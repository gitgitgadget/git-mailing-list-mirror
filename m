Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892B35F16
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5/whIRG"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763768E
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 07:09:15 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40859c466efso53918425e9.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700060954; x=1700665754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JwqI1/oS5PbeKX4Z3NOWe5gmJ3LR9mpz849srXa/LM4=;
        b=j5/whIRG37JQsxIHGhgmdUnUnDfYla2r6yZG4yBJx/r7ELhw5Y2d9P9gIucEUN6WAU
         VutYwwNphiyB/gs/gp5EBwumtV5QFdoLsFHxPPlI1U3Knvp14E+zp4KBzOgcgiA3LB3X
         r380VhD8GWFRwjE2j/HygugZd7L2KOrcEr6BQNx+TtSeILzBnTqm3x2/uR5VnNQvNglw
         1WseWSZAo4r0tc/Yu459m7V5789urZtecbSxwYGpNYnNGEIigqUi7pk4a0pG2+3JdvA1
         mLGZmSo+OyxRR98Aqe5mgTRqDxQjqil2mv43a1wQ/ERc358f6g51uQHlup0FBGO1OqZf
         N4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060954; x=1700665754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwqI1/oS5PbeKX4Z3NOWe5gmJ3LR9mpz849srXa/LM4=;
        b=b3PBjCd1t+g3H0fvD/5gvqE1nWgdz/cha/vB4si4XomvBJ1BfpUWjLF9okv+a0zfdx
         ZPGsWBjVoHH2Zi9LtNMQfqH+sYyON/ONIG4aE8FuajpY6V47wPiWSmi1m5PMiBsIcyVA
         OnJvVqn/1p69i0md5jiXpFJekxrsF50AwGigXWHyDfpEaB6dUwhdJ650C2C80U2+h7ip
         2qbXIpTaBxyX3z6QchTuHBx/qNjDaiukC/l/Pcf1eQW9MPAx35m6BVyQf/1FLZtdtA2s
         HNVrSb0OO8qy+pHZQ76wrTM6gJEh3ayBF/Za6c4L0Qr6QDt5uY+/5STt8VVVN1msdizA
         oeeA==
X-Gm-Message-State: AOJu0YxvI/rD3a9Sahz49RxOLeMLQL2czsggQjTt7nVHpdYCkAijSrU3
	O1ce1KpB42ehO8BB3LB+qnoC2A5I4wc=
X-Google-Smtp-Source: AGHT+IHQ+lZrxd6seHv2ZOgX09ahdTZrx+pnIYAGgG1emN22Q1fwQ7wkLGMaWca6/Her0ZdGdS7DHg==
X-Received: by 2002:a1c:7502:0:b0:408:39d3:a26b with SMTP id o2-20020a1c7502000000b0040839d3a26bmr10885445wmc.40.1700060953578;
        Wed, 15 Nov 2023 07:09:13 -0800 (PST)
Received: from [192.168.1.212] ([84.64.93.134])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d6341000000b00323293bd023sm10825998wrw.6.2023.11.15.07.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 07:09:13 -0800 (PST)
Message-ID: <eb62435f-08ca-494d-bcc7-2568df2bd7fd@gmail.com>
Date: Wed, 15 Nov 2023 15:09:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] rebase: support --autosquash without -i
Content-Language: en-US
To: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood@dunelm.org.uk
References: <20231111132720.78877-1-andy.koppe@gmail.com>
 <20231114214339.10925-1-andy.koppe@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231114214339.10925-1-andy.koppe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy

On 14/11/2023 21:43, Andy Koppe wrote:
> Make rebase --autosquash work without --interactive, but limit
> rebase.autoSquash's effects to interactive mode, and improve testing
> and documentation.
> 
> Changes from v4:
> - Fix amend vs apply backend thinko in commit messages.
> - Squash patch 3 for testing into patch 2 and improve the commit
>    message.
> - No source changes.
> 
> Thanks again to Junio and Phillip for their reviews.

Thanks for the re-roll this version looks good to me

Best Wishes

Phillip

> 
> Andy Koppe (3):
>    rebase: fully ignore rebase.autoSquash without -i
>    rebase: support --autosquash without -i
>    rebase: rewrite --(no-)autosquash documentation
> 
>   Documentation/config/rebase.txt        |  4 ++-
>   Documentation/git-rebase.txt           | 34 +++++++++++++----------
>   builtin/rebase.c                       | 17 +++++-------
>   t/t3415-rebase-autosquash.sh           | 38 +++++++++++++++++++-------
>   t/t3422-rebase-incompatible-options.sh | 12 --------
>   5 files changed, 58 insertions(+), 47 deletions(-)
> 
