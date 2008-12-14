From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] Documentation: Describe git-gui Tools menu configuration options.
Date: Sun, 14 Dec 2008 22:44:32 +0300
Organization: HOME
Message-ID: <200812142244.32438.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 14 20:46:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBwvR-00039q-SG
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 20:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbYLNTpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 14:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbYLNTpb
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 14:45:31 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:52542 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYLNTpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 14:45:30 -0500
Received: by bwz14 with SMTP id 14so964780bwz.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 11:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=+8g8sZHlfnoTzftM49QkQWXzV0ajHgnE1Byl/psTTS0=;
        b=Xn3n1weOyGRgGUcPXJRQoXcxUDiwtStCSy2ZsuyBZPoaoggZDswsqkrunt51RUYSw8
         s+BRirbicKxXoIHpazJYqBVDV+D8ovPIA1Ak3JLWSzasMFv6z/mrNjM9r174Kez1P5rn
         rK4gOGCVVLKzH0KTCfhAzSp7HoGutNDNdHplc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        b=g8pv/Tve7QiBQR9doKnfJH1gxGojEJH4kw6OLEZreiV4+1eRB5ST0yQjlWc+w4T4uw
         PPDbVB4A3hbXZF/mzOEjYBcTI771X1zDJ0fYTWSHpjgHJHZj7hB2LIUl1Szh94Y9z6Mv
         Ayi5VovFo3PVU9FTNWuM+vzjV0rOCQeXYWL+0=
Received: by 10.223.116.10 with SMTP id k10mr6040363faq.101.1229283928458;
        Sun, 14 Dec 2008 11:45:28 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id p17sm6581533fka.30.2008.12.14.11.45.27
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 11:45:27 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-123.fc10.i686; KDE/4.1.3; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103098>

Now git gui has a customizable Tools menu, so this adds
information about variables that are used to configure it.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 Documentation/config.txt |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b233fe5..2a06a3c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -839,6 +839,57 @@ gui.blamehistoryctx::
 	Context` menu item is invoked from 'git gui blame'. If this
 	variable is set to zero, the whole history is shown.
 
+guitool.<name>.cmd::
+	Specifies the shell command line to execute when the corresponding item
+	of the linkgit:git-gui[1] `Tools` menu is invoked. This option is
+	mandatory for every tool. The command is executed from the root of
+	the working directory, and in the environment it receives the name of
+	the tool as 'GIT_GUITOOL', the name of the currently selected file as
+	'FILENAME', and the name of the current branch as 'CUR_BRANCH' (if
+	the head is detached, 'CUR_BRANCH' is empty).
+
+guitool.<name>.needsfile::
+	Run the tool only if a diff is selected in the GUI. It guarantees
+	that 'FILENAME' is not empty.
+
+guitool.<name>.noconsole::
+	Run the command silently, without creating a window to display its
+	output.
+
+guitool.<name>.norescan::
+	Don't rescan the working directory for changes after the tool
+	finishes execution.
+
+guitool.<name>.confirm::
+	Show a confirmation dialog before actually running the tool.
+
+guitool.<name>.argprompt::
+	Request a string argument from the user, and pass it to the tool
+	through the 'ARGS' environment variable. Since requesting an
+	argument implies confirmation, the 'confirm' option has no effect
+	if this is enabled. If the option is set to 'true', 'yes', or '1',
+	the dialog uses a built-in generic prompt; otherwise the exact
+	value of the variable is used.
+
+guitool.<name>.revprompt::
+	Request a single valid revision from the user, and set the
+	'REVISION' environment variable. In other aspects this option
+	is similar to 'argprompt', and can be used together with it.
+
+guitool.<name>.revunmerged::
+	Show only unmerged branches in the 'revprompt' subdialog.
+	This is useful for tools similar to merge or rebase, but not
+	for things like checkout or reset.
+
+guitool.<name>.title::
+	Specifies the title to use for the prompt dialog. The default
+	is the tool name.
+
+guitool.<name>.prompt::
+	Specifies the general prompt string to display at the top of
+	the dialog, before subsections for 'argprompt' and 'revprompt'.
+	The default value includes the actual command.
+
 help.browser::
 	Specify the browser that will be used to display help in the
 	'web' format. See linkgit:git-help[1].
-- 
1.6.0.4.30.gf4240
