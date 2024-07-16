Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126AC19AD6B
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142973; cv=none; b=rv3+0leviYAUc3byCxL3wFRmpYMxhKKN8+VJ/Si0f0Ufy6DQw3r/Eo0v6bV6FGAyY3EhTpMPVZmbJ9jabP8YhQn+Cuv4RI4bF8xWm5K+OPV23v5BY2pBDghC2JZOYBGopdeerJ9tOoPpSxsjxYIoRgmAnLRhR9KUOdxP+qayrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142973; c=relaxed/simple;
	bh=a6CzHEliF8tEXpAm2Moxxjy3LlOlkRaDR6QBE0texqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=prhUHqC68KcmYpUWodnMN3BTLAeSC1LwQUzmoz4MMQl5+59CrPLzpuuRhGPJSXXvD6i9sqWnDH9fWMZRkkjs1Bp7ylIByqThdqlzf1BrbUQuGvfa0bcvoRbMP9A23qRDmWHeKnKU7bdNoB7RN+tePdn53UCVg9jYguBY2tITYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=LHSkcBxv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="LHSkcBxv"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fbd1c26f65so31511185ad.2
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1721142971; x=1721747771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tH0kohYfN/MznaLn50fXl4bcawXzLZeKqkzBDll4Qww=;
        b=LHSkcBxvi9N+5G1mX8Tf6TdTTX3je2tCaIAeJy73RJQAX+VEKUCQg04jsgGpbd+v3c
         aDLOzoYglpit2gdfASeROU8I747/Q9eNy0ZW4r4/fYKUvTPBlKy8O88S0rLMY5ontRK9
         yiG5mduAqMNHdRXmQlqnq/VvlwaF4rkYOSQsHfflgH9+qHb0Lb4AV8LZSY9NnumexZMv
         C9k9ACaJQMMatT2g+wmR7MURxTfuE4+ZW+JWz5iBnHVmLQj7J+/0F4XHdD525uMnFLHL
         207hHcr0XJz1hhvOHWT8b2Vs3EcR8OLEbH+LTnIPkaO0rXYZjnG4XFGwi+GnZYfDxS3C
         +ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721142971; x=1721747771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tH0kohYfN/MznaLn50fXl4bcawXzLZeKqkzBDll4Qww=;
        b=xG9ZR29kGGXlxWi9OPeSHrOQGcIys07vyOtwCuw59boDymMCQ1HioUYn/aHjFOFMtH
         Yz5r7zpys09CoCFSrdJ2Q7DNN2r4ZKahv7VNEH0MDoAlq8CnXJOq45MGkQypCb2LQv1d
         nzudi6ljHTv8FuqyL3I+w+u5L+y+StasEtK72VLKoWcUQxH2SxZbhmBmjaxOw3ry4r+c
         iGmkiqyI7nCJoj92Ff1YEonulHvAR0BoSs9KN8ZrYYyVf4xgXzSY7kcVy0EY3oLwli4q
         EcUMdFOsFvVcW+rUKDCTfd7rmD/K5vu8NqrcJj/s12ls1FrRr8mzjY9QSAUvz+eY82z+
         G1Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWGX/zbSuYCLcmpWiuaA3k8R+c2UklkI9LOCaLtPRCgm0QOH0lCDqmfxOiJ/jEVLnp47zTgj3mSAMIoByxujLcEXknA
X-Gm-Message-State: AOJu0YzTuWxQSC+7JBUrS4zRulw/DUCR+alv6Y8t4QbDaRNaa87yQbwM
	no67mz1qr8CPGV9s5iqhkD185T0aRYTGWIRkbNonrf0qAOgBVnGa3mvR8a1W
X-Google-Smtp-Source: AGHT+IGpcwk9HZFoe9WGZeGlFpc7aOf0sJt0AqOKCYweGhCqCs0wAko2pD+EpthFobqRSSrgPTg+iw==
X-Received: by 2002:a17:903:1248:b0:1fb:83c5:cf8a with SMTP id d9443c01a7336-1fc3caba2dfmr23966265ad.8.1721142971274;
        Tue, 16 Jul 2024 08:16:11 -0700 (PDT)
Received: from [192.168.50.41] (syn-172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4ff05sm59450815ad.274.2024.07.16.08.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 08:16:10 -0700 (PDT)
Message-ID: <047b889e-fa6d-4c4a-b486-0bc80922c4ca@github.com>
Date: Tue, 16 Jul 2024 08:16:09 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jul 2024, #04; Fri, 12)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqbk31b6le.fsf@gitster.g>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqbk31b6le.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> * vd/mktree (2024-06-20) 17 commits
>  - mktree: remove entries when mode is 0
>  - mktree: allow deeper paths in input
>  - mktree: optionally add to an existing tree
>  - mktree: add directory-file conflict hashmap
>  - mktree: use iterator struct to add tree entries to index
>  - mktree: create tree using an in-core index
>  - mktree: overwrite duplicate entries
>  - mktree: validate paths more carefully
>  - mktree: add a --literally option
>  - mktree.c: do not fail on mismatched submodule type
>  - mktree: use read_index_info to read stdin lines
>  - index-info.c: parse object type in provided in read_index_info
>  - index-info.c: return unrecognized lines to caller
>  - update-index: generalize 'read_index_info'
>  - mktree: use non-static tree_entry array
>  - mktree: rename treeent to tree_entry
>  - mktree: use OPT_BOOL
> 
>  "git mktree" has been rewritten, taking advantage of the cache-tree
>  API.
> 
>  Will merge to 'next'?
>  source: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>

Please drop this series; I haven't had any time to work on it since your
latest comments, and likely won't for the foreseeable future. If I do find
some time to address those comments, I'll resubmit the series.

Thanks!


