From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/7] user-manual: add global config section
Date: Sat,  4 Apr 2009 12:38:28 +0300
Message-ID: <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 11:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq2N9-00020I-GT
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 11:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759307AbZDDJjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 05:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbZDDJjJ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 05:39:09 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:63046 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400AbZDDJiz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 05:38:55 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so1248807bwz.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gYEDhxG6rppeMYBGvp3quD1Y4+8y7Mjh0Ubn5BwwRlc=;
        b=sgJSSkBMYZAPoPNBwqarOoKE1zavgZIljS38XQaPpPkb1dqaonkEtZDsW/LlxvPv4p
         F5z6Z+EEdDi3Lc6BEDmGKPpzZQifpgNAg5LwWEqMY8FZ2VfBvke/WziQv3mH4BhXgQLZ
         not/ZFmrEVZxrPGEH2kRvsqstmMJAuGjO1TjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EfRmyrIzXQvJiMXZaXeUpC4u0B4UcqKwlgtqULmFYTMicKvKRxP3B5ofXMT2lMf49u
         uSoY1mR3wl3TL1REZKzv1PD1WMFyS+NesTLA/qGk8h6e6U+mQKY8OB58y3U4+WbrzCcc
         cKK5lUxpRYZaUZ/wDmEbScavMno5Msk909vHs=
Received: by 10.204.52.197 with SMTP id j5mr756092bkg.157.1238837933510;
        Sat, 04 Apr 2009 02:38:53 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id p17sm1296241fka.10.2009.04.04.02.38.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 02:38:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3
In-Reply-To: <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115579>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3278aa7..a3032c7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -40,6 +40,36 @@ without any explanation.
 Finally, see <<todo>> for ways that you can help make this manual more
 complete.
 
+[[getting-started]]
+Getting started
+=============
+
+Git's configuration is distributed among different locations--this manual will
+only to deal with 'global' and 'repository' variables, where 'repository'
+variables take precedence over 'global' ones.
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
+View and manually modify the configuration with the `--edit`
+option (which will use '$EDITOR'):
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
1.6.2.2.404.ge96f3
