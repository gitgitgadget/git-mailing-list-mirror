From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 21:40:21 +0200
Message-ID: <vpqbp0v2fve.fsf@bauges.imag.fr>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
	<AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
	<4D909DD1.2050904@viscovery.net>
	<AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
	<vpq62r3i1z4.fsf@bauges.imag.fr>
	<AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>
	<vpqr59r6sg5.fsf@bauges.imag.fr>
	<AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>
	<vpqvcz35cjk.fsf@bauges.imag.fr>
	<AANLkTikADLZvN0N==_H47O1vcrap1_Mcf7vW69d5sh0d@mail.gmail.com>
	<AANLkTimR5XfOV-0RZjdyu72E9JdBfr1B+wc=q55V4qH5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: demerphq <demerphq@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:43:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ILd-0007oc-V0
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 21:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab1C1Tn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 15:43:29 -0400
Received: from imag.imag.fr ([129.88.30.1]:41553 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab1C1Tn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 15:43:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p2SJeMtR008532
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Mar 2011 21:40:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q4IIY-0003PA-6e; Mon, 28 Mar 2011 21:40:22 +0200
In-Reply-To: <AANLkTimR5XfOV-0RZjdyu72E9JdBfr1B+wc=q55V4qH5@mail.gmail.com>
	(Andrew Garber's message of "Mon, 28 Mar 2011 15:12:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 28 Mar 2011 21:40:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170180>

Andrew Garber <andrew@andrewgarber.com> writes:

>>> What is the point is finding manually a commit *on the same branch* when
>>> the tool can do that for you?
>
>> Seems to me that this is trying to cram two questions into one:
>>
>> A) where did branch foo diverge from branch bar and
>> B) which commit between that ancestor and bar did things break.

No. What I'm saying is that if you insist in not using bisect, you'll
probably have to answer these two questions separately.

> To find the answer to A, I generally just do this (using an alias):
>
> git log --graph --oneline --all
>
> It takes at most a couple of seconds... hardly what I'd call a manual
> process.

Suppose you have a bug in git.git that you see in pu, but not in next.
Try finding the common ancestor with your command, and see how long it
takes.

Yes, you'll be able to do it, but you still didn't tell us what was
wrong with

git bisect start
git bisect good origin/next
git bisect bad origin/pu
...

which is _way_ faster. And my example took git.git which isn't a very
large project, so real-life examples could be much worse.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
