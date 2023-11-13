Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092F224C0
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/WXehjZ"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273DD53
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:01:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40859dee28cso39018515e9.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699894867; x=1700499667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6X2I7R4poMWANzKWDF+eSJJ5c8+t9PoVtl2qY6ZV4Wo=;
        b=d/WXehjZrYVeQt2h9BrScDjbZ1zGkFv/HvJcuQNjknlrsG0GuvKPlRRpdDSFOdOAkn
         NxDm7MrB0yG4/4qUE6KLbKm3QUXOBgewndjRSUI3vxhJ/rlg+vUS1GQhtH4S0JJC1cBn
         +3c2KGNT6k4rmcy90K2/3feCzRjC42sUHE8UYGXR0BI/dLmB7TD78NO3ILfdWr26tkwy
         6e9+DdBGNpnuG4t86H6FiQ2JzYQN+nwgCZr2zv156i2XXRmsqtNd2T9NY05/Mbb/MQw6
         MElH3v2v0wohF66voiMXgl08pr6ShpqrW4XKlne0B3YUaiL3bzLl4N8DgHOjtAQSL+hh
         HJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699894867; x=1700499667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6X2I7R4poMWANzKWDF+eSJJ5c8+t9PoVtl2qY6ZV4Wo=;
        b=DP3Qf/E6rrlgj7LV9YFWDcrq5x9Hida1r78Yp578aUwJ8EgHZarxuW8lbh8TarYl/j
         MZ7czwuh1v3YpmCkBIZypn4KLpl4AmIh8XvA7zD9BWNuez3fQICXM0megUXCsNnpo6jJ
         x5mAdrdVrHebCdXpFXh4a0tAPZiuA1nZkc8e9VTGYWKUasJKc0k1T0+FowI37GrhRXKl
         5Fq9O9UBQ/cWezN1ZlIh8AAN8C8fFGJQ5ObOplKLmZHZB/GuaGQHt33C8maMWuZHqEDv
         bFrohE1JgKE42iF6UDlkOAa27d1oi1xKZAqm+IMWXugA7RelLJGENYqMrSG5/5ynyIhO
         H5zg==
X-Gm-Message-State: AOJu0Yx8CIsFG6lT8SiUREeZugKIw3GK3+f18zwBDV9fwgn91bViirOH
	iBcAUVNvaI/0HpAhPytU1VqscnqGadY=
X-Google-Smtp-Source: AGHT+IGmbbeucuAR/MdE1ICeGOu+vStkaXZr0JJ8+rl0LfRmtsZoJnCUD1FJtAjNUNj/E5aL/h0qxQ==
X-Received: by 2002:a05:600c:4443:b0:405:82c0:d9f3 with SMTP id v3-20020a05600c444300b0040582c0d9f3mr5838636wmn.30.1699894867037;
        Mon, 13 Nov 2023 09:01:07 -0800 (PST)
Received: from [192.168.1.101] ([84.64.93.134])
        by smtp.googlemail.com with ESMTPSA id m6-20020a05600c3b0600b004077219aed5sm14543234wms.6.2023.11.13.09.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 09:01:06 -0800 (PST)
Message-ID: <7b2e35ee-716b-45c1-9570-643d2cfeeafd@gmail.com>
Date: Mon, 13 Nov 2023 17:01:06 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/4] rebase: fully ignore rebase.autoSquash without -i
Content-Language: en-US
To: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231111132720.78877-1-andy.koppe@gmail.com>
 <20231111132720.78877-2-andy.koppe@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231111132720.78877-2-andy.koppe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy

On 11/11/2023 13:27, Andy Koppe wrote:
> Setting the rebase.autoSquash config variable to true implies a couple
> of restrictions: it prevents preemptive fast-forwarding and it triggers
> conflicts with amend backend options. However, it only actually results
> in auto-squashing when combined with the --interactive (or -i) option,
> due to code in run_specific_rebase() that disables auto-squashing unless
> the REBASE_INTERACTIVE_EXPLICIT flag is set.
> 
> Doing autosquashing for rebase.autoSquash without --interactive would be
> problematic in terms of backward compatibility, but conversely, there is
> no need for the aforementioned restrictions without --interactive.
> 
> So drop the options.config_autosquash check from the conditions for
> clearing allow_preemptive_ff, as the case where it is combined with
> --interactive is already covered by the REBASE_INTERACTIVE_EXPLICIT
> flag check above it.
> 
> Also drop the "apply options are incompatible with rebase.autoSquash"
> error, because it is unreachable if it is restricted to --interactive,
> as apply options already cause an error when used with --interactive.
> Drop the tests for the error from t3422-rebase-incompatible-options.sh,
> which has separate tests for the conflicts of --interactive with apply
> options.
> 
> When neither --autosquash nor --no-autosquash are given, only set
> options.autosquash to true if rebase.autosquash is combined with
> --interactive.
> 
> Don't initialize options.config_autosquash to -1, as there is no need to
> distinguish between rebase.autoSquash being unset or explicitly set to
> false.
> 
> Finally, amend the rebase.autoSquash documentation to say it only
> affects interactive mode.

Thanks for the well reasoned explanation of the changes. I think 
documenting rebase.autosquash as only applying to interactive rebases is 
a good way forward. The code changes all look sensible to me.

Best Wishes

Phillip

> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>   Documentation/config/rebase.txt        |  4 +++-
>   builtin/rebase.c                       | 13 ++++++-------
>   t/t3422-rebase-incompatible-options.sh | 12 ------------
>   3 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
> index 9c248accec..d59576dbb2 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -9,7 +9,9 @@ rebase.stat::
>   	rebase. False by default.
>   
>   rebase.autoSquash::
> -	If set to true enable `--autosquash` option by default.
> +	If set to true, enable the `--autosquash` option of
> +	linkgit:git-rebase[1] by default for interactive mode.
> +	This can be overridden with the `--no-autosquash` option.
>   
>   rebase.autoStash::
>   	When set to true, automatically create a temporary stash entry
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 043c65dccd..a73de7892b 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -149,7 +149,6 @@ struct rebase_options {
>   		.reapply_cherry_picks = -1,             \
>   		.allow_empty_message = 1,               \
>   		.autosquash = -1,                       \
> -		.config_autosquash = -1,                \
>   		.rebase_merges = -1,                    \
>   		.config_rebase_merges = -1,             \
>   		.update_refs = -1,                      \
> @@ -1405,7 +1404,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
>   	    (options.action != ACTION_NONE) ||
>   	    (options.exec.nr > 0) ||
> -	    (options.autosquash == -1 && options.config_autosquash == 1) ||
>   	    options.autosquash == 1) {
>   		allow_preemptive_ff = 0;
>   	}
> @@ -1508,8 +1506,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   			if (is_merge(&options))
>   				die(_("apply options and merge options "
>   					  "cannot be used together"));
> -			else if (options.autosquash == -1 && options.config_autosquash == 1)
> -				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
>   			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
>   				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
>   			else if (options.update_refs == -1 && options.config_update_refs == 1)
> @@ -1529,10 +1525,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
>   				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
>   
> -	if (options.autosquash == 1)
> +	if (options.autosquash == 1) {
>   		imply_merge(&options, "--autosquash");
> -	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
> -			     ((options.config_autosquash >= 0) ? options.config_autosquash : 0);
> +	} else if (options.autosquash == -1) {
> +		options.autosquash =
> +			options.config_autosquash &&
> +			(options.flags & REBASE_INTERACTIVE_EXPLICIT);
> +	}
>   
>   	if (options.type == REBASE_UNSPECIFIED) {
>   		if (!strcmp(options.default_backend, "merge"))
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 2eba00bdf5..b40f26250b 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -100,12 +100,6 @@ test_rebase_am_only () {
>   		test_must_fail git rebase $opt --root A
>   	"
>   
> -	test_expect_success "$opt incompatible with rebase.autosquash" "
> -		git checkout B^0 &&
> -		test_must_fail git -c rebase.autosquash=true rebase $opt A 2>err &&
> -		grep -e --no-autosquash err
> -	"
> -
>   	test_expect_success "$opt incompatible with rebase.rebaseMerges" "
>   		git checkout B^0 &&
>   		test_must_fail git -c rebase.rebaseMerges=true rebase $opt A 2>err &&
> @@ -118,12 +112,6 @@ test_rebase_am_only () {
>   		grep -e --no-update-refs err
>   	"
>   
> -	test_expect_success "$opt okay with overridden rebase.autosquash" "
> -		test_when_finished \"git reset --hard B^0\" &&
> -		git checkout B^0 &&
> -		git -c rebase.autosquash=true rebase --no-autosquash $opt A
> -	"
> -
>   	test_expect_success "$opt okay with overridden rebase.rebaseMerges" "
>   		test_when_finished \"git reset --hard B^0\" &&
>   		git checkout B^0 &&

