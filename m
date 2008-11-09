From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: [PATCH] Documentation: git-svn: fix example for centralized SVN
 clone
Date: Sun, 9 Nov 2008 23:00:12 +0100
Message-ID: <20081109230012.47adbb32@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 23:01:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzILi-0001YY-3G
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 23:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255AbYKIWAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2008 17:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756186AbYKIWAU
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 17:00:20 -0500
Received: from zoidberg.org ([213.133.99.5]:60928 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755932AbYKIWAT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2008 17:00:19 -0500
Received: from perceptron (xdsl-87-78-94-105.netcologne.de [::ffff:87.78.94.105])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sun, 09 Nov 2008 23:00:17 +0100
  id 0015AFFF.49175D71.00006598
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100472>

The example that tells users how to centralize the effort of the initia=
l
git svn clone operation doesn't work properly. It uses rebase but that
only works if HEAD exists. This adds one extra command to create a
somewhat sensible HEAD that should work in all cases.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
I have a feeling this looks a bit ugly, but I can't think of a simpler
solution (especially since we're not fetching the central repo's HEAD).
Still, it's certainly better than a broken example.

 Documentation/git-svn.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 84c8f3c..ba94cd1 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -544,6 +544,8 @@ have each person clone that repository with 'git-cl=
one':
        git remote add origin server:/pub/project
        git config --add remote.origin.fetch '+refs/remotes/*:refs/remo=
tes/*'
        git fetch
+# Create a local branch from one of the branches just fetched
+       git checkout -b master FETCH_HEAD
 # Initialize git-svn locally (be sure to use the same URL and -T/-b/-t=
 options as were used on server)
        git svn init http://svn.example.com/project
 # Pull the latest changes from Subversion
--
1.6.0.3.578.g6a50
