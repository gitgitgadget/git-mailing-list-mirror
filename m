Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5A1FC7
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768743799; cv=pass; b=jSWG2yamlqby+2z3uqW+I3vtGA87XEcq7uWUPuyA13rZJU3Twm1wYWdGngvKsKYV63EiN8hvtFnkkPDMB/6wrae5tlM+1Kp2OPftpyZh8//07LDFibiqCkGlUOWlHqH2vuEszTx9BJLUb2xxsiqNYuuq+hu+oJww4ZQNni1HDWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768743799; c=relaxed/simple;
	bh=lxTMUZpsc1dMmKy1+LbDSIWZSDJrA1gtWczfZkJYNlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cto8fsBk/hfGboBvXKEO1oKnN1veDREfAhoKHbEoQ7L5m0O2lb+AP21yqL1QJrvhADlWfqYFmj9fMevOn4cp6JACcNFeFjptj0KKv8sJGUi/KTygKHggJ4OX5wzeNmBW7b6dc31yGHyMFMmimvcjWqVA6oW08Uh8KtB+Jjb22i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H91j6nXK; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H91j6nXK"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430fbb6012bso2725143f8f.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 05:43:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768743796; cv=none;
        d=google.com; s=arc-20240605;
        b=kxsfBVXB0rmtep0QSFTawGnBs7DIF7wy3AyH84ES7jj/UmflssE1vsF9f3Nc7EbzIg
         e4uVOHcpHiRZ4TaliCJdwhXOuSM4UBc7dbZVU+icGCD4KHjLy+/9pizjkstZmWZ7VCrw
         NixE94wzDqwcpPQedZCbZueG4cIMoiqLzo5Wucmh/TK9injt8baCpp4lJ1a+qgpDNkKV
         gm9urX5V/Yj9A8gz9uaESjUpkJNVaBIm4cLWvOMU9ZR0mkzcxHgPBTrzb62rhS0KJsvt
         lSSri0XBODOmphSx2Xk3GCyLHJYRd8gz3K7+XBRCteKqziczqwbvE+XMzQU/7lXPR1ZM
         iJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lxTMUZpsc1dMmKy1+LbDSIWZSDJrA1gtWczfZkJYNlw=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=lmyQ+f5qCFr0yXGlkoxA2tvro7LPSuMGIVTtRWDm/G4okjx+tl6wHnxHotVvrOGptw
         E+L3zZylgWOKTwCrayLCL9lxNrY4vGBfKS29036sIRTGPdGlGfv2OOgl99VGVUY5l1s2
         qh3YOK1GKVg+tvtEjxAfgWbCK4XPxDpnqMoYh/rG5Ezalbe7jEHg85wnYtT/fKb1lwNt
         oNMS3rU+Ue6jyl5uMeV8fywmlHkeE35nFV1LgZqtABFhMBM5rxz4b8AQzYlz8kV6Agoc
         6rM1w8Hy1U1R+0Lz6YSCc99zxZn/VyTMswOb205x3DkFcIPu6n1UqTxyOjbCexySa7Ng
         c2PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768743796; x=1769348596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxTMUZpsc1dMmKy1+LbDSIWZSDJrA1gtWczfZkJYNlw=;
        b=H91j6nXKB/kf2vCWecPuy2kQXyfR4prFitJnvLgcn6iH1JFQZpvsXcKGD5WWC+9hGF
         mIccFPwI6Qua6yG+REMUpYhcJC237N81q73GOYu50VMquoT2hdYhgcatz7SaABvUQd60
         fp9qBuQJ7g8mmfr7DEC1HQjEdp0vzGOUU7uo+lm+KWZ3rV31YkAgsDruXZayl4wK9g3R
         lHWpAvKaEfeF6Yc3cneHpkQVZ0Ywr9K/rnv4juni1y+1WuklGQQdK+orKfr0xFWeWVFF
         24XZ9lWYOydTw88IAH/aawlNWc4e/DwiOoc5dJS0ou8RUAABe7AKK0+hpl7AfdZajCX5
         w41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768743796; x=1769348596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxTMUZpsc1dMmKy1+LbDSIWZSDJrA1gtWczfZkJYNlw=;
        b=ewMthwXY5S9Y97Jqe8hSWY+wkFOYDgkqDLAoIOnA5YLN1jvDMSCFFCJ3L5BfafkGvI
         czMlOOVdWKtq3keRoefuIH9Tc1M83IoRa50H7EzTen/PHnwC7ujnLKidT56HaL1/eEv3
         evJwzdLRNCyUWkI6qqvmWl+804PyUir8Cv8+hvVCDPxEpaG8af0fOEkbMrBAvql+xCsh
         ov1LhZRHuQ9SG8PD6skn5lZKge0h6vzxmzvXxz6k7+EGCUW08IL/j612NRvruxbKrn3m
         hf6oGr0hAoSL+UfUdlwRAKD2gKCf5fg6tXwyXxkE8PuU3QqqZoQo3kqSj7Ax1ECi1Jp8
         XH5A==
X-Gm-Message-State: AOJu0Yx/pjqjuGv0lOGlZXTW0SBitT37CQLYReaGwsmCKjrdLlZipd+D
	atd2SaWUd9sUr3a8MxzQR8aDSKRyLIqrD0mo9x4gUQlR36cnsKhvurt/e/VPMiUPyMiveyUbSct
	sBRT095GyV1bLV6pyWDl1IWEWH6AiFuXcBspt
X-Gm-Gg: AY/fxX6PDgMG/QggmjFqPCQGFb1F6F1tXS2nzRqbeFFDRv9wPPJN3qjeU6CQR3Thoja
	RydltfOW69VNp62Bk3cpfL8cRKBp+dgfyplqYCFt5PcvVTBgmcMJ3SZgAoA7I4VpXO0PCjJOMEd
	iGbS5ub3FVqUxXAOKNzAAwksGq3Beu57PMTyW6nbvGuFTP9rQZzDZ4SmyyQsgmf9aVUFkrt+Hgg
	kaaIi8FgWmVIul9KHNf56NvOMJ0mQX6cg9b5jDt+o5zwcWXMCESx6pNKvFI+enI/cs9kp4=
X-Received: by 2002:a5d:5847:0:b0:434:24fe:b25f with SMTP id
 ffacd0b85a97d-43569bbaf29mr11178651f8f.37.1768743795760; Sun, 18 Jan 2026
 05:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldhybtqs.fsf@gitster.g>
In-Reply-To: <xmqqldhybtqs.fsf@gitster.g>
From: Yee Cheng Chin <ychin.macvim@gmail.com>
Date: Sun, 18 Jan 2026 05:42:39 -0800
X-Gm-Features: AZwV_QjL7n-rAg-575KIpwMyBhpzUN0hSIBZOCUuN0QSJfqMkW23rUsvh3nek1M
Message-ID: <CAHTeOx8z4bG2OmPCc+8pCHBVeUWPmxgaSqz=jHL+H=VRHx=KAA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2026, #05)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> * yc/histogram-hunk-shift-fix (2025-12-06) 1 commit
> - xdiff: re-diff shifted change groups when using histogram algorithm
>
> The final clean-up phase of the diff output could turn the result of
> histogram diff algorithm suboptimal, which has been corrected.
>
> Will discard. Has been waiting for further comments for too long.
> source:<pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>

Hi, I'm the author for this patch. I'm still pretty new to Git
contribution, but what kind of comments are you looking for when
deciding on a patch? I noticed that my patch didn't receive any
comments, but it was essentially a bug fix for an occasional
suboptimal histogram diff result. I would imagine most people would
not have much to say given that it was not a new feature or introduced
any breaking changes.
