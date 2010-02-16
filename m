From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 17/26] check-ref-format: setup gitdir gently
Date: Tue, 16 Feb 2010 23:05:08 +0700
Message-ID: <1266336317-607-18-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:17:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ78-00072y-93
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208Ab0BPQRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:17:21 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:38433 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757201Ab0BPQRR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:17:17 -0500
Received: by mail-yw0-f197.google.com with SMTP id 35so4826857ywh.21
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0Onj0gZ4DmYS4GmpOrWdWrj3k6RPQELwBpAjK9J+OVw=;
        b=f36FZ22eoPHmA58hqowkvCpbzhpRbt/r037ebUAyNkhRuOXZi3i65Qc8QE0mTzVYCL
         +9s3gLaLEHhj7B+JkHt69muC/+J+blx7rL0NbqNL6PgrCATsVypz7+5E33LAKswLF+Ox
         eyu4wl7Dnq5YSwFtq+c4GVr/w1xg3vRAgJCD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tJi0CjB0/OXXTjpCVxCTGZ5HTKzauc9gtyCA21kRT5ehq8jZXPKnevOanX1NApDmXY
         Auc/knRGtagblFGv26Xrrwl6E92KzvPA5+bTJTlh8P85Enqhidx3kPhW0tkLE+UJZW7K
         DSnnnItdgSLE+Z7OTtQyXwH/Mgepylsq2cZMg=
Received: by 10.150.65.18 with SMTP id n18mr10094649yba.136.1266336589816;
        Tue, 16 Feb 2010 08:09:49 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 4sm2856623ywd.44.2010.02.16.08.09.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:09:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:07 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140127>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 8386a3a..8892d5a 100644
--- a/git.c
+++ b/git.c
@@ -317,7 +317,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
 			RUN_SETUP | NEED_WORK_TREE},
-		{ "check-ref-format", cmd_check_ref_format },
+		{ "check-ref-format", cmd_check_ref_format, RUN_SETUP_GENTLY },
 		{ "check-attr", cmd_check_attr, RUN_SETUP },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
--=20
1.7.0.195.g637a2
