Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D7F4EC
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU+RxptP"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d60a96533so13311495e9.1
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 07:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703776225; x=1704381025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HIoGKp43y97ZuUQoX5PVlnUYAZlsMmw4ROoggLoFWTA=;
        b=eU+RxptPhCPaJaZYKHp2yqqoZYzsM3dXGFEHa9k14nFeEGtL0baALn9oWv8VE9aE7N
         N/92yxgDaPtdrmjeRGGo8Bo440TMGqqGJbb2zsqs2DRwWPYEyFCBDeRKlb52R+Cya9cT
         D4zQMq5baXHDtcBb8B00+l8HYRWxL2dxiMm+p7SFwCRgqJf6a89Om3ZQUOKzOYTYfpJd
         ercZbaumcxJaI0rm+aEXg12yLV7lPj+/yGpYW+raqtQxzpkT1BTlCeyr1KIrni8khimg
         47JEPMKn8owh4Wb3YKWBfvMnBfB4zRb41Pa/bBt0Q4NMOUQJvrCdirOGCjKStxnn3980
         oWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703776225; x=1704381025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIoGKp43y97ZuUQoX5PVlnUYAZlsMmw4ROoggLoFWTA=;
        b=AU0XH4c1AV0hSWbDJ0Sl+JhhqBJMClT5wkd8xwbdS3msV2F8TTSk2M859OBUuNr75w
         Dr1SaWmn9kOqLxtuGZmOJClUXS5PoZYnJF0jutPLdEHW+j3wp+kQzkeLZ9NhhKLg5NZS
         Z4R1yPdJKhvzt6TU+ihRNygDgNxACxCpBseUerY1yMWW6oXtTQmnxpmElPlv3YsaseGg
         sgWAf6Pq+u8CGSW8N/tUmVRXbmAY7/VhXnFlPRSWceQa9fipJWoORCiIkr3YqZ1WiCXt
         6EzSu9uqzYNFWU9IdrZTe6+pdJ3sVDY/y9xFVHv7lTa50aaBS1oY2Sm0gUY83v84tVeM
         JAsg==
X-Gm-Message-State: AOJu0YzvPNoKCY0g0gA7QDG+5BhIK7kiEvz8YPCUJpIm+TlRAKxSg9VN
	8GojM/nS6i9PZqzrBmVjHC8=
X-Google-Smtp-Source: AGHT+IEFAEVrD7Duf172IIbsbPn4CDNbQKt8+egtFGAaQy0Z9SeTQxihanipMYyLih9MoerPpE+gDg==
X-Received: by 2002:a05:600c:3d8d:b0:40d:5575:a18d with SMTP id bi13-20020a05600c3d8d00b0040d5575a18dmr3654863wmb.59.1703776224941;
        Thu, 28 Dec 2023 07:10:24 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b0040d3276ba19sm27821876wms.25.2023.12.28.07.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 07:10:23 -0800 (PST)
Message-ID: <9aad15c8-8d3b-475b-bd44-5d24121cb793@gmail.com>
Date: Thu, 28 Dec 2023 15:10:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] mem-pool: fix big allocations
Content-Language: en-US
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
Cc: Jameson Miller <jamill@microsoft.com>
References: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <fa89d269-1a23-4ed6-bebc-30c0b629f444@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 21/12/2023 23:13, René Scharfe wrote:
> +#define check_ptr(a, op, b) check_int(((a) op (b)), ==, 1)
> [...]
> +static void t_calloc_100(struct mem_pool *pool)
> +{
> +	size_t size = 100;
> +	char *buffer = mem_pool_calloc(pool, 1, size);
> +	for (size_t i = 0; i < size; i++)
> +		check_int(buffer[i], ==, 0);
> +	if (!check_ptr(pool->mp_block, !=, NULL))
> +		return;
> +	check_ptr(pool->mp_block->next_free, <=, pool->mp_block->end);
> +	check_ptr(pool->mp_block->next_free, !=, NULL);
> +	check_ptr(pool->mp_block->end, !=, NULL);
> +}

It's great to see the unit test framework being used here. I wonder
though if it would be simpler just to use

	check(ptr != NULL)

as I'm not sure what the check_ptr() macro adds. The diff at the end of
this email shows a possible implementation of a check_ptr() macro for
the unit test library. I'm wary of adding it though because I'm not sure
printing the pointer values is actually very useful most of the
time. I'm also concerned that the rules around pointer arithmetic and
comparisons mean that many pointer tests such as

     check_ptr(pool->mp_block->next_free, <=, pool->mp_block->end);

will be undefined if they fail. The documentation for check_ptr() below
tries to illustrate that concern. If the compiler can prove that a check
is undefined when that check fails it is at liberty to hard code the
test as passing. In practice I think most failing pointer comparisons
would fall into the category of "this is undefined but the compiler
can't prove it" but that doesn't really make me any happier.

Best Wishes

Phillip

---- >8 ----
diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index a8f07ae0b7..ecd1fce17d 100644
--- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -99,6 +99,39 @@ int check_int_loc(const char *loc, const char *check, int ok,
  int check_uint_loc(const char *loc, const char *check, int ok,
  		   uintmax_t a, uintmax_t b);
  
+/*
+ * Compare two pointers. Prints a message with the two values if the
+ * comparison fails. NB this is not thread safe.
+ *
+ * Use this with care. The rules around pointer arithmetic and comparison
+ * in C are quite strict and violating them results in undefined behavior
+ * To avoid a failing comparison resulting undefined behavior we compare
+ * the integer value of the pointers. While this avoids undefined
+ * behavior in the comparison in many cases a failing test will be the
+ * result of creating an invalid pointer in a way that violates the
+ * rules on pointer arithmetic. For example if `start` and `end` are
+ * pointers to the beginning and end of an allocation and `offset` is an
+ * integer then
+ *
+ *     check_ptr(start + offset, <=, end)
+ *
+ * is undefined when `offset` is larger than `end - start`. Rewriting the
+ * comparison as
+ *
+ *     check_uint(offset, <=, end - start)
+ *
+ * avoids undefined behavior when offset is too large, but is still
+ * undefined if there is a bug that means `start` and `end` do not point
+ * to the same allocation.
+ */
+#define check_ptr(a, op, b)						\
+	(test__tmp[0].p = (a), test__tmp[1].p = (b),			\
+	 check_ptr_loc(TEST_LOCATION(), #a" "#op" "#b,			\
+		       (uintptr_t)test__tmp[0].p op (uintptr_t)test__tmp[1].p,	\
+			test__tmp[0].p, test__tmp[1].p))
+
+int check_ptr_loc(const char *loc, const char *check, int ok, void *a, void *b);
+
  /*
   * Compare two chars. Prints a message with the two values if the
   * comparison fails. NB this is not thread safe.
@@ -133,6 +166,7 @@ int check_str_loc(const char *loc, const char *check,
  #define TEST__MAKE_LOCATION(line) __FILE__ ":" TEST__STR(line)
  
  union test__tmp {
+	void *p;
  	intmax_t i;
  	uintmax_t u;
  	char c;
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 7bf9dfdb95..cb757edbd8 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -311,6 +311,18 @@ int check_uint_loc(const char *loc, const char *check, int ok,
  	return ret;
  }
  
+int check_ptr_loc(const char *loc, const char *check, int ok, void *a, void *b)
+{
+	int ret = test_assert(loc, check, ok);
+
+	if (!ret) {
+		test_msg("   left: %p", a);
+		test_msg("  right: %p", b);
+	}
+
+	return ret;
+}
+
  static void print_one_char(char ch, char quote)
  {
  	if ((unsigned char)ch < 0x20u || ch == 0x7f) {
