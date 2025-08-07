Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01123C50C
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573999; cv=none; b=bYUbqsZzG0tLNRuHvsIA04deQuQPQns3WZ5egBbob6ZM9BiyJBXtbqK6vYAeFhlF8707VufGTmccbpAbwbDavfD+vldQxx24DX1DriGkAe2azi1IlS009HiCeA6nIM5z8Qorivr2yQuNjIFwcwRaNXuaoD3SsQ0jwFJOJk7F5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573999; c=relaxed/simple;
	bh=NyNuthmoqRfPtkB9OpKOYP2AqjLMKRLUKc4clRCXM94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoDltwXHVLGPzW0nWHEv1IUGm2EjcaJyB39Xi2pnLXYLvlAEhwIR0Oge6lw6W3kgXJXdPhxXr/Q0aDc44EDvCkaju1S1Z4eUjjqLkj7X5VLa2GSaRirDgnEMp1iSyuOG+Z77DDWlz3T/klojnJiRbdYEuWCQgMO46rJSxjp8siM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asKTnuwX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asKTnuwX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so6617935e9.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754573996; x=1755178796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v7fOf956Y0OjBJm+hXW2NmoXOFKlNnvwP9dqamIYgLM=;
        b=asKTnuwXstbL057f8hXH5c18RMqpKT3RBUmiT35oxz4ywohzMa8zWVcCIacqU+GbX0
         siHZG5zCW62EctVKQmhfZiBVcemwofXXzTw7Hl0drL32ahiFmYG5iwU8380+fiyISTs4
         KzhgKmZGjJP/1YQ3sYME6p+yIaOQ1y/QSPgiDYRS/GuCCiAA6yTo6bkjs5zji1CKPAyP
         1Jq/+rNjLkNmiaz0K8PpBG8wJMcbPcQercqsTKSS1xAwVgvAnVUNbP/c59uX2cKe7cYB
         vx+IzLtHlgUGnPRP27ojMxAuZ+/9lrn4q0lwHucUK3agcWvzDZtgmf6xmftpvzmHBmmo
         faRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573996; x=1755178796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7fOf956Y0OjBJm+hXW2NmoXOFKlNnvwP9dqamIYgLM=;
        b=ayxp62MSeaQjyfDatIqpGefWMOqOURn+HIMwfyxEG82wLfoNCwKeuYgiEionNsMdR6
         7n+OvQxrPohL5hTc8DULCpKKZnPV2e/TzkKql5zLF+IaoQQN5mHmQgtASLRQ7FfeGs84
         8Jla1y+wF1v9sX9FbUPaOlIR2iUQ++XNvvmCp8iK2i1zTuc8RzJ8mJSpivHLItuAg17Q
         rTKwNZemWArDTHUiUciT5AyoE7PbOHz9kyx6BSm8upJ9XjsT0mdv8Pe/EPcn05I46ASi
         EDAFlKmWpGZoqwKGAjUo/v26TF1A+6eJiBysmrUrq+nijIwsJaZg9c006QU4JahVEbPL
         oBAw==
X-Gm-Message-State: AOJu0Ywa+KjdcpNsikO/fPp3RfgOWwUCr/c+m2JNU87m+08WPHjkuojl
	rQEKyliws/1Gqwu56KhRv31lYQn768Pjc4UlW+kiHGzccq1T2Ekcr8Zh
X-Gm-Gg: ASbGncvYG+0peEkDqCSvaC2V1AjCS2mUEPubjia91Lkzghbz4uyjsxQ0Iir+ENCfdAF
	ujBuOr39A1qOndPQqXcE2NRw3GsW14eOEzRlGohKOH6ri62a5EveayCXwWN3zdYwONdrvSWd0sh
	ijgs9bkvjlVfoeIFM4K7+UfDW/d2IcIp+hDlD3NPiiWvIn28YVAgsEFZZ+KEEHoIC6Wb1KBhXtC
	BVy0gva99BVF52HEs1qGaxeb/nhydfRRWC89FWaaqmbzIhTI0SJG9EHI1xF/a4GO+8rh2h/acak
	d4JBD6SezGZMRP6Vn+Z+g02bdsc66NbKJZiZCqrnnKbDaYbu8Ym/AchRaL3R/j3K7qunRq0EzNJ
	m/g+VlKYGvYATdlj5YZYF67O1uHxjh0buUIyo/zAjawbcPn/iNIUBuX+iKg9GmHhTE9feM2TBTb
	IK
X-Google-Smtp-Source: AGHT+IG6slYV++7vHzGlsbHMztlpGNFFzGbp5Ebs8eOKpLASOUlXgX4bkHj8ENDKu8wZXwmEFqrZeA==
X-Received: by 2002:a05:600c:35cf:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-459e70eeb46mr66754095e9.18.1754573996121;
        Thu, 07 Aug 2025 06:39:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm367456095e9.25.2025.08.07.06.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:39:55 -0700 (PDT)
Message-ID: <d55b3745-8471-4c57-aced-7813716a216d@gmail.com>
Date: Thu, 7 Aug 2025 14:39:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: permit 'drop' of a merge commit
To: Johannes Sixt <j6t@kdbg.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Git Mailing List <git@vger.kernel.org>
References: <37f6e34c-91aa-4e55-88e1-019d2e042df3@kdbg.org>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <37f6e34c-91aa-4e55-88e1-019d2e042df3@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 06/08/2025 18:38, Johannes Sixt wrote:
> 4c063c82e9 (rebase -i: improve error message when picking merge,
> 2024-05-30) added advice texts for cases when a merge commit is
> passed as argument of sequencer command that cannot operate with
> a merge commit. However, it forgot about the 'drop' command, so
> that in this case the BUG() in the default branch is reached.
> 
> Handle 'drop' like 'merge', i.e., permit it without a message.

Thanks for fixing this and also for taking the time to extend the 
regression test.

Phillip

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>   sequencer.c                   | 1 +
>   t/t3404-rebase-interactive.sh | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index aaf2e4df64..9ae40a91b2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2720,8 +2720,9 @@ static int check_merge_commit_insn(enum todo_command command)
>   	case TODO_SQUASH:
>   		return error(_("cannot squash merge commit into another commit"));
>   
>   	case TODO_MERGE:
> +	case TODO_DROP:
>   		return 0;
>   
>   	default:
>   		BUG("unexpected todo_command");
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 6bac217ed3..34d6ad0770 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2262,8 +2262,9 @@ rebase_setup_and_clean () {
>   	reword $oid
>   	edit $oid
>   	fixup $oid
>   	squash $oid
> +	drop $oid # acceptable, no advice
>   	EOF
>   	(
>   		set_replace_editor todo &&
>   		test_must_fail git rebase -i HEAD 2>actual

