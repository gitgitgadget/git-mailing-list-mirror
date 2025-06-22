Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF1AA47
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750575688; cv=none; b=tOelMBr6209E1yoSutvI/rx5yZOIG1p81A/TXYtEONBVtzZkOFRFjFM1JBZS0f8JHttOk7ItvguRcBTjG/ArDhfiWLuR/mKoyeUQQRSTanxB19/hykJkmKoOg0QdQM7qrjGYur/3CQHSxNq57RJsPKkVr5AdreMTdYFYRyKFEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750575688; c=relaxed/simple;
	bh=+51wuPKMbYGL1+iSw8ogxOkZ4Tnj8sPQ5/VpZEG9OGs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Og8Ny7FtRYH3IfDfaT5RQnqg4/cYbYFTasJbHL3Fa95Mj+YyTwTa1MqiRh6HFcgIm8AJEOBdkjR2+1gsSnsLnEzP7A4wDrsKMXC302GHGpzQjb1lZQTl9RxKBuJEFZHXvxfTuMbwk9vxyDBHNO8LEH35hTMdafh5YaiYBMhKZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgdI/7Jl; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgdI/7Jl"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52b2290e292so915651e0c.3
        for <git@vger.kernel.org>; Sun, 22 Jun 2025 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750575686; x=1751180486; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+51wuPKMbYGL1+iSw8ogxOkZ4Tnj8sPQ5/VpZEG9OGs=;
        b=ZgdI/7Jl1F4ks63A31WD2g7UoI6rqtASTkhrTwy93bgFRyOdt1+phz/5MYHOJaV7WB
         bYh1h83P0vEmV4yJYbra2syyj0r7nNgZIfacZkYnezW5Q2175Dkv4pBSEUWsZZHHp5tj
         mu3GHcHyJ9z+WtTkgqF1qh+5eKXNHn4eRw7+wsph2rb8XHTWbxxakLQMtcKRLpGcfl1P
         pRmXCNAVjDQZiBOVVvR4foCNb46GzNSXTG4loABkzqDJRF+AyJ5/iOvHZi6arX2bWRJA
         Y2vLCCKOe/RTNi+EJw+VZf1/G/nnAe5lFcBDpVzLgIpQ7FkaWDfbZ1o5rzSbjnWAj+zX
         fRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750575686; x=1751180486;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+51wuPKMbYGL1+iSw8ogxOkZ4Tnj8sPQ5/VpZEG9OGs=;
        b=RXU9h2WExqf41ry+ZSvra9OikpPQJjBHjnmJPWnaAExGO1ocYl3+em6WLJvwqE6UpA
         N//bTO5HwwZzFomeyrJi+TTaJpwjziP4g4x/eU6S1NIg4SgA/m8RYWdqfCz1N1gIMwhN
         YTa5Oe3x7tNiXk58l0uav79vAEOwyuX3dKuR6rmfQ0hc705Nd9eeySyCcTHQ5/Py47Gr
         zaMKeFofTo2+m6pXsKh1XdO8qWRfhlh2eM3KyT7gqzuhejDQrxkUymKrJnJo/W6UBG+V
         +b4b9m0h/fFAeoAW767CheTgDb6N3ifa62sTBa7vGWdH//LXRGYY1cPZ9jvX2vLdnA1E
         7wzQ==
X-Gm-Message-State: AOJu0YykdmcNx28UiMFyWULBty2liXdRk91KFJH4pRpoe/PS156IuQTj
	x9PHeRoQybcfIYuRckNlIvQ8y0SrUfht1tzNmv0z7WbXrrF9L+jGoFWyAN3DyHsagAVY3J33bJG
	TED6XX+nKypIcuCwncNldJcPjBD0RKJd/JHNB
X-Gm-Gg: ASbGncuGvXw4F08jbonJLxUsKkLxyUdH3dY64l9RrkaXRlEjdwUHH9h+jIGuYnSkcy1
	hZgtxpQ6hBGh5cz9SAKG9FT05ZQNnfBci6P9UUMqghg7ayRhLJ8Hf6ygYLUYlEM060wqaQIsxaK
	Ch0tIT5ZuwOsJ+ncsSpN9/NGsLFs7iElVvfFrnYP/q5VNrXfHoluYdx4iJVaP9637swr6B+MUWq
	i8=
X-Google-Smtp-Source: AGHT+IE0YTRwXWXCrToOmOFQMxmSC/Kc5nUEJH46ULnlUWxfnbX4NE0Q5p9lbSuzU60BZzexojTe3EihTkfGlYfWwrU=
X-Received: by 2002:a05:6122:8283:b0:526:7f3:16e0 with SMTP id
 71dfb90a1353d-531ad5941e8mr4208954e0c.1.1750575685732; Sun, 22 Jun 2025
 00:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: kryzet <hassankhalloof20@gmail.com>
Date: Sun, 22 Jun 2025 07:00:49 +0000
X-Gm-Features: Ac12FXxpdaTJrHFEYHzQukqHlnCMAhymoSWLv0p5t299qNXmywjv71Kzh-Msy98
Message-ID: <CAB2ApcOds+SZszEHhMwG5YvxQcRE01jKgP1modo1WhcwWeGeYA@mail.gmail.com>
Subject: repository maintenance: git prints warning messages while cloning https://github.com/git/git.git
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While cloning the source code repository from
https://github.com/git/git.git, the following warnings are printed:

warning: object d6602ec5194c87b0fc87103ca4d67251c76f233a:
missingTaggerEntry: invalid format - expected 'tagger' line
warning: object 2b5bfdf7798569e0b59b16eb9602d5fa572d6038: badFilemode:
contains bad file modes
warning: object cf88c1fea1b31ac3c7a9606681672c64d4140b79: badFilemode:
contains bad file modes
warning: object f403f5914294bd2769c9ebab7607d90abee915ab: badFilemode:
contains bad file modes
warning: object f519f8e9742f9e2f37cecdf3e93338d843471580: badFilemode:
contains bad file modes
warning: object a869cb0789d8ad87f04d28dd9b703f3ff343a4a7: badFilemode:
contains bad file modes
warning: object 82e9dc75087c715ef4a9da6fc89674aa74efee1c: badFilemode:
contains bad file modes
remote: Total 391414 (delta 276), reused 264 (delta 225), pack-reused
391024 (from 2)
Receiving objects: 100% (391414/391414), 267.25 MiB | 1.36 MiB/s, done.
warning: object 0776ebe16d603a16a3540ae78504abe6b0920ac0: badFilemode:
contains bad file modes
warning: object c9a4eba919aaf1bd98209dfaad43776fae171951: badFilemode:
contains bad file modes
warning: object 5d374ca6970d503b3d1a93170d65a02ec5d6d4ff: badFilemode:
contains bad file modes
warning: object 2660be985a85b5a96b9de69050375ac5e436c957: badFilemode:
contains bad file modes
warning: object cc2df043a780ba35f1ad458d4710a4ea42fc9c17: badFilemode:
contains bad file modes
warning: object 0e70cb482c7d76069b93da00d3fac97526b9aeee: badFilemode:
contains bad file modes
warning: object e022421aad3c90ef550eaa69b388df25ceb1686b: badFilemode:
contains bad file modes
warning: object 59c9ea857e563de5e3bb27f0cb6133a6f22c8964: badFilemode:
contains bad file modes
warning: object a851ce1b68aad8616fd4eed75dc02c3de77b4802: badFilemode:
contains bad file modes
warning: object 26f176413928139d69d2249c78f24d7be4b0d9fd: badFilemode:
contains bad file modes
warning: object b474d669fad6d037c18c0d232aef579a65ae101b: badFilemode:
contains bad file modes
warning: object a2438d35e51d7bec87ca5231c0e8f7fb9039ba56: badFilemode:
contains bad file modes
warning: object a4944100a4832f8fce1494e2e8cbea74e349f731: badFilemode:
contains bad file modes
warning: object 3f703cd0cd32a4aa9892bda84c664c36e40f7921: badFilemode:
contains bad file modes
warning: object 8156e162365f85a1712373132bd8bb3ba0209537: badFilemode:
contains bad file modes
warning: object 958b0946a5082fbc6797209fb225f5d7a786b786: badFilemode:
contains bad file modes
warning: object 192f84588c8e47a2d8ca3d0c6e50641b7a2491b8: badFilemode:
contains bad file modes
warning: object 69bfdfa541c368a47a86482dfe66e488b152fe3d: badFilemode:
contains bad file modes
warning: object 905781d15f6cb171e9c4360465905c7c27f835ee: badFilemode:
contains bad file modes
warning: object 0323c14ecfac54b060a52ef54b9ea38377adede0: badFilemode:
contains bad file modes
warning: object 6795adc096e36c7a7f8e6a407297727e61d4d083: badFilemode:
contains bad file modes
warning: object f2745cc464cc08214719d9f6ac71fdda9d6417a9: badFilemode:
contains bad file modes
warning: object 420f7beb8c3b0e8b7a5e6e8dad92e1246e1dcfb3: badFilemode:
contains bad file modes
warning: object 2ce9f0ac1f9d9035ec6ca90ec4f3922a127c6c02: badFilemode:
contains bad file modes
warning: object 10b554bd1513e33b7054c02eba9cda69bc29e187: badFilemode:
contains bad file modes
warning: object 75a725933087584bb4de417b38588f2b3dcc2943: badFilemode:
contains bad file modes
warning: object 5f3fcd81f68f4031cbcfcadd5c368104ca0969a0: badFilemode:
contains bad file modes
warning: object 9796e3ff820daee2ce8b2439f237dff900769db5: badFilemode:
contains bad file modes
warning: object b9be893a0014c33d0b825cd9588566825c129a4b: badFilemode:
contains bad file modes
warning: object 07c2d8f92d55b9ab885c10bfa862e652dcc40ee5: badFilemode:
contains bad file modes
warning: object 1e474a8671630eca49f3a94145045903a22ffed1: badFilemode:
contains bad file modes
warning: object c48c95c3b53b9a16518955e1271ee3dfeb093f80: badFilemode:
contains bad file modes
warning: object 5319e4d609cdd282069cc4dce33c1db559539b03: badFilemode:
contains bad file modes
warning: object 9999cff451d3a833ca39981d6868fdb452449f13: badFilemode:
contains bad file modes
warning: object 5b009b1f6683c4e167d4d13816a7303a4d74fe1a: badFilemode:
contains bad file modes
warning: object d4a96ba891017d0d26c15e509b4e6515e40d75ee: badFilemode:
contains bad file modes
warning: object 53cbeeb5b30e9a9e0759fad94a9e2d24aaeff53d: badFilemode:
contains bad file modes
warning: object 7ab8bf31e1f8df4e485bbf198c2579fc6b2b5cb9: badFilemode:
contains bad file modes
warning: object 989bf717d47f36c9ba4c17a5e3ce1495c34ebf43: badFilemode:
contains bad file modes
warning: object 0965df45db7cf28dba93b554bdf26b61e8b950f7: badFilemode:
contains bad file modes
warning: object 41fa9643de0044c75ac654ab2dd2319f1bf3b640: badFilemode:
contains bad file modes
warning: object 314297184c51fc558a83b8701a83f28a0e740d7a: badFilemode:
contains bad file modes
warning: object 298e5d544d67bcc11e95aa6b04f1069a9cd959e6: badFilemode:
contains bad file modes
warning: object fd8bcb6bf8499aca79300df577d2c9b8cc898f1b: badFilemode:
contains bad file modes
warning: object ccba05512dc3b5f46c5fd5caadb40ce79ffb944b: badFilemode:
contains bad file modes
warning: object b65f86cddbb4086dc6b9b0a14ec8a935c45c6c3d: badFilemode:
contains bad file modes
warning: object 8294109a769dc1f2ae9c4c622c2cf3f82531d80a: badFilemode:
contains bad file modes
warning: object 09c369f30a7ec350dc98496c5cb752280f6dfe51: badFilemode:
contains bad file modes
warning: object 67d4a7bf52c33e679b6e398d1113a33b072d942c: badFilemode:
contains bad file modes
warning: object 4cec02b6467ecc33662b8b691c604d1a80ac4a1b: badFilemode:
contains bad file modes
warning: object 31f24db6e3e3f70191d95bbe7a06a2b1bb711d99: badFilemode:
contains bad file modes
warning: object 0ff673eb3c120d8d2f2c327e7a772f2e4f902809: badFilemode:
contains bad file modes
warning: object 747fe6bdc82aff5407221eff645656932c66ae63: badFilemode:
contains bad file modes
warning: object 83941fd0e146733198bcc5fe8c06d50dc9e6c225: badFilemode:
contains bad file modes
warning: object 8caa89079f408d056c20ae13a2a62cb2148ccd2c: badFilemode:
contains bad file modes
warning: object 6c8b42ad4851c05a0a093af5468bdcec6367b7e8: badFilemode:
contains bad file modes
warning: object 56763d1f057cdc4bf4e60cbec69b51593f9e3bd0: badFilemode:
contains bad file modes
warning: object 4f856748145b27bc669a98cd4d66574dfd01b083: badFilemode:
contains bad file modes
warning: object dd229923a70e17998038996d66d4562df16f6d28: badFilemode:
contains bad file modes
warning: object 2031abe6fdaa115800eb0c5cd66ebf265d17b3c3: badFilemode:
contains bad file modes
warning: object 928b601edc5e57a3998233b5593de63f90d24671: badFilemode:
contains bad file modes
warning: object 0ba51186089993112337d5b34a9ee23fe7cf4fdb: badFilemode:
contains bad file modes
warning: object 41bcaba0309c151fb38f82135d9b011e2066d130: badFilemode:
contains bad file modes
warning: object 8bd5667ce5588ab02c103c9aa8d8f1c6e90da56f: badFilemode:
contains bad file modes
warning: object ac0272a74f3bf08bdc6c403dd624048521c89021: badFilemode:
contains bad file modes
warning: object c084af1ee14b234a73d47e2bb3fbf3617837e16d: badFilemode:
contains bad file modes
warning: object 5b140cab879595232bb13fe3007cdb14ed267db6: badFilemode:
contains bad file modes
warning: object a384894f34b2360404231ed72b3beb136876e16b: badFilemode:
contains bad file modes
warning: object 832c112baac6645c09b4b30f79c263c679e54994: badFilemode:
contains bad file modes
warning: object 60f9d89665bd7623ef43c2b2dec7645bbb08c778: badFilemode:
contains bad file modes
warning: object 5f7966de3b4b60260db3b510e6efeab94e55f37a: badFilemode:
contains bad file modes
warning: object 6ce87c726d7f7724a6441a1a94f2fc18314c5cd4: badFilemode:
contains bad file modes
warning: object e03fa31365b953db15f3dec6810aac4a58678e6f: badFilemode:
contains bad file modes
warning: object 426bfebd8064b754e1f6ab7ad6ab81801310043d: badFilemode:
contains bad file modes
warning: object eeb0c5958781ed3ed29c42b488a556676cd71ab7: badFilemode:
contains bad file modes
warning: object d64c721c31719eda098badb4a45913c7e61c9ef1: badFilemode:
contains bad file modes
warning: object 364de08062838733978d41da581fcdbb73c4f1b9: badFilemode:
contains bad file modes
warning: object db8e952afe1ad62c4bc5989ef3d2292ef4aa4d4f: badFilemode:
contains bad file modes
warning: object 406548bda4dfb72566db6e515e38604a7641ec15: badFilemode:
contains bad file modes
warning: object e31297f6bcdec878e0054ae10066e2aaa0495fcd: badFilemode:
contains bad file modes
warning: object 10344b81045df0a2cea3e76d325df5156c0294ab: badFilemode:
contains bad file modes
warning: object 5c9ee24e27939640e18088e56f40373fa2620b0c: badFilemode:
contains bad file modes
warning: object 5cc4753bc199ac4d595e416e61b7dfa2dfd50379: badFilemode:
contains bad file modes
warning: object cc4cf7c0e5833fdfc4999d33d5b652afa4858bb9: badFilemode:
contains bad file modes
warning: object d32ad1f96650d7da0d9b7043eeece8235da67b82: badFilemode:
contains bad file modes
warning: object 18e4bb98e1e685dfdd798048ada57c925ee87aee: badFilemode:
contains bad file modes
warning: object 6dfeb7c11933067d0517ee8f862430e83ae33d29: badFilemode:
contains bad file modes
warning: object 3d00c15360e1aea2a51558e5f56b95d11e9d7010: badFilemode:
contains bad file modes
warning: object 6bb02c5dc7e827fd0fb0d36ae92d14e25318bffa: badFilemode:
contains bad file modes
warning: object 7cb7710ccdcb867bf190b70d4586593bbad49499: badFilemode:
contains bad file modes
warning: object 5588456a03dc45bc5cc026a7e61ecb86bdd10c38: badFilemode:
contains bad file modes
warning: object 6722a6e40e1edeeec7cd4c527a16a51553074130: badFilemode:
contains bad file modes
