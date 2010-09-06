From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/15] gettextize: git-gc "Auto packing the repository" message
Date: Mon,  6 Sep 2010 12:21:36 +0000
Message-ID: <1283775704-29440-8-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:23:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osaiu-0000aR-8r
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817Ab0IFMWb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab0IFMW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:29 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so2884659wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9rwVpait2AT7hLh7miG2R6fZeuWs4qyH/ObJYS/EBPs=;
        b=s1k1tc2gibyKj3suDrwEt3c2h67gC2lNpHuRfxBEPmX1+0f6n8Nwp7t5equ4bXhPsi
         DJdnvsrUSv4qvu0WduVEpdpay3NYmgE0izdbQsNDqAqQQ7sKBu9WFEG/ki46a/x7/cVw
         KGOaLjeJP6rpEsEFhpwLYsecUCgdnEikQSOok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VlE9zmlSjdXCceV2jM1kN16PHo9ArbzohT4RkVc9mrBJyVrms4kdxZdn979kzVt3sA
         io3bu+IJAHQ4nafMiGQW1ZQPbPfM92WMN2mDXEVoviCGwRlS4anSeLUxN7FkqItR5h61
         /q8tsAxI+0vQen30h+Mz//LXSitGstdg4TIs4=
Received: by 10.227.137.15 with SMTP id u15mr1530321wbt.129.1283775748584;
        Mon, 06 Sep 2010 05:22:28 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155560>

Split up the "Auto packing the repository" message into quiet and
verbose variants to make translation easier.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/gc.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 05aed1f..74e77cb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -216,13 +216,13 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
-		fprintf(stderr,
-			"Auto packing the repository for optimum performance.%s\n",
-			quiet
-			? ""
-			: (" You may also\n"
-			   "run \"git gc\" manually. See "
-			   "\"git help gc\" for more information."));
+		if (quiet)
+			fprintf(stderr, _("Auto packing the repository for optimum performa=
nce.\n"));
+		else
+			fprintf(stderr,
+					_("Auto packing the repository for optimum performance. You may a=
lso\n"
+					"run \"git gc\" manually. See "
+					"\"git help gc\" for more information."));
 	} else
 		append_option(argv_repack,
 			      prune_expire && !strcmp(prune_expire, "now")
--=20
1.7.2.3.313.gcd15
