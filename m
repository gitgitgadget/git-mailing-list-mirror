Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2F210E4
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717947089; cv=none; b=arn+GUBY7sPH5uoRehGNBxLiHDX0f9Txd9LoqDqeZFMhdpDZsuHHTikCsDkzqo+c3su0ScYIuyL/0Y5ce+ZTBBIgtLhhlhj0wjTTSISjU60UZPSO+084K1vvlqO6WzUA0wFdE10UQPoAB7u6p+Q8Ixce/focVaicu7nxUFlRuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717947089; c=relaxed/simple;
	bh=cQNH054FdJgNbFLWc/6HYJwSkjMjoNE+vwESyqvWnY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6MvfeFp0i26OztjPhimRO23I67UWBi8vAjMxNyZZwd3NvV1Q1vXCwkBASL9B2SdD4EnIdc6Zk13DOMUgBaG7JNyKANJywcrf9pi+ieXvi3d9ORbiA701r7n1WcO4FDCR3gsRSMAozgffyiXvH2KLvNpaRJ85THc4ZJlhrU4Lvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=A42ULfpT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="A42ULfpT"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7960454db4fso8033385a.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717947087; x=1718551887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IK+tUi/Fksvtpdm4An/zHyYrTGFwVsoMPNGiG+GFENg=;
        b=A42ULfpT8coTbR9T1StfoxvQ7Q7AYEutcWEC7CHZqb1xZg6JEMGP7ijwIUkjQnhbOm
         ETtN/bMiRcnMjcZQ57rsuieCxo0zDOVSN3M+VHp/iPAX2kkW0sswSLYzdHZwiI+330NK
         AcPUTss2tPcbBPKVDSTXbn6QPrMsY4nMFB6nfPUAIUe5m+ohcxh7uHRCuXj15cw6Ve2E
         gd3PQEjprNsOxvWcOucfj7BS61OJWSiBwcjHqfZ8XyeYBD3TcFafunvrrXKHFjGiPdpa
         HxawT1V7VPPF9BZ/yWvrn8QJ0qCRkhuMquLuv8mNbgyfaM1zQS+WOgXxYwZKJ4C2Wklv
         7Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717947087; x=1718551887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK+tUi/Fksvtpdm4An/zHyYrTGFwVsoMPNGiG+GFENg=;
        b=xHEPweheEJxuBhgoGUgpjwXzpImuKzAlXbct34e0ygIIMNbGTuJiZ7/UVEYXxmZnHp
         4hXUVYvcO3gQpvv7ICho5R+Sw6ui8sVPJb1nJ/ibU19lLK08+WGj4UscgC4PLVpGBOOf
         jPuXWqfR1EXpGfVIIzcJ4dIqC+fTrZKtJ+g4y8gl30U8cvee5IaCgbuzEvaGxQz9/UMw
         r7jn2g/PwePRBgr2ItOkancqDZMLkSdni/LNSYLKiMzhaGbUZpLFSTvMqB7mCV0JXdxZ
         a19QE21DVOJMlr+Q6E6PVnh0BoLqezwW7bg93E0XErkbeJJt8iXYhKN8jnqbTYmRAeaK
         uvpw==
X-Forwarded-Encrypted: i=1; AJvYcCWLGrP5zQdeucmIl4bdaU9Avvu/s1Sx96v5TH8vguNqIgFjziGVn+mLeK9fzWFnDMszfzm+iWZB0Sb+bEi+N+FbjoUs
X-Gm-Message-State: AOJu0YwuQFHmSVtrA83akrMkai5bErVVe5xnZid2iqP7OaKzblA1yFmi
	/6PylAMX4ROSR77PlQ4/ZZx47Mxobsz84YcuF4uho4r6hJg8qWlUplahgRABmGLyGEffu+y/5UF
	mlXE=
X-Google-Smtp-Source: AGHT+IEHWUOw6coJd/oebNg0agjIq+Zd13LCBms9bnnSpoLVO+SepnhaqNpG8y5S9k0j6hyeW3GiEA==
X-Received: by 2002:a05:620a:8521:b0:794:cdc3:949a with SMTP id af79cd13be357-7953c5c6fc4mr698468685a.78.1717947086811;
        Sun, 09 Jun 2024 08:31:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532813a67sm346356485a.9.2024.06.09.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 08:31:26 -0700 (PDT)
Date: Sun, 9 Jun 2024 11:31:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Kyle Lippincott <spectral@google.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: MSan failures in pack-bitmap
Message-ID: <ZmXKzJ9CpbYTmTwC@nand.local>
References: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
 <20240608081855.GA2390433@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240608081855.GA2390433@coredump.intra.peff.net>

On Sat, Jun 08, 2024 at 04:18:55AM -0400, Jeff King wrote:
> On Fri, Jun 07, 2024 at 07:43:56PM -0700, Kyle Lippincott wrote:
>
> > I believe what's happening is that pack-bitmap.c:2091 grows the packs
> > list and sets up some of the fields, but doesn't set pack_int_id. We
> > then use it at pack-bitmap.c:1888.
> >
> > I investigated, but couldn't prove to myself what value should be
> > placed there while growing it, or if it's incorrect to read from it in
> > this case (so we shouldn't be in pack-bitmap.c:1888 with this pack).
>
> Hmm, I'm not sure.
>
> In reuse_partial_packfile_from_bitmap(), the code path that creates the
> struct only kicks in when the "multi_pack_reuse" flag isn't set. Which
> generally would correspond to whether we have a midx. And then the code
> in try_partial_reuse() that uses the struct similarly checks
> bitmap_is_midx() before looking at the pack_int_id field.
>
> But that changed in 795006fff4 (pack-bitmap: gracefully handle missing
> BTMP chunks, 2024-04-15), where we also disable multi_pack_reuse if we
> have a midx but it has no BTMP chunk. So we end up in the non-multi code
> path to create the struct, but then try_partial_reuse() still realizes
> we have a midx and uses that code path.
>
> I guess this gets into the "we have a midx, but are only doing reuse out
> of a single pack" case. Which I think is supported, but I'm not familiar
> enough with the code to know where the assumption is going wrong.

That's right. We support single-pack reuse even with a MIDX either (a)
because it was configured that way with
pack.allowPackReuse=(true|single), or (b) because the MIDX has no BTMP
chunk, which is what prompted the change in 795006fff4.

When in that case, our reuse packfile is either the pack attached to a
single-pack bitmap, or the MIDX's preferred pack. When using the MIDX's
preferred pack, we need to make sure that we correctly assign the
pack_int_id to be the ID of the preferred pack. (We use this field to
reject cross-pack deltas later on in try_partial_reuse(), which is where
the MSan failure is happening).

The fix should be to set pack_int_id to the preferred pack's ID in the
MIDX case, and an arbitrary value in the single-pack bitmap case. I
posted a patch which should fix that here:

    https://lore.kernel.org/git/4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com/T/#u

Unfortunately, the regression happened in 795006fff4, so this is in a
released version of Git. But this is all behind a configuration option,
so affected users can reasonably work around this issue.

Thanks,
Taylor
