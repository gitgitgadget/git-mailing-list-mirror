Received: from mail-ed2-f37.google.com (mail-ed2-f37.google.com [74.125.228.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD64549367
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082053; cv=pass; b=UuBh6IzN9VWSC4P+mDzBmkxXExfzG1WWqYsEtLFgTgTeVeX8T9gWCM4ZCNEFFgiQ8X5+bqkA7qlU3ejJA/hLoaIqUIGgzJXGf4GCcakTlZv+zZlfpunbw0xJO77OgdF7WKALXC7QS0Pi7wpgG9lSC/4fyzLyT4cFB7qKM41YlW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082053; c=relaxed/simple;
	bh=tBiL0Xzf79NOfxmP0cF9Cbv0JseBUPN0YOrRLOB/aec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0tpkvq7V2RbWFCiFqpEXF8Y8AnPVmzC/SzeYyqxpsNlLmVXqZeeWpG669amThKm5NO5ksKB4mXhGb72iUPnWuZIZRGQ6xo7bT2UqoLv0zmnmlACc4Pv4iO6Bz9DoxwX1My79CmMgTJCYN69zOSLXrToXk8RrCSxqnaxwe5uQW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOU3MDRV; arc=pass smtp.client-ip=74.125.228.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOU3MDRV"
Received: by mail-ed2-f37.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9a59so5962529a12.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 06:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790082049; cv=none;
        d=google.com; s=arc-20260327;
        b=buTQoPOOJW2ztyx6ZecvvviDyYrocKvhhE5JlrXJNlE4SH/d4wETPgJys5YyzJHCM/
         Ley1TqRWDUAavdqH1iqa+w2Q7A19QCNCXvhjPn7JJV9znxR3dUHWzjs9vb1kOGPt1VsD
         seb7eZMzc4NSMmHdc159e9vwE8w6Jhz8lf4GPWDrb9C2dAZYLA4THo2/wUsus3w75ycg
         /FSIkH/KYr8M81mZ4IUFU9yJ6Ys5xFqmamgdTAbGmoSwl7OYm+TvyyZVVPsXiunS6nCp
         YlY0FVxKdIWO0uP+um41hJplHJceROAZA94bNjkQgXxJQRSwOeBlPu4in+bxbIhd6skp
         Wgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tBiL0Xzf79NOfxmP0cF9Cbv0JseBUPN0YOrRLOB/aec=;
        fh=rYq9H8nwoes997+WaR04ZOL073oATMmpc/iUrgvi2pc=;
        b=D7gZal+hdgoB80TOmtZ42bUgKuzt6VjgBCTeUCijkoubREtbO03nqoZbk0VgvUXmde
         ZjwWLJjG6mBVpn6zrjG7cwT/KVK/mjXdSpICRvvv/unEh+XLTuCZN07X/ssbef1B4MUP
         sVuxdP3vmozpIE3+ONXryhgfND96uZNe2R7u7s/AWB9b93IRMRFgt1FHQd7bL+x5RE/x
         6p1BqBR+F6iWRz3xt084GGm+G2M5zfnvB1IdCLF45x9Dmrd1qdeEn/ZxuLoz2X5zE9pW
         JWqIFDXiVdeHw4qKSZtYQfMj2uJL8lou0XFk/w+Q6zdIL0P1APbLNJ2w+daOvLtpB4z+
         E5KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790082049; x=1790686849; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tBiL0Xzf79NOfxmP0cF9Cbv0JseBUPN0YOrRLOB/aec=;
        b=jOU3MDRVWpSzaxoxP+gl/QcKqtO9deiiBef2deP3KlQQp66BHqLDSml+ReKlsZi+am
         8nK0QlZ53V8vTdwsgEaWpIHVk+jKsH82xP2CymmBJYZARvrv/6f3zPpzQ9jWh15rz3Jd
         a3lh9Fr9Il+tORJnhsiC2060z/wCuuFgvQ/JyNhMoRBzeZyPpfa458e6sujl6m2Nu+Gh
         YMNSKkMtnq4gRto2pyBIJ7hVmMyk4U9LlPlPCr+qmkEMQnzqMCOfh8zznJyz2OwUosXe
         19r0NLFEGmdCIPvmUQdHx60u49e2hHL5xcmVzmrzyzWdD0AfAB8Fj4vS5QLS9JUV4Va8
         qMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082049; x=1790686849;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tBiL0Xzf79NOfxmP0cF9Cbv0JseBUPN0YOrRLOB/aec=;
        b=R1gQrA0UTz9JsaR+Odrjd6x/nzqyN154cpJWPG+X7/r7u8wpycH74NIiVNkEbUPR7n
         d3TgQvJK3fSSyW+TEQSfNB/NjXaZkXRiN3SVTvVlQjjWQdURNQC79l/fpTLMonky/S81
         HzLY+A6cNQk+FS2NA3qIRylPO78aDIfPk221s5OODBNiahQUQlF7MoIqrs8XISJPjzDN
         H5i4O63NZM0Ya96e++gHdPT7PCjZC4hT48GgDul5vIPkUQeA+71gc2IaAUtqh3BY2WQp
         gZL6uvIFd9ja4z8+VnDgm2+MEUEqSabQO/3vsf3K9sctCk9niL+0jCNw/ZFCSKKR6lcz
         owpQ==
X-Forwarded-Encrypted: i=1; AKwUvBymukbFFX9/6PhXiaBKqdrWMB0CCO9LtesrFX/IlfAMTf6ACrugG2wTSODqeIhP7S/a/QE=@vger.kernel.org
X-Gm-Message-State: AFuF++lVfvZeQHpaNOMDmTGnj+dgTKG86pfChcK6qPwuu9dBW7qNOSOQ
	rx3i/9T8fYC6EP8ozfemP2CTpR4jKbU24vSpxF1eDC0VthNKWpjW6i+JgNx84lmatLDinq5sEAG
	E3AIVCjRmG8JBr45dF7dF/r8gpf2aClVTsA==
X-Gm-Gg: AYBFou1b+QAbhWSTQZiad8SbtFhidlQ3BTXtOVpZWJPmhvrVfDM/3L06unKzyCA5Fyr
	NTmHQC+PawFo5ofCkrGjbpMmJzKflsqBLPIoBVpbHtP3vegf81/DuGx3c2RMvwyFgaV9bwgRyNL
	kwrcUjYHU8HMmLCNQyvv9QAGGh1mxQlKruOzIruhiqIA+umJnh2IX5+7hVVuhDNc+5i6gUg2BJE
	Vdm7BjGqdmQXM+ZRxnAEh5UcAyPe1x0lsTKHueu333A75vVvtdRU9vNcVmXl79iOApDflzA9Miy
	cU0+sTxTcmWHKqi0ZnH0WIxaI7g0tLc6A/FmlKwqGQNpJuYNUqqJwu4=
X-Received: by 2002:a05:6402:3908:b0:6a9:ae3a:9c9d with SMTP id
 4fb4d7f45d1cf-6aa531b797emr10607297a12.29.1790082048945; Tue, 22 Sep 2026
 06:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com> <CAHwyqnWbbCK40qAU1vhCFmN86J-dCY3tv_N_nBYgK2Bxf3o1fg@mail.gmail.com>
In-Reply-To: <CAHwyqnWbbCK40qAU1vhCFmN86J-dCY3tv_N_nBYgK2Bxf3o1fg@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 22 Sep 2026 15:00:11 +0200
X-Gm-Features: AcwNN1XGXKPgHMuANXmsnIOXg_mDDnOagIQ6vZvAy485f6PxgVUQWQbf6XO-ICs
Message-ID: <CAHwyqnUVkVUjKCiN7YT3tkvHEVCQwb3jDGM0OTojPxptFKrsLQ@mail.gmail.com>
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > If it is the former then we should think
> > how we can improve the behavior of "git remote add" in a sparse
> > repository to prevent it adding a wildcard fetch refspec and instead
> > setup the new remote to fetch only the branch(es) we're interested in.
>
> I didn't even consider that, that sounds like an interesting idea!

Would you suggest we do that instead of this, or in addition to this
fix?

Seems maybe we only need the fix on "git remote add".




Harald
