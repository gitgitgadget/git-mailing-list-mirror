From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-clone -s: document problems with git gc --prune
Date: Tue, 22 Jan 2008 22:03:05 +0100
Message-ID: <20080122210305.GM4475@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 22:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHQHq-00008M-Hz
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 22:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbYAVVDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 16:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbYAVVDY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 16:03:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54844 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbYAVVDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 16:03:23 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JHQH3-0006KY-Ju
	from <vmiklos@frugalware.org>; Tue, 22 Jan 2008 22:03:22 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4D0D2119019C; Tue, 22 Jan 2008 22:03:05 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0038]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71469>

There is a scenario when using git clone -s and git gc --prune togother is
dangerous. Document this.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I see people on #git regularly who do not know about this option can cause
problems, so I think it's important to document this.

 Documentation/git-clone.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index fdccbd4..5c4d936 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -62,6 +62,12 @@ OPTIONS
 	.git/objects/info/alternates to share the objects
 	with the source repository.  The resulting repository
 	starts out without any object of its own.
+	*NOTE*: this is a possibly dangerous operation; do *not* use
+	it unless you understand what it does. If you clone your
+	repository using this option, you delete branches in the
+	source repository and you run linkgit:git-gc[1] using the
+	`--prune` option, then it will remove objects which are
+	referenced ones in the target repository!
 
 --reference <repository>::
 	If the reference repository is on the local machine
-- 
1.5.4.rc3.4.g16335-dirty
