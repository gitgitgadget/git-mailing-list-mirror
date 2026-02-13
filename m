Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C229CE9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770958959; cv=pass; b=KYlGN4BFQsbKpyuDYJdDmIB8gE94ux/cxSAydCdpX+p6ibVQRzLi/IodcUcJHRbZN6P7pQO9tHziC+B9AZmT7G7Ri9vLSkxQaumGuFxQA2IY44zxbYNssGm2Uq6GfRJ4BIFnYIm8Fo2jwucp9OS5xCUFXtYYHpy7varMkU3FVzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770958959; c=relaxed/simple;
	bh=VJX95Ibn17zOPezTmrT2CfVBcCKSd98l/ZWID+SCtuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ6UpN2sSmPHfahwGfRUv1nJP2eWwPrqgJJV0mHapEks/OBUXohOcmHSHAXfHWopuaIiSNHqO+/50uoHLBAIqNrX8JzutfWNu9dPE923c24p6RLVfyjD+5aH2DIoLimt75ZACTUMyW2XHRwDsqYpNfml0MMtqX/BDF6dtazSlN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b867142b07so31446eec.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 21:02:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770958957; cv=none;
        d=google.com; s=arc-20240605;
        b=bQRiwTW6snzEPq1b2/RnpAYaVYivJiAt41Hr+n/KEG5Z2/Yg+dEfoLvjE9pb326kk4
         VQJ+W3T7UwqxJMV+rnRXsTCNborgBM2hWHlThDKS/w06k6adattTxc5j4z/9Df74kPg8
         EYoAma3AZigHCsaQon2QKZED2FqUnED1TCGPVqA1Ur5EO1AIPikTtCIc6rSdFC/71QrD
         KtJq6nVemBYuMgCer4dO3h6XSQUbFdgR3mcYGtNjrEhc8z9CR4kWw236iCpMoQThXmTW
         NNJRK9zxhM0UgR4ZEUf3bztOhieP9TY17cwm0SICZa/LFP4UWBE98QzUUESHb8xLDOxm
         /4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ertHbXF5yMYaw9uq39FAQaCGlieY9kHf2K3XQ/espgw=;
        fh=eHyAfTbZ9N8XPD00UHW876TQLjVEdXM8SdNM/ib7yFE=;
        b=iTirVpxgr82Jy5FoTDRk1NODzJT5s7U+EUkaJL6QYXb9+76EuN8OvPARHIToguWy+0
         q/aPD3GSq/oVEMmbjIDN3UECPPW/pB7Bm2LKLG/9L4qGZ81c9jbvNwU2N5axT+pji0qV
         6l+g3ZoBM1t7Q/9oCvPxhmmCAdzKGaw2njj0YygcNqdsOqdCXwt936Nt3bWVsi2Zx13f
         VRh7XNyivK+DSKh1CbeVfzjBTSYr8M7k3seX2Vg1iwx8e8cvZf2YhnXFBlOoq1+xMNpH
         ANr/T+pYPmpd2iN+njbJ7ukswNLPuh4qzEUlzuBZl1v+hTxIdprK+Sk+bM0gAv06vE1a
         GcHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770958957; x=1771563757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ertHbXF5yMYaw9uq39FAQaCGlieY9kHf2K3XQ/espgw=;
        b=XdT8L/lt5Kt4P+eJbMsnORid3QWumJJj154iIxGA+r9RI8GbyVjpVqGjJVPFb/bQZR
         g0RfMGVEOECpaRXdaOvtR8rSl3NYllL+qEnIGAkJcNqKOLmyxrdQZKOSAopSb+SDwA96
         Gbk1KPao+vygw7erEaV9f5YreysaAYcnn7otxpTextJvUeGqdOTLH78GTFArS0IIhSvY
         UldQk708GJXvTIm3GYIyTWUUt0tXabMxlsOt0qrcYzQDy2510U9waiv5EBh9J1+lC0bU
         avDpEaNh6ufZXzkw5/7jluZECAlP8NkgYt9k2F/E9viZS4U2PafvKaTDQaTB74VqFIP8
         LgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNUob401Ywm/T/qsww56PZ1PrcAVQzBtDieklXXdzBhyArwOTugf3mS2i9XAwViQXU4hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfljtF2PBRjIefJrssbF/H8j5aQKDQEnxhW+0JZFWXMBJo7/0f
	SryJ6kq+++GNtDGAOdTeAXTGN2GBEaGnw5pSspDswQx1Aq2Hp/3RpVeLQk0rlZkuOvizZHxNXhk
	mPHWTwOefGboxZ347jWUeDGHRphpguJs6yw==
X-Gm-Gg: AZuq6aKiCPRHeq8q1OiXRGkd3j5rhkAKTyema9wyNVMM8sOmRVpapfc5sLbvMNzTmN2
	hPAeEPQe6HaNTNlVFk/7FJRVLcLhWCg4qY1xpDlzaMG5BS6juGvqG33d0eu0uNbSWw2n4a24k48
	YSSqkPoSeTp0tQgqx+zXhKLEWehbDfq1SgZkdskmGWuPWjCkstXwlF18qeKhC8OuVyoE0usZqfd
	ml0+GihlLn9gNJvkA6szFcFPAPGLLqL2keKS5wlk+ymNvpipytgMBxNuUlOHAP8RTiSPOZ6mbDN
	by+aQYkmuiPob48cq8BR
X-Received: by 2002:a05:7301:6782:b0:2b6:f2d5:2923 with SMTP id
 5a478bee46e88-2baba1034c0mr257174eec.7.1770958957076; Thu, 12 Feb 2026
 21:02:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212041017.91370-1-amishhhaaaa@gmail.com> <20260213033729.50208-1-amishhhaaaa@gmail.com>
 <20260213033729.50208-2-amishhhaaaa@gmail.com> <xmqqecmpnu3g.fsf@gitster.g>
In-Reply-To: <xmqqecmpnu3g.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 13 Feb 2026 00:02:25 -0500
X-Gm-Features: AZwV_QgyBYbx54ugw0KW7oP9Ma4aZJ9cyfSEgmkLtG0NqLHdGXv4jccXWcMeWQk
Message-ID: <CAPig+cRciH+qvjXTcW-32b2-QtK41rYXZosjNXy2mC0AijajKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] help: cleanup the contruction of keys_uniq
To: Junio C Hamano <gitster@pobox.com>
Cc: Amisha Chhajed <amishhhaaaa@gmail.com>, git@vger.kernel.org, stolee@gmail.com, 
	peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 11:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Amisha Chhajed <amishhhaaaa@gmail.com> writes:
> > +test_expect_success 'git help --config-for-completion' '
> > +     file=3D"$GIT_SOURCE_DIR/Documentation/config/add.adoc" &&
> > +     test_when_finished "git -C \"$GIT_SOURCE_DIR\" checkout -- Docume=
ntation/config/add.adoc" &&
> > +     cat <<-\EOF >>"$file" &&
> > +     aa*.b::
> > +     aa.b::
> > +     EOF
> > +     git help -c >human &&
> > +     grep -E \
> > +          -e "^[^.]+\.[^.]+$" \
> > +          -e "^[^.]+\.[^.]+\.[^.]+$" human |
> > +          sed -e "s/\*.*//" -e "s/<.*//" |
> > +          sort -u >human.munged &&
>
> Dedent "sed" and "sort" to the same level as "grep -E".

Also, don't we usually avoid having both `grep` and `sed` in the same
pipeline like this, considering that `sed` alone should be able to
handle the job itself?
