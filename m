Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6F1B297
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485715; cv=none; b=g2qC0oyv21uBfQ5sAqQpHu90nIPu28UC4fCGPMehBXXZAQSkJ64r1m+tt/zoLCmP38mfBjs8QahEqxrHsEMcQ2+0op9+Fxi8lARK3zR2Unx3Vf7IF8Op6mb+if0bmd+0Lw7LmlAky0mcMhdBj5X4NfxHDG+WDF6/NCpNmcXrJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485715; c=relaxed/simple;
	bh=QnwRLwEvbitMKBzd4A1nGelZtwIiuHvmYrqFFicGnPY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bbApP4VadXr4MUPgUGSFbxpoDPKfKX3kL3rl3cxWxmYbKCgKuU5erqz14qLZl8S+NRf9MUAVBm8BZGIauqOyVCKqNOXPUoEnQFTp0mcamfOmQpZz5o7NxPPvMAwhThmB4y4cejsGl4fIVSl30GVBXs9J6OBwXFPfnEmuIGFdS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGDQ18vN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGDQ18vN"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e99b639e0so1083142f8f.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710485711; x=1711090511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utqsz+B8Wo6UOPNQ8UYwXBY6NQSAFkEdixNQ1BTbGn0=;
        b=UGDQ18vN3yxEHzueD/Lm6AUd6ADvOMUO/AAzzZ5ouSK0HJW6gM6Elvgyp9NDDYgQLg
         PTkAn1utlGX1iikZ0JMdloaSDzSuDnw2EYnB3ZD+8RdbNGJUZjvURNKA0MpQ6R6EfcI2
         YyyfjcWBVKtpKoZb8kxktEKBToCEzK7v+PerRrFwQciqKTTfAzshJvTwjIA7d/t738Yu
         1b9EhPXUVhH7J+rKSLqPsnX/CVqM4JrkJfAvwSzUlXkqQhs+QKuHoMUmA15iSq/nYqFA
         Jmu9pPv95rH05uk8P6dOhxaxOlYgZSUYL7xB5J8NjTbzlnwwNRJDI/xdxNAnrzQaadrB
         JvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710485711; x=1711090511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utqsz+B8Wo6UOPNQ8UYwXBY6NQSAFkEdixNQ1BTbGn0=;
        b=n5+EyS7EaH0zhIZD0UhdaJavmFMfA1bFmJ/YweC62GSC/yRO6eH1OvTQJHNou7kaEr
         CnWAhsdTfQ9ng/vL7ON4kwzc2dvaMG/inBsTNke7q0+MOYdXQFMTt0ZHc0V5WQIINJu5
         L7wq3peU69h1GVC8P/LjOf5UI1GG7v+WpeJwyzjoMgJdyrzdpCLFMpqTjP6SEDjfoC42
         WQgJPRBEBZbdct3mzkjkPkHfbcITRSr2Oyg3jVNpIE5z3mz5D7jdenWeSOd1y6KQ1LaH
         0U6thaqcMcYchCTTEABwvXUolkOSMcvcUze5Gr9VS5pQq9pH5Hdjq4xzWDRHLYqvUCnt
         7gcQ==
X-Gm-Message-State: AOJu0YyrLI6ELFxI3JSBsD7h3Zh/S23fdPZaLK9d/SNEtXcjG0gjIfVf
	FysA8Okg58Nbln9bUpeILKiUsOvY5qvwBNCrurkXSmbiNWqVbFqrk1ScHQ5G
X-Google-Smtp-Source: AGHT+IEQoBYMTZtuKKiIrWjEAR4C9RKoHEPTF5/U3RNOq/mkURUaJ1DUrU/BobO5N1ymD26YKAD2Zw==
X-Received: by 2002:adf:f04a:0:b0:33e:652b:d6cf with SMTP id t10-20020adff04a000000b0033e652bd6cfmr2808921wro.29.1710485710761;
        Thu, 14 Mar 2024 23:55:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6608000000b0033e45930f35sm2452401wru.6.2024.03.14.23.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:55:09 -0700 (PDT)
Message-ID: <259a4edcfa5138053255dbade411ef151617bb1b.1710485706.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 06:55:03 +0000
Subject: [PATCH 3/5] format_trailer_info(): append newline for non-trailer
 lines
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Christian Couder [ ]" <chriscool@tuxfamily.org>,
    "Junio C Hamano [ ]" <gitster@pobox.com>,
    "Emily Shaffer [ ]" <nasamuffin@google.com>,
    "Josh Steadmon [ ]" <steadmon@google.com>,
    "Randall S. Becker [ ]" <rsbecker@nexbridge.com>,
    "Christian Couder [ ]" <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This wraps up the preparatory refactors to unify the trailer formatters.

Two patches ago we made format_trailer_info() use trailer_item objects
instead of the "trailers" string array. The strings in the array
include trailing newlines, because the string array is split up with

    trailer_lines = strbuf_split_buf(str + trailer_block_start,
                                     end_of_log_message - trailer_block_start,
                                     '\n',
                                     0);

in trailer_info_get() and strbuf_split_buf() includes the terminator (in
this case the newline character '\n') for each split-up substring.

And before we made the transition to use trailer_item objects for it,
format_trailer_info() called parse_trailer() (which trims newlines) for
trailer lines but did _not_ call parse_trailer() for non-trailer lines.
So for trailer lines it had to add back the trimmed newline like this

    if (!opts->separator)
        strbuf_addch(out, '\n');

But for non-trailer lines it didn't have to add back the newline because
it could just reuse same string in the "trailers" string array (which
again, already included the trailing newline).

Now that format_trailer_info() uses trailer_item objects for all cases,
it can't rely on "trailers" string array anymore.  And so it must be
taught to add a newline back when printing non-trailer lines, just like
it already does for trailer lines. Do so now.

The test suite can pass again without the need to hide failures
with *_failure, so flip the affected test cases back to *_success. Now,
format_trailer_info() is in better shape to supersede format_trailers(),
which we'll do in the next commit.

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/t4205-log-pretty-formats.sh | 12 ++++++------
 t/t6300-for-each-ref.sh       | 16 ++--------------
 trailer.c                     |  5 +++--
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 339e0c892ef..e3d655e6b8b 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -675,7 +675,7 @@ test_expect_success '%(trailers:only=no,only=true) shows only "key: value" trail
 	test_cmp expect actual
 '
 
-test_expect_failure '%(trailers:unfold) unfolds trailers' '
+test_expect_success '%(trailers:unfold) unfolds trailers' '
 	git log --no-walk --pretty="%(trailers:unfold)" >actual &&
 	{
 		unfold <trailers &&
@@ -737,7 +737,7 @@ test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
+test_expect_success 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
 	git log --no-walk --pretty="format:%(trailers:key=Acked-by,only=no)" >actual &&
 	{
 		echo "Acked-by: A U Thor <author@example.com>" &&
@@ -752,7 +752,7 @@ test_expect_success '%(trailers:key) without value is error' '
 	test_cmp expect actual
 '
 
-test_expect_failure '%(trailers:keyonly) shows only keys' '
+test_expect_success '%(trailers:keyonly) shows only keys' '
 	git log --no-walk --pretty="format:%(trailers:keyonly)" >actual &&
 	test_write_lines \
 		"Signed-off-by" \
@@ -774,7 +774,7 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
 	test_cmp expect actual
 '
 
-test_expect_failure '%(trailers:valueonly) shows only values' '
+test_expect_success '%(trailers:valueonly) shows only values' '
 	git log --no-walk --pretty="format:%(trailers:valueonly)" >actual &&
 	test_write_lines \
 		"A U Thor <author@example.com>" \
@@ -813,7 +813,7 @@ test_expect_success 'pretty format %(trailers:separator=X,unfold) changes separa
 	test_cmp expect actual
 '
 
-test_expect_failure 'pretty format %(trailers:key_value_separator) changes key-value separator' '
+test_expect_success 'pretty format %(trailers:key_value_separator) changes key-value separator' '
 	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00)X" >actual &&
 	(
 		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
@@ -824,7 +824,7 @@ test_expect_failure 'pretty format %(trailers:key_value_separator) changes key-v
 	test_cmp expect actual
 '
 
-test_expect_failure 'pretty format %(trailers:key_value_separator,unfold) changes key-value separator' '
+test_expect_success 'pretty format %(trailers:key_value_separator,unfold) changes key-value separator' '
 	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00,unfold)X" >actual &&
 	(
 		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2688dcc7b9e..eb6c8204e8b 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1446,19 +1446,7 @@ test_trailer_option () {
 	'
 }
 
-# Just like test_trailer_option, but expect failure instead of success.
-test_trailer_option_expect_failure () {
-	title=$1 option=$2
-	cat >expect
-	test_expect_failure "$title" '
-		git for-each-ref --format="%($option)" refs/heads/main >actual &&
-		test_cmp expect actual &&
-		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
-		test_cmp expect actual
-	'
-}
-
-test_trailer_option_expect_failure '%(trailers:unfold) unfolds trailers' \
+test_trailer_option '%(trailers:unfold) unfolds trailers' \
 	'trailers:unfold' <<-EOF
 	$(unfold <trailers)
 
@@ -1542,7 +1530,7 @@ test_trailer_option '%(trailers:key=foo,unfold) properly unfolds' \
 
 	EOF
 
-test_trailer_option_expect_failure '%(trailers:key=foo,only=no) also includes nontrailer lines' \
+test_trailer_option '%(trailers:key=foo,only=no) also includes nontrailer lines' \
 	'trailers:key=Signed-off-by,only=no' <<-EOF
 	Signed-off-by: A U Thor <author@example.com>
 	$(grep patch.description <trailers)
diff --git a/trailer.c b/trailer.c
index 2c0dd8ac829..fe8b0819d55 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1124,9 +1124,10 @@ static void format_trailer_info(const struct process_trailer_options *opts,
 				strbuf_addbuf(out, opts->separator);
 			}
 			strbuf_addstr(out, item->value);
-			if (opts->separator) {
+			if (opts->separator)
 				strbuf_rtrim(out);
-			}
+			else
+				strbuf_addch(out, '\n');
 		}
 	}
 }
-- 
gitgitgadget

