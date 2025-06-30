Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EBA59
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255637; cv=none; b=NoiPZX/Xn0k5NkrofCZmNQRZK+2BoHqaDQN+jg5ctLBwSKMgJjmztAazkXQnlymiKUcv4ivpxy7sUh7kdE2htbl608rbaLhSn+QtWkpXidxhBQ7kFHkcdyXYr4tvYgzXjaoXnCsG6TwTGfVh/nIV2u3V5+A9Xz26hfDQxG3eOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255637; c=relaxed/simple;
	bh=3L6NhA6gUl3YwecuqY2DrF9lqdtFg7m+IDyx9apwvYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKpuZxltUAUbT5nN0HVV0q/QZN+T69gyrldNSnNzc0x7V32kAGZUH39Ko95SZvWGv+Ot5/pd7HVVvThf9rQ56XIwqOoAL5utgUKpiM5SK+Dm5pJitSbE2HKHlyTDMdwHyJde38ZyRHxUub9dHcKTANBEuVS57zj2H1TSk8JZHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGC73Zja; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGC73Zja"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so1126299a91.1
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 20:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751255635; x=1751860435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vd8U0oLs1B2njz64SFyWgts14TNuLVWH/8WCLg0gvp4=;
        b=cGC73ZjaOkxf/GjJ+bTqfB9FZbv9gcxN34KttNSqwRf+6d3eumkjrpi2ZiZWi51nui
         RNUO5WETv/g5fHINE1b6Wo7NWC6pGqx+aqOXmZxMoyFTigOWn3Q4jpi7AU8TTuRQamhg
         WgbqYQKUcEpjR3zy3vLyGEFSFPnl2kaSygud217B9jbCf09MO5RXJPsM3HfISHwIvCHD
         3afkZK2FJ+sUvnTpnnR7J98A3PK8v9FoaRaX9fE7wZ+RbkhzJlk/7nOv2w67Lp5kBRg8
         4Bvczsl/nh033XmKNTapn70dbkIgb/OKuoPx8tA8Nng0XnnZBdCqIf7pWEKJff5O4Z8+
         n3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751255635; x=1751860435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vd8U0oLs1B2njz64SFyWgts14TNuLVWH/8WCLg0gvp4=;
        b=Si6is3wB9GQdxGYBDmf+Dve9XzQPzn/DuZMbYywiYLxZxwZ4mp51A/IlyTGsOmeLby
         vKmvjnmAe+oT84/CWoPP47J1DBZXcsF+dTcj/jC1lOCaEQgzEY8CgEz5zKicp2lGjZx6
         85Q54XL4e67UhpK7OvAjemxLi9x27i+271cv9CMOK4micUMDP4WLRCuphQtYdnLOVQf1
         ThFYVQ51yYmCSwu95Zw6QIX96yi1OK81xeEqm3azqwZFdD6endkxvwdnwTs5X4e1jTnW
         wSvQLIiu1HIGClzuZyosIRwLMbzw6k4YBDu03kjfDQ8HqyBxFxwhM9o92STe2nfxXuVM
         se3A==
X-Gm-Message-State: AOJu0Ywmhpi/izkty2JKD7J1As5zejSFFTws/rhgOjtmaC9843DFPFWC
	8XEZ86Ip6PaN5ne+HEZx0WXRTG8vz2s2Pt6KMmA483cLsBUPIHPu+alXfaXTWJGVfwR3i8jLUOD
	DXrpV1ZgicO2HIZWc9vykrHK7BiRPXDw=
X-Gm-Gg: ASbGncuffd898lDnzJIRaCwZS1stq7JLgdgSFchWKyj1mtxw+/d5R5poy2luMd4saMR
	3oP29rxzKVCY6DabcDna5fw03W1iw+Xu4BhGUbNt51ADC4jdPzn86FFIuObQHzINMZlrCl5FRdP
	kJI1dLf1Frn8jW/d+uTgZ5tsUFqA97QJbaq5jhlV6+rCfMmg==
X-Google-Smtp-Source: AGHT+IH/j3tf83NdwPplyg7LPUenq5B7jgatp6F114mAj0v7d21flrvGwcDytT6DvS1gHrc0UkUJFru9HN96bRWKlVw=
X-Received: by 2002:a17:90b:3ece:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-318c9243f41mr19204716a91.14.1751255635434; Sun, 29 Jun 2025
 20:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627074934.1761897-1-meetsoni3017@gmail.com> <xmqqh60183ku.fsf@gitster.g>
In-Reply-To: <xmqqh60183ku.fsf@gitster.g>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Mon, 30 Jun 2025 09:23:44 +0530
X-Gm-Features: Ac12FXw8QUCz2bTDw3aWUXV7wXxC9ilMrSM9ZfUbgxTZeohNPYsjHnpdjyTmkcY
Message-ID: <CAPhwyn01spdT-hFxVPcr4cnwBJ=YL3Ty-johXvGKXKRdCTpHXg@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH 0/2] Add refs list subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 23:33, Junio C Hamano <gitster@pobox.com> wrote:
>
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> >   - Remove legacy or obscure options that are no longer needed.
>
> Such as?
>
> >   - Add improvements that wouldn't make sense to bolt onto legacy
> >     commands.
>
> Such as?
>
> While I agree that there may be cases that the above goals in
> general would bring us improvements, I think neither of these two
> applies to for-each-ref.  People are using for-each-ref to iterate
> over and enumerate refs already, and if you are to add some new
> features to "git refs list", they certainly will demand these new
> goodies to be added to for-each-ref as well.
>
> So, I dunno.

To clarify, I don't have specific options or improvements in mind right now.
The idea behind mentioning them was to acknowledge that having a consolidated
interface like git refs might open the door to such discussions.

The primary motivation here is to make ref-related commands discoverable at a
single entry point - git refs, rather than scattered across several top-level
commands. The aim is to improve disoverability and set the stage for
potential future
cleanup or enhancements, should the community find value in doing so.

Per mentor suggestion, this RFC was meant to invite broader input on whether
the community sees value in such a consolidation, and if so, what shape future
refinements (if any) might take.
