Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524D23498E
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593066; cv=none; b=jbyujsIlAUcdsPM2cLKYfhCO1ys/Imbb8XMyLKHVerPd/Xp4bR5d7onjQIkbE08GW5SkADCGAnrp3Xx/fYDBaMyjSvCoskKBn0oDGNW8+q5GgfVwqQ5Y2GhopQ21+QE6+AXF7PSus4AcT32dxr4RIk8lzrYAGKA9NemgR0gYBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593066; c=relaxed/simple;
	bh=eBgPXHdGJeCMXu2BF0LDQNRU4JA0qDYPjBy6tH2LHkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzyTx41zC8aIUdQ/K7VHqbx98WFmB4eSuEJ+WL5cel0ELVh6hkdQ34ZCgtSX8T34o2WdvoNqp8vaG6UDMFc2fmYZ5QCyq9iaFZH8g1Rs4n6rL8ybjcs5OtAhmMR4nPal1YcpnrI40b+wPl1YSn2TBMHq+/kQaTL2iF3m7oX6ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJp3weJx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJp3weJx"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so2319147b3a.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745593064; x=1746197864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/EH7Gm97N4U6P/6YscZy+JI3LqWp4v5TVPwukKZollU=;
        b=VJp3weJxUdQqxIYHrOoQNdpy/+19c3ePEMfvtVkIqnR1/L4o1qxZjxjtY+JNsl1lxu
         0Zb75c5Zb7FWPTYYEq6nfQ3ol5dGc3vO4OO1+iGqasrEr2OkGzxZ6/GEhwuNv1qADsR3
         TenSSMqPL5VLVf7+Am24Ua7d1MSCJ5bkO0TqlxZ3b+llpkSUAacXR3q6kIBZSqMrZmIu
         vOwZJ2/pWo1LBLXMKIpQ8CLLUwHxqSbqSHQa/zxTPUQwqqGPA+EbQQjy8XJZO5WoLgy8
         8fFndZQRPyumR1Oh0e0ABU+q2FL7UNAjVXGvY99qACC8+ZNb6E6es0mAj+kkRqYooaAu
         iY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745593064; x=1746197864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EH7Gm97N4U6P/6YscZy+JI3LqWp4v5TVPwukKZollU=;
        b=TBGrduV12bXAhMpjRojAJVx7DxlenYA98dvnpONzo0TIC9aFCMY0R2dYTis+W0cGJ3
         DTHOndcaTAeY2WxNtCwCKM1krTdJCVrlYZ6ByF6XQGEGaTp1m4U35E8t/WfzDslyLDk/
         ciUpeSZN6+ecWk0FRWmZaeRSBbkSMQ1yM4976pN7mke+e8OJWOpWMOxsGfslkUUoO0kk
         Ii+uNqb2KFdO8KlFr6KugQhlStwvY3SaodN2mA65g1GmvnYjYjCEWcd9OP4VR7BMvbSM
         5fpLdR2/QCWcus85VteQzod8QYwZoC0QAOKuxKQ+pI1xK54zDpbi221PKjo9OTL7uriV
         zDJQ==
X-Gm-Message-State: AOJu0Yw7nqTLKIan2oDJsdj9rpt3OIQwPOZE/vR/Qkotr4z418hfz707
	5919W6gqrhjaBK/7EXHrb5kLJ0KGCJ/iio6YSHxdq2LUhksbSIoq
X-Gm-Gg: ASbGncsTxVDGSavG2Gwks/Hd7BvdABnrsFV8grb0Beca3HY0MqFi8jPouvxc4YsPQ0H
	c/ztd5jaOgQJ/9Uu2yR1xHP5NFVyEj1VGjFUf1FBqgqNVLwa3QT87gVylnqc42Fn2vK704OQF2K
	YPDLsGv/zTZkuXTZZ/cVSbJP/wYjuLBP05KRPhT87+WWBGmFaKhP6IYGi10hql1qn4NJYmJgQGO
	hXSPn+k4rKUZrda2L/zAi7anplgozruN8BiR8S0EL6ga2MIzSJf7Szl+0ABtniEUeoPVf2nqsX5
	/jVCSngA9eQIfGzS6EMBPUzgCMgWbgoWxZDJXreiMHEyseU=
X-Google-Smtp-Source: AGHT+IHxrx9lTVI6c9Y1GUMsiJk5Onpdln5ix1D9AVzyz2hQ9RMPtxdk+BjRQUn0NhcwVK/l0G4hTA==
X-Received: by 2002:a05:6a00:1411:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-73fd9145d0cmr4193692b3a.24.1745593063645;
        Fri, 25 Apr 2025 07:57:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73e25912bf3sm3275376b3a.32.2025.04.25.07.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:57:42 -0700 (PDT)
Date: Fri, 25 Apr 2025 22:57:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: repo.eclipse.org outage breaking all our linux CI jobs
Message-ID: <aAui8hrhm1qAxGcU@ArchLinux>
References: <xmqqfrhxtdg9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrhxtdg9.fsf@gitster.g>

On Thu, Apr 24, 2025 at 03:13:58PM -0700, Junio C Hamano wrote:
> As https://www.eclipsestatus.io/ reports there is no ETA for
> recovery, and due to the failure of downloading JGit material in an
> early stage of our CI jobs, our linux CI jobs are all failing, I am
> very tempted to apply the following to 'maint' immediately and
> propagate it all the way up to 'master', 'next', and 'seen'.
> 
> I would very very much appreciate additional thoughts and advices by
> anybody more involved in JGit community and more clueful than I am
> on the situation.
> 
> Anyway, what is somewhat funny is that at the end of this script,
> there is an attempt to notice and report the lack of jgit (as well
> as p4 and lfs) but still continuing:
> 
> 	...
>         if type jgit >/dev/null 2>&1
>         then
>                 echo "$(tput setaf 6)JGit Version$(tput sgr0)"
>                 jgit version
>         else
>                 echo >&2 "WARNING: JGit wasn't installed, see above for clues why"
>         fi
> 
>         end_group "Install dependencies"
> 
> but because ci/lib.sh does "set -e", we fail way before we hit this
> code.  I am tempted to suggest we remove that "set -e" as a long
> term maintainability improvement measure, but that is a separate
> topic.
> 

I want to know whether we should use the "cache" mechanism of CI for
these third-party softwares? I somehow feel strange that we would
download these softwares in every CI.

And if we have the caches, we could somehow avoid problems by hitting
the cache when third-party services were down. However, I do not dive
into the CI before, so there may be something wrong about my statement.

Thanks,
Jialuo
