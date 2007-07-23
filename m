From: Steffen Prohaska <prohaska@zib.de>
Subject: What is a reasonable mixed workflow for git/git-cvsserver?
Date: Mon, 23 Jul 2007 08:28:17 +0200
Message-ID: <E8B0B250-A428-4CDC-A4D2-FFCF45953076@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:27:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICrOD-0000Tn-OI
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 08:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757389AbXGWG1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 02:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757587AbXGWG1Y
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 02:27:24 -0400
Received: from mailer.zib.de ([130.73.108.11]:47418 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757052AbXGWG1X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 02:27:23 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6N6RLbK026702
	for <git@vger.kernel.org>; Mon, 23 Jul 2007 08:27:21 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db11e8b.pool.einsundeins.de [77.177.30.139])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6N6RKSh011832
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 23 Jul 2007 08:27:21 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53395>

I plan to migrate a project from cvs to git and provide
legacy support for cvs users through git-cvsserver. It's
not realistic to teach all people at the same time to use
git. We need some early adopters first. It is also likely
that we start migrating only parts of the repository and
keep some other parts in cvs. I plan to start with parts
for which the benefits of git's support for merging are
most obvious.

What's a reasonable workflow when some people use git and
other people use git-cvsserver simultaneously?

I can imaging that we try the typical git model with
developers who are using git. Developers would clone to
private repositories and ask upstream maintainers to merge.

I'm wondering how to integrate people that will not yet use
git but checkout and commit through git-cvsserver?

We could easily arrange a stable branch for cvs access that
should be accessed read-only. Work merged using git would
be published to this branch. I can also think of specific
topic branches that are created upon request by a git
expert and accessed from cvs through git-cvsserver. Merging
could be done by a git expert using git. An inconvenience
is that people must do a fresh checkout to switch to a
topic branch but can not use 'cvs up -r'. At least this is
my understanding of git-cvsserver's documentation.

I have no clear idea how to deal with the shared rest. We
typically share work in an unsorted way on a cvs branch,
which everyone commits to. I think we'll need a similar
possibility, at least for a transition period. We could
create such a shared branch for access from git-cvsserver.

What is a reasonable way to handle the unsorted commits
from a shared branch in a more git-ish way? I googled a bit
but didn't find a good explanation on the web.

Any ideas, any real-world experiences?

	Steffen
