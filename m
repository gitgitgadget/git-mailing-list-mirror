Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59220DF6
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094099; cv=none; b=ezn2oVAXsvcWsDAkEWSbtqZI4OaTVpQLNAJ7T7DVIx07PjqtG3QdXKmgnhhB9YcGf9QMbDKwu1Ipid0r03pcmNhuwSa8tPB0OKSmp3YKbNiftLoUilPzGoDWCdYChxE6cr3xwP/KAMJ0GS6EwGV5z2zywOz1/0KqsOzA3ZZQTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094099; c=relaxed/simple;
	bh=dmRXW6ByM6OhuCGMoKbnWXPKJYPL33bs2+KMDUa82zA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c/hFxLjVrdB0ZV5kUfBpYP0qjU2ntXMm9cnsJ4Z0AYti6SY9k3R9olQri3HFSTriO/I7MIyCS+TA2EZ/mCyE+2vvqSdhE1ykyQ4bVxf1xu6ou0Okj5g1JnQG/10Lkx0v2WlCTuXQxSiqAvU/c/iU2dPvEEzEaoRa87VVlmDY4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCgq5qLk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCgq5qLk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3394446205dso1408220f8f.1
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 03:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706094096; x=1706698896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XEm9OwD6L8B1rrMwjwUG8we8Het9yj6ZPrWbfrl6cz4=;
        b=mCgq5qLk3GW6WElx04uHNdeNB7WwvobqPffKwddjqxR8DXsqln8z4KDRxAe6nx5TPM
         4q2fxs3KFj65I5zzJ1HUGCRsk26lSU6llp9zdK4hlx/UPrWwKKb0y69hUepJ6TD5M1lT
         gLjPO6mK7+tIobXZA0yWg+YShtNkrDDEX//knU91021BLOX+vaJoDXHmXct56f6C1F6q
         hk6b4cRG0hHvx+Civh1Nmiqp8ejwRNvH2vpd2dFLxNYHtKocnZlYorO4+aoEb+PRNGPV
         w4SPCdObq+rInGmyBfR+ydBGTUXIokWiQoaLI24ZhM9eaUnSijg8hLTSB7uU7yrcuMpG
         8W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706094096; x=1706698896;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEm9OwD6L8B1rrMwjwUG8we8Het9yj6ZPrWbfrl6cz4=;
        b=lTOCvs2b/j25XBLAPJp3GDZchJVU1H1tWSxyACB6hlj+407T+F0deEfRNIaAuA1wP1
         hhiX70IuO60E+HYANJL/reEgDHbsGT1MU5S4MTQLYxlVFF1X1+Gfa9c9+iNNuz5dWoAr
         jeRjc9RKPCBM0Rl9bJSMpyz/7KdQK7vFGo2jrbc30sC58qxEyfvfOETLVDOrw7ZI/rLz
         7Dwa01tzq3jM3FGk1ybco/jEiOBlUdGrS5+h6LEDHV3C8hxnqUqqP5Xs+Gp+NFznpJcV
         hiBYgrtHyUR4RY/0Eu14Yq3qLkaz6TSiRpqUf0c2qEIUmKTdRdYtzNc3jW6P7m8MbB7B
         Ydsg==
X-Gm-Message-State: AOJu0Yz9MP7LSckZYA1bleD60HO7F0dCVyY250szyetN/XOjYeIJDIDK
	dcb/3r63NXnW9IsNvt/1YtOI9DHkejOvO/hak6cp9e9JXqRLHGwh
X-Google-Smtp-Source: AGHT+IFwkt0xC+Zz++yomBUT73/GmKgZN8DiW4ZU3y4Xt7ffrS2HAg0FVVZqmF19t2Z17l3GoH325Q==
X-Received: by 2002:a5d:6a10:0:b0:337:d6c9:19ce with SMTP id m16-20020a5d6a10000000b00337d6c919cemr408560wru.131.1706094095526;
        Wed, 24 Jan 2024 03:01:35 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id e11-20020a5d594b000000b003392bbeeed3sm10076232wri.47.2024.01.24.03.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 03:01:35 -0800 (PST)
Message-ID: <ec05c0e9-20ad-42ab-8858-cc4ae0847d5a@gmail.com>
Date: Wed, 24 Jan 2024 11:01:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
 commit options
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
To: brianmlyles@gmail.com, git@vger.kernel.org
Cc: me@ttaylorr.com, newren@gmail.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <7bf5036b-9f55-4451-a13c-8a2c815dfbb7@gmail.com>
In-Reply-To: <7bf5036b-9f55-4451-a13c-8a2c815dfbb7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 23/01/2024 14:23, Phillip Wood wrote:

> rebase always sets "opts->allow_empty = 1" in 
> builtin/rebase.c:get_replay_opts() and if the user passes 
> --no-keep-empty drops commits that start empty from the list of commits 
> to be picked. This is slightly confusing but is more efficient as we 
> don't do waste time trying to pick a commit we're going to drop. Can we 
> do something similar for "git cherry-pick"? When cherry-picking a 
> sequence of commits I think it should just work because the code is 
> shared with rebase, for a single commit we'd need to add a test to see 
> if it is empty in single_pick() before calling pick_commits().

Having thought about this again I don't think we can reuse the same 
approach as rebase because cherry-pick and rebase have different 
behaviors. "git rebase --no-keep-empty" drops empty commits whereas "git 
cherry-pick" wants to error out if it sees an empty commit. So I think 
your approach of reworking allow_empty() in the sequencer is the right 
approach.

Sorry for the confusion

Phillip

