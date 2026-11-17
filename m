Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937742;
	b=crrG4LM32iniM8OhbK+9Tiz0PrHA2OcFcn0XYgUwmglJFpHi3rPQHDN/HjA6lrexz+F/
	 PICJ2j2RUYtW9bHA2A3l9o+RRRimalte4dxFbJgA4k4N2cq6+YmS7b+cXRD+aBUCh+1Cv
	 Et5ObhHp2+NNyRpLst4pvxJAPzOp8T+2Nj3taFKiDCIxk+SaOkgmeuevsDtyprRgOt228
	 daO8JRpEyctqnEZC0YumBvdkrjLrBuqsXgTuGzfeCnnQKiDaBbtPYJd2dN9Pkqoqc7b6A
	 HY7/fvkAcwSnKGCMCvSqdHXeeQiA6IpuVTvz1QPkcNJvtRgu4OrdJ1MMP4hd8/db4Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=2xLFlHPpTY8fJ5RgLARo6UqOdvIIKHasJ1dRmTGid4A=;
	b=EG1V6qJ5w28PTLzviD/r47zyoF9kIqVNtx5dTUtI1/Vk/hUjaFbQ9fiEy/PHinBHUog/
	 hgURiJThADdAgO6mGTQEnT9DL+M9zqVSWihoFiBhnLkSc/uuFQH2nfBOkR4eRIniVqxxx
	 q/OvLfgph86bXKeQgNbljoQSI7Iieuase5z0+T6UCQHwMQrPnf5lT9/KyCaOy1sQ/UQqa
	 XfB5xo7GG7VhBPs2DyHS7of0GNmMC6PJcfWnYRNbImE+V3XD7nWoD4D2MybzeOncM498T
	 gQqSfQNbKCbmZdQ2VYMV4vT/Sn8OLsP8c+/3+BQ0gvy2W4HJ+FKEWnWS249whetyi1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ft5zFnFs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CC606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B5CC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ft5zFnFs
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b4e04eda5aso21398347b3.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 09:49:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937741; cv=none;
        d=google.com; s=arc-20260327;
        b=kidQlHN115j8va+evFEIGlngCJOZdgUi1/zvrSq54x/lCuQbG9t0B/Tlq/MCPO5yP/
         9HxLGV/f7bL/3CRgwe7zhhmPSNNBbI4IgMgMY412HbtybM//X8vt/ZCsO2GL1XKxX3Mo
         Vf/Qz8BFBlPK8uM1bm0gZMWNtH4yKWDV8IdJzxgFcczODGkGpc3scvZV+A9nHlAtgA8W
         0zg7RnQifi8xx35u0ezpe6qYieSlAGicbZ4qTmz3hFffNuektDF6QKvF0EV2hYg+3lAu
         +L64b+UrnZBTA2c8WNErY2WjUycvsrHcxWskr+A48uV6zVD3d2WTluWdCCeJjVm040tl
         uZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2xLFlHPpTY8fJ5RgLARo6UqOdvIIKHasJ1dRmTGid4A=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=pLeDS7OPpI8LC4jQC0lNVrux6S8Z93cOCZqPqcux4d7/PcRxjZgbw8W9VN5pzuThfv
         PJu8sdAlgGbq5NAn4MGyOXad3zaMysRDnFXr6zIPH2681Jqys/4mKH3f25jEMaYBc50g
         xU6+uh0rPwPtJMiCnwL94rMIusoTzXqlTlmYsrI0ei1RIV0sTAtQDgRc/j18sFQT2kLM
         nRGFFw/nWEnLrXHiZOD7INUMtnQ6tutPTWGjsxExWdmKu1/K/l1kabW9tS1y9ww7LRBZ
         hbWhp9pL4XpTE1kceC+GP9Y1aWG2vwH4zAcyvN7wPqxgzyuefiDGYc80j1TPHJmNCfv2
         /cvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937741; x=1795542541; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2xLFlHPpTY8fJ5RgLARo6UqOdvIIKHasJ1dRmTGid4A=;
        b=ft5zFnFsv3oB0k+0HTSXHeAFhOJSKEZSVDXG1om8J/lsU9w8Q6Ku3WuBJI5+lY9wpR
         YnYxEQrJ/Wv9nT8x0PI0n8vU98aORPbvXDDU7724XqbnNglVXCltfXG5M6d9rWdE64ii
         t7WSqhQis7afa3wHp7vsJ13pT/02i9KaKX+EUm5SMuJvzY/03A84xObI4terTrDinbeX
         NQSxIUu3b89g6Q+dKzNaeMJ6k9DlgMiPmr/w7S5bvGWLXkdzs11VnQGLh8Rk2AT5y65j
         AFMQi4fGKJ/xelD8Ac+98Y5AYpdiijRbgdUyQMM1T8KnsFIAKWYSeObXKKQVYHVMDbwz
         +xZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937741; x=1795542541;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xLFlHPpTY8fJ5RgLARo6UqOdvIIKHasJ1dRmTGid4A=;
        b=xbl7v4frO6pX3ygzNyZdnTe+Sl8Ps5PeDbO5J9xA64pdx4wfOGgyrSir5YrBjP3vJn
         YdUrJzTw92Kf4MSIriCdyJdKX900ETxU5e1+PIfMQQY5BUBDBoWWd/uW8RrBsoKVA8uK
         KOsTmyoxbZUoS4vpZpqeczsagjAKWscbS2mxs2lZ6er/kwIVXAftSPnHLvwxxG9M35w+
         xG7cqVjBcFBWEXmgg5ut+iES5wmV5ul4cjFRN+AQmdGh/DVldh+b8YXK0cELkeewuaQQ
         Qde/BNqvzZImiW+rT0RX5EAoA59xzoJtCLxtylagbATS//JoVGBoFQcCecjcGkDZqa2B
         myEA==
X-Gm-Message-State: APuU4Z9umiGW6afrEA6cJYbLtZO75kxMglDBib4RN7+MUOAly6RcLUPm
	nzUAt9pWZ1Sp/AtnqdS+UU1PSHzC45lJCcgjO4Ae3aQ7M1Z6j+1xbfPHq/bbl++SnQfICwV8dUi
	pkL83w4emzE37pAD/55i+NGVDQOZ0Ov/qABeH
X-Gm-Gg: AZFdTZeHjHRj+j9rWSUAHO/5WQk+6oXCR8NHlDpan+0GuIwTMBGm3AYJwcZ4Jgz3yY9
	5bnqpbX679XV4u71of3t/7MegpDTgi6yXSkeHmvnu0gM4xrOkAopgghSEreJzumoEqoLhCVr5NX
	od4LTgW6nZdDPtFEfIJbeDk1yjUf5DdEFj97fD5XEn/W0ipH3MORmRbx7BzP73poFmIOGUC+/LH
	3i5QxB7xHEymcXdn1Ku2A7LOWOafWg7tA4nDx1xQcTNYUON3L5xdWA/SBuqPJqNKLt2UOpfRGCG
	AHTzqQZ2gBZ1ijEhKvW1xadIR2iXzb/leuuNei+AZX7LsAH6/7IweiRO1IVfqPAoJhVhEXK2ahT
	OAFHYj4JjpYJiow6yfatQPTNQjSHc548Viof9o8DUu9drB7CzieOj4wPq
X-Received: by 2002:a05:690c:2a8e:b0:8b4:d11a:59cd with SMTP id
 00721157ae682-8b4fed0a68emr72427b3.13.1794937741087; Tue, 17 Nov 2026
 09:49:01 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Steve <steves.sk@gmail.com>
Date: Tue, 17 Nov 2026 18:48:25 +0100
X-Gm-Features: Aa3M54oURGDYt2v8rs359IwDquLHW6ep4mpBYME1_nB-OgJbotp94VjnbX_nEaM
Message-ID: <CAAQS9U+Ht3x=V3e1XJT9V120Tj5jCuCMTrxTnZyzTpsg-G9uBQ@mail.gmail.com>
Subject: User-initiated recovery for stale index.lock
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Could Git add a user-invoked command to recover from a stale
`index.lock` when no Git process runs anymore? It could wait briefly,
then remove the lock and continue, but only if no other Git operation
contests it.

Thanks
