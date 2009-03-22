From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 7/8] user-manual: add global config section
Date: Sun, 22 Mar 2009 20:05:20 +0200
Message-ID: <1237745121-6325-8-git-send-email-felipe.contreras@gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:08:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlS5h-0000xY-Cs
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 19:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbZCVSGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 14:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbZCVSF7
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 14:05:59 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:40481 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447AbZCVSFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 14:05:54 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so1470067bwz.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qgmxhO3vUsbgWUOCKHSUDr7zyNcxpNlKco/0b+T97QE=;
        b=q9XR54tzkRRDxqs5RfYtR1wSwfqV7IoIed5uS1TwrjpxdvaCdOMKKu339HNtsaDzNP
         T4yRfn36yR7sc4VvkoV+K4IK+WDkiy9z/+iNU/EWdTxi1RyFrVsk8C1K3U30wG4CU5rx
         TmrUm7vmQtI9VPJtf55i2hA5leMDVlLjkXIeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FtsGQiyaojnZ/8jIfOqKcI3AMjaRcwFq4JJLY6iv9acId4on870QITiyMHgESu80+A
         HdEk+sG4RbuPVmoqS0NnJ9I+LG3wMmuIL3TwqK2yQRsefBeQCRwMFjja7Nz2JdoYAkuE
         hvXMY9OG0EVQd0EaGLJ5XMHHmup1g0h5Yg8Ys=
Received: by 10.223.122.70 with SMTP id k6mr5262540far.26.1237745152275;
        Sun, 22 Mar 2009 11:05:52 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 13sm7456374fks.27.2009.03.22.11.05.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 11:05:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.352.gae594
In-Reply-To: <1237745121-6325-7-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114163>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3278aa7..b7678aa 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -40,6 +40,40 @@ without any explanation.
 Finally, see <<todo>> for ways that you can help make this manual more
 complete.
 
+[[getting-started]]
+Getting started
+=============
+
+You can skip this section safely, however, configuring git at an early stage
+would probably make your overall experience with it more pleasant. Also many
+parts on this manual would be easier to grasp.
+
+Git's configuration is distributed on different locations: 'system', 'global', and
+'repository'. Variables are stored in the form of 'foo.bar', and the precedence
+order is 'repository' > 'global' > 'system'.
+
+You would probably want to start setting up something useful:
+------------------------------------------------
+$ git config --global color.ui auto
+------------------------------------------------
+
+This will make prettier the output of certain commands such as `git diff`, but
+that's not important; what is important here is that `color.ui` has been
+stored in the 'global' (for the user) configuration.
+
+You can take a look and manually modify the configuration with the `--edit`
+option (will use '$EDITOR'):
+------------------------------------------------
+$ git config --global --edit
+[color]
+        ui = auto
+------------------------------------------------
+
+Or you can manually edit the file which is located in `~/.gitconfig`. Other
+locations are `/etc/gitconfig` (system), and `.git/config` (repository).
+
+Other git configurations will be covered in the rest of the manual, if you
+want to learn more look at linkgit:git-config[1] for details.
 
 [[repositories-and-branches]]
 Repositories and Branches
-- 
1.6.2.1.352.gae594
