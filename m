From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 09:54:46 +0200
Message-ID: <vpq63horepl.fsf@bauges.imag.fr>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	<49CCE72E.20081.258EE61F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	<m3fxgz2h2n.fsf@localhost.localdomain>
	<49D32CE5.21780.391D18@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 10:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LovcK-00081D-68
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 10:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761883AbZDAIOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 04:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761845AbZDAIOV
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 04:14:21 -0400
Received: from imag.imag.fr ([129.88.30.1]:64387 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761757AbZDAIOO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 04:14:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3187FXJ026194
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Apr 2009 10:07:15 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LovHb-000744-0Y; Wed, 01 Apr 2009 09:54:47 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LovHa-00079f-UZ; Wed, 01 Apr 2009 09:54:46 +0200
In-Reply-To: <49D32CE5.21780.391D18@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Wed\, 01 Apr 2009 08\:59\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115352>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

>> Not to mention that you can have multiple roots (multiple commits with
>> no parent) in git repository; besides independent branches (like
>> 'man', 'html' or 'todo') it is usually result of absorbing or
>> subtree-merging other projects.  In 'master' branch there are 5 roots
>> or more: joined 'git-tools' (mailinfo / mailsplit), absorbed gitweb,
>> and subtree-merged gitk and git-gui.  And here you would again have
>> multiple commits with the same number...
>
> Which would not harm, because it would be version N from committer X. Any if 
> committer X merges from anything else, the next number would be > N. I did not 
> claim that my method makes a total ordering of commits and merges possible.

Neither does it make the numbers unique for committer X.

If commiter X commits a successor to commit N, it's labeled N+1. If
later, he creates another branch from commit N, and commit, the new,
other commit will be labeled N+1.

This means even within a repository, you cannot say things like
"commit number N", so, OK, you have numerical IDs, but you can't use
them.

What can be interesting is that a commit takes 
max{all commits in repository}+1, not just max{parents} + 1. Then, you
have local revision numbers, but they're not stable. Indeed, that's
precisely what Mercurial does.

But I'm not sure how much simplicity it adds compared to the confusion
it adds. Newbies will see Mercurial identifiers as

changeset:   2:699b81a5851b
changeset:   1:fd4b6597548f
changeset:   0:58cff172192e

And think "OK, the revision numbers are 0, 1, 2, and the hexadecimal
stuff beside is useless". And one day, he'll send a mail, post a
bugreport, or whatever, saying "I have a problem with revision number
42", and no one else but him will know which revision is called "42".

> I truly believe in unique IDs, but they are just not handy in every situation.

Usually, people find Git IDs to be non-handy until the find out they
can cut-and-paste only the first few digits in most cases, like
442dd42 instead of 442dd42d6d4903640b0dc5561481a77c88dcea90 ;-).

-- 
Matthieu
