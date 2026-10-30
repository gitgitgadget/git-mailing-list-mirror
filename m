Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353490;
	b=G4nAQ1GgPrgTdygXZfwUTGnctiwjP0mWvSugMKsQH0QbyUxpdpyAe7OymL/FQ9PsvYyG
	 w4aE0cwLxH3jFpcqNQeXH5xPbEGiHxXw/HvryJtdqcjz0LViOhPxvvDLBRh/7rXCfXYQT
	 3jnyvb9aQ3ZcgTbaHaex3QKmsiS3fOeHFA9MrjrTco6eCqr9oydC2jr1CuD2ICutkJJEL
	 atx9QxJ936d8XHBzjoZyRRVb+7y7M55MjnfDM6kfUcFh129VtjbRS1RDXCZWFgUcNea7p
	 Zg4g/9/AwtSEyaeAOsNreoBGNyraiM2fsEQBUOnPiM018oHf0N70ArbKsVNzqXkA1rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8tLF0cT5uV1q6TdMfyJ3fepQ+ko3/hb1YC79oQh36rg=;
	b=EcghNsvrLSlAqLcJ8zi8JfAKJa+yfL9HjxhSGO1r9V8LP6jF8/3QyW/kTRnEUYZi8t3x
	 cuBVprZIWINClrULt9wPCa+1iomhP9j/EgemWBS7N8On6rGGgjuHV5Ws5gtAONm99sb3U
	 Fc+eqOVoC7wLWefWQA4yAim2IwYO5NO8/dgLEM9GjSzYHZ2mYsuFUzp73IfUXWlu2qV2O
	 TKYeNlm8H3P9EkP9AQ9RrpLj2XTRVGL1mjy2b4s+0jOfxZX2pdoM48BFZ8/BQ9qJgkcnK
	 jlvmXNMCsAb2D0shHVAcrOdOL7ta5e9SxGXzGjkb0UlRnBxJfJdeJGeZNhu70hUxz+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mEQ4ap29;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63457606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63457606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mEQ4ap29
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so315286a91.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793353490; x=1793958290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8tLF0cT5uV1q6TdMfyJ3fepQ+ko3/hb1YC79oQh36rg=;
        b=mEQ4ap29fiI0gtPqfhnLBt1/BZGjKRFxfShNyBc8FlVVw9/TFMcc6AJl2WqApRoWYV
         TWQZlZchoov4GZkBJpKgavVF7urZNE1GYEuIDxWxCebuW4tg8Civ361+KJbnJBRzfMl0
         2vpFL/aoMaNxe6uJqRIi2Gy9XPBkeWAsRkfmkHT1ZfJKWKfjD7PqbhSVXRGBUsS5TL5T
         rkTUqSF+6EPAeKrrGwd/YkIZKfPQ7yPc/TqPqis51xyQSBwhkpcR5xM025T15es/mxDX
         mBPWovmKeF6zWo9hp4MGQoTDgGhRgV6mVo+xe7wOH+LA24rHQCd/cAlNtRHVJ9mJbiXN
         deqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353490; x=1793958290;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tLF0cT5uV1q6TdMfyJ3fepQ+ko3/hb1YC79oQh36rg=;
        b=FQRjJuQKWXYVniI5G7JiXquj4NySFeD0V5/XJZqNA6NFSahBKT3AYe2WJcVIAK+xSp
         3HJlh10kUhtBW3tU+o4ALY20pbm5I1jb/RyovFTH4kD9Mlm+Jj4FdAXWj8CMzGDnf8dJ
         R4DtSBxCr+0vO7CVtjAV4bo3GYkJ2+6jEhA4OvBTMq0F1CaDR9o0cWRVpJWUqsIO57kX
         L9fCrkYYQ4Zs5hDXrn6gX7+uurWZ5PpEroGhxe2MCZvwE23unOaGCS81QtN+WTYepwfM
         Aa6qZxO09nixdwJkmDUGSA6mcN+EAR+D9q/+Hdleu/GTr2Ulc6q2denTto/w1J1nKSXu
         RgHA==
X-Forwarded-Encrypted: i=1; AKwUvBzVCSQplQdk3qfKx+gNaSmmj9HjGq8lsYdG1MFYgMXobUH4sjcuB06ab4nj2g+0yEcmgRs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkqlvwqdIED4vXAoXDseAINqNDj7X0fm8qGT7S0hjPVHw262Lj
	mB3CEmqhrPV8d/rZF9WlRKDSO5aKqAc7zpKNDyf7XDwZCVA5zTwrDZA8
X-Gm-Gg: AYBFou3yCVba+47Q51v9Rtsxp/55r+BuJSzLW127vgTGY8nFAtyapwYfqJU32FETcQX
	sHsDrNhjxBlWUMHD2GNMuSsBjcrzlUqTww+MOMoODfdS/75GCd7AV+IBEbqpTbeItSTyxPH3Kdp
	GWA+1590b7Zgr3FbgU+EvwmMda+7l4qSZR6ozoR3neIYPswexGhSg3KGguIui/2kD1cGPUK8CRr
	xVU9EvBW+qJWEhAKBnId8kbg2HS2B4gTZLgMlR1ehb5m6Qj3ryavphkceCNaxWa9yYeujVTHrF+
	MOTvWi63uYMTnIBpjyd1MdDc+gBnxqATpxxOquis/K5ULQ0Fk2Rfn9DhTdOTd9aU/KRwxlXGIgw
	0gZCtWrxE5va7GWKJRYSVTzps40A+mTQ10zpEMdtakCw1vlflD+NoIeULigpOpj6mYVozjafTBy
	jPVJnDcTjSOpq8RncD4Re1VZX8CeRgx4Wve4AA4EYriU9kRRx5atT7WB9RbxRnroWmWNGJKOdr5
	U99TGuHoDWCWllhc1hvp+69t6Wq7n0rHc3nvebGQ1xVi8hSmN/3svMAyND3PTWwbHJVqfg/iPVb
	OXotagGxCL7XKyeGkM0G8KMiB+p5i0UftFZqMcujag==
X-Received: by 2002:a17:90b:5286:b0:3aa:6b5d:a02e with SMTP id 98e67ed59e1d1-3ae89853ad2mr1381719a91.54.1793353489691;
        Fri, 30 Oct 2026 02:44:49 -0700 (PDT)
Received: from [192.168.0.11] ([106.51.26.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e99b267sm7901444a91.14.2026.10.30.02.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:44:49 -0700 (PDT)
Message-ID: <123de4e4-3387-4eef-8a05-9ed1ad1fce30@gmail.com>
Date: Fri, 30 Oct 2026 15:14:45 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy PATCH v3 1/2] parse-options: answer
 --git-completion-helper before command runs
To: Tanga Joris <tangajoris@gmail.com>, git@vger.kernel.org
Cc: l.s.r@web.de, gitster@pobox.com, christian.couder@gmail.com,
 siddharthasthana31@gmail.com, usmanakinyemi202@gmail.com
References: <20261029012616.139783-1-tangajoris@gmail.com>
 <20261029231621.48958-1-tangajoris@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261029231621.48958-1-tangajoris@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tanga Joris,

Just a gentle reminder about this portion of the MyFirstContribution[1]:

   It’s good manners to reply to each comment in the mailing list
   discussion instead of letting the next version of your patch be your
   only response. Tell the reviewer whether you plan to make the
   suggested change, keep the original, or pursue a different approach.
   This way reviewers can respond to your reasoning before you spend time
   preparing a version they may not agree with, and later do not need to
   inspect your v2 to figure out whether you implemented their comment or
   not.

On 10/30/26 04:46, Tanga Joris wrote:
> fast-import parses its options only after reading the "feature"
> lines from its input, and it creates a temporary pack file before
> that. So "git fast-import --git-completion-helper" waits for input,
> and each run leaves a tmp_pack_* file behind.
> 
> bash completion runs the helper with the terminal as input, so
> "git fast-import --<TAB>" would freeze once fast-import is no
> longer marked with the NO_PARSEOPT flag.
> 

May be give a hint that you plan to do this in the following commit? 
That might give someone without context (for example someone reading the 
commit after a while) a hint about why you are worrying about marking 
fast-import with the NO_PARSEOPT flag.

> Since show_usage_with_options_if_asked() already answers -h and
> --help-all before a command does any work, it now also answers
> the completion helper, so fast-import and other commands that
> call it reply without reading input.
> 
> Reported-by: René Scharfe <l.s.r@web.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Tanga Joris <tangajoris@gmail.com>
> ---
> Changes since v2:
>   - Moved the check from fast-import into
>     show_usage_with_options_if_asked() in parse-options,
>     as Junio suggested.
>   - 2/2 is unchanged
> 
>   parse-options.c        | 6 ++++++
>   t/t9300-fast-import.sh | 8 ++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 283a0f1dc2..f2a23b79a4 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1536,6 +1536,12 @@ void show_usage_with_options_if_asked(int ac, const char **av,
>   			usage_with_options_internal(NULL, usagestr, opts,
>   						    USAGE_FULL, USAGE_TO_STDOUT);
>   			exit(0);
> +		} else if (!strcmp(av[1], "--git-completion-helper")) {
> +			show_gitcomp(opts, 0);
> +			exit(0);
> +		} else if (!strcmp(av[1], "--git-completion-helper-all")) {
> +			show_gitcomp(opts, 1);
> +			exit(0);
>   		}
>   	}
>   }

The change seems to be fine but I wonder if it is worth a note in 
parse-options.h about why show_usage_with_options_if_asked() is also 
handling the '--git-completion-helper' and '--git-completion-helper-all' 
arguments?

[ References ]

[1]: https://git-scm.com/docs/MyFirstContribution#reviewing

-- 
Sivaraam

