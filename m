Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C125B08C
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785007849; cv=pass; b=fN0Cek+nTtLowNSS3g5/ntphUDq2AbzsDOC0DHhfJoY28Tg2vjMvT69sHjEcyaq1USL0Gd0mUXHA4Uql2ZGAE79n2npu8ZoVJSRvzWTBZ2p+3t5prajZeko+2M17vQhHZ1JnBqkdWKppFHAJx0hrJkCUr28WRid9ryLYE4jqNbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785007849; c=relaxed/simple;
	bh=rMIP2hzmIzx22LKV0Fa/iBVIzYWXlknkOJJzawBadtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqaEL67IqV29cfmJsDJwfTWert9n5e0FiS1Ph6M1lW4xz07hQ+I4DMvOc0eghpJLZGjAS+VZsH/Uan8VqR9aREL0G5mm6X/VGBXL+7V/d74GDRNB7Tz4zSqoeWBE4wOVJ+pjxC0YLG8Gx3KoNiqOyuf8FgRLkrUR1icnQDxHrbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no/ovpnF; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no/ovpnF"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso1647613a12.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 12:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785007848; cv=none;
        d=google.com; s=arc-20260327;
        b=I+Mg8J+sZcwmYoBY11dHNIhaDwvicQlfsAe2ULuo26nchlvzv1rJUAilzyupmTxcdV
         hJYxihuR3sv650dj89Zt6RlUGAmQpu8zgO3bbmx+2i2ZEInDtowIA5sDEwuKgGX7BPQh
         7wzrU2/6bJzjZpnLaW1cgU6rzjr5EMK+77bKkdLxzXGBZtL/S0mxqAwzIV2t+ninT0MF
         LnOjQ7E32JDq0oXLVILnjksPltoGfcDKb6znmwkVHBZb4IeggqmXOmqVYAkE3Wulvhbr
         Nr/k655PXSSmEuEMysY5o663iuKiCBYw812bEbp0qCWhYtj/gRJALGwOUEE6hCO/CtGa
         p3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rMIP2hzmIzx22LKV0Fa/iBVIzYWXlknkOJJzawBadtw=;
        fh=rxXce4A1BYmBKDcyAP6CTTeBLAKxymZR1D9vVH84xcg=;
        b=McHxXOgQ9ljxC+aUj6zAskB+JrzEC+D//9/D8e/uPu0Qce0lQ2AaC/NFc8iloss7Sv
         UFa3x/wbY5bvRKlVykFb8RFRXmF1jNki6r8RrVViMvOFf5617pFbd2b4oDkrRkQxO0on
         Z6RGiNikN4Nl39NMDCDs4n910ERgVf+j0bE3D+m9Fw3FAJgX7xAUWqubsR238GnjHB/d
         hMT44St5beqNPzxf8bv/ENAFNotHpZAHAv/BQho2iAX78VhiUw9hqEkT1OJR8rQryZ4E
         mLasgSOpmaTBXOhN9lUW9ayxXqm5PONbuZD+jJR47oSBJmA7G7tXC5Vfnm0D3mZKKnD5
         xnxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785007848; x=1785612648; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rMIP2hzmIzx22LKV0Fa/iBVIzYWXlknkOJJzawBadtw=;
        b=no/ovpnFdC46so+LsFYvHcpd4eCUWvUwxhqahgQ2cOXBdz3zc7FDeJZXDLue6T3mG4
         qaB08AUmZCbhG09M89lzHBf7SHgwccmcQYtFHsEa73LNCeslHdbXad5fWKqEotVYHLLR
         u/AXz7cQTVXuicdhwjt1KhwtcWP/NRcWv7HoCwHjN6h8haKhExeEJFW9d7lrqdDzeJr1
         fPBKsNfGP3ZQa7e8rSH1m7mGl3FDupSD8lYIGddiy3uBwajNT8hOLKnApmUurAv2uX4P
         2aPDM45Kef/P5DIxvy+D/2ExDnVDMJY9Ly+8z4TjvUC2bUE/OdGFMWntIRRL64j+Cibl
         UwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785007848; x=1785612648;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rMIP2hzmIzx22LKV0Fa/iBVIzYWXlknkOJJzawBadtw=;
        b=D47Va0aIXBv1+VlO44pgtwCjJQGuU8IaBXh4a4zwSAbA9Tx1YRfA3iyLXFIRFZbF9K
         rjwFv/PMggrOxn8NcgJ19XuA9gpSdrzA3JUY71jiXOtc6StNBXVOfuvUO6YC3LTF48zJ
         LgFJEc64S/wlujKe/DBch1WZazjq0qmThJPxtaQfBTopzVD8A8OZ6s1Df77AT6PEb59v
         pF/Wxi23vE3gu1BZU5p9dlN2GWrTZRvDraKMs/ZUtMvVp7RRF+LNfe70TqBpKUOWAXBo
         PfDGtluPHqSUWGjEo/zgn36h1eCTkrGQYBvt2P2TwiBkO3Ij/lS036FiGp85nyc/Srb5
         kgTw==
X-Gm-Message-State: AOJu0Yybd+X+RqnfKUDgRod2oFedWxsR4RbhNUQOWXy7Vd+LyzYK8OvD
	IUsjMOSKgJIadQ9vRD6qZhZEBYjTRDhXl6Ca6gHaKsKDs91X9kh/wIVLDxMrNxjYO9P7Nhjwucf
	Fjv89RrmjViXi7He1U0WaxcTf4pO2p14=
X-Gm-Gg: AR+sD13bWR9jqokB3rkBFQvBFrWrAiABkeG2JFb5YR/NL3d0ufJELfMm5pvJ+lNX7tw
	RQ58SQn/rdXOlez5ggewVOIo5Tb3ZiqNfpSU2NmVa2Y78lMLQJ0+XoUrGDY4e10/ur6fbw8T6W1
	TQknFIGSHQqpNGwdMERB9oWEbchT6SUk9LS4wH4zDJvX+LnGLA9K4b6oKtPBTTwRVFIipMQsxxl
	x0sVzmCudISy2FBefT2i/THKKY8el+ebpbKfECmSpylk0+VicC7GqYwp8Ys1TZ/+PA8X96Aporf
	8TBRbYppDMiMk1NH6lY/n2z47b/iF1YfHXrMbFVB4eZIWEr0ZTW+moibi3WNtpOxBa0SDbMUEvC
	SMpHwJg==
X-Received: by 2002:a05:6300:8811:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3c6723f7bf4mr4637310637.13.1785007847668; Sat, 25 Jul 2026
 12:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260716132848.95982-7-r.siddharth.shrimali@gmail.com> <ec546f71-3412-47ef-a4cf-98558889a90f@gmail.com>
In-Reply-To: <ec546f71-3412-47ef-a4cf-98558889a90f@gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sun, 26 Jul 2026 01:00:11 +0530
X-Gm-Features: AUfX_mx5g_A3Ho9BhNjrMS5hjiZz1zEvqlJoDfhHwzTjFwF5oKp53NmDoBOI19c
Message-ID: <CAGWgyh_cNL=K-8JceMqZ6C9aEpKohnFhXEBxpMecnsHyoW3xXA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] builtin/repack: actually drop filtered promisor blobs
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	me@ttaylorr.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

On 24/07/26 01:12, Siddharth Asthana wrote:
> Yes, without that the drop would not actually reclaim space.
>
> It would be nice if the documentation mentioned that a real
> --drop-filtered run implies -d.

sounds good.. there is no git-repack documentation for --drop-filtered yet,
so when I add it in v2 I'll call out explicitly that a real
(non-dry-run) --drop-filtered run implies -d.
