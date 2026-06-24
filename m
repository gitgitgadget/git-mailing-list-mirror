Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647F3B4E9B
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311648; cv=pass; b=Kmd9ONhknugVyBAZ9VC0//EcEwwbZOISVz27r1URLYJk7BH5QgBCRhhziLrnkHm1E7G8Y0zC1nykn0k+NUOg2/4U90wfQlyJSGm1TRrd6EnMBa1Bu71EuB3GCzjFOUW/TJhBvml2ZfGiqPJrrhsPRaY9A5jdIoq4rYbT/5GRvCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311648; c=relaxed/simple;
	bh=6CPW74RuOKXpLLWqUsPBcLIgD+jz5mWu8ZJxOjsxLI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeZqFw7lZlI2drs91lQZSoNs+AF2UwPzg72pGJ9uYONdkLYfVc0zsUZwRHdYpdB2UlGWJQZX8npZVznZ7sq/ACA4Q475Z8Xyib41dKeB/VZyKN3EFes8m8lnhu5DppbuVHpRBU60M9sRn6F9AwxGqI6vJ1ZdprWpOASxK0Zj2sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Xugs1rh1; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Xugs1rh1"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-662fa4a4470so1222314d50.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 07:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782311646; cv=none;
        d=google.com; s=arc-20240605;
        b=LTOwTObWDdmqm0h9mHJME4Zs8ebFvH87429dfVVs0r4Rx2ltpzPsryCYg8mqdM6PXn
         XuQO5DTGMvMp6c3jniCRcweenfBKlb9S1Qd2iRoH6tAOyajKlvNkE/dvn6d9S7SfZ7mF
         gYZF9Rb5C3T6qXRNuTGRcCGc2OGCFxNZ/7D1lHh0a4Ker2wt7M36xSlkw1bahylcdZIM
         ZwECONQEdBFvpi+ORL+rpUYoGVH0grguLQaWBrdirW9nPnD+3X54vS7LOvf6XL/Aw2n5
         LrHt4ompovNXNug5i12t+jpKpHn9OjIWofUXmfzrANsdvfWmn5kAQyxzPnh/N6rWa++q
         HrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l6Jis1Ma8flIAObw2PJcmDWe9v8PCZr81sBMmpw5Ylk=;
        fh=DHTF6kJfFpGcY/Cz1VkPuq2wMGFH7MPLh/7Rlqjk9bw=;
        b=Y+HaHzm1kJo1jSu7N14GSdGUSO6ft6Sk2yYskl6BI6S3r9YFXYH9G0JRkB1GsON9Es
         M66JxJqTo0BDQoVo/5sS8+sQunq+BxQKTrxmPKI22axE80fM6niMu0pskmExIqISZC0d
         0Kmqt6eRmAxV6VUDFuXM+n8IWDHqsNAAiVLo62TmSfEuQ0ckbBusohjTsoFMvpqwrNEx
         RmVeyJ4v8zG4kU2Yt4YKMxG3EpvESX0CMEFqYs+DcP8BcOPDaKCa6r0V2yp4LHTTo1zJ
         3NveFcXFJvJUkhf6GmxQbzR/M8z12djztfOSHWNZj6zxR4MqKKxX/iF95nASvyAjYrjS
         K+Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782311646; x=1782916446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l6Jis1Ma8flIAObw2PJcmDWe9v8PCZr81sBMmpw5Ylk=;
        b=Xugs1rh1G1CuR7xZ8nniNwt1cmGnhqzAYwH8+2J27yjfhufYVYYhW0nXRihLIg9pq6
         XF6EdpT8iexi7pyF4Edm325aZ3dOsxvewyoZbGtwF/A/UpG/Hx7EP0QpakBUzY8fbexG
         Y4Yo3ggdHCBxkw00hDCYl7vQU98hH0QLwWumM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311646; x=1782916446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6Jis1Ma8flIAObw2PJcmDWe9v8PCZr81sBMmpw5Ylk=;
        b=LqGRA39Oscb28Iy27tWcc78tvaxaN/mwSzjnGLV2CthZ2xeXKu7OkVJdUA06ae2OYR
         Xtg5AUR/Mmh11iuZxFDqZ1fNTUeMgQRYa/XYK5bjNXZWRa0MHg0E+5zZ9gY4cmrFoaEa
         +GOa4t2lkFWvo/DoWpAbQsN7UiFbvn1vEXpybvpT6gTY5w5nITk+ah2g61JwZD+vym2U
         F1gh6QG8QGun5K4u+qjVxPeRsEz4aFOlJf1Co4uh2AnBhZ+lnbVYvjogIzxBMw1ciQv4
         aRVWRe7EiBnBKBpNpalZk5NNS/5qF/IdfIJemJswirPOPyzS6Vt+XILZm336YxcI+6JH
         k2OQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZ4N9zV+bmNB7OQYZ7EMMsvzTKIbZkbsBEpWUwV7UHB6HPMdJo2h+YYO1XmSLysxddALE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCozVPlUjvs9GvPIjhvpX34BmRQGuwg1Wi5uH9//9u5pgP9sI2
	NUEWpkizgxLZ+anW3u7fPsnbqLQ7P4sYHQKLEjzR2oBEG735a3EQHjB+fGd/PUm88BdtDVXZf9X
	3QQTF7HLNkcW+dsbfzGlfaUrfxc9r7luZUR0G/NVM3Q==
X-Gm-Gg: AfdE7ckgO21or0gxJER5l6Ks2VCkhdrWzCTDXJvXLFEoL3o2XXMgkyYGIYG21XukSQn
	Db6CpJp+/pFuEI/paTzQrlP6g/Z0tQbkqRoCqzsAhZG8bSMGfq9qqP4gDGyo6gDIKgUiapiU205
	/k2CWNggwt57/fK3MTr0t4qrx2Juqu3/ElPiA/zfqV8axgygloVTf4bVsV2Alv+6XtySpi5pSf8
	osrf1pKRFwgcobNrd6MgJ8Rw3yW1MOslqBQmBLpDlFDsYP6jMvPY25DlpHeEr1Q+tzMdCqDjw==
X-Received: by 2002:a05:690e:bc3:b0:664:774b:b068 with SMTP id
 956f58d0204a3-664774bbb44mr1089400d50.30.1782311645845; Wed, 24 Jun 2026
 07:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com> <6151b8e0a3989a51e6d9717e0ceac439f26f1c1d.1782303254.git.gitgitgadget@gmail.com>
 <b4b33635-1279-46c0-819a-d29cc13921f5@gmail.com>
In-Reply-To: <b4b33635-1279-46c0-819a-d29cc13921f5@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 24 Jun 2026 16:33:51 +0200
X-Gm-Features: AVVi8CfW9dLUyPmKMY265RxZvjJFHKUmhI28nGpz_I-qa4X6k_VfS0k0rotenkI
Message-ID: <CAL71e4MCXUnRddRVGT2jcN2YT7bbfkOmFEdriQXNPk+9W_oLtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] t6600: add test cases for side-exhaustion edge cases
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jun 2026 at 15:43, Derrick Stolee <stolee@gmail.com> wrote:
>
> One way to make these tests have potential to check exact stats
> without too much extra work would be to update 'test_all_modes'
> to run each command with GIT_TRACE2_EVENT set to a known trace
> file (reset each time) that can then be checked after verifying
> that the results of each command is the same.
>
> Then, these tests could have lines such as
>
>         test_trace2_data paint_down_to_common steps 20 <trace-full.txt &&
>         test_trace2_data paint_down_to_common steps 30 <trace-half.txt &&
>         test_trace2_data paint_down_to_common steps 40 <trace-none.txt
>
> after the test_all_modes line.

That does indeed look quite clean, I will try to massage the tests to
utilize that, though I haven't fully worked it through in my head yet so
I am not sure if/where I would get stuck. :)

Thanks,
Kristofer
