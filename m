Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB7D299
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/WXpu+1"
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E7C9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:24:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so3070335a12.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698679492; x=1699284292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4SYWbvZvQw9SR2yAvLlG2DmkmVs1KzGN6xNuuLqjcc=;
        b=A/WXpu+1HePLtAX15xde32GqfL3mOrMu7Y0Y7IwRP1F7LkrdauxqG5Fjew0CqVQk+m
         cqyH3To5xCuuEx993NLpUezm3bbhvRlwPwNBebeYzZVxkt3jspoujjPR3b/BUkVwRwQP
         1lvShXsD4eYvLRBsS85MnWy67UZF0AL6fbWVN4kA9LPnS5qSdQJ0uO3JVfCCpotVOUou
         MgTNn/OCDFm5TuPP3gff/q/1+YXnS+nhdy2aXtWZCcqO0RNip/ybGmAIt9+l1HxJLg01
         qweMTRPL6o/L9HhbFwfAJs3zRuuHgHVIkwWnninmVyiYro4wwfmGHhrb8kO0851PYN9u
         Rh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698679492; x=1699284292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4SYWbvZvQw9SR2yAvLlG2DmkmVs1KzGN6xNuuLqjcc=;
        b=K8NK9K5e/R0xzQUVWEJ9CwwvJUD/vqOhaQTpEY+jNw8Gc2QpRig3a5SfCtcm8YvpcM
         PokuvHj+DqlyGPeKQkho5BAoMOLBkjC2d+FZ4NEap4Uosar6FOpsTjoP2XzYO7Z8IULn
         /m3UZyQHUz4MMRLnWY3dKr/v1Nv+gu8VwWW1ZHetfpTc2IYKzeXpmwgOjdCXBg9mMa/S
         CTzUZ2qyaEY8Sz8+2FGvW3RctA9MH0wFX+rfBdhEmSrA0ZeDdgJ3mYdB4+wJwfBa/KfH
         KN67ccim1ITLg3/qjmqC0sUPpqGfx74Nt1dtlW+t3rmCf78njDU4MAUSdQLtdmzTjjyV
         FKdw==
X-Gm-Message-State: AOJu0YyMxa4kSFjJKhhZL4tZJccfbOa87fcXtYSVzOUGaPnuBRiMw8kG
	A6AEBC4hEEXOCZK5cz6Xc5Lc9msXq8wYkg==
X-Google-Smtp-Source: AGHT+IHC8mk4L0mVkR5UHzz6q6jZN2GO6la/WZeOrwnrOf0iR5cB9gbMKoQgt6Cx5TKnDqS+T2LGyA==
X-Received: by 2002:a17:90a:4f47:b0:280:23bc:7ba3 with SMTP id w7-20020a17090a4f4700b0028023bc7ba3mr4104893pjl.41.1698679491734;
        Mon, 30 Oct 2023 08:24:51 -0700 (PDT)
Received: from ?IPV6:2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9? ([2001:8003:3cef:4901:beb7:1ccc:62ea:5ce9])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b0027d0c3507fcsm1548154pji.9.2023.10.30.08.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:24:51 -0700 (PDT)
Message-ID: <b310e254-f6d3-4715-b042-341bf5a98bbc@gmail.com>
Date: Tue, 31 Oct 2023 02:24:46 +1100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Repository cloned using SSH does not respect bare repository
 initial branch
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <63eb269e-72b9-4830-98fc-aeef8b8180d7@gmail.com>
 <20231030093605.GE84866@coredump.intra.peff.net>
Content-Language: en-US
From: Sheik <sahibzone@gmail.com>
In-Reply-To: <20231030093605.GE84866@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Server version is same as client (v2.42.0) as I ran these commands all 
on the same machine.


Test on ssh server:

$ git -v --build-options

#Output

git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh


Thanks

Sheik


On 30/10/23 20:36, Jeff King wrote:
> On Thu, Oct 26, 2023 at 07:36:36AM +1100, Sheik wrote:
>
>> Repository cloned using SSH does not use the branch configured in the bare
>> repository however repository cloned using filesystem does as expected.
>> Shouldn't they both behave the same?
> What version of Git is running on the ssh server?
>
> Your example seems to show that the parent repository has an unborn
> branch (i.e., HEAD points to "refs/heads/test", but there are no commits
> yet). I think the server-side bits you need for that to work showed up
> in 59e1205d16 (ls-refs: report unborn targets of symrefs, 2021-02-05),
> which is in v2.31.
>
> So even though your client seems to be v2.42 (from the output you gave),
> if the server is older it may not be sending sufficient information.
> There were also some other fixes on top of that, but I _think_ they were
> all client-side (so your v2.42 clone command should be doing the right
> thing).
>
> -Peff
