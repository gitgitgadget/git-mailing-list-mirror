Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7B280CF6
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613956; cv=pass; b=qJDss+9xoACCdIPWdpGlxqdgvRe8lwvPgao9bTLMZkh+HVQPll4tGENp75ZQhosbB8g3PPtEqxA7a9mbzAgXkw1vEh5zl6iYk8rLV6eGB7biI8lH6+Y4i8dEE32+VGW3AvUrgOKww0rPXXyw2sc9lLX9rW3HgS+dYY8HZE03+eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613956; c=relaxed/simple;
	bh=in0mPhGcPb0iaTYxLFlX7UB6dCWeJPW9FQmULitCB9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZxeF1BVNBk8EiHSUZucydRc9p+JVYL20At5Gi2OPG1swlhWf1qTO7eNMj6uHcbaROFGpnwdze+CSFZ5otWFA+2D2wVaFlWoK58psqyri842fZPlzMdO7YMhk7u3eWmL1n1eWraDFGkfABpieFfQREHTz+6iTlrQIRzv3JriJEHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxKTUQ77; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxKTUQ77"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8773fcff60so97687566b.3
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 07:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769613953; cv=none;
        d=google.com; s=arc-20240605;
        b=NMBKvh+BaF38F7j2xIh4zb8nvQnAF70ApbUUyJ/az8+EZklzZ7Ngma1H3Bt25io7O2
         cnGJsCX1idZzYip2gdByaSdBGoeNW7Bli9KbTjfsdlEXbbKN8L/58rmIU1p11GEJhr0I
         Rmw6+LwcXJ5JrXcAWeJkVZyyvzb6gFTEXbJv5b7+ofEwlzKi72yVnyeYlxEoPnzvXHaI
         W/8grEB3BG5/AghO6apUQgl00ZwRoHIPYRo0nPe89fwLxEpsW2GxOrG9/aCvKA2J3lTz
         ZdLzUEEfseQLyZy6zJ2QbjVlwR70q6vNqSZYLXeIYqGr1oKF6xyNe6Z5KenMR3zxSTPv
         TpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=3HOyL+7ttHh1XwgOBSXomwRRXnIifKzI3BPlXa4pTG0=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=KVKw7FGntB3cjXyCkWI97RLdp52qc+G9K4BZRrm1hJDhItmSTU42+JkMcYbpHJ8ds/
         ix5BSWK0JsiheGScIazBmst7bx/LnpbePRzTtktPVZScw1J2Kmd2NdbWDkfiZOpq1EDF
         PChgMjUXXtsI0AD80PPfc1LP3eQfqpyE4wqNxD+8/wVgnerSJ1yvDCKMvxe4ToGLQNLp
         CvlKUU8YT/YnT6IMFFNngs4UDyDZDNI5Hdc2XyNNaWhrR1pbC6b00PZOcB7evtt1+4Ao
         fWpoqs8Gka2BEncVdt2hLme7vKADOiDmcDMAkFuS1qBNuGTyJrgVBONBk1TmaexVTn0i
         v5aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769613953; x=1770218753; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HOyL+7ttHh1XwgOBSXomwRRXnIifKzI3BPlXa4pTG0=;
        b=KxKTUQ77csziWAUTZSHI4w4elw8DiiL5uw1FB55FeC6GNOgBBDBuzq+RCQilqvxed4
         QUisVV2opkA0BYDj6keMEf8IXTgGAccRcCbDWCuZL1jzgV3Xz57zyoZa35W1JGVIejuC
         oBMGL9HfOBwajCPK6NhXrvgvWD41mA21akKwZssZs7UGb0Jl6v3mGGcu4t1NUsdp63tT
         hREyA84lw508Rs1Rs3LGKozEb1ACiMmDoZloJmFtxgu0mPgnvpRc7dJr7xXwLwiX7xf8
         M4tbBVDVUO9JE1SWLHi6LotYluDsCbCJ56psWfsTWGazpzMR+3z1z3gUk2Qn4rAkKZ7q
         vVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769613953; x=1770218753;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HOyL+7ttHh1XwgOBSXomwRRXnIifKzI3BPlXa4pTG0=;
        b=L6N4RUbjSrS9xOyCyfwIbNJekntRMoUUnKWUAhAfCfGoyYwz0Dq7sD1VMGmP7hxLR6
         kGejrSoX8T7u7+LKsGHXcLvtd7zRS3u0ZyxMrKR4C4Jtgw2JbSW90Ih+cCNLJVWGMj9D
         12P4j4tbJCgVa4beWvTUF94x0eLazfYZNQ6GBJ1g9lBIuxkX7aA0SBXlP6SRgIyHakGP
         0UkjE1/Ku2i6CIL/r8CQaxLkdQurYiVNa5sfey04eCgl3RL0r//BHoiki7CIQweI1azG
         6lFgrubRx9YGFoH6fob9NGcc5aXkEz2O2qTlXldFrPtH1km4oSwEIK9My/j8bigwrS32
         BUpg==
X-Gm-Message-State: AOJu0YxqgH4hIXZk/SPntqo12bLnli5agIvs9v7bZJkXma0YohulK6J4
	lBIqk5Sz37oREI3+u6WBOCqhRbMjxueP4Mfft8ul31JdLJyc8I3IiWtkztfJPPz8PqedYExCG8y
	kioSDlGCzKmAn0Vrh/GVmpSFZwOAQfmGUVnvHOnc=
X-Gm-Gg: AZuq6aKj3qX5wCetk16OLDs4/4g+MNb7DLIw88fo3tHPN6Q7fMaUeVSIqgY8jKzb4nF
	F+xMuTFgrTSvVZM9lMng3T4zNojnAcqJs0JEDi2hdsMXqJ9wsjGg3T7wcGDlZLXDO11xpwtimN1
	eNKgpDx4bEEi4m9lc2OTfeAKmY8GerErWXJ4e03nacczfhcM+TgKVhJXoDer/O+nMjtSeyGT7+q
	/zoHQfXscxYTnDMvoK4vXyiVEs1nPbCfpV/BiA+d8ZppaoRiO2QeaSsnLkm7vWOc9BHiw==
X-Received: by 2002:a17:907:6ea0:b0:b73:59b0:34c6 with SMTP id
 a640c23a62f3a-b8dda56c538mr16249066b.4.1769613953159; Wed, 28 Jan 2026
 07:25:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126165618.596944-1-a3205153416@gmail.com>
 <CA+rU_o5pzpHvvo=PwMV1-JUUa37Qp=B+-X3QqeXh-VRdNdA9DA@mail.gmail.com> <CA+rU_o7dZB=OCJHk9nGSbs4RLXmE9A3VUopa+6vF6oX0E9vxuQ@mail.gmail.com>
In-Reply-To: <CA+rU_o7dZB=OCJHk9nGSbs4RLXmE9A3VUopa+6vF6oX0E9vxuQ@mail.gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
Date: Wed, 28 Jan 2026 23:25:41 +0800
X-Gm-Features: AZwV_QhscNXAVXTsaEjZfrAJJ5ioeEwl-xKaPmfZzFoKVp68Iu8PbEIhDXsf794
Message-ID: <CA+rU_o6+Q89_xJyhuuO20kbpmEttKW8oTf4XFGM=R7V4ZygawQ@mail.gmail.com>
Subject: Re: [PATCH V1][RFC] t/perf/p3400: speed up setup using fast-import
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>...For this reason it is strongly recommended that users repack the repository with
>'git repack -a -d' after fast-import completes, allowing Git to reorganize the packfiles
>for faster data access...

After adding 'git repack -a -d', the time does changed:
                original(no change)        patch v1          NEW
     real           29.845                       18.081           22.231
rebase            13.34                         14.94            12.78

It seems that the 'git repack -a -d' line does reduce runtime.
However, the total duration
has seen a noticeable performance regression. I'm still trying to figure it out.

With regards,
Yuchen
