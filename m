From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] branch: delete branch description if it's empty
Date: Tue,  1 Jan 2013 16:30:55 +0700
Message-ID: <1357032655-21103-3-git-send-email-pclouds@gmail.com>
References: <1357032655-21103-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 10:31:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpyC3-00023H-Is
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 10:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab3AAJbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 04:31:10 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:41392 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab3AAJbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 04:31:08 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so6056714dak.16
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 01:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Y1aCNxF6/PE5I3QXDuihOtbhN5GRGVWRcX+UFebeIjc=;
        b=lENbfWmPnf9uRMrWUB5LIY1VfD7zT9zLV/10AmANLOGTFII0ix9Y8kfQr5hApwBCMp
         4NRq+obBGnpcXsXck7fNYgesCqkvftkJ0eI+pOXMHsgCJmnoxfEIGuVW6IOLEpwmIfrf
         VFo1/roioAOZrrAGMOa44s1DXguVIYK4ThLmiRG/p+36R3ueOr7iMiTXgvxALt2iREFL
         /xq3lbQcpfXBNCXRwbhrQ1xu6f23C2TrTTs25OJkOF95zWW2O2Sccx5NqODKrWgHF6V6
         815ozDQcWQzBpeBLFaH0SfULbESSndOAKRvU4eQ7P6B44sPaxqfgVhz0Pl/A5gBvqMxI
         UFFQ==
X-Received: by 10.68.253.230 with SMTP id ad6mr135930484pbd.84.1357032668058;
        Tue, 01 Jan 2013 01:31:08 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id b1sm11583066pay.17.2013.01.01.01.31.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2013 01:31:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 16:31:13 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357032655-21103-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212418>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I don't see the value of having an empty branch description. But I
 may be missing something.

 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1ec9c02..873f624 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -725,7 +725,7 @@ static int edit_branch_description(const char *bran=
ch_name)
 	stripspace(&buf, 1);
=20
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	status =3D git_config_set(name.buf, buf.buf);
+	status =3D git_config_set(name.buf, buf.len ? buf.buf : NULL);
 	strbuf_release(&name);
 	strbuf_release(&buf);
=20
--=20
1.8.0.rc2.23.g1fb49df
