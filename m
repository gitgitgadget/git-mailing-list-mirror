Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC82405EB
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817354; cv=pass; b=LWqnK17ocpM+ScVH0hE7AFln/xLT69dnvvUsPA6n9R3Y3tfv44MK+v9NdQLHCAiNuKgzWcSdLkus+IWdoKMLiqwzS6LkJeeu9r9QpkOD9vTyy+NVJXEKDc34kuBpMTVwugyiO8WHlijYPDhCXDFy3UmWo+pkTYlw0x9cc1M9IVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817354; c=relaxed/simple;
	bh=/eoVV3mE7u3bhU7DFzk+dJwbCzFWxsXUIwWrikWlEKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F5MsH8xYCz1DPJo/P+QTdjdD2gs6vT3vSbQkBsxQ8WgKRdegMj82GFVugKvSKx1NIW5ChkBpV3wETIZlBxvafM8akfnl4WLF4J/77PUC1Bbn9KPGSWdptNN5+m2Ik8Mfw8R8HKjVoEbJ8FImdGYrtmN9waMMJG0wnOoQ2/gKLug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3t1j9We; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3t1j9We"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6acc74fee76so1214340eaf.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2026 11:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786817352; cv=none;
        d=google.com; s=arc-20260327;
        b=mOiQ98yvvU4GG6maaxI55efp9XEZWFR+UeY5kNQoTQatDEl9FHCxVawHo5/pu1wo74
         KnKkGjIn5DK4Uw08Cd4hRApjvXQ+kdQOBMN+CxEpBUB+T7ubw4DFodN3NlbABdDWFO7+
         rgSDjkziCBpFYLyvEJD8T8K54RI0G7IQpDI6DMwI6IXwPH0C8dyZhRbLGiVuj6XxWycA
         T33JGPrFxyKmna2zuiLLGf8pI6v+qXsYwQCUEeIz4ZGbGGLNNsxWHpAgs14lIx8oXI3/
         JvYkmMSRQmhjA/kLgtoWKlmebk44LNz8KHOIWWt6/4e3L4g6CA01ixxWaYc8jOIyxb3U
         E8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=i2lj6+X55pSjX27BZ6G4Ba4qq2F0Y7ILclRmWOUwegg=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=eOTIZnGe/i13PWrAf/SOR007lEuvca/SuwbwslsyDo0AzrbUwMuxC44eIF3uKTDR8s
         RoCiHQWPRq4fMvt0JZfFBDpiPdQncJw+eCu5QzWOeTMEVnCiiWWTkEgJKpsWV2cKcu62
         BDYWNdBG8+k14aePg5IQpFcJD+aENpzgPQ7REKj/qmULmAST9dATqT8qGEAa0+Rj2LZV
         te8jGqVTFxsR58MBY2dt3rCSDcI2RR0s3SoNkrAZfFq+yupulmrfj6/mVw7nzMtt8c+8
         lm9wcw34E+C+MyTlPKMWB5zSIdRfM9Or6+JigUSSh20JBZPbFAFb7kdBl1ez9gBwqaER
         0Eyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817352; x=1787422152; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2lj6+X55pSjX27BZ6G4Ba4qq2F0Y7ILclRmWOUwegg=;
        b=h3t1j9WeXG4G2TvRH2zYvAo3ieSkpF2aPc8JYfpgL05WFSfFOI2dGa9wlDXdKfQ53c
         fJZn3tO/y+aBB+BH5ep5fhvCDMAKAeUk8L9XhaN5wVj5gSPD4i6jGsNPEo4+OFNAsXqu
         s3mnW1GCq/CfHj/RKhQx3i137dykD0rbCU6RGLs1ICyyaMuZc0o70f9RtECShivZScu0
         mw+f3nSnYS8F+8uTHuut/cgis+PhhOjRDD6aMsa8rIGqVNQX1EWvcue/K91v0ABIpgUy
         U6b9EOMsCOB8WRjJaK8Zfl5XwywOLSAgNR0OQEKRUtsPg92K1BxcHSUHQcMxOMXHxdjO
         BCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817352; x=1787422152;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i2lj6+X55pSjX27BZ6G4Ba4qq2F0Y7ILclRmWOUwegg=;
        b=L8FMqbWhwA9YVydsHfTYMouOINH6h4HvuU+IRmHO3wJwdFJZmQTi4kG/iC/5f5PhQ5
         l5fKmfA7ftVS3C/jPWnEkIvDuhi8QHiLigr8QMGNuMF6vWwQKoYjYdvZwjygU6LFir40
         iRVZrUBSY7UyemSY3iwyZJCtRkk0d5MWJGDJVtSf5CoQbVDZDazN1swYoQdbOWdcQK0W
         se77SpLWMX1hrpzb9hZ8F7ZzjNDRo1UE+ARzabUxKAEwqQiv8Z8Qy8IYMyks0E+SYbP9
         SumEam/qHLKYLL8vtbahG/hSkxi6Lv2RBuN9SPrP1EUlwmAIIDmNCkXFdt0GG578XHv3
         PUYg==
X-Gm-Message-State: AOJu0YwG+FrHVmyJYPUNxkzVH/KwrrKZzaTsh+jIe07BKHlV2lTb4wEP
	xp5ogj5HecH5xIKGR13lKKHHdCbmBgDgnJOWdrmar06NTbhQPMUcNJf6e9vrgYrorOcfWBggjWq
	9hkPhOdv97zK0ge3MmRB+hwIVr5a8zBm2ICGK
X-Gm-Gg: AR+sD10fFTLXL6eINl7UK/pQ9g33AHk3pTcu2fSAO0NOhGYeO7PfMF0uj1cR9ew3OMu
	1cOlrCZtsjGslGR1F1AspR/9W3mEdC8oxhvePvP29KBAYqQT2gLcN7CGLdpraZ2G04MhSKzYP05
	eXCQ1b7IKKBzgmBttD6C0BOc4R4KyyR5sa2PFKgjipo7SGXQRfFx8SDUWga9xlJaG3eDkVkKF1q
	RU1Vcun/4iuPl//32b6j1JiucD0RDp9Www+wNl3+tthcT3a10yrfrOxhalpKhy111sNm9/72bXC
	tYR4PSOh7ENhr+MTq/wHi89Gu970/mUQmoM4c3wu2t2HfGOhhjRU/j6X6iiEjBVPwY7TpH1YYg=
	=
X-Received: by 2002:a05:6820:188c:b0:6b0:ab1f:ec11 with SMTP id
 006d021491bc7-6b0d690ae32mr12608237eaf.29.1786817351798; Sat, 15 Aug 2026
 11:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOqWQbKn88m=OBDF7W8bBPjeOxtRsvNmhsqNy9AryMKrOKtLUA@mail.gmail.com>
 <7d0e9933-1a5f-4755-8bc5-fa4fea42f61c@app.fastmail.com> <CAOqWQb+YzvVeqS85qYjQKK8jrUqDwV01eKqC8i1jgT886ixCwA@mail.gmail.com>
 <CAOqWQb+XY_u2OUNnBJ9GBGBz8B73ocHWp+V1tDBS-4a5-OviYA@mail.gmail.com> <aoB4pOTtJ65PjwPA@fruit.crustytoothpaste.net>
In-Reply-To: <aoB4pOTtJ65PjwPA@fruit.crustytoothpaste.net>
From: Peter Morris <mrpmorris@gmail.com>
Date: Sat, 15 Aug 2026 19:09:00 +0100
X-Gm-Features: AcwNN1UyWB9u2nAYcv83sjekVYFHLLbz8qp8hoQnFIDj3Kbmdqcjasq1JNoEhu0
Message-ID: <CAOqWQbL24ZsLfDnc8pzCAdwaumWuoNaJOGz01PNSPxSkw6ZCqw@mail.gmail.com>
Subject: Re: [RFC] git worktree: use filesystem cloning where supported
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> ReFS has serious defects in its implementation.  If the data has been
> written but not flushed to disk, the resulting copy will be corrupt.  I
> just saw this come in with Git LFS[0] and I described it to a colleague
> as "horribly broken".  I definitely don't recommend adding support for
> this to Git until only fixed versions of Windows are publicly available.
> [snip]

Windows CopyFile API opens the source file shared-read deny-write, so you
cannot write to the file whilst it is being copied or you cannot copy
the file because
someone already has a write handle open.

So this wouldn't happen on Windows.

On Linux and Mac it seems they don't do the same. Linux FICLONE is supposed
to be atomic so no problems if that is used, and for MacOS I can't see anything
that would enable this to work.

So it would be Windows and Linux only.
