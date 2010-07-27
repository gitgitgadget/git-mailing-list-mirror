From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Document ls-files -t as semi-obsolete.
Date: Tue, 27 Jul 2010 22:11:04 +0200
Message-ID: <vpqeieoy9bb.fsf@bauges.imag.fr>
References: <1280162391-18701-1-git-send-email-Matthieu.Moy@imag.fr>
	<20100727195832.GA11717@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 27 22:14:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdqXx-0005mS-Pu
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 22:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab0G0UOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 16:14:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42496 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab0G0UOg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 16:14:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6RK9LZl013866
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 22:09:21 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OdqUS-0001XM-Oy; Tue, 27 Jul 2010 22:11:04 +0200
In-Reply-To: <20100727195832.GA11717@coredump.intra.peff.net> (Jeff King's message of "Tue\, 27 Jul 2010 15\:58\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Jul 2010 22:09:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6RK9LZl013866
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280866163.82746@ke2rfPrWFVUe4VfHSKe6tQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151982>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 26, 2010 at 06:39:51PM +0200, Matthieu Moy wrote:
>
>> The behavior of "git ls-files -t" is very misleading (see
>> http://thread.gmane.org/gmane.comp.version-control.git/126516 and
>> http://thread.gmane.org/gmane.comp.version-control.git/144394/focus=144397
>> for examples of mislead users) and badly documented, hence we point the
>> users to superior alternatives.
>
> I agree with the goal, but one nit:
>
>>  -t::
>> +	This feature is semi-deprecated. For scripting purpose,
>> +	linkgit:git-status[1] `--porcelain` is almost always a
>> +	superior alternative, and users should look at
>> +	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
>> +	`--name-status` for more user-friendly alternatives.
>
> Isn't "git diff-files --name-status" the closest plumbing analogue? Git
> status actually does a lot of extra work.

git diff-files --name-status won't show untracked files, while "git
ls-files -t -o" will for example. I agree that "git status" does extra
work, but that's what you usually want when you want to know the
status of files. We already mention "git diff --name-status", so
people looking for "git diff-tree --name-status" should be able to
find it.

> Also, while testing this, I got confused. Does "ls-files -t" even work,
> or am I totally misunderstanding it? I tried:

Many people tried to understand what "ls-files -t" was supposed to do,
including myself, and I'm afraid nobody succeeded.

> Shouldn't one of them be marked "C"hanged (I think file2, but that was
> what I was double-checking)?

You should ask "git ls-files -t -m" if you want to see modified files.

I'm afraid we have another proof that we should discourage the use of
this feature ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
