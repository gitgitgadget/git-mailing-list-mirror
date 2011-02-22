From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 58/73] gettextize: git-status "Initial commit" message
Date: Tue, 22 Feb 2011 23:42:17 +0000
Message-ID: <1298418152-27789-59-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vK-0000K1-MG
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab1BVXpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:45:32 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559Ab1BVXoa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:30 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Eg52PHHHsC2nLcYVtsRYXt51R/9Tk0l2a+9Cm/wqci0=;
        b=XgEw410jy4q4jinVq1j9jNYwjO/pIbUefSDtLJnhq6GivSNl3bwGFuxOk/fVqttw8n
         UiGh3RqAcJ8oV2eiFzWXEQFfEqViM9X7OumPb+wV99oyU5wTcVgq07ZE/4LgDo6k/BxD
         KHIzqZL63sM3UL346ffIkDl8n/MLf7NA+cYS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=e+NHcC593QJI+mTpUvUQ8ERQVzphVvzt9bfmnx7Js1jmQFUpNV0fFAfT/cD13Kia3A
         CbLG7+XBQbxYy2VyFFU3mDqJqYfrs47Nxgl7OViMeLJiuW+d4rU8sFGdapNwG1+mIvkU
         YmzDWbAVI9SeHA1+/kMsIYOrCIwgKa5wCvY0c=
Received: by 10.204.7.213 with SMTP id e21mr3030482bke.47.1298418269858;
        Tue, 22 Feb 2011 15:44:29 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.29
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:29 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167620>

Gettextize the "# Initial commit" message. A test in t7501-commit.sh
explicitly checked for this message. Change it to skip under
GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7501-commit.sh |    7 +++++--
 wt-status.c       |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 8980738..a76c474 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -14,8 +14,11 @@ test_tick
 test_expect_success \
 	"initial status" \
 	"echo 'bongo bongo' >file &&
-	 git add file && \
-	 git status | grep 'Initial commit'"
+	 git add file"
+
+test_expect_success C_LOCALE_OUTPUT \
+	"Constructing initial commit" \
+	"git status | grep 'Initial commit'"
=20
 test_expect_success \
 	"fail initial amend" \
diff --git a/wt-status.c b/wt-status.c
index c6295f9..ad6ef7a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -651,7 +651,7 @@ void wt_status_print(struct wt_status *s)
=20
 	if (s->is_initial) {
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "# Initial commi=
t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("# Initial com=
mit"));
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 	}
=20
--=20
1.7.2.3
