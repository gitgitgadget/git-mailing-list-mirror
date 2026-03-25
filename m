Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0C1D130E
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774412983; cv=pass; b=Zqnj+z+ncK+n6WZC059ukfxTuIKmFBwe6S/7erETak2DwgUYBAEztB6sVH7YqZ/aTfN2VC5FqosnIzJzQHS3DwaGlvOwbFuLtlocX5Kh7gblwZA1Nw0xYdh56GjMgMBZFXObQ6Hg+mbzhRB9vrT22sXA7B2W789Trh7BpLBAOH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774412983; c=relaxed/simple;
	bh=PSP/LHGoIyAvbdCdK2A4QqVeEGnRBnQmKrhyiui5mnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfPCDs0+u0tqxB+wzPO9JN4JZlOqkht1xrzvCy0hvulxIa7dTQLKkMZVYyGqiffyz0IUcxaTIYqajB0X7Whthp3EeDPn55ECQobazpCRLc50Vrpb59Qm008eLi0qfy9BI8RZaQ0weLqojHabyGBOzJtWtxP2DmYrg6BWhicMekA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEw5+v2N; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEw5+v2N"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4670464029eso2970553b6e.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 21:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774412981; cv=none;
        d=google.com; s=arc-20240605;
        b=ZmWBaZfQe5J/4dp4r0FFzzVU1ix5k3GAzoeLH1e9GbwqSmvDF2hwUfhSy6TeYQqaV8
         U0mUbviY9+GxWU602HFJTWrfnEJc7XRJeN+WVFILQriADT17w15iE66sdlddX8v/WEKh
         jGvLhc+cXi6P95o0FgNF75NTwK+ucG9DlCf/0UeYggIPtVg42bPSyXTDbkk7aBKbA/Kq
         8MDoelTHHgnm/ZpSZm8psFKT5ABNfzdE7nISTm2ycAFprHve8mMTHoZ1kJ3vvT1DJYZp
         4GtTVWauZKJdrC7KovoBFjUvHhik+GiJRjV0+KyJmDeJLHYCv4eNsstg/48CZoJC26eK
         RTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v2sOHZSuQjqo2EzZS2VXjeQROA2VJLaAHF2qOFgomOY=;
        fh=HUkQ1SwRswKcXM7ts7HmrzHS2Hrt75kaG2FAv/NMrys=;
        b=VdOzAkSEI4PmqL1FCk+1z9rbCCgjUie/yssA9tNOnA1OYx5t70flSbpuxb5urNjkro
         wwVBg+QdK99cMRK+mm78yMyzzK3wrYB0Pu4cCewXuhQIkRhMGMBpcLy62ghsXUedwPzJ
         y61SchJIq14futLQCAt++frbYBLKvrtcpF6eyijB+iu48AOuiXQHdQBD3nV6HR/0nKrz
         jBZG5oCaXYD17XpNM8fJMTlvFk8I5qI2GoXbvx5SMqIxP6JunHyL0/KI+gxQKtveDpYX
         cO9DcGNQkmQVZ2DcreW7zE1oIL0QCIwOJ066c6uOWYZpu20tE1KGhPqVl4rE/Ejf8FKD
         rG9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774412981; x=1775017781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2sOHZSuQjqo2EzZS2VXjeQROA2VJLaAHF2qOFgomOY=;
        b=SEw5+v2NmhLbWo8AtYiFt/gfilXaVlcqVR/G/W2EGbm75WoBhdqs8YBlipjJOd3H28
         baub8U1MgfwKbsyOibGveOWGXqSY3uw8H163Vf6Dbi784kVDFVDQjlBVvOeXubuz1DL6
         OrhxAwdSeDVTVos0enj6BwDAaBfp3wknF3+ab0T0Kn1u7J0/9+lSKFM1pJREUVSrKXga
         1NxWmB7arNAOqqltk5/hVjWwz8GruRC4eT2B/dtzGiuxu6ljSe5ffl5y/lLmGasvJ6sX
         eKMAJkyJJIqxCwnksfMnzQRWXay/spzHr+fq2hGQL6TXChsEJ7GU5p9HOs4/M0haPa8o
         CIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774412981; x=1775017781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v2sOHZSuQjqo2EzZS2VXjeQROA2VJLaAHF2qOFgomOY=;
        b=QgMkV7VJDJO4+AVrfDAxlgMU8UXeIi44G+cqVjTvcCsJp+4PifM1f/xtTlB+7k891G
         +OXpCF8XOf29JmqU0ZB2Av3aMHzfrAGzUYtjF8U3l4MD8ZqpTFLURO6HZ/CHuYCLlRBw
         TFooRcwVv4HrNOUQkD2LowGItp4egjVBEqeW4n7hSu/C5WLbcJ5hNUN5v7ZyBE3hfmOg
         AaRGKXEIu8nRH3Ejm9nYRgfIpW3Rk8cu3Z5X3qrD+6NsXaK+8JN7NSu9oN5VIjqoQKEW
         1tZXwSiAc+EM/pBbV3K+cxm4XSUv8aVL1PV0TvHYd2CskkKArsbgPwtnhcqaQiruDHRP
         hG1g==
X-Forwarded-Encrypted: i=1; AJvYcCWlY/MuUG3M2sc3JPyTWWRiq6zWN+8B5ag6lb6owp3Ak5woeeOfHhSB8RF3XVGP1GqL1F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmIzLo1ci1bEK4VZNvQoSAJ9ReNJF1GNBK4yNYoo4DNeZaYfT
	IjUBcKU0B8JUDiSl/P1OnInd0JoyAG4wJM7/SHM7rphc0nMBxiUD26rpgAy1Nl1ir9Ak7j2NM0k
	AyMfX05WzACQpwnQqBgx/lbTmX3AQwoU=
X-Gm-Gg: ATEYQzxKJ8y3h4T56b7Tw3M/j2c7ZFAj8VhAjlPIOP22F4XaAxXLzEjB1vTUWCC6Vhz
	SKbGoF1P2ukBor09ydBI6JHaOOfrD525bXhO594T1kUv8bniYrtFpRlfIqrJNZ+olbOcspYC4Dt
	3e/UAgDkFKuATSaeg0mhWvwrkWqUNi/W/vIuoP4sDmhDBkVhDFEZHDUl52JG2aGaXl4OxsMJ0VA
	GUvqGGJCKokHh0uAkhACWv+KEC/AaNCbXlGkrrpf6WRoNImRK5+naAKPdGE8XvDsS9hZ+z8g/hK
	7B9gU3yYz4sv68l1fMZY+n7m6QwN+of6YjENQr4Z
X-Received: by 2002:a05:6808:8955:b0:45c:75ec:b9b3 with SMTP id
 5614622812f47-46a5c59a78amr1055473b6e.9.1774412981418; Tue, 24 Mar 2026
 21:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
 <xmqqqzpmwdyi.fsf@gitster.g> <xmqqtsuiuugy.fsf@gitster.g> <ca6e021e-0301-496d-8bd1-b646487ccbf6@gmail.com>
 <xmqqjyvdvo7t.fsf@gitster.g> <75c85249-1cff-425a-8e77-98d55215c324@gmail.com> <xmqqms07putp.fsf@gitster.g>
In-Reply-To: <xmqqms07putp.fsf@gitster.g>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Wed, 25 Mar 2026 09:59:21 +0530
X-Gm-Features: AQROBzAdHICguuWve-kbCslSXc8_lS3l6rsM31z5YiCcuzP-8ARhSAqRMP-6JJM
Message-ID: <CA+ARAtovu6FrCEfYRd0mRz_KChkXPr6s=Er0-uCcFqfYLVU+=A@mail.gmail.com>
Subject: Re: [PATCH] remote: use plural-only message for diverged branch status
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> But wouldn't that lead to an awkward conclusion, i.e., hits from
> >> "git grep '[^Q]_("[^"]*%[id]' \*.c" are potential bugs that need to
> >> be updated to use ngettext().
> >
> > I think it does - maybe we should suggest fixing these as a miroproject
> > for GSoC and Outreachy? It certainly looks like there are plenty of the=
m.
>
> That would be great.  It needs a bit of thinking, the required
> change for each of them is quite small, and there are tons of them.
> An ideal candidate for a microproject.
>
> Adding it to the list of microproject ideas is a good #leftoverbits
> as well.
>

This has been added to the microprojects list now. Do check and
let us know in case it needs any tweaks.

  https://git.github.io/SoC-2026-Microprojects#fix-improper-pluralization-t=
o-use-ngettext

Thanks.

--
Sivaraam
