From: Ville =?iso-8859-1?q?Skytt=E4?= <ville.skytta@iki.fi>
Subject: [PATCH] Abort early if not being sourced under bash.
Date: Fri, 8 Feb 2008 23:10:34 +0200
Message-ID: <200802082310.34398.ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNaVF-0000Zz-HD
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 22:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274AbYBHVKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 16:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbYBHVKi
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 16:10:38 -0500
Received: from smtp4.pp.htv.fi ([213.243.153.38]:34527 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758096AbYBHVKf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2008 16:10:35 -0500
Received: from viper.bobcat.mine.nu (cs181043142.pp.htv.fi [82.181.43.142])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 0BEBC5BC01D;
	Fri,  8 Feb 2008 23:10:34 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071204.744707)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73145>

Subject: [PATCH] Abort early if not being sourced under bash.

This way, the file can be safely sourced from profile files shared with
non-bash shells, eg. dropped into /etc/profile.d like directories.

Signed-off-by: Ville Skytt=E4 <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 4ea727b..3cde9f4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -45,6 +45,8 @@
 #       git@vger.kernel.org
 #
=20
+[ -z "$BASH_VERSION" ] && return
+
 __gitdir ()
 {
 	if [ -z "$1" ]; then
--=20
1.5.3.8
