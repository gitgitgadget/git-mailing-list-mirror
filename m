From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v13 11/12] tag.c: implement '--format' option
Date: Mon, 24 Aug 2015 17:14:21 +0200
Message-ID: <vpq37z8afci.fsf@anie.imag.fr>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<1440214788-1309-12-git-send-email-Karthik.188@gmail.com>
	<vpq37z9lqwp.fsf@anie.imag.fr>
	<CAOLa=ZR4LJSou5QqmZJm1M49tD74t4Besb64F+XOHefjnxo7xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 17:14:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTtSE-0003Iv-5v
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 17:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbbHXPO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 11:14:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59729 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbbHXPO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 11:14:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7OFEKCX012198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 24 Aug 2015 17:14:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7OFEL9M032367;
	Mon, 24 Aug 2015 17:14:21 +0200
In-Reply-To: <CAOLa=ZR4LJSou5QqmZJm1M49tD74t4Besb64F+XOHefjnxo7xw@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 24 Aug 2015 20:37:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Aug 2015 17:14:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7OFEKCX012198
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441034062.34707@p/fguOua6EPut1wMAmAGHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276452>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Aug 24, 2015 at 1:26 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> --- a/Documentation/git-tag.txt
>>> +++ b/Documentation/git-tag.txt
>>> @@ -13,7 +13,8 @@ SYNOPSIS
>>>       <tagname> [<commit> | <object>]
>>>  'git tag' -d <tagname>...
>>>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>>> -     [--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>] [<pattern>...]
>>> +     [--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
>>> +     [--format=<format>] [<pattern>...]
>>>  'git tag' -v <tagname>...
>>>
>>>  DESCRIPTION
>>> @@ -158,6 +159,11 @@ This option is only applicable when listing tags without annotation lines.
>>>       The object that the new tag will refer to, usually a commit.
>>>       Defaults to HEAD.
>>>
>>> +<format>::
>>
>> Shouldn't this be --format <format>, not just <format>? We usually use
>> the named argument in the SYNOPSIS for positional arguments, but not for
>> arguments following an option.
>
> This is how it was in for-each-ref Documentation, hence to keep it similar I
> just put <format>.

"It's wrong in another place" sounds like an argument to fix the other
place, not to get it wrong here too ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
