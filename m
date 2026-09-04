Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B5374E79
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561961; cv=pass; b=BE1EsLv4ftUMS4Klhx6FZe41KgLELD9jrQiAz8Gd/mMHpJrLfvZlqTg2/3sLBGDjqJ8Y5k2UKBhCMLcS7ZSeAS5oNaYi4nWVe6jzh32Yq+mjx/IdbzJKXKm5lrXd+CkwlEH8umL7ojiuAgJdICzaQpbKtaPOnCzZzx3299H3lVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561961; c=relaxed/simple;
	bh=Tzqo29I/iFjh9emdR/RYmQc+gOaUWIn+GwBVbB6tYXU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdAeY+n3Kng43BvIutkf4sqg4nc/mHMMqEfnWU4Q5mvzU2dauikMQlEP7eyqjOGeCujNwPNMsjukadKkm53gEnalpadCOnWmUyHphSCatRVonER3GmHdLCpktAs1enSPMlypeuMKDImCbNVhzbAycWXBIx+qij3ZvU6LBCQjTMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNO0eGrH; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNO0eGrH"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7466771f1caso545979137.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 15:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788561959; cv=none;
        d=google.com; s=arc-20260327;
        b=rABwHGZ2btRuHrE5mjn1ep07Smw+SrqLhSSfbX5DwZYxL5s420fygzJw16bWQbHUWr
         JVijjUKMLc/fwl1U6MwhdRpLKVikzlu0iM7Ih2ZMvUwd8ySx+vjzMEs1zYsZBQSqkryq
         aBFYohKvinTvOR1UCTe2Ql6Nv8iv9W7Dv0CEmnsGHl9HvgRSOzGeYFS0izb0zL0WRIp6
         L2EBf5zKpQ5hLGeNp6zDIlg00nPBVuE5EDLUUSChF8jjODWc50DuJxhmdsT9t6WcUfOc
         VEZVhlMKZnIn7E0K4ih8zXDom3etD7ydHXHp0LA92zmiIK59Gwk3zSJSmlG4yVoam+Uw
         LWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=GrnHtIvpjz/uqJ5uOGmxhPsYco2Z+1zJP8vDTEwM5xQ=;
        fh=OC1BfFa/kcscKsACxQrP88IBuV8wbIvuWZCpT8TbozQ=;
        b=Qb2xqAkgnWi41hLOuPuJs2idZ6hzLrJCQYuET9SUR7vDOp35eF58k6LVpGOcQORJiO
         I+BC6uCxDQc9YIfi2F0suiyzSGwkIIm5j1LoHeOecjSx9SUVeAogMHWfQVQ/yVN4EIV2
         HyRVWs7ikWKEYV8Mqn86+Dk0D+S47jCBCBuEF2tmZK1t34E966pV/edMPweO5A6GzAB2
         aWy3U/PLorMF/XVJ016YNMqfUmb+wT5/1LQjrlgmGHK1cvnof6sp5c9Et+5zZwhyvEPf
         tbo2zujr08MboRtMdiLPrLX62WfTrOR3YStReZPkbxOP/HT6gxwKURnFetmhkkLAbHUj
         Q95g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788561959; x=1789166759; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrnHtIvpjz/uqJ5uOGmxhPsYco2Z+1zJP8vDTEwM5xQ=;
        b=hNO0eGrH9i0gkw3MkFI1s1gxMTWBZ95a+GuD6KfbZGJFUFT3Y45oD1blAy7NH+TT1Y
         2c3nnjfrWvCBIHvckfOm9azPfek34/8kACfXGDBZIQDtEj24oWqw5kfLdezeuSb8jnsn
         7h2NoqPyK/bRJaUTAxjhdRVpwuFPhAoAAJ/12C35Z6mpF91m24kE2bDe2XyU2QJ7xNTR
         QiI34Bg1oBY0z1MW3lLIKKPkYqVmR8SotQv8vGRmObDxu3oRjYTfwAMonmEOBB2U3aVZ
         KdKyNUP2ZB/HuP9V2GGhDRPWZbwgju8eHL6RcTpNBjiTQ1ROIUz86SO9fMAaAkbRsMl8
         doxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788561959; x=1789166759;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GrnHtIvpjz/uqJ5uOGmxhPsYco2Z+1zJP8vDTEwM5xQ=;
        b=gqupPuOMnAmLm0ylw5xmuMQ8k80FuQTVokz+KJuidwE3SgGyxxPG4tLFSuo1MI//JT
         C67CaUWMRf4ifc/BRDepQz6RLK0AyckOYaXicf4Y+iVq7w5NlhsfqM/QUbJnIoLQ8Y98
         JkqWC8CMyWH6KeSwVMIxgUXWWfjeRv0EhZ7vfHWBFQUpIP6ewskCA0XWzYNHlBSZeH2k
         E86DgQ3dsv1w14bglAFDPtryyCLpGYMsmWbQQknvet+YL4ywkR/ac5NUPFUGZr6GIFtj
         ciXbc3g4Asjo5vSOnu7yYyDaMCKOlhWhRyGI0kpd5MUdKjZsCfHa200HLUEwL6Qrrmk0
         B18w==
X-Forwarded-Encrypted: i=1; AKwUvBz1BxJMqhDbvhXNHh7tPiUvK3EezlLSgAYWtyhyRwglmq3yZIQeMndkb3E6PGffkioifqA=@vger.kernel.org
X-Gm-Message-State: AFuF++nDO55Scr9AkwGeqk/bf3necDosICHY5uyLFheNKO6jBMfcwnHM
	esRyJdLWP53QuM1JyA3Jhj8BgSVlKT6v/Js6apb38iBucsaIkMf7QJJ6u9LXcJ9BKS4SYaKXCBh
	pLxva3njbjCB/qjkI4EPdj9TgXQWqA28=
X-Gm-Gg: AYBFou3IR5Pnqvw0NQeRDhn+5MOMJ+30IhjEfYd2JwvJbt6cAdTnQQUueZZyM6FlSp3
	RWZg5oolzSI6QPH6TlaxV6AmtA5LRxTL0m/D24wcfu3MwPAfBm/Cu8W9reW47SaZgdN4IPnvvWx
	R5W4xMrCgxMNZ0ZUECheIoMTZ80kPKODV5qCdzBo+VCKhofsGxAv6eWhnM8OpJPFF6iyAAlpJVW
	1BYy1a2zcVT0dGrEOoQKPcl1jcNAyn149uOvvKY8UUSGk2atcShaVgFZ78Gy7zE33trd4qBmo8h
	0YsTObSHy/YpBiSGqi1v+u5AV6rMCqocS492V/jv8wh80VqW2mEHEkMY+JxKzOlj6BgES2KiONF
	7WYBS+HDNb+XjNElhzCvXqWY7EEsaTsKO3sg=
X-Received: by 2002:a05:6102:2d04:b0:785:eb33:87a8 with SMTP id
 ada2fe7eead31-78a4a883885mr2941042137.4.1788561958497; Fri, 04 Sep 2026
 15:45:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 15:45:56 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 15:45:56 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
 <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2026 15:45:56 -0700
X-Gm-Features: AcwNN1U762K3TMQE6qagfL8WrE3L53siPKjqrEEND1B2iiWsDD_DYDbl5wQnGUg
Message-ID: <CAOLa=ZQVRJwRqapa8p+fdW2VL652vh5=TJ_ToNGXXM1z=aiXBg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] odb: stop registering in-memory sources
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000320d46065ab0083d"

--000000000000320d46065ab0083d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> the object database has a list of sources that is used for two
> different purposes:
>
>   - We use it to track the list of alternates.
>
>   - We use it to track temporary in-memory sources that we create for
>     various purposes. Most importantly, this is used to link object
>     database sources from submodules into the main store.
>
> This dual-use is quite awkward, as it mixes two different levels of
> concerns and thus as a consequence makes both harder to reason about.
> It's also a source of bugs: we make assumptions about the ordering of
> sources all over the place, and we furthermore assume in other places
> that the sources only contain alternates in the first place. I don't
> think this surfaces in the form of real bugs, but I've long disliked
> this dual-use.
>
> Furthermore, we want to migrate handling of alternates into the "files"
> backend itself in a subsequent patch series. This is most importantly to
> fix a performance regression by making the backend own all of its
> alternates, but it also fixes a couple of longer-standing design issues
> that I've been struggling with [1].
>
> Most importantly though: this whole machinery is not even needed at all.
> A couple years ago we have already refactored our codebase so that
> submodule sources don't even have to be linked into the main object
> database anymore. And all the other use cases where we link sources into
> the main object database can be trivially converted, too.
>
> So this patch series does exactly that: it removes the mechanism to link
> ad-hoc sources into the object database entirely. This ensures that the
> list of sources is exactly the list of alternates, and that makes it
> easier to move them into the "files" backend in a subsequent patch
> series.
>
> There is one exception though: creating transactions still creates a
> temporary quarantine directory. This mechanism is left as-is for now,
> but as it's an implementation detail of the "files" backend anyway
> that's not conflicting with our above stated goals.
>
> This series is built on top of 1630431f32 (The 21st batch, 2026-08-31)
> with ty/repository-fetch-if-missing at 508ec9837c (repository: move
> fetch_if_missing into struct repository, 2026-08-15) merged into it.
> There's still two merge conflicts, but these are trivial to resolve: in
> "odb.c" and "odb.h" you simply remove both ours and theirs, and in
> "builtin/multi-pack-index.c" you only need to munge the parameters a
> bit.
>

This was a bit of a dense read for me, mostly as I'm not too familiar
with the code here. So I can not so confidently say that the series
looks good :)

> Changes in v2:
>   - Adapt `cache_tree_fully_valid()` to take a `struct index_state` as
>     input instead of taking both a repository and a cache tree, as
>     suggested by Junio.
>   - Link to v1: https://patch.msgid.link/20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im
>
> Thanks!
>
> Patrick

[snip]

--000000000000320d46065ab0083d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2f41adbef5710836_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xYlNpSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMk43Qy80ckpiSlZOVWlPSWZxa0VnU1FPV3FpSnVUWQoyaitBWkZ2MUtR
WnA1VWNhaUVyZzZiam5MamdFejdvRlRWbFY3d0VVUy9vT0JvVGplSVZ0MWRqTjRPcVFZQkVYCjhF
ZjhJUURuZ2dwR0YvNTV2T2YyTng4NDhWK1Q3cE1DYmM5UUxwVk9KY09rMmwvaFhyNXdNNDZ4MUo1
MFhBRE8KUmdYaWZYQ1djUFc1ZFpzS0prb21KdlJTY2Z6eXFkZWd0bFM3VGZUOXFFTXBVbW5aK1RD
bzNFS3VBM25vNnlvNQpOSUNWUzFCQ3ZqN215SklIc0hPNFplK1ZRb3lxQTZZNEJlWXVtQUJhQVh3
a2tkWTBydmJlTkxTaWN2MjZhdWVQCjFWdDgrVkR5TUhTRnVud05EZGMyVGQrSHE5ejF4UUFSNW1Y
RnQ1UHV4M3hJdklFYVNlZGtvOTVvV2tPekR5QzAKcXdBTzZQU1B1WGtGd0I0UmdLYVdKOEY4bUdm
dDM5UEFDZXpKZzhSSU1pT2gzTHFaUTFETVcvVFhZNThkK1FuRQpTUGFqZXZNS0pMNVQ5U2xYc3JJ
OGR0K2FMeXBCZ2N4Z1Uzdkp2VzNvbGtMVkVyOCtuYWFwZlg3MUJjQTlGZTFDCnEzNitEdTVSZzR4
VE9GaHM3eWhtZWRIY09ZY2hLMkdleUszRWlRdz0KPUVaajYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000320d46065ab0083d--
