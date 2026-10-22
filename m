Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792662889;
	b=O6cGydtzUkZPr4FND7xpz2KoLQerDwcwGRQB6Yfm0d4ePLkJY16alxAwxJq58pvriJxD
	 rpBW/il373G7AhFxVuXUN598efjOT358fwWHlJ9pMBEX3MZsCdpybN1WyNQSvYExiXCaA
	 dTKIxP3qMjbrrbgKAuGB6FHjDnzO7FO741JN8msLOAXdimmhQ+61rwwOL+WEz4Oyl6IEI
	 xVj1pj9kTEyUbC7wQDxO5mbVBpgIBFvHpqPlJahApoXCY4Bl/ZQ3lRGWrpqKCf8czqtkE
	 AEWqIYXKWamfIZoK20aVEDcN/xMPuGklSrCSASgZmHhfvzaGAerGdJoirywVPLbUTIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=2JCLcW/4VUUVFSD9Uc1oHBXpvaxxhQuOOVaUqT5ZYsY=;
	b=uAHv56NDK9kCKPSS4M7IOEBBwmjLBFB9BBZ2r9VjzUSdhjN8lckAdKJCoJxhFoDkN2pg
	 mnI70fQtC6cGTVfKdsLO2nxEXairjx1Pcagyf+mke+QH8QFA7woSsYnnRxWdQmRCBBu0t
	 VJjpTO5P3MBr8fG9fkUI4B3tUrGZ/qOc7mlN+vjWE0SMc41CI9LmhiQLklQWX6ycsjCs3
	 D0OMcGukmoGa0Ux0J2mr2pd6eixpQpJPekSK6pX5XuuoEpcWBNq/RFHf0EkLGQu2zDHoG
	 4InbSnnlH1t+8tHRmyvsi/VnWTB4tS6F+yAvHAMzOm103W/7CM/zHfUodLDiVV3jIaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="O/34k0Qo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DB606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 09:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E9DB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O/34k0Qo
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so2336571a12.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792662888; cv=none;
        d=google.com; s=arc-20260327;
        b=hX4VMGR/6hQG1ZRy+trrGCvvQ3+k0Zz0s6cVKwbUke6p0Rpm9w9zHWZFlahxkCu3XV
         51kDkOotGjV2T2HSjH+69y8fAZGLkD0ysbRUir9pWuDwOLNsMj0yhKFj4aLxTFHq12xj
         8aV78xKdWQwFmJMnwEMZfNHVXM76u4j6RJFW19M0hV2BUvSfR/AaymuWfYHF1Vzi/oMl
         hxCcor2Q02+OVo0cbb/BJnrTjvZI62lkGXQmC3QqdqwUJXbGAHWVUx24NeUAfDKECFzh
         mSkosPSfY8h/WVueR78H8Vkahet5fr4fse9F2NfebeJYQtiadOYLWt25o+VlGHyORaMf
         kclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2JCLcW/4VUUVFSD9Uc1oHBXpvaxxhQuOOVaUqT5ZYsY=;
        fh=hv86tS9KzE8Kz4f8u4dZlokELkq6PSd3zKnHihZN1As=;
        b=gLbeAl4+A96AayZZ7bG7h87ARgv1HDk+Ak50xo35R6ITm2BDuQd1qo9vhwphgZ9PkR
         JhT6efVja5HJ37/IzaBx0+gxHlRq7lUjx8uFgC0+BpBjG+QgbcrBhXqKOHRZdmr1zub2
         0MBNFknvPVwuOZx8yUM23E0hInrzXV7hJ43waimqhlcluuZ+0JQeG4KOGo/VBRLjEY6D
         +HU1/HnZJXpkkquh8PlCkH1CrA4/RZnuEr76zk0oWKYMVqGJVUEzBylML/HKqVsF0gux
         gE40Dcq49F3w5FhOQ3yDcNA87V8UMbp5Z7ooxaxn3olASBVEcRwMol6qObkNdLOFjWa+
         xqWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662888; x=1793267688; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JCLcW/4VUUVFSD9Uc1oHBXpvaxxhQuOOVaUqT5ZYsY=;
        b=O/34k0QoQJLYtgYsZAieToQjZERc4HPYtexeoTo15ywvRpnHBisy8krZwdGU6q3Fmx
         nCx/b4P2jvkx1ZZ4q4QumYQ4j7/EFO4xKFaKVfeI++HV8SM8nU5XuCF6WpVNK3/tlgSz
         Nd+eMv9xAyovp0+Ka7uFK1zxB8Yz4S7wsuELZecOX1MHhuTpj1SOwcdnzl4HfSr9CDGl
         ivIOC/tn08QXUqnMZlH8+daHAswQwzemwAAUf1jcPIUYcGG7bY/Lv+7fFHmqd+rzNZKG
         TRNmjjKahkt6VAiCcboYzv9S2iPSkgZm3k+h2u5zdfe2MAvDsDaiKjjtmNfNz+fAEoJK
         Wn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662888; x=1793267688;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2JCLcW/4VUUVFSD9Uc1oHBXpvaxxhQuOOVaUqT5ZYsY=;
        b=UV73ksnCkPb2PuqQt6CNmZubpFaBHX8/xKhqbdNzvp41LTMT4hWxgWJJQt+1oRwKY4
         M4PQtantSAXFDj9I18DZwnUt/hbdmtKk6ofjTebgMCAwEKROBF4Yr1+f0uryqeEOsDJf
         /cVURaxYkztkfxtO1AUErz5K2gpho96JokPU9nX7pKVyaf9EF+ducNPjSuAoGCmYEyaY
         k1zC+yLLbRwHGjZHFS/Ihg3L3UQyMj82XyP1yYLA6hQijW4d8EhLzD7kftx0pEx4yCsi
         Cl5xK+MjxmOFtXmRdHtEk1R4OBkDcMpQ4IxFfkolXLwHGfaBO+1rD4tre6E3YLV5AbDz
         WzQg==
X-Gm-Message-State: AFq9FYIY+D6rHClu8QM9pjMST7qh75iPp923SMrNbPAw/qrNTxgpyd2R
	kQIyoBvKMnBfwp3qHHTY8lmfOappRoKumZnoNca1/1bC/dZAMWplXL+JnmhKESv34XS3jesmCH1
	FJI76w8FFydiF2746sWHLBqTKNATnBPw=
X-Gm-Gg: AYBFou357nnWaOmARyrb/j0k+HuKYpmhXowfAA2rnWPdTLPc9+1D5XXq/B2DseFMM9H
	UlK0XBNFMF1hEDkKYZxL8wjwiAsDR3ByzzL7ea95dynPOZy3FAuqXS3F0l7UI2p7Cf/ZxoomFzf
	VaTXQk2WoJ9d9w7luXZToXa60+JOehKTgJqwpF6KT+QofLtjXAng1Nm9u2ugpSN9W/xabEZUmfm
	aCuqf53lbkaKMn/J//EuVPraFn1aS4kZCPqRGfHsJMt9QnV/8mtyOnIcW2HjYJYbrOF5GjZlBQc
	APZY35yOmPQUDdgmmAU5S4IqUNDH6LqSwEffmMiTQQzkQAyabrIYIk011e4U+Z1xXHjm0FaD0L4
	E2nS4iQx2fV1l24N+kER3JagGO+5rS1AzqQTl46I5Sd7rxWOrGfC239UNUiUDFhR6R3qD
X-Received: by 2002:a17:907:94c2:b0:c2d:bc33:7be3 with SMTP id
 a640c23a62f3a-c4679a0d7c6mr456897366b.47.1792662887765; Thu, 22 Oct 2026
 02:54:47 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOcE0wJ88hbd9n-A2C0RxksKVtnt76u4vGxvhQ4rdNDEdGTmOw@mail.gmail.com>
 <CAPSxiM-dxHUE5tHf830=zHnLfg1U5jyb211-ZODS7bu8OjqEnw@mail.gmail.com> <CAOcE0w+EciSBZDTTNzbi8hEzZAZjB6gut=Pc9qB5yEgs-w1f2g@mail.gmail.com>
In-Reply-To: <CAOcE0w+EciSBZDTTNzbi8hEzZAZjB6gut=Pc9qB5yEgs-w1f2g@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 22 Oct 2026 10:54:35 +0100
X-Gm-Features: AclHuK-H6eWw0cq6gyAqe_HTNMTyzd98gz3gfKvmNghHRgbgHywmVUkUUm5cvkc
Message-ID: <CAPSxiM8Nv5mnWoFVjWE284yhYG0rdLmfXN2xbZpm4H-wO7oAng@mail.gmail.com>
Subject: Re: [Outreachy] Applicant Introduction
To: Priestess <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> (Resending in plain text, since my first mail was rejected by the list.)
>
> Hi everyone,
Hi Priestess,
>
> I hope you're doing well.
>
> (Thank you for your welcome, Usman.)
>
> For my microproject, I'd like to work on avoiding suppressed git exit
mpare the file, changing only those four spots.
>
> To check that nobody else is on this file, I did the following:
>
>  + I searched lore for "t2104" and "update-index-skip-worktree" and
>    found no recent patches touching it
>  + I ran `git log` on the file against origin/master, origin/next and
>    origin/seen and found nothing in flight
>  + I also checked GitGitGadget pull requests & issues for "t2104"
>
> I found a GSoC 2024 attempt on this file but I could not find that it
> was merged. Also, Junio's "t2104: style fixes" commit did not
> change these pipe lines. So, I believe the exit code issue is still
> there.
>
> I'd like to know if I'm clear to proceed with a patch.

Next time, you do not have to wait for someone to tell you to proceed,
you can send your patch when you have checked that no one is working on it.
You can also indicate that you are working on it after ensuring no other patches
addressing the problem.

For "indicating that you want to work on a patch", that is needed if there was a
discussion on solving the problem before or it is a leftoverbits.
>
> Thanks,
> Cynthia
Thanks.

Usman.
