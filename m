Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B71C9EDD
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543851; cv=none; b=YGksAqwW992SRP+Pk0KwJRBED8udfYHZWCjk4sUO2glTAUynsG5Vw5T2bkwaLxJsBTRpxpUMUPeLj49DFhJfDOMCdC9RO3uK1ppbLXLffqj4Xql0aE7NzhushIURlczRIPz7+HwfsTXFgsSNEs5F0GgJw0ddH97kDCfTTTMrMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543851; c=relaxed/simple;
	bh=GXaWX3XgTgPfRj3PjOc/xiA0dllZhsvhP/sj5mNy6CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESekN4wvNcvevvfyFEuQYTURbg2URG53rjhteAV8la29ixELVVV4l+dnscad3Y1SkziV9b83dIAHgr7aUiLyqVDzmwvnp3CGUxnxXXru5qmUmxrGVt3g0IfLqfuMPcahvjyWgAwOPm/TEwm0XZ2OpJDwQ9V2DtQhyGJA8w8j/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2zTBtYjK; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2zTBtYjK"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e5a5a59094so46687217b3.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729543849; x=1730148649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qW4RJzs/68aleuIFmFOTph9IgK4Ei1mbPzISoDjjDHE=;
        b=2zTBtYjKBD7SleqBkdaAuMZyoXJfGGsiNLu3ccWyqO4cIlIgHb12mDYGa4bcJ4Txg9
         PEV0U36+GOb3utyueQrKGib7njOQRE5rvK1yNsUaTmUqLAoGJrXfb1zMuoGiz0rPsnLT
         1mvilJImE2mdPkQWO8bRMvdU9M0r18+OLeiHL3+iurYZwVzIoyCUlG8jpx5rMMuemHCc
         VQFF1HaxFQqDZlIK4jfYx4WeHwMuMBZzdFCJllqbA/P+yw87qDIOb1Wfca1UqJfaZhff
         Rt3h/brj6u3DPTCTg2XWhfr8PCJeMEEyYgpelVIdTZbe7GU2k2Q2GfTZT9FfzwT8GjuJ
         FTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543849; x=1730148649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW4RJzs/68aleuIFmFOTph9IgK4Ei1mbPzISoDjjDHE=;
        b=ZBX7fDhKPJwfCjCoEGNcwebtwgllguOsAV8g0STH8pr49gzFt2HKS3pZFssbgV/3Ae
         0WYPbjQ/etDJgZG0u27jr+fxzoVi11choXFvzqch/8BEq8HnkV2M6GDWqAUNox1HlPU1
         mxxgWtXLS7s9+7OLeaeoKwlnX6JuA0YpHziW58hLWF7UfLVG5yddhToa8HqsF89otH4J
         zqco9+rfJvdjjzEkiMIWSiZspthV9kZsHbDnsJyIBvj4VyRCobQKK3L0sAydxGmWGEJ2
         EfDYhUXxuiaa0IK452SVQLxWPxUp0h0o9GqK75nlCR4s4EhZyJmPs/dypnQNlgX2Giab
         W4Bg==
X-Gm-Message-State: AOJu0YztU5TW8mOOOgroDg9dofMw6RycvOFqLhOVCEZq3TSthE0qqBoe
	vFMYXLxC12RS871rcv52RET/UooFst/Uoq+gPBNxhcc2Zv13KgXCmEuCiDCRhio=
X-Google-Smtp-Source: AGHT+IGyp0a3k/zszBxSSnlsCg+bJSo3PXtQZB9wYssp3vtmrqmlSUdjD2yj5SThrEYiqB+bUQrwpQ==
X-Received: by 2002:a05:690c:6208:b0:6e2:7dd:af61 with SMTP id 00721157ae682-6e5bf9a72bcmr117494697b3.17.1729543848966;
        Mon, 21 Oct 2024 13:50:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ceecbbsm8205557b3.110.2024.10.21.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:50:48 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:50:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk, gitster@pobox.com, bence@ferdinandy.com,
	karthik.188@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/6] doc: update-ref: amend old material and discuss
 symrefs
Message-ID: <Zxa+pvRAbqhmIZxy@nand.local>
References: <cover.1729367469.git.code@khaugsbakk.name>
 <cover.1729543007.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729543007.git.code@khaugsbakk.name>

On Mon, Oct 21, 2024 at 10:47:23PM +0200, kristofferhaugsbakk@fastmail.com wrote:
>  Documentation/git-symbolic-ref.txt |  4 +++
>  Documentation/git-update-ref.txt   | 48 +++++++++++++-----------------
>  2 files changed, 25 insertions(+), 27 deletions(-)

Thanks, this version looks quite good to me. Are we ready to start
merging this round down?

(I saw that Karthik had suggested that 'v2' was already looking good to
them, but it would be nice to get a similar ack on this latest round).

Thanks,
Taylor
