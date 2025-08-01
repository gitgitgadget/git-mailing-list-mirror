Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866F1D5CE5
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067264; cv=none; b=ajz3WoJyiVXeTPjmyEn7fAl0LlMLhBtdELpXj9ZYpFo4UQNTAGA6Y6yKU6rSelqeshDl2TCckFj/hpfqpU5YaUS4LP/yreuysM1b/NLsd2Y0enAt7lq00tugadgcplj0+EnRQs0MYzd9Fh2b3Fa1DQVnUq0eQtpZkN9a2VdA8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067264; c=relaxed/simple;
	bh=nhF/riTZc+r88mn7BGQ9bu7ugyfmBuLCO9NkMPMaAJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvhKO6ATDcLx222F3jBWLqozQUhxHL6rCm/nMHH9QztHteQ7w9IPmxUhYZHF5mjcoDoNd+9rh7povjs/dQahCr25l21w0ezfORIoXCGcZQz3B/52aUThErHRuWzy0Ub8EFky56GqaD41Q90fNlPBlITXnG6vSvbJNr9k1zvoLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2RulQAs; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2RulQAs"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-302fdd379faso548833fac.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754067262; x=1754672062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXRJimVC+LiLW5xSIw11jhY4xjVHUvahv8fpPk6PzmY=;
        b=N2RulQAsrpZ+iPt82Ocu1WvWiLE9e4vMFNKI0FSLJVhhEwnjHfhZJcSMjkl+bzTyoX
         P6GVS7rmKK6HJCsusYvZO/o7je8v4fOrk5Eus0LSbvhBTQqm5MgK2iM0fpVZLWHy8HrN
         /hTUrjCj0V1o8pSyF6qEy1O1HScx6A3r+APQ0j5qq7gAGGgpw3kVqASipS25+qL0RAUw
         Kg/y9ZBSiEmmwk3GxVSVzrLJ7V38Aucu9CuefMOnLU5vVsRU1hm2NdHETcQn17DXKTqi
         AKGXUj5CBnM9fcVtHBkJZY2LVcCqXIQNFHduiL2+aIb+3gIw+a5MNt7yE86s4YFFrnX+
         evHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754067262; x=1754672062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXRJimVC+LiLW5xSIw11jhY4xjVHUvahv8fpPk6PzmY=;
        b=wXRQah0dcil1+lQucnUT4+I9eQf+jURty0bAFSGPiyF2lv61SQ+OFRVnT67+NwTgLy
         gBgY8ODFs40c4S5Cnnai2fjDSVmizfYZsGw0mgY15X8CZUdtA3xn/61AX51hgQ4AyrUb
         CGXTzMefw6Pbn5jO50XjlyfU/Nah0Wk+chb9VrZz0sjFY2g0QcsSFF3whEUYdxQX8km2
         4bCDzuLU7R74yOiR+Yov+6+dP2Jo02flY1jLuF1wOj6bOlGjgKMqX58VRcoxYu41FrKq
         Y+HFfXil1FyA/tjgatFWsfqPepYqsDCtHzFNCxob+ho/jmhEVSYjGmgOR9liPCVQNX8l
         MkIw==
X-Gm-Message-State: AOJu0YxnUUFb873FpI+UnLw76euFI/IJNR5DmQnW1eNQvOxGn7S833eT
	TgukgzlccsABYCya2c4I8WfxdddN6maTvs4ctgoW3ISKsEDlrIr2WBs9
X-Gm-Gg: ASbGnctm8ZxxHFprCdSbue6HxUMFh3v0JjQn2CCTl1I/VpCsUrldQpj3au0QNaM0x0N
	4ezKuJLMLc4a+6/BuFbvLsOYKJvmMpSRCuSKfYNBE9B1ruT7ylfceJu7aqj2qsn0nBGX0R+6t3G
	opt//BgZbaUfzPV2EHA/gjS3Jc105ybp+9f5c2ioaxPwZ81T4+ZhI9OxutK/qLb32uB18KvZG51
	C9lJNgv9FVgvLjyoY30ZRaIAi7jTN3/JtQe31+LRXT/TugyEUSIgGhuWsQ4w4M0Hs0KcUXUml3M
	LZp9O+BsaQGG+NrIC8B8aus/vuNdEoW/A3Pi+DYNMvOAya1Z7T9IIzaDIoICd44plXMlD1sG/gP
	7X4gM7q8W5WYAsEI=
X-Google-Smtp-Source: AGHT+IG0qJiwJaQU2x1u29zzN6imKZLXeOj4JknNXbn5eFOt2ZmVOWPdFmtSNCVWX+wr9YpS6gtGNQ==
X-Received: by 2002:a05:6870:7195:b0:2ff:9e3f:dc8f with SMTP id 586e51a60fabf-30b6780daebmr180971fac.18.1754067261881;
        Fri, 01 Aug 2025 09:54:21 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-307a7122e02sm1013279fac.8.2025.08.01.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:54:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:48:22 -0500
From: Justin Tobler <jltobler@gmail.com>
To: chenjianhu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, chenjianhu <18230222379@163.com>, 
	chenjianhu <chenjianh@kylinos.cn>
Subject: Re: [PATCH v2] t7450: inspect the correct path a broken code would
 write to
Message-ID: <5hdj64ha2b5ewydtrra2rbzofgzaqnu2rt5enlarqs6u4grjsg@pkdsa6plxsuw>
References: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
 <pull.2022.v2.git.git.1753933780883.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2022.v2.git.git.1753933780883.gitgitgadget@gmail.com>

On 25/07/31 03:49AM, chenjianhu via GitGitGadget wrote:
> From: chenjianhu <chenjianh@kylinos.cn>
> 
> Prior to 05e9cd64 (config: quote values containing CR character,
> 2025-05-19), a repository can trick "clone --recurse-submodules"
> into running a post-checkout hook shipped with the project.  The
> test was written to make sure the trick would no longer run the
> hook with the fix in the commit.

Yep the first assertion in the test exists to ensure that the
post-checkout hook in the submodule is not executed. The test also
validates via its second assertion that the sumodule cannot be tricked
into being checked-out into a symlinked directory.

> However, the test did not check for the path the hook would
> create; correct the path to the expected one if the bug were
> still with us.
> 
> Signed-off-by: chenjianhu <chenjianhu@kylinos.cn>
> ---
[snip]
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index 14b5743b962..f512eed278c 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -401,7 +401,7 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
>  	git -C repo commit -m submodule &&
>  
>  	git -c protocol.file.allow=always clone --recurse-submodules repo bad-clone &&
> -	! test -f "$PWD/foo" &&
> +	! test -f "$PWD/bad-clone/sub/foo" &&

Yep, this is the correct path now. 

This patch looks good to me. Thanks for fixing :)

-Justin

>  	test -f $(printf "bad-clone/sub\r/post-checkout")
>  '
>  
> 
> base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
> -- 
> gitgitgadget
> 
