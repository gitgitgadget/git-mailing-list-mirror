Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF215E5BB
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317042; cv=pass; b=UyjTUXMEL7RrEb8i5vwzULlAN0NwgPe4JcSK0brjHmkf31wD3DIVntto8UMz29ZX1d+tRUXiYIrvelYSggicngaemr7QHE23BjVtebavCMkB13iEwuoA0eosmG6e+sEyRePb/2kjr4hDjQmrAi7mL+o7mCh609ELWyVJPqHX5so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317042; c=relaxed/simple;
	bh=cYw0I8buhnEuLKpEYH36/+Z9sgwJ3ZM2KDV6FhZKV80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHWM8XlO49ktPvfuGd28ZABNAgOUOnjURJwZ6HTSOZ4DlQhIh7AxF2I6F+v+Ov7t8E+H45j54tUk3F8EgvltmWnxIDArU82otqvaKpqvFFyzMP9bqmvrh75lj3AbUofS5BIpp1yu+EaL54oQ6xFGBJJAQiUrFiUNQXr1CjF2y3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG+DbpCr; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG+DbpCr"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e4a341d177so19105565ad.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 13:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791317040; cv=none;
        d=google.com; s=arc-20260327;
        b=oSlsF52RFGZLgZ1Ag1k389I2yr2JySqnLri/VCuBJ9A0t4bzC08wdkWpIoYvYO+9oC
         k+Xir0eqoCNG2b0kibKaOF7t7IMZWF+IYa4jwlb2xLlO9BAszwIy0l0NUzvCx+Ujo2of
         EblBcTmKuIf5RSPoj30R+0bGHrOSAaNHB6dwZKWhepqUXpWAX8pOpigJHr2op+DGcD9o
         nmpNPxv8twvLoxK02B9D0Ue1BXXpmvQeeJM4byeUavgHDsNCFaWHBELM/LEb1n8UJxTE
         Czx+wRQIZvkY2+5/faKOnLcZlgvidW9EfvfOYPGK3uYxW3saAYPtAWL5uK6n3yc5kLEJ
         OiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHNuEI24XDIFxKpSAygtuTw8JVWL340WrzvqsFuDCdA=;
        fh=aJ5M2waAHRLtBDQiO9CVMVKG66TyW174IWgd5Sq2sSI=;
        b=rmkoRpDXuZ3FwCd7jgTedH0tZH6JTSgU/vjG1w1hAf+UIDHv9UNgp2yjvcF1CpuLPt
         Z1esCCuhVCRKzKDix4KWCs9egv4/L05mcxk2oa3z2yhtPVDsQ2MTOI6qTm49PCwd13ZE
         lgcLtbGABJytNhisZwgnEJ6GoitMlXKyKo3Ijt0EJZbD1bqFrrHoqNQghvOdWp5y4Qc0
         Lth29U38WWs/0DZVbk81Eop51h9pqK1cPb62gKPpbHtJA7mC3EcXMkiXv/DobVb7tPbu
         c7Ru+BvGwb/+zlHS1hZK17Ka1FTJcPAo5TMN2QGXffQS+FsDVrQUHgHJ9rWYjiEE01gf
         j8+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791317040; x=1791921840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uHNuEI24XDIFxKpSAygtuTw8JVWL340WrzvqsFuDCdA=;
        b=YG+DbpCre+5gdogCWqLGofj97wgTMrpYJLeFQgqO5WTTcG/hR3/e69C//CNI+lZ5rJ
         yjQjxFJGeSOOfbWQIHycLmCusA+6FlMKXRb6D1DLse5btGRet1Y5zj1zD1TODmQ1+PDw
         dUpb1flTiymhuTDduFEg9lmQYF/gEJzkoWq2x+DlawnsUYPLPXRfIPAjNcqEJ/OK5UPC
         rtL68zfm7sI1EqJCkSMIvXPUC3mpm2Rmv6lnyn18eu+uFsfuiBF+zRnMoxH+GOlNqEKZ
         U49cP/rJ16e4TOubDZFbfP26uUpasv9iKaV8hLjMDsKaAokpSMj4mQkUvERclZxKlEoe
         sRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791317040; x=1791921840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uHNuEI24XDIFxKpSAygtuTw8JVWL340WrzvqsFuDCdA=;
        b=H77Tl1qbtnruvehOIis09Fy8xFrJTltwkowtjzdGICTJ+q9R9MQMfJ8GAEtN7xCTRN
         rXfPO3NnsHy6KfvKblOfcYbM86l1P9oXMoF+jA1Io9Ro3jCNiQCtSwiNQJq5mWOMuCvb
         BASz4+rKQLGxRylbFAow0o/MFm9xbNHSmKSVms6lRI2t+KIgNVhG0JgyuzYUAyw9Cg7V
         MbtljzsJeZInOX1rq7xTHFQ5pEefIV+c8V0nX4S9ISXP/1LSyQk4hVaru1m/XMjpSpgS
         6sOotu6YBdRgCWFMN2BnisKFSy9+wc5ME0LH7YJYl7XbIENNs9Z6HyVu8IeccEOsakDa
         swmg==
X-Gm-Message-State: AFq9FYJI4H8U3GUyc8e5zJ/jShuGGxoQwb1h+Dm0io8dUfE1h64rDprI
	q8EPfXb95HR+XWZ7lVmouJlJDxK4ZjInX9yYq+FMjqORPvh8zvLPhBcL1wROVVLQerXn3YFR/WV
	eIUmVEOh4iFjPVITkkAvE7BYcTnPAvqw=
X-Gm-Gg: AYBFou3L7jsJkzW+LJLHLWiJK16/0jHBjuSs9bAR8bkNDCi0zUe4WKASEdtj64vyYbw
	Dr0ENrnJihovdoH7rmab3zMfLrBwAQHFDfmTfHru7xjd0ldVj7g+6X2Xw6q/rDTr7/NnGc+KAzS
	DuVWhQlVpAJ9gpsNTikx6l0ClNspK2CQRS2hvOqUUEC5cMZspKm2/BCM0Xv76xR0NK4KB87bKTL
	x6+FJbkguk85qiY4o+XobIIcoPGrP1hvxJoryG8AVvzsZ0FMWZ+BMCB1nmctDvDhVCx0r+/EWPX
	PP4h1v6zgOWQ0GgfSvOnC6NbHT65sUWD1Ee52RmZd3dKC4VYTBG3JMrfCLC0rsd0UUn70j7fGCp
	swskZilAb00GtZUvrpIhziDuk76swdFdD1jnrXi+xzW+qp1wyVx5nqhponS/azoa/8pngCGv+yc
	5hoWpZzEYQwSBJzmstUHkyiXnCz8Sv
X-Received: by 2002:a17:902:ce0d:b0:2e5:cf33:80ca with SMTP id
 d9443c01a7336-2e60059e355mr3066715ad.52.1791317040158; Tue, 06 Oct 2026
 13:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+tGzvYYKm=Yo88knZb4oavG9dH5smUCXnoqa-RR9-7YEBycVA@mail.gmail.com>
In-Reply-To: <CA+tGzvYYKm=Yo88knZb4oavG9dH5smUCXnoqa-RR9-7YEBycVA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 6 Oct 2026 16:03:48 -0400
X-Gm-Features: AclHuK8m7xvpXoiDDVAPanMxHHCD0qidOUyyHP9mwXixveohhCsJPEHEa5CLLgs
Message-ID: <CALnO6CAAGgKK=cQ6Gycn9Y4K7rW8_vxkzpgFUYQANY=yg3Y17A@mail.gmail.com>
Subject: Re: [BUG] push resends common history after repack during pre-push
 (2.54.0, 2.56.0)
To: =?UTF-8?B?SmVucyBSw7Zja2Vy?= <jens.roecker@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm out of my depth here, but maybe others will have the same question=E2=
=80=A6

On Tue, Oct 6, 2026 at 1:39=E2=80=AFPM Jens R=C3=B6cker <jens.roecker@gmail=
.com> wrote:
>
> Hello Git developers,
>
> A push can resend common history if its pre-push hook repacks the local
> object database and removes previously loose common objects. I reproduced
> this with Apple Git 2.54.0 (Apple Git-157) and an unmodified build of the
> current upstream Git 2.56.0 release on macOS 27.0 / arm64.
>
> The attached inline Python script creates fresh local repositories, seeds
> a bare receiver with a deterministic, incompressible 4-MiB historical blo=
b,
> and pushes one tiny text-file commit. The common base is initially loose.
> The receiver uses receive.unpackLimit=3D1 so the added pack is measurable=
.
> Each case starts from a separate fresh repository pair. All pushes succee=
d
> and the receiver ends at the expected tip.
>
> Observed added receiver pack sizes, in bytes:
>
>                         Apple Git 2.54.0    upstream Git 2.56.0
>   no hook                      300                  300
>   repack in pre-push      4,196,026            4,196,026
>   repack + negotiate     4,196,026            4,196,026
>
> The repacking hook is simply:
>
>   #!/bin/sh
>   set -eu
>   cat >/dev/null
>   git repack -adq
>   git prune-packed
>
> Expected: the already-advertised common history should still be excluded
> when its storage moves from loose objects to a newly created pack.
> Actual: the historical blob is transmitted again. The receiver stores a
> new pack roughly the size of the historical blob. Enabling
> push.negotiate=3Dtrue does not prevent the redundant transfer in this tes=
t.

=E2=80=A6I've lost the main idea at this point. Is the problem that you see
objects sent from pusher to receiver more than once because of the
repack hook? Or something else?

--=20
D. Ben Knoble
