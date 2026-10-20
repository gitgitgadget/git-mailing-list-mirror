Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792532473;
	b=dRRHfYGs1K8wm1HhzqCisufnRhEwiqa74S7sjuRbr9LcZ/4iIra0sFlyeq7Y8Uy3KTjG
	 cpUdSlnaXuXicaE3sSAy/x7ewXJFJK76K5/PYHyy/7tmsA0wCUaIqF4BwU1Dns5GIEs5v
	 q4ZjmtgFRH3dBvYa1fPFgSBeFo39xMFfBrFz8jQ32eUbn5YPIUJruzi98s57a1JKRJisY
	 GhbpY7APJQPIMvOeTdXZ9hxShoh87QscFev1fMKIOVsJGVMc+IdTq3wKeiv3q8qO6NncI
	 hpDHyufwupdPj8eXhAkuP5CSW3spzV5WG4p+vnhXrqHmZA6q9lpoQJL51XH2I11eG8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cD//dn9n0/Tfb/mMwISrkmk5hmUrMi+Z71DZArAJ4NQ=;
	b=RlJJ0Hkney4mWkjeZSVt7ERn2ZixwdfH4pfod/jpRlHZpbN7e40dDIi1Y0GI8BVvetM3
	 SXConsPi8X3qCx+1LKVI7BE5JWcQk+PQ9K3MH6+y0ZCbe/4jRofpYgyZiqYwYpu45owAY
	 IZHy6T56lvVTQ+pLqjXy4Xbydc3Jy47VB2ZwqVpsSGUBYEamoT9MQ+B2ZIhtin0H5pM5k
	 eBUT+3O3JSxgiKlc6GXZwbOHkyRKoU7oaQux5fCpQuJDiJsQtjVolD5jIxhTIwc91KLtm
	 ZvYUFz0KccrKKNcYWrKsuPMOC2jsLsbVjNYPIG0DbkkqH6megTUiFSsRXutmo7J252w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TjqwAOyU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8B606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 21:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA8B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TjqwAOyU
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b10d24345dso1006077b3.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792532472; cv=none;
        d=google.com; s=arc-20260327;
        b=Kkzb1+YDtVQeZTq5Eh/JGU180NQhSb+5R3//zR7sGgSiblmsyy3moVi5pphnL/V8TZ
         SjTFp4fnE6wc9/4UfvHKzw8N38wdZIIsijto+3zYFWb/PVRZWSVvcO0bjnmk2FAZ2llK
         m+hg83bRc1Q6lcAUJ0Tp3694gZzxef+ShJcGXpqhDYEKWQwxKXdwRT9gbhcxlil6BiNJ
         ZoqIT59T2kWlp1Vnei9QTYGnKXLaoFGQaEQbnBdvl8S+3ezjKygnsSVzTV6/m4AZmJYX
         kSbcVReqPOE8OXLNiKGvfE0R5lT5l22VBJVgaS8L1Xchw8tcN7q5FS+5k65ONlPJR3dE
         nY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cD//dn9n0/Tfb/mMwISrkmk5hmUrMi+Z71DZArAJ4NQ=;
        fh=xct+iGG4b1LwuXoxK5VB4+y71YE7hTgcJFCPJmdmGL8=;
        b=EsXZuA6JdHY2womzOm/q1w+j6ESN5lSY783GIdHVjdcvvyLpCx409Uol2XF40Rh+t4
         SvTcv2s8wpoR7WQMJEshEqnOdFmL+aI8DUQeEnO6s9mrL1CEIvKNuUnAYHE0ag0LjxoX
         grYwFivGtmnepQz0trNqr+Q9WKUGz9BIrjVEtGNaLyk90+bWN9tXjZNmaAdIlfUafwdU
         3/XdbbAa9sM3Lcb3GMdQm0HCHVkYiU8Cd/Ty1a97fxGztja2g9I3KpWzNqqRAxF9S2jj
         JrS1VA24Hm3tU2JuXYHcsI1LhR6OH4LgTB24AM8T0q6oKzutOwPCeWAUmjY4cKyrad9Q
         FdDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792532472; x=1793137272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cD//dn9n0/Tfb/mMwISrkmk5hmUrMi+Z71DZArAJ4NQ=;
        b=TjqwAOyUvXeyd7Kmg8kv5DULxoENvpvgPybfHEI+QO9BvEcfvLkv5EYczXcaiywKO6
         OUkeAQjb2StXZ4Zo7ZIXL4k/Zj9yNUiAimyeUD3CDpkH8yQD/T+HxFWRh85HKzivj+L+
         JwCdLhbtCak09gsi1ewWXmOxg6XRfy+XUuUclfUSNkbguEOU3ixOlpoVkDUCoEIaIMqz
         1che7LDbw++Q8n5Z4qj+ntX5vM7ruVJaCUf4LkD3gfFahYXPF4rml5HYtaNf4+Cfy0TZ
         1Pjpb22awwJjRHPrQBWrR+3ztLlYcHTPHmH4Mpcijf1Y/1Tavp2lrvaSCs8mr2ifU27U
         g1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532472; x=1793137272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cD//dn9n0/Tfb/mMwISrkmk5hmUrMi+Z71DZArAJ4NQ=;
        b=grdHInabtPLnnB6wb1406Pt7gFfEU85ambCgJ5KJpnTAwzIN/Be5jrwbQaw4fVfcB9
         aY/OifmKjAH+/wiy2dxJyEDrBAEpp2AqEfy8GrR3ktSuefbhberE4WVYAc4B+s7Xk27Y
         GrSWFOTs+PvQiWudtCexz3g4iYP7RFVexTV/ghEQhXlecDwvN08/3uFCWoDALcDK+Ttv
         Be04J54Wq/EoSYEQckqba7O0CcvktIeajwEeHju+NvFe5TfZNnU1qRtjd8Ny+UmCmtpZ
         HQO03lDkcIgoCxFU5rJrpLrtVJJHiss78IXsCYJ3tkFQkhOb/Yd/OShViELFdKc+AtA9
         kOGw==
X-Gm-Message-State: AFq9FYIVHsTDke/09mZvL7FqVQG8tzV9CNCD08/K6DuJ9V7E/erNBMME
	lTzhThDSB9+yI7kBPeJsHKiD2F01UNu/7IZ5qY9TAtZsWNWfj5rRe0jscVg7X1XFQ08vVvXXopX
	+BcHSh+gaiHMSGSUo8/EuTUhVlUXSWM8=
X-Gm-Gg: AYBFou2XqY6MnoBoSwsfyho5SiuU4b0wXZ+8sGt0wEtSb8T0qbZB9I5F+vZuyq/8U8g
	lm+9k5Aea0CsS0PQeYJpDSPL1wGahrphdy07UksfZsgyQYl/A9MUfcYfM+aAL2/jJ7FRsnTHhed
	aETU7HJ72Ue6hB2OO5KhfMfjsFjS3KhNUnU8N5NEWg49hJxWM9x9qVA41ybyRD4mYAS8dqb3Vfx
	DXACrWpatDC60BaH4BEat5QCjZ3Eye2Gn6i6z6TcnGS4SUkzSbBKyojPr+iJqKo6VXEZySTK8Q/
	U3G187CWjUsyB/S1xpRQxgmsfhpS08/SnX2ZFNswL+3GNrAbyTicqAv6aRCfL+3tz8FpX61o3LC
	HtIFANhcqkEwc2NHWt5nL5bK6sNB9sllGT3hXX1DIJ/tSiOS3Ot6rA9Rf23+z/XDnQu4NZox1HH
	eN0dCyFwlR+9+FAixIPdePDcYs1FQ3C8aOLTxdFl2mb2R89VVUCM3ugCPQCumwZvI=
X-Received: by 2002:a05:690c:e18e:10b0:8ae:6740:99a with SMTP id
 00721157ae682-8b133fff195mr979527b3.30.1792532472371; Tue, 20 Oct 2026
 14:41:12 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017105244.90295-1-okhuomonajayi54@gmail.com> <CAPSxiM-OyrVEzYgja0nwa8PikfU1WpsCYbiNiXpcxb4TM4=mOA@mail.gmail.com>
In-Reply-To: <CAPSxiM-OyrVEzYgja0nwa8PikfU1WpsCYbiNiXpcxb4TM4=mOA@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 20 Oct 2026 22:41:01 +0100
X-Gm-Features: AclHuK9DvC-3VF4hIqUaVaTDKBnW0oTzy4gxVZIIl50khryB3JmFOYCXYTZB2R8
Message-ID: <CAFpMFfA1yMJO8=UX92+_x=Bi2CCUVT5rw7gEFqH-DfdNSsjevg@mail.gmail.com>
Subject: Re: [Outreachy PATCH] merge-blobs: stop using the_repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 5:53=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:

> Is there a reason why the repo variable is named "r" instead of repo ?
>
> "repo" seems more "descriptive" than "r". if there is no reason, let's ch=
ange
> it to "repo" from "r"
Thanks for the review.
There is no particular reason. I studied some files and saw it written
as "r", but I will change it to "repo" in v2 so it is more
descriptive, as you said.
Okhuomon
