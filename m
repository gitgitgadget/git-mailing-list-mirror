From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to update a cloned git repository
Date: Tue, 11 Sep 2012 13:21:57 +0200
Message-ID: <vpqy5kgdctm.fsf@bauges.imag.fr>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr>
	<006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 11 13:22:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBOXm-0007rB-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 13:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758918Ab2IKLWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 07:22:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46328 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757924Ab2IKLWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 07:22:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q8BBGunJ013516
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Sep 2012 13:16:56 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBOXW-0007eb-35; Tue, 11 Sep 2012 13:21:58 +0200
In-Reply-To: <006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de> (Joachim
	Schmitz's message of "Tue, 11 Sep 2012 13:17:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 11 Sep 2012 13:16:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8BBGunJ013516
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347967017.93002@p4m6OMuNdMlyB2ztci1p8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205220>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> From: Matthieu Moy [mailto:Matthieu.Moy@grenoble-inp.fr]
>>
>> Short answer: don't work on pu. Work on master unless you have a good
>> reason not to.
>
> There are some changes in pu, that I need as the basis, namely my
> setitimer patch and my 2nd mkdir patch, which haven't yet made it into
> the master branch (and in the setitimer case not out of pu)

Then, work on the tip of the topic branch you depend on instead of pu.
These are more stable, as they will be rewritten only if this particular
topic branch changes.

>>   git rebase HEAD~42 --onto origin/master
>
> For pu this would be similar?

Yes. If you insist in working on top of pu, you can rebase --onto
origin/pu.

> Like this?
> git pull --rebase HEAD~42

That would be "git fetch" and then "git rebase", as I don't think "git
pull --rebase" would allow you to specify the starting point for rebase.

> So far I create patches, wiped out the entire repository, cloned,
> forked and applied the changes, pretty painful.

This is conceptually similar to what "git rebase" does, but it does it
in a slightly more efficient way ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
