Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD1D35959
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751171167; cv=none; b=hFCLw4pMCYxX9UY1yk2zkQagaIreJmvvKdcgFIipW++FGzU8HTNuz1TK4EmsNgovbJQ7VaYL0sd7pDaiSApSuhJCVy+mgu7xQ9lCf7AOr5pJHrG0c2ChLSQ2pV5f8LM6en1Hj9qvLRAhwHnVGM/GVD6vYxlWTK0nCc3KBAkIKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751171167; c=relaxed/simple;
	bh=Fs74Z1HHL7ePfVCGpp0AZRRUZyTZhOZuKH25SyVdvPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kul/rxwIoZz9MF+ZXXTWCChksR1/qn31rq1ZzcufGxbHdhLkp50xhhlWMhmthI6A492ssJ7TE0fMKpoKmJ0UIZ+LYWhd80kOfttW1nAun6hKQUrGMFbC6ViBgASOXZkt9KFg+em2YZjYQW+NjvpuIj8n7ZP3/Xb9YgQliviny0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBKgepSx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBKgepSx"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso3437067a12.3
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 21:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751171165; x=1751775965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKUzoBSCNd3IaGuSOF8GKh/5Pc6AhwjRtFp4FHZGOs8=;
        b=YBKgepSxRy0+IUWRcKghoRGEPYDYh+fnOC14u1iS+Kl57ztmbFexPhOmACuwXgJVQ6
         +NsoSMR3G8gJmlY88lsTp8KV57LrB2q/4oAFTQzw6KVr3As54siaySTAuVBFEHrltqYj
         SPa+90zjbAzPk3SINc9KKD8gSMEOWWczC+JRdiqCmf6LPyOVmlOwIhVegUOoeffkxGll
         iNTpoqgxSAq5X3l1lrklgX0oeNjccjtePfr6096mhWhsoH/+7qAOeQEnEBljg82V/Jss
         XLeMn86O0nIvYAUIc0qK54EtY5TuIghCqPvnBlTtsCDRZvK1SNTswqfVDasQ1Wq2xqc7
         CYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751171165; x=1751775965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKUzoBSCNd3IaGuSOF8GKh/5Pc6AhwjRtFp4FHZGOs8=;
        b=T+anSdnoyg59QhbN36gcgrfRAgVorjp7909K3JYQuyWLw0m7hDbYdg3yCiadTHCjEt
         pPL1y8bUnMvul1f3s9sTbN1caR9MmXOZppLU96O2j405ou0yTCtvAa3/4Ym11eggxwFh
         l3K6j7X5V78uI6tWy15/oC4rdKFu/S55WlEN1eadyIlNQU8sT59QV8Q7j0z+5iRr3dEA
         RDzsFMMve4lUSy/lzCg3hgr8Iy/MKDuhz5/jdBSXL6pKCnwlarmHUO27W/XdA4nm92GZ
         Bnk0KRvTPex13ZAY7i/3ok1A8N27FObrtglYQR5cFh0BSE6p9QSh/vQLk1Jp9lSb4wPD
         kPkg==
X-Gm-Message-State: AOJu0YxY2fiFQpFlhSo4oaBa7vla9fG0ABdS9NkRMkuoS8mhjFTpFU5E
	JjxJLkXL+sebCoteA6PEXPKaQlH3z6pO0dDKbEW8jKc+6OEdawRdGqVso5fqag==
X-Gm-Gg: ASbGncvkkx+SchHA7zTy8DY46IRJ7d/qvnctR+Zz8FB+7/w/04mYBtpFPXwbqcdncP2
	d0I+gd14UJnLRe9vZSKaFmC31OvmmTsH9NK3gkSAe/6LsTk48ipzy5qOt9OQZGb+jM3NovTvJBS
	QZ+yU2Rhb5Eravc7ZClDBcaJIawlZDjRHZHHF7bV+trFjFbJB/03C3fx2THDqDPH0+OY4FQGgdj
	mXdu0J0zkHu7o2yfh6gvEsfrhWlL5Wtvq3CYDSGTPLvqbmUPmGigv88hjzdcVNYzUhQ1WcGA+gb
	B8xW2s+KvHREd2yf+EmRScmUWyQqesuDJepfG0vqRPFB8qRweVEYLvhCxg==
X-Google-Smtp-Source: AGHT+IFKbPg6kNKIsI7u++KPkTmB34ftBTiDxJhNiUM5tdYA+CqECUUbKvsxxCe+ULmqXj7O8ilcSw==
X-Received: by 2002:a17:903:3c47:b0:234:bca7:292e with SMTP id d9443c01a7336-23ac40f0cc2mr141972445ad.14.1751171164725;
        Sat, 28 Jun 2025 21:26:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3af744sm49377035ad.157.2025.06.28.21.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 21:26:03 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:26:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 0/8] enhance "string_list" code and test
Message-ID: <aGDAZ6a0-PyXXGmK@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCoDB9P5XV1lHMil@ArchLinux>

Hi All:

I finally finish the version 2. And I don't provide the range-diff due
to that I add more commits compared with version 1.

This patch could be organized into three parts:

1. [PATCH v2 1/8]

   Fix simple sign warnings of the loop iterator.

2. [PATCH v2 2/8] - [PATCH v2 4/8]

   Remove unncessary code, improve the logic and finally enable sign
   compare warnings check.

3. [PATCH v2 5/8] - [PATCH v2 8/8]

   Remove test to the unit test.

---

Changes since v2:

1. [PATCH v3 1/8]: improve the commit message to explain that we would
   handle a warning in the later commits.
2. [PATCH v3 2/8] and [PATCH v2 3/8]: improve the commit message to add
   the history background.
3. [PATCH v3 4/8]: improve the commit message to show why the current
   bianry search algorithm introduces the sign warning and how to change
   it to fix the sign warning.
4. [PATCH v3 5/8] - [PATCH v3 8/8]: remove list into test helper instead
   of test itself for reducing the shared state.
5. [PATCH v3 8/8]: improve the commit message to say why we can't delete
   "test-tool string_list" totally.

Thanks,
Jialuo

shejialuo (8):
  string-list: fix sign compare warnings for loop iterator
  string-list: remove unused "insert_at" parameter from add_entry
  string-list: return index directly when inserting an existing element
  string-list: enable sign compare warnings check
  u-string-list: move "test_split" into "u-string-list.c"
  u-string-list: move "test_split_in_place" to "u-string-list.c"
  u-string-list: move "filter string" test to "u-string-list.c"
  u-string-list: move "remove duplicates" test to "u-string-list.c"

 Makefile                     |   1 +
 string-list.c                |  48 +++-----
 t/helper/test-string-list.c  |  96 ---------------
 t/meson.build                |   2 +-
 t/t0063-string-list.sh       | 142 ----------------------
 t/unit-tests/u-string-list.c | 227 +++++++++++++++++++++++++++++++++++
 6 files changed, 249 insertions(+), 267 deletions(-)
 delete mode 100755 t/t0063-string-list.sh
 create mode 100644 t/unit-tests/u-string-list.c

Range-diff against v2:
1:  4fb4546525 ! 1:  a69eb0f7b8 string-list: fix sign compare warnings for loop iterator
    @@ Metadata
      ## Commit message ##
         string-list: fix sign compare warnings for loop iterator
     
    -    In "string-list.c", there are six warnings which are emitted by
    -    "Wsign-compare". And five warnings are caused by the loop iterator type
    -    mismatch. Let's fix these five warnings by changing the `int` type to
    -    `size_t` type of the loop iterator.
    +    There are a couple of "-Wsign-compare" warnings in "string-list.c". Fix
    +    trivial ones that result from a mismatched loop iterator type.
    +
    +    There is a single warning left after these fixes. This warning needs
    +    a bit more care and is thus handled in subsequent commits.
     
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
2:  3721c92803 ! 2:  35550b3b7d string-list: remove unused "insert_at" parameter from add_entry
    @@ Commit message
     
         However, we only use "add_entry" in "string_list_insert" function and we
         always pass the "-1" for "insert_at" parameter. So, we never use this
    -    parameter to insert element in a user specified position. Let's delete
    -    this parameter. If there is any requirement later, we need to use a
    -    better way to do this.
    +    parameter to insert element in a user specified position.
    +
    +    And we should know why there is such code path in the first place. We
    +    used to have another function "string_list_insert_at_index()", which
    +    uses the extra "insert_at" parameter. And in f8c4ab611a (string_list:
    +    remove string_list_insert_at_index() from its API, 2014-11-24), we
    +    remove this function but we don't clean all the code path.
    +
    +    Let's simply delete this parameter as we'd better use "strmap" for such
    +    functionality.
     
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
3:  fa1d22c93d ! 3:  7877b528e4 string-list: return index directly when inserting an existing element
    @@ Commit message
     
         When inserting an existing element, "add_entry" would convert "index"
         value to "-1-index" to indicate the caller that this element is in the
    -    list already.
    +    list already. However, in "string_list_insert", we would simply convert
    +    this to the original positive index without any further action.
     
    -    However, in "string_list_insert", we would simply convert this to the
    -    original positive index without any further action. Let's directly
    -    return the index as we don't care about whether the element is in the
    -    list by using "add_entry".
    +    In 8fd2cb4069 (Extract helper bits from c-merge-recursive work,
    +    2006-07-25), we create "path-list.c" and then introduce above code path.
     
    -    In the future, if we want to let "add_entry" tell the caller, we may add
    -    "int *exact_match" parameter to "add_entry" instead of converting the
    -    index to negative to indicate.
    +    Let's directly return the index as we don't care about whether the
    +    element is in the list by using "add_entry". In the future, if we want
    +    to let "add_entry" tell the caller, we may add "int *exact_match"
    +    parameter to "add_entry" instead of converting the index to negative to
    +    indicate.
     
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
4:  02e5c4307b ! 4:  50c4dbff5c string-list: enable sign compare warnings check
    @@ Metadata
      ## Commit message ##
         string-list: enable sign compare warnings check
     
    -    The only sign compare warning in "string-list" is that we compare the
    -    `index` of the `int` type with the `list->nr` of unsigned type. We get
    -    index by calling "get_entry_index", which would always return unsigned
    -    index.
    +    In "add_entry", we call "get_entry_index" function to get the inserted
    +    position. However, as the return type of "get_entry_index" function is
    +    `int`, there is a sign compare warning when comparing the `index` with
    +    the `list-nr` of unsigned type.
     
    -    Let's change the return type of "get_entry_index" to be "size_t" by
    -    slightly modifying the binary search algorithm. Instead of letting
    -    "left" to be "-1" initially, assign 0 to it.
    +    "get_entry_index" would always return unsigned index. However, the
    +    current binary search algorithm initializes "left" to be "-1", which
    +    necessitates the use of signed `int` return type.
    +
    +    The reason why we need to assign "left" to be "-1" is that in the
    +    `while` loop, we increment "left" by 1 to determine whether the loop
    +    should end. This design choice, while functional, forces us to use
    +    signed arithmetic throughout the function.
    +
    +    To resolve this sign comparison issue, let's modify the binary search
    +    algorithm with the following approach:
    +
    +    1. Initialize "left" to 0 instead of -1
    +    2. Use `left < right` as the loop termination condition instead of
    +       `left + 1 < right`
    +    3. When searching the right part, set `left = middle + 1` instead of
    +       `middle`
     
         Then, we could delete "#define DISABLE_SIGN_COMPARE_WARNING" to enable
    -    sign warnings check for "string-list"
    +    sign warnings check for "string-list".
     
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
5:  990ce4db0f ! 5:  ab2aec5887 u-string-list: move "test_split" into "u-string-list.c"
    @@ t/unit-tests/u-string-list.c (new)
     +		string_list_append(list, arg);
     +}
     +
    -+static void t_string_list_clear(struct string_list *list, int free_util)
    -+{
    -+	string_list_clear(list, free_util);
    -+	cl_assert_equal_p(list->items, NULL);
    -+	cl_assert_equal_i(list->nr, 0);
    -+	cl_assert_equal_i(list->alloc, 0);
    -+}
    -+
     +static void t_string_list_equal(struct string_list *list,
     +				struct string_list *expected_strings)
     +{
    @@ t/unit-tests/u-string-list.c (new)
     +				  expected_strings->items[i].string);
     +}
     +
    -+static void t_string_list_split(struct string_list *list, const char *data,
    -+				int delim, int maxsplit, ...)
    ++static void t_string_list_split(const char *data, int delim, int maxsplit, ...)
     +{
     +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
    ++	struct string_list list = STRING_LIST_INIT_DUP;
     +	va_list ap;
     +	int len;
     +
    @@ t/unit-tests/u-string-list.c (new)
     +	t_vcreate_string_list_dup(&expected_strings, 0, ap);
     +	va_end(ap);
     +
    -+	string_list_clear(list, 0);
    -+	len = string_list_split(list, data, delim, maxsplit);
    ++	string_list_clear(&list, 0);
    ++	len = string_list_split(&list, data, delim, maxsplit);
     +	cl_assert_equal_i(len, expected_strings.nr);
    -+	t_string_list_equal(list, &expected_strings);
    ++	t_string_list_equal(&list, &expected_strings);
     +
     +	string_list_clear(&expected_strings, 0);
    ++	string_list_clear(&list, 0);
     +}
     +
     +void test_string_list__split(void)
     +{
    -+	struct string_list list = STRING_LIST_INIT_DUP;
    -+
    -+	t_string_list_split(&list, "foo:bar:baz", ':', -1, "foo", "bar", "baz", NULL);
    -+	t_string_list_split(&list, "foo:bar:baz", ':', 0, "foo:bar:baz", NULL);
    -+	t_string_list_split(&list, "foo:bar:baz", ':', 1, "foo", "bar:baz", NULL);
    -+	t_string_list_split(&list, "foo:bar:baz", ':', 2, "foo", "bar", "baz", NULL);
    -+	t_string_list_split(&list, "foo:bar:", ':', -1, "foo", "bar", "", NULL);
    -+	t_string_list_split(&list, "", ':', -1, "", NULL);
    -+	t_string_list_split(&list, ":", ':', -1, "", "", NULL);
    -+
    -+	t_string_list_clear(&list, 0);
    ++	t_string_list_split("foo:bar:baz", ':', -1, "foo", "bar", "baz", NULL);
    ++	t_string_list_split("foo:bar:baz", ':', 0, "foo:bar:baz", NULL);
    ++	t_string_list_split("foo:bar:baz", ':', 1, "foo", "bar:baz", NULL);
    ++	t_string_list_split("foo:bar:baz", ':', 2, "foo", "bar", "baz", NULL);
    ++	t_string_list_split("foo:bar:", ':', -1, "foo", "bar", "", NULL);
    ++	t_string_list_split("", ':', -1, "", NULL);
    ++	t_string_list_split(":", ':', -1, "", "", NULL);
     +}
6:  5a02f590df ! 6:  06aca89b57 u-string-list: move "test_split_in_place" to "u-string-list.c"
    @@ t/t0063-string-list.sh: test_description='Test string list functionality'
     
      ## t/unit-tests/u-string-list.c ##
     @@ t/unit-tests/u-string-list.c: void test_string_list__split(void)
    - 
    - 	t_string_list_clear(&list, 0);
    + 	t_string_list_split("", ':', -1, "", NULL);
    + 	t_string_list_split(":", ':', -1, "", "", NULL);
      }
     +
    -+static void t_string_list_split_in_place(struct string_list *list, const char *data,
    -+					 const char *delim, int maxsplit, ...)
    ++static void t_string_list_split_in_place(const char *data, const char *delim,
    ++					 int maxsplit, ...)
     +{
     +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
    ++	struct string_list list = STRING_LIST_INIT_NODUP;
     +	char *string = xstrdup(data);
     +	va_list ap;
     +	int len;
    @@ t/unit-tests/u-string-list.c: void test_string_list__split(void)
     +	t_vcreate_string_list_dup(&expected_strings, 0, ap);
     +	va_end(ap);
     +
    -+	string_list_clear(list, 0);
    -+	len = string_list_split_in_place(list, string, delim, maxsplit);
    ++	string_list_clear(&list, 0);
    ++	len = string_list_split_in_place(&list, string, delim, maxsplit);
     +	cl_assert_equal_i(len, expected_strings.nr);
    -+	t_string_list_equal(list, &expected_strings);
    ++	t_string_list_equal(&list, &expected_strings);
     +
     +	free(string);
     +	string_list_clear(&expected_strings, 0);
    ++	string_list_clear(&list, 0);
     +}
     +
     +void test_string_list__split_in_place(void)
     +{
    -+	struct string_list list = STRING_LIST_INIT_NODUP;
    -+
    -+	t_string_list_split_in_place(&list, "foo:;:bar:;:baz:;:", ":;", -1,
    ++	t_string_list_split_in_place("foo:;:bar:;:baz:;:", ":;", -1,
     +				     "foo", "", "", "bar", "", "", "baz", "", "", "", NULL);
    -+	t_string_list_split_in_place(&list, "foo:;:bar:;:baz", ":;", 0,
    ++	t_string_list_split_in_place("foo:;:bar:;:baz", ":;", 0,
     +				     "foo:;:bar:;:baz", NULL);
    -+	t_string_list_split_in_place(&list, "foo:;:bar:;:baz", ":;", 1,
    ++	t_string_list_split_in_place("foo:;:bar:;:baz", ":;", 1,
     +				     "foo", ";:bar:;:baz", NULL);
    -+	t_string_list_split_in_place(&list, "foo:;:bar:;:baz", ":;", 2,
    ++	t_string_list_split_in_place("foo:;:bar:;:baz", ":;", 2,
     +				     "foo", "", ":bar:;:baz", NULL);
    -+	t_string_list_split_in_place(&list, "foo:;:bar:;:", ":;", -1,
    ++	t_string_list_split_in_place("foo:;:bar:;:", ":;", -1,
     +				     "foo", "", "", "bar", "", "", "", NULL);
    -+
    -+	t_string_list_clear(&list, 0);
     +}
7:  87a6ec722d ! 7:  4cc76a6fb4 u-string-list: move "filter string" test to "u-string-list.c"
    @@ t/unit-tests/u-string-list.c: static void t_vcreate_string_list_dup(struct strin
     +	va_end(ap);
     +}
     +
    - static void t_string_list_clear(struct string_list *list, int free_util)
    ++static void t_string_list_clear(struct string_list *list, int free_util)
    ++{
    ++	string_list_clear(list, free_util);
    ++	cl_assert_equal_p(list->items, NULL);
    ++	cl_assert_equal_i(list->nr, 0);
    ++	cl_assert_equal_i(list->alloc, 0);
    ++}
    ++
    + static void t_string_list_equal(struct string_list *list,
    + 				struct string_list *expected_strings)
      {
    - 	string_list_clear(list, free_util);
     @@ t/unit-tests/u-string-list.c: void test_string_list__split_in_place(void)
    - 
    - 	t_string_list_clear(&list, 0);
    + 	t_string_list_split_in_place("foo:;:bar:;:", ":;", -1,
    + 				     "foo", "", "", "bar", "", "", "", NULL);
      }
     +
     +static int prefix_cb(struct string_list_item *item, void *cb_data)
    @@ t/unit-tests/u-string-list.c: void test_string_list__split_in_place(void)
     +	return starts_with(item->string, prefix);
     +}
     +
    -+static void t_string_list_filter(struct string_list *list,
    -+				 string_list_each_func_t want, void *cb_data, ...)
    ++static void t_string_list_filter(struct string_list *list, ...)
     +{
     +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
    ++	const char *prefix = "y";
     +	va_list ap;
     +
    -+	va_start(ap, cb_data);
    ++	va_start(ap, list);
     +	t_vcreate_string_list_dup(&expected_strings, 0, ap);
     +	va_end(ap);
     +
    -+	filter_string_list(list, 0, want, cb_data);
    ++	filter_string_list(list, 0, prefix_cb, (void *)prefix);
     +	t_string_list_equal(list, &expected_strings);
     +
     +	string_list_clear(&expected_strings, 0);
    @@ t/unit-tests/u-string-list.c: void test_string_list__split_in_place(void)
     +void test_string_list__filter(void)
     +{
     +	struct string_list list = STRING_LIST_INIT_DUP;
    -+	const char *prefix = "y";
     +
     +	t_create_string_list_dup(&list, 0, NULL);
    -+	t_string_list_filter(&list, prefix_cb, (void*)prefix, NULL);
    ++	t_string_list_filter(&list, NULL);
     +
     +	t_create_string_list_dup(&list, 0, "no", NULL);
    -+	t_string_list_filter(&list, prefix_cb, (void*)prefix, NULL);
    ++	t_string_list_filter(&list, NULL);
     +
     +	t_create_string_list_dup(&list, 0, "yes", NULL);
    -+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "yes", NULL);
    ++	t_string_list_filter(&list, "yes", NULL);
     +
     +	t_create_string_list_dup(&list, 0, "no", "yes", NULL);
    -+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "yes", NULL);
    ++	t_string_list_filter(&list, "yes", NULL);
     +
     +	t_create_string_list_dup(&list, 0, "yes", "no", NULL);
    -+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "yes", NULL);
    ++	t_string_list_filter(&list, "yes", NULL);
     +
     +	t_create_string_list_dup(&list, 0, "y1", "y2", NULL);
    -+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "y1", "y2", NULL);
    ++	t_string_list_filter(&list, "y1", "y2", NULL);
     +
     +	t_create_string_list_dup(&list, 0, "y2", "y1", NULL);
    -+	t_string_list_filter(&list, prefix_cb, (void*)prefix, "y2", "y1", NULL);
    ++	t_string_list_filter(&list, "y2", "y1", NULL);
     +
     +	t_create_string_list_dup(&list, 0, "x1", "x2", NULL);
    -+	t_string_list_filter(&list, prefix_cb, (void*)prefix, NULL);
    ++	t_string_list_filter(&list, NULL);
     +
     +	t_string_list_clear(&list, 0);
     +}
8:  55269e7fcb ! 8:  b608047d40 u-string-list: move "remove duplicates" test to "u-string-list.c"
    @@ Commit message
         Also we could simply remove "DISABLE_SIGN_COMPARE_WARNINGS" due to we
         have already deleted related code.
     
    +    Unfortunately, we cannot totally remove "test-string-list.c" due to that
    +    we would test the performance of sorting about string list by executing
    +    "test-tool string-list sort" in "p0071-sort.sh".
    +
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
      ## t/helper/test-string-list.c ##
-- 
2.50.0

