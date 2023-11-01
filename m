Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAB5680
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esF4pqHX"
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B4F4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 23:34:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso89852211fa.1
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 23:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698820459; x=1699425259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIFTf15ODN/FZZf1V/i59mJ8zTggezvg8lfgB5ri3hQ=;
        b=esF4pqHX1mGH+Z5S/0A8/3KsqREmJd1OBpHp8wO8bC4WmmZcWERhWcfp0TK/11QPta
         FgYcAMada70qd3XIton8S+CjhEuGZJSyw7imjX23mqwURMD22sPh1Yjt4L3MIhoG2FDs
         klNnwK9mKIfef+VLXx/ge58mPyOSRcQh8ZGQ2G5dMy60OAn0pQbYHRCyG/yxQPypyrlY
         eYoG9murFhXoK36c5chR/79TzYLwJ1oSOeAgLsvrwSxNl5uZOYijEqaXS2yf0Ni5giVT
         0HAx1kZ/III4AVYmVqrIb9pUZdVYQqOSejbFaHdWRVMu7ceQ18BVR9rLaxpaEaUATND1
         wLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698820459; x=1699425259;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIFTf15ODN/FZZf1V/i59mJ8zTggezvg8lfgB5ri3hQ=;
        b=t3eR27+sXHLVDrAL/XAq9YurxFq5mw6XQrREm12c4BPkKKSpB7250DLhgc1G36ySP8
         TJSm2Uf1PKafB/k3NDwtZ4S7tlgGB19ZMBT/igi/haUsMROPosMA/IeGvHUrElLjp+pj
         XTBoojITQuuCJY4IgfYuVGVz6TUeamsN+nGVRFXPK0YPfSmualXFu5QlyQxh9jVBkEbQ
         Mf1BDYp6EfCLwanvYZEGZsFpnVi1yenzWvZIKyncFl5Cd2QTDwlmaXS8iTf2wThHVqgW
         wCr0ajdDodYRv6wrVpeFNhpE1YlkqR4uChVxnG9qGyLgcnff0uKmqUkfsipRU1CZtHaY
         ghSQ==
X-Gm-Message-State: AOJu0Yzhr36UE7NivoZXt9j0EE/hW7VsRV1hUlRVHrQvECas7RldNAwC
	xyrjZYZNnZCBGruhFdYtV2hWDyUDvFpRwA==
X-Google-Smtp-Source: AGHT+IFoj6KSlM7WSDbY+wtf4zzAG3QMpJuIWYEie7n2sVqa7SctLuEV34t2E9dw2lFlQzFhkUHaCw==
X-Received: by 2002:a2e:8090:0:b0:2c5:183d:42bf with SMTP id i16-20020a2e8090000000b002c5183d42bfmr11124968ljg.45.1698820458414;
        Tue, 31 Oct 2023 23:34:18 -0700 (PDT)
Received: from [192.168.192.11] ([178.127.214.205])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b002c0336f0f27sm116968ljl.119.2023.10.31.23.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 23:34:18 -0700 (PDT)
Message-ID: <aa3559d6-0e05-4c7a-818e-8a0cb05e908b@gmail.com>
Date: Wed, 1 Nov 2023 09:34:15 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
To: Junio C Hamano <gitster@pobox.com>
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
 <ZUALkdSJZ70+KBYq@nand.local> <xmqq1qdb8wzk.fsf@gitster.g>
 <cb166ed4-b8b5-4120-b546-e878445573b6@app.fastmail.com>
 <xmqqa5ryxn8i.fsf@gitster.g>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
In-Reply-To: <xmqqa5ryxn8i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > And the only effect to have the "--ff-one-only" option is to allow
 > you *not* to look at what is on the side branch.

Moreover, it allows not to forget choose the right way and allow use
a lot of external tools (GitExtensions for example) as not all in command
are console ninja

Currently, when complex features merged with --ff accidentally we have
to do in main branch something like
$ git reset ...
$ git checkout <some_old_commit_which_we_have_to_find>
$ git merge --no-ff <latest commit>
$ git push --force

And that's what I prefer to avoid

--
Ruslan
