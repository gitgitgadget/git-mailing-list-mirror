Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1AF48FF72
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399744; cv=pass; b=Jdon/LJFJplRwh2Knz+gG0nzgB8P0tWtiin37A36BJZ4N8axg/K6XL1mAZD9AEjPIEvzvEgCLNoOdx+slr9HOqXq2FlTRkmZ0xHWSgovVaBnuzDj3wbZvjqL15Qv2lYR2zdmM0suwUvQY6/lUwd4VDUw/qUtXOUcvMQOqlpQXUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399744; c=relaxed/simple;
	bh=TDdmsk8sX2b6TSE5AKjlttKcauE/kkz9BMwVGajFpWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seMFyjlFT+vDL36jAaIX5CtRMb1A7n3LrpoB5n5INjIy5/BWTM1hvM4sMacKF5g72NHvOA4r+BEQjtz6kwzgD6uA83xiATOyNBwURLg3HzL6r53eLgHcUb3rsTPjyzUvQMt9URjgs1oyaOJnNKQQWTqH2N11W+c5BR8wSCxXjkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oNx9XFzk; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNx9XFzk"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5337c7b9937so380871cf.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 01:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792399741; cv=none;
        d=google.com; s=arc-20260327;
        b=ARim1fols091UlAoj/siMWvghGxjFoftRlgjmLeey6ox+8mIO9pocmEAsgMl6gY4cD
         tJSXiVOwAvmavtMbYJXvKFtoHzfgK218py4qbWHIG2AZHpKotoeqsXM7JYORF/WepBZJ
         JfswItQaxmCpIa/gC8kK8PR7uW2+3T35CEwiiEo5hXeuNQGasJawLxoqo3cn85CyuA2J
         y0Kv+odmsexdh++6MmnJATDyp10pAgQjB+BChWbUFbAtARf0Sd3Aoqxec0ff4PFaMAlx
         +K3k1yNvWdkoiGomE+FTtCRYAs2x0tdhIOT5mwxpeOcWdpSBDkH+cl919IQJ6aZ7WkFh
         NBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cV1cEtoQRu6LaapIP4xneupVJK+2HQWo8hG9J1LMvKI=;
        fh=WrtltJ/MxkA+Hy47VRmDr2G3MArSYxV3qDTXhnXoEqI=;
        b=Y64ooZEG7sPKYqv3H/N2rXKWiyk9APDMNpp8PLY+LfWvNfo4vq/NtaeHpIQI0tHXIV
         Ajer5ULPidMlueMfZOFCrqVj0kAheJ114uvoQrMwHEzElQjk3BZb2p/axOK89BVP2gXm
         djpwc1/PWwR5P5sqU7Uvsa5eaoUtqR25qwuY5Ag5yA7YvuFn+EQRDWOGgNkV2Y2qoysV
         PBt+s4hkSvytbhwnh4r61T4Y3uHWiV7+b3EIMlLE4vKhs/9QjLe1XHRQ9NmvpeQ4zfMs
         bv8jelt85Wd4ozjiSxq87IKFOX8yXB9xRMvvJTgckH1OwpiBJU1uTjHBXfAcBccsGe54
         MZpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792399741; x=1793004541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cV1cEtoQRu6LaapIP4xneupVJK+2HQWo8hG9J1LMvKI=;
        b=oNx9XFzkhOfEoaGc+tI6HcZEXvgi+j8LkpYYyOqCopfbeeRfdQ3uXXxxX5yiYANEvD
         ZMf1TYm02Lq8gEcwSClrmwXHN7q2AeftCHrNEnairth3TmPYUHfZiVQo0CtIRjdZZ269
         HBf/W3VIx0+mo8ZmPRguDbP4jSh2ErzBDvcxHYz4TbgX0SRQDTyRrqLfmo25trVkYcWi
         U2vcU/jzeu1u7F9F3OefIDAujBs8Tc0X4GrHzphjUZ3oUAjWi7K9ZCtw0KZi7D3uHV2o
         vLXT6BgpCUBLQ3+Y9pRZMMdEyLSPlvmiaTBU7ODlHls3drjiiud56BbqkDA1M0kPXErh
         A0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399741; x=1793004541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cV1cEtoQRu6LaapIP4xneupVJK+2HQWo8hG9J1LMvKI=;
        b=J+BXiFJP19txnPs/b+VrjxmQ/k1kQA+FwpHzXLfHvTF2NXNUI1o3HhLY0I2kDMvVuY
         H6T8SeEwGNQ5GADnldLFDeVxngZguIWN1DSEjh9jKr1Ey7H+zJmRUhncE6BeZ2Svip8U
         bpVZx8T/Iqj86LcmzhHTNbpZnguGw/cNB9/047u922u03+hXwLrwhxGo0X9qJ5WvDgUl
         9CErcRzu8KJVTgykoDMWlDg4/Xs1VrLTYAxJtLjlWk0SsbxcD9/4qfPaoxhTaZyz8Fv7
         jy+GN0TDwDpVBcu6T9XqPIndVRJsjAOviV3S6/2xiX/M3rBCniKsxwOvI3obxhQgVltD
         h+uQ==
X-Forwarded-Encrypted: i=1; AKwUvByzonviqzoBGo7sjI+PV5HwoUWRSxY760sbDJEjgJtK9HoW5HJiUvyR4xW3NX6fxM52XHk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkZ8xPkDsNznaL+9ZJMEOZ0TxrO46jAvTxzqhGI75VInowjOxX
	hyeh6+ZVGm5+sQiNA3c7JQQ+5axP5zrxG70VsicL7OCFLj1sfMKSNc/IugbMzIIEHrj14rGuht+
	n7BO+1AHCRx5yVb1l6jPxEtwB/CE5jDFHRaMGTmRb
X-Gm-Gg: AYBFou3dE37zH/TDTTdr4g9JdEgBJ9/Q7Y+0I55zG1uzfXZU5fTCDIYJeITBF1i0gwZ
	Lgzy7l8npx5NTNXoo8d6o4OCX6xo3jqiS3yINae2an5cpwbJ8adrKTSbwMXGZBileAgwej/NsZt
	dp1HtQvFrhaAAjxp27cSTXyCUA7mYVfLiBI5kq6sy7hBpR5g4A7jISlELqhagn9YHatXRkJOYhi
	u5YXhbWUz3oCFXavbqKGinf938p3+D3NyBB/MH8RnbX8eckkPCMptrNJaWDLDLo8IeGgTTqr+ZB
	zdQD7iGt8Oc4hgktzS5lEpdWkbC/uVEL7KJx3qe41exfrOw7XdBDTyzRL1/wGqpvi6TsaJyNOTH
	gyXx6ULCPAyuAFqdJPA==
X-Received: by 2002:a05:622a:2609:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-53649a12adbmr34084981cf.4.1792399740664; Mon, 19 Oct 2026
 01:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011210928.3900020-1-xfding@google.com> <20261012151748.62723-1-aniketgupta3001@gmail.com>
 <xmqqv77696sf.fsf@gitster.g> <5d5dfa51-abc3-4a8f-badd-48ee398ad73f@drbeat.li>
In-Reply-To: <5d5dfa51-abc3-4a8f-badd-48ee398ad73f@drbeat.li>
From: Xiangfei Ding <xfding@google.com>
Date: Mon, 19 Oct 2026 10:48:48 +0200
X-Gm-Features: AclHuK87jZcKa3AFrZqG0rQ8nzSPktNhMr9dCp4i3nXFuvxzDr-oVBKKJfR7WwU
Message-ID: <CABtdbsmUU-J+Ytdno36hBH2acjT_1Ee6dQ2DeCAXhwaZ910Paw@mail.gmail.com>
Subject: Re: [PATCH] imap-send: use ASN1_STRING_length
To: Beat Bolli <dev+git@drbeat.li>
Cc: Junio C Hamano <gitster@pobox.com>, Aniket Gupta <aniketgupta3001@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, davidben@google.com, 
	dingxiangfei2009@protonmail.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear all,

Ah sorry, this is buried in my mailbox. Many apologies for the late reply.

> On 12.10.2026 19:18, Junio C Hamano wrote:

>> What are these two separate sign-off lines doing?

I contributed to the kernel under the other email address. I shall use
this email address for future correspondence and sign-offs to avoid
confusion.

I have finished reviewing the patch from Beat. Since I really prefer
that approach, I will retract this patch.

Have a nice day, git.

Best Regards,
Xiangfei Ding

Signed-off-by: Xiangfei Ding <xfding@google.com>

On Mon, Oct 12, 2026 at 10:09=E2=80=AFPM Beat Bolli <dev+git@drbeat.li> wro=
te:
>
> On 12.10.2026 19:18, Junio C Hamano wrote:
> > Aniket Gupta <aniketgupta3001@gmail.com> writes:
> >
> >> Hello Xiangfei,
> >>
> >>> +   int pat_len =3D ASN1_STRING_length(asn1_str);
> >>
> >> It seems that with OpenSSL 4.1.0-beta2 this is deprecated
> >> (ASN1_STRING_get_length() is the replacement), so it warns, and
> >> fails with DEVELOPER=3D1. The patch adds a second use at the error
> >> message. Beat Bolli has a series from 7 Sept ("imap-send: future
> >> proofing and two correctness fixes") that also touches
> >> host_matches(), maybe we can check how the two can fit together?
> >>
> >> Thanks,
> >> Aniket
> >
> > [jch: rewrapped long unreadable lines]
> >
> > That topic also needs rework, unfortunately.
> >
> >    https://lore.kernel.org/git/20260907211210.2621693-1-dev+git@drbeat.=
li/
> >
> > I guess we can salvage the patches 1 and 2 with fairly trivial
> > changes, namely with the style fix in [1/3], and pointer arithmetic
> > that breaks later free() fix in [2/3].  I am not sure how involved
> > it would be to fix [3/3] in such a way suggested by brian in the
> > thread.
> >
> > Thanks for reminding us of the old thread.
> >
>
> I'm working on a new branch that uses OpenSSL's built-in hostname
> verification. All this low level ASN.1 code will disappear as a result.
>
> Best regards, Beat
