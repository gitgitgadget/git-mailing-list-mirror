Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A63914E0
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956466; cv=none; b=TrP2C3IqWQ8tG9Fb0pQs2HmM1wT9QCm2nutQawQ7aQfV3qD7xNV5pHC8E+gPCLn07T0Jy2jP6jZuU31gS0z//BrqtZ6SZInsOvQ5PYhfT5fE0ZztmHxc9gji30ry584+mBG1Q4C1dKC9lRZPmVVzwz+MBt2ZpRRSo/S60kH+nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956466; c=relaxed/simple;
	bh=T9/zQTe7fZX4unHVwo+awtJ2JqT+wtcMpcL9GyZ0KfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4104th9dJ+RTQHtJ/3MO3Rd7ABsMmBbDbdaBYI7BMENYNQzfGQSPzy98lS0GMJeYHrJ46IpxtIP9gBjbEPpEyN2wv3aH9cP5eZdFQJDspQfmsBQakkZuprEkmcjrxlw6a07lG88YJlBZ6e+q803/gHzDXKoYQpPI2DOrS6+DDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG+nJv9g; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG+nJv9g"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493ba701891so342205e9.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783956463; x=1784561263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HD/A1FIv2lm0Npxx4TJCHOHW+6AJ8Mq8Mpi7c5xfTNM=;
        b=YG+nJv9gsG5AC3vzR/hFGLerR2lxCjQVyzh6URoAx07Sl4cJ894u+36Df/psi1R4J6
         7zRwv9MtK1eVaq/1AQsYC8NPN3hpCp3hw0I3reNzA5K2fQaz8g8QyPlpwnL2Db2dlnpZ
         q1HT8NZIHdFj9OSBta57VZ3Cmwn3eULFQdgUFhxGLDFY11rNt80mEmRHjP7PJsXjgxkJ
         lzy45bV0ZQ8dC6C4LcGEQZBwR6MkOKhgozLVzjoIJXSFy77R0tDmUH4W8Ia8twxkS/F4
         IdISIP+DtxOOBif6bgzTyUL9Tc37fUaLup2BcB1ruwGRthlsExWxdt77suqIqI5bqQdY
         XbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783956463; x=1784561263;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HD/A1FIv2lm0Npxx4TJCHOHW+6AJ8Mq8Mpi7c5xfTNM=;
        b=EFf3S4uvWQT/skzaeL8BQqzEX83oFlOTDnXfgWZ9wac4VP/jXUC8k4Q8ax8KF291GX
         +OEfLn5J+AKf2l7TQXwxh0X+x/wKxF4vvfNT5X5ibIkOv7Zay9uk5pPILkjSVNFPzeO7
         SU/wb8DdUQutDPnvrxNcCR6wTozWR0P5pPZDOtR2GS08OShxf+n7NbV8SneQ0rliqXDJ
         dE938fDMBu0pu430dlsN8/CjRbi1ki0PZ5ab7A0NEOgrjLnb51su6iXpB7DBqSMJ7D5p
         F9GEHMxwt4wdCIcw78DJntp1SH5pp7W9gMu7EzyWvs0bCfYTQnL/jLFXRrzzcSZOdQC+
         OAlw==
X-Forwarded-Encrypted: i=1; AHgh+RqKgOet/uSTq7R65RFGzreUkaRKlf42MF+m0yXSYZwuvJbo2WG2KtAPEjgXoQwlFH/e2f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoM5iPwV0o03Oxg8V61frgbWutjObHQYyPznSyQdgK/5L6/wwK
	cgdxIA6sXU8pJ4+mmrCfKYTqCxnPRpsVl/4LNsbbwpdaViQqI8G4EaoA
X-Gm-Gg: AfdE7cm8VIlFNV8yNK/DtZj8MloLEvXaw+KklI91dmDUKUtb64S4IoWQrHwsSsZkmZH
	E0EmVz1zjOqhjrn1ms+sG7gN8Nsmv52shQ0tzPpb9FCTf9Fn2HNq9sJJ5ZA3dztmV6oUS8qYBZH
	VHxvTxS/rQ05oXvQOt1JqyUrzOgNlbqjxdjlqxhb/n12syV2Fjxayswv5cjE3Xye+EbLjrwEF+u
	+F4NZDh5bQaVvOA4aQiGsJyA62vE4YdOAvuykAE9Gs284WcaX+8vmeIJVYiMZ5Y3I2rVSJfOZK1
	SndMRkgp1Hk3AN3fnvuN9A9hYaE0kUMvPBGxoMZVCkv7wlCx6JkP9IhsYCRT7tkRKHry7DZ3iq4
	Z2kT24iIpUsYffluN+yZwBmb7UgI+WJy533wUj3bpQAaRSuPaj03GA7OFQ7letMplUM3d5t8+C1
	yZ2Xny+3DiwVX19/U8JHnPYjcdyhY1umg1UjQMTyPbGNHDCdcxwpmcWVfIGGA/jlOiLVk=
X-Received: by 2002:a05:600c:a40c:b0:493:ee4d:5c5d with SMTP id 5b1f17b1804b1-493f882cb8cmr69331635e9.31.1783956463117;
        Mon, 13 Jul 2026 08:27:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a974csm130338f8f.18.2026.07.13.08.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 08:27:42 -0700 (PDT)
Message-ID: <f53f7140-b9c0-40dd-8bd3-89917a4eb2a2@gmail.com>
Date: Mon, 13 Jul 2026 16:27:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v18 6/7] branch: add branch.<name>.deleteMerged opt-out
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <d52d717b70c80b668e6d3a1fdf186ab4846664c7.1782338106.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <d52d717b70c80b668e6d3a1fdf186ab4846664c7.1782338106.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/06/2026 22:55, Harald Nordgren via GitGitGadget wrote:
> 
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 047ba54778..b7595610d9 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -2024,4 +2024,30 @@ test_expect_success '--delete-merged clears the upstream of a kept base whose ow
>   	test_cmp expect actual
>   '
>   
> +test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo_for_delete_merged &&
> +	merged_branch deleted origin/next &&
> +	merged_branch kept origin/next &&
> +	git -C repo config branch.kept.deleteMerged false &&
> +	git -C repo checkout --detach &&
> +
> +	git -C repo branch --delete-merged origin/next 2>err &&
> +
> +	test_grep "Skipping .kept." err &&
> +	test_must_fail git -C repo rev-parse --verify refs/heads/deleted &&
> +	git -C repo rev-parse --verify refs/heads/kept

As with the previous patches, I think this would be nicer if we checked 
the output for for-each-ref. Everything else looks fine.

Thanks

Phillip

> +'
> +
> +test_expect_success "branch -d still deletes a deleteMerged=false branch" '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo_for_delete_merged &&
> +	merged_branch kept origin/next &&
> +	git -C repo config branch.kept.deleteMerged false &&
> +	git -C repo checkout --detach &&
> +
> +	git -C repo branch -d kept &&
> +	test_must_fail git -C repo rev-parse --verify refs/heads/kept
> +'
> +
>   test_done

