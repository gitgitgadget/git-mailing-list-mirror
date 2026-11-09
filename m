Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794188369;
	b=4Qm+oxZMEgRWKIMk5DhlruUV4kwQUupPHr6oAj/oQXRGKaP3QnZSL4y6X8QErIGcTeSj
	 +if2eIpsVUZyUElfnI+hTpDMn6quZL/6LnH3C1tPSxLUK86CXF8BA9y58sMSwU182ZUjA
	 IHIoX1TFKALvpLvOWqo3+dEa7iY8U76IsuCfqg5cTxw1uoDoER8+5qLLnL68z6dLNpMob
	 vFWcp/T+O7XCSwSeYrrTmV2uYH6l+w8o8dlTxc7xyt7tz2GDAil83Xg106lFK9cDq60Gr
	 0NzsS/8Q0nSfZ7PDQLvZacOUgHTviKOm/A4ye/KS3U4iNIMpMMtU58cs8l925/MHcrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PnI94zHiwF3yhwkWMzQxW8qMZpbYWSQhHCJvDB6WCdI=;
	b=E0r0cg+cnhOqGeJjtJq7Fs2bTzGt8YyoPTdl2rXZwxmeTZtt+ttdmUUDmEF/tPNRq/oK
	 dMnAuhTPKgE05NMpKIoE0jKQSQXy++7k+njqJE6H/dqahUSj/tbrAQs3wAavs1pPRn1lm
	 5ixIoM6px2ahGtBPgoguLnnUfL5Bz/hEiYi3qON7np1JmktcVuYhogAmdwj363CCOCBOW
	 9f03OtHEEZOAScoqN4LLujfKX8aS7X5AMk7Ng5S6dT1WDnRWsX36xOvBivlga9QflL7SR
	 CUYAGvf2aA10368wV18DObex6WgaDmO3brjnD+mDC1PG43VWqGPqJAz+N9kJgAhLanw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSiJdAcs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A30606A320
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 01:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A30606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSiJdAcs
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f2a8cfd4fso7406285a.2
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 17:39:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794188368; cv=none;
        d=google.com; s=arc-20260327;
        b=Mpn+yiCX7ZBcnjLntkoCRFJaEjICv0uSFfyx9Ra9X9cHOjTllcHi7OpASE3oeaNbap
         iM9Q/b3AU+JqEUxwR6cPLkI+JFsx2x9ZatPUMP0n1Di2E+1nD0lLEPqTYf5mqzdP8udR
         TgrmbZWHkfbJL/V7Sd3Y26KH7aExH9D3602vWV17ZD397L58aAmPfBCU1LvNw8F0OMEk
         J9OCnp96Ht8QW2VHswh8UoeK+zuE8C/UKfXIr4OmgD36gOTKIJg0Uuw5ugLeFHWpGp+F
         qHxAtJP+3G+l63u/EBpu/DYhSHPSWq6sX8B5TZLAbL9gkPromJix82P7cGS7HUM8OqJn
         lb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PnI94zHiwF3yhwkWMzQxW8qMZpbYWSQhHCJvDB6WCdI=;
        fh=KxAyhZk8Vz1NTWCbW/FpppHz3i4Hbd+EQXd7CyCVHdI=;
        b=cnTwmTU3mFs8cYfd5jUlLX0t+s/TN0X1t3IKkruay6hBn4Np2c5+Nao8cFLMqTPYXk
         RReef/ZRUFPVTiCfBYGasKyrxpbIwRDykSH1FcSNdyRuc+qPkrVootmkkOHiX8zODwCJ
         LppkJgxQrsqdGgjoPIjfi/wxojBcuJcEzEX5bro2UzTDWoDx4KzFQcCqlwZAnuQp+vHc
         TUi7JhMHtOAldL6c1ifrcUCtENE5TRoRBYF2F4JlG04s4aOOS1fk1ekDp7q7A3fYbDNa
         HAEnrlXR9wItLIkC72t1/WP4xGojuujmOCbpcNpux3q0bxLQza9fF9cY4osqsREroZ2W
         CQwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794188368; x=1794793168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PnI94zHiwF3yhwkWMzQxW8qMZpbYWSQhHCJvDB6WCdI=;
        b=uSiJdAcsl/25YkuaD4bH5g/cgWcDmwKEhUQyRYYfWTKyiIR6Wa0oHoAoj3W9LvRWuj
         BlQ99ELjCf4F9y/E9SWbmEcV0bVvHz0tV86GDnT3uqZR0a3dmB+1Bhd1hejH+BbQ/TFr
         3YtDWxcXcenMoP4YwZUYLwi8Y4G/g3dOCgr1m53R/gl6SdaE7xqjbnSQ0E2WNUS0fiRG
         0my9jjoFKarO9q1um/IABxns8dobULk2d7WucaqYV8/gpUGpY4aN9LVLdxWgLh93waJA
         X8h2jsWlmp7ec6ZIcc5N27ioLCAn/W2t9H26Avm/K+Jwf1F2N5jfr+f1RZd8eyXdKoCF
         jOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794188368; x=1794793168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PnI94zHiwF3yhwkWMzQxW8qMZpbYWSQhHCJvDB6WCdI=;
        b=FonT/rErr+d3JTiI5MEV6xXV0K0jzMe9rLEhpkZDpDqPMvIsFmcmP24wCN18lqgSJn
         SzsMDYrPGBjiZYl3dsddtiPzNRofnFXJ1QJyYa50PwbMeTZSeVdSZ84RATkq4w0RwiPs
         goQQI2YlVq2HzH8HV6m5+3RwyepagH0zqhmpLad4s4pOpRNC9KhkrOZwrTkzpHr1FVQu
         +QPJpObwCs3v5VJp3px8j20D+MCO5rFfLp4+ATD268Kuv66g2FKD6F82F14+5XrXCKzX
         stzGoRzyUdV0p7hN8GFYvSYNFYH4J3ihxFoVFNTx9VZE2waFkP+Ur9jIEHRbmjBXVg6r
         1i5g==
X-Gm-Message-State: APuU4Z/16fbjJFsxGrkYdiepj0/N2mM6isokmTYSGJLCr26061A/3yr+
	ZbxfTK8Zzeu4r5CrppFegDSvetMTU3O3VuxXJSQ3zaT7VpnYqvqrL7E9l2KeSbVoESM1JrdvO9N
	Npj31gy6DvGg7HprpqI/CMvajnk7Dxx4=
X-Gm-Gg: AYBFou397iCkAHy8847TZno1dEfo9HTdVhDB+XUutuF0xuS0yMCkTt8wfHM+Ndjw/tw
	tpEBWAyjqzb2GvQLWwupbueDz2oBtyJexl3wDktwgCckmKgHlFEdBuqauxsCis14zToU1xcJemF
	OGRhgiLl9vT8sZsmae9MT6P+TjO4GwOobGaHDMvJ8DoQXGULSXY0EU3ziahmY8dIH8+0y7WMiwY
	BIW0IkxCBx82aVYXWwY+L9undWJHmSgOCiC3pRtNkZetN3lzZ4es/VugTawJMvBKfKwm3LMe7Bz
	TqpsomDe0Ar55R2EBLsbsqtx6hN+S5+9JZT0xEtDGYeDe3AFd9icFU7nxDJnAZ+YCp5aTdl9fJW
	Nj7WhahjDjixvyqzAty11voqdMBU1dbG1y0k=
X-Received: by 2002:a05:620a:a913:b0:93f:a34:d9fa with SMTP id
 af79cd13be357-947840f2208mr508579285a.1.1794188367843; Sun, 08 Nov 2026
 17:39:27 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAP8tz2L3Dfhd+ec4+SFkZgXmzQnBg+3Y0REAV+1Hf5X415qnfw@mail.gmail.com>
 <CAOLa=ZRSQ4_EGC8qTs6f0HBQyxj_k0Z-zt+uXt0JpO2Z3Mpqzg@mail.gmail.com>
In-Reply-To: <CAOLa=ZRSQ4_EGC8qTs6f0HBQyxj_k0Z-zt+uXt0JpO2Z3Mpqzg@mail.gmail.com>
From: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Date: Mon, 9 Nov 2026 10:39:16 +0900
X-Gm-Features: AclHuK8_TT-6vGRoUZ17IlyCqogPcxds3W3nDC-f_GzGB6V6P-sihxYtPeS4gRc
Message-ID: <CAP8tz2KFb971L5_XY-hb8M=vfK-AsWwk_7YoMK6nCS8xhUKQ+Q@mail.gmail.com>
Subject: Re: reftable: wrong HEAD reflog when its target is updated in the
 same transaction
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> With the files backend, this isn't an issue only because the files
> backend doesn't support atomicity. If it did, we'd have the same bug
> there too ;)

Thanks for looking at this so quickly. You're right, and it shows up
with files already. files commits the updates one by one in the order
they were queued, so the reflog is right only when the branch update
comes before HEAD. With "symref-update HEAD" first, files also records
the old oid, or no entry when the branch is created. I was wrong to say
files gets it right in both cases.

> I wonder if we can move move reflog logic to the generic 'refs.c' layer.

I like that direction. As a first step toward it, I'd like to add a
helper in refs.c that returns the new oid of a ref updated in the same
transaction, and have both backends use it before falling back to
refs_resolve_ref_unsafe(). That fixes both backends whatever the order,
and one test can cover both. Moving the rest of the reflog logic to
refs.c could then come on top of that.

Does that sound reasonable?

Thanks,
Tsukasa

2026=E5=B9=B411=E6=9C=889=E6=97=A5(=E6=9C=88) 7:18 Karthik Nayak <karthik.1=
88@gmail.com>:
>
> =E4=BA=95=E4=B8=8A=E5=8F=B8 <inoue.tsukasa.4@gmail.com> writes:
>
> > Hi,
> >
> > With the reftable backend, if one transaction updates a branch and poin=
ts
> > HEAD at it, the new HEAD reflog entry records the branch's old value. I=
f
> > the branch is created in the same transaction, no HEAD reflog entry is
> > written at all. The files backend records the new value in both cases.
> >
> > To reproduce on current master (fb255012ac):
> >
> >   git init -q --ref-format=3Dreftable repo && cd repo
> >   git commit -q --allow-empty -m one
> >   git commit -q --allow-empty -m two
> >   git branch y HEAD~
> >   printf '%s\n' start "update refs/heads/y $(git rev-parse HEAD)" \
> >           'option no-deref' 'symref-update HEAD refs/heads/y' commit |
> >   git update-ref -m test --stdin >/dev/null
> >   git log -1 --format=3D'%h %s' HEAD
> >   git reflog -1 --format=3D'%h %gs' HEAD
> >
> > HEAD is at "two", but the "test" reflog entry points at "one". With
> > --ref-format=3Dfiles it points at "two".
> >
> > Using "create refs/heads/z <oid>" instead of updating y leaves HEAD's
> > reflog without a new entry.
> >
>
> With the files backend, this isn't an issue only because the files
> backend doesn't support atomicity. If it did, we'd have the same bug
> there too ;)
>
> > I think the cause is write_transaction_table() in
> > refs/reftable-backend.c. For a symref update it gets the new oid for th=
e
> > log record with refs_resolve_ref_unsafe() on new_target, which reads th=
e
> > refs as they were before the transaction. So it sees the old value of y=
,
> > or no y at all, in which case the update is treated as a dangling symre=
f
> > and the reflog entry is skipped.
> >
>
> I haven't looked at the code, but your inference seems to make sense to
> me.
>
> > I ran into this while looking at updating a new branch and HEAD in one
> > transaction for "git switch -c". Would taking the new oid from the
> > target's update in the same transaction, when there is one, be the righ=
t
> > fix? I can try to write a patch.
> >
>
> That would definitely work, but this same bug would exist with any new
> backend that is introduced and supports atomic transactions.
>
> I wonder if we can move move reflog logic to the generic 'refs.c' layer.
> So for a given transaction, 'refs.c' can already parse all the updates
> and also set the reflog values. Then the individual backends would
> simply receive the reflog entry to create and wouldn't have to worry
> about solving inter-transaction conflict resoultion.
>
> But that might be a complex undertaking. I prefer the generic approach,
> but your approach would also definitely fix the issue and would be a
> very welcome fix.
>
> Thanks,
> Karthik
