Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC914AE13B
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646708; cv=pass; b=ZRoWATTpTUgUms43Il8GcSaQ6aONFTqwiYna1WTzIIKjvGx2qGmmUEkjzu7EKYsdrdomGVX8T6qTLBFSFg4PFJtb/Gmxj9jKjMlycc/XgW6D67LCU5bOYAmszVkQPUk1pDnGyZKhl8kbBsiDB6dGM9XG7emDGIZmHXIv0xp48AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646708; c=relaxed/simple;
	bh=YHRgM17j7cAf6Ku4AtmpAkjmoKz46aM3tU3hHTtxoWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sy/GMK3L2DufJhePCNi1rgPy+TyiAgPb+j/9C4ZLQTNxhQNjtYzIcppZxzeWRBevEd0ILPweMCQAn6YHupTfsA0va6IROPOntK2mPP4NPcQG+Ko6eR/iQ6GQlaMP7+ul+ctjcv4CZ3JvEOungiBFBhp4j9DgRq8Gq7vbzxQ0Nek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjK/uMJS; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjK/uMJS"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115c1so7808145ad.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 05:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789646691; cv=none;
        d=google.com; s=arc-20260327;
        b=Vhsw0To7ayGge0k+sny6+vjVn2cLHIsAS516/3vkCoSsz4dH/P8eJgssZjFL46jwA6
         oa0uq/Y4qlPpO97g5u0h0Ev8xiPzFO31YPI3p5mghAGmVm0VQYePzmX+llT1upHXDWtx
         JL7oJOMLYPqEkgmmVrouVGSf+Y9SII3tV7qHEPppMIScZLiCBV1OzhXSEPi5VJ6z2jTx
         nJJHDDfgb01J80z1vAOZvTurCpA2O3Du9YQLN/7K4jU4zU1kIbDca/O21Xf75LNn2lJd
         ByQpSYiN5XISMCENt6CabE+/1u1eqvLLr556xQgaXtwjtwW7xtH+9BMJdytN2ZtNkJYA
         opog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k9bye9nkuIJFRE4CB4XIiTJGDDvRowJxekj+4KSY6dU=;
        fh=e0xNKdsyXmc9YxCu/01ZjTrZkt7r/0sT+3Bhd00xCp0=;
        b=EBbE/iAobKDYyydksmbLXqHCW21fmT51o/juk42fDA5ZXxXBO4alOhvIz1w8bdsYlu
         RPOoOqNM7RkRRh/A8C0iNvrl5ZHioFwjcID/oKkEKn5UlIAQf0NJoItfZb4sZiTe3t/z
         /QGi8aFn7pMRRi4/m7A0mOkFTTE0nh1P5nQfU28yzpT1q9N5maoqNAUZ2CfdKy4jD4oC
         Sf0St22lURkkRHLFzb39hHi5s337cLInUcvhKjXqDzzN/mI0qavLVN4FcO1Ckod7vlru
         WOmaJaaMdBYfJa2QCsgwqWChk+swnKFhNMU1/dQHfo9i08W5mg76EsSQfdd0UR/RnAl4
         +iQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789646691; x=1790251491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k9bye9nkuIJFRE4CB4XIiTJGDDvRowJxekj+4KSY6dU=;
        b=CjK/uMJSVF8RQD60xTlf5qI4fe/NqFtTTompqyEUqz7KlfvoxUS4S6MhCpf/JaJffd
         ZcLcC6/Rzx9isLTnLvF40d+HJ46ePkhHhS7chZkjsr3Sl48dH219AmYd+gdR+ywtoJUS
         ZLJijx6pRYLl2xa8aqFT/75ZWt0ove+KAdZnGRNSNZrMAgBd/py1HepWOv3OHPU0kCwq
         9+YQfbhukU4w8gqD7PwunM2RgMzHCuBhA1vVpxuTeqoJdw5EDaGunDB+buuovVp6MIx0
         ve1kr6lBItZvr0Uy1mvYpED76evPxwadkFUW/MbpMKnuAOeHf4n6zZ68Xu/Eb8vJgePj
         a6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789646691; x=1790251491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k9bye9nkuIJFRE4CB4XIiTJGDDvRowJxekj+4KSY6dU=;
        b=100VOouGTToxC2rY3hdYT6FaVNj1VzMW4g/BRCvR/xwK8WuhuAINtMG8vOQtAH+IVc
         C0x0kB99MmU5y+eNfq9wYqDk0n7cb2zVZ9vwrV0TyKfNeTfPDSabEssM9+5rE8AUlLCu
         jjkNNx21VGSXb8l4joItwBnCSy/eg+GZ9JrFwrWZQ01IfFUTLxZTeATRxi6aF+cLTGlh
         HIp/ofYQh8MYCws4a/mJhfJXo78SBkj8BhkO/dr3tSSuStTkYnbPg5g73Uwkzu6PtCm+
         McugHfGYjPWW5bRuEb+uBETpCt0mmWv4TtovrdomxTKWbvbjMVdfeVWxkFIqkiQ97kkJ
         X6dw==
X-Forwarded-Encrypted: i=1; AKwUvBz+cInBhvjtg/N3cDuH/hWmhDrOSx/4EOW7MnoPDa1lRfSHVaoRdEFjlhJyJ28cCaTlAzk=@vger.kernel.org
X-Gm-Message-State: AFuF++k5BvmEfm7DYcWR41eW37Fm7qhTbHcb/V0oFGijadS63WL6a+Eo
	4aCrlg98XHfy9D4a93/7evkv2Xs8EOma5JfZNj6yzMi84GXYGNXJ23K91Cfxqq++f9cEQkQzTcI
	GEI7m2wMnX0DgVvQ+v3FDtic/naVmmFIM7Q==
X-Gm-Gg: AYBFou16f/6IjI1yOi+Dudr/HawecGNHn0ioDfdbkLmSGSeIWCLMQos3iFoFmd9A8Kf
	yvgDDFwIo1YT6RjxUN9cUkCLCdFKGsHXJmzLn9Y3JxS5ZuYDEnAOu40qMOGRvTDo3YZizt4nNcs
	qUKiqd3Mf7ga5sIQ6gSZ8+gbNwp2m+X7XdCPxrKD9mjewrVQNu8lkU8fgd7x+YRAPNRQcKDZytn
	+SeMCPPAqJ8XjSQjpfz6lm8s91E2Kb/ig8SkJQXVUxcmVHsw2Yk6Tn324T1QbNMSCAtpr2i+NZD
	Z58Mf46P6uimzCdZo7UlZIdwjUoz1T+5V2XPY3sybjRyO8F0XhjZYq3ovYkfHKulUGnXvwQBS/i
	FpvA4AzhesAF2zZc34JM8jxP43/ezRjxj5p8ESf5vA5LeVZBUtCMnmJc2c689Fv8okfxqg0dGVU
	fq0DR5Ufs=
X-Received: by 2002:a17:902:c40f:b0:2dd:89b1:7fdb with SMTP id
 d9443c01a7336-2dd8e03c3bemr116017045ad.9.1789646691140; Thu, 17 Sep 2026
 05:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
 <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com> <CALO-guua8fcRq5n_M8=r9GMZ-aW4LaddXxS9rz0YhpAQ9TL3mA@mail.gmail.com>
In-Reply-To: <CALO-guua8fcRq5n_M8=r9GMZ-aW4LaddXxS9rz0YhpAQ9TL3mA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 17 Sep 2026 08:04:39 -0400
X-Gm-Features: AcwNN1WU2LHpLLdLK6_AmlMpsnWu8PBfl78ELDNaDmipToDqUZBQHgTZzR1rp8Q
Message-ID: <CALnO6CCtACSLmkCm77=rY40+90f_3OTuGKg30AVORtQk2+=gMg@mail.gmail.com>
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: Eli Barzilay <eli@barzilay.org>
Cc: phillip.wood@dunelm.org.uk, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 3:57=E2=80=AFPM Eli Barzilay <eli@barzilay.org> wro=
te:
>
> [Note from the peanut gallery since I can't spend time diving into the
> code -- that's result of collecting dead autostashes is the only thorn
> in my joy of discovering `stash.index` + `rebase.autoStash`.  So while
> I can't spend time in the code, I'll be happy to try patches or
> whatever if it helps...]

Thanks, I'll keep you on CC for patches as well :)
