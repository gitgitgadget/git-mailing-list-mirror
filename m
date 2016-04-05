From: santiago@nyu.edu
Subject: [PATCH v5 3/6] builtin/verify-tag: change variable name for readability
Date: Tue,  5 Apr 2016 12:07:26 -0400
Message-ID: <1459872449-7537-4-git-send-email-santiago@nyu.edu>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 18:08:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTWF-0000aC-WA
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 18:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759459AbcDEQHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 12:07:47 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:36298 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbcDEQHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 12:07:44 -0400
Received: by mail-qg0-f65.google.com with SMTP id f105so1615657qge.3
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=16nAjXvn3EoxUlEvm3XdYURfbrxPwzBQwvMe3AH11+U=;
        b=ijJyfuGqmJEMvydu2vycz3jZhla3glf3c+WoTp4M2MevNB3Sf4ffSUXHd6r3/DxDTV
         UCywNR4tosIR53ROyWtQISL/8xyG+TdmMrkVAvUQiSe73aW53QCu18bWQj6kWGNzzlCb
         CCKI0/FAFvRAgQvjLAtFReJB1Em5PLzWRnM/LvdHxkqO8oMV9oR/lOp8I2YQMzIZuZar
         cZ4mwQaUExsP0cHRk/P2hz90ayhEUS7YN5T0aJengaJUQlReXBSROSuvwsLoDkvls0AW
         0d7k4Eoe21F3eKOjfoq4zgIi6m8u4A0l1xMs2ZlxmEwEvk/5IXXep3unJTTMfr08110n
         06mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=16nAjXvn3EoxUlEvm3XdYURfbrxPwzBQwvMe3AH11+U=;
        b=OOw1OTFXseIIA1aSyAKbqugZrKqEz0EyjFhQnkna8q7zv8yBBbq53MuvjJ3G+Urdz0
         CYCPYssD+lAOrnOb+akg5AOzjMcK5nm4L4+gFa5KD5zcvEOTdWQnxHI/0KQXLn1NE3X1
         EO3D3WrxFsJEFBcbS1BNE+CSKwpTgH0v81LyqFzsIBwCQlUnuS+cAvImivmaWs8M3fcV
         Jm3eBAyGTz5W2bR73zos1sOF/2qlyBTT2eNV5O2hJe0SqFJnHicdCbABlr0KnqmF6Kqd
         DqhDA/iqWUbXG4zpyCIZcphXbe9hnwGV4bI1lkJcsvJ3rrt8Vhch01zwx/hsvCGJddCa
         vEYg==
X-Gm-Message-State: AD7BkJK/4W6thtjFL8ozNxyxEmFgSdwbZtG20FpF5c4oRI6QHv80wF1IiuoDzFxK+2H8orCp
X-Received: by 10.140.100.244 with SMTP id s107mr20150361qge.19.1459872457944;
        Tue, 05 Apr 2016 09:07:37 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id b66sm14671343qhb.48.2016.04.05.09.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 09:07:37 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290795>

From: Santiago Torres <santiago@nyu.edu>

The run_gpg_verify function has two variables size, and len. This may
come off as confusing when reading the code. We clarify which one
pertains to the length of the tag headers by renaming len to
payload_length.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 77f070a..1ca9a05 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -21,20 +21,21 @@ static const char * const verify_tag_usage[] = {
 static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 {
 	struct signature_check sigc;
-	int len;
+	int payload_size;
 	int ret;
 
 	memset(&sigc, 0, sizeof(sigc));
 
-	len = parse_signature(buf, size);
+	payload_size = parse_signature(buf, size);
 
-	if (size == len) {
+	if (size == payload_size) {
 		if (flags & GPG_VERIFY_VERBOSE)
-			write_in_full(1, buf, len);
+			write_in_full(1, buf, payload_size);
 		return error("no signature found");
 	}
 
-	ret = check_signature(buf, len, buf + len, size - len, &sigc);
+	ret = check_signature(buf, payload_size, buf + payload_size,
+				size - payload_size, &sigc);
 	print_signature_buffer(&sigc, flags);
 
 	signature_check_clear(&sigc);
-- 
2.8.0
