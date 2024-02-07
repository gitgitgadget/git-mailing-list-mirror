Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA16823C1
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326789; cv=none; b=EBvq8oDZb54AVSB1AEfjtSSDlSiiEt2FOhzios7tvQgwZYN1G654J+gxSrp6dIBnksKE2hEKCxwDpVT72020L4bKQzqc9OvxmMTerTtXYfVDpWUn7J3zGYZY+nuSruZYmAzE5N/NjkeOSh8QnnYZE6VIIEuzzFhe+lI0Ms99iXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326789; c=relaxed/simple;
	bh=TIyKLyfgrhkzOqwwdXKdOnb5oX8crIX5hr2iUCBJk1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpRPxLGDcv///q2Llnm/Sb3nsnrcFJx3kEHBXe38inyjoKFTuW85XezIqNJ+abfKNihyABpS26T/XIYVh7/q4CuVdMmYEEXPU9BGo7T7WUwSNajUMpSpu+n9k8ofpzbC2DngS2glYHI5wPSXKs8EsbffVgbBDCD9/1ysf4e5BKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68c8790aeadso5889826d6.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 09:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326786; x=1707931586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIyKLyfgrhkzOqwwdXKdOnb5oX8crIX5hr2iUCBJk1c=;
        b=ZgWgzB3o1Wzgcf8ojcbKnR0yNpXV6Xqjk67wzpx8YfjL3NdesqqgnDu04laP4PUBFP
         uaSS/WamvVKEpnuzEKdC3nQRr8CwrLzOFT9Rr820jfjixXJ4YZsJNKmaq2eOZhFEwx1t
         2TB3SiCRVzIsDDhiWQ154P7sHFMvP7lwb2lUumpCZCmO3tv1+QEZVbbQ7dgMQXWe/ncV
         sTPQstac03SSqpLrv5Q28y0DD3RbL1zicLHW4KKMFN6CVGoZGus+HXhD0Rwelc64XZgQ
         yVMBynI60A8vji2rNmx4t/Ble0CbVzZJ+ZAz/4YEdf4pdiiHvr4JAM0uNMjpUJWVK0FX
         hmEQ==
X-Gm-Message-State: AOJu0Yw/NkJ8yAubMwFI1EDtuiL5hmjuCw8Wi/X6h3iksRdNh0WvWT6+
	ffaIX3gjuyMHZaWEwbnflyr+jlgkQsBhC91nf3sFsJ8/RN/csBkbXWrC7+tB1/Q/x23M0LVnh3u
	vR+f7B0Y40KxsrbGJfM7zDmAWyVc=
X-Google-Smtp-Source: AGHT+IGIjuX1+pCFKhbnSaZVyD9Woog+9FRHxA69m2TmZRFiGADJKEAwO80AaYF8g2nho1STl7/kJaqPHZWQPpQbFhY=
X-Received: by 2002:a05:6214:d6f:b0:68c:a6ab:19ba with SMTP id
 15-20020a0562140d6f00b0068ca6ab19bamr7952326qvs.16.1707326786102; Wed, 07 Feb
 2024 09:26:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
 <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com> <ffd38ad602a53dfe72cdbfe0d098ca43e7443895.1707324462.git.gitgitgadget@gmail.com>
In-Reply-To: <ffd38ad602a53dfe72cdbfe0d098ca43e7443895.1707324462.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 7 Feb 2024 12:26:15 -0500
Message-ID: <CAPig+cRK_2BWYkcgaZ1pMJJtztepeEJCwuevJNj6gJwRoJgF5g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] Always check `parse_tree*()`'s return value
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:48=E2=80=AFAM Johannes Schindelin via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
> Always check `parse_tree*()`'s return value

If you happen to reroll for some reason, perhaps: s/Always/always/

> Otherwise we may easily run into serious crashes: For example, if we run
> `init_tree_desc()` directly after a failed `parse_tree()`, we are
> accessing uninitialized data or trying to dereference `NULL`.
>
> Note that the `parse_tree()` function already takes care of showing an
> error message. The `parse_tree_indirectly()` and
> `repo_get_commit_tree()` functions do not, therefore those latter call
> sites need to show a useful error message while the former do not.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
