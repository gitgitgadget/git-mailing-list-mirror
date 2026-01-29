Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD137FF72
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688868; cv=pass; b=YTu/Rc/fRYB8YkZ6/7yKtk472FfaR69zctfCLZOa8p2PhDrwnXcTdNDQZZE8LMvnzarKZjEmX+n+KEAVsnHDRRuq816Yw162eEsrWlAdc+0Zi8oPBygPufXFSIOu0nXUfBokW8iqzHz/qi686IggQOZw97HdmbH4s5wPGUSD/WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688868; c=relaxed/simple;
	bh=5ZhzwhkJW1cuKIhz2JIePEBcU7EWVZF4IMcJT9fyLKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoAV4nlesQMsT7dZSf4x4NoFiWXDZPpfyJEW9sxpdxRv3KdA+hzxokUvuv4afq7TgNY/yVEquO0IID+my67by3/kXghWMWPSLgv/816U2xIbmVYTHUEbO7gy5F8a0J2uZpkOcGTR3TdRSH2ylfFqad9vZHBwsLd7KMv3B+7hO+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9lWJ8i6; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9lWJ8i6"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79495b1aaa7so4506157b3.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 04:14:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769688866; cv=none;
        d=google.com; s=arc-20240605;
        b=VwGtvGKyL8FR/ew+vmdP9jm6q4f0Jk4NSTKdL+1qtez73rzAmVVUUbBN7wWT/jC4QA
         Wcb6zlt/y2usu4ApSMHzyccWrQZ1/H9l8EuTKhfE5u8BI7KCbv7+/yVxwPygJFHJgmm6
         srcbPD82shdq6rQtbXTrHiOLdT6ezwSoai44cEjdkbpzjNXvjIocM/sUdn3GaMBED7UZ
         hNxnZUzCgag918I3TP32wBG/J6XKxRJ7Bs2WPyTgnah5goKKrAvkXohqjnxoZb2zrj15
         Kqd6vmcf25x1VUs6uE3awPGpO5yO7xoDedeO9KPkQvgJkt857gHw5+7/CFMvqgYqjXAC
         bNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ApjXXaxT9kCX2/VfcyW7iaMYB3LUbXbjeUtuyuJg2jI=;
        fh=aziwdFByzEBA9Efkz1zTINAfytEihKd945UWwfzqmXM=;
        b=Iwxomr8wG95JpcPd9A5sIodsfyrmPZK8E3uULC0phSnvXPNlHdpJhSSsuhJFC9lTfL
         Vx6HkvKLEOg7BKQSRmnCXm2LMjHA1QTdJVskdr348OcHtipdIsPnMCaJvwHMIiyEgBrz
         rmOFHjcl+MKvLyoprXttPMHeBz0SL2xE5HbLUhIyPc7JYZxJrYHyXOTk3OKW0tJT0m9L
         OvCbSRY9Xnwz6TURDShp+625vnIYXTMPGO88kgz6dg/HipLYkUaDCRIdXaHzY0BFgF8u
         JbbQGjbxP7C3tKETSA8Jw5mZEEdtHN85UZ5rp2WFO5UgB7syfoUZnyAXr3FEsmoMBK1h
         1GPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769688866; x=1770293666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ApjXXaxT9kCX2/VfcyW7iaMYB3LUbXbjeUtuyuJg2jI=;
        b=C9lWJ8i6AV9xKHY57F5YqF90pvzgveT8rqwtaKHnDogPuVS9uzReYoLHyvVgigoOy0
         6pJCnkG1N74MrB7DeKJqESc0qc5eva4BPbY1lGKoiUb7zEKinUYbFamgEPhpY0xS0s9n
         ZVfEkcdT2A729e6nXCxkEkALfbmD8ExRsnp+1Y2PP8mJWll30QtAlkeAv7RAwyf9EeRs
         /ybSgicHroA5YPa++edoHWokh2Nmni1UAWfK8uhfdzbLskHj0IyrlA9FswQ08YKUm9Hb
         8wF8hH35gjm0SmuI/2wDXatTldbCVCDTlMh9jdh0jUJl4+hDnf4m0tl9GfHeGoPIM9iQ
         r2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769688866; x=1770293666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApjXXaxT9kCX2/VfcyW7iaMYB3LUbXbjeUtuyuJg2jI=;
        b=LtNIS8SX9uBCCIUlZrx1dt1m8/qi0Lvneh2osdbrlzL1vZstcYTnboSsfpNopYqGpY
         DYLBF4O99oIcGhYlww7L/HQ/J5J1nRzmj0FmUbzYpPg9Jn5Wrf9aYFGw8kujEi7CHTqk
         KbD6dSCbRHRCiZlHOgC22zoiTtWCqnHcQeeSHdsirw5Xj7ARiKzKyjzzKRuchgbgEgMC
         ZruE8wbJc3EHFijPoWx9JVAaBFWHbTiaw3ETxhNzCAybfsuSuCJJmB+bqvHGxD0MRL1H
         lGXnGUh1JayC+tFYnmHURTf0njmwd+DC5A+z6KZCuB6EIYYTlweLN8hMKX/kpTUwS1qT
         FxDQ==
X-Gm-Message-State: AOJu0Yx25YptTt6zituuZqIuYyd4TPsO7Cok/GPM2PcZQQRc/FTCPj8J
	pceXd81CY5UfHIXM5FQ8Bkx+Kkf0ZF+g5NI9Kwe/bovnKBe1E293ojygJTDywjic3e3++AziGj3
	UIuDJjUFdnBwHtGuwfUwwk0W2/Lv3EsuO7ml3
X-Gm-Gg: AZuq6aJ/CLdgCN0f9KSaIFvjKtOa4M7KRNWtLaPJsJBPzxaAeOLtulDaISn6RPGI6lP
	mL7qo42L0AHcnmkJCdINZK4/H0cZ+IiIbaRYJaq9C9RiSPBOf1JGoqBqqSK+WhZ3xBoQ6gG2RIA
	xDeW7tqSL6+qKLOaG/Yq2NnA8pZzn0V4gFLDJGbt4LUQIIekUmr3whRkpPA4IR2UDUGfBWj85Fy
	lUEMVlRaXfso6EIocQSHlZR13HTrSWQ/RuaMBArCi4ITrCSNhW4cy8rcQg12K74dM8W0yagAL17
	fVS6daMLRTUdGsKkvmTRb93tsg==
X-Received: by 2002:a05:690e:1188:b0:649:6139:b80c with SMTP id
 956f58d0204a3-6498fc3fddfmr6105979d50.45.1769688865569; Thu, 29 Jan 2026
 04:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125201500.63904-2-amishhhaaaa@gmail.com> <20260129121220.69267-1-amishhhaaaa@gmail.com>
In-Reply-To: <20260129121220.69267-1-amishhhaaaa@gmail.com>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Thu, 29 Jan 2026 17:44:14 +0530
X-Gm-Features: AZwV_QiioLJdZPkHsQcnKznadQyAySumLGRmslDQhW4Wxb92hIZ5JZx5CL4P2S4
Message-ID: <CAPvEtrcHVaz_aROXhzomCkmgn6OyoSHnhnrc-tAZD+V79oOsTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] u-string-list: add unit tests for string-list methods
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Jan 2026 at 17:42, Amisha Chhajed <amishhhaaaa@gmail.com> wrote:
>
> Unit tests in u-string-list.c does not cover several methods
> in string-list, this gap in coverage makes it difficult to
> ensure no regressions are introduced in future changes.
>
> Add unit tests for the following methods to enhance coverage:
> string_list_remove_empty_items()
> unsorted_string_list_has_string()
> unsorted_string_list_delete_item()
> string_list_has_string()
> string_list_insert()
> string_list_sort()
> string_list_remove()
>
> Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> ---
>  t/unit-tests/u-string-list.c | 209 +++++++++++++++++++++++++++++++++++
>  1 file changed, 209 insertions(+)
>
> diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> index a2457d7b1e..d469a06eca 100644
> --- a/t/unit-tests/u-string-list.c
> +++ b/t/unit-tests/u-string-list.c
> @@ -243,6 +243,138 @@ void test_string_list__filter(void)
>         t_string_list_clear(&list, 0);
>  }
>
> +static void t_string_list_has_string(
> +       struct string_list *list,
> +       const char *string,
> +       int expected)
> +{
> +       int has_string = string_list_has_string(list, string);
> +       cl_assert_equal_i(has_string, expected);
> +}
> +
> +void test_string_list__has_string(void)
> +{
> +       struct string_list list = STRING_LIST_INIT_DUP;
> +
> +       t_create_string_list_dup(&list, 0, NULL);
> +       t_string_list_has_string(&list, "", 0);
> +
> +       t_create_string_list_dup(&list, 0, "a", "b", "c", NULL);
> +       t_string_list_has_string(&list, "a", 1);
> +       t_string_list_has_string(&list, "b", 1);
> +       t_string_list_has_string(&list, "c", 1);
> +       t_string_list_has_string(&list, "d", 0);
> +
> +       t_string_list_clear(&list, 0);
> +}
> +
> +static void t_string_list_insert(struct string_list *expected_strings, ...)
> +{
> +       struct string_list strings_to_insert = STRING_LIST_INIT_DUP;
> +       struct string_list list = STRING_LIST_INIT_DUP;
> +       va_list ap;
> +
> +       va_start(ap, expected_strings);
> +       t_vcreate_string_list_dup(&strings_to_insert, 0, ap);
> +       va_end(ap);
> +
> +       for (size_t i = 0; i < strings_to_insert.nr; i++)
> +               string_list_insert(&list, strings_to_insert.items[i].string);
> +
> +       t_string_list_equal(&list, expected_strings);
> +
> +       string_list_clear(&strings_to_insert, 0);
> +       string_list_clear(&list, 0);
> +}
> +
> +void test_string_list__insert(void)
> +{
> +       struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +
> +       t_create_string_list_dup(&expected_strings, 0, NULL);
> +       t_string_list_insert(&expected_strings, NULL);
> +
> +       t_create_string_list_dup(&expected_strings, 0, "a", "b", NULL);
> +       t_string_list_insert(&expected_strings, "b", "a", "a", "b", NULL);
> +
> +       t_create_string_list_dup(&expected_strings, 0, "a", "b", "c", NULL);
> +       t_string_list_insert(&expected_strings, "c", "b", "a", "c", "b", NULL);
> +
> +       t_create_string_list_dup(&expected_strings, 0, "", "a", NULL);
> +       t_string_list_insert(&expected_strings, "a", "a", "a", "", NULL);
> +
> +       t_string_list_clear(&expected_strings, 0);
> +}
> +
> +static void t_string_list_sort(struct string_list *list, ...)
> +{
> +       struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +       va_list ap;
> +
> +       va_start(ap, list);
> +       t_vcreate_string_list_dup(&expected_strings, 0, ap);
> +       va_end(ap);
> +
> +       string_list_sort(list);
> +       t_string_list_equal(list, &expected_strings);
> +
> +       string_list_clear(&expected_strings, 0);
> +}
> +
> +void test_string_list__sort(void)
> +{
> +       struct string_list list = STRING_LIST_INIT_DUP;
> +
> +       t_create_string_list_dup(&list, 0, NULL);
> +       t_string_list_sort(&list, NULL);
> +
> +       t_create_string_list_dup(&list, 0, "b", "", "a", NULL);
> +       t_string_list_sort(&list, "", "a", "b", NULL);
> +
> +       t_create_string_list_dup(&list, 0, "c", "a", "b", "a", NULL);
> +       t_string_list_sort(&list, "a", "a", "b", "c", NULL);
> +
> +       t_string_list_clear(&list, 0);
> +}
> +
> +static void t_string_list_remove(
> +       struct string_list *expected_strings,
> +       struct string_list *list,
> +       char const *str)
> +{
> +       string_list_remove(list, str, 0);
> +       t_string_list_equal(list, expected_strings);
> +}
> +
> +void test_string_list__remove(void)
> +{
> +       struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +       struct string_list list = STRING_LIST_INIT_DUP;
> +
> +       t_create_string_list_dup(&expected_strings, 0, NULL);
> +       t_create_string_list_dup(&list, 0, NULL);
> +       t_string_list_remove(&expected_strings, &list, "");
> +
> +       t_create_string_list_dup(&expected_strings, 0, "a", NULL);
> +       t_create_string_list_dup(&list, 0, "a", "a", NULL);
> +       t_string_list_remove(&expected_strings, &list, "a");
> +
> +       t_create_string_list_dup(&expected_strings, 0, "a", "b", "b", NULL);
> +       t_create_string_list_dup(&list, 0, "a", "b", "b", "c", NULL);
> +       t_string_list_remove(&expected_strings, &list, "c");
> +
> +       t_create_string_list_dup(&expected_strings, 0, "a", "b", "d", NULL);
> +       t_create_string_list_dup(&list, 0, "a", "b", "c", "d", NULL);
> +       t_string_list_remove(&expected_strings, &list, "c");
> +
> +       t_create_string_list_dup(&expected_strings, 0, "a", "b", "c", "d", NULL);
> +       t_create_string_list_dup(&list, 0, "a", "b", "c", "d", NULL);
> +       t_string_list_remove(&expected_strings, &list, "e");
> +
> +       t_string_list_clear(&expected_strings, 0);
> +       t_string_list_clear(&list, 0);
> +}
> +
>  static void t_string_list_remove_duplicates(struct string_list *list, ...)
>  {
>         struct string_list expected_strings = STRING_LIST_INIT_DUP;
> @@ -304,3 +436,80 @@ void test_string_list__remove_duplicates(void)
>
>         t_string_list_clear(&list, 0);
>  }
> +
> +static void t_string_list_remove_empty_items(
> +       struct string_list *expected_strings,
> +       struct string_list *list)
> +{
> +       string_list_remove_empty_items(list, 0);
> +       t_string_list_equal(list, expected_strings);
> +}
> +
> +void test_string_list__remove_empty_items(void)
> +{
> +       struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +       struct string_list list = STRING_LIST_INIT_DUP;
> +
> +       t_create_string_list_dup(&expected_strings, 0, NULL);
> +       t_create_string_list_dup(&list, 0, "", "", "", NULL);
> +       t_string_list_remove_empty_items(&expected_strings, &list);
> +
> +       t_create_string_list_dup(&expected_strings, 0, "a", "b", NULL);
> +       t_create_string_list_dup(&list, 0, "a", "", "b", "", NULL);
> +       t_string_list_remove_empty_items(&expected_strings, &list);
> +
> +       t_string_list_clear(&expected_strings, 0);
> +       t_string_list_clear(&list, 0);
> +}
> +
> +static void t_string_list_unsorted_string_list_has_string(
> +       struct string_list *list,
> +       const char *str, int expected)
> +{
> +       int has_string = unsorted_string_list_has_string(list, str);
> +       cl_assert_equal_i(has_string, expected);
> +}
> +
> +void test_string_list__unsorted_string_list_has_string(void)
> +{
> +       struct string_list list = STRING_LIST_INIT_DUP;
> +
> +       t_create_string_list_dup(&list, 0, "b", "d", "a", NULL);
> +       t_string_list_unsorted_string_list_has_string(&list, "a", 1);
> +       t_string_list_unsorted_string_list_has_string(&list, "b", 1);
> +       t_string_list_unsorted_string_list_has_string(&list, "c", 0);
> +       t_string_list_unsorted_string_list_has_string(&list, "d", 1);
> +
> +       t_string_list_clear(&list, 0);
> +}
> +
> +static void t_string_list_unsorted_string_list_delete_item(
> +       struct string_list *expected_list,
> +       struct string_list *list,
> +       int i)
> +{
> +       unsorted_string_list_delete_item(list, i, 0);
> +
> +       t_string_list_equal(list, expected_list);
> +}
> +
> +void test_string_list__unsorted_string_list_delete_item(void)
> +{
> +       struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +       struct string_list list = STRING_LIST_INIT_DUP;
> +
> +       t_create_string_list_dup(&expected_strings, 0, "a", "c", "b", NULL);
> +       t_create_string_list_dup(&list, 0, "a", "d", "b", "c", NULL);
> +       t_string_list_unsorted_string_list_delete_item(&expected_strings, &list, 1);
> +
> +       t_create_string_list_dup(&expected_strings, 0, NULL);
> +       t_create_string_list_dup(&list, 0, "", NULL);
> +       t_string_list_unsorted_string_list_delete_item(&expected_strings, &list, 0);
> +
> +       t_create_string_list_dup(&expected_strings, 0, "a", "d", "c", "b", NULL);
> +       t_create_string_list_dup(&list, 0,  "a", "d", "c", "b", "d", NULL);
> +       t_string_list_unsorted_string_list_delete_item(&expected_strings, &list, 4);
> +
> +       t_string_list_clear(&expected_strings, 0);
> +       t_string_list_clear(&list, 0);
> +}
> --
> 2.51.0
>
Fixed extra EOF lines and overlong lines in v3.
