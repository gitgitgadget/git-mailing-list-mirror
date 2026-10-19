Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E137652607A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421492; cv=pass; b=n6Zf+320XKT3GacvjKF2tOzd9S1j9b69ViD2vy3qpyRkcHlsjURme8xrmwDxKqpsrEcmWvx3oEHdDyruSswqVmQEB8zLd3ixb0ZrPnqIQzh1tnUWbFfRA1fRdNcdun/J3RM2Zrbjb2qUOdEFVGXQLlO1oySOS6jXbOkA5ljYmB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421492; c=relaxed/simple;
	bh=yLZxgK2Zv2Psh/yexAF4jX0XuN2q32GbWxvBXZ8nSXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMpvGtUVgN8qYtVVc2CXODS4vhsMPsjKV8ikWsB672ql9be8p1Glri9vYMZ8fF9vQiOpGgfGvQ7r53KJDDpm8PayLYX1Od6s00iXiO9EaFodlsDI7wmtGPBO2dFxs7ZTQFCdyHVr0MfxrHNyq/tSFVcBfCx+6Uc3lILVjr+hDc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHQTMQJP; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHQTMQJP"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso2825935a12.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792421489; cv=none;
        d=google.com; s=arc-20260327;
        b=L7bBJ9iXjbXPSvB2EDO6eLXwcelDCVpajmZaQ/rrsNahF2TZ7T3JUz5deNLD/yTKnO
         FXqT4VpulDfBbatryH/M8AOZTonqV/G++xlORpguwItzQGxBj/xZ4oepi43D9scL+Exo
         pp4JoUgFKiAUeu74wud1gVtYRcPApU4vIxyGoCaf8PdgNjARg9SlPU6DNirBEueDLLqY
         Rg57g2ubQ1dmQ4YL1qFeNQocazcYrHzpGxCCC4XiD9d/V8gebpkxOElio/IcoKUXMVXk
         3tpovsZZ0ao6kj2RQldCqqZb4D8k3czCoCGT6vvf+R5nE1pjpK0BmI93aoW3wGQPJrs1
         y0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7j5nAQz7mBGcMoDXp7s1jAE7BmNmGp/ecKDMqPidLAI=;
        fh=M37SdqDTsw9dCJ0yoKaNPjyy/TUPycXk6rXd3dsrp64=;
        b=c0DjNp6p6eoHLNpLcMwf0TYixZURlUuOuyPbb6FcIOTygjuk1TDqxVyFz+b0OdxVDR
         MmpyH0KP8MnUTbN7DfrkLtsL4JWofqGZ8Ys4l4ci1VN4lq4ErV8MhFFPByaIyD+d1t5v
         anQh0yW/7qoD/Tj2gSlvUnh4C1UDx6l497R7vLknIl1dTRBPtYk0F+aJzQT6BfkEnILZ
         LPEw1Enpmn8HA6uONoZWR5+MOzpphpL1xYZbVupAUjZhU7YJUp9kwpYEWL5qqHamMuT9
         zMpcKZXYe6E/U268S8Md71iSRvqyPQXO+/oQbZcTsislRuGKjZvOnPZxiMq5a1nxujoF
         ujrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421489; x=1793026289; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7j5nAQz7mBGcMoDXp7s1jAE7BmNmGp/ecKDMqPidLAI=;
        b=WHQTMQJPkzz7ago6nzv5y3Zrk0O6F9fJYWNd78YOuyiFVDZsux6QkOW/wf2zklz+mo
         c0j/gKtq1l3HEIYGYs0WgV0ZZluAbBFPI0A6ruCqbSQ14tR2y/2ej1cWKDYQXkZiHBWf
         MNujiRRx+t6HN3Q7+l3bIpNiZxEn+U3w7z+iafYsR28yjKy7fXckim4xtaAlN16tn/xt
         03yAldsbOHK1QmqlJYpzEj/pbT1w0HawHYfPJrKMb33dPOMrU83J3Orv8zX7cAERWgNI
         ACdDykiG15fg8c8wavNDfP3U2CGMhEIZshkhChe4uvsN9rE8ZtKbW4fEOySl2RFBxUWd
         uZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421489; x=1793026289;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7j5nAQz7mBGcMoDXp7s1jAE7BmNmGp/ecKDMqPidLAI=;
        b=Nyfk1znxOmHOvBjtL+FfEvPiHf3ipPqYe1w9gG8QFnk1cluf2XynH6vt64WOd25TKR
         L6l0sqKPi0Q9nZggyuGLzLIjMNV20I2zfoJoHJTiCgx3Jq67gqv7Jvd90n3+q/UgiHPI
         HQkKXyJG8N9uUakgHJNFhIPCjkz3IGb/gnmEkrHEIBMEvNJn7MTBvUI2EYf8vpjJpdLX
         KFwmpbyBSx45FYHW+5LAIAHhC04NnPg0fEr4TyKHVIZSJ2SjEU27gk3VHU4/QGCGJdPy
         sa86SSa7KS2oZJ6aQnerUZyjoEVRIqP/dacAKY2/kTrabhez7OZsPqTLa3tZGmiNG7xQ
         o1bw==
X-Forwarded-Encrypted: i=1; AKwUvBxV9GFxwqnQKHssf/bVVlzsKQAVbzU0/AIfI2sT9tGXNUmm/4WHRCU2Wz9qekk4TdbvFp8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO43rOCcxDQcVlllOUbb1x/V1Su9Tl5A1VYgCFlgRfmHLGYmNs
	ncAAY83xie6V+KxFyTDMVGpt3HCzutQNeJ5VC9wUuPRzqay2Oq6lLiHM1VpLji+JQNg4G1CvBZ3
	ac2ADsc4w8ohh+oK20yqi1A24EGAfYbc=
X-Gm-Gg: AYBFou2I+rIowzmvRPcIk6TZGQZFUDhT4rkrhm3BNHf8m2OyeQypUFmWsz3RT07AxZR
	VGsuqOoYJaV2/fZy++Yg2u/B7f9Ly+5rEdfVS4WobQqb1E14fRbWmxbrO9oqZXuMaMK1seBBz4P
	zsBu/xuM2uPWt1caXPEQq20kaLvd+C37YCMAglIBUcF/Dh0Px0U5vlKbZ8JuXl0psSj12YCSLSj
	vrFaWrkUn2Xxy2hheW995HJC9PK7mN1bgY5Ofo+bNtchf8aQ1krHqqUUNY8sfNYV+r0lQUB8CtK
	0MNmqfeYvPxGuWovL+1KiEqU5/3Dyb2+FRxC0iemgsjY965r4nnlZ0E=
X-Received: by 2002:a05:6402:5c6:b0:6a5:f4eb:df3 with SMTP id
 4fb4d7f45d1cf-6b3a8100dc4mr3028793a12.2.1792421488893; Mon, 19 Oct 2026
 07:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2455.git.git.1792275106640.gitgitgadget@gmail.com> <xmqqpkx57rcv.fsf@gitster.g>
In-Reply-To: <xmqqpkx57rcv.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 19 Oct 2026 16:50:51 +0200
X-Gm-Features: AclHuK_t87F8ztSM4smkU4Y7gsfkp2okUj6EKsG6FSIc3nIj7eUYm8v3eyVba4Q
Message-ID: <CAHwyqnWw+SDy357RN2ENMgThBfhZY+V_Vr7zR9HdR3DaGKV0cw@mail.gmail.com>
Subject: Re: [PATCH/RFC] upload-pack: fix slow fetches from a shallow repository
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The advertise_shallow_grafts() function is written for protocol
> v0 and uses packet_write_fmt() to write raw data directly to the
> named file descriptor (in this case, fd #1).
>
> However, protocol v2 negotiation uses the packet_writer API.  When
> sideband-all is in use, the response must be multiplexed over the
> sideband channel.  Because the updated code fails to use the
> packet_writer API, 'shallow' lines are written without the '\001'
> band designator.  The other side then interprets 's' (the first
> byte of 'shallow', which is 115 in decimal) as the sideband channel
> and dies with a protocol violation.

Thanks for pointing this out! I'll take a look!


Harald
