Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261C33ADA7
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364700; cv=none; b=g4uFH1tQgJhzcqDGRyYybj7r3WMBIviGlu/Lwfr2aSkXO/jE3bfMLOYJo0S1iKnvdZSeB6QVJapOtDgwQUergz61v9BbTWe+12HrkuPTzd1w+K7Hf4KVvf1/i4AuBPLyQjipQbn6CJp3LJcSQ6IWXxJvA3J1ZqqhSk/1t7aarXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364700; c=relaxed/simple;
	bh=AR73yR71RP7ek1qe62atvk8DZZaoUioD/0dcZnfGNds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUgo2boiw0lOoDYclSD+VE7ScXZ3ugc4SQTJNKYFSUOWpfLBt99mWTyYm7G4w6wteIlnFk7oQ20DhRHKU7pa2NXt2J6VH4Gwn1jLdyurQAQpkll+yWZOEGXVeulqi5izyFgZUr0+/VDVzv2XejjzhbdPK15EQWDZgi7UktGOGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=priyfrTT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="priyfrTT"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2c77c62d7so8492895e87.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776364697; x=1776969497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LgReXKHRzURjGgSSEwrhcwgXY4NUXpeGBnLgGvU/lmo=;
        b=priyfrTTfauC6iMHThBnelBnMrrWOXdTok7VDvpR+em2iTPnJxfrjp4NBl9YwoC8Ds
         gPDT7Dw8QNtqZrjGGnBUKSJHR1ymXVFOxTFuPtZZeL6pupl1bB6/QtoAX+s3en+KV0Yp
         cil5g3u9zbADkiev51iYfj407GM1pZuPv6u8khk/sNVRYIIhHKC3Qr4exoCbQclu1Pb2
         xi2BVnKcP8zX1zaRc2DecR73Kkhq4cU4XaqmJJCLi1SE9qTJ6hmd42ZwnGUvJjmi8r6e
         dnWq0PqXYHdHW0QSmw2HwJsuy07TlX3JN0L//eurCGGBbCAHbdgJmnVEBozu06fTf1Nd
         z25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776364697; x=1776969497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgReXKHRzURjGgSSEwrhcwgXY4NUXpeGBnLgGvU/lmo=;
        b=dyTRRHGw5nJJN0wQmN9rSPRaQOxfeIAb+qbth5Mga/3wzSptwI5+HnyO0J6pRn8ACQ
         /fxMBia8RgNXL5sqpcqeq+IX9Nr4R4WPHF8PgLl156UwtOcHhzzEp2MN4Ir36ybie9+2
         euGTpil/Pg7IUkzxB+wa/gbxeqvXSJ1rhpkenCMljyDkD1pbPfTSmh8QgJeFNVXldJ9S
         yOCmijbQmdVty01JXDj0AMoJpRoa3945nBfxMKBty6VOIqAm+HyYOD8vbM0IK6bfWg25
         yGPEpf1cT3RgrqeAbppotitZjM4YNlBZkipaTOkEo5a83xzomaUMMtWKucoGMKeEKALd
         usFg==
X-Gm-Message-State: AOJu0YxL07vMCjMf5Scb+2YQuKKXMWP+4RmWNrpsDXgc+g27l580JlLs
	Q2sVl5lQ8n0OyfLB5td+FOxRkWzOJJzfBRJXK/lNaDgvOL0uOwsIuHHW
X-Gm-Gg: AeBDietbG7kxp3b8UU9KBM7fVqM2Muv7xD1/nkbDr4o7bKMssiS7oQCFPzVuYahlo5c
	/4Ax6nqcU0bzaAEVSu/gpbm8oRqA8IwFMW73tJhWhx1/0fRvMlr2D3aIx7ugI9XgBPYvVQh9sZL
	ABzRxUYsesJ6yx2P+sSdsAe2mL0+XcweadnK0G4hgrB2sNJfF+z0mZBbve9BkGGsUzk2byW6h2C
	Nrc7Ne1aV6PWnrzExbQ+dKjI2XjcAutzznfLXaqTAtuW7+yQqUWl2QR1qxeqQCeVpTkg7AYqCoL
	DOcxUWcW4J599n1W0fm7hJgbCXVkzI7GoQrYi11Rj0yERd6xI0/IdDjLfbq9tcK3steDmqL5Vg1
	ilWoHuycZnyfaBb/y6/Sq57UaLRu2x2vn/4NEUHJzQU30LSXwk5sFJlHZjumWRS4SNU3qMRwA/S
	8Nc0NCd6zqWlB0tdXBz90evjDkw/ro6d/63E8GKFVCPlK0yA==
X-Received: by 2002:a05:6512:2243:b0:5a1:3b7f:450e with SMTP id 2adb3069b0e04-5a4155839d1mr128594e87.42.1776364696967;
        Thu, 16 Apr 2026 11:38:16 -0700 (PDT)
Received: from [192.168.1.201] ([90.254.45.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40a30909fsm1469659e87.79.2026.04.16.11.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 11:38:16 -0700 (PDT)
Message-ID: <19b86e02-6842-42f0-8226-c86ad6669ec4@gmail.com>
Date: Thu, 16 Apr 2026 19:38:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] worktree: add --recurse-submodules support to git
 worktree add
To: Junio C Hamano <gitster@pobox.com>,
 Jimmy Aguilar Mena <kratsbinovish@gmail.com>
Cc: git@vger.kernel.org
References: <aeEMU-ohKz2tnSWq@RTX> <xmqqzf3225u1.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqzf3225u1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2026 18:05, Junio C Hamano wrote:
> Jimmy Aguilar Mena <kratsbinovish@gmail.com> writes:
> 
>> The approach follows Phillip Wood's and Junio's feedback: each linked
>> worktree gets its own per-worktree submodule gitdir under
>> $GIT_COMMON_DIR/worktrees/<id>/modules/<name>/, so HEAD, refs, and
>> the index are independent per worktree while pack files and loose
>> objects are shared via hardlinks.  The gitdir isolation is the same
>> model git worktree already uses for the superproject.
> 
> I do not quite follow.  The point of git-native worktree support
> (which improved a lot compared to its precursor, "git-new-workdir",
> is that it can work well in a hardlink-challenged platforms.  You
> shouldn't worry about "hardlinking" yourself at all.
> 
> After the superproject successfully did "submodule init", you can
> move the submodule's repository with "absorbgitdirs" to
> $GIT_DIR/modules/<submodule>/ of the superproject.  The primary
> motivation behind this feature was that you can switch to a commit
> in the superproject that does *not* have the submodule bound to it
> at all (and obviously you do not want to lose the submodule
> repository only because you tentatively switch to such a commit and
> have to re-download when you switch back), but I think it gives the
> single instance of submodule repository that you can share across
> worktrees of the submodule.  Because the single directory created
> with "absorbgitdirs" looks like a bare repository, you should be
> able to create two worktrees off of that, with their own HEAD etc.

I haven't thought much about it but that would mean that "git worktree 
remove" ought to remove the submodule's worktree when the worktree 
containing the submodule is removed. Worktrees avoid hardlinks by 
creating a "commondir" file in the worktree's gitdir which contains the 
relative path to "$GIT_COMMON_DIR". I think we could probably do the 
same here and create 
"$GIT_COMMON_DIR/worktrees/<id>/modules/<name>/commondir" containing 
"../../../../modules/<name>" if we want to store the submodule's gitdir 
under the worktree's gitdir. That way removing a worktree's gitdir 
removes all the gitdirs of its submodules without any extra effort. 
There are probably other tradeoffs between the two approaches that I've 
not thought of.

Thanks

Phillip

