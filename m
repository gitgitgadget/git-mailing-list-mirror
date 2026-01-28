Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924224728F
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574821; cv=pass; b=NKzjL6PMKkkcFFyxds9K8avHODCt7k9benv54zYbmIbMgF7q0U9y19cyuUpflWdPeIlH5921dzD4lTAyna88FFfhJHxMf6xBzoCRuopfol4FH2zDN7n7SB52m/ntWd5VTvoXWvi5vWt6eNupMjBx4lr2E+2iP4lqI61sW+f0Wig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574821; c=relaxed/simple;
	bh=yicGsCpAmMjJfHZu/CdZdwGwkiP1E3k6DjK7dYb8r5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FwGKekrABRiM/F+9kvuTt8uvLlBjGcVsQU/J88FM2um87bLQxUq8GD/ASY9sGSpMJ8drr/1SCl7rthAPHsbP5tWdMdQLEXwWA5+9ouqCxt0jv9oMG4g2EFwLu3hUOVjP/NnODRffiz/fzLCgik9tSI/aoaJubu2+XsdKmCgZhUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTBaLIRb; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTBaLIRb"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-658323d1c91so1022342a12.3
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 20:33:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769574818; cv=none;
        d=google.com; s=arc-20240605;
        b=FJ1KUTBmHqrZECmWGEvMIeGXnFVAt2AxtHbYILIxSmX25uCgDp7IkNepSpfaApCT9q
         9zgDOoaN1uE/T4tj/P+5jj6NhmOuyYcl8IWkFiYAAYzOQotpq1lrOt1fbZ3s/6wBlq8t
         BRmS8PDhoBfoJHU1y3qngYSs4KJ3LBzzL18JO8PYh1no6SuPL0ucMXnEbpLI5/1OtQSy
         8dEMlgfSSRJxWu9vds1NaXAs0IeCl3Vx1/vBRyJwxC6Wi56SeYDhtYNM5kAog/WY2NgJ
         Ahnm4sW5BXaeyofscshKYfFn4lFvoWAR6GzDsUrPZ28uXEDoqmSbNtbBDoNfLJRusUKI
         S6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yicGsCpAmMjJfHZu/CdZdwGwkiP1E3k6DjK7dYb8r5M=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=f/EcakHOnUm4lbN4+fypb5UkpYuMw3zBsteUwhOZf2X5OVQ75Xf5n/5xGh4woC3zXV
         ncbsOCYI6ONs1wpGJPFn8o+AnVsrcnav9fyOMQvLVnFHwikRSX5mbSXr5Kb7ryGePcxO
         mt2/l+skmlo9hcJwgHXAeOofYFaov7LzZdTu0MaYyBtpgqDQ9P6AnLeyw6GaC2BoHRgW
         Gua5tKrPxXkSWgD9SF1rKggL9Z9eV6++/KhaUUE51Am9QB5s77chjMdJzcbUiyF5hPj8
         jcj7lL848Skb364Q4h0sBqGrpMFutdkOvI9Uua576YG9UGld/JHhWN1h2NuT06qGBLL4
         udig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769574818; x=1770179618; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yicGsCpAmMjJfHZu/CdZdwGwkiP1E3k6DjK7dYb8r5M=;
        b=BTBaLIRbXF/rt4L2ThWi4Av4cRq2TfJ0U9zCNYjzh0NZyJAQIojkh40Ipd4RG23QHX
         sdjdebOU+n80oDhRwoOvujKVlxlbGVDoGBB8LSejbRqbrCm419/rY0pOGi7OZROMHMFq
         1hBl27s9jilIH8DuKhEEFmhiXKVfvLnUNQTfB1SkR7SsQG3g1kpJ/YeMh03H3zWuqqeH
         +BV1R68mZLhmlYHrjKpBI9pEelmPB42QJVtOa+FMCwkE5todF+x05wtcdECGDsp2PpMT
         zXQa1agcS7ECdkZOuU+8VWojRFqg9zoxeD4sgFl6wr3kMSAQmWKTZd8zi9MlCIZl0Btq
         mELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769574818; x=1770179618;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yicGsCpAmMjJfHZu/CdZdwGwkiP1E3k6DjK7dYb8r5M=;
        b=STKCx7HKQvhl7W9kiS7aGDd1rSERWbS0ga3aeEG8Mm8wSRaDkFzLtmWYCo8m7Wp+oR
         CK/zvdMCvEw4zyOBDflCjnWwlvg2NRGhINpT5dPh6Cjyi0WX81MC6EVGXGHqOts948Gy
         8Ccdf7QWrISDgOopVkR6E9CkTPi0jhoj0fulvvZPPV5+4iacMnNEDikWLAR83zK4Q+sA
         DhKCZ0xKevndXYo4RoSu67JGiXAV82aZewK03krc09MwWV10BksjSVxOUnUDUKU236gl
         VZT9WCib2R1wPCK+zdkMNwCC8P7W7/FcUeBXAhghVamWj4Mfq4aehe653GyC9dGz64jJ
         XpzA==
X-Gm-Message-State: AOJu0Yx2jqb1AOYaceel/wsGthi/hn/mkD7pagCIt3TZESNqPEjba4Wm
	EaB0VBNJr1oyta7+jHaM2Ye5g+Bihn/euwiFJ+INHuM7ZJpDyGOrzrz5o6Gci/YmSXVU79KTSnn
	HpdGDfuGU6Fnkmt8Tmq4FszD+I70CzK4yoUwGxUw=
X-Gm-Gg: AZuq6aJnGiTiw8Bm3aMADK635eVf/OfQjGo6ZC8JbLwU9BEsytOdSZ5jb/mq+k6Qv3b
	s9JhUJPGK5+eZQDnhfhuIy4fQz5M7mNjhC77wVlMkcA7JwKfHh6y2c3knQDRpfM+Nv6+J7g7A/G
	xZSBUNFJtWYMCfeJAdrqiLXVckfBYBH+AG46bOPpoKvfXYQJmqFCUhgQhmriqDmIybEeP2iRGlE
	l/5brXfMfGjsrg7VSRhGBjUezoD4PphE61y0R5DL6+s1x+8NVydyIicZpgoK3kpWehEAQ==
X-Received: by 2002:a17:907:8687:b0:b83:95ca:22e1 with SMTP id
 a640c23a62f3a-b8dc7f66c05mr24838266b.1.1769574817932; Tue, 27 Jan 2026
 20:33:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126165618.596944-1-a3205153416@gmail.com> <CA+rU_o5pzpHvvo=PwMV1-JUUa37Qp=B+-X3QqeXh-VRdNdA9DA@mail.gmail.com>
In-Reply-To: <CA+rU_o5pzpHvvo=PwMV1-JUUa37Qp=B+-X3QqeXh-VRdNdA9DA@mail.gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
Date: Wed, 28 Jan 2026 12:33:28 +0800
X-Gm-Features: AZwV_QhfIzWNBoEATIWN2ks781tENPKrSlBopnG2nBGIGDPjCeHzue8RvxwUFxs
Message-ID: <CA+rU_o7dZB=OCJHk9nGSbs4RLXmE9A3VUopa+6vF6oX0E9vxuQ@mail.gmail.com>
Subject: Re: [PATCH V1][RFC] t/perf/p3400: speed up setup using fast-import
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tian Yuchen <a3205153416@gmail.com> writes=EF=BC=9A
>
> I noticed that while the setup phase is much faster (as shown in the comm=
it
> message), the actual rebase performance test regressed slightly by about =
3
> seconds (from ~2s to ~5s). I don't quite understand what led to this outc=
ome.
>
> Additionally, I haven't delved deeply into the technical details of
> `git fast-import`,
> and I'm not entirely sure if my approach is reasonable and compliant with=
 the
> specifications.
>
> I would greatly appreciate any guidance from those knowledgeable in these
> area!
>
> Regards,
> Yuchen

I highly suspect that git fast-import generate the packfile that is NOT del=
ta
compressed. According to git fast-import documentation:

>...For this reason it is strongly recommended that users repack the reposi=
tory with
>'git repack -a -d' after fast-import completes, allowing Git to reorganize=
 the packfiles
>for faster data access...

Could this be the reason why it's even slower than handling =E2=80=9Cloose
objects=E2=80=9D? I'm working
on it currently.

Regards,
Yuchen
