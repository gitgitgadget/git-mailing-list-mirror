Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A826D3C33
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800135; cv=none; b=MV6+dY0KJPoy3eDUvXrzyKtNLbr7ARJgQStcsQOp9hAzv5ekymBzy6Fbt6n1jyzBN8DtSq4FXQxjTZE/Z+jw3LeNOnUEUJOMNzALUng0cfYqN5xOyornXeVpVYie2pds/nZPSveUb+m3tLVE8/OlB3b7zOylLs8/HvjD8IN5HY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800135; c=relaxed/simple;
	bh=GJPlU/Vhd3goGZoW+rW6Q2DRHR97JK+UFB0/yKknpV0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Imwo3ywNxvg4i9d9IfGS07s7kFyY1ryKig08jf83NldQWgu1Mu832SK3UmD43io3oMndp/mVoMzCjywopuYV+vtBVrZzbzOXzGcxk8Fcm3DHB9k9p3dYkAi5ECEV7M3/Sej62oJUoYpK6JesIshqIQsPSF1c89pg4HJc8CJZjTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxkkXMW+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxkkXMW+"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce508cfe0so1265826e87.0
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755800131; x=1756404931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6A5LSqD1lydyEahDNAWpQ/je0BvHcx2Jc2+Yv1Qfnbk=;
        b=lxkkXMW+sunq6J1fWH8wDKb1JExBJJ5G1ZvAJNfV5YD1XWAzywKc3jRSy61hYcZ8ZE
         v9LyCR+hdm7FFkd2SN0c0migXXGAOX61exR+VHABxquJk5fGlXoHxEM6qLhgWJW4GeLE
         +lz9NOJEd6c970kupMEfWyK2GpUn+zMHrBGezAuqwQuCBTAjVd2dvAhw2OOsC+xUFIx4
         dJiivN8M73lD4Zj/0hNTAdJrqwJMtO3YybA9UuL7cYXW/m1zZXaev51yKXVZExncpA3J
         Xyt8FP63jVES64jaITfLnNVMzvgMK1mMWwLCfqQkKtaXYY/cD5MmMqjWYjtf98Kk9yOM
         Roqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800131; x=1756404931;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6A5LSqD1lydyEahDNAWpQ/je0BvHcx2Jc2+Yv1Qfnbk=;
        b=JEFBSSqdTK07uWH4k/FpC655KhZ81rEppit292t/t44jmH2aqiXRfxAoGI5Tb6mfgb
         uYQjSNmuP6SaXi+gHBOUzK3I9QgkOnzsiOstX0i3o6xleCwJN/vEJxazqxxHN4GyDpem
         iQvWsmRilxECE+UbaKrtsb2nhAaesUM1SlpXNqt9/Rgdhrd55rT9UR9imJtUwSPmZX8j
         gLbbJF939/yrLZXtQSWbDufIid7PxD5Kp03xeoVibS4/6NG6AhFF3raB5k5fAI64HHG3
         zzX3Qc/MsphVW8DaTCziPYP4Jet74m5V0wK8KnLbBzjsdP8xzYOuFiLuKmBKDY4yKL0v
         pNqA==
X-Forwarded-Encrypted: i=1; AJvYcCVsSY/rRLCkv8NEUJDBZi5Y8Ohu9239+sVkZs2cDMTpHbQZd2ins6X2eOIzERQKxcv/VXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwD/nK7spKaDYtaQjoqH8iOLi4dcgNqIcmUXKNey0+B4Sn7mCM
	4LBeNBckJWwL/zDDO4V/wG9lJgj8QZ8zzA8Wqy34KKgGN6jYcA9syzwEojcWig==
X-Gm-Gg: ASbGnctlscH++kCqSoCgIh8TY71iPwYtNrOXxr8G8La7Ccelm+Ca4ddgTon5JaBUr8M
	0bglxhB8S8DQEvHBDYQYwYXgdZcopCbICITaGzvnxwnn8H3KbwMCYDtQ6BvmSSXa0OeINkX/CyC
	/kqO7GC8q0Pf7E+KvgIubH58qXvlo9I+FL8Tvcy1SreDTucYcR43bUo3x1Y/68qMxySgz+Rwe3O
	EMbGT+QsxZncO6x60DwQgTu1LHdU8B1mu+L0OjlG+XOIEAtzWqTjjjo6X5EJYUOc3OmPz7Dc42u
	/4Z6nzNdMl/1SFj3E93K5lvzlxqe7uLTp7u7/zDBqfrIyL9h92xYnzIfHS0lJz9Xuo3A52+oaPy
	LJKqpneO+RpurL+7y1qgIlqs8jA==
X-Google-Smtp-Source: AGHT+IE5vK+QJE4PCqGTDRCZ12HqYXnKqi5E8jSReA6ZhuNhF/GLBe/H+YITNpPpci6f7rWkMgGyOw==
X-Received: by 2002:a05:6512:2288:b0:55b:8a00:c703 with SMTP id 2adb3069b0e04-55f0cd47754mr114007e87.10.1755800131206;
        Thu, 21 Aug 2025 11:15:31 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a605458sm32166341fa.42.2025.08.21.11.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:15:30 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
References: <87a53sr67i.fsf@osv.gnss.ru>
	<6EC11FA7-D80D-4DA9-A615-C3523967CF93@gmail.com>
Date: Thu, 21 Aug 2025 21:15:30 +0300
In-Reply-To: <6EC11FA7-D80D-4DA9-A615-C3523967CF93@gmail.com> (Ben Knoble's
	message of "Thu, 21 Aug 2025 13:21:56 -0400")
Message-ID: <871pp4r16l.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 21 août 2025 à 12:51, Sergey Organov <sorganov@gmail.com> a écrit :
>> 
>> ﻿Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> Patrick Steinhardt <ps@pks.im> writes:
>>> 
>>>> In the end, I'd like us to learn from what people like about Jujutsu and
>>>> apply those learnings to Git. We won't be able to apply all learnings
>>>> from Jujutsu, as the workflow is quite different there due to the lack
>>>> of the index. But other things we certainly can apply to Git directly.
>>>> 
>>>> Note: This patch series currently builds on the cherry-pick infra.
>>>> As such, when one hits a merge conflict one needs to `git cherry-pick
>>>> --continue`, which is quite suboptimal. I didn't want to overpolish this
>>>> series before getting some feedback, but it is something I'll fix in
>>>> subsequent versions. Furthermore, the command for now bails out in the
>>>> case where there's any merge commits in the history that is being
>>>> rewritten. This is another restriction that can be lifted in the future.
>>> 
>>> Two comments.
>>> 
>>> - You would want to honor notes.rewriteref yourself, as cherry-pick
>>>   does not and that is deliberate [*].
>>> 
>>> - It is a sensible design decision to limit it to linear single
>>>   strand of pearls history.  "history reword <commit>" when
>>>   <commit> can be reached from many branches along linear history
>>>   that rewrites all these commits on these branches would be handy.
>>>   There may need some way to say "these branches are protected, if
>>>   'history reword <commit>' needs to touch commits on any of these,
>>>   abort" and things like that.
>>> 
>>> 
>>> [Footnote]
>>> 
>>> * "history edit" (aka "rebase") is an operation that "edits" the
>>>   history, once the edit finishes, the result is *the* history you
>>>   want, and the previous one is to be discarded (except for in
>>>   reflog).  "cherry-pick" on the other hand is "I have this good
>>>   thing on this development track, I want an equivalent _copy_ of
>>>   it on _another_ track"---it merely is an easier and quicker way
>>>   than typing the same thing yourself on top of the other track,
>>>   and does not duplicate notes.
>> 
>> Unless I'm ignorant, "git rebase" (aka "history edit") lacks essential
>> feature though: in addition to saying: get "this" history and rebase it
>> "there", one should be able to say: get "that" history, and rebase it
>> "here" (aka cherry-pick on steroids), that also would eliminate the need
>> for 'git cherry-pick <range>' that (poorly) duplicates rebase
>> functionality.
>
> But isn’t that
>
>     git rebase --onto=<here> <that-upstream> <that>

Cause we end-up being on modified <that> (unless my memory fails me)
rather than on modified <here> when intent is to keep <that> intact.

> ? And why is that cherry-picking a range is a poor substitute [it is
> rather rebase that duplicates cherry-pick ;)]?

Because rebase has a lot of useful features compared to cherry-pick,
such as --interactive, --exec, merges handling, etc. In fact, IMHO,
"cherry-pick" should better be Git plumbing, and every-day-user-needs
should be handled by "rebase".

Historically, when ranges support was added to "cherry-pick", it was
probably a mistake, as "rebase" appears to be a better place for needed
functionality, and what was needed is rather adding "--pick" support to
"rebase".

-- 
Sergey Organov
