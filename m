Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792673762;
	b=YymK1cdR/zTevExMdNmR9Cs6Hwntn6Vut4KGRFOdv688u5xpC4+gpxKUnh2Q2P7H23G6
	 heGNpcI/4xhgq5RqvXN6kq1/NuouKsQimWFGZruUM0g4cotamRrib28Ha4Bfr+z25bI3r
	 zYxDaevThEljRxCDl0bs4kkHdbAopSPNURoBVnLZPqHn7o6M89RXkVSvjCZ+aWpDHUWOZ
	 no11t/4V3cD69DzherTjSjIadMryZUayYeZ6815WBWE9GL1am9PqfEoMn+iZygp626w+3
	 ciUWp566gnx3NDeWoSsTrepfDFliAwVX2wCXijsa4DHHoOEnKEaSTzifGrOuuVoMAVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ejH3+0hlVE5D/iuM5LRfw++9ql+AUQWS8H9cyzHwSNw=;
	b=NluanU+LLll7T5gjUC2BdRd5xDGftvZEGLEtwrh/AsjIJ8Zg7tKZgSvTjsxX3g/4mGHI
	 plG6yMLRMPvsnU6Q7bn6WvRWcEVtcNiw+/0pRTKPjPQHj2RDOxKYiH9k7JAy6zv/MF9uK
	 qU40MQUrglaeFx0fq0pD07lOT3jvyuTNglRCw6ARkiN7z3q8kGJE5qds1TkpMzSbkstuF
	 4JMx8kPam/PlJ5mLV+byD6PnR6XAlJ93hS5bN7E7F8t3fqyqhc8oE8hFUFvXemftRvnNE
	 P8E/C7kxQQ9Gct/cbLPHEWEWaAdPSoGnfI5YEKEaq8w/7bN6jAfry/c/lwe7njae3Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dh77MQ0W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7514606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7514606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dh77MQ0W
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a058315c79so819266b3a.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792673761; cv=none;
        d=google.com; s=arc-20260327;
        b=BYxS+z+/54lacEtD78QJAsglWiDmbijsXa/CdY5rq0iZ4Yf1e4TdtzMmzkhpJeYjlU
         IB5fn7LLC9vkRPYfe/unTvTaqJbXR5ufq2cE9cwjW+g5Dyjyn2YOpXaxSZwWts2nmpK5
         7lN4OGO/uHB8SAkVoYKNTQg8xq4q37wpAGn2NFMk2E3NiN4Fp7SzaJUltBNLzpPU8AnJ
         ipPra/x358sh8gft/9NDNSMLIOgXGEdKOg0Qrd7lSUZK+O16WXNa7Jdv8yW21TjF3Ct4
         M/5v3EwXHj06i+eibe6jox3zw/h704FGDJWL7JLJRHqJ/180vMuAZC2AfnFZb+Avo9yf
         mNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ejH3+0hlVE5D/iuM5LRfw++9ql+AUQWS8H9cyzHwSNw=;
        fh=9CXoHcS+eRKCIvZA5DyYbrosCOmZ9TdAG9rI6gHtt2Q=;
        b=HpVz2ZVR8PtE67PDnMz7COblu0Lr3+ZkVa6LaOZYnB3UEEaUaC+yfQx59bRvow2TnQ
         fp1kHLsxORvfsOsAAbSyEP66p0wm7rDx7GdLlgWy3s6QdHxbU+GRx3r13zOdzIQRkKhS
         /GxoJ/aPY0pbDOHxXdI3xDrO8u2yFUXYYx+UtlIPYplLqJ2WVTDNPbbKzbWXJRqSz/p4
         6y+OFn8X16n4bkMD61UyWuAEmamCCBRpS47jlZNvECa8T6r9eKQiT7kL+k26xeG8uLJe
         ayw5ScthoEp5hS1RqNdxRI9Zs895jCu/+sLg9RlB+qRVaMpXyoUok0WU0BODa/QSiBQX
         TuLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792673761; x=1793278561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ejH3+0hlVE5D/iuM5LRfw++9ql+AUQWS8H9cyzHwSNw=;
        b=dh77MQ0WLVbFShCP+2vr+CINw5aViA1cRWDbr1WBOh4iNB2iFs/AYixkMwD1xOaoYw
         qAJ+ZZ5GMSXLC6+YHimBTdsn8UfulZ6R+mBhf/FCuVH49t99UDA3aX/lERyh+OqWZl6T
         K0PoHDzw4dmyEtV8kTOl7cFFRyQ6a/PQYcqq1zJp7AW0q4b5D2Rqcf6oySzMqlxxVFuM
         HecUkLBw7C1HOWxUDRPTo5JAl4KIXaXuF1oT7TgqpBRywxL+/aKROuzQfpwH8yJ1MOCv
         kUxOwItWzjPGfyE+1hvFxzixaBw7oRAMF6M0pgu2soKwb7JA4VKgIqH+rXT6htfjxbRB
         vtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673761; x=1793278561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejH3+0hlVE5D/iuM5LRfw++9ql+AUQWS8H9cyzHwSNw=;
        b=sFgAAZOJ6u68abxpykAw1Acr/csEQi3KO3aOQ2B9h48Xs02aYieI+RYMc5iRd5H2Yt
         MNAIyzlgHN9Nc+cSG9FsWXg2VRFb4YfP84hg7cRQwY7P3qvwZR/lpD5JFLw62+/3XRq4
         +WT11T7aPoGCLC/VjpkWgRLAhM1XEidyyYw3ZOYac2dqI1C3puf/Ii+mMcj1qkdGeoCW
         dzZvv3xjg9d/AeYNbNweAXV6WUECNbxdxAWyYKiyq8BUf4ZYL8olCzKlzZHAsH6wpKLz
         WftnLMpHCF65oXD9YaA4iCRnYEWyN3OteK7/aS2gzOHeBnoBz7K1kM/u18dYjKijhfjC
         1+Hw==
X-Forwarded-Encrypted: i=1; AKwUvBza+o2fhiLUXPHs5H9Pb3KQ4dCIU6tW4b1mKUGS91qyGUoZlVt/hs9uvHpPYdEZRYYPdrA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCly22a8WUk7TtB9fVHsPRUQvshmMxz252l1SG0mNRPoN2onA/
	bx2czi/YNLt6pVpPw2Jk2I4va7g03xlrNvwAnUKF+cqwTjc/8h9zS/fSw6Go0YoXGrKLwNoS226
	RPwN/kRpx6odgR9LE7tzeZCEKS41sNnQ=
X-Gm-Gg: AYBFou0R10oPx4BP5IKpbzOvhLv4pZNxDBDXVKQXRTZq/wg84ckOeL97ArGR+GhakeQ
	SXLPGZESd5vFYvveKCtlvBf9Treob3frBT6Vm692+AHjQOuOfkASjAvFl0Iy6YFO0oJFz1fBiIl
	vNBXKv16hEQs2QUgW952Mi8YK5Rdm3zIPDeKUg7M24vN+LV/KseNCRS0/H7o6n8OiaXYRNaFbjL
	BjIW5lYfzIoV5ADTdLPynafE45weP15X+GGabq0ECfEFCl80T7a0uEm7yw5LITAA9Rnk90CifWp
	C7x2vAOj4p2MjWwB9y5fcmw5QBlgH1e3kljr3AZZhMhgDo/DdvokWawtuiYwi6UJiT5rzdGlj5G
	uMe6z3w9Ng483HmYVE+lfwZSKBCHJi5grG45J815XJM41g0waEfmewwCDr0CdtwRH76lvtcg0AD
	KyJj9dzVrQrcK6vAkUkUXTZPHKmPv1q+9lya3hmOxbsQB+fBZHRGaF4/oBXTwcqZ7A2g==
X-Received: by 2002:a05:6a00:3c8d:b0:87d:dc3c:1b5e with SMTP id
 d2e1a72fcca58-8a089d05d4bmr3927959b3a.26.1792673761176; Thu, 22 Oct 2026
 05:56:01 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
 <20261021173503.70887-1-me@jaspermayone.com> <CAHwyqnWnp0W17TXbXgLQPaGuwasqndgoPHV1CL3mBpfGFYadtw@mail.gmail.com>
In-Reply-To: <CAHwyqnWnp0W17TXbXgLQPaGuwasqndgoPHV1CL3mBpfGFYadtw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 22 Oct 2026 08:55:49 -0400
X-Gm-Features: AclHuK8NGU3ZcexFfrRGEsXveEZ-pHkujv4drDdV4sc3_TiXJOqimiTmtR2D2cs
Message-ID: <CALnO6CC0+t3PTVXC=TohzpqzgeOK4t9bKzGP-43uD1bbA4dPOg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Jasper Mayone <me@jaspermayone.com>, gitster@pobox.com, git@vger.kernel.org, 
	kristofferhaugsbakk@fastmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:52=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> My branch being pruned because someone else did the same thing would
> indeed feel weird. And it could be stopped by doing an author check.
>
> But I question if it=E2=80=99s realistic at all. The code has to be exact=
ly
> the same, and I don=E2=80=99t think I have ever seen that happen, I would=
 call
> this an extremely rare edge case.

I have seen this happen when 2 PRs contain the same "npm update"
commits and are rebased onto main: whoever gets there first wins. If
the commits contained additional changes, then the later-rebased
commit loses some changes because they were handled prior, but (when
doing so via GitHub) the commit message is unchanged. I find this a
bit confusing, tbh!

But, I will say it is rare. Perhaps not "extremely" :)

--=20
D. Ben Knoble
