Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610957262A
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769211038; cv=pass; b=X5lhJElmjcyo/0McjEZv7oyoIYX+OXhpq53PtB5EAFbYh6KdFiXC6PHYxpiS1zys/IgHmd+sRA82nLudYApLHdnfog3N3JdYM0fD6rwjaJjMaD+/bk+eK6UhM92ov6myla+DrAkHWyJaL6nULcBBKE02MSMQ5ZH2pot3R7CaT28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769211038; c=relaxed/simple;
	bh=G0NYwVz3vq0f5pvSS3oBWTlIDF9Wlko3pdAq1j8oYm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy6ZsxJo/avqU/BdHY7IwFiXcQgU9XI8hklsgCqxhtBBkV/Si8uYYQl8WFEXMRWpfk0/tctvW72kPsPb3/KVwy6X1b0DlfB7Nz65CY+lvkieGCG3J1Cuouv4ydOSmTsSpB2zUKrgs6AaNbgjGGXTLpdecT5JVdXidtwRrYPMTpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn9lk0tU; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn9lk0tU"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79427f739b0so29079627b3.3
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 15:30:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769211036; cv=none;
        d=google.com; s=arc-20240605;
        b=AmImTufFBAryMNedv7ocU7ik/iP2JUASPV22RrmUDo3pPKKy1GuZynSZ21jXtMZM8h
         UAcsvEgtppa8ITRoLqvVWo1m4n6Y+2JVFrQaY6r7A/dz9Vi4LIgnysk4P99rsK/Vc9m5
         cSRBBst4579ndBenoUb6CTquSJpgm4rt9axBPf8Mm90rMl1kHKu1BqPttzNtyqlrjbJe
         cZvimxbSrNlfW1tsNOGJuQhPDtA1dbz7YMkzfhNF1631Pez7u0l0H03fsuX5jocX+D7y
         KQ8OaVKVBTOsWGkkrWJqwzuFm93e0M73nPKituoiDiOGm8hoOB3594xnLSCiQdGtONKw
         wbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1JpzOttTpDRZ0P2fx5sq0qdA6t3JmLlGYqxjx8DGEn8=;
        fh=zDOedxt1Xg2HIVY5L777stFP+7KZK5UYxHyCEp1dCY4=;
        b=VN+rR/Rbp3nJwmozVauLrQx8ISYrIEc6oZXTXry4jLraO6XHoU+ZfXwnkHP7cpyxoR
         497V5RPoYBzvrzGKSh5ICnBhFixDwJH2Bk1D+BSkxcymqEpnh2cwp+xnQOvX6SZ3ztCV
         DZt7+AiS4YfihF4Zh7+cL2H5sBZWnZZyZdfcTbvY7XS49rON9M7pB9hrf+DAnT1IJ3uQ
         Db9luXwJ6TR3V4nfc+2NlwVvCmfvaOzChdocmJNPyhfhfG/gJxv3vaJdV6Wh8RaqHJy8
         FFdojPFxpbQp4zyZZk0bMkSNma+O/PGPwejNMYHigb0Q1EQfBUlDQ+9eSSy/wyyR6YJ0
         OfQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769211036; x=1769815836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JpzOttTpDRZ0P2fx5sq0qdA6t3JmLlGYqxjx8DGEn8=;
        b=Hn9lk0tUhXj4ORP8ZJ/D1QJfcwUvmB8nmThlQdL0ld9+OdI+rL5TxWO1qUF1ZhbVlI
         DS2fRvHFoOM/7+78bG4x14SVuXcGqSiGWg1FzkrJbgT+KjFK1Hoq0VGB+UFU7aje5iqD
         OmkyzVMaJnqxitDCsdlMf8/o+apKP82JgVl63VQ5soWkquT9L51Q4n3/oqOCuxyD2lgN
         /xUYQ3+XaqS359HgO/F0q6WRsYFPk5poOReemBt6owzODnMn+hCbBTe+i0ZmSLCprrDR
         yilup5DsJ3Wl/H4Sz5lm/7wSUsArL0DmiQbefha8JxRkC2TlW35mDQHGmqgSuaonTHsC
         w8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769211036; x=1769815836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1JpzOttTpDRZ0P2fx5sq0qdA6t3JmLlGYqxjx8DGEn8=;
        b=MXp6GQ/HTPITGlqV4Far9XdmVzwzIGElD3nsKax1tCwrXc3Ws+4c1lhYxMifCBvLgo
         BUYU47iQL8mzy1N25LKbClFQUCiJ08NU+kHVsDYxq1dsADWAYEEdi8Qs/LODk546H7t2
         ipTtyTfjuaLqYoXq/B4pY6MfgTqdZYhnVt3tFU57LZCvteJ3B6ginf43GLnktQgynNdm
         3zqH3PsZqsULNeQiyyqfjuAdHHM/tkiutEDwtYSWahjmuA12zn35Y2IM03Z3I6A+KXuS
         4KVhJywamztrIoILGNkZFYw7TVlHo5ofAfsaKvca0EcEaYthUTeiU6fDkXgfXt0JJNDo
         BnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjf3lS/OB+mMTzzP4Rmdxx4DsHZGbALkJ/CISXNvP54A7bj8qLyp1xKd2el58CKBTDfG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOwqhDQJxz8TncatjLTTAjrsVNWyus0zXXCBxxwL7qih415oC
	n4miFppHOEWpO1QsMOEfe1qE7BAQJz7WXWdISr+jXBW6dL/d66xnSN+tnLKMjQcYC+NC2BmU2CD
	F5tB37Z5i9zEx6rxd0bEveR9NCbftX43FjVG/
X-Gm-Gg: AZuq6aLmwM3Pjz2PJGYA9G8ggGPEdd41zOC8ZBAgvSXuclk7m7CMxKK8VKgjiWVmvNG
	X7tb7phfogJcKiTPsUzrz7Ppccmzz5G+XuCRG4JU9XpaobTRGArs1IMzm35jrYd+tiGlEboirQ9
	QU+OZnOmvXIDQEEwbq/9Rqy+Q8g0YFFW9SjRln50sjAmqx7JPQqjau5rdlUA3rPW2Jq72IrcxhV
	MBGxMP4DRrX5bGhS1cfwiOcKZ+jQPDqIQd7Dwaw2omehkIPAF8au6i+p1wuJiGFQoM4bHeMXDk/
	q6f1gy9yeFEEHlw=
X-Received: by 2002:a05:690c:e3ee:b0:794:15a2:13c1 with SMTP id
 00721157ae682-7944093ebb4mr22160077b3.32.1769211035994; Fri, 23 Jan 2026
 15:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
 <20260123210643.GA2728629@coredump.intra.peff.net> <xmqq8qdogdmu.fsf@gitster.g>
In-Reply-To: <xmqq8qdogdmu.fsf@gitster.g>
From: Klaus Sembritzki <klausem@gmail.com>
Date: Sat, 24 Jan 2026 00:30:24 +0100
X-Gm-Features: AZwV_Qi8uK1A9k6Vu0CT1sgES3NPq_J9p8j7_TeWOYHcm86BAfXpW45ruYqAiIQ
Message-ID: <CADMnYXD9BOGyBNX+7pecow=by8n_+Zhh1EJ0RYWd1c1qujrsmg@mail.gmail.com>
Subject: Re: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in za,
 and I am 1aa
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

1. The brute-forced hash

>  Sorry, but I have to admit that I completely lack humor receptor

That is a pity, because the brute-forced hash contains "codoodikk",
which reads as "code-dude and dikk".

33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f96b
cco1jgdebihg0deflefjmigleilonmfkmnjmknnoikiklcodoodikkb0cncfoifk

2. Jeff King's real hash

echo jk | sha256sum
720daff2aefd2b3457cbd597509b0fa399e258444302c2851f8d3cdd8ad781eb
720 =3D 2*360 =3D 0

3. Junio C Hamano's real hash

echo jch | sha256sum
c666df2af21b29a6b2c7f3b9deddda805f2ed8dcd3c72a6fbf38f6c729e2c98a
666

On Fri, Jan 23, 2026 at 11:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Fri, Jan 23, 2026 at 09:16:46PM +0100, Klaus Sembritzki wrote:
> >
> >> $ # My initials (ks): 1aa
> >> $ echo ks | sha256sum
> >> $ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b65337
> >>
> >> $ # 50566750337
> >> $ echo thinking | sha256sum
> >> $ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f352f
> >
> > Oh man, I've got deadbeef!
> >
> >   $ echo jk35252822 | sha256sum
> >   33f1a74529870456c56ad97c59cfed6bdeadbeef9b9bc3f4ff49bb203e36f96b
> >
> > What could it all mean?
>
> Sorry, but I have to admit that I completely lack humor receptor
> cells.
>
>
>
