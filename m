Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0607316192
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417936; cv=pass; b=NVY4r4Lw+dcFnsegvZi8MY0FprnN4nE8CiMdWw4/L8VGL+hM9V2SsnbkN4d+T7h02obPaQi88+ezn3Jakc1Gj6+k3797f3JsaLgZhgW7Kf8MRSOLm9nFjZX7mAZ9DquHkYTLj2rp8iIu06bSFzMMbd0SxIgvJLopf+OkcyJfuwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417936; c=relaxed/simple;
	bh=Kad+hJFH4HQ37Yq+1PoPnUXlXvpaSHb2BKpUr92jwbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkGkqn9pFpfbfIXaiql4xKuYex8eRArdgDg3imM/EKjHPuV4CDD9xmcdiKUhsmOEYj9b64tlhFiAihCObTRlb+0z/Mpx2U7qoCkXG3u0Yv9/NqQC0umg+CFvspCKnIblg/lrWBR1UCw5/Me3Lx76TK6Ni5uD6CMxycZwzKw9e3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yun7QQZ8; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yun7QQZ8"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so5245609a12.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 09:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780417933; cv=none;
        d=google.com; s=arc-20240605;
        b=lFLODXAVyWv1vbxMtxfK+EiZwTw/4rXFNmXC2d9LRynxyhnTs6FYwJblB5BPr41u2n
         8W2FbkYiCzaWKgYfNcNU/XFcCaWhmgPerYWu0Vp9zBM+wcATvVTeGLCNzhFlvYEK/92o
         2x4k17TTdwZ3PBbXq9HWHoZKLLo4Pe4UAb1KCBKv4zCKh017R7iH/jI4zHAnlMMEKhPu
         1Q3/ZQUyWafO+o0F1ViR9/K9xLwUy9YScmUbrVLhYlqxd1IPPvg4ycaPakXBc3KkTyX0
         bzVBzLcotzsKDA3Fo21vZbgdnHEn+4wsIsbO2moagSs1iFhfqpnMzkubw2Ww3fYKeSmp
         vcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kad+hJFH4HQ37Yq+1PoPnUXlXvpaSHb2BKpUr92jwbU=;
        fh=bCjvB5kdMpDhfhnUCzMoTBPePDh+/1UV4N+zm8fVlL4=;
        b=ZOStxvzYIxLbhdmaXuzkKWv8dSl9F4Zk/Hx0JU9uJ9MtRKBc/aUM0/fiEXl8z0xh4q
         dsaRylVVdpHtWtsiat79kuC5vrblCYOOVwHt/uZWzFRWP4+/89niYMAWSmRM0MdC6aJc
         levmznClS4R2bh/B63rCZD7IHXXvW8Slx+XHYkfh+wY5nb0Qp4lgQto+hB3pWZsQOb0A
         JoWwGLtvk5wu3VHsqiJ90UecOy68lpd47ML+1eC9BtzuwdS6rxKQNWwUYL9xjH8onZwA
         AQBhz/WRITmANIpie3ILiuIi/PnX074xuClVt3maz8X2oKgQMvR+tQUPcOdDkjjzcRNe
         jL/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780417933; x=1781022733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kad+hJFH4HQ37Yq+1PoPnUXlXvpaSHb2BKpUr92jwbU=;
        b=Yun7QQZ8EKwHPj7Vq3sdxVeZUYBVu649tnZx/+0hwlfDBOeMriBN+kLNPubINoq8JR
         Jk128Eu0C1/9w3ld7fS0FqID2ythFTy3QhJGIuTRJ2xQf6HbcuActXpKo9zsQAN/J8o7
         FoXywgTBMnOwHwZjiCwO3EAur0v8ylBy58q9WLn3VH2edG9TARu7eSEZvDatLk1NZotG
         CmwDj+K7evGfzd2c1kTu/Hx55z+PFNjykzg+ysAzcAX0pSV8ritSSiuj/A+wc4AYB6Vt
         Vw4ZrnIbfSEG2Pp9lYdwj79WzL3NBgcrq3kwZIA014+vR3SaI5CxPa3AHfOap/dmChwk
         T5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780417933; x=1781022733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kad+hJFH4HQ37Yq+1PoPnUXlXvpaSHb2BKpUr92jwbU=;
        b=sThCZBkND0QLD12ugtj3kpt8jx13fEZo1C8Nhqd1YBoeC2xF6mPEifGJ2cQCJJH7s6
         FGbys1qtHjfjucT6+fRzW3qzVqn3TbCJMfbCCVWArUqnu+90BM5uy36MjP4urdapymTV
         E/TAVGnElQgmRSLdVZUhz9kzZet8X8bGBL/YhIYAviVMX6+//HG/mxxiUkeYVe321i4k
         4mVoq8v8d2vd4kkekjl0WwuSZRo3FNIEqItIja35t++DiT9+mByvCdfJ+JrtUQ7fUZOV
         hhkwCf8UDToAG1saQ3PTcF0CPxJTlde1WkoPheZLRFR9y3Dq8FcGsMwwHuNkdhKZcDVU
         iqLw==
X-Forwarded-Encrypted: i=1; AFNElJ+Z5p2QV2fEK/z8+tYQC4XDCW2JXAa1bHwJlCvs9HfmBZZ0YwFqfw5XODS9EuR91/2/Lck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTvccE3eMTzP2eziRyvG3LaiV8kHoik8zfgMsZ6fcAEigwwJb4
	JbZc6nvAEZBYkbgwrXUPnAyKNgMWWzKXRPtKuRAsqFHZNTEE8fNYc2t3Y7uvo+t0uuX5BPArrHw
	uAGLJE7qyoc6KGzxO9yYhVwl8TMn97i0=
X-Gm-Gg: Acq92OEjwItRiXVIxBe+h1TCTPmc9WiryTRLOtjwhlkjdSoAQhDJnfjLCjz3GxuQL82
	2g0WkG15f8A2ooecMbACjYxsyax9fQ9NKUBbRIEq6ZnZurGDfPzhYcfUAW2BG58TYj69P+Vd9fY
	i4qGKiOt0zfU444xkCVLBF8gh0CKSXmYTsKEuXmo9gNNnC6YO7hs1M1MoCiidBVpyozuS0sAIY4
	xcynfRACydjohr8Rb/Pss0Hg/D8MHp0liofXl0Ou8keEH+7AzfRVCpNkpNwE6kMiSl8nJ+VmPNK
	dzIBsodpYJ0t+rRzPQ==
X-Received: by 2002:a17:906:9c84:b0:bee:45f5:3e with SMTP id
 a640c23a62f3a-bf063232792mr17119666b.47.1780417932504; Tue, 02 Jun 2026
 09:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
 <pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com> <d938ebf95a817c00a415670c08b839747d711d29.1780407557.git.gitgitgadget@gmail.com>
 <xmqqtsrlujah.fsf@gitster.g>
In-Reply-To: <xmqqtsrlujah.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 2 Jun 2026 18:31:36 +0200
X-Gm-Features: AVHnY4LdaApJBtvurgJCExwbJfi62a8YsUJx6LfH2Bpp1TgQRMfulG3YR-P0QHc
Message-ID: <CAHwyqnXC=F-ewFy3nejzKZcSNNe5L73PcaH+b30wg_BKNpStYA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] config: let git_config_parse_key() validate quietly
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"

> Perhaps the updated "git_config_parse_key()" in this patch should be
> renamed to be a file-scape static internal helper, and the existing
> "git_config_parse_key()" should become a thin wrapper around that
> new helper function, retaining the current external interface,
> requiring no changes to existing callers.

I want to remember a discussion on one of my earlier topics, a few
months back, where someone else suggested instead of introducing two
thin wrappers over a helper, we should update the callers instead.

But for me either way is fine, maybe here it makes more sense, because
of the repeated NULL/0/1 parameters.


Harald
