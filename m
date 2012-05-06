From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] apply: remove lego in i18n string in gitdiff_verify_name
Date: Sun,  6 May 2012 20:13:22 +0700
Message-ID: <1336310002-3769-1-git-send-email-pclouds@gmail.com>
References: <xmqqehrbbf4s.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 15:17:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR1Km-0005Nj-3Z
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 15:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755Ab2EFNRD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 09:17:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43355 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab2EFNRB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 09:17:01 -0400
Received: by pbbrp8 with SMTP id rp8so5644122pbb.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bWVEcH/+Go/X7MPcDNNQPWiz5kh80kiX/yXX1Caod1A=;
        b=IPKor/DC5caMCVlHRoPl8iNikl6HhdOGPrJzOSigYeTXfFIV5RG8z6Mis+yv4xtDV0
         cOXZ8DWX94MA6PK0CZSsRLzMp59THyo6orW9UTAmO4uD9AvpwK6d16nJURQTEADa39hB
         xPWPAjFx6MhgX1gNxOmqRVa1jyGVCAkATmiJBfI+46moc6Or9ciTjDw+Xmuo4qzPqs4x
         NTXyZfpvvwwOM5ovG9B40SpeB5Vz14iU/0ccxzcEfAKRGQGAzXhKVFQ3n33EWssshUeW
         c62tpfi5vPAMJIRdVjsg/vgtHKFpNNb9tOcTiRVlDnycrETH8ydEgNeIIEK/rpke6VAn
         GVdA==
Received: by 10.68.232.233 with SMTP id tr9mr17813902pbc.153.1336310220963;
        Sun, 06 May 2012 06:17:00 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.32.70])
        by mx.google.com with ESMTPS id nk2sm1555827pbc.54.2012.05.06.06.16.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 06:16:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 06 May 2012 20:13:23 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <xmqqehrbbf4s.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197183>

Currently it marks the string "...inconsistent %s filename..." where
%s is either "old" or "new" from caller. Make it two strings
"...inconsistent new filename..." and "...inconsistent old filename..."

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, Apr 26, 2012 at 5:50 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 > In this function, the parameter oldnew has "old" or "new" and the
 > callers (gitdiff_oldname() and gitdiff_newname()) do not have it mar=
ked
 > for translation.  Even if they did, it would result in a lego
 > composition, so you may have to switch between two translatable mess=
ages
 > here.

 Makes sense.

 builtin/apply.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 725712d..1edd3f7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -919,7 +919,7 @@ static int gitdiff_hdrend(const char *line, struct =
patch *patch)
  * their names against any previous information, just
  * to make sure..
  */
-static char *gitdiff_verify_name(const char *line, int isnull, char *o=
rig_name, const char *oldnew)
+static char *gitdiff_verify_name(const char *line, int isnull, char *o=
rig_name, int new)
 {
 	if (!orig_name && !isnull)
 		return find_name(line, NULL, p_value, TERM_TAB);
@@ -934,7 +934,9 @@ static char *gitdiff_verify_name(const char *line, =
int isnull, char *orig_name,
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line=
 %d"), name, linenr);
 		another =3D find_name(line, NULL, p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len + 1))
-			die(_("git apply: bad git-diff - inconsistent %s filename on line %=
d"), oldnew, linenr);
+			die(new ?
+			    _("git apply: bad git-diff - inconsistent new filename on line =
%d") :
+			    _("git apply: bad git-diff - inconsistent old filename on line =
%d"), linenr);
 		free(another);
 		return orig_name;
 	}
@@ -949,7 +951,7 @@ static char *gitdiff_verify_name(const char *line, =
int isnull, char *orig_name,
 static int gitdiff_oldname(const char *line, struct patch *patch)
 {
 	char *orig =3D patch->old_name;
-	patch->old_name =3D gitdiff_verify_name(line, patch->is_new, patch->o=
ld_name, "old");
+	patch->old_name =3D gitdiff_verify_name(line, patch->is_new, patch->o=
ld_name, 0);
 	if (orig !=3D patch->old_name)
 		free(orig);
 	return 0;
@@ -958,7 +960,7 @@ static int gitdiff_oldname(const char *line, struct=
 patch *patch)
 static int gitdiff_newname(const char *line, struct patch *patch)
 {
 	char *orig =3D patch->new_name;
-	patch->new_name =3D gitdiff_verify_name(line, patch->is_delete, patch=
->new_name, "new");
+	patch->new_name =3D gitdiff_verify_name(line, patch->is_delete, patch=
->new_name, 1);
 	if (orig !=3D patch->new_name)
 		free(orig);
 	return 0;
--=20
1.7.8.36.g69ee2
