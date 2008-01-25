From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git pull manpage: don't include -n from fetch-options.txt
Date: Fri, 25 Jan 2008 10:17:38 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801251016170.5731@racer.site>
References: <72481CA3A5A6474EA49CFD2CF28A5D5D02CA348A@hektor.iplbath.com> <alpine.LSU.1.00.0801241058330.5731@racer.site> <20080124232418.GC4475@genesis.frugalware.org> <7vfxwm8z4u.fsf@gitster.siamese.dyndns.org>
 <20080125092839.GF4475@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JILde-0008GT-3T
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 11:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760121AbYAYKRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 05:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760174AbYAYKRw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 05:17:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:51529 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760107AbYAYKRu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 05:17:50 -0500
Received: (qmail invoked by alias); 25 Jan 2008 10:17:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp013) with SMTP; 25 Jan 2008 11:17:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/omatNUE3oKazJ0vkCGmfAhpn56YPtWx8+7MKqm5
	u2rdx5ynQcSA4I
X-X-Sender: gene099@racer.site
In-Reply-To: <20080125092839.GF4475@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71696>

From: Miklos Vajna <vmiklos@frugalware.org>

The -n option stands for --no-summary in git pull

[jes: reworded the description to avoid mentioning 'git-fetch';
 also exclude '-n' conditional on git-pull -- ugly because of
 the missing "else" statement in asciidoc]

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 25 Jan 2008, Miklos Vajna wrote:

	> On Thu, Jan 24, 2008 at 05:36:33PM -0800, Junio C Hamano 
	> <gitster@pobox.com> wrote:
	>
	> > > The -n option stands for --no-summary in git pull
	> >
	> > Ok, but does that mean --no-tags does not exist there?
	> 
	> Oops, my bad. Here is an updated patch to just remove '-n' and 
	> keep '--no-tags'.

	How about this instead?

 Documentation/fetch-options.txt |   12 ++++++++----
 Documentation/git-pull.txt      |    1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 61e48cc..b675911 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -23,11 +23,15 @@
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
+ifdef::git-pull[]
+\--no-tags::
+endif::git-pull[]
+ifndef::git-pull[]
 -n, \--no-tags::
-	By default, `git-fetch` fetches tags that point at
-	objects that are downloaded from the remote repository
-	and stores them locally.  This option disables this
-	automatic tag following.
+endif::git-pull[]
+	By default, tags that point at objects that are downloaded
+	from the remote repository are fetched and stored locally.
+	This option disables this automatic tag following.
 
 -t, \--tags::
 	Most of the tags are fetched automatically as branch
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 77fdaf1..f9f1e0d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -25,6 +25,7 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
+:git-pull: 1
 include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
-- 
1.5.4.rc4.36.g6e122
