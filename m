From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to update a cloned git repository
Date: Tue, 11 Sep 2012 14:40:47 +0200
Message-ID: <vpq4nn4d968.fsf@bauges.imag.fr>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr>
	<006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>
	<vpqy5kgdctm.fsf@bauges.imag.fr>
	<007001cd9016$8f980f80$aec82e80$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 11 14:41:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBPm0-0001qa-CM
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 14:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab2IKMkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 08:40:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45785 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898Ab2IKMkv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 08:40:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8BCaNqG032238
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Sep 2012 14:36:23 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBPln-0000rg-VO; Tue, 11 Sep 2012 14:40:48 +0200
In-Reply-To: <007001cd9016$8f980f80$aec82e80$@schmitz-digital.de> (Joachim
	Schmitz's message of "Tue, 11 Sep 2012 14:11:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Sep 2012 14:36:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8BCaNqG032238
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347971784.53555@xgjZphQPXwuqPbYSORnw1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205225>

[ Re-adding git@vger in Cc, I guess it was meant to be so ]

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> Then, work on the tip of the topic branch you depend on instead of pu.
>> These are more stable, as they will be rewritten only if this particular
>> topic branch changes.
>
> These are not available from git hub. Or are they? How?

I think they exist in some of the repos junio pushes to, but I don't
remember how/which one.

Anyway, you can easily get it from the commit that merges the branch
(it's the-merge-commit^1).

>> > Like this?
>> > git pull --rebase HEAD~42
>> 
>> That would be "git fetch" and then "git rebase", as I don't think "git
>> pull --rebase" would allow you to specify the starting point for rebase.
>
> OK, I'll try that next time then. Like this?
> 	git fetch;git rebase HEAD~42 --onto origin/pu

That should work, yes.

In general, when you have a somehow complex workflow, I recommand
fetch+(merge|rebase) over pull. It gives you more flexibility, and the
opportunity to check what you fetched before starting the merge.

>> > So far I create patches, wiped out the entire repository, cloned,
>> > forked and applied the changes, pretty painful.
>> 
>> This is conceptually similar to what "git rebase" does, but it does it
>> in a slightly more efficient way ;-).
>
> Indeed ;-)
>
>
>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
