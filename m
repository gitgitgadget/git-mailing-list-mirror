Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881559;
	b=AvNTy0p3vEUqgsD2ezA49PyPUAUHRQhb32ujj/UuOTuNCpHydmuKuKc0iAfHk1e6g212
	 5rqFmuLnY+IkCfxUJobE0ZZgEg/BmQvX+BIqJ45nx8yo7Bah2QOTqgRG/MWbENg1gVxN1
	 /WGtuwP71W8kpLldSti1Q+b5TXMMn+z0iAZv6d/pb9Sge2DY53FW2Y9NtxYdys9qV6sZp
	 G3H9lvqM6ghxD+/O9/R3gzQTJCe6AzF/YpkS5BGhHWLSftuFBsh11RLlAlsmO0hyYKj6t
	 IAokZfdDbxdVp+ZYEkFVENrqOSglTBPooekfrm1dZOIHLwhQRJ52/xd+1zVNAc7sYYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vOEPUvgPU9lXYybnOL01XEUVdxauSUgsIFfKP2+YCDg=;
	b=CSJqyenxIGVbHHYWJ9+d7e0G85ozQjfXz2u6ZCnh8KnwbF28wLoI8Negi/p0ONZQA1xd
	 3Rt4HY/Zt/pagUDTCABoQf++ocSPZo1Vnbm2tVLUxBh3RDlrPKdqpAAuHXHbX0HkWM3dq
	 eYvtLCXhnUsCmi4UEqdqNQPtmZwuLwEsGJpv/o4kB5G/hygJTFhMioX+SF3ibguL+J1wB
	 tw3Y10w/yK20BkLf+Pr1b7Em3AuFu0Oq7KUnSGQwZ5GpT8jp8TAr/FfMrrLamFohIe5sQ
	 fw70PRVTm2H/55sg6k7juqvwEsXpeo+vJT/ZAHtTHpZCz4OJltfY5wDnMZjXhkM4J4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jU1fXS9p;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796B606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9796B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jU1fXS9p
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so712470f8f.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 04:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793881557; x=1794486357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vOEPUvgPU9lXYybnOL01XEUVdxauSUgsIFfKP2+YCDg=;
        b=jU1fXS9p2l0BnjV7PThkFgVqaBGIC9RWupv2MGMCK9SIVCCL6ml44BJBl10YU0d6Mc
         nGT8brWCk4WpvDyyyaVoT0e8SrMXaVmyft9lYhPGDvF6h0P296ESDBH25UF2z4Ba93d4
         XHa1FbPJYBanIDZmSCrTdur/FotnyMwjyY/UxadZssX+Nbb+2gm9eTD23xS0Oar+kIOj
         MDxc/5HT0ZlsR8QNvFIUO2kUcuOt/QsHU9/75JWo+DsSAsDNnVC4y4jjf2IfP0fYlAvp
         qDSELmAd+jm+Dpq3jCHaEGOno/ikxlQisEI28fjdt2hT3L30MU4L0BNQw8WmXzFk9DNe
         l78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881557; x=1794486357;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vOEPUvgPU9lXYybnOL01XEUVdxauSUgsIFfKP2+YCDg=;
        b=IS7eJtQgau7X1qGdSw3hLTnKxAJiF5L7O+Yjx2UiWFXlGnXd2laRsM7VzKB3phPbkh
         rhVIXYBl87HfC89ZR52GZ3HnQqTwM5r/T6aETAteBTS9HhWX/qGMjQcn0ic2AAElovBZ
         G5hsxmx4GKCdifnlVZv8ilz6hbBzPp7JsQEI0A2jRF5qUzW3DIhUuKrryjNXGyHbJjos
         mw9MdAFnMxAUGOnz133e1eog3ouktOY96IqX71O80Uxzqnpb815iSAipnsT0vAJpqLJz
         ScSzQvUGKAij5/F90uo1ypmRqv3pMyQiZmXcmpNMDZlhyxLt5bWBNNMTG08GeUfis168
         sSsg==
X-Gm-Message-State: APuU4Z8Mh8kM64hPuRpu0VhG1ODNPxvjx9Y/eI7HjRv6lMkixcm+Ihis
	eOGXoTAqJowrdBG6N+W1NdoLd2rec7M5GtISrmG7wpRrVERned322m8e
X-Gm-Gg: AYBFou1M2t81LDTQrK/oLAzeOwLsiq8Hh4HTFQy26Z0GrTmyh16DrtjITE+AdAbWnUV
	FbiOCY7XGga3mBrwUrSHxMYWAa0n+gGStty/4LfmvV9z2u044Anv2dbPeOqlsdovL72z4sukCW2
	N73uKeUX9cl8g0+tg7ZQNxr+AFnCqFacjEEZ8K+szutO1DRRl1DVSa+sIBcEFthZx3dJ46m8VR1
	LOaenKFPnbK8u8NY0KjBZ5oLroul0mfHGQURTAwnjzdaZG1hkfJMEOqVTFRsJZbF++HPW5z1QY8
	/Wrz8A/20P/LZO+6k9Yfk/HtzNCkUmLggCJNAPtiRESqAomExnpvDV+0mbEUKDL6kQVstFhp3EV
	xpC/wVh+Bb4Hv9EtqhkGsqiKj6AP5nn9XIulXspAmm05oiXWfBCljHcbn4LEj3BQkQ6RT8HuJ5i
	LaMkuDdznuoFqrnlbJUHJk5b0Lpl+I8KjJEgXNAYO6SRAOjwZuez4i9lZ78fNfMOhZrxhpC43PQ
	fz+T3BC4Lt8JZnNhR+QgcHMfJuETjLVRqRGbEKMRLHe8sz6Nv8SkT5+EpQ1udVYU3fVLEdafv+Y
	NYNn8W+2CKdTGWJ5EGTFcQa4ncY6ahlSM9h3PRK2qlZVndf7Anw=
X-Received: by 2002:a05:6000:26d2:b0:48e:88e2:fe6a with SMTP id ffacd0b85a97d-48e88e2fea8mr20759889f8f.49.1793881556869;
        Thu, 05 Nov 2026 04:25:56 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.57.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd40csm9755828f8f.13.2026.11.05.04.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:25:56 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH] api-parse-options: add missing flags and macros
Date: Thu,  5 Nov 2026 13:25:31 +0100
Message-ID: <20261105122532.391-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com>
References: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Karthik,

On Thu, Nov 5, 2026 at 11:37 AM Karthik Nayak <karthik.188@gmail.com> wrote:

> Also add the follow missing macros:

nit: s/follow/following/.

> - OPT_NO_WITH

The message lists OPT_NO_WITH, but parse-options.h defines
OPT_WITHOUT, which is what the diff documents. The diff also adds
OPT_BITOP, OPT_STRVEC, OPT_UYN, OPT_NOOP_ARG and OPT_COLUMN, which
the message doesn't list.

I applied this on its base (8d1b215c01), built the docs with no
warnings, and compared the descriptions with the code on master
(0ffa3e35c7). OPT__VERBOSITY, OPT_UYN, OPT_BITOP, OPT_COLUMN,
OPT_CONTAINS, OPT_NOOP_ARG and the two new flags match
parse-options.c and parse-options-cb.c, and the git-add[1]
references resolve via diff-context-options.adoc.

OPT_ALIAS and OPT_ALIAS_F are still undocumented tho. I wonder if that
is on purpose.

-- 
Cynthia
