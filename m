Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC65238C03
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262293; cv=none; b=Z7cdVPaLFKqkHaHxFaYlLzegOTn5+UuvBgx/M04MRjPxq1CZKqavhdnr2Yk0EA2acDKywRX4iW5lAblOwtC4OQgpNnEgVv5ak7eKnhxqEK6nHy+mLRvIpXxHgRjWKz/C3EMucyxT+WseibKAxRTQKNKCfe5Iys9Nh+krE+d7vUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262293; c=relaxed/simple;
	bh=sIIv6W6su6wrSRLcWXxyqHqE6hLxNy04QdrqERR13Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FqecUtzM5bV067pT6n/CYs2fsntooSLlIt0KpOIGFqZW2p1Pv8OO+h9YmrDPx1fMB2gLbbMKW+aTXSSHMAgFoLQ4HSs6AP96u+m3FYL7UNagKi+EzObUEz0gDnqtyVYRJcPOdq1+Eq5zDH7M4ZLmnEE3+Z1ihSONppKlKzxIA3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRPWoB+L; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRPWoB+L"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-427621906faso21179955ab.2
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759262290; x=1759867090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9Jgea5MU0iswOaLB3TrwTEzKwgrhnf7uXaSDK5uWAU=;
        b=CRPWoB+LOo6ifPEduduXJlOmf3IfWlmEw8B2L/kCLo3BP90Qr0YSvaYEWum+Srfd8X
         1TuvMOftxaubkyrFCMSr+/ZivnB33yHf4f8YbJOG49thrRGp0QJmNgmdBUvUpVdJ1Qqk
         kGt1rnX/lMpSff7jduwbF3Zhau01rSN6tHiDdjZzmCIvo9G/oraqP9q7QGNRAK4bMEtl
         HFNESc+oAVvXZLCaiUpXllPVqucpPL1WrQEcLwBjnwF20bPotdvoU7NkgA1bXofjoNWA
         CLzPRNkrUWFMvhlQO32Sw8CNFYoN6Oc37KuuhYkDWfzDWdSbZcApeW3PQLpFvjHZ0EFz
         DuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262290; x=1759867090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9Jgea5MU0iswOaLB3TrwTEzKwgrhnf7uXaSDK5uWAU=;
        b=H2nw8NfA80wfPwirUDzmk9K72hgd8EovW0wWWtE/RnNCtaWxXQf4B63RBUQfXu/8Ra
         8a1OzS6YIv4Msxxxgleq7O2kaV3Db8dadYdBKIpKF437khsMkWaUTmsLKramxDMHnysQ
         6huGm9LLOPziFiDEqVGGZNGVfMZm3U1Zc7KX/NZfK3ra3uPWzSzV+MDlUBLueqwR71lK
         7VZlwvhOUFuzBrjlXWJNuKBpGWnAMizTKLT3oWTL9mLVyfjxU+0pgB7KCIc9W5sVreVr
         unqK5oYIwQkM6J0sXqTvqfKahaRXitY1PzWEqb5N5nd28uB2iUxqfONiSHsxLO+Bp3cR
         5N5A==
X-Forwarded-Encrypted: i=1; AJvYcCVO68F2EK4We7xGS42quQUIAyDjuo6I+SbvrK0vr8KK7ss449ztHcM9Va7gD+t3OB3yw9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9a0RX0dAKu2HbMak/HoU6aevbs2W9Un8sdilaLbMBqIafMGJv
	PUpgBva6JD/MkvpubrlW5ApZ3XiGthuU5mUVBhMOBSvP+b1tkYGjmRyfmLGt1Stb
X-Gm-Gg: ASbGnctU17ofIXJYozw9p+FUm0WNXtko83Fliqo/ZulUgrmwPAHcr03wnG47LLV54ax
	2mUut2mjx3sG7ZDxc5BCv4GmQ9NFjSJAYZLJtlQ7noThmus4pgUzO63gw7DIjD5qbivPTEkfL7j
	Ce2SpgX5gIkM8TPlKY9w37V1Maj6LEktiL7+tPhJ6cUaY2ELKo9NiGRTwmlgoYO+tS/Pdi+IGMm
	Vy4h+7whLy1xnEcoq49YbDPazna71WiMoGt0URhZCXTzEFtMwwnmA1N+rznOnvSedjLUAfDm3pX
	Vdokyv/g7A9M9X4aJPeL8YTC6qnHHH2uxmtZ/a5eWechop9Wsr7hsZSO9rWnvzpr5n9uc8BnJOW
	jiOfovlza65aUrgH5qFAIO31YNMiOaM3CVd/k917dd+yVUBXuIikC+A==
X-Google-Smtp-Source: AGHT+IGlnL/bOlpP9qsqnytSX4f2sDVAWITfXuT03LDjKP+caYBWIIuNsbhzAOlfMyIea0HMP0N3bg==
X-Received: by 2002:a05:6e02:1a4c:b0:41b:6e7b:3e9f with SMTP id e9e14a558f8ab-42d81676819mr17120715ab.19.1759262289884;
        Tue, 30 Sep 2025 12:58:09 -0700 (PDT)
Received: from [192.168.16.8] ([135.129.173.33])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d7f1abb60sm5897145ab.26.2025.09.30.12.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 12:58:09 -0700 (PDT)
Message-ID: <ea8d572d-47c5-43c1-9a78-d15941110c39@gmail.com>
Date: Tue, 30 Sep 2025 13:58:08 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Sep 2025, #11; Mon, 29)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv7l06gwi.fsf@gitster.g>
Content-Language: en-US
From: Ezekiel Newren <ezekielnewren@gmail.com>
In-Reply-To: <xmqqv7l06gwi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/29/25 16:19, Junio C Hamano wrote:
 > * en/xdiff-cleanup (2025-09-26) 12 commits
 >  - xdiff: change type of xdfile_t.changed from char to bool
 >  - xdiff: add macros DISCARD(0), KEEP(1), INVESTIGATE(2) in xprepare.c
 >  - xdiff: rename rchg -> changed in xdfile_t
 >  - xdiff: delete chastore from xdfile_t
 >  - xdiff: delete fields ha, line, size in xdlclass_t in favor of an 
xrecord_t
 >  - xdiff: delete redundant array xdfile_t.ha
 >  - xdiff: delete struct diffdata_t
 >  - xdiff: delete local variables that alias fields in xrecord_t
 >  - xdiff: delete superfluous function xdl_get_rec() in xemit
 >  - xdiff: delete unnecessary fields from xrecord_t and xdfile_t
 >  - xdiff: delete local variables and initialize/free xdfile_t directly
 >  - xdiff: delete static forward declarations in xprepare
 >
 >  A lot of code clean-up of xdiff.
 >  Split out of a larger topic.
 >
 >  Will merge to 'next'?
 >  source: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>

Other than a typo pointed out here[1]. This patch series is read to go.

   [1] 
https://lore.kernel.org/git/db85429d-2c89-43ec-a92e-96ad8d0049ce@app.fastmail.com/


 > * en/rust-wip (2025-09-16) 18 commits
 >  . misc::varint: reimplement as test balloon for Rust
 >  . misc: use BuildHelper
 >  . build: new crate, misc
 >  . varint: use explicit width for integers
 >  . build-helper: cbindgen, let crates generate a header file
 >  . build-helper: link against libgit.a and any other required C libraries
 >  . build: new crate, build-helper
 >  . github workflows: upload Cargo.lock
 >  . win+Meson: do allow linking with the Rust-built xdiff
 >  . github workflows: install rust
 >  . help: report on whether or not Rust is enabled
 >  . build: introduce rust
 >  . BreakingChanges: announce Rust becoming mandatory
 >  . doc: add a policy for using Rust
 >  . make: merge reftable lib into libgit.a
 >  . make: merge xdiff lib into libgit.a
 >  . make: add -fPIE flag
 >  . cleanup: rename variables that collide with Rust primitive type names
 >
 >  Expecting a reroll, but probably xdiff stuff comes first?
 >  source: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>

I've dropped this patch series.

Thanks.

Ezekiel.

