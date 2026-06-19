Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81135399007
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881351; cv=pass; b=coPyAmPVz3KrrCimHuk2CFybJKIU4dcBpXly8Jd3N2VyEnewnKO9U1zWXCMGOEhOajibEzN/5Dk9pfTj2MW8GjNvbCWFUaDA690p5PhENniMKM/72bqP54pAZUz3YdgqWQcC/pNleNis5XD1FLionlJVa8YTFm324YaaI4YydNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881351; c=relaxed/simple;
	bh=Zrdb5NNPMmPi14RumZ4Ux6gBeGJkIYdlTNe6nkBsaag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAVn4YkajM6EmiPfN19AyMF3cvFzZdwPn02SvfOspNe0fQH1PytSpEbwMmg+0oC+7jRu0GJDIPpMZuctujY8KOOGphHzQIwafAAIrK4CaRz8VPPVD8kXqaoPV7taUYavCuOaQZ+uT4Hy1HGpDnLF77LFowLafO5DDY3PO9pplX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnBYBM4E; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnBYBM4E"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dbcb505578so25205987b3.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 08:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781881348; cv=none;
        d=google.com; s=arc-20240605;
        b=Yxes3NEvAnjfOI3DGy2MrGkxZlSzGQPXTMv0x/fWrjDtIkjJ8Z932G7tb9kj8T4lv3
         Ss7M/I4e5KgVldUOxYGtqH4qQvlQYj9tjOSQIMfQHVz6CjjqrzZ5k4vkZHp4n8pnTRbE
         SX+gFXBOBacQvCgmq9gT/CgVbEMiKT+LIzjFzkDmXIoNeR8zWZQKqmHx2VHVPRAo6mHD
         9rWseSITaLxY+Kjq5R/9NTOT13e2CQrVFR4U8p9YtjKQeSONRIy3oTVGcVF9elYB/eSe
         RUhesaMKcqxYT3tacva0pog1kfO4mSxU1HxExVRCocrQIWGA9j8sUh52mOw1f+kLRBMv
         /uVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zrdb5NNPMmPi14RumZ4Ux6gBeGJkIYdlTNe6nkBsaag=;
        fh=bLBFwVVxD0mtSVCNfeXVqx11UMldKKepDj//oywTbDk=;
        b=cNPHtgP08myxgT3cxeF6aNoC90C1OiYqqldzgKIKFlUAJ7QNm8Hp/ZftX97L85ax/D
         RyRJ6hqPHC1xJxVlRGCW7tqKA1qX4CDeQgLhM/ksoYEgaIuOh6PTGIEKy61xDymxACUP
         /6oihLJamvp3IQEx6B2JUxroz/nAB9DxQCGIYZatJKUOKH4UPFQLkGfcpT0Fk8sei/Yo
         s8vaV4BB5vuPP3ZmThpDYwM4XXmzcm+wLaBtGOLDZ4F61iIzxE3lPZLsBC0tp/iCMB6d
         ogskRxEDJk+8irUYV8RnO/KBekR4CU8lNeVunJ2PTurcHVgd0O4pTOab6usdNLe71j+Z
         aN/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881348; x=1782486148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrdb5NNPMmPi14RumZ4Ux6gBeGJkIYdlTNe6nkBsaag=;
        b=TnBYBM4Eum0Azjudd/VAJlgLQ2mlH/drLe2Gxp1Pe827WGS1zQ7DRoGSrR3udAJCNQ
         0sl/SL1Wegzx9hdFRXwEnNtvzqWjWEZqyxz9zIf9Na3e1P66HZTLmPzfhIUmF5axhW8q
         lG37QfM5uLIv/l9Ukm1f7oUA+8yybzU3YWGyNoDZK3H31Zfazg+S3A1cuYV6ogJxLuDL
         Uknvm6I9Z+Yfv4mTK3rrFDJSfZmgTcmFQg84QHVvUyByHJAIbH1jyV8yV041DZaKZuSX
         rHzz7QJm9Ugc5V0LnM9+vMWMzFJqskHkRDmFqVDKUK7RHCfkjBaglQSi/BJh/aObn6IF
         Kpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881348; x=1782486148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zrdb5NNPMmPi14RumZ4Ux6gBeGJkIYdlTNe6nkBsaag=;
        b=R4S6F9rvQnR5U35jfX1fOEXQ9SLfSlQ0SBCVRW6wMLCRkIYbMYlRezvtI588sCk2Tr
         1XCP9T+96J3evTjvVGKms3S0VntUjliPe7S3s2g11IYvQg/v7QDeK7jwM+Ug/L/RwqKF
         KohhCb0fjKaFQuFzT/z1wpNxUKPi7EB9hFiCD1KayCEEILXIzyFj9dLy5MAkmsZkzwS/
         gKe+NrBnIsGUJhA9kQtztS5VD1YjWSu6nK42ZH37Au6bHM8UfFRzL2EWsamy0R87kiRa
         R59b5n4A82kSShywnRv2QGOzjfd19XoEBBqwr1fVt8dnpAH1ECXlORvnjmNabIEguefb
         mXMg==
X-Forwarded-Encrypted: i=1; AFNElJ9X1M3/fULhnLe35RTocTp0+wPpbF2mx2lSOIYZmJmRaNf9/cWUFC4illXQPVUOL3nDyGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvgM7dUpuIvEOaD7VqYFerQpeMfhOc7cnLJpb55Wdalh/I/9G3
	tyqqJpE4i7DBdQPJ16i2X7rcLIZDdPHP5sM09JlQJlpDreyzOPQIiT43BISe3oyz5evfDTdEtkc
	EkrtdmU75cjZEpvS97QNZ2zAX1LY3Kqg=
X-Gm-Gg: AfdE7cnIvjKfiRvLfojk+W1P++xAeSTO8ek6J4vb05aNkz57mgbxSkXcTj/ObYVLOqY
	O5nCrfVABks4+DbgrnGiYUiM+9y0TKNv26tJx4NLXfCvfiIRpv0TqC/Wyi1Ca236U/LqbiDlDG8
	DidYz1pc6A+wTPwbIffJT9RRTEyvXfp3BtlM6udfpooVVSYT2aNVkGoQ+MzB/aT8yreFADo3QAc
	iDv4FdTgFwEkMpP6DwS+49iwFrKDISAmgD0wZZ2xLCZ3s3Q68UKh+syvh9ehzyklt8btf52pg9v
	wn4PeDAzrYzcNlED+VK8Nh2mcrXf8CMMtTU1w0M0QUT3Lf0SKdortCi9hvjfig0sZytnAYkqhrD
	3WpuNUOFOnEGkXSys5u2bGlUJmKYYeBbE4pH+S+ubfnRi4Bok62L3vyu/TQBY59sav+gp
X-Received: by 2002:a05:690c:c521:b0:7dc:9693:57b0 with SMTP id
 00721157ae682-80133402b29mr37896977b3.42.1781881348296; Fri, 19 Jun 2026
 08:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com> <20260619-ps-eric-work-rebase-v13-4-3d4c7315d2f8@gmail.com>
In-Reply-To: <20260619-ps-eric-work-rebase-v13-4-3d4c7315d2f8@gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 19 Jun 2026 17:02:17 +0200
X-Gm-Features: AVVi8Cf0QPwovTdfSbvJWDwjx4M-1denC18tIYjPU2SvTf0BpcxT8S0xS-5vxgU
Message-ID: <CAN5EUNSNFbcQRG5UbQv_jx28iwjoV3R43U9Rt8wW2Us7z-5UBg@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 04/12] t1006: split test utility functions
 into new "lib-cat-file.sh"
To: gitster@pobox.com
Cc: peff@peff.net, eric.peijian@gmail.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, karthik.188@gmail.com, 
	toon@iotcl.com, chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 19 jun 2026 a las 16:56, Pablo Sabater
(<pabloosabaterr@gmail.com>) escribi=C3=B3:
>
> From: Eric Ju <eric.peijian@gmail.com>
>
> This refactor extracts utility functions from the cat-file's test
> script "t1006-cat-file.sh" into a new "lib-cat-file.sh" dedicated
> library file. The goal is to improve code reuse and readability,
> enabling future tests to leverage these utilities without duplicating
> code.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>

I forgot to mention that it is needed in a subsequent commit, sorry.
It will be in the next version.
