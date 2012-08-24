From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] test-parse-options: mark parseopt help strings for pseudotranslation
Date: Fri, 24 Aug 2012 12:43:06 +0700
Message-ID: <1345786986-10826-7-git-send-email-pclouds@gmail.com>
References: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 07:44:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4mh9-00017Y-Hr
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 07:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab2HXFo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 01:44:29 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39005 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab2HXFo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 01:44:27 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2795592pbb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 22:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tkioCcIgbiVg5zqz65YAjPT+TRYURhCRBLq5S2Zf/mM=;
        b=dA9X+NZayqhHn3KlB3BcubDg2i2+OPYseMjclaVXBgz0Eh8kXNjUVH9/OTtTuASKca
         y9nRkx0JuuJAjKE3u5x33bPjO0Ai0LiLt2JYMbofpVvRZ17atUK7d0Aq3maFoAeVRzR+
         gp7tjHSPVRbNle2il2djZ5vRiuBWqRkqy9+4arPpWzg7FKXrJltxcnOZ9tzoEv+tkkt7
         A3EWjjqNjWkaNBDG8apV0KGWInbuANBRxLG+K6enMwyk7oCsC90fF16cQqnywLM0/ScG
         u6WzvUpuQSRQOfj/s4VmDRpluSAwJ3SvB51r6K9EYjRaEryMNY3FuoZou6keMs2dXZ5t
         EXWw==
Received: by 10.66.78.69 with SMTP id z5mr8385183paw.14.1345787067526;
        Thu, 23 Aug 2012 22:44:27 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id io1sm7558252pbc.67.2012.08.23.22.44.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 22:44:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Aug 2012 12:44:10 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204187>

This reduces the number of false positives in untranslated.log when we
check for unmarked strings.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-parse-options.c | 62 ++++++++++++++++++++++++++------------------=
--------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/test-parse-options.c b/test-parse-options.c
index 4a94327..09ddf74 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -33,50 +33,50 @@ int main(int argc, const char **argv)
 {
 	const char *prefix =3D "prefix/";
 	const char *usage[] =3D {
-		"test-parse-options <options>",
+		N_("test-parse-options <options>"),
 		NULL
 	};
 	struct option options[] =3D {
-		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
-		OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
+		OPT_BOOL(0, "yes", &boolean, N_("get a boolean")),
+		OPT_BOOL('D', "no-doubt", &boolean, N_("begins with 'no-'")),
 		{ OPTION_SET_INT, 'B', "no-fear", &boolean, NULL,
-		  "be brave", PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
-		OPT_COUNTUP('b', "boolean", &boolean, "increment by one"),
+		  N_("be brave"), PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		OPT_COUNTUP('b', "boolean", &boolean, N_("increment by one")),
 		OPT_BIT('4', "or4", &boolean,
-			"bitwise-or boolean with ...0100", 4),
-		OPT_NEGBIT(0, "neg-or4", &boolean, "same as --no-or4", 4),
+			N_("bitwise-or boolean with ...0100"), 4),
+		OPT_NEGBIT(0, "neg-or4", &boolean, N_("same as --no-or4"), 4),
 		OPT_GROUP(""),
-		OPT_INTEGER('i', "integer", &integer, "get a integer"),
-		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
-		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
-		OPT_DATE('t', NULL, &timestamp, "get timestamp of <time>"),
-		OPT_CALLBACK('L', "length", &integer, "str",
-			"get length of <str>", length_callback),
-		OPT_FILENAME('F', "file", &file, "set file to <file>"),
-		OPT_GROUP("String options"),
-		OPT_STRING('s', "string", &string, "string", "get a string"),
-		OPT_STRING(0, "string2", &string, "str", "get another string"),
-		OPT_STRING(0, "st", &string, "st", "get another string (pervert orde=
ring)"),
-		OPT_STRING('o', NULL, &string, "str", "get another string"),
+		OPT_INTEGER('i', "integer", &integer, N_("get a integer")),
+		OPT_INTEGER('j', NULL, &integer, N_("get a integer, too")),
+		OPT_SET_INT(0, "set23", &integer, N_("set integer to 23"), 23),
+		OPT_DATE('t', NULL, &timestamp, N_("get timestamp of <time>")),
+		OPT_CALLBACK('L', "length", &integer, N_("str"),
+			N_("get length of <str>"), length_callback),
+		OPT_FILENAME('F', "file", &file, N_("set file to <file>")),
+		OPT_GROUP(N_("String options")),
+		OPT_STRING('s', "string", &string, N_("string"), N_("get a string"))=
,
+		OPT_STRING(0, "string2", &string, N_("str"), N_("get another string"=
)),
+		OPT_STRING(0, "st", &string, N_("st"), N_("get another string (perve=
rt ordering)")),
+		OPT_STRING('o', NULL, &string, N_("str"), N_("get another string")),
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_SET_PTR(0, "default-string", &string,
-			"set string to default", (unsigned long)"default"),
-		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
-		OPT_GROUP("Magic arguments"),
-		OPT_ARGUMENT("quux", "means --quux"),
-		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
+			N_("set string to default"), (unsigned long)"default"),
+		OPT_STRING_LIST(0, "list", &list, N_("str"), N_("add str to list")),
+		OPT_GROUP(N_("Magic arguments")),
+		OPT_ARGUMENT("quux", N_("means --quux")),
+		OPT_NUMBER_CALLBACK(&integer, N_("set integer to NUM"),
 			number_callback),
-		{ OPTION_COUNTUP, '+', NULL, &boolean, NULL, "same as -b",
+		{ OPTION_COUNTUP, '+', NULL, &boolean, NULL, N_("same as -b"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH },
 		{ OPTION_COUNTUP, 0, "ambiguous", &ambiguous, NULL,
-		  "positive ambiguity", PARSE_OPT_NOARG | PARSE_OPT_NONEG },
+		  N_("positive ambiguity"), PARSE_OPT_NOARG | PARSE_OPT_NONEG },
 		{ OPTION_COUNTUP, 0, "no-ambiguous", &ambiguous, NULL,
-		  "negative ambiguity", PARSE_OPT_NOARG | PARSE_OPT_NONEG },
-		OPT_GROUP("Standard options"),
+		  N_("negative ambiguity"), PARSE_OPT_NOARG | PARSE_OPT_NONEG },
+		OPT_GROUP(N_("Standard options")),
 		OPT__ABBREV(&abbrev),
-		OPT__VERBOSE(&verbose, "be verbose"),
-		OPT__DRY_RUN(&dry_run, "dry run"),
-		OPT__QUIET(&quiet, "be quiet"),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT__DRY_RUN(&dry_run, N_("dry run")),
+		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_END(),
 	};
 	int i;
--=20
1.7.12.rc2
