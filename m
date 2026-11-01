Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793574466;
	b=MkmU6wI08fo7XEijUK8jTDqKk1CipSbd+75f4FG2mUvfA4bX2xLeEmnfYVjxDi0aNtkK
	 qZBRUj19LdfHkCDBt1dgN07+m7lNVSAckfKu9Q8CIgK/GarALFkAIBnGOJO+hHZIhA2sz
	 RI7iTb8jKX8/zT9qIWe9fBYe7B2o8EHW+DeRZrmSqMZ0Rts8SEFTiern1ccyELHiSJeFf
	 xcfW7X6um7FrvJsGq0bAhif/oVpqVfjWDLXyR/Q9zz+kegSuh5tg5EEyOivBp34TJKFkQ
	 +xHTqxbUG5oxFnumbbRhAdJ0RkBfo0HjuVvGwgahkxpvdIGD3YYkF8mqPlkZ6di15nQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=q81p9fB30aQ3rl8uhVuRRLtZZ+2VN1UISBckaojZXDw=;
	b=F9kRJ/MbwFHKzeCKuzYaxiCRupjm1/W+alfLZq4fqCgWW2P6mTy6RF0bsTOny3Yyua2w
	 S/Ss4P4vAt9FasOBkkD9xbTeJ5s8x+CbscliQYEf5+c9PQQVH3L/EYvteL9ayToiw5ycD
	 hpobayTXjgcOVzdpWmxWeGN0NaiJf4jauaPPYM0kdOZO4U2K046I/hGRr9k2PC3TyWtCB
	 y3Z/6H4o5xvXT4vIsaowaEAx6HwZGeANHZbjx6XCqnEZ6zOWydhj+XC1+UJzGJepAV6p/
	 +DLTjpYsKEqCFp84vfIYTaLc3ekp/Y1lJxgNCRRgxmvzlz43jEz2xdXhSpJ8j6kE3Lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u3kaUDgx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248B606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A248B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u3kaUDgx
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6d290b10a35so965061eaf.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:07:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793574464; cv=none;
        d=google.com; s=arc-20260327;
        b=SlSR0+wUT7iVsmnZNTP8ILoPU/oIePT+rn+Mr/+jpFpI9cHmYCmNaR37sticPvNYOP
         MlrxcIAbyY4T1RqyfFmDLkkanHCdELjkh8IunSdp5IB10IcGWJB/X4/t+6sOPIpRHC/N
         750wsQuH+l9+0ROr7QZB4cUMFvUbB/ftqdRlR7s51ityOpaZKJfI3YJ8flo3uj88fI5P
         eruFWEvHfGzsS3xcVBMBSK+CN41u+BKhQmtHIZgBFLXKdYM1bqR1E3+OonlMVEdaf2A+
         UV2MEbt2rUrVRcJANfbHPWpMaVG8pXt5f5KFr030WDvwi2ebplXC/vQ/Aq4bJRRM9fpE
         AQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q81p9fB30aQ3rl8uhVuRRLtZZ+2VN1UISBckaojZXDw=;
        fh=5PFJeBr7a+nhkSJKkBd2FkDf8aw85ThIkZJzXtcSCYg=;
        b=W6k/X4vvNX5ao5zpsc2TktyYCGpKvnYYTlvmnRCADxJDlVDwF3XV9vbRG43Tw/0S7q
         KdHIl93pZ2rqcAJkOcj+Z3FpX5c561l2ucyKixaJ4bLshPm75SoXDaG9Ng9oKgNEhC1z
         pXiRRKC+B7ZXaNRGaUWQUEy5GDRnwCKedg+9PuhSYZyjENj291XDFI/CNlew3N8mnRY5
         9Byiyh2PStLLjRcOAgqBTDCQTFSwORRtH2mQi9BThe4ezIqO3QVKS1J1/lvJ242RAzd+
         m25JFSfl5L+5YYjDpyRieDVxeQlms0Wh7LvsU0pVHioETb/bOumdWj2rJAC1yvdlyAZQ
         8E6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793574464; x=1794179264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q81p9fB30aQ3rl8uhVuRRLtZZ+2VN1UISBckaojZXDw=;
        b=u3kaUDgxt6KReUrjnBDyP6NPsYZUoYYxoararPmybWSTYOWTPmt3NCb8p+hxxqWibH
         DULAiNtMz6kUFEIIRRi37eg8Bd1cHenT2bxaiRfabc7q+GatoGR7HyrkOpxAYElEmFS+
         nmoK+ZKJFl9bEFTnK8aTllWRqVW/qOsWh6jnWN4TJIOhQR4UfDsihYBHKBUvD9hJIF4B
         No8wVhTwq964WFjX6Ti2XLV9z80SwaCVRPjTPmy3MEUPODREdQLL2SsHbV7j4XIa/oii
         rTDo4JIXZa8NiVr9ZwSO6BEL6NuazO/4oXVkmUYht9vpO8XqbPBE9OJIexyy6C8en7ap
         VY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793574464; x=1794179264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q81p9fB30aQ3rl8uhVuRRLtZZ+2VN1UISBckaojZXDw=;
        b=eTxlpItJs7YYZ6TYHebARrPHeRW0UzCt9YzKECapd8CfczCKz/x0+TpyowGcozMAGH
         eN2UF6VeoiyEapW/Sdl1ZUknez+XMsmY+2al4xdKJezjV5vukNRUnaw3Ptpk5xdX1EAO
         4ovzWkD3XD29mGLKObK21Je53JdmP7SOJldM2NpWc79Cyd9/GVS3NSOTRR+w08WUlemZ
         mWjFRXe6K0bT8GynOP82EbuHuRBPItpvf7Y8Cjj2lE1QZSd7jwQN4lu2oA6XT/zJP8Vw
         j5WbisxHITVMqC6UXWm6oZJev9nLMonGZ/1ASZH/PPMW1ndiJEHc2OiNVFPnU1c50fJk
         n8eg==
X-Gm-Message-State: AFq9FYK6p4ibQnFeVK2d/BTkFUfvsofXEEBqCmEHCcY1APrr/5KsUJFv
	BOP3aQrcAX/2/f7AkatrzAsnfy4vp4W7CLrcO/MWcS/i3EqyQwtmPQ3vFCqnSMbRgv50RS7LKa9
	hxzBi1pkszMuho8ibZgzy93r1Fk6jj1E=
X-Gm-Gg: AYBFou0OxSPotdxiwK0+5XzkoT0fSyaMPmHCr0xnfnHdg/wlplf+CfXEVCZdC3Lphsy
	C2E16LiKcbzn+uaGcYa0JzGuRqm8LpiGed9SZZynCNkZu0fS0bMZW+raduQOlw7APW5HbjWzbXH
	YnCFjAGm/kF3Uzmcdpg6Eu1R6SXtYNT5CTHxpQjEbTUIjTB2t5JpRn0WTdPCnrwXaalqlWYjtax
	cHpOhdID4ktSI01QRV93xRQTuwohVAeofU5WjnWxH+H+LoOsSJXx1F3osdaV2UMb1rJSOYMfCP0
	7AhqD2GfnSBYxd9cgLLRpjB8vpBrAJ18oPxlaKb1Lh0d/t4szL7rAr/HVuuqLDPH7+spS/Ndeka
	o/vGebBv76ul5RKhNEXFmA1wNQxWJIWtZ1fHKt0PhUMimC3CZ6NVgJCRC
X-Received: by 2002:a05:6820:55d4:10b0:712:c3fb:b4dd with SMTP id
 006d021491bc7-714f2a07b44mr3487440eaf.58.1793574464523; Sun, 01 Nov 2026
 15:07:44 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <93D20D7C-E19B-4A41-AC10-4AFC8330E844@jvns.ca>
In-Reply-To: <93D20D7C-E19B-4A41-AC10-4AFC8330E844@jvns.ca>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sun, 1 Nov 2026 23:07:32 +0000
X-Gm-Features: AclHuK_hmuylOaFwaDiaoD3-muEfKYSee1w-mbOqegKqSdUzPFoim8lL8ZkUWNo
Message-ID: <CAHWeT-aG1Uubq6eEXYk=TurnkhbF+tYh0dU0Xxhj4m4iQg5siw@mail.gmail.com>
Subject: Re: [PATCH 0/5] root refs vs pseudorefs
To: Julia Evans <julia@jvns.ca>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Oct 2026 at 14:21, Julia Evans <julia@jvns.ca> wrote:
> I wonder if gitdatamodel.adoc should also cover pseudorefs and root refs
> in the =E2=80=9CReferences=E2=80=9D section. Right now it only says somet=
hing extremely
> short on the topic:
>
>   Git may also create references other than HEAD at the base of
>   the hierarchy, like ORIG_HEAD.

I've given it a go as part of commit 3 in v2.

Andy
