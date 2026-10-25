Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951963;
	b=nBhMW6VN92+bfLRMzTrmQDmWpJ+62XpGSs9V82Lww1Op2BdtmXuoKyYCk1XIiQ28UgOJ
	 n5iFJGriNYyat2R69WcsHffHoVEgYH6F+Z5coarUquAnDOqqzvi0CHgHoIj+cMITdpEWW
	 rpbOGmVAS9D1rIKyfXwlw1KACpvfenN6lO74dAj/wc/dsdteLYpzUYJNqHlfKVsHIBVFx
	 zEgCqSsRNxP3yMwj0XTAkgml0BCih5Dt9fqKaOhwoGVHfq+FS5nEoBixAbencVi/KWZ8y
	 qRVD2upidvlacWqqT1/EW1es7bskosWF12SnajtkzDBkzfyP8GXMtPoHqLk2QaGJPGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iCjt4NMXyujMSluoTQ8HHaxYBfkFND/DqtpgVdOFFXo=;
	b=ecXmvVGQKsXX8F/tjqI3Dz0Wd9kNI+vJdUP4DsBeMo9yDWgqAWa5HgWcmJB19Qon+EpO
	 Ga1zwg5GWLyBl7Zai+tNm0FNIuQay3pXUeWWsy3qs9dUxcvG9G2jncrcVnF16g+alGwZ7
	 zIX+DnlvZk7dk9aTGVemJbeU1olRXpzuWzeFWTHpOoefiXNeSYgTjN1Fz6BdJ3GnVNAOd
	 uOEAjiX62dMdrO3S5IT4+qa+CuyF4cCYG8LwtIfIMFV0s3dx/ybg5eu+VE+FrDE5Au/eI
	 X+s73QZOyVG7fOXej3gxswhyEBMvpwPQ2hFImbAhEAkjrcx3OSH4BejhPmpvgqFtsiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Vscq8/XO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D25606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 18:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D25606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vscq8/XO
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1ec41d8e9so2333441a12.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 11:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792951962; cv=none;
        d=google.com; s=arc-20260327;
        b=KhXRgPlOusBQMiAQrodEVLQIAOBxJ4JxaXzwpgRAabp2LxGe1dBO1enTPpo68r+sz/
         JdY0uJM4BGk9ImZ5pL537/qOyCFXkZMky9fr5x7ukkj9fKaHox6wGpkWWe7P2MDHmUId
         gpM1iy0/o1dv84tMKRpKaW2QdAdCNDYBbQaFR186kWJl5VlByYnNgEBZXvng5oKheeBG
         KCaAbH5AEXVV/NSqL+yaC1uqpaOEXXMyBaNJSF2Q3Nl//VzRSgQWHNgJjt8KB76+IKvl
         C6A2AF5vczT43xp9EZlL/eJ+x13r1tF11GxsgZ2TOVW2nRQ4kQoFyhaAn/UFnJ6VJeiW
         mO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iCjt4NMXyujMSluoTQ8HHaxYBfkFND/DqtpgVdOFFXo=;
        fh=tROxP9bh/yctZwYZ48MeaLPAWAQGVLtW4A+LLz6gPOM=;
        b=iiOf+BelP+XzO9qoYStXdDosWrqiYQfuNdjQyRUwG45LVs7iFBwzspBxQkTVozoAKA
         19DiHi1etv6xNLndd7a47Sn5rgOsYU2283GkmXAxeSAHxFpZD2qInNF0uL8Tm0/o2le6
         CednPhGbaCQv003B4CvHcgPOltbK6tBfkvjGkQPmDATDLllSpNV+SO8uPIHX9aSS7jyx
         C3YzpCIT3QH2rNRPGZmNR/SUad1CEy9l0HCYCO2oCutiXoeCuqR7Gl7Pl9FM1ILU3fvL
         HBFAq8GxqF5rrwGB6NfS3Cw0xKQokROGdXZar5fhkEXa8VEx50K/YCF1lP07jZXjdPJ1
         MqOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792951962; x=1793556762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iCjt4NMXyujMSluoTQ8HHaxYBfkFND/DqtpgVdOFFXo=;
        b=Vscq8/XOqH3li4/+9IVhQDNFKH2YDpt13TWs+Arp3Rsv7iww9ko38DrFPdk5XDLVkS
         bsm37LwBkKQVaase9ZMC4pV92ffcW8D5/uBHFM0dxS6D37P0n77XwSBkuc8g3qOKSDog
         nft42Uohyxmy9opxazIJO8Ehs1990sgsRfujVxvOwU+vUJGVOiMrLFf8XBV6omMMVNd3
         3HAE5GFLfmFfEq8WxNOSRXwurUsKz9+rSWzCjKh5YHVjTpVpddg4icNVI2bRPWEQOYA/
         alLRRmxILmP6/LA6/BxvZNyNP7OfVDqMTqIKdYiscnoLutbqAPBUQtkJFdaNdtOXkfsR
         vecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792951962; x=1793556762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCjt4NMXyujMSluoTQ8HHaxYBfkFND/DqtpgVdOFFXo=;
        b=WMdmJrfwoHFpFovPzOeddlVg+vJ93vjZfLILenkj5GqMeDb63iHB+ohdBeDtCfVOkL
         759ddh2wylHapHl1CYs1TT+8IswqPH/8lgbF/tjgvmy1rFxdyfN1vCsoatV7ZUqxSi+0
         61zH6NKG2adBb9vVYnj2y7U53Nvpwvk5gQXkj8R02EjUFH0FmqQKbiEOGlkVulbhvkIM
         t/CMIUzxo2qr0ZylOonpOKZcUR+Z1gUQvYf1Bqes8G3XWOBprIbrGfnxQs7tDfx51kiH
         o4cNSaXEDn8aqKWsUMm2DP18608MDEzveEFS/HEMyGNY78xeVbrkGHDaAoFy4m8IhzMn
         X0Kw==
X-Forwarded-Encrypted: i=1; AKwUvBwtKSzl4iBuQzjqj0ZMNufdXFVjjGHk3ugZo6x1I99oW8shR2ZX6uERQTOq/DqAv/6MCOg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6dmFaejob+Zs5m+0hNhLbVu+NHlOH1Uq4znNtj49P9TsqXudX
	9vo5PWvuHTgEVWNKWMmnFvpeC/xs5S8FfrlYlkq3iA1SOh0k3gVb9xS+9UnerfE71dn+7Y5PgTB
	D1w8lQjwPGtgFbxnqS1rIq5ZMlxQoTOA=
X-Gm-Gg: AYBFou1cAK6sDcXFsvmcldkOJrLJyu0DNzk5r6Iu1RidCwWFJXxUF0R8tnLsAswB+Z+
	oXNoog5kpc06uT4tiLSy7ICOMeHGBUFbf8jyIBS4bORj32MfU23mebRdezbTB8bBnPKiVCROE5E
	7fKl+8W+6MBNp+hHqmm3KcPeklMu5efziwbmZMLm+gqSYjSl8hp/dvcCmnq4qFwJJjqBLn6r7rw
	DwnhRcTvwRSwngyFxRSWiuvYkjtP+z3zE1ODlpGOXSjhw7pQR4Ty38at93BFyjIUrdbORtTFjBX
	aRV2bmuRkQ4RL6hrV5gSVgENnp3uE0Z+yIUMzgHeeQOMr032bdj5mVP8kVbmR8F9hmXZo07DLmw
	VEEBTBF1OyjQigbAKre/oXHzA1lP3b5FzKf7cz3G0M5jV7SJu1bGcwrV24Vrjv/n0QF5XZA==
X-Received: by 2002:a05:6402:15cd:b0:6b1:ef9d:9d73 with SMTP id
 4fb4d7f45d1cf-6b443000ce8mr4232632a12.28.1792951961441; Sun, 25 Oct 2026
 11:12:41 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <552bf08971be5204311c96bf232b5da49e852db1.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CBA3oQMm--3VxhbUdDmXfAGjZo9H5bFxWOGUCY=GADk3w@mail.gmail.com>
In-Reply-To: <CALnO6CBA3oQMm--3VxhbUdDmXfAGjZo9H5bFxWOGUCY=GADk3w@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 25 Oct 2026 20:12:03 +0200
X-Gm-Features: AclHuK8lGRTnciaTTzdPbcMuh2tCoWdtA2S1xB5QOq7eKYW8I4w5zEt3V5stWDM
Message-ID: <CAHwyqnVxK+hJXHTttWmswPjb8AzNhkazybOxwrmHG4yEtMOHSA@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] remote: default to --limited-fetch in a shallow repository
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Adding a second remote to a shallow, single-branch clone used to
> > still fetch every branch that remote has, since "git remote add"
> > always set up a wildcard remote.<name>.fetch refspec regardless of
> > how shallow the repository already was. That defeats the purpose of
> > having cloned shallow and single-branch in the first place, and can
> > make a plain "git fetch" on that remote hang or take a very long
> > time on a repository with many branches.
>
> First we focus on "single-branch shallow clones", but=E2=80=A6
>
> > Turn --limited-fetch on by default when the repository is already
> > shallow and neither -t/--track nor --mirror was given, so that
> > adding a remote there does not by itself commit to following every
> > branch it has. --no-limited-fetch keeps the previous behavior for
> > whoever wants it.
>
> =E2=80=A6now we only care about shallow. I think that's reasonable, since=
 we
> don't have a way to track "was cloned with a single-branch" (and it's
> not really the key criterion anyway), but the wording begged the
> question ;)

Good point, I'll improve.


Harald
