Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674261;
	b=Mqf9MjeBNkvv9x3DxkZ2XWpohD5GZQyb/d5Fj3y4yTqf5n16KTxeCSfm7FuK+BwpXHer
	 ZHNdyGOs/8uRGlQyGY79HsiQiq0mzAslHQQ2BlVWy6Mk7jKydiA59ySOXowSyvP68004J
	 ji6u6RALpgEgE1jiJJkvqPsI9AWFKO6y+nvC8iwqKFd9HAmBhciCTApH+g56u8BJc59oX
	 ibu+W5kQgYMlevglMKxgwcNrUP5i/RTwmrEoZuajsCZhQclWT6lJPSGWGnE/tw5SEru40
	 t2lvTiNbTBaUblY7bcsigqVSUrik/ngdHETE273vsJY/CBAmXFnlumJSAnABTCdpKLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9bnyP2+Y/YBgAFcOBaGmfvAagZAIxf2cgdjvH0fF+Pk=;
	b=wxrcir97gosgQre6NAVR/YoBLU3ZxPQeCeSlV1Nj65RZsLdldRYl9JyF5jwINgN5shq4
	 Eobd5oLdZEWNfnUdVQwgAYFOkXV4paTrhI+c1zStFGHFka0dBImuKT7kZV6HIPgg4dZG9
	 /0Pen1BLyT9QjHLr/c366pQS082urFQECk9zX8fPa8tyfmKptqixGhToPJqlxrTxi45I9
	 l4Epnw2Ym9o5OHvSQsPGRcavgGDysvHzgOsK1hdStkZWZ2zxOBD5S/xl9I90Wkkf+kbcm
	 a6q4QVy37INaIYiS95nMC/t9HA6OmG9oQaHCh65yPNiKNomE5nB2g5DrVSRNz1R2lCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UjEbcJdI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF4606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55CF4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UjEbcJdI
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4f48d91ba7dso2203678b6e.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 18:51:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793674260; cv=none;
        d=google.com; s=arc-20260327;
        b=TBwmU2qtNpMb8v+k2v53ikUBf9gBN9JOMXQYQTE0Jad9NJKVdIV8NO1u/B2lKtbEoS
         85lIqJUemHYRibWQoEwTxX3kGEoAitGh5Us71Dvf6JnJpmJkbLYZsh2tY6A8OxZewvWw
         5F8nNErOnIEu29HfKsHmt0QBEr51eejBie6s8mXXVrnm3JHeyCNc38MR1GYhzU91MkDi
         JCDJiaU+aQMH13LcpwvE9Fnm2VLKRiM3ruGkaiP38eIaAU0duDdXbBaMwvKIVDLIpDAU
         MvzDwgTAZOCu7Jdt1xg1atmA8GszM004DqcRuFGKU3dQ7L0ADtnTi4Pcy/2E0Stl3mup
         Ny0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9bnyP2+Y/YBgAFcOBaGmfvAagZAIxf2cgdjvH0fF+Pk=;
        fh=mv5zqN92u4yGkXYcJT4eDsfhsA+TdzFjZ8yY/QsyRCY=;
        b=rNOdskQYVFSNQIFEDC3gBS2AQEJcWp/oQTpkhGU6KbXH/9erGpmGDBoL87SRLhehnb
         MaWc60Yp4MC/44kE7PEj0aXWTsjJnNMrTU3VnI2NpWBt18BmnBZUkAZGL7LT+tGRaNVU
         +bdygYK3RknSZ/FvyTDQS8QIRnXX4TF0tLRCvLXcTL7zClMkDVHlZL3tfVTzNIyd60H0
         hB4FWnCAhxqXzv/buinWW8PPkkt4G7MmBPvRImyCnbbwU0dPDEyF1Lg1P2k06SqQrgOO
         6VswMQGW+14mTQFcM4XFj2Te3V/92dNLbBBytXBwV96lmRwmosQS5q9vDpMfrQUZg909
         YjKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674260; x=1794279060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9bnyP2+Y/YBgAFcOBaGmfvAagZAIxf2cgdjvH0fF+Pk=;
        b=UjEbcJdIllcldyDxznIAeLnKrhHRfF7bUTdCVmUu9W5iZOB7N6hBAX0u3DOnONC7wo
         rCGq+bGIewPsrAPNmujRJVWjuFy+CJ0dA1uFBJcgtCD30hfdD/Bak5eVEdbNyqwCC8Up
         goc1AMeFEDJC3ymPgWaJ9a5C92W5n4jhTVi0D5FNr1iQ3pMfj0lxTBLnK1xM2qyOrpsM
         2MvrgVhVvWeuxmYYhvWd2zVB0iXtTlSsd5k1DO9J19I8NEb3vxdDzGU0HOYIzIugc7Hf
         CCmdFkOSTonEc0Wx2XJyfFun4yyO4bCCx39zsVXALT1aRPbY6mDC0MM8APUSFZxkyRrJ
         a2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674260; x=1794279060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bnyP2+Y/YBgAFcOBaGmfvAagZAIxf2cgdjvH0fF+Pk=;
        b=zaHiu4M/E0/Hlv2FldfBgFI09a/Y7gFvmzmi6vXJ+H11fgoogHOtrNyf0s7ZWeXCa+
         aoqGaZtIEV34huXr0FD4xquDzzAOwgtYA/UB05katDnLvV7aGgv4sO01krvAK3xHURDL
         aTNO+CgilA0SNtjXDS29sBkycQ2Dwm4ksvgnk3HrmdUe6LgbkiIS+47C3nhG7uDnVGc2
         LZnMRZ/kUjDawzI7VfuRG4HXUJqBgaFS82NfXjMUGtJ/bWx25aPybbMMg4ZqXb9NVtx8
         j0L/Ar3XcGgzAdM9nxVyda9L9X14+l0HaAE4XtZy3AGHrxe+gBWssGWtdr52rWk6PiKI
         lP6Q==
X-Gm-Message-State: AFq9FYJ8Wzs3jggHB1JjW8rpjEYA2jXa2qSUeGaz136x2tFb0bx7gkQG
	qn6tjHJ+nMPNzsvoZ2oiC3ogEvvecPZD2RFqN/lA7fhg/mU1Kbyie0MhIttGyW4sVucjXqIbuk/
	Iotk1byDj+jVjrlJAubwJNtrrFABGdqRBaA==
X-Gm-Gg: AYBFou26mbixmD/TVMfDogNSnhQJ+qzg1dIo2EKAUccnrPHjLQpeWx63oJiAs3qE5Dm
	Bzm6p6qyyD/SvfOYwp2VpmO49KVOwYA9i85S0YvGf82IaG0tPAM3MCH/FPKJW0EHBGHfZBDrgAO
	Fqbm7UO25rthJiVaWbJ/NEqaIPjT00ck4qAwaW9cPNoAhwINE0kAF6JcQ35txiuSpZoXqGA5l9P
	U0IyHcsfy/0jwtzHdyBX+Ns6G+HI+ttgCD1s/R5IFK3qlMjyzybN8SrT3z1KgKMlTyNnymigHYm
	kCcWVbB2PI2ljQ9lKqjVA53dmflGRQwrEk6d7Aqe51QU+riMbrl7mrxvl/wuI1BH6gFM0VULcGK
	0/igaVoMTjVocrGS6ruSBd5sMq4DQwHcYU5pDscqXu2dW5vLCkp4vwoLWtJSaHxEPY+VA/tqKXF
	qfPgG0pHWUZE3CpCYJVeTyBhDSqRg2RxW2xLZlbQ0r7YJQeS1xpAHHXzjc
X-Received: by 2002:a05:6808:5090:b0:4f4:8bec:ace3 with SMTP id
 5614622812f47-5640df40c87mr9049102b6e.57.1793674260138; Mon, 02 Nov 2026
 18:51:00 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-7-jayatheerthkulkarni2005@gmail.com> <aukQWTUKWwmCQwi5@denethor>
In-Reply-To: <aukQWTUKWwmCQwi5@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Nov 2026 08:20:48 +0530
X-Gm-Features: AclHuK-6hG62CKr7lh1IjdQWyVBTDDMi0K2Hkm8t1C7A4FF5-WAi1kJk13v5nl0
Message-ID: <CA+rGoLdcO94KGFg-qeUmbXHmRPz5UaOjeBd4_c_HuppquM7XTw@mail.gmail.com>
Subject: Re: [GSoC Patch v7 6/8] repo: add path.grafts with absolute and
 relative suffixes
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 4:17=E2=80=AFAM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> On 26/09/27 05:14PM, K Jayatheerth wrote:
> > +static int get_path_grafts_absolute(struct repository *repo, struct st=
rbuf *buf)
> > +{
> > +     const char *graft_file =3D repo_get_graft_file(repo);
> > +
> > +     if (!graft_file)
> > +             return error(_("unable to get graft file"));
>
> nit: Similar to Junio's comment on the previous patch in the previous
> version, `repo_get_graph_file()` already BUGs if `graft_file` is NULL,
> so the error isn't really doing anything here.
>

Right, I am going to depend on the original error check.

> > +     format_path(buf, graft_file, "", PATH_FORMAT_CANONICAL);
> > +     return 0;
> > +}
> > +
> > +static int get_path_grafts_relative(struct repository *repo, struct st=
rbuf *buf)
> > +{
> > +     const char *graft_file =3D repo_get_graft_file(repo);
> > +
> > +     if (!graft_file)
> > +             return error(_("unable to get graft file"));
>
> Same here.
>

Yup, will change.

> > +     format_path(buf, graft_file, repo->prefix, PATH_FORMAT_RELATIVE);
> > +     return 0;
> > +}
>
> The rest of this patch looks fine, but I do wonder if it really makes
> sense to include this patch at all because graphs are deprecated feature
> and also slated for removal in "Documentation/BreakingChanges.adoc".
>
> Maybe we should just drop this patch?
>

Ohw, that's an interesting question.
If they are being removed, then probably not including is a better choice.
I remember including this because on the idea page they added this
also I am a bit hazy on where but there was a discussion to include this.

> -Justin

- K Jayatheerth
