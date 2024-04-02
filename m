Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F65A0F8
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052629; cv=none; b=WXvv3UKumqf/KZjrtsJl3EYy5pDiEMC/AtH9PY3GIZGUDnFMG38bJ9wmAPudCAlrfGVY7pvG09JXydrzZ5HC0F9Mdi7eAjJ4rcOZx2vYqW9E1v3/9Tps2nIQYpnH4l+AdYdUA0yT5QMCpxIEDdr8SBpskRZ2bgLmuls91xSsL80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052629; c=relaxed/simple;
	bh=sxjUVfihG1Y697wUarlH4RpCD7S/f0gztUXa1ZJZTd8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iyAM0xUUccVHrHXFlkrm51SQZgzUOI3Bo1ZY2SfMryTOKjRCm99D454huZTIwdsYVnlT9VMUqFs4v321Iajksz7YX7Q4VYUuAc77OLZovYvDtRj/pHuVAWnk3NNGr44CPIHU41RasXDLDwRYVQZNAgNLiEdS/UXcLNV3TsGqOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGErDMlX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGErDMlX"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so68473381fa.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712052625; x=1712657425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvjy5XFOWvXnKzaIRBAwyEHPEATDJxIl9ecXdiu5wYY=;
        b=kGErDMlXMLuTljPWYZ0BIwKhJQGp4LJO0Ic0ITWFqb6jKEiAI4i9ZG/gLJ/0oD/xzP
         OA5BSvVdBC8BUJDmcFjezN4fMCfnQcw8iPYTjWCJEq0vs8cILbzTmH2cn+WbafwtXHeX
         ozOFI0EFmzYpJTCCt9P1BjSJD/2o9CTyO4z/wFPkEeVN4Y3IvhyZsHgXqKLAtfDY74lN
         tHsjf/Pv+R40dDEd89RIBOz7AD2417k0pipuaC6IZDEJZxQD2wO+MAQEg81O6o5hXoVm
         bR9exqlFt5PcHvCEi8g9ERJeqW3xTU+UV/sl6P1Pywg/rDluYvJy5WPp8iBI7UlA3JvM
         mAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712052625; x=1712657425;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvjy5XFOWvXnKzaIRBAwyEHPEATDJxIl9ecXdiu5wYY=;
        b=jwH3F363Eu+IJqX2Bv6AMh/1P9Iymy6kR7cGB/lUUJLsVzYGWJL7uEskS7BafH5BL0
         YABsv9fqoXg59G8jYufakJ7txONXjPL7Agw6GjKSCJ8v/mIrJSM22VeFV8m7ZVuz1eWa
         sF22ibqHw9NOvyV4G1Ns8tNrgEWeyH3FhPpxAfPefCXr5UaRSr544bTipCzjUNHDX7vZ
         zOYEpSATm49CE0+xNdHYwGvfOLJClwRgRhzhOZcjtJabxXDefqIzXEchVQ6nfTm19g8V
         m6sFn7hCw5S3M4rnM7L76O7ZX7XOKtwTL47zVQAD2OGfRGxsIdoDfKu2fc1uh2GawwvG
         ydCA==
X-Gm-Message-State: AOJu0Yz8QTNeJfwktWWSbrkZ6ultzxLZth18W0Vfa6dVsPHTCNcuO3Ia
	VYwDz11Wihx9tXs+GsAWIKaadZg+wf4x4ObXdM0FObExTsOq+G8P
X-Google-Smtp-Source: AGHT+IHhZUQ+uqTyoWu//1QcKRXZTGi/OZC6fjqzLfkDnW3xT5rGE2YE0xS+4b0sQheZYChPli9Ktw==
X-Received: by 2002:a05:651c:c:b0:2d8:11cd:4223 with SMTP id n12-20020a05651c000c00b002d811cd4223mr3854041lja.2.1712052624165;
        Tue, 02 Apr 2024 03:10:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b0041488691eb1sm20459910wmq.17.2024.04.02.03.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 03:10:23 -0700 (PDT)
Message-ID: <4041487e-d8d8-481c-b490-884e31f533a8@gmail.com>
Date: Tue, 2 Apr 2024 11:10:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
To: Eric Sunshine <sunshine@sunshineco.com>,
 Tamir Duberstein <tamird@fuseenergy.com>
Cc: git@vger.kernel.org
References: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
 <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
 <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com>
 <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tamir

On 31/03/2024 07:49, Eric Sunshine wrote:
> [please reply inline rather than top-posting; I've moved your reply
> inline for this response]
> 
> On Thu, Mar 28, 2024 at 1:40 PM Tamir Duberstein <tamird@fuseenergy.com> wrote:
>> On Thu, Mar 28, 2024 at 5:24 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Thu, Mar 28, 2024 at 10:54 AM Tamir Duberstein <tamird@fuseenergy.com> wrote:
>>>> % git branch -d cleanup
>>>> error: cannot delete branch 'cleanup' used by worktree at '<my source dir>'
>>>> % git worktree list
>>>> <my source dir>  dc46f6d5e [main]
>>>> % git branch
>>>>    cleanup
>>>> * main
>>>
>>> Is this error persistent once it arises? That is, if you invoke `git
>>> branch -d cleanup` again immediately after (or a little while after)
>>> the above sequence, does the problem persist? Or does it "clear up" on
>>> its own at some point?
>>
>> Yes, the problem is persistent. The branch is never deleted.
> 
> I'd guess that there may be some sort of "ref" still pointing at the
> "cleanup" branch which presumably was, at some point, checked out at
> "<my source dir>". Digging through the code[1,2,3] suggests that you
> might have some stale state from a rebase, bisect, or other sequencer
> operation which still references the "cleanup" branch.
> 
> [Cc'ing Phillip who is probably much more familiar with this code than am I.]

Thanks Eric. I'd have thought that "git worktree list" would say 
something about the branch being rebased if there was enough state lying 
around to prevent the branch being deleted, but lets see. What does

     ls $(git rev-parse --git-path rebase-merge) $(git rev-parse 
--git-path rebase-apply)

show when you run it in <my source dir>? Also is <my source dir> the 
only worktree?

Best Wishes

Phillip

> By the way, it's not clear from your initial report what you mean when
> you say "then the remote deleted the branch". Also, did you fetch
> and/or pull from the remote after that?
> 
> [1]: https://github.com/git/git/blob/d6fd04375f91/branch.c#L454
> [2]: https://github.com/git/git/blob/d6fd04375f91/branch.c#L386
> [3]: https://github.com/git/git/blob/d6fd04375f91/sequencer.c#L6551
