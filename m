From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 25/25] gettextize: git-status shortstatus messages
Date: Thu,  2 Sep 2010 19:40:46 +0000
Message-ID: <1283456446-22577-26-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:43:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFh8-0007JQ-AI
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700Ab0IBTnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:43:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57195 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab0IBTnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:43:09 -0400
Received: by wwj40 with SMTP id 40so1284319wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=53xRH+MrqfZojk89IxpAmpF6WnICcr3bs/iKjlALO5s=;
        b=FyR6xd+c21YJLn1mzR3SpmG2TVs08wbhq/i1ePz14j+idRH9ItRFXmJyuYSNkZtrEH
         Ep2i0URayRg9s4ZmBfAXMHkCybkU5mA7kFX7s/I6Zf5V5MtNW7MVGavar0QTMrGuKqcT
         b+/Y6WNpLEejd50rv8wqCs+29dGaJN7mjKrO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dlXlj5e92VIQPQcGQuKySo+oOOLmkwQVUp84H1Yd5aDM5bR5xmLUxSuUZ8cstXhOU/
         2IMgRZCTLUFgYhlZSxKG4abIRN0uOT3cXim9kJMRqu4YiNO/lwU431mC5qxWIHsnQKI+
         DBtwPqMKKk2IKAXZzwdvHi9tVhsbp8obdyAVk=
Received: by 10.227.135.15 with SMTP id l15mr9812174wbt.203.1283456588172;
        Thu, 02 Sep 2010 12:43:08 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.43.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:43:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155187>

Make the messages added in v1.7.2-rc0~54^2~1 translatable. Some of
these could use the to be implemented plural support in the gettext
library.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 wt-status.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 1c1a575..fc377f3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -793,13 +793,13 @@ static void wt_shortstatus_print_tracking(struct =
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
@@ -814,15 +814,15 @@ static void wt_shortstatus_print_tracking(struct =
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
1.7.2.2.614.g1dc9
