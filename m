From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/5] branch: delete branch description if it's empty
Date: Thu,  3 Jan 2013 21:03:08 +0700
Message-ID: <1357221791-7496-3-git-send-email-pclouds@gmail.com>
References: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 15:03:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqlOZ-0001Gt-Hd
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 15:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab3ACODV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 09:03:21 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53433 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437Ab3ACODT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 09:03:19 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so8505518pbc.8
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 06:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=/B4fHhoHAihj3v+0U/1H8SjVGCFQQkcLK7TNTjqTd7g=;
        b=NSmAvQp1fyPQ5BLPIXtI1Jy5R3zPWXQ9WwFDAdl15+XtxJAuixVG2FevGs/9Nqs8T8
         bsrkiyD5t6GlsnNhv0OOyLt17yI7gQMEmbBMVG/3mgun7mE5bXYVUM/tph9yYnK4wD1t
         8sT/BlxfPmYcnf1wLv7AHBvVxRlHoVrYfjuzcHocxvpszvEMPQplZrEkk505XxrP7UoH
         NWplhfkw+x4x+Oc1Psfxso8JQ8mGHutEAqAt9E2ZBWMfao/bUnjcWofdncn74Ew8CjNC
         CHM93QEi+ajxv9mWvYzhbxt2WUfOuiNrATJgXuNQbdSZT2Frkiqpmo90oXDVHHJkjOhi
         MRMw==
X-Received: by 10.68.248.74 with SMTP id yk10mr154264644pbc.86.1357221798709;
        Thu, 03 Jan 2013 06:03:18 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id qn3sm28222261pbb.56.2013.01.03.06.03.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 06:03:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 03 Jan 2013 21:03:24 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212585>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
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
