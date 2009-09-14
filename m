From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 02/17] boolean is a typedef under MSVC, so rename variable to 'i_boolean'
Date: Mon, 14 Sep 2009 15:11:15 +0200
Message-ID: <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Sep 14 15:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBML-0004Gq-Ud
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbZINNMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755361AbZINNMb
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:12:31 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:53705 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbZINNM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:12:29 -0400
Received: by ey-out-2122.google.com with SMTP id 25so583417eya.19
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=UPwI8BnD7w/90w3D8kN2da35YQqjDhMO9JEW7hLYDK4=;
        b=HoHtk5gwnXPHpW1QlJi7/xNTqZQbtpO+r/YjNjN6PxawGaG/Kq4R/t9+EGmr1wUCAL
         xSQMyw7CORdLakfiOkNC88V9TaFrHKpM6hTiMX1Ictr0DSzcvuutwCGohDw8YQbQXzmr
         cju3sUi3jWU3fdqJv+KzR+32vMY+2HwhMzI8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PoqbA4p+UktZBynUAi1p1ScN/qHk1TlT56PGZZkkNM2V04Sulz8CJ4WLMJG/l5eUAn
         2yXxMUYSrVLRnikwfxWFes0tjoZ1GmPmqltdNAMWOsDyZ9152mRyfxg6AZBK1M3APqGx
         pOt5mtoroP8gMv2THIrZwgIJRd1+GOSkJq6Ko=
Received: by 10.210.4.13 with SMTP id 13mr6946417ebd.45.1252933951867;
        Mon, 14 Sep 2009 06:12:31 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 06:12:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128460>

With MSVC 'boolean' is already a typedef to unsigned char in
the rpcndr.h in the SDK. So, just rename to 'i_boolean' to avoid
conflicts in this one file, instead of any include magic.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 test-parse-options.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/test-parse-options.c b/test-parse-options.c
index efa734b..0c2d327 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "parse-options.h"
 
-static int boolean = 0;
+static int i_boolean = 0;
 static int integer = 0;
 static unsigned long timestamp;
 static int abbrev = 7;
@@ -34,10 +34,10 @@ int main(int argc, const char **argv)
 		NULL
 	};
 	struct option options[] = {
-		OPT_BOOLEAN('b', "boolean", &boolean, "get a boolean"),
-		OPT_BIT('4', "or4", &boolean,
+		OPT_BOOLEAN('b', "boolean", &i_boolean, "get a boolean"),
+		OPT_BIT('4', "or4", &i_boolean,
 			"bitwise-or boolean with ...0100", 4),
-		OPT_NEGBIT(0, "neg-or4", &boolean, "same as --no-or4", 4),
+		OPT_NEGBIT(0, "neg-or4", &i_boolean, "same as --no-or4", 4),
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
@@ -57,7 +57,7 @@ int main(int argc, const char **argv)
 		OPT_ARGUMENT("quux", "means --quux"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
 			number_callback),
-		{ OPTION_BOOLEAN, '+', NULL, &boolean, NULL, "same as -b",
+		{ OPTION_BOOLEAN, '+', NULL, &i_boolean, NULL, "same as -b",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH },
 		OPT_GROUP("Standard options"),
 		OPT__ABBREV(&abbrev),
@@ -70,7 +70,7 @@ int main(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	printf("boolean: %d\n", boolean);
+	printf("boolean: %d\n", i_boolean);
 	printf("integer: %u\n", integer);
 	printf("timestamp: %lu\n", timestamp);
 	printf("string: %s\n", string ? string : "(not set)");
-- 
1.6.2.1.418.g33d56.dirty
