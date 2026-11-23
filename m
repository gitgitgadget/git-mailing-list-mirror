Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472029;
	b=IPllzfh12WaVYZrABpCidqdBdDEJGOgxNK3SCRj0OkLqoS6a5cXhJhTcRjsxRA+XcaxL
	 by3WYkCj2F9ZQnBERao1Dh5t7Z/zhNRXgn++ReourvJm/WGqAdSNYzjL28GUkpQUagkaK
	 MwE9ixHPveQQSPpZrA+aBtmxw3qOhsfwgEwvPgGGwWf1ldIjx8d9sulD7i/4C6cF+TfnO
	 VeiPjii52GNAwS0oMxWYiCAenEwxtdafZr+JARby5nrb/+e3VbN+t2WVQe/X0ylTj67oY
	 wXmXsuy2u0Ejg5lPmqeR4qQ+F+pR+kKcvj6Cb0wTbjhU5Tw1AL7op6+GYfkq0K/9zHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=pGKiy4Ifh3InIU4tg8JYzxQW9ml9h1f0vUfzkV0C69M=;
	b=oTX32EZMjhN987UHcQbY7vivdA1cv8vYwIou41mzBA7yYuE8E942B52Pq7Gub4KgemcU
	 JiPG9A72S5hu1NxtIrFxe5BujC0DXDcXYwoSg1s7OwCB9SyeZ+nEBDI9RT7XVtWyq5Ysz
	 7jZpWgWFfqymxRZRYYG1b4yCZd3dTCh0OAWkAC1qvyM5DRdQBsFnwYFGq82o2iFX+o5fT
	 N55T6NmES9HZlyTDqE3DIHiTbw74wFEOyIKlH6TCrzkFevinnUHA0k5JxWzbmuRU1vioA
	 J5AjGEDn1dgfYduLJAeLRpBS2SAXam0+HBdpZrneuRLC3/b1kZ+87+h7v1bRL61/LNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="u0j5Av/D";
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB7606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66AB7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u0j5Av/D
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b5786e099cso1442982c88.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472028; x=1796076828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pGKiy4Ifh3InIU4tg8JYzxQW9ml9h1f0vUfzkV0C69M=;
        b=u0j5Av/Dz0InT9pjTQ8Q6xM3vW9/FEN0RBpbxhipOZ8tsCpNwqRrr6Mgf4Y9dq9aMY
         6/iO+g5sxHKardA1BO9r3Jue6mnZ0Y3GG1XTkack5PiLInv9u72q1AG7+QJ9DWtMin+c
         ooLpx1JRb718xMjDlMbbvd+QNlXLc1rmoTAG8X235TUx25vaEykGMlJ2AzahzBqALRqt
         pN3entjdQlj0kQ3Grpuv31aS+tOtceK1iE6e3UJkY2kSBi1A4ZSJN1i1P0D35VTB+n2B
         n5ymHAn7ri/M63x0PpBbl7bOt0rl9tR4ky/BX7W2Il3zBQAX3CMr/s0yCVxctAP9/X9r
         4W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472028; x=1796076828;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGKiy4Ifh3InIU4tg8JYzxQW9ml9h1f0vUfzkV0C69M=;
        b=c9j0uxEaKbmvQOq2EsCacvDRXyNq+WezAe4oCX57U8zB7gWdwiFdJow9yZwXts2Q8Q
         CeW7kbAlSmEzum2NbABxIWVgKBNKDYwUsIqqRGMj1LsAOQNxjKMeRWJKtY/MJBUoe0MZ
         a2u3xqlepdQrnRf3dJhknP+fjM+mBsm78NAEiAWDQBQorHaLMTtEvwjfWvcUOhEjW3h+
         SjbsGmKvW9tXtUYFsKT8HUsh17HNaFZnxVFxKNYFiyQVJakxxQE7x0ERz0xbdTi8Ri7i
         +PpEChjboRe1IYw4UvL44wtGJLWxBT6Tey/xAsftipnuvljWs+btGTGkdACl589eWqhI
         i+lg==
X-Gm-Message-State: APuU4Z99P8pydwD9XNOBjvXuHvLj03Tx7NIDjCgyUrQrEFejqSl11gni
	Biy486qoCwlZvhfC7v6ROCB0GAEnynNI10uTjDBfvmFMXBaOSy7HmqGyg0BW3dyD
X-Gm-Gg: AZFdTZe993NNSxqcp6J9+g3CKf6FKoI9siTpkZM1J1NMNWKhFQ70TN+aBJbVEvxT9tK
	A4OzIqW7XXLdPkwt4r/9MzmPLYUbTooGpdQv8v14BFYyzj+TSMJEJD/YGAff8hW8FyC9R8it/oA
	9w/C6yXJcds7VwMrLcBq8Kb4IphvbHFMhEfpz7vOf2tvNMBKlouztAsByRqSUGqA3mXt9FWqqzX
	gTanqAZ8YAg2w1y4EK3AfyjltX2Ck8/OpwtXjtMrTnXgktpOGdiqCnbr/4LqBfQBEY06fxkzcYx
	dGyAKcxnQYMfuYaKyt7QBFMSCsge187C5miu+gG7+vtvbL36ONftVlhI215RkLYjyv5y+tRPn8S
	qUmGmmZx5DCtjilczItzm92XTyG0yfbjoUJ2eaabbqId+vJhT/LfUuTDfw8jccm+YExt5tb7USq
	uamliezk+gGKVKwN97IY+fBbP/e8xDGiIqkXZ7a21+zkH8SgOtiePOHwkDJcncg76ULA7cZEKui
	eZWoZ+VvffqvlVFnfGh0HTfXfH01o5SI5tB4IVOPUW+uD6HEBW+tnU27UUayjVRJ7+Cu4pIusPL
	ogeHODgNt/O8nVNgRl2T6fyvl8w2PH8=
X-Received: by 2002:a05:7022:3a83:b0:184:992:c9ec with SMTP id a92af1059eb24-1b55693aaabmr16447341c88.38.1795472028298;
        Mon, 23 Nov 2026 14:13:48 -0800 (PST)
Received: from [127.0.0.1] ([51.57.82.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm49762172c88.9.2026.11.23.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:13:47 -0800 (PST)
Message-Id: <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 22:13:41 +0000
Subject: [PATCH v2 0/5] Address overflows pointed out by Coverity
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Simon Richter <Simon.Richter@hogyros.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series is part of my effort to bring Git for Windows' Coverity
reports down to zero; Previous patch series have been merged in 347fe8a91b5
(Merge branch 'js/coverity-fixes', 2026-07-16), 0b75ef5168c (Merge branch
'js/coverity-fixes-null-safety', 2026-07-19), fcc8c931b53 (Merge branch
'js/coverity-unchecked-returns-fix', 2026-08-24) and 8bc9c7fcfd8 (Merge
branch 'js/coverity-fixes', 2026-10-03).

Changes since v1:

 * Most callers of read_in_full() and all callers of write_in_full() are now
   no longer restricted by the range of ssize_t.
 * The signed_mult_overflows() and mult_overflows() macros have been
   dropped.
 * Since the approxidate() function only deals with non-negative values, the
   complicated overflow check could been simplified.
 * Rebased to master, to avoid merge conflicts.

Johannes Schindelin (5):
  archive-tar: guard get_path_prefix against zero-length input
  http: use `size_t` for byte position in fwrite_sha1_file
  wrapper: avoid byte-count overflow in write_in_full()
  wrapper: add read_in_full_or_error()
  date: avoid overflow in approxidate relative-time multiplication

 Makefile                        |  1 +
 archive-tar.c                   |  2 +
 builtin/blame.c                 |  2 +-
 combine-diff.c                  |  6 +-
 date.c                          | 26 +++++++--
 dir.c                           |  2 +-
 grep.c                          |  2 +-
 http.c                          |  2 +-
 imap-send.c                     |  2 +-
 notes-merge.c                   | 13 +----
 refs/packed-backend.c           |  4 +-
 strbuf.c                        | 10 +++-
 t/meson.build                   |  1 +
 t/t0006-date.sh                 | 13 +++++
 t/unit-tests/u-reftable-stack.c |  2 +-
 t/unit-tests/u-wrapper.c        | 99 +++++++++++++++++++++++++++++++++
 wrapper.c                       | 56 ++++++++++++++-----
 wrapper.h                       | 14 ++++-
 18 files changed, 207 insertions(+), 50 deletions(-)
 create mode 100644 t/unit-tests/u-wrapper.c


base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2253%2Fdscho%2Fcoverity-fixes-overflow-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2253/dscho/coverity-fixes-overflow-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2253

Range-diff vs v1:

 1:  dcd319476a = 1:  bb8225547f archive-tar: guard get_path_prefix against zero-length input
 2:  70a909de18 ! 2:  38cc1dec53 http: use `size_t` for byte position in fwrite_sha1_file
     @@ Commit message
      
          Pointed out by Coverity.
      
     -    Assisted-by: Claude Opus 4.6
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Assisted-by: Claude Opus 4.6 and GPT-6.1 Sol
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## http.c ##
 3:  b1ed701935 < -:  ---------- wrapper: reject insanely large byte counts when reading/writing
 4:  3dcc3d9757 < -:  ---------- git-compat-util: add `signed_mult_overflows` and `mult_overflows` macros
 -:  ---------- > 3:  b24520c50d wrapper: avoid byte-count overflow in write_in_full()
 -:  ---------- > 4:  ca30ed613d wrapper: add read_in_full_or_error()
 5:  a4e602b9e7 ! 5:  6057734709 date: avoid overflow in approxidate relative-time multiplication
     @@ Metadata
       ## Commit message ##
          date: avoid overflow in approxidate relative-time multiplication
      
     -    The `approxidate_alpha()` function multiplies a time unit length (e.g.,
     -    604800 for weeks) by a user-supplied number to compute a time offset in
     -    seconds. Both operands are `int`, and the product is passed to
     -    `update_tm()` as `time_t`. For inputs like "99999 weeks ago", the int
     -    multiplication overflows (604800 * 99999 is roughly 60 billion, far
     -    beyond `INT_MAX`), producing a wrapped value that results in a wrong
     -    date.
     +    Parsing relative dates can overflow `int` when multiplying a value by a
     +    unit length, before converting the result to `time_t`. Signed overflow
     +    is undefined behavior, therefore checking the converted value is too
     +    late.
      
     -    Use the checked `time_t` multiplication so oversized products do not
     -    overflow or wrap around.
     -
     -    On platforms where `time_t` is unsigned (and where the pre-processor
     -    allows us to determine this fact), reject counts that are too large and
     -    report a parse error. Narrowing them first could otherwise produce
     -    negative or truncated values that become bogus offsets. Leave signed
     -    `time_t` count parsing unchanged.
     +    Reject quantities above `INT_MAX` before narrowing to `int` on all
     +    platforms. The inputs are non-negative, meaning that checking unsigned
     +    arithmetic is sufficient. The product must also fit the native `time_t`
     +    range. Report arithmetic or conversion failures as parse errors rather
     +    than saturating the offset.
      
          Pointed out by Coverity.
      
     -    Assisted-by: Claude Opus 4.6 and GPT-6.1 Sol
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     +    Assisted-by: Claude Opus 4.6 and GPT-6.1
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## date.c ##
     @@ date.c: static const char *approxidate_alpha(const char *date, struct tm *tm, st
       		size_t len = strlen(tl->type);
       		if (match_string(date, tl->type) >= len-1) {
      -			update_tm(tm, now, tl->length * *num);
     -+			time_t length = tl->length, num_t = *num;
     -+			time_t seconds;
     -+#ifndef is_unsigned_type
     ++			uintmax_t length = tl->length, num_t = *num, seconds;
     ++
     ++			if (unsigned_mult_overflows(length, num_t))
     ++				return NULL;
      +			seconds = length * num_t;
     -+#else
     -+			time_t max_val = is_unsigned_type(length)
     -+				? maximum_unsigned_value_of_type(length)
     -+				: maximum_signed_value_of_type(length);
     -+			seconds = mult_overflows(length, num_t)
     -+				? max_val : length * num_t;
     -+#endif
     -+			update_tm(tm, now, seconds);
     ++			if (date_overflows(seconds))
     ++				return NULL;
     ++			update_tm(tm, now, (time_t)seconds);
       			*num = 0;
       			*touched = 1;
       			return end;
     @@ date.c: static const char *approxidate_digit(const char *date, struct tm *tm, in
       	/* Accept zero-padding only for small numbers ("Dec 02", never "Dec 0002") */
      -	if (date[0] != '0' || end - date <= 2)
      +	if (date[0] != '0' || end - date <= 2) {
     -+#ifdef is_unsigned_type
     -+		if (is_unsigned_type((time_t)0) &&
     -+		    (number > INT_MAX ||
     -+		     number > maximum_unsigned_value_of_type((time_t)0)))
     ++		if (number > INT_MAX)
      +			return NULL;
     -+#endif
       		*num = number;
      +	}
       	return end;
       }
       
      @@ date.c: static timestamp_t approxidate_str(const char *date,
     - 		if (isdigit(c)) {
     + 		if (!c)
     + 			break;
     + 		date++;
     +-		if (isdigit(c)) {
     ++		if (isalpha(c))
     ++			date = approxidate_alpha(date-1, &tm, &now,
     ++						 &number, &touched);
     ++		else if (isdigit(c)) {
       			pending_number(&tm, &number);
       			date = approxidate_digit(date-1, &tm, &number, time_sec);
     -+			if (!date) {
     -+				*error_ret = 1;
     -+				return 0;
     -+			}
       			touched = 1;
     - 			continue;
     +-			continue;
       		}
     +-		if (isalpha(c))
     +-			date = approxidate_alpha(date-1, &tm, &now, &number, &touched);
     ++		if (!date) {
     ++			*error_ret = 1;
     ++			return 0;
     ++		}
     + 	}
     + 	pending_number(&tm, &number);
     + 	if (!touched)
     +
     + ## t/t0006-date.sh ##
     +@@ t/t0006-date.sh: check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
     + check_approxidate 3.months.ago '2009-05-30 19:20:00'
     + check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
     + 
     ++test_expect_success HAVE_64BIT_TIME 'parse a large number of weeks' '
     ++	echo "Jan 1 2099 4000 weeks ago -> 1651778400" >expect &&
     ++	test-tool date timestamp "Jan 1 2099 4000 weeks ago" >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success TIME_IS_64BIT 'reject a quantity that does not fit in int' '
     ++	git reflog expire --dry-run --all --expire="1 day 1 second ago" &&
     ++	test_must_fail git reflog expire --dry-run --all \
     ++		--expire="1 day 18446744073709551615 seconds ago" 2>err &&
     ++	test_grep "invalid timestamp" err
     ++'
     ++
     + check_approxidate '6am yesterday' '2009-08-29 06:00:00'
     + check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
     + check_approxidate '3:00' '2009-08-30 03:00:00'

-- 
gitgitgadget
