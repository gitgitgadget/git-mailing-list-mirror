From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/25] completion: support git-worktree
Date: Wed, 13 Apr 2016 20:15:29 +0700
Message-ID: <1460553346-12985-9-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKeq-0004BJ-Om
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760635AbcDMNQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:32 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33945 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760158AbcDMNQb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:31 -0400
Received: by mail-pa0-f66.google.com with SMTP id hb4so3924894pac.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npj2geCpjA6ATzGInA+wdKHnD/DCGgkkgeTWUiVZi70=;
        b=GnQ3lfluD95sfa/OJ5X5pZ0gLFGUwPoTIBf9E/oDOJfM2Dt7wlFVlyIaMwOVgrTr+d
         7qeymbF509FOwTrZtLF0xL2lXNbDuksIpoMuZ7ctbZqFtXd9+nQwW95tyzOSQQ1Id0Fg
         8bECX2f/1t1BC26rUNLoexGcqmm8AFP169wEYyPnH8B8h/s/QK6rh7oUPmVMvyJ3pmcw
         GFc1360QLDsStv1kFC9vhxWshYE1NNWcrhDvceM3HR12DOGXNL1c0LvT6v+n029+ce2B
         UIItSLvilGenu2tF1043CaPe/QkT8e+i8JVomyzZhysc07hoOHn9zLgLZHwgBGd4LAne
         uY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npj2geCpjA6ATzGInA+wdKHnD/DCGgkkgeTWUiVZi70=;
        b=j5LP2G35AXMEd+UWAtBGQ5w6knL2t2YC+fnFhEM15XBIc/Mahddt/UCCIaBzQ8V66/
         IESAoaJ9zC2JTyL/9jB77G9j4Dwmr1Le4qCteUzMWZs//bu+lSrqnhfoSbRHRJS92/xF
         nInQzRjZi+6I6xmwmN0hEcTgs0NTHe5t9bsCJSZZo6aBuL3rDoz0VgmF/j2G40dxlB90
         2E0lfjb4gg+nQxWSpaL5fWZ/bgUnZGrTp5xxRV0KX49zGT0SZ1M1ehcbhmI9zO2xTbaR
         zaXnp4WcAyl9z2/E2cnaTbwn3DjgRVnL1gSDmWDtAUtzMchoULXtZk9L01MJ6MNW61qw
         E91w==
X-Gm-Message-State: AOPr4FVTYdED3wO+2KcQ00ELRnufTk8Hyn0+sTARnUh7Ucgon0qgQGMX7sbEgsjbXl+t4w==
X-Received: by 10.66.66.108 with SMTP id e12mr12854815pat.92.1460553390630;
        Wed, 13 Apr 2016 06:16:30 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id 62sm51153162pfk.83.2016.04.13.06.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:36 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291428>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 contrib/completion/git-completion.bash | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e3918c8..f66db2d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2594,6 +2594,29 @@ _git_whatchanged ()
 	_git_log
 }
=20
+_git_worktree ()
+{
+	local subcommands=3D"add list prune"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+	else
+		case "$subcommand,$cur" in
+		add,--*)
+			__gitcomp "--detach --force"
+			;;
+		list,--*)
+			__gitcomp "--porcelain"
+			;;
+		prune,--*)
+			__gitcomp "--dry-run --expire --verbose"
+			;;
+		*)
+			;;
+		esac
+	fi
+}
+
 __git_main ()
 {
 	local i c=3D1 command __git_dir
--=20
2.8.0.rc0.210.gd302cd2
