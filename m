Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C4156661
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 05:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765431341; cv=none; b=X6UqHLWOHFd8hQfyJJx4WfI3xaMIXD/TW7tjizPl0k+GQCtZlq895dd8+du/sTx2rJS5VoFNPwDWhyhc1dyWC1a5ufbGt7V8kxu85wtO8J327GVrMuDcbdRY9QMkth5Dhx4RONQaJudeXOJ9DOo+Myx5wM2STH8SLxL7E6sltck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765431341; c=relaxed/simple;
	bh=/z23up5GHFh+1nm2mulJqADRwk/cW8Py6yBEzOcRab4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=To9MqIAagVL9SNiE8dABBQOMdvkSL/Muu6aKIiuZMmlo/mja7HMq16UPj38dnL7SIkkIhsXyuCPfnjOjmWojfs1rVNDA2KK9qjnMB4ssJ7zInpr/WixKL/tVja3vdv1cUM/dx2aHf7Fo4ZqomqW5B8zqRyiP1UJxFTinfDVyfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfCXPq3R; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfCXPq3R"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-298144fb9bcso5960245ad.0
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 21:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765431339; x=1766036139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z23up5GHFh+1nm2mulJqADRwk/cW8Py6yBEzOcRab4=;
        b=OfCXPq3RIJsbVhC8svBmZ7LFwFafX7WOyYNo/y3clmM89Tzbf2jHbkyi/hGBiCnk6j
         u87+lELDtnb5pzuJYtmQwJBZP/Kgm3k1Iz5g0GyIPsiL7fUj+asCyms1vOxVLnjjv7bd
         G2CCHxbsy+b4REjy+tetJ0RyXlEPkljaui7DZN4kkjQBaYNZbase/6GEmOBBLtyKArA3
         U9/HlTOcM18K26GKyKG5mgnuhY12pE+fZMWQTVORuP/H0pV67OJKq9SRDM+iKW/Th2/X
         CgED00d5mAGstyFhNqntdOcE/vNWIUAZrmWcSq0FsWUj4I51UE33sF+VvUibFRiSCvX5
         Ih/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765431339; x=1766036139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/z23up5GHFh+1nm2mulJqADRwk/cW8Py6yBEzOcRab4=;
        b=IJhAcBd6KEoLr9f18AIGEK4GxYCd9aBgndoCIjMWQuS4zgKrIVHQB3H123djjZsiwW
         chWLJEAmlHu24BHZXxgv5rr4qHiM3LPjqBlIV7VEyLzAld5lRAozJKOi2OG//hVwI2dw
         eDpNHWCJjZkVoZWEYxTSH3R2xXGRaJgiBQz+D2a+lbulk19BgcV6dvknkj99dU+Fn9YD
         bHmn6ZMC/PRKME+e66rTTOdm7deNSGUaH6XDGJxQH+/la+VCRTe20b2PC2yMKQtk0+Ms
         DANjFcKgwksMmzC0nZ/Ye5c9xcMK0v5bfMJDrEjpLeZENtq7SZb49Ywv4WX81ZIjMLLT
         ZkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaXdabmYYgJb5U82BBsTx9D0MOo5UwMeqPuogDszgQf+UH9zD0snWEqbTAALbw+CrSOgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfukmC3F7WI/MMdZ//8pZXwQfFFhUyX4UtF8p7ovQYSul6JFy
	7XVb0cJYtKfFWv9p/xvCWBxO6cg8fRmJfltA0GeEQ/38g3BCjgTqhzFYX/nw5iAA
X-Gm-Gg: AY/fxX7LHNFIe7Wobm8LlLe2PU465TvbNepyPgPEz2jtYw6FDOdpKp2qGJ1NJUKzDa1
	PC/ecOBwQ3GsdDAFymiuABEWp4txbRJG/doJruc2KqafyxhMuC6CG1PYN0vmUjTyg424LVv9R11
	lRjFF70YEkI+VoNbmXlvkO4SyG0P7xozlDRQ25IORidD9OCERukYIMJoFGMi7kNCNSa93cN/YxR
	rwLPqtmvbVn3jXIWvn0x8FV5YWgtdoKXxTdSb8XSx3tXY9tO2E/aQCOIQj7HQ4haIJvHwyZBll4
	d+6LeTnKWsrZWctknF+3tCl7HomR7rAK0x6R9EaCKC9V+9sqkoI5HGDxwPui/ym+pDvp6FYcWjQ
	IqCqnAs9hOzMtc0HiMbootGS+gdAUvwPoATP5RowAP9gGAM9lyu6Wowb4d0B6vOZBerP9TbmeqS
	uBzsG1/21FRmA9Sge+umYMAe5rwAe+ICqS
X-Google-Smtp-Source: AGHT+IG2y67mgVvQwv8tUTttYvq4blqiwCV5+YPHpYsxW+nQwrQjE2bSers6iibtwB3dHQR99C+QXg==
X-Received: by 2002:a17:902:d552:b0:297:d764:9874 with SMTP id d9443c01a7336-29ec23095f6mr49130515ad.21.1765431338788;
        Wed, 10 Dec 2025 21:35:38 -0800 (PST)
Received: from Fedora-Gink ([2405:201:c005:b959:acb7:a699:c03a:f9fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea043d21sm10540415ad.81.2025.12.10.21.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:35:38 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: ak@akkartik.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
Date: Thu, 11 Dec 2025 11:05:03 +0530
Message-ID: <20251211053504.8758-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqpl8lg0u3.fsf@gitster.g>
References: <xmqqpl8lg0u3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I’m trying to make sure I fully understand where the fork-point behavior is coming from.
I'm assuming get_rebase_fork_point() and get_rebase_newbase_and_upstream() are responsible.

And when we talk about the “fork-point heuristic” here,
we mean the logic that uses the reflog of the upstream branch
to detect whether the user has previously rebased or reset,
and uses that information to choose a
different merge-base than the raw merge-base HEAD upstream, correct?

Just checking that I’m following correctly
before thinking about possible approaches.
