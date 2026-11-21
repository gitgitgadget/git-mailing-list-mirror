Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795277879;
	b=jOJQmtWmUP20fdM3rzQVtRcn0O4nOqGyImSOSnhWK0G3qCOCx8qho8raixhJzKoeQpZY
	 jI8ZqGzTRs5xuTQFR8sBjJhfAdQDPYQqT5mMi+2CWmh7wCafF9BBVo8TG7yzvxnQ4s/Wd
	 3OSDTWWkvpF1IY4rg9o1NRIhBYT9AcwFeeoKvYcPOfs02/9lvPXocODnprWJJ2OzsKtgx
	 e0PgzcoGgL5q9vzwOjusR+lnkYc/lHEOOcs/LgHB0sSJfPtv2RUYVND3kr/1g1thz2lNL
	 sRFHGV+wpoi6gbxplA8mcraQjicXHK6a+9+bV0DxQBZSQRQQ2IAilxItcQ2+7N8oN4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MkxJM1pUM4Vyw2InbEbEMGzeTvZe7MMAwfvwyqbqBiw=;
	b=SCuVRqbCnct1wrdAtFVn7LOkcgix4+Vf1byGmtG7rFzTPFngQ8ZRDNJoyBuVE8lNKkZD
	 +SIBqoP0Zm889upUrcHNJOopY8yILWWXoNJKctn5Umaw3n5ps7vGuhRbUcYBFrG8SIRDO
	 INict1OMRLdP/HPdl3ZHx6uMFEJtubsXeOt6T6xLBipxmPpfhomZ+FQWgEuGi87CC/i+Q
	 5576ynCTPK+94ZunXqge4WorFf8bTud9dLylGFr2SF9Udm3za/iDDosIo4avPUP8iahtK
	 djVikpbXkvgdnjxPhZ2zLLtKMS16YZcHB/rERWnqnbTJ0mSDtol/SFoZYn1blgvWbiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YARNIUVJ;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC17606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 16:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC17606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YARNIUVJ
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9212dac247aso22008986d6.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 08:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795277878; x=1795882678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkxJM1pUM4Vyw2InbEbEMGzeTvZe7MMAwfvwyqbqBiw=;
        b=YARNIUVJZRN3F0PFZkE54f/dEFS3EVnMnHXNvq2KCTypm/C4he9d41ZYPH0Vua47XY
         SAKE6ybdiEsJ/polMTVvw25FpBEFhojVq+QPIQ0FYUmDZ/hJLjzGwyIhZW5esVM1xIRq
         n1NVd5OZTLvlJ+DKjbbx9pN445RF/xnJFbR3m2Yxm4l7ZArauUi/kG/9pU8znRVsmXML
         H9l22tbUIwSECGAUhj8YPd3YzM+e3bbd5u6xV6JHo4EBETtDY91aVI4bb73ubCyc7LYT
         vvc0XmJg6npoby41hdBUT2Pyb6ELsTGINWXNNt5v5QPsjKVFP5K13V6iEn3zKhLc3R2g
         SYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795277878; x=1795882678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MkxJM1pUM4Vyw2InbEbEMGzeTvZe7MMAwfvwyqbqBiw=;
        b=mUUrK6hntmX8D7uagMqGTK3Ve6qf8eSIpgmtFAdyg6FV1pP+FqULjAn0SlOmwETpZa
         L0R61oU86nuuh6UA3LW2dQarDEl3akCzNENj2nQUHxXgahTNhs65ynMAOc2dvPCiMANK
         lriJhvCAeAADxXO8FOVfEfV2i57BOg74Nsaoi+E94O+DWXA7ldBfzZKlimya9GDFUTtm
         zB7R3BmDLx/kaSKkkd7ssWSAokR3rKn66UjvTKqS2ZJmL74lU55DEdAQHV3tN8htfdvs
         gKVeOh8xrCjAnrVMmMeUaLtyiYTX3NdyUBUoI13um2YLr5oi2la1egPxsTdqQ/0Ttav5
         h7hw==
X-Gm-Message-State: APuU4Z9/LAhxo5y8lboNXMIBUvBpP22ccv4ELxXLL1gGLj721F9NTf2t
	jZepFspbja92dihq2q3WBTkBrGRPa5+yC1t4o5sQcjcL5yE3I3+zMhFvEW30KQ==
X-Gm-Gg: AZFdTZezB3yzrfFw4jlr0oPJ9+BIVWmLH3CoM+B+HYx5yXkT+GblFZbrzp9+y3GPPiS
	4fQwl9jBw4QVrqrtAn2WrMlJ2SPI4sJJgDDXPkX3ZVupQXwKehrsNS1hpNuL4FLHB2BuXeVSfxV
	L5feDnw59mCjQnTTEqeXbZOwq6NqOzM820oTFlyBGZCwKqP20GJ8TijW8dpUBF2H3ibw047y5dq
	mIIi1VNfOXSSg0rroTgqRDcWeaEgPNu0RWvI4Pk09rEiU+X97y2y99z2Cz5N50FBcCTWeHt1qTw
	HISJHvOv1mD349KZiqmbkQO7PdR1J7JRl09MzVFJzWSbPzljT0vMxMzhYIcnwpI9olmG8agDopt
	VucVk7WaHjbc+17KvOet/g2VZ/S2azFzualmp/1Dn/7LlwEXVnuKAQJLM91E8q0Mq3OnH1aoSid
	SZvreiqw5MmICEJRpiPl6lHFhdqDPaqjZa/13f+FvJlSBs30VVLiTmVWhnzErdM0MgiYY+UmRPI
	AepaJwz/p5DvKi7XG+Ew94kk34mig/WKs9EkWoUBzXzBwf1jhQsmwig1vPDqQ3dn8LV2et5kxhm
	UxR0phSS3b3vS7OVP2/G1kxIgmu9xQ0ZoUqhnYMRT2jhcx7co7BwHt6eyIswBQ==
X-Received: by 2002:a05:6214:3f82:b0:921:3730:2b4f with SMTP id 6a1803df08f44-92137302c0dmr85111346d6.22.1795277878164;
        Sat, 21 Nov 2026 08:17:58 -0800 (PST)
Received: from Williams-MBP.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a24e91sm56723836d6.43.2026.11.21.08.17.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 08:17:57 -0800 (PST)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Glen Choo <glencbz@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] submodule: foreach in reverse order, with the superproject
Date: Sat, 21 Nov 2026 11:17:55 -0500
Message-ID: <20261121161755.20032-1-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028001529.81557-1-whatfield.git@gmail.com>
References: <20261028001529.81557-1-whatfield.git@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A gentle follow-up on this series.  Before I resend, I would like to
know whether the overall design is acceptable.

The one open question is the name --reverse-traversal.  Following
Junio's earlier comments about "bottom-up" vs. {pre,in,post}order: it
is not a tree-walk order, so there is no "in-order" counterpart.  It
reverses the existing order literally, siblings included, and it means
the same thing with or without --recursive.  Unlike in v1, the options
no longer require --recursive.  Is that acceptable as a name?

Upstream has moved since: a new t7427 appeared, so I would renumber
mine to t7428, plus a trivial t/meson.build rebase.  I'll send that as
v3 once the design is agreed, or in a week or so if there is no
objection.

Thanks,
William
