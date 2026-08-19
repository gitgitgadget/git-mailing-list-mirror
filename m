Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0E3A5E98
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145866; cv=pass; b=Vy1HF7m3qdIfUvcPCsN8J89lBp2mkjt8GpjRMtWGHTwhcWJglF+wxBN2NzNsHk9IrdE253H7/rISAWghC7gwFAzlfKPwCA0rHeynz4y+wp3mBXputH7wkhxSc+rdnIwNky/KVmboOIiTE+Rq+afImbv0dtayc5bsog1AAac4aaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145866; c=relaxed/simple;
	bh=Uf36ytPu2N9eIf/bPtt2hd4l3vOVDQQLG2bT4NZyyp0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHwwhujJh093kl+sX7o/4C8LG7xouprLvtSQzQZQ/kF84wZ2GLPzWdFcOWSea7XM+36kAFE4Mf/ytDTNXY1MZL8VBSYLgI4AqJs0IIrTGzPahyaDC1CxcnUvorw/aVvqQdRfC5susFcl+21OCMt04X43k39Pw4C05SxlVWcvieU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXlffYiX; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXlffYiX"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9696319e14dso347466241.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 06:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787145863; cv=none;
        d=google.com; s=arc-20260327;
        b=ldt1NAO18ya9LoF3bMarbuGUXKsJJo98j2ZkrpUbN7efS7l0JrCXn3U3tzEwCswKcc
         b97ZfKUeTDh+eOQ3YKBggetaEcgbGRStM8XMEW42ymRiNLAKG/5pcK7FojHwJ0S7H1Jn
         JeMOpqNnLApwCnap0SJyfv0Rc+slPKEnzJ59Mk7YJLGDp2nWVpZBjJD+QHX1QpjWzQX1
         Tibzqn6UgtmxqPA9549A7K4/CI55Y2agdZyiI8//hKpL0t9FUUYEM+PbqYhcwOwxooO9
         tbYnC0iN4l9iVdTWN5V4rDQzX8xB1o51kg8Z3J46hZa3tozbK7Y7dDou+RkBR6OfelPd
         ZRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=oi+SwlJiCXdo1bNL4pp6Yq8aelMTV9QZET5gHsakBrk=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=U1YjKFDkMLto2iDGZrG7Dt+bIs0ascNhvb+qmF55BW3PF2Kh8aXxwyCsEkyGjdlXru
         pdymTuYfG13EBknq8OE+pgzzXMAjgHq8NClsOPGFYzxSHUtoVg1PYo2j1nMWsT5UZBXR
         V806+UXvYycEzAf0grCF0HMzysnQUs8mT/z2VSMUbfEy0JUSUWyHtIKOWFK+fReOWma+
         dXQZqMqfuTtHvOjQvNK2RHIwdXx9TmLou6IOkdTklJTFsW8Fa9npJUYChb1eJoOCLOU8
         Ob5OVo9dIZvuCvAwy3kbJr3TFCHeR8mucaVNLpNjRRv9Y9/ZsXeNWxX24X9Wier/6wcf
         iFug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787145863; x=1787750663; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oi+SwlJiCXdo1bNL4pp6Yq8aelMTV9QZET5gHsakBrk=;
        b=DXlffYiXR2kbrVPqDlgalH/oyi7KSWLrVo8MmQQzuYif72t6yJkeug8A2SxZo5Tfy7
         mV4hFIL0oYYE0dGiyj0OK2AWzpIn3kIip7D5tCHluaBTgy8RoJ6p+/p7lqV1p/376sCy
         LR/qbYC0T0WzHrn82ID5AEOwVydbAePxaTnXlB1bYJxCSbdcn3HQjTrMOJkLvAxeDULG
         3kPBmtEPguApYBUimsSRlBmceCrF34dKqLqEFANVs1Mo/nr9sfswHfOzFB3RwNpLjKCd
         Kqt0Fwifg8060H0rbvFbJ7T12NdZToEN2elWPtYxD8GwTgDF0Yxcny1bLyWcq/uD0guE
         YI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145863; x=1787750663;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oi+SwlJiCXdo1bNL4pp6Yq8aelMTV9QZET5gHsakBrk=;
        b=d4JiO+6kaNKifPqVO8nJFk4+wGXn/pFGG6tQQCFyM2BA6yMPV3hUizbBNPQs50jlSp
         vuqgL/g73FoP3pdQNFiHXECbC1jm4c96Szz9X0miVzZtW/hiqTnlcIq7haCP8bs9DDWT
         l4wsJ36xMhDFKJn6ayYrjsh/P3xFQjwKjv3wtPGhyHNqYV5NoCIGcJ1oHJSgUlNYn/xe
         0TxKBfGRI2Cmh8KWP1oeZpFdDzLoia0sYvmBb8gBKDxl91pvLoauQZD5s6AcTEI96cKA
         HMZ4/NYpC+1Z7I6V1l1lC5AVacMQhWJUun8hM39OCcV2Ck7lPA4srrzbOGahEd/KLAry
         J/xA==
X-Gm-Message-State: AOJu0YzyIi12HbNVz20HZi2cnw6erLo8KAVp3ZaChTQknLnG9wtxTPbi
	wpRBmXQFSOJQmpgeUIjSS09X95LH4y6YojtXMtXGxVPvzIsSLAx0hPrPo0ceJbNgDn+4tXFamsd
	ntoMglAp2B+vUxe6CVyrL/U+8IhXqlsI=
X-Gm-Gg: AR+sD13lfks9u4Qw1eSGUhdULW0om7WWm418uEnmnBLGi7srfrazSSjJrCEq4pTAxVG
	IU61bnZqlJV47fzbESTstAhtaETboZn6PEHA2OqEfzANpZsVfPB00w1szJVD8CkzLmWXKp6um/H
	atW3gv6aVTpW8m9hYfUZmnBas2GhGLlAlSpKdCY1TPjHyGLqKBvTxSN+FTlDGPfuuIc4dBYNTne
	dXiZiSOzjFs0rTnXGqc1V6cQbsV6BZpQBo3k7JXWkHJ6dnZJRMClSpltlGT0cziBVqvPA0gWwvm
	PjeB/pMSGAGEgap6FXIX7A6xzUYAsIL2UfTq//a43AL6fMSTVTjIvllSyXtJiIMrAXYXTq/E0dh
	cQpPLKQC8DXlS/abaQYp7ua1jVjhUP44fk5mZU4EOIw5Fhv4=
X-Received: by 2002:a05:6102:370f:b0:6d4:ba3e:bf97 with SMTP id
 ada2fe7eead31-777f8c84ecfmr1427159137.4.1787145862535; Wed, 19 Aug 2026
 06:24:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Aug 2026 15:24:21 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Aug 2026 15:24:21 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aoWtgz8wWsb3v6du@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <aoVdlC7myRFenPfV@pks.im> <CAOLa=ZTtOJLXkfZ8jKpuA9REg5CP_xxD8+kDxPAYLeRz_xR1Wg@mail.gmail.com>
 <aoWtgz8wWsb3v6du@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 15:24:21 +0200
X-Gm-Features: AcwNN1WiolcHX4ZQz_e3KXK8z5-SVjjsl1izaID4vJEqPopqidO9yUcvQ_9tctc
Message-ID: <CAOLa=ZSuzd3FozharJ_1LRgaQdpY+eRZnMOJYoLJNvPXiait1w@mail.gmail.com>
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004c78c106596652c4"

--0000000000004c78c106596652c4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 19, 2026 at 03:13:50PM +0200, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > On Tue, Aug 18, 2026 at 09:55:55AM +0200, Karthik Nayak wrote:
>> >> When running 'git-receive-pack(1)', there is currently no way for the
>> >> server to intercept and modify the status report before it is sent back
>> >> to the client. This is useful for servers with custom logic that need
>> >> to transform or gate the report based on the outcome of external logic
>> >> post reference updates.
>> >>
>> >> Introduce a new 'report' hook which receives the pkt-line encoded
>> >> status report on stdin and whose stdout replaces the report sent to the
>> >> client. A non-zero exit status causes `receive-pack` to die and the
>> >> client to treat the push as failed.
>> >
>> > I think it would have been useful to add context why none of the
>> > preexisting hooks work for us:
>> >
>> >   - The pre-receive hook runs too early, as we haven't updated
>> >     references at that point yet and we need to have the full view of
>> >     all resulting updates (both objects and references).
>> >
>> >   - The update hook is too inefficient as it runs once per reference,
>> >     and we cannot trivially determine the last update.
>> >
>> >   - The reference-transaction hook cannot be used by us because we care
>> >     about the phase where it was committed already. And while the hook
>> >     fires in that phase, it does not allow the caller to modify the
>> >     result in any capacity.
>> >
>> >   - The post-receive and post-update hooks cannot be used as they run
>> >     too late, at the point where we have already reported success to the
>> >     client.
>> >
>>
>> Yeah, this is worthwhile mentioning, I already have made the commit
>> message a lot more descriptive, so it does become bloated. I think it is
>> justified though, since more information is always more useful than less.
>
> Well. Until it isn't anymore :) Just look at the walls of text that AI
> is prone to generate, where one is essentially drowning in information.
> And it's the worst kind of information, too: plausibly looking but
> inherently dubious.
>
> Anyway, I digress. I think in this context it's good to have the context
> indeed, and I trust your information more than the one generated by AI.
>

I have been using AI to correct my grammar :D

Point taken, I'll try to find a balance.

>> >> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
>> >> index ed045940d1..7e6643ad89 100644
>> >> --- a/Documentation/githooks.adoc
>> >> +++ b/Documentation/githooks.adoc
>> >> @@ -527,6 +527,29 @@ The exit status of the hook is ignored for any state except for the
>> >> To reject individual ref updates, rewrite the corresponding
>> >> +`ok` lines to `ng` lines in the output report (with an explanatory
>> >> +error string) and exit zero; standard error can accompany this to
>> >> +provide a human-readable explanation. A non-zero exit status causes
>> >> +`receive-pack` to die.
>> >
>> > We should probably document that we expect the hook to never return
>> > non-zero, even if it rejects reference updates, and that doing so
>> > indicates a bug. This is mostly because git-receive-pack(1) shouldn't
>> > ever just die on the client without giving it a proper status.
>> >
>>
>> Yeah, this is a part I was thinking about but wasn't sure if it should
>> be added in because, we could also do an implementation where we simply
>> ignore the exit code of the hook.
>
> There could be cases where just making the whole operation explode is
> the only remaining option. So I don't think it's necessarily bad to have
> it as the nuclear option.
>
> Patrick

Okay let's settle on that.

--0000000000004c78c106596652c4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2792c3d1e1f755fa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRnJvUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmpvREFDWmFsYWZXZGRhSUQrVEVIcWxxUXVJRFpCNgpycDNGVHFSQ0tM
d240dXBaa0xOdjd1eUxoOFJMdjh0Zno4cjN1bk02RnVlVGJ5VytHNGNvQ1JHeUFHY1QyemJCClgv
UlpBY0hkbUJ4cGRiNEFCc3pVcmlPVDNSY3AwVG1xc3NPR01SK1UrZkt2VDI2T0JMa3g2cEhGaWNJ
RW5aN1IKc2E3NWpTNXR1NUoyMmlzVG41STNqTWpueWVrVFZqb2VCNmFwc0daMmlDaEhUL0JmQmJX
ejlDeWRPWDZlcGtBbwo0eVFCQUE2NEg1c2ZudDRIbi9LR1dHSEdWWksvR2ZIQmxVdXdvd0pHQnpv
eitDOUVTL2FicTJQdVhyalNvVmQ4Cis4VzlUMjNHUUoyZ3QrdFc2cmgxNldpS3hYUkZwMkUxWUI4
MElSekNyMy9iVHhrQ1hwL1hIM3lLRFZQVEo4ZWoKUDA0SnFELzB1R0p0RU40YmFzVWxpQ0tzSlF4
NDdCWmF4TVVkdkZBR0VPUW5BQjNUS01CZVgwbGhQdHpLZ1ZVNQpuR2RiaTZmUCsvNnhUdUxLdGR1
MFcvNTZzTTBjRittbXQxWkh2b0dVZ21ITHdmNW1wOS9iNDdXV1pYWWFTWi9LCnVoVWdadGdMaC9a
N0kyWHhsMjRtenNTZW1YKzlxa29PSDRrYmszaz0KPXdrYUkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004c78c106596652c4--
