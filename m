Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD11B0F11
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550277; cv=none; b=YhEbraRWcjX/bNFyJSUcudcHbXGzJlKapXHs7eBfef/mS90WD2EwVBsh8LLbrC8mbL+PlcidDp0T5bu44boVSl7iMz8Pegvml2DoAq4sa/X3jWFvRVT5blvgW5IdJD4PpmeLobzLS3o1PQYf0441l+mn5eZK0t4KhQU3WkSaQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550277; c=relaxed/simple;
	bh=FDLsbjUwk499gBPeYm4MJhpPlsKR4+pcJg1qhti8TS4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ohbsBRssv3RsF6VgUYjUmcbYZKow4sFiIStbPiXKiG6tAoa2lJcwR7IhM6HbY+JUMwA4Dq9RxltCWSXucAFaGeUfvpr/Td6kmSqTRl7d31d0ndKT4wrHUw3n8K4YFP1f+4/d87LQlD1K0XdP5YTNM50oAMF+hLsblm9bprcM0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3F6OXIj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3F6OXIj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so26714335e9.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758550272; x=1759155072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4L4vsfKPkb5mWi4cW7AgOM3g0FGFjq+Tc3WAVU5LwSs=;
        b=Z3F6OXIjljATP/Nrc+UipP6Zu3l9Sd+0rijKWafKIm3Khrj2bsKoHE4L1/6abmdwRF
         EQRc7bk8hpG/h4BAAK/ixytBN1OQ7c7vYpfV9Ekz63F/Tvwx3/iK43dT/qEVDlsE9SXm
         k3173gafqyPUwGzWwKew1ZROFTV6Tg/pJjalEcyoI8jnRNgoOucZoL5p6UmXrpuwY26X
         TPMiK6PiBQvSv6pQQ6J14opuaLJ10XTyrN5UPZbduh1wzEoNEal8BppgYqHW8k3kzYh8
         RLdTfNW17m2YnftFhwtWKTpn1x41p93daLTEuOeRRxdTpTHO0K6aPuwuuDXPyX5MyS0x
         o/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550272; x=1759155072;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4L4vsfKPkb5mWi4cW7AgOM3g0FGFjq+Tc3WAVU5LwSs=;
        b=Y8rdMqcxt3s+Na3XadhACM+7Qd/00RPZGrlEUT3R2RHu/7GnqLqrkeia57hLRqY8S3
         P1ltyTVnXWKslfKiAdZigTdU/GpecbYVXtg8HkZN9+vg9dRA7ygrAzyr4pO5Flve4M6p
         Dz/BlwRc9Sm/nZno7Qq1Iz4+XSfPDiofu5yWPXqpUMU5lZo60a6EwHK+H5vJn/uENREO
         RO+2HgxwJGk/cFIygjMGaoS+StcdPYtqu/jXPirnkv4InZ8eUTTX9KWm+U/OqHLqq5WK
         cN92d7ZCRFtqkocW9ZXW7oFOYlBK3wva9jLfrqslFu358eovlopAWwwJkk9txCeJ3jEw
         yg4w==
X-Forwarded-Encrypted: i=1; AJvYcCVm4RGd92Z4nphOAJH3z7lfc28MCWsRIi+AILAQbH2Cusky30qppA7AC63CXZ/hcW3AX7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YypkXO1C6pzkVlrhSqTA/xpvK4SQa8J9mVokmYf46vTnU127s0z
	ZUVlVqK3MgTFfSBQYpI6PyjD09lfTNXFHgHVOubyZEZjzy0+F7Mt+Isn
X-Gm-Gg: ASbGncs6i29k1Jo7y2k0DDWmfFQ+LFb/1KZyNUaZsJSFg0EtJHhZwXYPpiO84BXsCZT
	TnpV4vgRWWq1jTaBYS/7iarzt7NxeUOD0TfMU7yLAzrxMIhBI4A1pwzXMULtpu8KTdxa4WC1u0N
	E8QvWVCW24/EE2rs71/nNUj5XgS78p1VTGbR9Fpz2dWhyRUVzTrK6fEGeHR5NwXN1xcDbBIPEXE
	JZgm+h/6b8Mpqzr9FLxMuLIOU4QtgzfSpfsmwkxBPqhvQyfKFxp1o6+DM1rGyXS46bmBy8fJQRP
	eIeLoEsShOs72KZu4s8BV1cDGA8hr2rPBO3NxaezHnjHEMWvGDFnp9fBA786h9cL1LA5Qfe/MBY
	K/cf5u0vEtBtYoKXCbz2OCZgKLjreH+qsDDlUX0xUERVBKuIjFTEZOaH13Rgbv/UWESHUeru0IY
	Y=
X-Google-Smtp-Source: AGHT+IFoGLzh1PhUPSnWKsbuXQ9XINzqkWqcOpJDsFia7hlj1UR1fkFO7RcdEqlOG1pbYh0XTkEByw==
X-Received: by 2002:a05:600c:46c6:b0:45b:804a:a65e with SMTP id 5b1f17b1804b1-467ebbbff33mr133148385e9.28.1758550271528;
        Mon, 22 Sep 2025 07:11:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm198664615e9.1.2025.09.22.07.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:11:11 -0700 (PDT)
Message-ID: <d7721018-3b2f-4764-b33d-4fc6bdc034a1@gmail.com>
Date: Mon, 22 Sep 2025 15:11:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] stash: honor stash.index in apply, pop modes
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, moti sd <motisd8@gmail.com>,
 Denton Liu <liu.denton@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Glen Choo <glencbz@gmail.com>
References: <cover.1757982870.git.ben.knoble+github@gmail.com>
 <cover.1758505011.git.ben.knoble+github@gmail.com>
 <8e6cafbf3a01b968663b65559acf3df615eecbad.1758505011.git.ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <8e6cafbf3a01b968663b65559acf3df615eecbad.1758505011.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 22/09/2025 02:39, D. Ben Knoble wrote:
> With stash.index=true, git-stash(1) command now tries to reinstate the
> index by default in the "apply" and "pop" modes. Not doing so creates a
> common trap [1], [2]: "git stash apply" is not the reverse of "git stash
> push" because carefully staged indices are lost and have to be manually
> recreated. OTOH, this mode is not always desirable and may create more
> conflicts when applying stashes. As usual, "--no-index" will disable
> this behavior if you set "stash.index".

Thanks for updating the tests, they look good. As I said before I don't 
have a strong opinion about this change but I certainly don't object to 
it. I think this change will also affect the behavior of "git 
merge/pull/rebase --autostash" which we should maybe call out in the 
commit message. I don't think that change in behavior is a problem as it 
is probably what the user would expect when they set this config.

Thanks

Phillip

> [1]: https://lore.kernel.org/git/CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com/
> [2]: https://lore.kernel.org/git/c5a811ac-8cd3-c389-ac6d-29020a648c87@gmail.com/
> 
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>   Documentation/config/stash.adoc |  5 +++++
>   builtin/stash.c                 |  9 ++++++--
>   t/t3903-stash.sh                | 37 +++++++++++++++++++++++++++++++++
>   3 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
> index ec1edaeba6..e556105a15 100644
> --- a/Documentation/config/stash.adoc
> +++ b/Documentation/config/stash.adoc
> @@ -1,3 +1,8 @@
> +stash.index::
> +	If this is set to true, `git stash apply` and `git stash pop` will
> +	behave as if `--index` was supplied. Defaults to false. See the
> +	descriptions in linkgit:git-stash[1].
> +
>   stash.showIncludeUntracked::
>   	If this is set to true, the `git stash show` command will show
>   	the untracked files of a stash entry.  Defaults to false. See
> diff --git a/builtin/stash.c b/builtin/stash.c
> index d9b478d1d1..8a0eef3c70 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -130,6 +130,7 @@ static struct strbuf stash_index_path = STRBUF_INIT;
>   static int show_stat = 1;
>   static int show_patch;
>   static int show_include_untracked;
> +static int use_index;
>   
>   /*
>    * w_commit is set to the commit containing the working tree
> @@ -662,7 +663,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
>   {
>   	int ret = -1;
>   	int quiet = 0;
> -	int index = 0;
> +	int index = use_index;
>   	struct stash_info info = STASH_INFO_INIT;
>   	struct option options[] = {
>   		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> @@ -759,7 +760,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
>   		     struct repository *repo UNUSED)
>   {
>   	int ret = -1;
> -	int index = 0;
> +	int index = use_index;
>   	int quiet = 0;
>   	struct stash_info info = STASH_INFO_INIT;
>   	struct option options[] = {
> @@ -864,6 +865,10 @@ static int git_stash_config(const char *var, const char *value,
>   		show_include_untracked = git_config_bool(var, value);
>   		return 0;
>   	}
> +	if (!strcmp(var, "stash.index")) {
> +		use_index = git_config_bool(var, value);
> +		return 0;
> +	}
>   	return git_diff_basic_config(var, value, ctx, cb);
>   }
>   
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index b8936a653b..d6127173b1 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1595,4 +1595,41 @@ setup_stash()
>   	)
>   '
>   
> +test_expect_success 'stash.index=true implies --index' '
> +	# setup for a few related tests
> +	test_commit file base &&
> +	echo index >file &&
> +	git add file &&
> +	echo working >file &&
> +	git stash &&
> +
> +	test_when_finished "git reset --hard" &&
> +	git -c stash.index=true stash apply &&
> +	echo index >expect &&
> +	git show :0:file >actual &&
> +	test_cmp expect actual &&
> +	echo working >expect &&
> +	test_cmp expect file
> +'
> +
> +test_expect_success 'stash.index=true overridden by --no-index' '
> +	test_when_finished "git reset --hard" &&
> +	git -c stash.index=true stash apply --no-index &&
> +	echo base >expect &&
> +	git show :0:file >actual &&
> +	test_cmp expect actual &&
> +	echo working >expect &&
> +	test_cmp expect file
> +'
> +
> +test_expect_success 'stash.index=false overridden by --index' '
> +	test_when_finished "git reset --hard" &&
> +	git -c stash.index=false stash apply --index &&
> +	echo index >expect &&
> +	git show :0:file >actual &&
> +	test_cmp expect actual &&
> +	echo working >expect &&
> +	test_cmp expect file
> +'
> +
>   test_done

