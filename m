From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: [PATCH resend] Documentation: git-svn: fix example for centralized
 SVN clone
Date: Fri, 14 Nov 2008 18:45:14 +0100
Message-ID: <20081114184514.6f7d437a@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 18:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L12kq-0007pb-Dn
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 18:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYKNRpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 12:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYKNRpc
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 12:45:32 -0500
Received: from zoidberg.org ([213.133.99.5]:59979 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbYKNRpb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 12:45:31 -0500
Received: from perceptron (xdsl-87-79-252-221.netcologne.de [::ffff:87.79.252.221])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Fri, 14 Nov 2008 18:45:28 +0100
  id 00165FAE.491DB939.00002F48
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100991>

The example that tells users how to centralize the effort of the initia=
l
git svn clone operation doesn't work properly. It uses rebase but that
only works if HEAD exists. This adds one extra command to create a
somewhat sensible HEAD that should work in all cases.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
When I first sent this one I said I didn't like the solution all that
much (it would be nicer to use origin/HEAD but we didn't fetch that)
but Eric said he thinks it's okay and the original author of the
section hasn't piped in. It's still better than a nonfunctional example
in any case.

Previous discussion at
<http://thread.gmane.org/gmane.comp.version-control.git/100472>.

 Documentation/git-svn.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 84c8f3c..ba94cd1 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -544,6 +544,8 @@ have each person clone that repository with 'git-cl=
one':
 	git remote add origin server:/pub/project
 	git config --add remote.origin.fetch '+refs/remotes/*:refs/remotes/*'
 	git fetch
+# Create a local branch from one of the branches just fetched
+	git checkout -b master FETCH_HEAD
 # Initialize git-svn locally (be sure to use the same URL and -T/-b/-t=
 options as were used on server)
 	git svn init http://svn.example.com/project
 # Pull the latest changes from Subversion
--=20
1.6.0.3.578.g6a50
