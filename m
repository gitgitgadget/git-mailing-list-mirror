Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4CA15ADD
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6z6uPkK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so193425e9.1
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 03:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702984044; x=1703588844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nx9cU9eFWr8VKKqj3a1vzoxPB1QEhkyRCq4i8GcdcbY=;
        b=R6z6uPkKZQNL4eGTic+/FyJOxWiE+xl7stl02ztVsty0qWLfWUbAsATmh+P4ThzfmH
         HwBGoMpoHZDmlMQNxuDpWeANO3ghogPhOFk1IrNnjhMDApZlDGRt/OmxFJMhh//KZYY5
         SvxHNbYjeOBYcxofgPXtkIkHzhXBvJmbGgmQhjnWOTu3ZV1wn2YhGZbA3ROd6wAanRn1
         XtYFMf3asrhrkL41yc9glpDd5p9JZAnXoMxxLr565TLJXip2pnDbiRArlqgFuwPpNhNv
         KL05szjdtlO0D5PEkr9i5vYImcOF5Xo+/yMRovphYNhKH5G+nQLm8heY+vMB7DcmQHCu
         Bflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702984044; x=1703588844;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nx9cU9eFWr8VKKqj3a1vzoxPB1QEhkyRCq4i8GcdcbY=;
        b=cNU8dI7LVpfuHQvbnWUyq6uRyfgWw423CaGkhaXvyuv8AohTNkI89p559Yq6qnPOoY
         9FdqZvoEC5MbwlZEF1RUCwIyps3w+xf/WWVyj95l5muCOK2bywtC3UP/lhzv01KRl/wR
         t5Fd0hIBPflDJ+fTUEUHcYRqoV2JU2sAzpNz9D/lo5TPifyqZY9QbI0wFGKFwrQOBw/c
         McN+UYVTksn51wXh/RFSKpbpOuFLPF8uoHT86EFGqjgnsl/Cm97zPYMustOIhlvU7a+Q
         LfYgO5PtmliM6lXa0wwphl1oDIyZHQeThWzDmipxHN7yUKfTGVQz5lvlaaBty8GIvCfm
         g0Rw==
X-Gm-Message-State: AOJu0YwaKbxC1L1wiP0hsK4VFeJsPd7PMYgwYy78MQUyURPpTK66AF5W
	jawRUY6++tykI3pUlruU92k=
X-Google-Smtp-Source: AGHT+IE/yW/UeJOwVVOXOspjD2jmgL+Xr4AX30a9+Lxuepzf2Ezo9wjrzAKPDYMPxSXJa7B25EXr/w==
X-Received: by 2002:a05:600c:3d96:b0:40b:5e56:7b49 with SMTP id bi22-20020a05600c3d9600b0040b5e567b49mr494350wmb.146.1702984044069;
        Tue, 19 Dec 2023 03:07:24 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id q19-20020a05600c46d300b0040b632f31d2sm2359452wmo.5.2023.12.19.03.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 03:07:23 -0800 (PST)
Message-ID: <d91f96aa-8320-4b6f-ae5e-54290a4c03ea@gmail.com>
Date: Tue, 19 Dec 2023 11:07:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: use strvec_pushf() for format-patch revisions
Content-Language: en-US
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Git List <git@vger.kernel.org>
References: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 19/12/2023 07:42, René Scharfe wrote:
> In run_am(), a strbuf is used to create a revision argument that is then
> added to the argument list for git format-patch using strvec_push().
> Use strvec_pushf() to add it directly instead, simplifying the code.

This looks like a nice simplification and the extra context lines in the 
patch are much appreciated

Thanks

Phillip

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Formatted with --inter-hunk-context=14 for easier review.
> 
>   builtin/rebase.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 9f8192e0a5..ddde4cbb87 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -582,7 +582,6 @@ static int run_am(struct rebase_options *opts)
>   {
>   	struct child_process am = CHILD_PROCESS_INIT;
>   	struct child_process format_patch = CHILD_PROCESS_INIT;
> -	struct strbuf revisions = STRBUF_INIT;
>   	int status;
>   	char *rebased_patches;
> 
> @@ -615,34 +614,32 @@ static int run_am(struct rebase_options *opts)
>   		return run_command(&am);
>   	}
> 
> -	strbuf_addf(&revisions, "%s...%s",
> -		    oid_to_hex(opts->root ?
> -			       /* this is now equivalent to !opts->upstream */
> -			       &opts->onto->object.oid :
> -			       &opts->upstream->object.oid),
> -		    oid_to_hex(&opts->orig_head->object.oid));
> -
>   	rebased_patches = xstrdup(git_path("rebased-patches"));
>   	format_patch.out = open(rebased_patches,
>   				O_WRONLY | O_CREAT | O_TRUNC, 0666);
>   	if (format_patch.out < 0) {
>   		status = error_errno(_("could not open '%s' for writing"),
>   				     rebased_patches);
>   		free(rebased_patches);
>   		strvec_clear(&am.args);
>   		return status;
>   	}
> 
>   	format_patch.git_cmd = 1;
>   	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
>   		     "--full-index", "--cherry-pick", "--right-only",
>   		     "--default-prefix", "--no-renames",
>   		     "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
>   		     "--no-base", NULL);
>   	if (opts->git_format_patch_opt.len)
>   		strvec_split(&format_patch.args,
>   			     opts->git_format_patch_opt.buf);
> -	strvec_push(&format_patch.args, revisions.buf);
> +	strvec_pushf(&format_patch.args, "%s...%s",
> +		     oid_to_hex(opts->root ?
> +				/* this is now equivalent to !opts->upstream */
> +				&opts->onto->object.oid :
> +				&opts->upstream->object.oid),
> +		     oid_to_hex(&opts->orig_head->object.oid));
>   	if (opts->restrict_revision)
>   		strvec_pushf(&format_patch.args, "^%s",
>   			     oid_to_hex(&opts->restrict_revision->object.oid));
> @@ -665,10 +662,8 @@ static int run_am(struct rebase_options *opts)
>   			"As a result, git cannot rebase them."),
>   		      opts->revisions);
> 
> -		strbuf_release(&revisions);
>   		return status;
>   	}
> -	strbuf_release(&revisions);
> 
>   	am.in = open(rebased_patches, O_RDONLY);
>   	if (am.in < 0) {
> --
> 2.43.0
> 
