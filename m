Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439A8482
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbXoIqrW"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B638FF
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 06:44:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405361bb94eso52400375e9.0
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697463880; x=1698068680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kratpb9GpTqhcrfetabeu+58flcxOYCe0k5b5fEbC3E=;
        b=XbXoIqrWG1SaQiBHcWp9tDL6nNrDXVBdrhop50nvn/SjrklSCtUB/JdHvKiFgy3zRr
         M+Qc0ZOW3kubFW0KsZW27ghiKuDMAiqjl0E6a/8M9AQYeLJ/qMVxs6vH4eAtm91Us2NC
         PtPpNgkGZNzDMg+0y0BL1XnAZ5eO8jFwcyCs4McjCeZOd09aquLDknTC5L/Kyd5PYK/6
         HhZgb42NljhrsjzdqKCIl4yysgDjv/ojomkPuM9WpCtaAHfbGyBWRzCYNZjIO5qZUQtV
         a1gPgPta2NihUUKUqMo1UuGb60a/6USHw700CiCpHw72sVRfFzkjKP8q4AV4KR+/S+Mb
         t0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697463880; x=1698068680;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kratpb9GpTqhcrfetabeu+58flcxOYCe0k5b5fEbC3E=;
        b=MSvQynY4NnYJFP0jWucr1SdIb+DqO/zN/vzCgpgsqkELzUSWb5UNpxuy0Zt66stUEV
         BgF+e58I2atiNQi5vpBmZhmpDh5qVco4thIISBzQMgzDuHhGMR+SOISmtyKc25UTnQEx
         g3tqP9mCgszSYxAwxplpettpGiHDK2mUo6wqzgmhHHFl6XrvzQje8BdSxG/DrtrC5Qjw
         sW1k59HQkOB53yZHc2ccJ/JMQbgQ+3372BrfFmLx3z7VATb73WMNMzrecCymDexV/757
         XZ54bDXZVS+gUc0N7svD5EYSJKLdR2eqGO5bVNTJlrkm8zfWIgQiNDoQa6CSwt8QA1jA
         K6hQ==
X-Gm-Message-State: AOJu0Yy4rXLuFnhyx0sJizvBhnQWUdc4MISWrAjIfMaNAb75Vbs84e0/
	UX3OorpS4MQIw/74EAzscJY=
X-Google-Smtp-Source: AGHT+IGCZRwmBBXWe9IzmySvI396y3iXu+kkWV7r9wp2uwM4HJhniL8/WBzFziZyIFaPkOYJYE17+Q==
X-Received: by 2002:a05:600c:294a:b0:3f5:fff8:d4f3 with SMTP id n10-20020a05600c294a00b003f5fff8d4f3mr30619478wmd.7.1697463879343;
        Mon, 16 Oct 2023 06:44:39 -0700 (PDT)
Received: from localhost.localdomain (host-2-102-115-95.as13285.net. [2.102.115.95])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c230a00b00405718cbeadsm2521822wmo.1.2023.10.16.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:44:38 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: steadmon@google.com
Cc: calvinwan@google.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	linusa@google.com,
	phillip.wood123@gmail.com,
	rsbecker@nexbridge.com
Subject: [PATCH v8 2.5/3] fixup! unit tests: add TAP unit test framework
Date: Mon, 16 Oct 2023 14:43:00 +0100
Message-ID: <20231016134421.21659-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.42.0.506.g0dd4464cfd3
In-Reply-To: <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
References: <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Here are a couple of cleanups for the unit test framework that I
noticed.

Update the documentation of the example custom check to reflect the
change in return value of test_assert() and mention that
checks should be careful when dereferencing pointer arguments.

Also avoid evaluating macro augments twice in check_int() and
friends. The global variable test__tmp was introduced to avoid
evaluating the arguments to these macros more than once but the macros
failed to use it when passing the values being compared to
check_int_loc().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/unit-tests/test-lib.h | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index 8df3804914..a8f07ae0b7 100644
--- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -42,18 +42,21 @@ void test_msg(const char *format, ...);
 
 /*
  * Test checks are built around test_assert(). checks return 1 on
- * success, 0 on failure. If any check fails then the test will
- * fail. To create a custom check define a function that wraps
- * test_assert() and a macro to wrap that function. For example:
+ * success, 0 on failure. If any check fails then the test will fail. To
+ * create a custom check define a function that wraps test_assert() and
+ * a macro to wrap that function to provide a source location and
+ * stringified arguments. Custom checks that take pointer arguments
+ * should be careful to check that they are non-NULL before
+ * dereferencing them. For example:
  *
  *  static int check_oid_loc(const char *loc, const char *check,
  *			     struct object_id *a, struct object_id *b)
  *  {
- *	    int res = test_assert(loc, check, oideq(a, b));
+ *	    int res = test_assert(loc, check, a && b && oideq(a, b));
  *
- *	    if (res) {
- *		    test_msg("   left: %s", oid_to_hex(a);
- *		    test_msg("  right: %s", oid_to_hex(a);
+ *	    if (!res) {
+ *		    test_msg("   left: %s", a ? oid_to_hex(a) : "NULL";
+ *		    test_msg("  right: %s", b ? oid_to_hex(a) : "NULL";
  *
  *	    }
  *	    return res;
@@ -79,7 +82,8 @@ int check_bool_loc(const char *loc, const char *check, int ok);
 #define check_int(a, op, b)						\
 	(test__tmp[0].i = (a), test__tmp[1].i = (b),			\
 	 check_int_loc(TEST_LOCATION(), #a" "#op" "#b,			\
-		       test__tmp[0].i op test__tmp[1].i, a, b))
+		       test__tmp[0].i op test__tmp[1].i,		\
+		       test__tmp[0].i, test__tmp[1].i))
 int check_int_loc(const char *loc, const char *check, int ok,
 		  intmax_t a, intmax_t b);
 
@@ -90,7 +94,8 @@ int check_int_loc(const char *loc, const char *check, int ok,
 #define check_uint(a, op, b)						\
 	(test__tmp[0].u = (a), test__tmp[1].u = (b),			\
 	 check_uint_loc(TEST_LOCATION(), #a" "#op" "#b,			\
-			test__tmp[0].u op test__tmp[1].u, a, b))
+			test__tmp[0].u op test__tmp[1].u,		\
+			test__tmp[0].u, test__tmp[1].u))
 int check_uint_loc(const char *loc, const char *check, int ok,
 		   uintmax_t a, uintmax_t b);
 
@@ -101,7 +106,8 @@ int check_uint_loc(const char *loc, const char *check, int ok,
 #define check_char(a, op, b)						\
 	(test__tmp[0].c = (a), test__tmp[1].c = (b),			\
 	 check_char_loc(TEST_LOCATION(), #a" "#op" "#b,			\
-			test__tmp[0].c op test__tmp[1].c, a, b))
+			test__tmp[0].c op test__tmp[1].c,		\
+			test__tmp[0].c, test__tmp[1].c))
 int check_char_loc(const char *loc, const char *check, int ok,
 		   char a, char b);
 
-- 
2.42.0.506.g0dd4464cfd3

