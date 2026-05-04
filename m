Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710E3AB284
	for <git@vger.kernel.org>; Mon,  4 May 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897340; cv=none; b=Gj4nnVKwI8w+fO0DK1+mbr65de7ce3lMu9OP9n5JdHj/I6ThL6gMpQkqfnPO28YzQAZDILjJIIKHvdg7IzeWejWQRmjbpe8HaTFD76j298kryeoHryLUdJxREdHtW8JoaF2Fs6CAvGbdEmdYwFLxR8aVTSPFmauTsHlQBZsyQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897340; c=relaxed/simple;
	bh=sF1Hybr9mYlgaa4RInLBOjSTKYNtzkDcTMIZw6g4VhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEXY+772QjVIlRmA0qwQYH6h5Qzif5oZFVsIhss9/5MqyC4HaYTaSdWYKrM03I5/2Avi3Y8F+Hk8tbo3J2JnAMk+7gOawYprndYypJokv3c6QWtvATc06BU6FpreqHW7D4PeQjXuWvmyX6ZfX+M81zokEo6VLsAxw381FgNGykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0Oe3Djs; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0Oe3Djs"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8eb5ad01402so440334485a.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777897337; x=1778502137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kHjrS8J6PEi/a8IZXzHt3we9/t5ax+E7XeKCDtjWkY=;
        b=r0Oe3DjsjfOguLzS1E+QJeRJ+Tz1oO7P5bOvAIacxxFzwV+yYETKSElgPBEGkMeBQQ
         LT6q+Zn0CldU6NlfuTxg0F5uT0p+s2CK5OtQ7v2GNEjLZK2ojxmw+0tsWyAzk6ouMJSp
         zBvYT88iv7gocbdlf8XX0faAtHKl5b4yhbCrkjj8C6ziMyYa9e28B2dKY7Y/Ak24601w
         Tc3AOAphk2SkqN7SOj/A0U4Sx8la8l7moMwGl8ipsLKcS/iaJsmDM6tYa+BNxFYRgv/3
         hXpfUTayQMqZNVuUuobWSauvnl2lx1cyGH3KQSO2CZI61TPht+6skA4fJJdCjH+wpYO0
         +HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777897337; x=1778502137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kHjrS8J6PEi/a8IZXzHt3we9/t5ax+E7XeKCDtjWkY=;
        b=hMk8TGPEKiUEnKbMILYU/EqRWrl/+BUrm2R378AcB/YTUXHX0tX6OsLGLO9yH2WQUj
         sTf9oJbQ014Y4A60L1vqCZm2B3Fhk6ZYxfW9wHkL8ulwMNxoUtU2e7rfFYsf30ic7+qR
         5tfD1ZFSdkyM/g/uwmN/XKa7Dw3FSWdoxvgvYLL+9dpYXca/Qgu2nyKwitXWln3PLKSZ
         wA3coFg7OQQMVMlp1WnHLIZFgAZsoBWYAi5/GdMyQ9Qy7aKqGIJh6G/hKES1CZE9QVnW
         eRD7ah7I9MHcaKdpskNJlueEIhUewZFgGBQvof9J082NL6N26ZB/Nm+66/HXFhn2r/L8
         HAbw==
X-Forwarded-Encrypted: i=1; AFNElJ+82iC9Xsbf5DE0+hyYde9PqK27aOb0f1aYdQRGbLrBu9gh7oUTF0YSgvhkXenHP2FYj10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwixfbW56qDKdK8ROzyNTv9rAx11w7Z6XtXTTSQFuGbR8dcX3YK
	wK+5vXTJ3aQD9udkG/bgvf0/OdQg5Ui+MRpSQc+zejIwp7xCyI1Ly4FK
X-Gm-Gg: AeBDieuMvBMwkO4sNbIsBHu7T+x6wENjf6rabwDAUBiMxoCEG/Jnkez0fpuegJ6i+9a
	K2glDnnqx+Qy/HapqHBiWcrNxowE+oUQfSG7ddQLHHDli5vI7BCP45L22blE+c21HZcQD9jZumM
	qtHuZL/mEEDipxbqbB3zU/oNPCM5FZVnLfhIzuDrWtsRsRFPlyiCmAGvflPkHf2fU0aVcNEkp51
	UrtyzL+21/u+86LqDTPlJsBBBwSNSmMQ+8QRVdAybVPfc0mkmP4pd7g/zpBQa0DEjc1WTYf2tQL
	AfkNXSVHQEk5Plyt9rlNaC3r+H/9jt8CiqrfLlehm3qot+EUZf99YClcDWfzs8J31yWK4TzrU5B
	7UG7Ta55FPyL9dQVIpX3rvjsLR3JXN6JhAtc0aQ3fM1ezdSIP6n195Mpsxjaz2Qn6KAz1ZamF7P
	UGeMCAzZ/cmyZ9kp5kKnou0WRilwMbFvKA0/UZYW71zPTyEQsKpmy2oddZcZCbM3HnFGhBO1QcS
	mzXtsuK
X-Received: by 2002:a05:620a:1a13:b0:8ea:bddc:690b with SMTP id af79cd13be357-8fd18236ef8mr1417874785a.51.1777897337387;
        Mon, 04 May 2026 05:22:17 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938596bsm1036625785a.5.2026.05.04.05.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:22:16 -0700 (PDT)
Message-ID: <180bf883-2941-424a-a01f-6a75d18823b4@gmail.com>
Date: Mon, 4 May 2026 08:22:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] pack-objects: update `--path-walk`'s existing
 incompatibilities
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>
References: <cover.1777853408.git.me@ttaylorr.com>
 <babe1596161365209c226d374db70a1bdc284a1c.1777853408.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <babe1596161365209c226d374db70a1bdc284a1c.1777853408.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/2026 8:11 PM, Taylor Blau wrote:
> The documentation in git-pack-objects(1) claims that `--path-walk` is
> incompatible with `-shallow`. However, commit c178b02e29f (pack-objects:
> allow --shallow and --path-walk, 2025-05-16) resolves this
> incompatibility, leaving the documentation stale.
> 
> Likewise, this documentation claims that `--filter` is incompatible, but
> `blob:none`, `blob:limit=<n>`, and `sparse:oid=<blob>` already work via
> path-walk.
> 
> List the supported `--filter` forms explicitly and note that other forms
> fall back to the regular object traversal. Also remove the
> incompatibility notice with `--shallow`.
 
Thanks for pointing out that I didn't update the docs in my series.

I should incorporate the appropriate language for these changes in my
patches and give you co-authorship. That will also help avoid using
commit references that are impermanent until the series lands.

Thanks,
-Stolee

