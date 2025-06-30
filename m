Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AA29293F
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300197; cv=none; b=MbudwPkfzNJyjRqwGrXqsP0i6zKVe8VCT44zxPEana5O0CULnbWtAjKi08sZPDkZl/eF/wxnsnyT4V8gK5EN4yQ42wj4yw79lmWdDMXQGFqJbz8KB7zeYkbfxjz7OBaQ7h06ksq7L/gBDiTCeDZuBUKCh8+f4CwQ3+voF3oUyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300197; c=relaxed/simple;
	bh=z7q/fQ5GA25nldPVMk2eues2f49WWVWcf5jmhYzAz2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gh9WBwsZdPFEGB8yzAvFB7CG4xt261jDIh7z2ZzhixCQoVRtT5HZciVhc2sU6ZvAwzwQ+PT3LOp7Uu8VtR6CmQ7URnp6QCEedVSYITjRtaad8gSafulNtouTnwpusoG4Qrm3baJIdndFFrqWZFI/T61pAr/5IJg+qQoSLHDQJ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj/C6y2g; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj/C6y2g"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so4417083a12.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751300194; x=1751904994; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8KqQgLbaU5brD+i+P2lTbM27mJkU6LSvGHd9uy7BoQ=;
        b=dj/C6y2gChEH3c7kAVCUI+u5qRe9e6OUhhxaVZMLIpquuygdRruLm1Xs6YL4K6CeqM
         iCpWfn5NU+BeBi5AEzzeISlbfE2btohq/SEKT2LhNgSfRBOw2LxFY2opQhvoxNGe9Zlq
         6VFnjQg+y7sRADb2qfGtn8nmAYc378wbaJo7vJoIeZXyP17urCbnGOLAl76v0VIZO6/l
         beFOn+Fb/HARgD1Xp2Q1KPhFV1q6FanqpoAlnyAdPJJbThcaaz6aGbCe8PuxlFpgeTc+
         Yp+U0d/q1JUuFxlBTveDTDloqgolRkynIwbRc5m9drEOeZOnMsOFx3/V8G3nkmQjqXdh
         3EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300194; x=1751904994;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O8KqQgLbaU5brD+i+P2lTbM27mJkU6LSvGHd9uy7BoQ=;
        b=vG2myWgI/+JuxTj0mE0jM8Zcj/Wn8IOuxpyhuV9Vi5GajGoY8JpK+g47aFEHFsNBp9
         cvJClia2RDJwARlseoMyv+6mw6E55dU7B3lm7r9h7KJkkCVk79bwLCxq0Zq7+kZ78k7o
         8xwuoPbKN2AjuUJWD0FbcURHYenlmyPch/DnwZdyMDEwjMdYVO5k7gjcELHrHYqqCskd
         QIGTIsgTJ7CENfEoOljBjNPPzqaW668L7+xT8ukHxVBF1QFO/VMWF9bD1WlMBDdEW4oI
         qCNvBiHPQByO12G6Iriv88dBAkO0sMjKgvv2j7OAKgM3M4JPoRt7QuUkcBLmvsWqPyQE
         0SOw==
X-Gm-Message-State: AOJu0Ywvn782G1yPbFrQCJltJQfNbdymxuK88EvX7OPkq7bbNxingjN0
	l1oQoPnz0AXI1HSrb19fk3oCKZdq/NIMa9dBkbOI8Y9TSXXClGzUckVg
X-Gm-Gg: ASbGnctAGdRjGTnwjfoclgSeHjP9JaFqZuvT37tXruIR66gpaSu6OY/bPiY82HRLqGp
	QTJ1YHzweAsOIzkzTswRZ8rOY07JZZZQOoYhHfPtbBUF2SzT7c5w/Yq9gxsX3lur8Yj3bVwYpdw
	eA7ze3JV2Ic416nhc+6YX2SshTAqFAXPLRyK2nf3bouSlVo/b9w3LdW6ICDQHBBh+3w8OdT0N9z
	wyS+nPmv4YJpBUtSPjFJy+xYMOxf5VvY2k2Sc9lsT6nc3d58Yn4juJkUeI0PBH7QFU/qGOlayGS
	DISoC7aX+6Slf6P+KKmMQM4mPCcbhEIdprXN7SVALOOPsd0HqhZlTU/o3XBnomf6WpOa8t/Jvyt
	zthepcpSVs9KjI+lAC55cIMRHDFc=
X-Google-Smtp-Source: AGHT+IHDz3HEUSc9nRqEdNlT+9ASsjYXTHlt3SDVgvideCub0T2Ug6cJB5XiUzTGyxcQ0oWzhJqG3A==
X-Received: by 2002:a05:6a20:4304:b0:216:1fc7:5d51 with SMTP id adf61e73a8af0-220a1802a4emr24175159637.37.1751300194054;
        Mon, 30 Jun 2025 09:16:34 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af56c0c8bsm9464866b3a.113.2025.06.30.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:16:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH v3 0/4] Better support for customising context lines in
 --patch commands
In-Reply-To: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com> (Leon
	Michalak via GitGitGadget's message of "Sat, 28 Jun 2025 16:34:42
	+0000")
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
Date: Mon, 30 Jun 2025 09:16:32 -0700
Message-ID: <xmqqwm8t2oin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Leon Michalak (4):
>   test: use "test_grep"
>   test: use "test_config"

These make it sound as if they touch all test scripts under t/ but
apparently that is not what this series is doing (and we do not want
to see a huge churn like that anyway).  Would something like

    t: use test_grep in t3701, t4055, and t9902

work better?

>   add-patch: respect diff.context configuration
>   add-patch: add diff.context command line overrides
