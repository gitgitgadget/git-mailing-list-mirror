From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Mon, 24 Aug 2015 17:16:30 +0200
Message-ID: <vpqvbc490oh.fsf@anie.imag.fr>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<vpqzj1hkc5q.fsf@anie.imag.fr>
	<CAOLa=ZQx_eWdq5cLskAT_c1OjZ-7DwWwZTC9S=ZafEDYHFGncg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 17:16:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTtUG-0004pz-8k
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 17:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbbHXPQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 11:16:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41606 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614AbbHXPQf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 11:16:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7OFGSdC011923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 24 Aug 2015 17:16:28 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7OFGU4U032402;
	Mon, 24 Aug 2015 17:16:30 +0200
In-Reply-To: <CAOLa=ZQx_eWdq5cLskAT_c1OjZ-7DwWwZTC9S=ZafEDYHFGncg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 24 Aug 2015 20:39:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 24 Aug 2015 17:16:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7OFGSdC011923
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441034189.17561@ZvcMJI6O5SRoBQCf0Cde6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276453>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Aug 24, 2015 at 1:30 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>>> index 1997657..06d468e 100644
>>> --- a/Documentation/git-for-each-ref.txt
>>> +++ b/Documentation/git-for-each-ref.txt
>>> @@ -133,7 +133,8 @@ align::
>>>       `<position>` is either left, right or middle and `<width>` is
>>>       the total length of the content with alignment. If the
>>>       contents length is more than the width then no alignment is
>>> -     performed.
>>> +     performed. If used with '--quote' everything in between %(align:..)
>>> +     and %(end) is quoted.
>>
>> There's no --quote, there are --shell, --python, ... (well, actually, I
>> would have prefered to have a single --quote=language option, but that's
>> not how it is now).
>
> That'd be easy to implement, but I didn't because `git tag -l` is
> human readable and
> I didn't see the necessity for having something like `--<quote_type>` here.

Agreed: tag does not have --shell, --python & so and does not need it.

But that's not my point: you write "if used with '--quote'", and the
option name is not --quote. It should be "if used with `--shell`,
`--python`, ... then everything ...".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
