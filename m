Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3253AEF45
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672077; cv=pass; b=R3S/mwfGgEIDKFlJZzI7nKNpwsam3/ghhuBH+Qnt1tgbQseBRszrUywNIi5VcidIzE1l0fpJZvd4YlHVfb0GITFbdXg0/kFEjUkzdEp53ARaSuOz6WdfdHk7bZfhP6azRlcXJnEN761Dd3yFXFH7Fi+TiR0QPDcj69SKPN3NHTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672077; c=relaxed/simple;
	bh=UaDdqYgzFDiwuGZ7InvTVN3b70+0UXx69vdMnJMvb/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmS6GDSXpNc10SgHhxHcAOK/3ykee7xel/ovVz6j356bkkfaVpEow1fdGjoCbOLGhf2ChNm6Km4mGkCvb3mhmmnamsqrWnb5sF0pD6rbVmvovId9qkN2GKr95pVHqiIYN8xiTb7cQ/YNJ0Lb50Um5d/OisndU4MJOKdKtqQd/Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR/zJgu1; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR/zJgu1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so12276085ad.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 11:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775672076; cv=none;
        d=google.com; s=arc-20240605;
        b=YJstQCrnZcOCb28khc4s9h/ubrNJ/WWtbTUXD8kmvkCzEdhpAoXbXSZGLNSW9y9+BO
         guXTbMtrNF99h2RT7DKfc6X2vAi0vOvHS9cNMDjQ9YEOVc5jHsaiKVAuVHucbowPPNFR
         PBjh5u+8hVrYeU76t5QZ2sB8gtIJKFR5SYgpzSsC+4WwuzZQf21Yg7KPrtgMWW1Y2DMm
         15OIhAe7R+L/CiVDmOtWCNhe1wb7rZ2tvDylr1OE2WHc9OsSkyPtZS8VtVTOzTm0u3Wv
         fMkYISXeHu6RUxKMdCmCe8iGe0yeAXZOZGpWGJ96/qOpQyWABOE++6moChS5MLR+J60N
         iNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NSPOD65+QE8VUl0lF08xA+Wm3TWEy8k3M4eIX3hGQf8=;
        fh=Zf4UIQDULNtxLJHlDYx9xEuHM9LnA324xYtJg41u+VA=;
        b=TBMX+dk0XWJ4trGA4FjCdhi/bp5cgG4KtJi+dZs96h74POVBTk9oAleLO8LeHDAPAB
         xW21hAPwqjwmgLJOmul5Q2HVUEPcxq96y88m/d7pq+j5cysAcnFQBLCivHX426q31XQK
         RO5g+r36icX6+xO9yBxLTwLaPJYNScHCWLrTbM3xo5k7RikPeYWnDHhuq8wXLBU6UW1f
         FT7M73P6rYjjDgpQBc5qoA4fTEah4WUMccoWkvxtdOaHgXe/yKrewj14gkdlEyDRfdKe
         qI56EegZKlQ9HLzcOJ+wZQw6C2AkqeNVY8VAaanMVWPWalAg+DoXgKF+7PVRuNy8tp57
         OVig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775672076; x=1776276876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSPOD65+QE8VUl0lF08xA+Wm3TWEy8k3M4eIX3hGQf8=;
        b=BR/zJgu1GJ9egWIR6Cnaq2BCT+fYgGJiepSdJTnezxayh5vdjOJk9NNtISLWuydQHu
         ppenmzJBrxN5lEKqFAqsP7+9lzul8I0kKp+qprOpGbn6xVlRWamp6T0MWFwTHD0ppNv6
         thWGfsFvA3aybl6pR6iMfEPo5mEQ78T5YDpwm4ikJ+M6o124nV9KaryO2i0bhccQGeN2
         gUs1rzLuAk4v/6evgFjpTruLC8dbdPT2BIcXRUGDCiSubIbreSTFueqzr5x2En4qgml7
         LYy3xSXCUdtKiUwOjyUHGGA0Qas/tI/ij8r+jzS+n3x/nXOddn7p1ubhqyLV8FvN64ln
         CrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672076; x=1776276876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSPOD65+QE8VUl0lF08xA+Wm3TWEy8k3M4eIX3hGQf8=;
        b=ZCXavW8NEuBuiLR4yNWmbaw7z3VCkwg9tk5rIOaVRYSlllucXGFfYbh2GshL3qO1D8
         CY9X232gDZbU84HUdwTpyZ2hhmlxVRfk/n7ljw7zPWo9uxsg77VBpZ6b8F02pDGCcsDM
         o7lDdwXJYYU+pj05XhE3AIDlNA4sJWjuqH1+6zfekgpI2wFif1qO1u+0CUwdURhi/m8N
         gqKs1P8QVpKjcZsy6Gzctvv+4XwWKgAq1oGY37j9NcP8+zBSoA66k5pNpnpIrIHsc4yk
         cMEtnKoZvB+KcHnXPmWtbVQbVfJ2neNR/aE0YwIImUhfk07CIxpBhbCB24hEIMyheQU5
         jWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUKIfmYgI41mUNKJuwNdcvFHeEK1OATU9M6dqGQxfX8AFmfLdy4FgYPPdwAsU4TlUeLj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17ccJ+hXMR28ghNU8FduBbRVk1AYMm9OKoKwvvVb1OkIUxabH
	YZGbzsb69zAc5NSEHUsSpKHwn85wK3rwzpMxsNqadgl26VuntWiHsivvrwVU6P2mlZD2VjgWtRW
	pJkiCjsYoYc6Uf7OCVCf0zHtVFtcBze/8E1ip
X-Gm-Gg: AeBDievfxiPUXQw4dF0SMgZvMxMZsfSmRRJ7RdCPARMM7I3vVTEq+E8GZja64SBxmpi
	LmStcFlPIhq0VnMuipjsW8fhrtIQwtDN9LuOERCP4j3MlCLm24qKVTyn6y6jLXJZ1uL/zqs1KJA
	+nIfbIZUVbKfVgHZEI01E6mlEQfqJk1cUqlJLBBcyhQpZskEhT3b3dc8IksXywWr6aTpjt3+nCz
	WFhrRTTRZxx9arsIYNyeCQr+32Jf4j9vpp1MFBK7Dxf23iZs1NtS+6/rmD0cksamlLsNsxTvYZ7
	yxNU4RgXhyONRN9QBnVU0RPDniYGDStPktDGOubNrjoXEYzmKs/r/sZN9ZraH0A2xhHONNQ48Iq
	NWxR09Nh4hcybBTzvmxnp52yi3X8=
X-Received: by 2002:a17:902:f64c:b0:2b2:5168:2f82 with SMTP id
 d9443c01a7336-2b2c7384dddmr3602935ad.24.1775672075882; Wed, 08 Apr 2026
 11:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq4ilm7q1n.fsf@gitster.g> <5DFBE9D6-0EC8-4702-99C5-827AEF8C6265@gmail.com>
 <xmqqpl4a68o0.fsf@gitster.g> <xmqqldey68ir.fsf@gitster.g>
In-Reply-To: <xmqqldey68ir.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 8 Apr 2026 14:14:24 -0400
X-Gm-Features: AQROBzD6CuOCD6OAe7_fR9yP3PIzi8W7rgfkg8QuUkca23N--ZP5wUKdmUxo7Hc
Message-ID: <CALnO6CCwKXCxBobO5x2MZZz-AG75haJMaOANjc=KWzjHz1kTrA@mail.gmail.com>
Subject: Re: checkout: clarify "up to date with origin/" uses local
 remote-tracking ref
To: Junio C Hamano <gitster@pobox.com>
Cc: Jesko Schwarzer <jesko@schwarzers.de>, git@vger.kernel.org, 
	git.vger.kernel.org@schwarzers.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 12:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Ben Knoble <ben.knoble@gmail.com> writes:
> >
> >> I seem to recall a recent (last ~6 months) thread about =E2=80=9Clast
> >> fetch time=E2=80=9D and there being some question of how to record
> >> it. Alas I haven=E2=80=99t searched the archives to find it.
> >
> > Is it a bit older thread?
> >
> >     https://lore.kernel.org/git/xmqqh65b2ci3.fsf@gitster.g/
>
> Wrong link.  This one is better.
>
>   https://lore.kernel.org/git/CALnO6CB2TjwRWr0=3Dc2nWY5DnwLeqXiaA5fCiEeF8=
5zivmLggjA@mail.gmail.com/

Yes, I think that thread ended up with some discussion of what
timestamps are available and what are not:

    https://lore.kernel.org/git/xmqqseottxld.fsf@gitster.g/

--=20
D. Ben Knoble
