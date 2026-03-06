Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9C3264C6
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762414; cv=pass; b=FEAS28w2JrhauIx0/0z5iy7XSo5lA7kwQc6/ADP7+MytVKNlq0A8fwzBEj0klrYbBxEVmxIyclFN5ymBwpOw1LN8eV1zYyxtzKw59H98RYGQorURwjOPUie1HuPpKT4xpzE9hhylMX6+VwaFCCTRq8xFanurLgeuI3OOjVdpmtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762414; c=relaxed/simple;
	bh=c4NiPN6LmsuWNE6+SGMBpwhzSrDuluFmLkIXUZoedPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbBS5YMcVxnvpA0sSscecN70aGhAGhiPdQlGioGDtcsgln4R8Jsp6HACWjkY41aBpMLxOSHBdywwhIXRlmoKEV6ivO4FWhIbcCbZbuJ2KfaDTXvFDS5CxEGjzDEB6Yhavs+N+zcOkXTDkOzY9xV/xRsNtlb66dvI/cjb0RiBfQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnfpM9qm; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnfpM9qm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506e287dd53so74988791cf.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 18:00:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772762411; cv=none;
        d=google.com; s=arc-20240605;
        b=JeJjMV7PNRWEeCMlFCsS+3Ccp+fWUdbnrLaOhCjZ0Yy0fmLF5otoRqwgY8tj6tpmG7
         stwdWwm0raIVHTrF4ORskd9EsdjcnhwV78ir8K0GgF1/2kFglRQjvm+MZCeyqCtaeJfe
         9MWtMAN9zELijxk4VnzQPdECgFfVUu1FtwNVlUN1JnX6LwymE5nSG8u4O4MdN5aSd0M+
         VPGlVn5J1kB4WMzYlhjc+J9VtemrsjrP+QlulgHOfa8g8AawlrGTZTkmWa9MVSq+GhCo
         L7LfsR4Q1mCcoVKGwmLX2bAp86Y3MG41fTSe4GKz1L09orgVlpL/dCeiel00ThTX/cMn
         xM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5oZ5zWoqBgG26iWeF2lLz9dL4+a2cxCzSItQiD7l56w=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=VhH0Wx5Ln4TzfTAW5UOxSyrhwP27Wib8YQQZ2OVdtScBPhilLjH1oNi8ZSXSqvMtao
         ugUwW5e0VLCL73hUdhwGyl+hh9+YSIVx24RO8ycLpp0rnbQSjgB9sXWF0bjA+rta0+BE
         y811AcCegtqom/hOHBAhWolpnoVQh3f9QOMiQYYGbO6JkdN8Xabn9tYy7a8ksHXCrhon
         HXWu0RAWxm1R8witdoh+wKftazbvdHAJw8xGPkKBz1ZnteT1qCqQbpFgvIFRlhk1EhOE
         l60I8X+iZ/VwIDH8TxSYtETCTjxYDYJKGC7HRzpQcaIranUqjSxWLvk95Rq/dpO8Aiwb
         ukOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772762411; x=1773367211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oZ5zWoqBgG26iWeF2lLz9dL4+a2cxCzSItQiD7l56w=;
        b=WnfpM9qmPQ5VXHA+37nCuTlPBjymYsakFxCqEE9tLQTW/fbQdhiqHFZUEmMRW2sSc7
         uERBlBuGAdIdKl9L2/q068yI52UEcEzpI76ircKe6/GPUtJ+xGRL4KXlqZdBa4Dv9gR3
         eMpzDFhbHVGg2ugVZ3VvhwDP62/u8T5Qv/SO7ifbYhqh+nWz7OmD9ZjPfLI38Y9HM4p2
         YyIBrCnGdooQ4LElpk0eJsNmpl+z5TcibUan5xeOyISXW8spd0QyV2yFF2RqwcCmX2Dt
         L6NYRVJm/NdRHrmwPfAUrgjheTdOmFB02TFoAI+RN09vZ9SI5Iptss2XzRucFXYlyIVJ
         MjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772762411; x=1773367211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5oZ5zWoqBgG26iWeF2lLz9dL4+a2cxCzSItQiD7l56w=;
        b=ltfmc+SgDn8FicYlQKlYFsJQJuWGwbq1d/Zz6m6KkY+w38fUXAC3jr0822BxbJSsPq
         sWSFIxy08CQwswg0bFJG80qeuouEC6VNcyPpNzk4/uUaUux/8FECO1iU4r7LFS5P0W+g
         Rmbb0tcLHF3/WohknObQo2et67F9n/Dv4Pjzy61CVMDfadHHiKjbEscdxTKVOhz5LRyc
         KNh9GG1YI1hMOAUDhGCTG1x4vJK1zstDrj2eDBwiuNslbUhg8M6hFUlg/2cDz12KBMwZ
         8mJGA7UZtG2ZYpwOitDNczXaJGuIQkVysbJzv3R8HTfARnOGQKotarvcqvP5Mcqy0F1v
         1CSA==
X-Gm-Message-State: AOJu0YxUlUaqbgB+3f/sAh1b/9K54cOHJntyJNphfc7o8lVe6czlCr0L
	dq8KAkjKYieufi5FEexO+2e4Tyg1TkrxcYaov89TAuBY+X+1NAebVEd/WJ+y9U9WTjPsbpM7kua
	kE72/oSRAspsSoJVs4tZ8J94CGQI16feXL0Hx
X-Gm-Gg: ATEYQzya4zTcNHHyMLOVS9om1wB9zRD63J2Ocv8L2HodcyGcdCk6ac+L3CFmUDtBJoy
	DzTb8zAWfn8J6pguTQpRETziRJddo38C3642FVX+lio10OkRIYhrJIFfZhY7L1SJrr4e3fWw0zd
	uOvJXGwHoRVG77urQCEaPwETB6e+ml2RgZiMDBhsDdZb3xxFLDujCf+OUCC+v+YZ+/L58c+jSq5
	cjWMGo2ye1z/nShkdBCAGpgpSVbVLqyxF/xUcl1de3leX/92ViHbHPVtcANf3nDjm2bRbU9cVoy
	UCAmMyJKGVYZjMoLgj8ML+oX9ekCuHCCX7/HZY8IXqv966jzIq2/Go6AjZSyGKMcOnyqdfUBpTw
	+S62W/Sn5LCpNkiNQeYQ60LzBlg==
X-Received: by 2002:a05:622a:15d4:b0:4ff:b3d5:4f6b with SMTP id
 d75a77b69052e-508f49795bfmr6639451cf.69.1772762410435; Thu, 05 Mar 2026
 18:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304130502.8475-1-jayatheerthkulkarni2005@gmail.com>
 <20260305125332.27600-1-jayatheerthkulkarni2005@gmail.com> <xmqqms0m2hn1.fsf@gitster.g>
In-Reply-To: <xmqqms0m2hn1.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 6 Mar 2026 07:29:58 +0530
X-Gm-Features: AaiRm53RIHWZIjbzIDUPPmwXS8EskVTJhfNjJBV4B0o8RG15RvZbz_ckTAgWTus
Message-ID: <CA+rGoLdzfPiKx8=4qboU1h0hg6z=j904sesWV_6UvYrE2TvWVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] clean up a few things
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 1:06=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > Changes since v2:
> >  - Update commit message of patch 2.
>
> Hmph, they look identical to me, and more importantly, the previous
> round has already been merged to 'next'.
>
> Thanks.


I just noticed the commit message actually had not change,
that was a mistake.

Either way, since it is already merged to next
I will consider it acceptable.

Thanks again

Regards
- Jayatheerth
