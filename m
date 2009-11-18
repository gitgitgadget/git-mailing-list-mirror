From: "George Dennie" <gdennie@pospeople.com>
Subject: RE: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 13:51:56 -0500
Message-ID: <008401ca6880$33d7e550$9b87aff0$@com>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091118142512.1313744e@perceptron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: =?iso-8859-1?Q?'Jan_Kr=FCger'?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Wed Nov 18 19:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NApk7-0001ss-2a
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 19:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758292AbZKRS6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 13:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758276AbZKRS6b
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 13:58:31 -0500
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:22157 "HELO
	smtp103.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756141AbZKRS6a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 13:58:30 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2009 13:58:30 EST
Received: (qmail 243 invoked from network); 18 Nov 2009 18:51:56 -0000
Received: from CPE001cf04d66c9-CM0012c9a0913a.cpe.net.cable.rogers.com (gdennie@99.244.179.211 with login)
        by smtp103.rog.mail.re2.yahoo.com with SMTP; 18 Nov 2009 10:51:56 -0800 PST
X-Yahoo-SMTP: zge3jO.swBAK2Pj1ZBh8nVciRpiiK2CUUeAJch.zCNP5zAk-
X-YMail-OSG: _FlrOUoVM1mfpt7RzknF65THvjob32UO3J.DR0ooXYqoq87rOc0uzETq7obHLiV5rQ--
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <20091118142512.1313744e@perceptron>
X-Mailer: Microsoft Office Outlook 12.0
thread-index: AcpoWJY1jrlHJu/EQbSI9zYeCttJGwAEHRJg
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133195>

Thanks Jan, Jason, Jonathan, and Thomas for your response, your thoughts and
concerns are enlightening....

Jan Kruger wrote...
> git config --global alias.commitx '!git add . && git commit'
> git config --global alias.checkoutx '!git clean && git checkout'

Thank you. Being new to git, I did not know that such aliasing was available
within it.

Jason Sewell wrote...
> If you have a bunch of debugging code sitting around in your working tree
after you've tracked down a 
> problem, you don't want to commit all of those printfs, etc. - you want to
commit the fix. This has 
> ramifications from making diffs of history cleaner to making git bisect
actually useful.

One of the concerns I have with the manual pick-n-commit is that you can
forget a file or two. Consequently, unless you do a clean checkout and test
of the commit, you don't know that your publishable version even compiles.
It seems safer to commit the entirety of your work in its working state and
then do a clean checkout from a dedicated publishable branch and manually
merge the changes in that, test, and commit.

It seems the intuitive model is to treat version control as applying to the
whole document, not parts of it. In this respect the document is defined by
the IDE, namely the entire solution, warts and all. When you start
selectively saving parts of the document then you are doing two things,
versioning and publishing; and at the same time. This was a critical flaw in
older version control approaches because the software solution document is a
file system sub-tree.

What you termed the debugging/printf's I would treat as a distinctions
between a debug vs. a release version that may be suitably delineated by
#define's or preferably separate unit tests assemblies. If I must prune
prior to committing; however, then it seems reverting spurious printf's may
offer a more reliable and automatable technique than ensuring that I have
added all the new class files, resource files, text files, sub projects,
etc; that may constitute the "fix." Once so selectively reverted I can test
and commit such a publishable version.

Jason Sewell wrote...
>  Isn't fastidiously maintaining a .gitignore file to contain everything
you *don't* want in the project more confusing 
> than explicitly specifying things you *do* want in the project?

This is git ignore for "cleaning prior to a check" and git ignore for
"adding to index" and is not an either or. You would specify what you don't
want to version tracked as normal but you can also stipulate what you don't
want to be deleted during a clean restore (which should otherwise completely
wipe the folder prior to restoring a specific commit). This would permit
embedding non-version elements within the version tree for whatever reason
you find necessary.

Thomas Rast wrote...
> That would require supernaturally good maintenance of your .gitignore to
avoid adding or (worse) nuking files by accident.

On the contrary, the approach would all but eliminate the possibility of
loss of data since you would not manually (and therefore error prone-ingly)
pruning until after a commit. In fact, one might default automatic commits
(if required) prior to checkouts or at least an alert system when
uncommitted changes exists.

Thanks again for your input.
