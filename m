Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07A3C6611
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200190; cv=pass; b=oIV8Od7qxxbq/xk2zoPMe5U6RM4NXntRfz3yQLBWpdaZeFbCBmhlx2f8xpguIULOFP9pXMi8AWGt1RryGSe9f6q0m3kPJ8bHyXoLam2aZfInLVBXF4SX6gnmYAYp+XW3p21ftdl6sOmwGWH1TVblBbGB5YJ9K8BnVgw5VB9kxhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200190; c=relaxed/simple;
	bh=Rvp0qmrUH1LyDOZAaedciTFps1lpOGTRAPh+fnDIYOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRc0Emc5lENjpA52BY9U/cwtiY7jNnZvryOq+8G1VGDP8VKMgY3/fvyhnk/xLRlq1fcrULVYFnIWgh7vgRWePzvmPIZ4bzlJLu0ehu6lcDFiQqgU+oNGDhnSyL6IQXXXcEnJZdqmRyO91fKkGezAKAQ00cT29s/ciYjADpeaO0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaBSSqR2; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaBSSqR2"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so8916336a12.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 00:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782200185; cv=none;
        d=google.com; s=arc-20240605;
        b=S+4U7BdlZbeRVuVMxmZ31hYAor6zqGZRogs908WyOrn9ZwE8R9Cfc7gZZhQ7PBVbzH
         eJMLKav65MtHSrG5oRbyjpirYyUdlyAbqrZtpVBaQ44oo6DS07aOp0S43Q5gQ0PfAIoK
         n7TOIC6OMQrMi3bb6TRNzRrDfADcyGqd/ODtUilGPLqi8+ibequpowEmbL7yRXYpf/SO
         AffDc0GU/tenbav+hf6AYi9QIwDQI2MIo6kB/Sem7eHDIH/MOmpWAgfKHxqR1N4BJTT3
         Zyy4F1tc3AV2dx2gYbxjbOb5F/qo/fjlwo1L/p7BNU0fT5PBmaTRMlCjXZ+km/ZG8EQP
         DFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Rvp0qmrUH1LyDOZAaedciTFps1lpOGTRAPh+fnDIYOg=;
        fh=NN5iVhI0OsyyhwwHlnV8fsJe//5+cLw6S23KajZs1no=;
        b=A1GA9FTwzv/2nK5dCrj7cggGUV2d3b/APA2wKucxer1zZkFzdzWdqz8f+tojUiPvq/
         WbrtNSH42KgXcPC4eDMUl3XGbsMBjMvEuA3BOg6vj6ksLP4CVYqoRRScCyGz0rRy7P9b
         coXpFDRVj0BowNadbtf5aXFIQKyA3DukG3uQay9jaRBFrVg51QgRcqO56zze5va4IJdP
         UxEsAKZJuh0z1fJsSqRDt4tq2ciPKEQ8EhuckLFRyzi2XfQG2Y6IuzTFWVl5mzhePxja
         tRWk6ujuz+QsJ46mndtQzcQ7j0gqeTStGLsCTxJQInegCzodx7eXEulA+Ub47XQ1UxKb
         Q7gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782200185; x=1782804985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvp0qmrUH1LyDOZAaedciTFps1lpOGTRAPh+fnDIYOg=;
        b=NaBSSqR2NTlOmMHZOZESdoGMA6anpM4WQm4pImrFSgFnt07nBBjCLd9AkR15rykTGc
         bZGHRzKxzenutBCKEvtTtoaV9F4OXZOypn9qhnyDgzQzCvPrAZCNyorWc87f9FJ70v+D
         gPcnJ2DIDp+AuOSBKS4eDP0Hn3t7tcyVRz6X2ZyEEr9xCxFyraoq7pbYRJIjAhlbFq1Z
         2T6dvCK9HgoTMSeKo64t0HhIekjzrrA1/NJRvCT5VP+84cPvlHTKA/ko54PU0uh+CnZv
         ByTZ2B6KmnZlL2+PnGfTLkDByVwkT5H2ruoGgPQZ2My4C1CTgG+ymsNuyW95yNSs8Qzi
         TlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782200185; x=1782804985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvp0qmrUH1LyDOZAaedciTFps1lpOGTRAPh+fnDIYOg=;
        b=MCKD+e+KHeQxEgYbzjPiUcKDjAZDKoXFoxjf259VdXfRnp1gKB92uPvL6MqY9UYC/d
         QH792Ji8ke2rh9ccwQoOr2PKiEBb4DU1v6WuPeAnG8MrP0hHDQsQS8ooQd/aQ64AD5JZ
         EtHp28UIesFUVdzECxgfJuB4DWTyDDozoncbnn3nn0BCn04Oix0Tcszr2wtNnZzmWdqv
         ZlFt4pAIZ6gxYe/DRp3kPIaJgu8HBN+U99rPVZTYJBc9q5PFa1YUfjrPtmWVP6mT5oei
         RS0d+MCI8+TskiAbfv/04S9oS56nPK7i3fsP7/02grcT7GGZHMNhRp6dvNG46tlDViP4
         8h1A==
X-Forwarded-Encrypted: i=1; AFNElJ/gTNl5CaQ1DYWhCfM/pWi1qBbfeClusvacHfpThLR2UuHs+pdizUpie6KLomz3QzmHYq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6qFTJ1dsuWKF6hLesU9KxmL5fK1MNlE7FHToRoWtpd4bq5d7J
	CyfpHbbm9nduq3SXJjP9ncQW2DQh2fIPwZdP9xghLJuuKQIi/UliIhNgyBdoHPFR9UrytNo+QaA
	Xh/1FKXAoEdS5UuvjKffpq7GQhHPhPWE=
X-Gm-Gg: AfdE7cmXv0V6U+IyYe/b1+qHRgH2NWtfiFcSgMBV8m5QYINP4X78ZfeZVVA0F5jDz5g
	GLOFiNLjS8S7Tm+PgfCQWdYLcuR/AMk4CJdfRQ/qhCoVgFFlPmsqgadnwrVj2pUmPDHIKQsEKXg
	948alUcf67vw3sj8dMedxzAUy8gSj9gI52IA1FECFx33zmj2kudDSHZTjh5TvjPqe8RkwpqBfQc
	PeeL/VH19IQVTPxFjOXGKpv3qiQQbETHtPYn8jV5501XSnX8DHZ91zmH6HFwWdY9YEw8Iei
X-Received: by 2002:a05:6402:190a:b0:68f:c63f:1ed4 with SMTP id
 4fb4d7f45d1cf-697dbb64733mr609785a12.27.1782200185049; Tue, 23 Jun 2026
 00:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com> <xmqqpl1is2bm.fsf@gitster.g>
In-Reply-To: <xmqqpl1is2bm.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 23 Jun 2026 09:35:48 +0200
X-Gm-Features: AVVi8Ce13MdvXllhFh3peS1yDCsNkGbxRKx3SjycDzT9VuLGZyjNDf7Y-C_kL2U
Message-ID: <CAHwyqnXdp=hRZimp-UXSxmCW5WJ7QrL5Dmk2yBF3RaH3KTLPwg@mail.gmail.com>
Subject: Re: [PATCH 0/2] branch/push: suggest intended form when remote/branch
 slip given
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

By slip it meant mistake, so you can call it 'hn/branch-push-mistake-advise'


Harald
