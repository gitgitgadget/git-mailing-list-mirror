Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0603ED8
	for <git@vger.kernel.org>; Tue, 14 May 2024 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648104; cv=none; b=HdZSlXd3bCVu25h6Odp5B9QB57Pdr4R384f7GjzJiYK1FA7/+u4hqt/3tUOxqyjxBsHFf3F16x41c1ilia5NwgQbEmClFK3ymSU5SjRIIFycJYKaOsd9lchZCpADfOpfXd9K7gOpUn6KGrxe/FfQAJK1IOoDURqM5UwJECFzUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648104; c=relaxed/simple;
	bh=JO0ekxrR3WJDSzvSkFLXrkc50qvAkz4Mis2c4KgbyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppy669z8rwON3hvUHsAUxq1eE8Y2nZal1MyJyGO1Z50Zt3oTVz2Wc9SdPDcEk1AnuhF/8hBv5/Ev9uZ/saQiudYrGZYgaODdzcNaO1OVnPfUY+IGBrCR83+JGffEeZ0dO4Mu2x8MX/qEwDBl+BRyfZDrYbmFhCYafr5bLNmMKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aUqiGGF3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aUqiGGF3"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792bd1f5b28so512034985a.2
        for <git@vger.kernel.org>; Mon, 13 May 2024 17:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715648101; x=1716252901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ92HLaXPyBDth3Sg1qCs/Hy2nI5rqhUqehHQ4IOD8s=;
        b=aUqiGGF3apDI7KXTLIeyoBRoTw0m7YSkcR5ndohGW9ywNpifHACgrygAsUTtO5A8VT
         20Ku7bwrzp1+Mc2/p9hX8jeU1wRqAXVq/NjHh+VqKMhqRTJsuB9nBfhvzYUt1mfh2G20
         j+APvAZ2yiaz+T831YIiIcSsouiv/klDKrB1/lbFv8hvrrFyTpLB7IacZ+vbYqhHECE0
         J2KY/KiCAwdmmnQcOyCaBSbNwp6dAnvZrk/YiaUJPwu6Inpb3y1LxOmpVC2nB/lBYS+g
         Uc4tW+iTnxUfG9nNlP0w0kaSog3B4wFXEXQKD1ltcr7Pfvf5wc5PLDUNca5O0YXWRYZN
         D3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715648101; x=1716252901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ92HLaXPyBDth3Sg1qCs/Hy2nI5rqhUqehHQ4IOD8s=;
        b=bHFajp3TJ7SaEyHRJ25bRmz/+A8rwMj6vkWFzcwPt0h0EQuLsPwbBp9MD0K6NoIxHT
         ltgFv2C2BYEi+4+A5MFrz3lS7EWts2iNgUAuzRVMAzavdp+MOhodftu87OiiDcj550bl
         wKGsOeAQc5gxC/hbsDfAaTxe4QwZVuoEsDqSoibzeQqKXuy6v1feILhP4O1wu9Qq5RLa
         Dn0tS6iK8fHjin6Yls3nI++QnRuEr9FH/+/vBTfy00ZM5C9Gakri9xVIsgvhmp1+oCRF
         sVI2EMwVSex0W6i5QseQQl9sBr2yd1eU11tCycEb0Ac0p/SEMvyFjP042MN1iocL+y1d
         bvbQ==
X-Gm-Message-State: AOJu0YytxIkWEe1my5PF86+/7R8Eek9S4P+uyQRJyv93oG2O9/A9s7uj
	Z3nQ+cu7XPtO2Msh70zh9tODSBp0V6kIh3JhzCRAy7q/MuhGz1bTFA+i6+SPd84=
X-Google-Smtp-Source: AGHT+IFeq684nCo2zHbv0smCixJolFXQNITY+tehrOEIuf8BmrboeA//Hd2TlXlIucEk7SGoQ07l4Q==
X-Received: by 2002:a37:de08:0:b0:792:bb2c:9737 with SMTP id af79cd13be357-792c75af7fcmr1311140985a.40.1715648101361;
        Mon, 13 May 2024 17:55:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a45b5sm508408385a.62.2024.05.13.17.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 17:55:00 -0700 (PDT)
Date: Mon, 13 May 2024 20:54:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/23] pack-bitmap: make
 `bitmap_writer_push_bitmapped_commit()` public
Message-ID: <ZkK2Y06dgyLanNEA@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <dfd4b73d12edc1833e5090c956cda6f28046c9e4.1714422410.git.me@ttaylorr.com>
 <20240513185055.GB2675586@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240513185055.GB2675586@coredump.intra.peff.net>

On Mon, May 13, 2024 at 02:50:55PM -0400, Jeff King wrote:
> On Mon, Apr 29, 2024 at 04:43:22PM -0400, Taylor Blau wrote:
>
> > The pseudo-merge selection code will be added in a subsequent commit,
> > and will need a way to push the allocated commit structures into the
> > bitmap writer from a separate compilation unit.
> >
> > Make the `bitmap_writer_push_bitmapped_commit()` function part of the
> > pack-bitmap.h header in order to make this possible.
>
> I was a little surprised that this function and the one in the previous
> commit needed to be public, since this whole topic is restricted to
> writing, which is mostly contained to pack-bitmap-write.c. But you've
> pulled the pseudo-merge bits out to pseudo-merge.[ch], and they need
> access, which makes sense.
>
> One could argue that it could all get stuffed into pack-bitmap-write.c,
> but that is already getting to be a pretty large and complex file. So
> this is probably the best route.

I had originally written the series like that, but the new bits nearly
doubled the line count of pack-bitmap-write.c:

    $ wc -l pack-bitmap-write.c pseudo-merge.c
     1031 pack-bitmap-write.c
      752 pseudo-merge.c
     1783 total

so I ended up splitting it out into pseudo-merge.ch in the end.

Thanks,
Taylor
