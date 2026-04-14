Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F5388396
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203896; cv=pass; b=Ioe3dmsco7T2DaXrU3jNYKI9NIuwLo2NWGXzmWDSWbhXGFdivE41d1tYBXh1vW+0uVCg1GFEWmQ2KnocTvvZU4Q/iBhZipoT9sKvNw9TC02pBOu0B7LwrywEtfzp5GmY9YPIyyIc9bLDSbPPI2Ev1csIf5/sMt3Po8QJidw8XJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203896; c=relaxed/simple;
	bh=dsWewjro12M9ltjky1RaN7su69+amQv0JvmRfVo2TMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uREmzIDO7H0MfmQBjz7naYrfk208XV8NpF6zdtuG5SqDE+7iKaJef7JCyajTMqIbbzbE7uge3hqJaMP8v+0QHVMmnWrOoflpbtN+QTwl5aHCc4u8MfA4JYzW4IxCWJc5mutcFKLdClcfexjZAFPXeA8P6BPbBL0XvbOfwZvRClw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gumKIPr5; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gumKIPr5"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67e09232daeso3581786eaf.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776203894; cv=none;
        d=google.com; s=arc-20240605;
        b=amlC4UnMSwwSLVdaAZa0KMBe0hCt1nvR0MVW8l1OKIUgmmHvnMtehpisfz4uhzVxFX
         nm+gVPyDQz15fHo+Hm611fwUW3cdQ3ZMuYacKdlP7Pxmxni/XIMGrW3yKlJJO0//Lym7
         WIXx3AR3pE1FfQtm2ZG8LMFux6dkhy8ff+vnYlOc9lwxS0cVIKXSlscBe0lXLVTJ8IiX
         lo63VvyfHcItc/DqVq7rFpDLotD0fD3Zz7JQbRBk14w1TiuVtmMB19cvpdv0Y2lS0jct
         MIUIq9bqXwokxwGGIC4PupMgnp8Oc02TBt5VCnCr6pVKDNkxLejrj+PlCm0OTu/OW1fz
         Jt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mly2yQQd2nDB4oaqizjGJk3nql8kW++S0OEQezLov0=;
        fh=Kl41kzKfrmYe6CpN4WVy5jvZ2WRy2HWkMezWS0OjedQ=;
        b=AE/LPsEj48K3IjieuJPfn1REv1TAbHQaLVg5UVecc1Za/ZRtY0FAnDZ4LBFSRrFPvI
         A9W05V+mlrrVYFaII8l1tk5+Nbsvr8EQteQwQ5PXdO7KB7Enn+FQ6WJRg5irCytFZ0x6
         /M+QlLbD+6NbD0K3fPDhZl9VSP4WwFzNHsTQmbtxUDw4toPSho6X5C1/+5/OZrkHZOrZ
         YkDKPwJs5GjxorHhCrByhKX7YItS6aVuCRZfbicbTcvzJr/8YCRWQryX84m/C3cjwzWt
         AUOJcOhzDjniJStbkcx3tihUX1Nyq6/KYOZ82n7hHXUQqyt07bp36xojBZlK9T859twD
         c7lQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776203894; x=1776808694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mly2yQQd2nDB4oaqizjGJk3nql8kW++S0OEQezLov0=;
        b=gumKIPr5E0JWi5Q2lWxGEDPEIfexkLPEODmGb9lIIpdOCkcnIseIM5nSshgRP7BLE/
         yugt8F8tfMaJuARzRLWDbRmbeFpjA9UOZZftkCQuYYdH8MY+AMqSajkuuiGlm7qVwRna
         +nP0GJQapPYVrx8FlnSICahXm/QjqtMOylsSLBYydEaTSqPBW7t64uWa76RoMdJa6cTx
         vEX+w/lwk+ViD/gfgXYmRWFNQ9eGVohsDsdtc4YkMtvngmVCWdGeJSYKG8F+3dNyEUh+
         YdnbnrD2mJNPsAZKfTEDtKtn1rb7qcZQ7ScSjJXq+vnY0dOp++uBNzb3h/tDAKwloGlo
         rcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776203894; x=1776808694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mly2yQQd2nDB4oaqizjGJk3nql8kW++S0OEQezLov0=;
        b=kD5GsnCz2vdeI167m/IpgObwc0zypWrbI62AKp4/nZYuxpm73bh7H/lmQslJq15ZGK
         PKe/3x8ukJWggx9tjjErdC6cbASTMietylUX69qo1bODknv7xj/431vTxqij7kUGHhPk
         +TwPp2X31DA1Tg3Gf24yLk1RWmTBCyslvCiyj/HUKxhnNn6ECsrgnfpHLyr9mrLanfOG
         5XSfgC7CMUdffI/jMNcHopHFtDmK8/uASoiZVxoo38BsxBu4knVzY1ATqq7mAe/BFVqA
         vtt/A0+6jnGjqpCaItaD9aRwQweLFm31BKAIn8LpdljNfdfl04qlBlqWKGsIVpTcWRys
         2F5g==
X-Forwarded-Encrypted: i=1; AFNElJ+EPpX2ZWsYlMQL6AB43CU1WLa6zUcmggvhjPg6ElOMyCQ2hUau/wSyF8WJWQYIQWfs7/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZPYxdjw4JkXAMZN4FNgXyn0gX2q14bXa0nIq6Y/YAQAEdtMU
	7lVhPCB7NpwydyhslDPkXXQ10WI47YJOgfgifLKgW7c5x4xU8FQsknvhUBnpEPwC87K8DXfXC+N
	o1v1GonWu03JtcCj+OCN8DuTyB880GvU=
X-Gm-Gg: AeBDieunshY5RklHkI8dLtvi1wDx1QgcxUXeFcIIZdZ2CyRhrijzl68tOCJo0RGvmyq
	CiWF6+nXhjlVwEw24njGcJBd3EEvwR1BULZZHCNQUtdSUfTDZR5pzIATc/XknV97hOoFU5gdikA
	HYoZYTKR5FHQD5iFSAmDLly0Bnvdcqj0ZUA3ujbXDSL/E0fg4mXg+B7psAx+urxTJg97RANG0n/
	vP6JaIXKwAhZjgdK5FZe77JLA3Wnw8iG4ZwQvPpP1hQgCSi2ehKNjLdTiGxpicrBSGagwkFPK/l
	h7/ytnM1EmKSsIY=
X-Received: by 2002:a4a:e904:0:b0:68d:bf34:15a2 with SMTP id
 006d021491bc7-68dbf34163fmr6618375eaf.30.1776203894244; Tue, 14 Apr 2026
 14:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
 <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com> <75fe3ea1250ab7dfa4e029f49f2ad353185afded.1774890003.git.gitgitgadget@gmail.com>
 <32c34d0d-9358-43e3-9d58-5999b3ffd6c2@gmail.com>
In-Reply-To: <32c34d0d-9358-43e3-9d58-5999b3ffd6c2@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 14 Apr 2026 15:58:03 -0600
X-Gm-Features: AQROBzCBqcOqAS9eF0OjFc8q0kWfDaafZ1aXd2o31Upc-WT1P200x-WFx0x6T4A
Message-ID: <CAH=ZcbCX8FEs4ueU7+groQp8XhiaP0QPHMeGqT+Ap1FjeW9foQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] xdiff/xdl_cleanup_records: make limits more clear
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Yee Cheng Chin <ychin.git@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Jeff King <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:44=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ezekiel
>
> On 30/03/2026 18:00, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > Make the handling of per-file limits and the minimal-case clearer.
> >    * Use explicit per-file limit variables (mlim1, mlim2) and initializ=
e
> >      them.
> >    * The additional condition `!need_min` is redudant now, remove it.
> > Best viewed with --color-words.
> >
> > Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> > ---
> >   xdiff/xprepare.c | 19 ++++++++++++-------
> >   1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> > index 386668a92d..bd8baf214d 100644
> > --- a/xdiff/xprepare.c
> > +++ b/xdiff/xprepare.c
> > @@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action,=
 ptrdiff_t i, ptrdiff_t s, pt
> >    * might be potentially discarded if they appear in a run of discarda=
ble.
> >    */
> >   static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, x=
dfile_t *xdf2) {
> > -     ptrdiff_t i, nm, mlim;
> > +     ptrdiff_t i, nm, mlim1, mlim2;
> >       xdlclass_t *rcrec;
> >       uint8_t *action1 =3D NULL, *action2 =3D NULL;
> >       bool need_min =3D !!(cf->flags & XDF_NEED_MINIMAL);
> > @@ -287,25 +287,30 @@ static int xdl_cleanup_records(xdlclassifier_t *c=
f, xdfile_t *xdf1, xdfile_t *xd
> >               goto cleanup;
> >       }
> >
> > +     if (need_min) {
> > +             /* i.e. infinity */
> > +             mlim1 =3D PTRDIFF_MAX;
> > +             mlim2 =3D PTRDIFF_MAX;
>
> This is a nice improvement as it simplifies the checks below
>
> > +     } else {
> > +             mlim1 =3D XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIM=
IT);
> > +             mlim2 =3D XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIM=
IT);
>
> As Junio has pointed out we now evaluate xdl_bogosqrt() twice which is
> unfortunate. It would have been nice to mention that in the commit
> message and explain why it does not matter.

It doesn't matter because xdl_bogosqrt() was being called twice before
and is being called twice now. There is no change in that regard.
That's why I split mlim into 2 variables to make it more clear.

It looks like you and Junio have both missed that xdl_bogo_sqrt() is
being called on different values.
