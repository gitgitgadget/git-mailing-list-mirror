Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839177;
	b=5RB9bWvZeZYDw3MFWjpck9CGAmPjQirilgnh8KFHhdpajiku8+oyhwFBOM50SZRgp96n
	 QLSriLp2BfU4G9coLf2HBJ8QX6XYkJFt07VI7MeIFfhWA6316+2hRL0z/MOTzMAm84Q73
	 dP6PapZE49JLv68M7fQjXg5Z1IPazW9OsVhjf2+ZnznRQNmjGs7T/rcEX+B3OvnL5Psuv
	 SqydQKvz66bTbHqMvZP7IdsmIXMnJX5Xg7mDegko71Zmix29qpYYveG7avhjDMOnwthMO
	 8gREKykdyCRpjUXU42G0d+UK0Z2gsyHBenRgQgb8DLRVlVS7OGpoyuB4XppBkWxShaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/4mpfEeVtAl3e4+MhWOzsCIhBg8/1QaN2eNz+CYSjSY=;
	b=GHl2UakKV3GP14hFYcbzVJr+RRyOtt/w4Qc5thBCK+A9aqdjsO35uNWqRXM2rH8KflvZ
	 X/CC+5YwEy7k3F0QGlV4XIKk8jarj6a1ZjYj0xo0i7FPVetxu4FOvaphsr7dERIQw30wB
	 q0PMNSDP0aiVCJvpTOZCvpDXUp4Q6d2smwPBhbmw0kYVPRp0n9D5q9/7lV+g6LczvfT68
	 l1je3W+rHlwdVEDPSOnfXEb/uArqcO8KtE0hl1qUF2B637LXmagY+VYUdC/vIZvBZDBwr
	 kI4k16hOJ90TBwqvb2w5siqQ33c0aAI0Dn4Nhybi5Am7sV8zchT4Sn9wesJcHrd3Q1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHlCgaU2;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15AD606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A15AD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHlCgaU2
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso2133742a12.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 16:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793839175; x=1794443975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/4mpfEeVtAl3e4+MhWOzsCIhBg8/1QaN2eNz+CYSjSY=;
        b=qHlCgaU2LPNLGzlirEm6DyzgDn5aHkjCyDnHs10joyjFXQ42S7rI8ttB+lDLe+syNy
         xCNWFjVVnoylizldMF3hXNQEb/7VrTM7uRmTFcgMQ8J5eMLDGjxGXHneLEg9KPih1DLh
         JSRU1PLbsQqy6+9iPw8wBxA9QQH/KDx7c032zO7IOgdTxtVrNom3T0aKmllGjtk8DiSk
         i+Rk62gESN6afgOfUpW8IB0HQUO4yvBTPcCfENQrEGCCt//Yv3tI4NbuSTsjYJTefam5
         DBn4KKEHgnpHHhAha9ubKAW/4gheiRJpSPGCMxxgc8oxyRJsvfJ8BURfPmprjYaQM5bm
         en2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793839175; x=1794443975;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4mpfEeVtAl3e4+MhWOzsCIhBg8/1QaN2eNz+CYSjSY=;
        b=tMEHhXFYLrs7wt2AwB2OPJiHix6XOVp2k3Hvz76/wWeRhpMKOSbnYgiL6kFgvHn++k
         IZUennsAicnmhWgPxot95VU9RP+MLocdGgwXKZLtp/A0EjX9X72j07Abmk6RtWP4IlDT
         lIfOdbZGFYLdM4cDhnRJMryNJS0CunGU1p6K3w/obR+7NhLSWRaSAQHz3JEg25aDjr/N
         Y/XIIHAId1Jq67QCAc7ORxicqL8n2SBvBYWxGi3ZQTMErnxEQ9C3mSi5tTGJrHIbeweQ
         6Y01SJddyk2TJyxv7hqV9NER1YMSa8ddv9RoW+dmD3GMe8c6+n/ea3dbsD32tq/huel+
         Nn+g==
X-Gm-Message-State: APuU4Z9Kq0QXsZKCIHj4niuOMCOjJTg3V1HvF3T43cWQDOzeLEhrtjn9
	9R7Ap3ZMS1sJJbrR6CjRpod25Bon/JpvK2DQWVXMIjdqKws1DhO6mRXXoQDkpXr5
X-Gm-Gg: AYBFou12JK+2moUSgAiPgIIwEOz4byzmDk47RSAYN655LYvRfhIXIxTnp5beOqHS1V1
	wt0JwgrvoNz/OfOFn1htDxfoz9p5IwmN5XGwdYuxY8xzFv4kOQgwkBjCtD7R89muVwnqYMCO40A
	gdK6JRWKF+1VFCCXSF1w2oekdUs71uOWtj7coqdRoR/24GixDnibNPdxyyIj6DG3ZZ9qQuHKjW7
	Qhrs9b1PpKhcRhidnq/wX5r69HG7qNdiuUkFboUlzGkmjcyuPpZ5Vsf0p3ekPv7o5q/8+k7s15X
	YZSMEAKTdFl3DyYBCZorTCGGsbeO655Zb8IqWfr7QeQ2Qp07+N99YTJLh7jW1bJvNfIi6wih9Wa
	P8TJYCLjyj1i24L+EmgXAM41navR6SDXFsa2ONlWkKGPyQ7jSSn2f1AYT9T8N3OMIZ1oyAbinfk
	xWg3EmjVCLOo66SsA2KjwTepHkQypzcnEX8fcqyejUUhMbxt5+FVM/5c2k6pnMlag5CoXyKLs//
	+UJfJUmKgCil/GhR4BS9MIqcpUK13ynOBmtAgW55XTaz96v5czBOwJfvzcLFSp8gA9VrTmfoKB8
	Bmdal3yGZJSUuzmdYvnD6yai7cal70hClwwNoANjlZ8+Z8UbRsKcwt3B3s2CCstMjTCEgWSIM5Y
	EBma3Z7smMicuLYvvGugVeXTCmEoQ7gCYNqYQ
X-Received: by 2002:aa7:c395:0:b0:6b3:cbe9:7231 with SMTP id 4fb4d7f45d1cf-6b4d33c68f8mr8881886a12.5.1793839174705;
        Wed, 04 Nov 2026 16:39:34 -0800 (PST)
Received: from HP ([105.163.158.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac7fa76sm1236883a12.28.2026.11.04.16.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:39:33 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	herroyalpriestess@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v4 1/3] parse-options: answer --git-completion-helper before command runs
Date: Thu,  5 Nov 2026 03:39:11 +0300
Message-ID: <20261105003914.708836-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.299.g39a9a95557
In-Reply-To: <20261029231621.48958-1-tangajoris@gmail.com>
References: <20261029231621.48958-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fast-import parses its options only after reading the "feature"
lines from its input, and it creates a temporary pack file before
that. So "git fast-import --git-completion-helper" waits for input,
and each run leaves a tmp_pack_* file behind.

bash completion runs the helper with the terminal as input. The next
commit removes the NO_PARSEOPT flag from fast-import, which would make
"git fast-import --<TAB>" freeze without this patch.

show_usage_with_options_if_asked() already answers -h and --help-all
before a command does any work. Teach it to answer the completion
helper too. Then fast-import, and the other commands that call it,
reply without reading input.

Reported-by: René Scharfe <l.s.r@web.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Cynthia Uche <herroyalpriestess@gmail.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
Changes since v3:
 - Added a sentence to the log message saying that the next commit
   removes NO_PARSEOPT from fast-import, as Kaartic suggested.
 - Added a comment above show_usage_with_options_if_asked() in
   parse-options.h, as Kaartic suggested.
 - Added Cynthia's test for --git-completion-helper-all. I also added
   the tmp_pack_* check from the first test to it, because without
   it the test still passes when the fix is reverted.
 - 2/3 is unchanged.
 - 3/3 is new, it adds the test Kaartic suggested.

 parse-options.c        |  6 ++++++
 parse-options.h        |  6 ++++++
 t/t9300-fast-import.sh | 16 ++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 283a0f1dc2..f2a23b79a4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1536,6 +1536,12 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 			usage_with_options_internal(NULL, usagestr, opts,
 						    USAGE_FULL, USAGE_TO_STDOUT);
 			exit(0);
+		} else if (!strcmp(av[1], "--git-completion-helper")) {
+			show_gitcomp(opts, 0);
+			exit(0);
+		} else if (!strcmp(av[1], "--git-completion-helper-all")) {
+			show_gitcomp(opts, 1);
+			exit(0);
 		}
 	}
 }
diff --git a/parse-options.h b/parse-options.h
index f68b51ceca..7ad33801fe 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -427,6 +427,12 @@ int parse_options(int argc, const char **argv, const char *prefix,
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
+/*
+ * If the only argument is -h, --help-all, --git-completion-helper or
+ * --git-completion-helper-all, print the answer and exit. Call this
+ * before the command does any work. Then asking for help or for the
+ * completion list does not wait for input or leave files behind.
+ */
 void show_usage_with_options_if_asked(int ac, const char **av,
 				      const char * const *usage,
 				      const struct option *options);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 73c6e3d448..1305614381 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2914,6 +2914,22 @@ test_expect_success 'R: blob appears only once' '
 	test 1 = $n
 '
 
+test_expect_success 'R: --git-completion-helper does not read from stdin' '
+	find .git/objects/pack -name "tmp_pack_*" >before &&
+	echo garbage | git fast-import --git-completion-helper >out &&
+	test_grep -e "--date-format=" out &&
+	find .git/objects/pack -name "tmp_pack_*" >after &&
+	test_cmp before after
+'
+
+test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
+	find .git/objects/pack -name "tmp_pack_*" >before &&
+	echo garbage | git fast-import --git-completion-helper-all >all &&
+	test_grep -e "--allow-unsafe-features" all &&
+	find .git/objects/pack -name "tmp_pack_*" >after &&
+	test_cmp before after
+'
+
 ###
 ### series S (mark and path parsing)
 ###
-- 
2.43.0

