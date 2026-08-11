Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B92BE655
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786417073; cv=pass; b=SmH/OD+fl0+cd+XHi64irshg5cGkk6Qk9MPvHIvpvDTcXYNAMsB1DtY2Ji8vJ0wuYUHkkuyVGZBGSRAvrSXKSss8qCVFPGzknMR0Rmlt+oVLzFXEFhQuK2dGAlZ/lX2WHPKyEBHIHZXM2nu/g2uPCwM2qsa7R81lGJ1bKV3cFkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786417073; c=relaxed/simple;
	bh=uWFg+qq9eIWuSfgsY2bw2FAOYPewdlbXZKzHJ74eVhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IA3xq2vifxJi3g4A1RDPjxUamvSX07M01EjVjgfSoxkE0niLdRsxvwHhsFcvtgnaFg4ZhS8d3cKUBewP+f6LXSHcN/1opHUlPKrQSlX0nlh3Tc1d3yumkZJafWbcBHKXNnOjW0xe8atOdjP/ctq6riSRD73oXyiJpSh3ISfhB7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA69a42S; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA69a42S"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso265826a34.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 19:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786417071; cv=none;
        d=google.com; s=arc-20260327;
        b=X4rQuOHmppjajFGDoLwlvEWG9TU2KimntA+1Ah4iOQ+eT3v1XVNEFDPxG9QLAztXq5
         IAtGhHnK9kJcXlM/0e745Kl71Mi2p5sU/OxP0aJZKQOUaBhpoUvvpbdkV6iGnYW0aAFA
         Zf1+5nh01tSwFX1FWp0M7rvXhcBmi+yEJIh8F28S7CuaGBXnewlVnQQ6uqfqoJXXPlBh
         aWkhka1GtOZ9UIe5CGgeSCv2phZ9YRugfBqMjD/DJV4sgohWUCfrMVKFDHfwokEp+JvC
         STb08mbsgq8O8StwQHiX6uLCdc9LBK5v/3h5Q6lZNU+WDjfHLMB4DOsAJO2+Ypbr8SZy
         9/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0TXo6dPDesyTfTxT4QBjTT1EQNkwRJwW7SAVjiIJTxw=;
        fh=jicDeUGyzltEtByoy7N8IpZb6chl8WGdPdmtBLFx1ZE=;
        b=N9/5bUr4japMoUrlHOwQEjSsmaNmYMWQ8RSK72JuLqYIJNeCoPf5ORIUStCaSzh4Xh
         +PsO3mB05ntRlzKjjZlqXmRVt7Vpscfmh6p92HX+utVYhRoz8sNXpmtUySsS3668t5Rw
         xfrEZxzdpZUePV/oGah4WUGec+PTTvt56RnLOXLJfLzFXU2/Wp/WmbKonEARa0mJr8eq
         oI/LjmcmdKO+JGmHK7r4uNFhBckpou+yW2dfq5FHKf+ReYq7BZ9ZWOxmg75lDDmIxLoY
         TYdF4raLD3arrFtrg5/NbNyE0Htldb/CKCG/OkErnYhRQXLTyWcvIBT8470P3oqN9thc
         YI6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786417071; x=1787021871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0TXo6dPDesyTfTxT4QBjTT1EQNkwRJwW7SAVjiIJTxw=;
        b=OA69a42Sx2HKY4Ce8tIKhCtxPJpmSkiHJTvpriVu5qkwA2neCVOAa8tXlxzXp6okKp
         292d+tgNr58uVvB5tXGtEEFjeDTIoCYzscME/1GDKssMxh9qBJMa98x91BoTs8ouu8CC
         uK00FotUAD82ZNc6lv/0KfJtCtlKY1DWyZQoojUAhzFcE5VqTL3RpmkPxDEd2XuLleqn
         AXOMRQ3OQ2EZxW1PL4Df9WCBbDg+COa+b9KFSJoc46Hr6tyb0hvzD6gmPexymdPE2Z8/
         cBwdpyxvrS06sxgBfifY8MVFg9B+UG/4I5YYwk3ChEr8Gcz4kTO+0kCRuRTfD68OWvIo
         pgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786417071; x=1787021871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0TXo6dPDesyTfTxT4QBjTT1EQNkwRJwW7SAVjiIJTxw=;
        b=GpzkYnNdbWL5PQVEw24Z9ujsxygwKg5XHWXdWX91Lb1Tcc48adO7Zi20HtY0e4B0G9
         SGJP18GVm+Ga/li1srCucBsWR87guJZrZ7wWh2wkaF0Y1Ty/M5cnPJ08S4OxbvMTpuZ2
         3GFz30JEug8mlm0fQPjuHvgbb3p78XNMXGh+zzkEbzmR8xRiDVPn23QgI3NRyLqQAL3D
         Cfdzzi9fg/dMdBG3CEs1W8o4BneZVCHQ50oxDvFBTlpt1cIQovKsce1O6DIK5KGCh46x
         morCStk7ESUFTYMBHQJsSNCx/FqBVb4cj35QknA6SASqQGsuYuhgWKPPS0sdfsDp6fdM
         CmZg==
X-Forwarded-Encrypted: i=1; AHgh+RrX6MtemAtTICF00TgOWks+GhJByP2pI5XEMCicePNdilKnY97RA4owz+Q0V+qJ5Z9FEXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEunMHrGBq+Kk6sOSMkd36MKPFHUbB3aHlF7MXq2yB46kiWPqC
	RC8pr8mm0vw3XmkImEQN9eqbczuHNSjts1MjK8kM9M6KqjVBOc4hdHFXEs06z4OJCjST0W+z92E
	mT4KtBDhA8Qr+ldE2tCYAfxe2fWIf63s=
X-Gm-Gg: AR+sD11a6Stlgmcg9S3cW9lWSvntykWmTdt1pli6ac1CSmMZDQPxYbjPM6BHSqNJJVP
	3e9kGV5EFxnntsgHNIplUCI+qVolC9N65LO+IlDB1RJ4XLejvtBcrwslnrZKWBImkDFy8o97x+n
	OiuY3YSs5L32TcuWAFfK1SMH+ppjFYaAozXzCs3K0sAkqds6zTbLzGbhGp/LuU1K/QrbTrRawLp
	tOYd5wL2XSGFzQp7CPv0a+uBsAaqUvmIrHv8y8Pu13hA7IZJYW1FmH3efNmIotqucMiOJXIsrMW
	ALBPSs3rx8UpslIdO189BtGCs9jE8BDpSihib1nFnQ==
X-Received: by 2002:a05:6830:6d19:b0:7ee:36e8:d0ba with SMTP id
 46e09a7af769-7f3a82d7a7dmr127814a34.11.1786417071070; Mon, 10 Aug 2026
 19:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721213042.3357346-1-ccjmne@gmail.com> <20260723002132.3989727-1-ccjmne@gmail.com>
 <xmqqldb05dlo.fsf@gitster.g>
In-Reply-To: <xmqqldb05dlo.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Mon, 10 Aug 2026 19:57:40 -0700
X-Gm-Features: AUfX_mwmao1RL4TJ9u5nlaDskHo0U8KMrmmUnPXVElTh1MDfkixMDBDZP4VBJM0
Message-ID: <CA+P7+xpADY-cfzfjmaXboJMdQfcjRLFNoxhWf4weU00-Q0g2rA@mail.gmail.com>
Subject: Re: [PATCH v2] submodule: resolve insteadOf aliases when matching remote
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?=C3=89ric_NICOLAS?= <ccjmne@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> =C3=89ric NICOLAS <ccjmne@gmail.com> writes:
>
> > - Reword the commit message more purposefully
> > - Adjust the implementation as suggested, avoiding a superfluous
> >   variable
> > - Tidy up the integration test
>
> Queued.
>
> Is everybody happy with this version?
>
> Thanks.

Yes, consider it:

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

Appreciate the fix, I think I had ran into this at some point and it
got put on a pile of "to finish debugging later" and never fixed.
Thanks!

>
> > diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> > index 9554720152..10adeabf0f 100755
> > --- a/t/t7406-submodule-update.sh
> > +++ b/t/t7406-submodule-update.sh
> > @@ -256,6 +256,25 @@ test_expect_success 'submodule update --remote sho=
uld fetch upstream changes' '
> >       )
> >  '
> >
> > +test_expect_success 'submodule update --remote resolves URL rewrites' =
'
> > +     test_config_global "url.$(pwd)/.insteadOf" local: &&
> > +     mkdir alias-super alias-submodule &&
> > +     (
> > +             cd alias-submodule &&
> > +             git init &&
> > +             git commit --allow-empty --message "Initial commit"
> > +     ) &&
> > +     (
> > +             cd alias-super &&
> > +             git init &&
> > +             git submodule add local:alias-submodule submodule &&
> > +             git submodule update --force &&
> > +             git -C submodule remote rename origin upstream &&
> > +             git -C submodule remote add fork user@host &&
> > +             git submodule update --remote
> > +     )
> > +'
>
>
