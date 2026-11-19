Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072343;
	b=vqF9DLCf5JmbxCGs73KlH92piJiMIqUQeqttBID1RDEirYhUvKi4TXiOWjfoX/71X14P
	 dz8PALXbcBjH5lHOp5x4B22Fqouc+7ZZC5kDVzLOGBWAIVxvAoYp8q5j3KGTVeFUcwtgU
	 5Bs9J1ln0LDaHlTeIKyguFpaQZ3VjB6uRDPuiH9ClX5HfPhNzeZHZHdJyl1DaMx7Ybf7b
	 GsaglMSpOiaskcI4Kgr/L7X89BpQnCn2WCUn1NLSmgfIAmn2WYXiSD0U51xDSldCSXbps
	 3AAYWz0WulJppE7b+2Ykc4HHKQcIqkY+Ijd+Kg1BmkETD+HYzuKuHRmE04M2cyMmO2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OJp0HR3fjMG8tOxkelfC2twovoBbavaNkH/vAOwIehM=;
	b=1QlOjvi30LH2I+Q3n9UHrAsgixzJDqU5Lr+AgfmKgBRLCtEROV3T6ZGSIUqaXkqrrLJY
	 fBIqF6SrS5DoOBwp3TufQuMnKH/0D5TfFqt37/kTUU1yjRUkKybdPi9ghFcqarMywYjWW
	 MiDGuYaTcJorKhtn0Ngg5NaIxjKjPVbqGemio4DvVR5hC9vh4WjL/lMhAWOoGh69c6ERB
	 cSHIRK/92Vkq0qhq5k6P3pj8FsCV3hIVzkXVcMpDpsylH2KEXIfzWW4NKNIlmIijeIYql
	 TO/Iv1IZmY/78W/BMAyHC/a4x2baEysR9aqXEJbCrYUI+TDjucEaRJSw4kUbYyGcgvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIF94jIq;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071F606A334
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A071F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIF94jIq
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so13718205e9.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 23:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072341; x=1795677141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OJp0HR3fjMG8tOxkelfC2twovoBbavaNkH/vAOwIehM=;
        b=SIF94jIq3RO+AtY/2SQNmazPfcZbx9tanYey8mQ8fKLFnCFmBHuhZXMy+4k6vT26Xj
         +Vhxm+ZqZmTtEiZb5xdCBM/B7AMELtmBBABBQLXOIW8FdjVBLPO9iNWFvMzbQKA0Ye9k
         YgBUFqiKV6L1F6dZDEk9USYIdo7z/NVA5aaVRzQzEJAORinw3yi4i6YKNhWYGpdrur1t
         dcocSQ3eCOUYIhjubXqt3GyXDl9tQV/QxV7VQ95rbatzIfF8OFKUhZcz0APfr7m3Ui3D
         tB1BnauKByNtyK/KCMxxddbDcxq1ztEqrcb+2/hzUhmbH3+q+QCx2DIGMtzXQifbWNJm
         c+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072341; x=1795677141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OJp0HR3fjMG8tOxkelfC2twovoBbavaNkH/vAOwIehM=;
        b=S6QmrEPEHgs0lPM/8lCJwqB6gAnY3F1P0NNWpCRbg1HfJOy3DT23wAM8MM9JrmXusu
         oOxuk8Cw7lcsk4jSxHgBPq9PIwi2MFQqBoNe8R2Dhro7FtJgtOWZ43TlsjS8H2234h7K
         itlHcJgSNLZaeMoCZ+W5Xdfl6luATQ+n1lkeOhoh1XLaPxDdDROt4MohEyLjFm8CFmFe
         elHJdJfEZ39cs6HaZBLh0MyikO+BoaBu1OXlNaEl/B+3t+LsZ18e+cZsFnJhHARAFqm+
         VeMlpEpUscjJsY+WQiSDNf2fqBCJm3XELdv4SUenITvsZfClayGVh0WLsz914AXuX2he
         o23A==
X-Gm-Message-State: APuU4Z/ExkalJY/hX4HXFf+nPE/hwj7zCUfXPv5c/5d3EPeYS4IWoilj
	WnpeGxH/H6Clz8bXdzXWQ/vHraCkllP2eTAX/E7tiqEw56VJVtR260lYOD89/Q==
X-Gm-Gg: AYBFou0+k8F4JfS8zrn0esQuzSKUdjMCZUcZH4uHv6pzBh1iUjMr4Qp3WmOM1yCW61k
	c6iJPy4K/bXkIfH3J3Qz+8r7LjB1KKzwdYUA3m95gpC3JQzB/05fjY9OgLEAzOOiOuQV8PBmFLN
	MqJvy88zR8cPEdcnEenpqc/1Gh6Q0CPSMUwZbFt2Ed78VP8LjmDov3KqKD0LVY4mYdSme9/L4ZJ
	LwMBnb5UF4CTXYRgPcWEsWzGYja2K+dRCxwc2AKKli/NKWF0LlZN27NkTzxdYbwJj93tdD4hRT3
	VKy5vNdYpqN5pezr/+jXZg39wgBaTtCj9M9FYQdR4jL5YVUfnkUnZx5zJ5Uao485bokXEy3ZLvU
	WHUAnJncSJIN/UUiH5aE0mpogE09/xf9xUFDXvN9DcdpAu+uHVbikKdABcFo+62A/3kJSRyltYu
	NAdyYZQJEd6kdvuK7/PymI16GaaHjJ7CL7ANZBxiG4hcTRVL5dKH9lS2cPc79+GxOM7V8UvUeoc
	UbNSo+hUa1RsV6OovQRVQ+Il7JjkZoUR7MIPH0SIBh5tKCJZhECGcDj+M/uyf/iacvJ/MHIgFG0
	p+l6an5Wy5kq5TzKmZ211eA8yGbXoixwVTEczVUKhcT3EyK9o+Mw70wlrbRKsJw=
X-Received: by 2002:a05:600c:5012:b0:4bb:6847:7927 with SMTP id 5b1f17b1804b1-4bb7da0f629mr93842195e9.7.1795072340889;
        Wed, 18 Nov 2026 23:12:20 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e06c73sm28817095e9.2.2026.11.18.23.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:12:20 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Toon Claes <toon@iotcl.com>,
	Shuqi Liang <cheskaqiqi@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH v3 0/4] use size_t for a few more object and buffer sizes
Date: Thu, 19 Nov 2026 08:12:17 +0100
Message-ID: <20261119071217.828481-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793439137.git.gitter.spiros@gmail.com>
References: <cover.1793439137.git.gitter.spiros@gmail.com>
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

This is a gentle ping on this series. v3 has been on the list since
October 31st, and it still applies cleanly on current master.

Two other series of mine are waiting for it:

    https://lore.kernel.org/git/cover.1794984184.git.gitter.spiros@gmail.com/
    https://lore.kernel.org/git/cover.1793524457.git.gitter.spiros@gmail.com/

Thanks,
Elia
