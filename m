Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7291DFFC
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728832857; cv=none; b=pZRiR6nhraXUsfRhG4OnXHTCgZESXgGdVj12ChnRrRU8eSzkgbp0Noiwd1dHcXcHbJKsjKkgDy0BO+j4ZccBQFk3dCr+nYPy4KQ7M2ErgQyUt22mZFwzTS99QwTXMaovoXWcB3nJgFhZFJjrT73sRcksWSBylYrTuLeTlaOpRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728832857; c=relaxed/simple;
	bh=QKAKnDMrT5FYhyIZy3LRyJTsiM5BfXKSSCblfeKUL7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AD9eGtAiKyapv37WRtciD9USwWBAeJIT6EagrZBCrNrKtqPD7zb4dIZ/IhOhGJvCcvlx2e4YSeFdBANDExc1jKXesmBsB6zActe2xXFUBa52NeParvXdJkd+jh02L+2WubZzxLrBMYH+JxTiqV6m24OAkkjNSQ9coMFx4QkVZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eq+tN6sX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq+tN6sX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so40186525e9.3
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728832854; x=1729437654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h258N+BileuHcyvVCtqEs/A3pVXUJDlsaS8AhsKU3tw=;
        b=eq+tN6sXDmMYCZv8O5pRzJRKSg89lzW9ljqw6mEjArZhmYKBMEnDOCGpadXg7UkI5t
         dUvN6NolS38JgCpHIA07WM6afNzoAhHlkvJC6kzPcXEagYbwK/Qy4FJHnl+gckHybR/p
         DGeOgipNTYYx31BPI27j+YVqAJOUIeRjWCMc3vDiNzQYBRPCEzv64RTdlox33ZkleUry
         fMLHFwMfASWMWAbmBVqs2C/TIXSH0TxK7bCcxGIEoKZsUR9/h65HOchZ4CFH0qQ3S0Ya
         IOis6zix5ISuy0lf/8uy6ma7lpZoW142YLi8dPIqzLxF52E5YRtIVEUHbYQghdUK+DU5
         IlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728832854; x=1729437654;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h258N+BileuHcyvVCtqEs/A3pVXUJDlsaS8AhsKU3tw=;
        b=kBIxBjq5NofknlIc4KdfFhNT4cn4dN0XQ4Pp2qAc5AMv6Lgkbnx0Jr5XGTJyT3EFg6
         4oB6MwODAcZ7z5swD9yLctlJWD4z9oVNbwekSEER4G8UYG4sKlLwNhItlVOP7BW9zLjE
         bYpyULe01GCVBvmBMxmI4tErScrsi9Nqij1gndGqjwCSQAiJGNPws73KCY97/Tt8FZl/
         wR5Y136Mm2UGSy/2Mjyc7vvOzVG4Zh2Hy/GMvoMnPg58mY6KlDjcnJ/8YIuPGSQeZz9G
         uBrbhTUX2B6jw1N+/YmbkzPanSgmTQ9e8Q4uDRkjREDnmvphLOjdzbv9mHFafbgismtk
         ltHA==
X-Forwarded-Encrypted: i=1; AJvYcCXXFeye2ifebMJ44UOjhuQlz5K4FCsy0BwMX5xxCGUbGtkOjFmTrrZCaUg4jBkCTGRwneA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8l924YvWFxzeMB5yNrPA8iBKkt0TaRYL73xypPmJdfV8jKa7
	43QWDDBBRM18ZrJTeIqktLQNm7IQEqxah2dficoxsYbvTwWOr90w
X-Google-Smtp-Source: AGHT+IGCwxG7EgHxyKFmR4BTRI/vuPaJl572sNjkesJx5HSS/LCPdw24U0rooyt1QDQH0ziG8Z9nBA==
X-Received: by 2002:a05:600c:1d93:b0:430:4ed0:d5ce with SMTP id 5b1f17b1804b1-43125617316mr58626195e9.34.1728832854230;
        Sun, 13 Oct 2024 08:20:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff785sm95561345e9.13.2024.10.13.08.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 08:20:53 -0700 (PDT)
Message-ID: <2a119bdd-93ba-468b-bf80-bea41a5e8e60@gmail.com>
Date: Sun, 13 Oct 2024 16:20:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] blame: introduce --override-ignore-revs to bypass
 ignore revisions list
To: Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>,
 Abhijeetsingh Meena <abhijeet040403@gmail.com>
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>
 <8d2fa3af7964dacd09d454de4325b1d5eb7a5c3d.1728707867.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <8d2fa3af7964dacd09d454de4325b1d5eb7a5c3d.1728707867.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Abhijeetsingh

On 12/10/2024 05:37, Abhijeetsingh Meena via GitGitGadget wrote:
> From: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> 
> The git blame command can ignore a list of revisions specified either
> through the --ignore-revs-file option or the blame.ignoreRevsFile
> configuration. This feature is useful for excluding irrelevant
> commits, such as formatting changes or large refactors, from blame
> annotations.
> 
> However, users may encounter cases where they need to
> temporarily override these configurations to inspect all commits,
> even those excluded by the ignore list. Currently, there is no
> simple way to bypass all ignore revisions settings in one go.

As Kristoffer has pointed out --no-ignore-revs-file should be sufficient 
to disable the default file. If it isn't we should fix it so that it is, 
not add a new option.

Best Wishes

Phillip

> This patch introduces the --override-ignore-revs option (or -O),
> which allows users to easily bypass the --ignore-revs-file
> option, --ignore-rev option and the blame.ignoreRevsFile
> configuration. When this option is used, git blame will completely
> disregard all configured ignore revisions lists.
> 
> The motivation behind this feature is to provide users with more
> flexibility when dealing with large codebases that rely on
> .git-blame-ignore-revs files for shared configurations, while
> still allowing them to disable the ignore list when necessary
> for troubleshooting or deeper inspections.
> 
> Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> ---
>   builtin/blame.c                       |  8 +++++++-
>   t/t8016-blame-override-ignore-revs.sh | 25 +++++++++++++++++++++++++
>   2 files changed, 32 insertions(+), 1 deletion(-)
>   create mode 100755 t/t8016-blame-override-ignore-revs.sh
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 1eddabaf60f..956520edcd9 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -69,6 +69,7 @@ static int coloring_mode;
>   static struct string_list ignore_revs_file_list = STRING_LIST_INIT_DUP;
>   static int mark_unblamable_lines;
>   static int mark_ignored_lines;
> +static int override_ignore_revs = 0;
>   
>   static struct date_mode blame_date_mode = { DATE_ISO8601 };
>   static size_t blame_date_width;
> @@ -901,6 +902,7 @@ int cmd_blame(int argc,
>   		OPT_BIT('w', NULL, &xdl_opts, N_("ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
>   		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("ignore <rev> when blaming")),
>   		OPT_STRING_LIST(0, "ignore-revs-file", &ignore_revs_file_list, N_("file"), N_("ignore revisions from <file>")),
> +		OPT_BOOL('O', "override-ignore-revs", &override_ignore_revs, N_("override all configurations that exclude revisions")),
>   		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
>   		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
>   		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
> @@ -1119,7 +1121,11 @@ parse_done:
>   	sb.reverse = reverse;
>   	sb.repo = the_repository;
>   	sb.path = path;
> -	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
> +
> +	if (!override_ignore_revs) {
> +		build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
> +	}
> +
>   	string_list_clear(&ignore_revs_file_list, 0);
>   	string_list_clear(&ignore_rev_list, 0);
>   	setup_scoreboard(&sb, &o);
> diff --git a/t/t8016-blame-override-ignore-revs.sh b/t/t8016-blame-override-ignore-revs.sh
> new file mode 100755
> index 00000000000..b5899729f8e
> --- /dev/null
> +++ b/t/t8016-blame-override-ignore-revs.sh
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +
> +test_description='default revisions to ignore when blaming'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
> +. ./test-lib.sh
> +
> +test_expect_success 'blame: override-ignore-revs' '
> +    test_commit first-commit hello.txt hello &&
> +
> +    echo world >>hello.txt &&
> +    test_commit second-commit hello.txt &&
> +
> +    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
> +    mv hello.txt.tmp hello.txt &&
> +    test_commit third-commit hello.txt &&
> +
> +    git blame hello.txt >expect &&
> +    git rev-parse HEAD >.git-blame-ignore-revs &&
> +    git blame -O hello.txt >actual &&
> +
> +    test_cmp expect actual
> +'
> +
> +test_done

