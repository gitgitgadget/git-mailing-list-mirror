Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF422F4A
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735611518; cv=none; b=YzVzpsjy2WUURymEK8e5kNiz89RlQjPIYGtUxkPpyrYKiyo0JE51ZwTAmQOV4IXGA55Wxi9r3UydPH6+mObwDh3ljQhyVH8iGl6siRZ+4EYbJAvor15VcEOuNhx4K7CXvCZ5GCWFPYnNI+KhpJlC43auzSZFQZ/pO8LqqvgBML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735611518; c=relaxed/simple;
	bh=3m5OV2CCsyBlW0DPGA+UiQXMKLRcM/yvVOc7gX7rFZ8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=djbaTa4Q5+cuznPugSDqkFoAxqCYi7PCU85jMM3OdloJ6Nd9RHrWmf/g/q4ZjtwL7uZBvQsXHe/5RJyJ/sSnkGUYD7vYoickypSbWEte6pAxKR9iAMcaqIZyOCjbleeU8t3lBWGmCBPXnoFMf3LHzpSj+Tg/mVQ1fCT4KJEVnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDkFktJd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDkFktJd"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3863703258fso6297334f8f.1
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 18:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735611515; x=1736216315; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf4nJgG4HCg1NNOMIFeTNBckM3MvlG6QKDHoWPLTEnA=;
        b=HDkFktJd4qpgfLtY/kqlFJ5sqYDoKWlhcO6Zecs/vJyYAULuFM0HVVKY6rOYtpTFgY
         JvaXoMdb1qkke6I7+Cn9yX70RzCVrckokYLasiYQqDrEBIEVwXv2oQEseNWg1NPSxGMF
         OWWt0RRZCIr2zln+Wk++sHi3kK5YNOmGi/o20yFoCmTozqV8eeWk5xTnaSbUS7SXPUT0
         xiteajnFeBdttUlT/Jep7zOUJ+TgA5/P3oZQnQbunbBJPbEVqDhPf3stDQgPR3JmtQ6z
         dfTCErAPQ+0AeTgpP9Ztay81sSaUpvL220q4X4bwZFn8gKhmkKi+b+rSB3NJRnfikpSQ
         b0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735611515; x=1736216315;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf4nJgG4HCg1NNOMIFeTNBckM3MvlG6QKDHoWPLTEnA=;
        b=ZppvFk4bWG04duu7s/hREPAyIThkksXZeUuinxhpvPT0nDwFbLPRCLPJ0GHHJrq90S
         MljaNZ1KjDwvSRcZdXDtX4mqxtL66zvIqHLg1q9rlhGTQdvSy3FTKxhhhC8tMAdiCmVT
         BdrKLwzpKMU59dKCoaBk6Fu9JcqaYDSr2vAouVvTXKIQCgvGHAuuI5rjcg1JM99H6F0P
         6dJqoVgb1KOAphbJAPFwpJuwgVE9GuZf0Jl1J8WwDMFfUYrmxs8Tn7OI248yGzvZ4Frn
         Y6Dn73P62OcjSbqnRwW96Rma4clvquKD1dOpsy1jWRmSbxPb/I72uzvYkhXk1qBljtHc
         r2tg==
X-Gm-Message-State: AOJu0YzKoDw2Px9hUhP+ZloGtqsb4BL+M8sE0MVxDGmvBW3GfkzvA9Ty
	Sjocaamrl+pb9rkW1j4o3WmbFpzmYNUVT9/162tNdnhxrfV3u1FYqLWcew==
X-Gm-Gg: ASbGnctbsEX4xoj+yCRtVinWM9M+MfW/EQU6+QAtWVka2WqrvGhfxYxEG0kL6QW6c66
	NYkbd1yx78QRADutZO35FUg4vTaSTtSZUKOT+rrMObM6w8u/K1PuyvdGNnYNTThnhLhV/uHyyVj
	a+1vZRHJWvr+GvcbgSWf82BCl2gXQHOdiQQSns+xMLm24AYtK0ULcGgmxs+rnJ34Qwit2D647hE
	9fjaFdig5clVS6ipmTAxFweAy0X59xcFADGUTyo0a6Ospwf4YOjDHEatg==
X-Google-Smtp-Source: AGHT+IEMdVp/sVOUnS40N8VtcbntYmiAHGyb5avVZ2wQEsH5kxfWXRZDjR+XBcRvMwDSrHA/dxg0ZQ==
X-Received: by 2002:a05:6000:1acd:b0:386:3c2f:a3e7 with SMTP id ffacd0b85a97d-38a1a1f7298mr34011224f8f.3.1735611515086;
        Mon, 30 Dec 2024 18:18:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43664b15365sm357467215e9.7.2024.12.30.18.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 18:18:34 -0800 (PST)
Message-Id: <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
In-Reply-To: <pull.1843.git.1735041177817.gitgitgadget@gmail.com>
References: <pull.1843.git.1735041177817.gitgitgadget@gmail.com>
From: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Dec 2024 02:18:31 +0000
Subject: [PATCH v2 0/2] gc: add --expire-to option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    ZheNing Hu <adlternative@gmail.com>

I want to perform a "safe" garbage collection for the Git repository on the
server, which avoids data corruption issues caused by concurrent pushes
during git GC. To achieve this, I currently need to use git repack --cruft
--expire-to=<dir> and git prune in combination. However, it would be simpler
if we could directly use --expire-to=<dir> with the git-gc command.

ZheNing Hu (2):
  gc: add `--expire-to` option
  fix(gc): make --prune=now compatible with --expire-to

 Documentation/git-gc.txt | 6 ++++++
 builtin/gc.c             | 9 +++++++--
 t/t6500-gc.sh            | 6 ++++++
 3 files changed, 19 insertions(+), 2 deletions(-)


base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1843%2Fadlternative%2Fzh%2Fgc-expire-to-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1843/adlternative/zh/gc-expire-to-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1843

Range-diff vs v1:

 1:  14e94bf04e5 = 1:  14e94bf04e5 gc: add `--expire-to` option
 -:  ----------- > 2:  579757957d2 fix(gc): make --prune=now compatible with --expire-to

-- 
gitgitgadget
