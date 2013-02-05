From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 2/2] i18n: mark OPTION_NUMBER (-NUM) for translation
Date: Wed,  6 Feb 2013 00:16:56 +0800
Message-ID: <8d6d4d869ea58e0a26b3bb6377fc102728948997.1360080194.git.worldhello.net@gmail.com>
References: <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:20:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2lG2-000185-4k
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697Ab3BEQUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 11:20:06 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:35570 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab3BEQUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 11:20:05 -0500
Received: by mail-ia0-f174.google.com with SMTP id o25so330049iad.19
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 08:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=rIXvOH15vPap5oGQfmS98QGxLYehhVoqghas+BMyC2o=;
        b=CCVBqyVeal3+YFqhgtZ2BkHWVllwkznGwdQgzmaNGvkGZ+b9E8Fcf+oxEJOsEOKib+
         1NaNHj0+3oxlTBypLmUsPx3fj6vJrX3z29eBi/m+359ubeSjuSaevjjHsbv+2LaABxe0
         QY+25r7QBvTXI1CYI8AU3sqv0TceaFC3yTaJBCTVpdUB17wqdrzBDJSEJQF6ScQ9GdtG
         ZyGf/XbKHpiNtqccEF/h+pDcuN+nr/xyQjpCEk3eqxdsY4zU/Z/lvueeEh4LA2OEGSan
         J1Qr2jrC8IiIjcCv9xZqN6QLdnbq9CWTULbIaCySYcylRJNlzMlni8gAoqt/9ZdVZzdk
         6TGA==
X-Received: by 10.50.155.134 with SMTP id vw6mr14553187igb.34.1360081204693;
        Tue, 05 Feb 2013 08:20:04 -0800 (PST)
Received: from localhost.localdomain ([114.248.148.50])
        by mx.google.com with ESMTPS id iw5sm20961335igc.5.2013.02.05.08.19.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 Feb 2013 08:20:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.369.g1321903.dirty
In-Reply-To: <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com>
In-Reply-To: <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com>
References: <20130205121552.GA16601@lanh> <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215516>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cd029f..be916 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -497,6 +497,8 @@ static int usage_with_options_internal(struct parse=
_opt_ctx_t *ctx,
 				       const struct option *opts, int full, int err)
 {
 	FILE *outfile =3D err ? stderr : stdout;
+	const char *opt_num_buff =3D _("-NUM");
+	int opt_num_size =3D utf8_strwidth(opt_num_buff);
=20
 	if (!usagestr)
 		return PARSE_OPT_HELP;
@@ -544,8 +546,10 @@ static int usage_with_options_internal(struct pars=
e_opt_ctx_t *ctx,
 			pos +=3D fprintf(outfile, ", ");
 		if (opts->long_name)
 			pos +=3D fprintf(outfile, "--%s", opts->long_name);
-		if (opts->type =3D=3D OPTION_NUMBER)
-			pos +=3D fprintf(outfile, "-NUM");
+		if (opts->type =3D=3D OPTION_NUMBER) {
+			fputs(opt_num_buff, outfile);
+			pos +=3D opt_num_size;
+		}
=20
 		if ((opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
 		    !(opts->flags & PARSE_OPT_NOARG))
--=20
1.8.1.1.368.g6034fad.dirty
