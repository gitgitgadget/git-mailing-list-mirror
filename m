Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0492FE567
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674245; cv=pass; b=oxidobL3WzfOjKACtMfbIRmqHKnY4T/+hEAgQsEIKrxv0wSGVHpXlBNlXqjKX5GeKrzOPLhJJejqaK5Y6JuV+d71XiAAv3lZ3GZZGryxJjo65VMFWT5AzNvSSb2FQe5BStqyb7v1SsWmmaSRDi/T/N7dYL3yVsDRnaLyQF5C1jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674245; c=relaxed/simple;
	bh=GCIQXwaKWy5JBDsas6QAhst3ppNxtbt0vciVA0Ot9nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ncs1zfDWJywwqw16gsLwUu9Y9peQEKn+QR48T08eT+xDFDGzqkfP1bjphe9rQYlM6CT2uMjR4dNV1vo3MM2klR4JiZmfRUVuiqb0JIETwPfqsljnCS3xi5fuoEwBqMhPbDuhn81OG3+WUJ4GxJd5NiD0IhdxNJOVGVeQBNFg5Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk3BEMF+; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk3BEMF+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so926075ad.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 13:57:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770674243; cv=none;
        d=google.com; s=arc-20240605;
        b=fME4sLCPDuFGiqIBy9wm2ALa3G0zh1/4D/yGYChFQdSl+82NfA22tPLm9KTuQFq9pD
         nYYJoYmP5mlKp2rCR+QhDJ7SdwdtX+gIkOzh9uG79KSNBwrTCAdYn+ShFR3r0+n0+c7o
         vlev+ZOaa6TzgQGRENN25uBFRB711K2tXRe7f1XeGbGJ9MKUj9xcwBwWQH/99wczQ2Ff
         cC4tZX6BfEqnHTDu1fQ8L1si/b3o8990qF5hleg17UsMIora03jegDKDnu09m+9A16nl
         Bl9lg18yuU/glY6uTFTSftY9Rj6PBBspfDZIFwJvLGVoebm32rZ32rJG/1fPUcIdJXLT
         Hlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+7jWTVQ/qbRPGfVTsT2aBiJz11Y0YvcCpr92xrJGx10=;
        fh=mJbBesx+oRc26OZKm2CZILTBbLe8BCinXbh84KNv+5A=;
        b=GdIQOVa/d+QGsYgg4fYHCZ7WDlj5R4PcSIPHLAytiJpLcikCXQXjrEtGdrrRe6PF/g
         0CdMDr4k9hXbS7NQgkBkEbpPnDuE0cpwvC80ETxkajkA1mdAg5tjki9hXBBuh+dDwc/l
         f9s3sC43uuNLr4wBHv+nMcJgs0JZwOu4Iu47PDiYFCn2gmio287QneOgtRlsENiPdpRo
         b98Zm9pABRJveTNa6aIlFemI2vRPClbqgTZA05pPFio2P0ttcjh5hAE4FyfraXAbrt3v
         +9hG5lEGyBWHKDzvkmMRgdbC/2aPn81ELjNec/BnPbnyANoX3PTrgQVxTzq9ZafbByaz
         oSxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770674243; x=1771279043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7jWTVQ/qbRPGfVTsT2aBiJz11Y0YvcCpr92xrJGx10=;
        b=Gk3BEMF+141OMrknPpi9/kwD3HaQrXoC6FWT1uGJVAS+U8Ff1fpLn+s5FNUp0WbneK
         U93f1r7ZFzhV3vxKetVzOl4XN9vpY9gAK8IYnr3U488BllyXFF7d1ZcNtSF8etPLlE55
         5WzD3tnzb7RZ+UTSsrFG6lmksatHqzTWu1IhSAtAqahXhMSUlVFmvX81zquENLpuqoMN
         +/NzTrq77XZ6DAKiQmnO5LlvFzCoXqJ8FYO3NOrSt5kv/ud2sOGe8iHbtcMNTUdMOAb8
         imRSEqamQmgcKleXTEJ0reymRuhOTxYl9rf9p/ghad8V2iNmLQOz+lALSuMijmHx+tBg
         /XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770674243; x=1771279043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7jWTVQ/qbRPGfVTsT2aBiJz11Y0YvcCpr92xrJGx10=;
        b=DmO4+yV4bvE5SI3/uaVKM5QvPFyiZLgKVjTwFrFxGzy7He0Y3FGgUWwSFt0ylZgX38
         bbZ9dHdnXNLqgXr0U2ZY7LlT6zVRHWeYr8fMTe3fi2/IwjK3GsEWGiRHRtqIE+/ZlAe0
         fsYV5vsO3nbY8A30VX+Cbpu985EnG//SQlJVYblw7pCbXXj8gKNjCLGn26ZC9I1Vg6/n
         nue7xk2mfrTZs/B/qLgbfRcUU2V2RsZVRWCl/Pf1KWGYkPY5Z13DJBsPJKavlMFKSa60
         lvfRiNwiRXd4sDYiK33vbsPQ/m5L5b7sQFX4sW1LNTGAgd3GkyDJA4sfS2n0ZEjS6ouH
         9zLA==
X-Gm-Message-State: AOJu0YyCbCxO2MX5UpIincsF8w6PqovqHwWUBp99Ttj+Ubhgwkt5a5hb
	60PM3ZoHD4rry4p4xOJwkPZkFRNZrewOS0gZxhTlVdgvawO3Au8Y0c1O6SNjfjTySvFBCqYvF77
	yWsdRTtJ1n5eOgUlomLoe36hEmMxVg7QYSA==
X-Gm-Gg: AZuq6aK4CN33ed9rDbZSntpM7AMRds9kOBeXDZeCSaDzPRuZ14E+iGRpuIZjykeqtoQ
	oIo1A5ApfH/5AiIhIhlDYSF3TRwWtvpODp5C3miW8qury7cJwRcHzAsM5hcdakUm99kMKPVaTLB
	hSLxbYX2ykdmALjhkbkdh9ezj0I2avaurGSGCFrnkNwizp+RfKldA9Yll/lx0SqsWa0jijNkBvo
	ouGpnIwpFH8G999q0cFDBj/LNz6N7Xt8Y0nAZ2+uyR8o9y5TxicnEQfeA/yCWf+tXnaP53aBbt0
	1zsd1spQH2/K8gCLCTT1M5mt5YVKV02aPr6mV51laqlxgs/5+o5+K7ZpikvgmZVOCxB7
X-Received: by 2002:a17:903:2289:b0:2aa:d1e1:29d5 with SMTP id
 d9443c01a7336-2aad1e12c0dmr76779345ad.50.1770674243461; Mon, 09 Feb 2026
 13:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <doc_link_rerere.328@msgid.xyz>
In-Reply-To: <doc_link_rerere.328@msgid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 9 Feb 2026 16:57:11 -0500
X-Gm-Features: AZwV_Qgpr_sLDLuv-Uln0gi200AiHjQrR2CwFsEXd2aCFgKVLbgAlAhDZ_yEVqY
Message-ID: <CALnO6CAET9GOsNCdmd3_Jp5Qr3Rfxn8cgmu9n0N8s7uNYpCchg@mail.gmail.com>
Subject: Re: [PATCH] doc: rerere-options.adoc: link to git-rerere(1)
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 1:14=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> w=
rote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Five commands include these options. Let=E2=80=99s link to the command so=
 that
> the curious user can learn more about what =E2=80=9Crerere=E2=80=9D is ab=
out.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     Topic name: kh/doc-link-rerere
>
>  Documentation/rerere-options.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-opt=
ions.adoc
> index b0b920144a6..115882edab1 100644
> --- a/Documentation/rerere-options.adoc
> +++ b/Documentation/rerere-options.adoc
> @@ -4,6 +4,6 @@
>         the current conflict to update the files in the working
>         tree, allow it to also update the index with the result of
>         resolution.  `--no-rerere-autoupdate` is a good way to
> -       double-check what `rerere` did and catch potential
> +       double-check what linkgit:git-rerere[1] did and catch potential
>         mismerges, before committing the result to the index with a
>         separate `git add`.

Minor: should this adjacent be linkgit too? I thought yes, but on
second read we really are talking about the command.

Anyway, agreed that rerere should get linked. Thanks!

--=20
D. Ben Knoble
