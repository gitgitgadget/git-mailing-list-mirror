Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164841BAEDC
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806450; cv=none; b=QG88IVpwiqJybDiexX2vdU9Zb54qAF+ioDaNZB9VspHKvqjPwEcRtbUuJrNmX5ZCh6/gkyFnp7IcTwby6Jtx/qWB+KjeEhr1VcBaIjKPiitvmkUQWMHxZgglWNB+OXMCJ3nFmHZ1BJBJAtqO0QV96QC6E2Ic5rMYR8Bf1C50+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806450; c=relaxed/simple;
	bh=s82ziGDH8fcCsQol2KXEY87mhy49VBtj9dyodxI4utE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lsJRa47yHGfV63XxGISyzVIGebc6f7bUOIW0Q3cab0ariKJrzIM4q5UQxvmUI2JfTVCEuUK4UrGEoQesf748gITTG0y/xC9XvcokfcNjt2xERQGBJzUxPdvP8MQnvsg0RuwlqsNdmwQi4QcD2OL2OiRBOEnLVj6iK0lKcaagZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO0s1dkS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO0s1dkS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a83c6b01so8104935e9.0
        for <git@vger.kernel.org>; Thu, 28 Nov 2024 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732806447; x=1733411247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJlNK22EMWe4sbm/D06GfoUINBa6ImiQtR6AmxQ7Oow=;
        b=OO0s1dkSqC7BDCaDnO16WrUUyeCEiuwJemagRBkLAo54/mVwgizMwr+30AQvqJNjYT
         tXZ8+7SvMvCXSkDftNOdjGli58rIphrTdT+e33q27PQW1cdLpxvWTLFznIPK9QFu9v3M
         V0/aDt1AvwPmuYPhbnU13wRFi8dZXspNjP99IWo2Pxmyv3EJIaPTcOy87koqCT1hT0d+
         y8e1S1xJjw9G0qHLSh8EB3yXbb7rdLR53i1ke/3xekBOoK5oZO60+m8szogaGlINs8uD
         RtmjpAGr+pX0Nrlb1jHqLx9i1rFWN9m9Fu8ZYT8mdCKiVPyXtoxvDTz7EOM91vPjtR5P
         vlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732806447; x=1733411247;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJlNK22EMWe4sbm/D06GfoUINBa6ImiQtR6AmxQ7Oow=;
        b=ThvXPRy5eRuNQFAtkR5AjtJJVLwiDwxweo5BjgWrzL5Ys1nxwkJ+6b5ZvtBs9MIDnI
         HHGCvebeS/IieKJgE28DhN8y8lp2+FLh3nCBkXag/lJ/KC0/4BIv2mZnv2n8h4QzPRJ/
         tkTGP3C9jETWeKUlK78t7QWtEgfvdMuz/yPdJA+nvQzr7vveJ03BgGmsE+/WYAQsu59r
         rAlO61iAFfiuaIBkRCFnVCKnoizazqsTfc7gSKVCJ2Z/FDOsKS+5c5ktzoE6x9BwSnlB
         ob3ClT66g7SfMx8Fp6aNZyPw9U2W2Vr6o/51N9cwvbWrXQrWBEa+reXLcvymMcUzKyzU
         KGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd8KkphJHlF17WUZ2TBk6lCv5R8VupTwRI95zKzOxYR19Ldw3eCxvJJpu1GdDIeb5Mmeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzywGbBFlt3bKaQN8YON/CPlfcseZzrs1v3C8HwgMHUIKnI+8
	OWfja9gECN3lZIk0tJghWQO5A4+gy8eFxdOtmIzacKPPNfVHQhM5
X-Gm-Gg: ASbGncvY9ERThYMcZ0nAL8SuD6E1W6VL/9OCW3rDS9uh3qx5UuPD+7SA2yfwaufIG+I
	lCjYgn/PAI3/Y6KUbfSvXcErsBWJretJzMQt3QMtuKxKPdT2pRZuPiuiTE5ZX0kkXqf36BjVcFY
	Tgi81M/8FKo/174t/KORxkNBnH6P/nCIR4dIoUMxWPPtwZUUmJHSp3e/loXzq3OJt/mSjBmakvB
	iRdxZainrWKBvGMsCxLiFpKA+8KBrYDx8XiZjywB1YhXcZppSfqu27DGenNWGxx7t9HkULCtIEo
	1uYEypNidiDBu5/7/c+7TwpUjcOv
X-Google-Smtp-Source: AGHT+IE9RV0lJQRIaA/N5BlX0ytZxWN2QmxaITcosy+ZgRKwoletce8tf/Va1d9VGQZ8olt8VJJneQ==
X-Received: by 2002:a05:600c:1d19:b0:434:9d36:1f0c with SMTP id 5b1f17b1804b1-434a9db8467mr56588515e9.1.1732806433714;
        Thu, 28 Nov 2024 07:07:13 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b? ([2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d21bcsm57003385e9.30.2024.11.28.07.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 07:07:13 -0800 (PST)
Message-ID: <8a4ff61f-0545-4edf-9e90-1e16e4d55911@gmail.com>
Date: Thu, 28 Nov 2024 15:07:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
To: Eric Sunshine <sunshine@sunshineco.com>, David Moberg <kaddkaka@gmail.com>
Cc: Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 phillip.wood@dunelm.org.uk, david.moberg@mediatek.com,
 Git Mailing List <git@vger.kernel.org>
References: <1730787532-3757-mlmmj-5e7be4fc@vger.kernel.org>
 <CAL2+Mivva3AFR4of0-2d48YDDMbHiNVsUmCzhezHfe+h9faEvQ@mail.gmail.com>
 <CAPig+cTVfNW4AFJKyGbRcy0_YJEJGcNYNx57USyp4zz1g9fSeQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cTVfNW4AFJKyGbRcy0_YJEJGcNYNx57USyp4zz1g9fSeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/11/2024 07:36, Eric Sunshine wrote:
> On Wed, Nov 27, 2024 at 11:04 PM David Moberg <kaddkaka@gmail.com> wrote:
>>> To: Elijah Newren <newren@gmail.com>
>>>> My commit merely pointed out that long before that commit came along,
>>>> if GIT_DIR is set but GIT_WORK_TREE is not, then the working tree is
>>>> assumed to be ".".  As such, a command like the above where
>>>> `--show-toplevel` is run with just GIT_DIR set (to anything) will
>>>> merely expand "." and show you that path.
>>>>
>>>> If you are going to be having subprocesses that depend upon the git
>>>> directory and the git working tree, I think there are two options:
>>>>    * Set GIT_WORK_TREE in addition to GIT_DIR (as my patch does in certain cases)
>>>>    * Stop setting GIT_DIR if you're not going to set GIT_WORK_TREE
>>>>
>>>> The second point is a bit harder since setup.c automatically sets
>>>> GIT_DIR for you in various cases, so if you want to go that route it
>>>> really means you'd have to actively unset GIT_DIR in those cases.
>>>> But, you'd have to be careful since you only want to unset it when
>>>> setup_discovered_git_dir() sets it for you, not when the user who
>>>> invoked your command had manually set GIT_DIR.  So, there is a little
>>>> bit of a pickle here...
>>>
>>> So, what is the way forward? Is the option of setting GIT_WORK_TREE more robust?
>>
>> Hi, sorry for posting this on the side but I only have Gmail on android which doesn't allow text only emails (I think).
>>
>> Is there any work ongoing on this item? I think I lost the conversation and/or fell out of it.
> 
> The conversation ended at [1]. As far as I know, nobody is working on it.
> 
> I think Phillip did a good job in [1] of summarizing the two paths
> toward a possible fix. Unfortunately, both paths will probably require
> a good deal of spelunking through the code and the history to
> understand why the logic is the way it is, and (importantly) how to
> craft a solution which won't break existing legitimate use-cases.

I think the solution of always setting GIT_WORK_TREE and GIT_DIR is 
probably the most practical. Even if we find a way to not set GIT_DIR 
when git is run from a linked worktree I think we will still run into 
problems when core.worktree is set as that also appears to result in 
GIT_DIR being set without GIT_WORK_TREE.

> So, it's not necessarily a small task, and whoever digs into it (if
> anyone volunteers) will likely need to devote a good deal of time and
> effort to it. (My Git time is severely limited these days, so that
> person is unlikely to be me.)

In principle I'm interested in fixing this but in practice I'm unlikely 
to have time to work on it until the end of Outreachy in March. If 
someone else wants to take a look at it in the meantime I'll definitely 
try and make time to answer questions and review patches

Best Wishes

Phillip

> [1]: https://lore.kernel.org/git/743043bf-60b7-4ed7-8cf2-4f3f972968a6@gmail.com/

