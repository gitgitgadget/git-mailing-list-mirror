Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A51E492
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854741; cv=none; b=ERYXEefe0VRU1/XwPq0mxeOAHETY3PTPT5Defr24NHkZ0o/4vd9sHfZgLTze105fOBC7A4KiAfHM4NFuBaNdCsZxLJHFXerUXNRpOsmMQ9eR4LrunPuRLnzUfHvkMMXnaRqHfgsQfX4TiOBjxXZcEe7M6DU8PX+NLbZbJjZ6QZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854741; c=relaxed/simple;
	bh=SL7L/CanbOu357R4hVdBSpFwuClHIKSU9JPljOX1RBY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=X5jSt8YrbGOiQHNMRFGioQ/IYUltaondw2eGti/2ZwTbHMKgi+kZ5i6yv601uSr3fpA61jkX09PVQ51xG1RsmGSe3riVCcZN2xVl92RqvWVD5nDEDYrvyG8Ej69JoTYCjg1vh+4qkqrYjgdYBlY+/0fmqKBDl/pLibqW/Evxnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrPPFTGl; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrPPFTGl"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ea7815d3e5so467501fac.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750854739; x=1751459539; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KkusYRq7J4x7y6CP7xVFltyfbBga5pbC0s66bk//Vfw=;
        b=nrPPFTGlX0cq/UcHHgdp4enIctnhOciOoE+VxFcu4g1x/aSGGmgoCwomqiORTE62cO
         VHtGEYu4mcfkm2IgATmNdKopgjPNsBo50vOV9ONolcOe5gK0yL8JgneVl10AN1/EjqUH
         c2J7+KYfSObcvE2ibndIxqMrAmuebz0J0BF64YnNdOyMV3ezhbkKboGW+kf9p8qT1aSs
         W2zE8kpU09uRjhpjgSsoMpr0x8CsfUXXgxTD3N9rts3KPNo5nOQ0qy+buAEbzaRNKluQ
         EvS22KpRKIIshE09ekewn8/v2SLXHjIazf3PIrfZcsJGTbYDqNvi0gOc1cbXltSLEfg5
         +cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854739; x=1751459539;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KkusYRq7J4x7y6CP7xVFltyfbBga5pbC0s66bk//Vfw=;
        b=fCDs7w324Rkv+UHRv46jKoWwFu4f2JOsbVOKH/GPbdPoEnXheJArb0Ue4d9tQ+J6Ho
         UiT8b78HvUXL2s2e4vhnxMXzGRFkmheMYcyYN70DUxDn723H6tp44ufmfLLf7hadIpoa
         nVQGgY98HLnNePe8aumKuMxxWFQ4p+7OqRbTPIBxpprAg2UYkOAquAD0f6VSs6v7JFGH
         c3NNFZcXFJhzvkXmkvGVi1+RCg0bzcKY7f05qIXGI5WcbFzhamYXllpmmP2bxKocz6DK
         Jzkd6+99OcGGYZLTOpZpH+nY2+ZYFoZZENS0skaTonfiQvTeobZkYDBL4zEMAXeeqP4M
         1EwA==
X-Gm-Message-State: AOJu0YzSkDYnA1OUaWfTGi5yAUHeaqivQTv4g7RvIXrQNz+C7EzICEg0
	8mIUSNhhJh/HK2e5YMMgJ3/RBIP1Q48YudeIH4NrlZaddCNCb/hwLsR5q503SW558Qv+rjSGm7G
	tIB+8ZUz/7FYMO+zjgMz3av7imSA6cEjsozWa
X-Gm-Gg: ASbGncsxcacACE0cb3WgxDcDjbFueHHo1dU3y/FMjPQg2gcitDEekqo1V3BBXa9Ho4g
	nCanbmqAKswmIR8wOEh58/t5dCXFmhC6RoHQuBM1qPPN5ZK1cEqHyMAFEsgIOLbW5cuvqOGEcWe
	hRa5IWd0CG9mM+osP2K1ihMRjn1y3sUmzjtNo6nrqjOGo=
X-Google-Smtp-Source: AGHT+IEonphV7+mD+WENfqA4gQKltDg5CKqrl4AyKAj+lCXUmwBR10r6T0IrIyx5QkzYjGLeGH/guOH3RxAs7aR5o20=
X-Received: by 2002:a05:6871:a6a3:b0:29e:5f79:21b4 with SMTP id
 586e51a60fabf-2efb23f394emr703610fac.13.1750854739376; Wed, 25 Jun 2025
 05:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ryenus <ryenus@gmail.com>
Date: Wed, 25 Jun 2025 20:32:07 +0800
X-Gm-Features: Ac12FXwhJbMc5LIEXZ4y5QVPcbfJeG9Cxr1aiwV850xx6gJkFzQ74LcK6qeDmzc
Message-ID: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
Subject: [bug] pull --prune could not delete references due to lock file
 already exists error
To: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

today I tried to prune the remote refs in a local repo, but `git pull --prune`
failed with an error saying it could not delete references. I retried several
times and it failed consistently, without a single ref pruned.

I found this interesting comment while looking into the code here:
https://github.com/git/git/blob/bd99d6e8db5e2c56dd24395e9711ee7ee564bf4f/refs.c#L2863-L2895

> /*
>  * Since we don't check the references' old_oids, the
>  * individual updates can't fail, so we can pack all of the
>  * updates into a single transaction.
>  */

The problem is the assume is wrong, coz things could fail, one such case
is to have two refs like below:

1. origin/TOM/b1
2. origin/TOM/b2
3. origin/tom/b2

Notice there's `TOM` vs `tom` in the path. Another factor is that my local file
system is case insensitive. As a result the 3rd ref would fail and cause the
transaction to be always rolled back.
