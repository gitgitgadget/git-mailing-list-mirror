Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794863373;
	b=yo5Uk9Qh1J6yO5bRWF22JdeOC3Cvg6G7+u6pbOai32x2tXyiwMvE2CiRmm5yPcRUvnaH
	 rBn6gAqxCgw8FX6VelTnXbuIabGrcgAqW/dzDHuyT+iEQzN+9jpIo24VSWvxO8tWShPKJ
	 2Rx0vc/c3K1OTH1Y+zD30hr9tHT8FSjlDe0vlJKePwnt66QykijAfsoJLdFH31FpKtY5E
	 FfB2dCw2G7AfEQf+fi0RWCEJw0SevH/RNcmQO2tnuRzv/1rI/gnxzeGfYAWsj01OGaEjZ
	 +lWYLztNh1EbQc4GHbhoAkGJInKk1UCCbBEU6GlhLShZOxFdqj1O2uxuuzk0KOadgwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794863373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:In-Reply-To:
	 References:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=3lGbhHXzWM980vNrc+RDNu7oMtkaQyqGhOHd1yDeQfg=;
	b=2r1rKZvps5y+A8symQ6biIHUF0XhvyvikGFRYA00Z7pB1cX6CSjDq+zm65ycRnUfWqUa
	 1tmePvNXB0U8Fqwi1LOtQE5E4hup2r7OuA1H9jML2jZl2vmBcsyahgCngi/HDWsGdBtbm
	 7DeiGqzn5eYrpAgPFVXcxJ8RlmnDlo1RpHDoVDd9uRTK4kulTrsb67+gM9/jFgErqOqP2
	 beskbOEgjNFamEhJ5/5RJZUwmVrCERSUl8ZGYic+L4Ei2ZENLAFdPTgYnsf5IdA6zh2AX
	 I0fH1PFB9NQ3aQYoOiewCXwnhZ6fhnM4LSdgkgGQl0LKl1tar3TSIo5Ei/diMmuMLQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GtYomqoh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6296606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 21:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6296606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GtYomqoh
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso346a12.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:09:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794863371; cv=none;
        d=google.com; s=arc-20260327;
        b=r+sKKafNveTmw2ARnpTeXv3USIJgHVtqWS94RKSKNqo8VEeKPY4zUswEOYJ51TmjkB
         qzcFRN/51M97iOfntdHSBRTUE2EUz/c6f1slaWNjAkbI1gNDS/dWBy6HZyc+xcvL/gBh
         S9dKcBq+xSbabLvconwWTChcpPa58Xmh8k6R2AsxkSnaZ3A8y9OwzMZ9GBL0UjjDN1HW
         8xxf0fv7U3Ej904htbSU0wU/fJe03d163ioPQq/AbXjtjYLuYXtXifVIW7puvxPzHkvv
         iWR0/kjZft/AsTYE4CfF1JQ5RfUIf0KPDvsJ/pn1ESX98WD+VSakwt+1+8ZswdycCcVA
         hpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=3lGbhHXzWM980vNrc+RDNu7oMtkaQyqGhOHd1yDeQfg=;
        fh=wA7009Xb395sBbHRFE4T9yhhPpTpC77SZnliAacqD+4=;
        b=sK102SHQgygHNHA/IyQLm/rxA/MKAZgsdnlyaObnIcn2h9fG8LAtDfMRozh7f9PXVf
         6cXX9DPgZXjm2T5WiChzMjgHVBIdejYxznRQe/6rfNY4w0ub7xULlg+29T1/OaTnpFSO
         EnilaOLyt9jxro5XjLDxbU7qqFIE7m/SvqQSR1+nCXhP2TjAHLCoYWsyzWzXQvpzldl4
         4T1Dj29MaUwOb/nzdGhl++DZBTVZRC9zj9cQOYH8vE9r0sa86xTFzu65rUr8lCbgOxpG
         ChYqYBSI1qd4ID2epaQ8vZE3ajBmDO1Il82t5gvWh9iiBqA/on9V612ud7A3xsxWaho4
         LPKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794863371; x=1795468171; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lGbhHXzWM980vNrc+RDNu7oMtkaQyqGhOHd1yDeQfg=;
        b=GtYomqohHjWeLQashYZS3k4QnIbXCWIshp7gbxMUySaaQ1ip86PDTMarQcqZUP0Nzb
         5w5LURWS2Roa7RTVtc2NFPndcm526Xew94XAtA5oYYYGFgZzqAJskMoUswoX/YR98dLA
         ZDk5WU+QgO/0hYbnb206G6M/WpM20PFte/iI03MugoAa6MhqY+qdUxeh0yGm0IlZ+L+p
         hc92ZD1perrU0gtPR4D7SISNbFZibpPvo05EUuRkTQbfmXor4y6kvtEaTFXSlTW0ji4X
         xyeZL+TmbYU2g1p6ECbm08k/TDtF5OJ9A6UoQBL+edL8Tbsvnunm55/hDJhjBB5/2KAY
         1hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794863371; x=1795468171;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3lGbhHXzWM980vNrc+RDNu7oMtkaQyqGhOHd1yDeQfg=;
        b=0gLi8hlGAsxJgDem2KfEt5CmkIJMnC8Dp5+uWjYQdJe5rXIOOLk75aen90ia6NRgoL
         Ds+2kUiMOWfciN8JW2RUgNoZQWnDahd9S+BTFjhIYInkrEAQ2+qYjjT6OJQ5l7ZGk3Io
         TovVc5XOncOCsjteM9YCsYxDNCHkjpHIprP1uIA3dXuw4ZgJsd3kSFhIezWddq5dacvF
         ymU3xua2HIuNtV9iiAcPfp1MH/b/1OuFwufCV5s1BTgE+vDdYHs8uokvE2Ke7mD6HPh+
         vkgULecwyka8M8WSw1EJTqk0JLUkSfqYpFJ5n0Ay+2JG2dYp/fhQV1EPDEheer+qV6UL
         3EAg==
X-Gm-Message-State: APuU4Z80pWdy9ExIulEnaTL1TO0W0XbykeSvxl91En9SUbQTgOvFl5r3
	W0X5sxjMk1vAK2Bk0U88x16z2DunGVKqdLPhEwbf/cbhLzMIMSiwAgx4/MeBiJRR8s8myve26VW
	3xXTMMJQjpy5qHpK2btigCByLsMX/d00FXyjIiSEA
X-Gm-Gg: AYBFou0SLTvq5xOsY/3n+J71TpI7FlydM8sNHZSY5eQNzVqu5FYFHtpvkbt5cA09T/E
	M9CfJaeaQpkPE9kG3yqyinvQdqxj8+5hNL1z1HkUSNVJC9zFZ3Oc8Cy9pj9QW4Rp6ea2dN24mb5
	wZS4knAQ0N2R1f/JXrvnkzfkthhIpOS/BKgMX7MNKkKHPu7nOhANMlCcztq3ClZT6LknRLA8811
	Ct6G8Pl6z1832eOvEB/FqKr+6h2bSjvubZeWssNIxBDoPz88nuy4I4DuUSuAjxYc1u1Cea+VEOC
	001Iy31ELTrkbn+EMSoj6lW7l15UWgdYp/3vIp9sFHd4wxuuTbO+yRSFm5EfXoaWNnJZZ1Te5EL
	Uj47usEGkU5QMUfw1eDCbDF5nmhae4nwNg1l8SGHnKXsLLApSk2cQAEYda9w+SK5GcdgH5U4I6x
	4FDNPOiquNvPDKOyZRO8Vy7w4541SGlbw=
X-Received: by 2002:a05:6402:1a47:b0:6b1:b3bd:1576 with SMTP id
 4fb4d7f45d1cf-6b8625f37c6mr6408a12.8.1794863370507; Mon, 16 Nov 2026 13:09:30
 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Nov 2026 13:09:29 -0800
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Nov 2026 13:08:36 -0800
In-Reply-To: <xmqq5wxwolja.fsf@gitster.g>
References: <xmqq5wxwolja.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Mon, 16 Nov 2026 13:09:29 -0800
X-Gm-Features: AclHuK_3gVOjELQJosAcaxpvlXjnaLzwPjQ_0Tq8R1H-ftfjCdE-gs3uUYG3Sfs
Message-ID: <CAF+mdicGt4+aydaTqjP1DJRzxpRBbKSQQNai7BvXepC5Kt1vVg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2026, #06)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * rm/http-retry-improvements (2026-11-06) 5 commits
>  - http: default http.retryAfter to 10 seconds
>  - remote-curl: retry transient HTTP errors in post_rpc()
>  - http: add http.retryStatusCodes config option
>  - http: add exponential backoff without Retry-After
>  - http: fix retry count and Retry-After timing
> ...
>  Needs review.

Since there have been no further comments on v3, does this look ready
for 'next' as is, or would you like me to send a v4 folding 5/5 into
Patch 2?

Thanks!
