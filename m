Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794491076;
	b=CMKGH9yeJj+0l2tU0jV5SBhzs34UXHQxobf2d6RaJZw27q0GP8hmmBKOtxE4iMfPYnhl
	 TMAjbGYM6ZhQ19bHzMdqxI6dG6MlngzT/3m4d6TdTTMJmqkoKvxW6SMlYyep4uiRxIrOu
	 HOxTaSUhHYybCYgMbkOFNGGwOTilEYiUzqf+wgBe9DH5GS2abtkTvD6/Gpcmr/3pL6KjC
	 ULQIEYq0Mu76eE9tOmv5WtLOBouPXug98hFEYkxq5QRK3G7vhYKWlVRZa2LBpwg6eFULQ
	 byPw4xqWJ4iwKrqP/rYogD+CaJ7229a23shBl4hXFsd2TR6v/krNUW+L6IsnvNDSH8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=teIEqAN7EJNssj3wh8jUo1Hzmb9P1cukgc+8z+mP74c=;
	b=uaPfrbYO2qnzd+Mz6lpmbnlDxf9dsm7ZBG8maCnRiIDvr5k1ZEEuLHnIYqj8TFzKcIqA
	 E7n8qzceqwYIWwqdBT+qn2t+zUcSZ81UvHe5+h+QC7iuxqW2qqZFlJqog2/44zL9PGCr+
	 VbragJoDPfGTn6Hr1j+AgNO6RSdIfU3qq2XWep/GsaFUcq0PIvwOHsG0LxlOhYGUkbnoU
	 W1uAps0vthJRmFdEWn0JD+wWppGybEM9qLyoltlGdLVPMD9eq2nTvM8GG/YcoTvbHroAZ
	 AJYvlGj95X46BYg+HFIEuSI/9Op0dbrdboYrwJhkNDsy2woI+0PgfXcx1uOkYrvfuzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcaBSQ36;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C63606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 13:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6C63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcaBSQ36
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7d2ca055399so1266760137.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 05:44:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794491074; cv=none;
        d=google.com; s=arc-20260327;
        b=npobrB4wiub28ep9WNYBdjDtlUgzaR7hvBYSF+mm7et5CET9qpkzkcPv8aUbqkU/TG
         +6H5e8mWvwtcA5QezcLWEsnNwEY/3GQxL3tvlucHMnF1j1WGuB6VAnwUiykdhmrRUP3s
         P/iffCeAXqR4lffRYUGeyzlEqFD8J4DUAuvTomL5eyGyS0XegZMLjjzK0Rva9GiQFF7C
         OT704X3CUJaaeAXIbmsXiU7P1RZ9DbwHYl4KP7WVbHRpbIUFy7nt538RMfjZ7n6JAOX4
         KJTWx9bEg1QVjQp9DUr7Dh4Tif8jxaWU1O3fVkw+sqk6wjIOkc8/PrVCHmZOQGIu8XMZ
         zB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=teIEqAN7EJNssj3wh8jUo1Hzmb9P1cukgc+8z+mP74c=;
        fh=lNkMeFpgC9R1UZkVt/4vdYnK1nnuXoAwVesFyopQeV0=;
        b=PPblN+Z9z7+mwHJvbIe/GLDF5TMcnR2/nuRGqDqfzuYIVMY/bdfowTrrHvicv/BUam
         nzmUYkuU3oLAq5GtcUkl9GWcACT8btAKuMfHt9R0DW8c/1bRTuQBiWCB9cLSxrjndJvw
         MqHmj8vAg4Td3oAiifal4HytHhZVVK9iGRwFZAg4xWiPpUWL/LrDsw3bdeqdqbuolvAH
         CkBO3SLW27vtwXfolGoZTeRLfC73yZpzbtxKFfLEt+lha4pA3ACq4GQFOgm7GzoUQ/Fj
         PuKEpHkh6r69e1ufCxGN4aGSELfAb69Tx7itxw3OoQv0TrEWsF/GBhdQsLoHINMCYsb+
         Bw1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794491074; x=1795095874; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=teIEqAN7EJNssj3wh8jUo1Hzmb9P1cukgc+8z+mP74c=;
        b=qcaBSQ36qFDo7pUvUr7ryU0+YAZvmvGGWE3OVkDrs4AwwuEyV0dNbnfRDhviYaUsOC
         HaN12XHivlhQJCyDmP3qmOT1YxfeoP224+GPlqETM1y6Qp1Xhhi98bzoq0y+XWnuqEuI
         4Tpk7Qhl1a2HYJY0q+RdWADgEDbQRwNnSghf89YvcVzYfIkTLF55CSQDkAvUA821pVEc
         GLq9qcaP90o39NXvFAQxTy60s4SyYF/XMIrzrfT3O5dYGcSVfYr0h7CvztRSzslfz14n
         55b+QmM60243p9HMy6PvmBTZXX/NnHPs78JcmAILdqwYpUnXMQ3/UkI1aKys5iU2X15p
         EYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491074; x=1795095874;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=teIEqAN7EJNssj3wh8jUo1Hzmb9P1cukgc+8z+mP74c=;
        b=glkQeZEi39bPAT8DfJP7rTB593ebOnmhplI8xo7DuuAiDDgBVnwXx3PfClQT+g76oY
         60oIhTAKlu6id9VsUsHiHY0J4ZV0imQFD8WyjOwxrePo3h09EMmM9ZSTv1lHQc8bBka4
         aePRKqokmsCVjy9GODbWLjPbBGv5y5A6WiypNCbji0NNtmTIP88r4za3Kijf84KlswQq
         LyWECKp6ZNqPqb7EtzZG4eeeXDMR4wT/gpfhKUwC5JT/z130DgdNfWqiZZuYGrt1Kbt+
         webkuo97ZcdHHjRJR1iiG9xlwC6biNVCWSxM9KOPTGgCQkLB0jMeS0AP7VlHehyrB9ao
         v2fg==
X-Forwarded-Encrypted: i=1; AL+hErGWsOOEQp3D5D+qg2oxTvdjlnsN8B8kt/ALUxV5hHb6xOEDxB824whTYt8Q3Ez2ppo6Shg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VJWAECooRRaceWRiCPo5imPR2ci4olbjoWEsiweA6vNfgT5h2
	KPDhhfeUDZ4bdGaPXBRYafi0W4QW2rpoQS0SGCnNuR2/xe3gc94tN4a3yYY0nbeJt62YLC6IXDd
	eIPgoekWDiOxU6pHtfS9PGx5B0zc64Cw=
X-Gm-Gg: AYBFou3CL7//rn7Y5LS+ocXjhb2+OvYk328gq5jq7lwOhuo3v9wWCPIiBMbYLPOteQo
	AgI/o5LjMnBXadtVevPdrBmzaKdnxcosuPUN2W2sp5rE8o0N2Td/MEVFS4wZ7wGpud5vQKkAl2z
	MuezjitbBm6Ot2TjXpXvHqrZFB7AnEblV1QezSro2zHK+zDV8LrdeiYxhu6vCoeheDoo5DucJ7Z
	wCtydNgA2qgN9swRMxQX41dcvyu0J/cdKexPoEh2w6d0UwrXCvxeeHiRPR4EXI1giq2BtJuJfME
	Aa2iArDPSwCkXopD6px9AdmMchcxQVeeE1G/kRk4ZYiozUFQ7bw1aRqBFcuKwGsZ7hJZ3HQXL/m
	Z2sRJQNblX0g/r/SW8S4EK2DouoFvfMYTeRr3omPp2GrCvgG86QnQhjns2OuGjcWoEmc4ibSPIe
	el83bn2yYE116VM81QgJB+11+tUQA=
X-Received: by 2002:a05:6102:5241:b0:7d2:da5c:6f7e with SMTP id
 ada2fe7eead31-7d4fb2dce50mr1719646137.21.1794491074473; Thu, 12 Nov 2026
 05:44:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 08:44:30 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261112-mb-ref-filter-missing-object-double-free-maint-v1-1-d6d56a3c8dbe@gitlab.com>
References: <20261112-mb-ref-filter-missing-object-double-free-maint-v1-1-d6d56a3c8dbe@gitlab.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 08:44:30 -0500
X-Gm-Features: AclHuK-v_Vx4A-P7w3yuURF8lAv6-QWBKJpBuCBnTKfAlOFoSTx4lFpJUhjAZRs
Message-ID: <CAOLa=ZQuT5+x-Rvxcv1CSYka3aGG2nV_hPFRDTYJEGgjbLhJwA@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: fix double free when an object is missing
To: Mustafa Bayar via B4 Relay <devnull+mbayar.gitlab.com@kernel.org>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Mustafa Bayar <mbayar@gitlab.com>
Content-Type: multipart/mixed; boundary="0000000000000c1abc066014835c"

--0000000000000c1abc066014835c
Content-Type: text/plain; charset="UTF-8"

Mustafa Bayar via B4 Relay <devnull+mbayar.gitlab.com@kernel.org>
writes:

> From: Mustafa Bayar <mbayar@gitlab.com>
>
> When a ref points to a missing object, git-for-each-ref(1) may abort
> with a double free instead of reporting the missing object:
>
>     free(): double free detected in tcache 2
>
> get_object() frees `oi->content` but leaves the pointer unchanged. Since
> the expand_data structures are reused across refs, a later call can
> start with `content` pointing to a freed buffer. Then, if the object
> lookup in that call fails before it overwrites the pointer, the cleanup
> path frees the buffer a second time.
>
> a29e2e8fe (ref-filter: parse objects on demand, 2025-10-23) introduced
> this by making object lookup failures jump to the cleanup label.
> bea37f1d6 (ref-filter: fix stale parsed objects, 2025-11-04) later fixed
> a related stale-state bug by resetting `maybe_object`.
>
> Similar to `maybe_object`, reset `content` at the start of get_object().
> Add a regression test that exercises this path.
>

I had only reviewed this patch internally and we did some iterations
there [1], so mostly just rubber-stamping here that it looks good to me.

Thanks for working on this!

[snip]

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/737

--0000000000000c1abc066014835c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fd9748403826e52b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMXdyd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3M4Qy9zRjRxTXRWTGlrR3lwWjN6UVJBaXFqQnVWbgo4ekdiejc0Tk9j
OXJwNDZnMnhEaUZNMFRFbi8vNnorbzBVTGpXaGRmMW5HSnJYL0hHUFRmNEduRWxJOThEZzRaCklS
ZmJhQm5OdllhYUhwMGcrejZYUFJGZm5GSWhuMkxobDFmRThzRHBlbkFHbVcrWEs4MWswL29JMkh5
YTl6enoKRlVQRHdRbUl4SHl1NEJqMmpDR3NWd1NuekpVVGUwbEpDZEkwNU1qV2cxaDRWNi96VXpP
aDg1ZCtXUHpaL1locgphUTdieFBKMzdmaTNjL24wYjk2b0NEb2FUS0ZKT1hYbnJkQm92OWtiTXd6
ZGNPdWFNZWw2VEQ1eEZ5NzhrTjI3Ck5uRjhZcFdoNEhlYVpFSjZjODFlRTIzdG9BR3FJU1hQSUY4
T3ZVNXNBenZiemdEV3dmdURCalpzV1pmVnlXbnAKV21Jd09wVTdmNlhhVmtKMUtLaUFlWDFxd2k5
Rk56bWJ6TXA1MXZPL1dPMVZ5eG5EYk5yUksrZ2ZzbWJNRWlVaApvUXkydTBoNFpYTGxETDhqN0ZL
cnAyQmVkbzI0RTJWdkU2N29KZlcydUJYSXdpOEt4RXk0ZGpPL0hVcWFrU29qCkJiK1FVSkk0aVYv
dDNrdGpLTFRGemN0bHFzRFQ5TVBVc0JUVjNnZz0KPVVBTncKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000c1abc066014835c--
