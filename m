From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 11/13] tag.c: use 'ref-filter' APIs
Date: Wed, 02 Sep 2015 18:13:33 +0200
Message-ID: <vpq37ywol3m.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-12-git-send-email-Karthik.188@gmail.com>
	<xmqq8u8oq2lq.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQXgVXSB9FqhXnc5npOrW8HVj97i0XhNeM-k-MJHR_xfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 18:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXAfQ-0007lz-Bl
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 18:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443AbbIBQNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 12:13:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55591 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbbIBQNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 12:13:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t82GDV5R026383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Sep 2015 18:13:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t82GDX4f029691;
	Wed, 2 Sep 2015 18:13:33 +0200
In-Reply-To: <CAOLa=ZQXgVXSB9FqhXnc5npOrW8HVj97i0XhNeM-k-MJHR_xfw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 2 Sep 2015 21:10:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Sep 2015 18:13:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t82GDV5R026383
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441815213.71858@PiCfrq7MJbJm6wQAuZaLAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277105>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Sep 2, 2015 at 8:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> +     if (filter->lines)
>>> +             format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
>>> +                                        filter->lines);
>>
>> I recall hearing that you were more in favor of
>>
>>         "%(align:16)%(refname:short) %(end)%(contents:lines=4)"
>>
>> somewhere in the earlier discussions?
>
> I did, but Matthieu suggested that this would be better!
> Can't find a link to that.

It was off-list. I don't have strong preference. My argument was:

> -            format = "%(align:16,left)%(refname:short)%(end)";
> +            format = "%(align:16,left)%(refname:short) %(end)";

I actually found the other more readable, as it reads "display the
refname aligned on 15 columns, and then a space", while this one reads
as "append a space to the refname, then align the result", which is
equivalent but requires more effort to understand.

But it's not important, keep this version if you prefer it like this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
