From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 55/72] gettextize: git-status shortstatus messages
Date: Sat, 19 Feb 2011 19:24:38 +0000
Message-ID: <1298143495-3681-56-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVH-00042j-Ir
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082Ab1BST3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:31 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39339 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135Ab1BST2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:14 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347149eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=lYMRuenqFIqgcMkCeF4IXVFANCNxdkApV/XDDMCMu5I=;
        b=kD2brUm11fXFb91WNcuj25H6lbqLiCQ2Jz0AlvBILD43nponHHCcKS2qEHXLqRK53E
         FrT9NKSuAFZ9tn1xZsLW8LSfy4ll4gGDEy4qsOjYrSBQW0d9aVtHzPx6F+YOjQY2FvX1
         qceoCCjGSjxCg6n0IsNmIrVPiGyXCMh/zsRFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ktI8F2gz/fhsVs2WX3/j740jC/1lwzyOWT3i++0tnNfXAhG2SiGZDzImmHq85VnSz0
         TXpa66MS9AaPoDu+IS8zEvqRAelVyAzy1MSCUpW01uBziN3SFvxT5kBefuvQnNNE+rzc
         MN5WvXeo+wdUjsVoN+BBFbMj2GiPIh4mOVhaU=
Received: by 10.213.108.204 with SMTP id g12mr2521479ebp.99.1298143692954;
        Sat, 19 Feb 2011 11:28:12 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.12
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:12 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167362>

Make the messages added in v1.7.2-rc0~54^2~1 translatable. Some of
these could use the to be implemented plural support in the gettext
library.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 wt-status.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index a975d07..fc38ac2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -804,13 +804,13 @@ static void wt_shortstatus_print_tracking(struct =
wt_status *s)
 	if (!prefixcmp(branch_name, "refs/heads/"))
 		branch_name +=3D 11;
 	else if (!strcmp(branch_name, "HEAD")) {
-		branch_name =3D "HEAD (no branch)";
+		branch_name =3D _("HEAD (no branch)");
 		branch_color_local =3D color(WT_STATUS_NOBRANCH, s);
 	}
=20
 	branch =3D branch_get(s->branch + 11);
 	if (s->is_initial)
-		color_fprintf(s->fp, header_color, "Initial commit on ");
+		color_fprintf(s->fp, header_color, _("Initial commit on "));
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
 		color_fprintf_ln(s->fp, branch_color_local,
 			"%s", branch_name);
@@ -825,15 +825,15 @@ static void wt_shortstatus_print_tracking(struct =
wt_status *s)
=20
 	color_fprintf(s->fp, header_color, " [");
 	if (!num_ours) {
-		color_fprintf(s->fp, header_color, "behind ");
+		color_fprintf(s->fp, header_color, _("behind "));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	} else if (!num_theirs) {
-		color_fprintf(s->fp, header_color, "ahead ");
+		color_fprintf(s->fp, header_color, _("ahead "));
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
 	} else {
-		color_fprintf(s->fp, header_color, "ahead ");
+		color_fprintf(s->fp, header_color, _("ahead "));
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
-		color_fprintf(s->fp, header_color, ", behind ");
+		color_fprintf(s->fp, header_color, _(", behind "));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	}
=20
--=20
1.7.2.3
