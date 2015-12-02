From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] git-worktree.txt: mention about the config file split
Date: Wed,  2 Dec 2015 20:13:46 +0100
Message-ID: <1449083626-20075-6-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:14:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Cr6-0003VY-MP
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbbLBTON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 14:14:13 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36693 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932376AbbLBTOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:14:12 -0500
Received: by wmww144 with SMTP id w144so228389751wmw.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yiqOo2rOQse/+oUjloD0XIiTdoXUiHMt9mjmXbxrunA=;
        b=Rz1+kgtJH9LpzgKD2P6BrK5PwenKg4exIOG545P6WSdIXnbk1TEv4ctkjYO2AkjTiA
         i+ZhoBjE7NAOHYCIhQ56ogM1f7HCg3BWwvsuD3IEqM8PFVTNGYlstgnWoxeAychN7qUe
         Bzx/rbe9xuuUM9jdEtMbKfqI2a5qkG0ZpObXfHATZKOv9auqOMNVVJ/f4fD67tQfvQd3
         yFMMEobdgeJA3SoGzgzqsLbv1mQPLLC1rbq6lu9J/77i/B6/CfHiXOXbJdX+wnP3/COn
         wQoXFUlLCQADgq8F3Vo2Cx3bvQGDFs6TAy4V0/xbMhi8GN4pAUQ4Syx5N1NSWcSzQk93
         XgIQ==
X-Received: by 10.28.141.140 with SMTP id p134mr47097522wmd.6.1449083651176;
        Wed, 02 Dec 2015 11:14:11 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id uz5sm4090822wjc.8.2015.12.02.11.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2015 11:14:09 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281903>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 5b9ad04..299e4f2 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -147,6 +147,19 @@ to `/path/main/.git/worktrees/test-next` then a fi=
le named
 `test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
=20
+Similar to the file system split in ".git", the repository config file
+is also split. Certain variables, for example core.worktree, are
+per-worktree while the majority of variables are still shared (see
+linkgit:git-config[1] for details). Shared variables and per-working
+tree ones that belong to the main working tree are in .git/config.
+Per-working tree variables for working tree X are in
+$GIT_COMMON_DIR/worktrees/X/config.worktree. Even though per-working
+tree variables for the main working tree are in the default config
+place, they are invisible from all linked working trees.  You can make
+more config variables per-working tree by adding them in
+.git/info/config.worktree (see linkgit:gitrepository-layout[5] for
+details).
+
 LIST OUTPUT FORMAT
 ------------------
 The worktree list command has two output formats.  The default format =
shows the
--=20
2.2.0.513.g477eb31
