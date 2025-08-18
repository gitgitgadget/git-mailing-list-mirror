Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB07924E4C3
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530058; cv=none; b=pD2IzsBwQYlsu7DX6DnOEFkFugcjfgVTBd1Nuy6syxg1/5ZGi3LDzOvBnhTYvGeA7XclPV3SuNuO3ce54rQc1G3TPLg8rJwap2Fiq5J6/UHLSDPfj2SaFZ1OfI2WYKB2gNPV2RntjXelBvOJKPO/NKf/7zwg3QhRhU0hYYdv6YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530058; c=relaxed/simple;
	bh=3oXJRU4hsCeivSK+E+2aDAgiSJuBj1OyU3NVb6U5lKU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UkqCi81ZdvovK8RPebGxzsuATHahCcx7MEvzufNpaG1SLXkV0SFCwegskUxW9NvmTUjcu7SzOxDEzYf/cHuk7QpMDLj915pq1VxJQ/5A5VVILPuFvw72Cc3ejemVmxbYIfRrTMpB99KbhRxXrSLYZYoAl+etL965AlRX/pf5+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtSDY4C4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtSDY4C4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso21019025e9.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755530055; x=1756134855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvsMJxOlfhtNv7AxfFTwK3EfFrW+hG1b918QWnH5kJE=;
        b=TtSDY4C4C6RwlslRFgRgiwbce+kySjSM0AcQtnvh4lSI3deHYSrDuomXUCwos6/YUY
         HvuDtiGzDTIyRv0cr5EiNW+UqrUvI6Z/8nsoxEOOUu5kb58RJRsnEn2J0c7wmCz0j/CQ
         SZ9QYyh4HIEFtki9Gvl1JjxDazudsgDlA2a4eexfDIaIfcZxlSQo/QN1LnkupU1j/wAW
         NQEiLebyBImsHT4AupEkz2C/Fx4OjjAcvjpdZrMVRBNiy2DIILkfAo8IuzejyQAjchol
         NTB/PXnyAJfGwvZSZPDTBq/vxlZIpOnmQewu4qqdy9o2ZQYAp39wl2irOCo4wYTGW39z
         RqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530055; x=1756134855;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvsMJxOlfhtNv7AxfFTwK3EfFrW+hG1b918QWnH5kJE=;
        b=FclLNXlOa5iBZoyrCqy/YXC1xbDk0B7KZOT6wjM6vB78G/sKKFmPUysEwCUKAkQrms
         YExg8qLj4V0Oq1utvhgGk5eQgEjeIeKe1lzxmeSbnPh388bn+Qb3WEVwyeZp+KjY4xUU
         x1rxqcie3HT/NVRtx282V9b+9rv13zfyp828tAB1Z8gXM05gSWxUPGDc+rQey+2duf9R
         3M8vfp2DcrpAA95UH8mUa7X55UUkx1w9/0cjwaRcMKO7jYK2sDZJ/PjoW+99b/CItOdJ
         xooTyDQc1kO6w4KFhhTEMDI1cerER/A1uur5VAek6YtA3u7ptE98ktqwZ0Z1eLdKRzqK
         Mplg==
X-Forwarded-Encrypted: i=1; AJvYcCVoFrOsrJXITfuLUYH9ldWEmuA33XDsHgx+FaLYBrTNdckwZguNELNiesyN+QVy3HgRglQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyIXsqmKEm8WQhPYbaYt2crRcOBS+zINVevYsoxtiQMrs81iw
	W9y+v05Dp8zb2KFEC7MO3Ia5y9z3WZAIbmIT8CddDAnWrLa9WXg8P0JQm1lukw==
X-Gm-Gg: ASbGncs+UOWilzQeeTi1h0+5XhHK0JOrAGnAyDtVY+QnZ+IVoDkBcKDA1LBmvB9gXeZ
	gGeCcf/E8NigpvlcmfLubRj2ngKQ3i3twGcQC+XiGfAvr4DL8FF+/SxSs/6BSVLnSLev84wOqlo
	KHWv5R1fth4iWUuMbvv2JqTnzapmeju6oAzwKfTdZ51iu1ELp0BYXRvus/dn+/pRpIWeJY0kPuX
	rM9Z6RywTbo4Mld7V4XP7V7EyfwgLAvAWS4znt2+r/wH+0vq9lKA5HlXd61cE0MCpJ+QI3KOObZ
	CAw4XBPqbXC3z4N4xXBV1BzunaKytXcc5CAMzqF7JfcMMxDWFG+dctKQlCk1FuBWq2jZML6SezF
	6NZDNLgvWi+iX22Mzr1AJpRJkevdTiAZl54U+8gRE++RQF+HhelSfxfNdNL0P+OXo4BziEaYKyt
	fTjWFLwinGzebZ
X-Google-Smtp-Source: AGHT+IFUpQRuOoKRBtDNvzhk6sGsOsCmmInyj098znyxWMOeXro5YZRGHj6quPbpvp6Ev1If0QXOSQ==
X-Received: by 2002:a05:600c:458d:b0:456:1a69:94fd with SMTP id 5b1f17b1804b1-45a217793f0mr122293985e9.0.1755530055035;
        Mon, 18 Aug 2025 08:14:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6be10esm188501825e9.3.2025.08.18.08.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:14:14 -0700 (PDT)
Message-ID: <89394e50-9077-4a7b-b30e-afd1be1a40e8@gmail.com>
Date: Mon, 18 Aug 2025 16:14:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
To: Junio C Hamano <gitster@pobox.com>
Cc: "J. Dettweiler" <git.vger.kernel.org@dettweb.de>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>
References: <12fe17735317215aa0de58a20055193a@dettweb.de>
 <60f38225-2bcb-4383-be40-36c7b02cf38c@gmail.com> <xmqqfrdqkk1l.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfrdqkk1l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2025 17:08, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> To use it create your stash with "git stash push --keep-index" and then
>> use the script to pop the unstaged changes rather than using "git stash
>> pop". If the script proves to be useful then perhaps we could add an
>> "--unstaged" option to "git stash pop"
> 
> Hmph, would the behaviour useful enough that it should be always
> enabled, without any new option?  I strongly suspect that those who
> worked on adding "--keep-index" option did not expect the user to be
> mucking with the working tree files while "testing the staged stuff
> by updating the working tree files to match it and nothing else",
> and as long as the end-user stays within that originally designed
> use case, nothing changes for them, no?

Yes it probably would make sense if we knew that the stash had been 
created with "--keep-index". At the moment I don't think there is 
anywhere to tell from looking at the stash if that's the case but we 
could add a trailer to the commit message when we create the stash to 
record that it was created with "--keep-index" and apply only the 
unstaged changes when we see that trailer.

Thanks

Phillip

> Thanks.
> 
> (the script left for reference without comments below).
> 
>> ---- 8< ----
>> #!/bin/sh
>>
>> USAGE="${0##*/} [<stash>]"
>> SUBDIRECTORY_OK=1
>> . "$(git --exec-path)/git-sh-setup"
>> cd_to_toplevel
>> require_clean_work_tree stash-pop-unstaged
>>
>> LF='
>> '
>> stash="${1:-stash@{0}}"
>> if ! stash_oid="$(git rev-parse --verify --quiet "$stash")" ||
>>     ! oid1="$(git rev-parse --verify --quiet $stash_oid^1)" ||
>>     ! oid2="$(git rev-parse $stash_oid^2^@ 2>/dev/null)" ||
>>     test "$oid1" != "$oid2"
>> then
>>      die "error: '$stash' does not look like a stash commit"
>> fi
>> merge_output="$(git merge-tree --merge-base=$stash_oid^2: HEAD: $stash_oid:)"
>> status=$?
>> if test $status = 0
>> then
>>      tree=$merge_output
>>      conflict_info=
>>      messages=
>> elif test $status = 1
>> then
>>      merge_output="$merge_output$LF"
>>      tree="${merge_output%%$LF*}"
>>      conflict_info="${merge_output%%$LF$LF*}"
>>      conflict_info="${conflict_info#*$LF}"
>>      messages="${merge_output#*$LF$LF}"
>> else
>>      exit 128
>> fi
>> git read-tree --index-output="$GIT_DIR/stash-pop-index" -m -u HEAD $tree &&
>> rm "$GIT_DIR/stash-pop-index" &&
>> if test -n "$conflict_info"
>> then
>>      printf '%s' "$messages" >&2
>>      printf '%s\n' "$conflict_info" | git update-index --index-info
>> else
>>      git stash drop "$stash"
>> fi

