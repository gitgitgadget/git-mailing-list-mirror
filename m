From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: noob question
Date: Fri, 14 Jan 2011 12:10:25 +0100
Message-ID: <201101141210.25523.trast@student.ethz.ch>
References: <AANLkTinU---Bw5nWFXr7psSyZEty=awihPrDGqNX916O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Harry Johnson <hjohnson@viasic.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 12:10:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdhYI-00020e-SJ
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 12:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab1ANLK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 06:10:29 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:30126 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab1ANLK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 06:10:28 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 14 Jan
 2011 12:10:17 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 14 Jan
 2011 12:10:26 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <AANLkTinU---Bw5nWFXr7psSyZEty=awihPrDGqNX916O@mail.gmail.com>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165092>

Harry Johnson wrote:
> 
> I have used git-svn to create a git repo from our subversion repo. I
> have done this as user foo which is just an account that is used for
> doing central builds. I have then cloned this as repo as myself,
> harry. My thought is that the repo owned by foo would be a central
> repo that all of the developers, including myself, could clone and to
> which  we could then 'git push' our changes.
[...]
> when checking the git log is that while the changes I made and checked
> into my repo clearly showed me as the author, the same changes after
> being pushed to foo's repo showed a different author.
> 
> So two things.. First should the author have been preserved? How can I
> make sure that it is?

Yes, absolutely, and since the author is encoded in the commit objects
it's impossible to change it without also changing the commit sha1s.

Can you spell your experiments in actual commands and output snippets
so we can see what happened?

Did you ever run 'git svn dcommit', 'git rebase', 'git commit --amend'
or similar in foo's repo?  All of these rewrite commits.  As part of
their rewriting they set the *committer* to the identity of the
current user.  'git svn dcommit' sets author&committer to the identity
coming back from SVN.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
