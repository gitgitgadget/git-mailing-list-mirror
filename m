Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2227A441
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719929; cv=none; b=MWQ8z1bOfl37AsRGU9hptKzItHsZpABb5cQJUw65OnMNA4J4cjcPCPguTSqVGoSEt6OLBBL0bCSMo57+8xM2wvjX4HSNSnRrJp0lxbwF1nkSJ4r0BuxHY0XGApbFGPq0RtqSu4qwuJ5g/itKpauk8FzcK4Ac0wjbu1LYY3r4cyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719929; c=relaxed/simple;
	bh=B5G9JOO4vhZkJRX0Fw0ZcWjSQwhT7mUA5ePa5HGBF38=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bcyPsbK54Q3Y2AKg6z6rOxNgVlfcpOFDOXqM/ZcnHvD4Fq28K7DqZRdy9tOBK0Q60L9Ax5m35k6vI6+caQy/CoNSSQuA/vHe4cdafd7RQnZSKfrsgshNZI8LBPUxHsRB2FZhRoGaZG0Kwe6Kb12+2GlpHNi4582Lp28uUXKx9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA68lRuK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA68lRuK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso7363435e9.0
        for <git@vger.kernel.org>; Thu, 08 May 2025 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746719926; x=1747324726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ospgAYzA5YT5tzQlRMgWovDYxc/l84KDzzMjRSLERGQ=;
        b=eA68lRuKD2sz7BHIEEdavF37yoDit44Yd4yoAnFrdQ7jOyGn4rdJ+/OAt1GYebJ/3N
         4iH/bWTSHGCaFGoC1HeFuv1h8mxtaW3+6XQppWTsb48jKoVrwbCfFcxEIauqrLOrnUwS
         Mk2Oxyohx+xVb5kDK+j4qVKvOXDUy40mIZqiR6+X31z6wR/o+uUCyTlRn9PRoihWjqMZ
         ZMgpOBmBMzIMZKtDbIjT9K897eGGFLrGgc3T0akx+7TTmvALD1a991pcl2/cUgM/OzhI
         dvHUvdh564aa/os9GP3TunUFwbI52w3PTEOMYbDP8GZODSPYkBS5GowwFiCIrSps0+2b
         C0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746719926; x=1747324726;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ospgAYzA5YT5tzQlRMgWovDYxc/l84KDzzMjRSLERGQ=;
        b=Bi3C6hte4qwro2TkoD3P+1ffhqzA4cweXB69z/iylPBObv/qi0aETN82/ksDG+dJtw
         dqXlaSnh9FyUkZWNqISs4rkHGxOMTLq415zm3HNSnP7e6lgzqlxXz6MRBQDoCCoszRPk
         0oSiqkj71GLAKkYCwVjXEznmOodoQAeaxJIJEM81/QrLbGoSU+VjvFDvi7eFoeaqVU7a
         zxNNp3z9d/jhaI9NC+B9K6wXRfdHzr2QC4zgmUVT0G5xF1B3qdxCcioALMyTcclwDWqK
         djGUnDTtz+hKe5/JmN8gtKi9bU5yS0jeS7RxDyhBbPuMrffm2ZBR768ASFwPZho1URf+
         12BA==
X-Gm-Message-State: AOJu0YxfrSxKCib20HLQILjfGQwJoVwhOe8AhDYVnSkPZ8Jdj82hxQfM
	Ef894baGgzqVs3fUVajXiOFNpKnzKomon/ODLV0crTB75oJ+vH8N
X-Gm-Gg: ASbGnctXRrtk48wV+l8MquBWJ41gZGWuQJd+MNpUXTusxcrwGBg+e6faJVUz//k+uCA
	xy/Ls9snmvWnAjaDR7IDvxJZt2ImarNlvUKEGpSxpr2YCz5b+iKWUQIJk3Hl3gOJ2gHvyQ25Bnc
	VRIdA8lQrCgSDSO/jMGriuSTirP2qHcxMvNI1qVkuceTF0yBV0Azu9MFaAGjXdx4U3nZdWx16Cw
	N7xct9jCaGxmHpnOlzzEAJfXcybekL95m+U3mQ2Sh++13jWZ0i5qNIkBcYvsQjCpz7hsudaJcn7
	AkDIRcdoI8FoUxfAJCQxoQHdG9b5MeT1sVaq40Db4q12oRlV/zK/AGwvCbZ5fhNcvNPQ1rmN5BB
	LUPaNJf+TaGtsANy079HjTzhVZvs=
X-Google-Smtp-Source: AGHT+IFrIhKudR/U4yuRJeIalomp7IYB5BqiE7OWfGcBvMBa0rkAK+M7sm+7dCPvMngk6Lvy6m9oAw==
X-Received: by 2002:a05:600c:1d08:b0:43d:94:cfe6 with SMTP id 5b1f17b1804b1-441d44c7addmr81086075e9.16.1746719925570;
        Thu, 08 May 2025 08:58:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm354513f8f.22.2025.05.08.08.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:58:45 -0700 (PDT)
Message-ID: <1b6545a0-5981-4377-9709-39ff29aeda6a@gmail.com>
Date: Thu, 8 May 2025 16:58:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/2] rebase: support --trailer
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5ad7fff.c587c495188189.5980390754046003962@linux.beauty>
 <951d3343-fe97-4e7e-bb73-1c569ff10ee6@gmail.com>
 <196b09c1324.fba686d21234508.1995945025408421751@linux.beauty>
Content-Language: en-US
In-Reply-To: <196b09c1324.fba686d21234508.1995945025408421751@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Li

On 08/05/2025 16:55, Li Chen wrote:
>   ---- On Thu, 08 May 2025 22:17:17 +0800  Phillip Wood <phillip.wood123@gmail.com> wrote ---
>   > On 06/05/2025 13:58, Li Chen wrote:
>   > > From: Li Chen <chenl311@chinatelecom.cn>
>   > >
>   > > Implement a new `--trailer <text>` option for `git rebase`
>   > > (support merge backend only now), which appends arbitrary
>   > > trailer lines to each rebased commit message. Reject early
>   > > if used with the apply backend (git am) since it lacks
>   > > message‑filter/trailer hook. Automatically set REBASE_FORCE when
>   > > any trailer is supplied.
>   >
>   > I think this is a reasonable idea but unfortunately I think the trailer
>   > API needs improving so that the implementation
>   >
>   > (a) Checks the trailers given on the command-line before the user edits
>   > the todo list. That way we reject invalid trailers and exit before the
>   > user has spent any effort editing the todo list.
>   >
>   > (b) Does not fork another process to add the trailers. Without this the
>   > performance is going to suffer. Hopefully it wont be too difficult to
>   > modify the existing code to take a struct strbuf and a list of trailers
>   > to append to it.
>   >
>   > (c) Only adds the trailers on the commandline. I'm a bit confused by the
>   > various trailer config options - the man page reads to me like "git
>   > interpret-trailers" can add missing trailers that are configured but not
>   > passed on the commandline.
>   >
>   > The changes to the trailer api should be made in one or more preparatory
>   > commits before adding support for --trailer to "git rebase"
> 
> Thanks a lot for the detailed feedback and for outlining the gaps in the
> current trailer API – it really helps me see the next steps more
> clearly.
> 
> I have one questions:
> 
> Who should take the API work?
> 
> I’m very happy to roll up my sleeves and prototype the improvements
> you described (reject invalid trailers up‑front, add an in‑process API
> that works on a struct strbuf, and ensure only the CLI‑supplied
> trailers are added). That would give me a chance to contribute a bit
> more deeply to Git. Of course, if you already have something in mind
> and would rather drive that part yourself, I’m equally happy to wait
> and re‑base my series on top of it. Please let me know which you
> prefer.

If you're interested in doing the work on the trailer api that would be 
great - I don't have time myself.

Thanks

Phillip

>   > I've left some comments on the changes to builtin/rebase.c and the
>   > tests, I've skipped the changes to sequencer.c for now as they'll have
>   > to be updated to avoid forking "git interpret-trailers"
> 
> Thanks for all your great reviews!
> 
> I'll address all your reviews in next version.
>   
> 

