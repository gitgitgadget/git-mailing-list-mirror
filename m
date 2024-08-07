Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B91C6899
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024116; cv=none; b=Plnjz6ZvullyxBNAyWI8ozn++FgI6DedJyk39madWF4XgpYaLExnLqLYrmaeAL4HXq8UEjS72i3IvxS5pBDHBZ8TlpQi873m97qtYJZoyILoKjd+giUudKLjJle5CAOWXgye1IpM6kJjnX//FT///HPYMG+RDXRO2k2QAd+hnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024116; c=relaxed/simple;
	bh=K9cJD8GnTXeae6tk7XyXA7ny5+/e/K4LEGmEAGg9paE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=DNxmbm4FRDeedEesLjMtTkeZg3/nyQdGjnGJrUQ1/vKtWqWjybekOOd8FkMYFAN7Ww5IgOovKp4Bz1dRjY4R7f+Go79TZvrjZJVrqX75qNTzwzXIxHBdsWcNT30EMRyNwCUZSY5K+Ml+8HVHGiO6CbZkXxijVMTApBRpU33bcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPBJFeME; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPBJFeME"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so1246221b3a.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723024115; x=1723628915; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9cJD8GnTXeae6tk7XyXA7ny5+/e/K4LEGmEAGg9paE=;
        b=PPBJFeMEKoOJy4sBl2phr3ngsmru2JwZW+0a09nUxNyBKKh+tjw9zTydeUo5mEgGQh
         Jg9YJgZgQqEPaPYua1uw3ccbaWyAkP2OaT4ae9fqhpkynyCS33mvUoI+feytsEHZjrt0
         5ZUZuiZ3gZfeDYbcX8PcMuF/6nA+r2/9/GAveqtGYm4iVN0bvBAtt4dZ/USrGPYVHa8y
         cVZoNk3R8heyljbsl5ECucDSitOBwGdaz4TfCJo/FXDbFPM1nHX5gByKnZsXoQsNwQqz
         Kgvrw6H+fitXr79D4P4dvDpVxwK9Tu5ivLFtH8TEVBA6fAEoYpteCn8V7K5MRsdsD8bG
         USIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024115; x=1723628915;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K9cJD8GnTXeae6tk7XyXA7ny5+/e/K4LEGmEAGg9paE=;
        b=WPGTmqA2MoMQMBdiNJMdBrQeQLhkxvwDL2/ROJUMXBiZpE+0KI1FjIXajZBJPfpQJ9
         6KuXAYle7ipJaKe04UExGjaDlmefPJnV3BvtaJi18IvJFK0lqM44cPy3e1EX9RW+kve1
         +4qkxqRU6kjArtgmj+kfYUQ5kquuuqn6amwThnN+q1yEWXgu0P7QgCOsYnnGCYKf7Ge4
         dVSe1gG9FrEC3w7Z2vxgX9h0SCbVevg14KfrNV27XXY3N5ZdyWzF5YiIzrQJ9xhHaNc2
         qhWNQrS8kSvs0kjYfmxhzC83mwVpC1/CQh3uYWw07mYMQrOR9CD7cAsgPu1BZCNI6R7w
         IGMw==
X-Forwarded-Encrypted: i=1; AJvYcCUId2WSC3FzOXDCcrccJnQBfgIGqGwN0J9gtbDcHy1o6f525Nc6RRQjCHdRobKc6ziZf0dmnRmSL0YOR1cCz5lkYc7z
X-Gm-Message-State: AOJu0YzvZAQo3LFEUn/JjA/QDcZ+u8dSSCDD+YPJcuzkokQs7+fVyAAw
	aju++OY267Mmc5QkbqHlIOXbMkTFetNxGVyRGXtXBPjzoK/37UxiAdFfnr/g2+s=
X-Google-Smtp-Source: AGHT+IEfjsp032O6BWGx1CKVOGEk1S1O3b8Wd+GKZtsrmXPjJtjdNAu1Xkb4lSPabkD5GvrZIitjZQ==
X-Received: by 2002:a05:6a20:1592:b0:1c6:a825:8ba4 with SMTP id adf61e73a8af0-1c6a8258d8emr15622551637.41.1723024114668;
        Wed, 07 Aug 2024 02:48:34 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b372fc9bsm1101358a91.42.2024.08.07.02.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 02:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 15:18:30 +0530
Message-Id: <D39L2L3K6I94.3JFA6EEDPYNQC@gmail.com>
Subject: Re: [PATCH 00/20] Stop using `the_repository` in "config.c"
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
References: <cover.1723013714.git.ps@pks.im>
In-Reply-To: <cover.1723013714.git.ps@pks.im>

Patrick Steinhardt <ps@pks.im> wrote:
> Hi,
>
> I found that there had been a bunch of callsites in code
> not marked with `USE_THE_REPOSITORY_VARIABLE` that still implicitly
> relied on `the_repository` due to calling interfaces of "config.c".
> This patch series has the goal of fixing that and making the dependency
> implicit.

did you mean 'making the dependency explicit'?

Thanks.
