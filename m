Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ABC32D0C0
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793604; cv=none; b=odLNZK8YArFYu0vzz7ACWmGkSPc3rYcFIpJEMZ0qnmBikIytdVc24NrWI4rt7QWmk2s4LPreBzwQQnwGrQ4QcGOiVu5zRIaqQOB4PW3B5tC6yOFaB7G3I2e+brJReQhiIZE+6HkjsknrT+F4wnNopyfBIgW2u6TMKK1Ise95T1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793604; c=relaxed/simple;
	bh=t/O/Vdu6OffwL8cqc44V7t/4WwTzJKheMnDrzKVeNbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDO/GiN80MMYzp4SOd3XHAnPuHnuGd7O+DweiQXrZfx0gv+IM/Nk/v6jmQvqla+AeiZ9E3LAhk6Bk2u6MnO1hDNqwTDSYzPB9WV37IV61hCi7J/rcNmRamMgEp1pvJO6w/rCRv0/lhJGgQ/W40M4PLb1z7nO6ZxOKxh5/xpoQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd6Z3p7Q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd6Z3p7Q"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso28468845e9.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765793597; x=1766398397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9BrgOzLeUWf4Fw/G2Fo5s+1qI1BELzBgGqOIq7jCSqU=;
        b=hd6Z3p7Qzv0RjeCj8n2rqpBloUB27bukpiw22khbuVItlrnZcMZPrkeBmijKCjCbwB
         HLHLTmnBZUka77Rl0+Qer5f1K9CQDSxVTJuTtd6VGzqkaBU2FycYI+1+YY6uZrMYCO1/
         SDK0YewWVstcHPy7jViPvSA9sEawi+f9Li3DHASOvw2r4bh0j+F51NJVzXcNnH7BUkNB
         oNmwb14Ev6qRWJFw0nTSvWJMd0hOmlXR6KjhdGSCsx1AAj/g94xdlsSjm6SuQirybzas
         JXqQQJgABGzgBGV4CsRxVv5HC2fYqiQ51fVES0l4kFdn/+HA2OJTjmhoZN4HF0KIiuQz
         lMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765793597; x=1766398397;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BrgOzLeUWf4Fw/G2Fo5s+1qI1BELzBgGqOIq7jCSqU=;
        b=F9kbWHK1ul2CAuCTaig6y7nL0j/TiZ/yFkTVygoPI4fauuS9Rdnu+kTPcb9z9NUfMY
         nEWb3lsVPrBcZVFmJqoo3Y78upNptRuz7xj2dVti/FD7MPX23RAW/gt8sHp+ws3G3zte
         fEQBWhEDg+HHPV3t61kRrPPHS+WdxwZRnCtOctqYuxjCtbJhXRTW4+I7nVyrdufovXG1
         JfdGaApEwq1rNcRAC7p2jToevMojoM0QVP+7cu8pYcG3oSjGD2cgo7C7WLWESkE0Mn0u
         249IVs0tT0NE8YcTGWZuVbv0YgSeQfs6XciNU6hBH2Q+VAiTboe1sUF+SmvA+oUeSgjk
         HX2w==
X-Forwarded-Encrypted: i=1; AJvYcCVYaHJraBTOJyXufPEHP5rU3QvaMSkvuo+Y0WQ8xxNfxX9IrcNG/DefuGqj7+Ybs3s0sIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32R5vLybQiwBe363cyquYRjwYyx2+8sZYBqlff4H60KjxNg1t
	UjVcKxLkI18O1+CDSlx0Cr/o3KG/iGnOaS6NhKyEuXo5wkH+M2mzd/Ej
X-Gm-Gg: AY/fxX6Ui8fntBTvqhc4b/nciImxo0PMthJvNVQCwkcLaRgfuHh4TAqVTQ0N4PS9koE
	deh31uUtTW0tU7QkdYdyQlcKLW5xZFHwmJKZr3qceIbvxGfGHEfMUSTFAgn1QmCTsIXPTSEelIc
	9m2b5yP+Ycc1X8yNvT5Uw21S8b1y7X6QNKU1usT8IySeJM17n/up6csrKUrm0vtyDiCufrmf6s+
	1Nf04qbBIh1B2q7R5ojsPRaTY1J7RJXad6ZC3n3ZxswtMtkvIPHjlnoZzoQfGNkaCveKcKoJcwz
	EVkWQqzOFJivXDapdRdYMEvdPLTui4WZtuLaoN3Bg2ydDnRPxoJeK3yAN26KNJV7xB/ZOj9n9lH
	TGbfyhnsEktFgcpdlN4bIcXIOCTdzUhrMbNGZNVCe42N3rPQnMarlLemanfP9VV6B/hE/VRcYdb
	2lFi7G4U5Bkb9hFYmTrkYObSp9W5Wnpb5NXaUEn8MWFcH29YSz7vk56UzLQ5HAhpx7jg==
X-Google-Smtp-Source: AGHT+IHdpNLRQeDMWeQkJDE313MJ2OAqaLcUeEt5XijgBIn7zyb4ruPgvATc0BQDWkwKyGUKMjZEyg==
X-Received: by 2002:a05:600c:4e09:b0:477:9c73:267f with SMTP id 5b1f17b1804b1-47a8f914a25mr118755465e9.33.1765793597414;
        Mon, 15 Dec 2025 02:13:17 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8d9d63sm181128145e9.9.2025.12.15.02.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 02:13:16 -0800 (PST)
Message-ID: <8fa21ce8-1e02-419f-b82a-0e4a41f7e2d8@gmail.com>
Date: Mon, 15 Dec 2025 10:13:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] doc: replay: improvements like "mention no output
 on conflicts"
To: kristofferhaugsbakk@fastmail.com, Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 Phillip Wood <phillip.wood@dunelm.org.uk>, christian.couder@gmail.com,
 newren@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>
References: <CV_replay_conflict.101@msgid.xyz>
 <V2_CV_replay_conflict.12f@msgid.xyz>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <V2_CV_replay_conflict.12f@msgid.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/12/2025 13:46, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Explicitly say that conflicts do not give any output. I found this a bit
> confusing with the current doc since I am used to other commands
> complaining loudly.
> 
> § Changes in v2
> 
> Patch 2/3: improve `--contained` and mention that it requires `--onto`.

The new text looks good, I don't really understand the commit message 
but the intent of the change is clear enough.

Thanks for improving the documentation

Phillip

> Kristoffer Haugsbakk (3):
>    doc: replay: mention no output on conflicts
>    replay: improve --contained and add to doc
>    doc: replay: link section using markup
> 
>   Documentation/git-replay.adoc | 11 ++++++++++-
>   builtin/replay.c              |  2 +-
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> Interdiff against v1:
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index 04944a5fa23..22fd1b271af 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -43,7 +43,8 @@ point at the tip of the resulting history. This is different from `--onto`,
>   which uses the target only as a starting point without updating it.
>   
>   --contained::
> -	Advance all branches contained in <revision-range>.
> +	Update all branches that point at commits in
> +	<revision-range>. Requires `--onto`.
>   
>   --ref-action[=<mode>]::
>   	Control how references are updated. The mode can be:
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6606a2c94bc..9e5ad64cad6 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -377,7 +377,7 @@ int cmd_replay(int argc,
>   			   N_("revision"),
>   			   N_("replay onto given commit")),
>   		OPT_BOOL(0, "contained", &contained,
> -			 N_("advance all branches contained in revision-range")),
> +			 N_("update all branches that point at commits in <revision-range>")),
>   		OPT_STRING(0, "ref-action", &ref_action,
>   			   N_("mode"),
>   			   N_("control ref update behavior (update|print)")),
> Range-diff against v1:
> 1:  b9ec24c8b8f = 1:  b9ec24c8b8f doc: replay: mention no output on conflicts
> 2:  02a80ee87b5 ! 2:  27bf2ac7a0b doc: replay: document --contained
>      @@ Metadata
>       Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
>       
>        ## Commit message ##
>      -    doc: replay: document --contained
>      +    replay: improve --contained and add to doc
>       
>      -    Copy the text from `replay_options` in `builtin/replay.c`.
>      +    There is no documentation for `--contained`.
>       
>      +    Start by copying the text from `replay_options` in `builtin/
>      +    replay.c`. But some people think that the existing text is a
>      +    bit unclear; what does it mean for a branch to be contained
>      +    in a revision range? Let’s include the implied commits here:
>      +    the branches that point at commits in the range.
>      +
>      +    Also use “update” instead of “advance”. “Update” is the verb
>      +    commonly used in this context.
>      +
>      +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>      +    Helped-by: Junio C Hamano <gitster@pobox.com>
>           Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>       
>      +
>      + ## Notes (series) ##
>      +    v2:
>      +
>      +    Don’t just copy `--contained` over. Improve it on both sites after discussing
>      +    with reviewers.
>      +
>      +    Also mention that `--onto` is required.
>      +
>        ## Documentation/git-replay.adoc ##
>       @@ Documentation/git-replay.adoc: The history is replayed on top of the <branch> and <branch> is updated to
>        point at the tip of the resulting history. This is different from `--onto`,
>        which uses the target only as a starting point without updating it.
>        
>       +--contained::
>      -+	Advance all branches contained in <revision-range>.
>      ++	Update all branches that point at commits in
>      ++	<revision-range>. Requires `--onto`.
>       +
>        --ref-action[=<mode>]::
>        	Control how references are updated. The mode can be:
>        +
>      +
>      + ## builtin/replay.c ##
>      +@@ builtin/replay.c: int cmd_replay(int argc,
>      + 			   N_("revision"),
>      + 			   N_("replay onto given commit")),
>      + 		OPT_BOOL(0, "contained", &contained,
>      +-			 N_("advance all branches contained in revision-range")),
>      ++			 N_("update all branches that point at commits in <revision-range>")),
>      + 		OPT_STRING(0, "ref-action", &ref_action,
>      + 			   N_("mode"),
>      + 			   N_("control ref update behavior (update|print)")),
> 3:  ca83b00343d = 3:  4e851fdff34 doc: replay: link section using markup
> 
> base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06

