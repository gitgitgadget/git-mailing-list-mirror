Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4E58200
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VItwHNEX"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7831806c527so469692185a.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705009439; x=1705614239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njQfyaKDw+zwH6peSnfIUal+FYmsl7p6QdHvRP4Z5cY=;
        b=VItwHNEXw4dolrmVW04VzBQymZesbtk6iXFXtCoTvGYU1kY0MjOWvDWwf7xeVZtcMI
         Uihdebr0bK8vZBblZSbFfRr6JfrUDIlr8lkg8dITc608hiYWtZygOH1o4LM5IBevrbD4
         bsw8r46RZDCXtWXLzjOHZc8WfeMgIgTVpgZ63gyQU0QOIMxZu6MudGYfuYJnia+4WsvQ
         ULaOhNdabUJCG7RYJluWDOMuFGftda8WrakYHHydpH4py5s++GSBNEYhiQKHtijwaPIl
         cahInOSM2TppoNBBdlfH4EZtEBGK7g73HKL5qN9QcvSU1DHuBSdRMINj7Kz5Jm70Jvj1
         diNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705009439; x=1705614239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njQfyaKDw+zwH6peSnfIUal+FYmsl7p6QdHvRP4Z5cY=;
        b=PCEuRkWTFEEHonP31YIHlmkgFPBmsf5cLBNg7+3Q0PTOT9r6zucJaM2X9YRaPsW1UO
         +ktok/ruxxqB8moaNe4Bb7Tmutun0CfPd7YDYi+5UisrWGcZBhE7geM106zN32dWfdir
         EVqbHMzMN3tA0L7h42XvCuRMuXiZNvLcWbeled+35QV+CspS9iKDhL1Fqm/fmhMFq7LI
         Pplcp80H7BrrRMwAEjuH52pPZcu53JnpVe3HfGnr1FvQVZRpszNxMBDUr7bDeNCcgOdG
         T4KUJ3tI31tPFjamWKYfh08I0lZWDSu1WhTYZzhm5lnSdJsvIAFiOpjW9/a9KuT+JLTf
         hcJQ==
X-Gm-Message-State: AOJu0YzqNbeTabJ2txgxt8h/6lUVrZFcTtPsQr++QMcolbMavwfx8JAp
	t6Al78JKN4obeBKlhVMV87tuFvHZifZCg7ZGQZroy+Oe1ma1vg==
X-Google-Smtp-Source: AGHT+IEp3cs5TzoQDq8q0Ot0kVw/RCKwQ4vGp2Fe02evuacB68GPpC1/pu1I4Ep2cHdZzF9l+uy/hA==
X-Received: by 2002:a05:6214:23cf:b0:67f:48e0:671f with SMTP id hr15-20020a05621423cf00b0067f48e0671fmr349853qvb.38.1705009438805;
        Thu, 11 Jan 2024 13:43:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id jy18-20020a0562142b5200b00680ac921860sm583449qvb.45.2024.01.11.13.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 13:43:58 -0800 (PST)
Date: Thu, 11 Jan 2024 16:43:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Benji Kay via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Benji Kay <okaybenji@gmail.com>
Subject: Re: [PATCH] push: improve consistency of output when "up to date"
Message-ID: <ZaBhHSCT7EOgTo/N@nand.local>
References: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1638.git.1705008449995.gitgitgadget@gmail.com>

On Thu, Jan 11, 2024 at 09:27:29PM +0000, Benji Kay via GitGitGadget wrote:
> From: okaybenji <okaybenji@gmail.com>
>
> When one issues the pull command, one may see "Already up to date."
> When issuing the push command, one may have seen "Everything up-to-date".
> To improve consistency, "Everything up to date." is printed instead.
> (The hyphens have been removed, and a period has been added.)
>
> Signed-off-by: okaybenji <okaybenji@gmail.com>
> ---
>     push: improve consistency of output when "up to date"
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1638%2Fokaybenji%2Fup-to-date-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1638/okaybenji/up-to-date-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1638
>
>  transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/transport.c b/transport.c
> index bd7899e9bf5..c42cb4e58b4 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1467,7 +1467,7 @@ int transport_push(struct repository *r,
>  	if (porcelain && !push_ret)
>  		puts("Done");
>  	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
> -		fprintf(stderr, "Everything up-to-date\n");
> +		fprintf(stderr, "Everything up to date.\n");

Between the two, I have a vague preference towards "up-to-date", which
would suggest changing the pull command's output to read "Already
up-to-date". Personally I think that neither of them should include a
period in their output, but whichever we decide should be done so
consistently between the two.

Also, should this string be marked for translation?

Thanks,
Taylor
