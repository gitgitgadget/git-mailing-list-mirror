Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC0224C0
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETnyxweq"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4840D59
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:01:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40790b0a224so36967005e9.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699894877; x=1700499677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mJjdBrH4S+NffNbk+LJMo0yq30gYmvtnz66lULydIHU=;
        b=ETnyxweq1yweEiMvrp7nrl6PjdhVwAuuvIARnCJrogt6gym/TCEr1R5S6rdagzwPdk
         glxWp6JvnjRGC2WF3Rgi2SBBP4cAfcrK9Jo9Brbe80rYMOEyQnLlLW1afX2pPWHqVTxi
         8pK3+C5BSi2/i+SK16u1V+rSljexyLNcmz8iZTs4zX9wqJIGSpOtsl/SjbP2R9qJIpkZ
         txcMVy6HT5vhBMoAHmZhquQqyjiewAq54xiCh8S9DomsNNSiXdyyJl/Vhci2Sm/WsE1u
         DwpYX+4iR5NGMTEFQXi5xfsQTMIh0XtchiBV1z4xz96bZde4s3M8ECJt0/RAQOdNbKky
         bF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699894877; x=1700499677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJjdBrH4S+NffNbk+LJMo0yq30gYmvtnz66lULydIHU=;
        b=FFL2dQUYF635XGr5C/cNiV5G6Yo7V/Wxo7ImSJ6SBw2guqZ9BFl/JzQvRrm97A/P4r
         H9c5SPScvxmU6UlPqBPKupliLzmBA/NbN1fH37rQbBBxalo9fOAS/6IJSLOI3fmxiLWO
         TR4vOYUhLxaQfMzWU0NhArlNElUAo196MLbfrBku6toCFIoGWlniMEtGsN2dOF3xuWvK
         8md0QYbEeNJMXjXYEW9NNYfi0G4k2R9UdE9Vg+X1lnmM/0Qq2E/syr6KtONj8W36sXLe
         OLc7gRGhBJTyfiEfVFJKv5hWcoRIgmC7U3RgRBF0xZxRDa4K4x0i0l7ympTLssoiJhqi
         EWqA==
X-Gm-Message-State: AOJu0YxSy7oZ4iL3RDcrL9cdrzwHTdAxhBdutPERXgvc10DJh7iz2eUR
	2+s9d2XXQdU5BiZCO+WfKnEtMcZf8rs=
X-Google-Smtp-Source: AGHT+IEyWnvUyvwD5r+D9UmXKZd71rdQL566FskhE6scj0chZSaPdOStFR3Z+EH2yHyZBgOj8itV6g==
X-Received: by 2002:a7b:cbd0:0:b0:407:58e1:24ed with SMTP id n16-20020a7bcbd0000000b0040758e124edmr6136686wmi.39.1699894876974;
        Mon, 13 Nov 2023 09:01:16 -0800 (PST)
Received: from [192.168.1.101] ([84.64.93.134])
        by smtp.googlemail.com with ESMTPSA id m6-20020a05600c3b0600b004077219aed5sm14543234wms.6.2023.11.13.09.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 09:01:16 -0800 (PST)
Message-ID: <058eb5d9-35d9-4452-8d33-d9cfebb94347@gmail.com>
Date: Mon, 13 Nov 2023 17:01:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/4] rebase: support --autosquash without -i
Content-Language: en-US
To: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231111132720.78877-1-andy.koppe@gmail.com>
 <20231111132720.78877-3-andy.koppe@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231111132720.78877-3-andy.koppe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy

On 11/11/2023 13:27, Andy Koppe wrote:
> The --autosquash option prevents preemptive fast-forwarding and triggers
> conflicts with amend backend options,

"amend" should be "apply". While this sentence is true I'm not quite 
sure how it relates to the change in this commit.

> yet it only actually performs
> auto-squashing when combined with the --interactive (or -i) option.
> 
> Remove the latter restriction and tweak the --autosquash description
> accordingly.

This seems like a reasonable change to me, thanks for working on it.

Best Wishes

Phillip

> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
>   Documentation/git-rebase.txt | 2 +-
>   builtin/rebase.c             | 4 +---
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index b4526ca246..10548e715c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -592,7 +592,7 @@ See also INCOMPATIBLE OPTIONS below.
>   	When the commit log message begins with "squash! ..." or "fixup! ..."
>   	or "amend! ...", and there is already a commit in the todo list that
>   	matches the same `...`, automatically modify the todo list of
> -	`rebase -i`, so that the commit marked for squashing comes right after
> +	`rebase`, so that the commit marked for squashing comes right after
>   	the commit to be modified, and change the action of the moved commit
>   	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
>   	matches the `...` if the commit subject matches, or if the `...` refers
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index a73de7892b..9f8192e0a5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -710,10 +710,8 @@ static int run_specific_rebase(struct rebase_options *opts)
>   	if (opts->type == REBASE_MERGE) {
>   		/* Run sequencer-based rebase */
>   		setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);
> -		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
> +		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT))
>   			setenv("GIT_SEQUENCE_EDITOR", ":", 1);
> -			opts->autosquash = 0;
> -		}
>   		if (opts->gpg_sign_opt) {
>   			/* remove the leading "-S" */
>   			char *tmp = xstrdup(opts->gpg_sign_opt + 2);

