Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757018C1F
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246711; cv=pass; b=UlQ/RjsDMU4imnMnqJUjuyslefhDbbS+RSAJc9HB7/nLO36CLGVXH8aM52g1Ggzh3SvdBxMjS3jqPvGb7lyLFhpxa5EmsDBsaYGy7fe8BfNpp0p/uihMt4hrBFBM0QaxGuoe0U44iUClBtVnWG6NH8jxo6OvqJVEll2BdzWSeQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246711; c=relaxed/simple;
	bh=4WNoqqCunNJ66gjvE6SF1TEiq8HdxHFVnvRDWYTRcNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCMXDWGQbYF0mgx33kJxEBXkJjznLCVA/0G/ash7VH5MqADuJC8rvxjjf19tGcYiMG6KAq/b4oKY0i6YwP/x70gm7EDovOdLxNGR2WDOPIUYCoPM5/VbxcBSiFcwuSiRYvtjggxhoORG/1Kre5w4ODEuRYPquAl01FV+7bT5KUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeaVz4v8; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeaVz4v8"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-823c56765fdso1963505b3a.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 23:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774246710; cv=none;
        d=google.com; s=arc-20240605;
        b=J44T4SmbJh+MTFHh6jctveB60HxGYwPF6xlB6CjlKa3LScYK0Qa6t6UI2SdSogjLtM
         2N18csxqzE3a43sr1fs0jKeWcgn8Lra1t27W94C3T93QErq/bu7s/yIeJzhh+pfNZFfe
         6QGJr2Yjl0BzbyreDO1WNP7uw4UW4NiBW1xvbSMwqbnj77wIL/0/pxt7DTPCwVzM5w1n
         puaAK1DQeaP7eGW8NLmFmkOg1jDT5ysekxqJDexAXMVPS4j1K7tDYZHypHAN3FT8Mp1T
         BqWxi1v8opikYmuitPtFmoN0Uydt3K0jh9KvLDbp+/qXfzZGKzrzeMfYKpYOs9j0xrjd
         7Cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UO3XIHcmmjQ0zV1naCsZ36TuYhMYUvYIozyPdv5Nv0o=;
        fh=4H858SncsAVFwdeyLImunhEcRVqA+VHAsbCo+ehCmnI=;
        b=Grko1CrgEhh1lUqGAKwVzuiAAmnfkoUOd70D0thpd60YQje1VzGlzzO6P0q58Ik2uQ
         TNx3zLBQwTKNtdJwLBdCU4paut3vdAFxH+ZjSOknI7Ne1gPvQaBtEmKwM2uKxhvEHpuC
         IgTxWHxhqKSaLcFJn6OZXKIHoBJRnzlxB6t6GDdKbo/exaaypKV9IT4vfmS+0d+H4LEA
         nMrR3XBdjE5guTYzr2U5giawRp4Wnvr8h2RCDtxmMTxV5ETxkoBUezzXSrQo/GOALwx5
         2L1tyjPeLj8qkBp+Z3l5+oDodOnN2osRDJvBvV8UD4/bIEhKpnUqaFPU5IA1Xlm27CJj
         TQ/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774246710; x=1774851510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UO3XIHcmmjQ0zV1naCsZ36TuYhMYUvYIozyPdv5Nv0o=;
        b=MeaVz4v8+cazORDAITrrG60H1QUDIbEpB+Y24QoBy0Dfrfpklan9LHScHLbv4+DwF0
         lY5YIbQ7xctLCXZdnNb6XLBqIaGxuOPgWTCxBv0E62yntASrZHYnFwxk55P/MQK1p2ui
         UncVeFXadCXm7DMEBMaOJOir4CPo6+atzWeYIhTVpjV5vmZqT6MxP88g/HBL6xJHbVNn
         zH/LllW3JtgUKGAhx98osDyigTgggGYWtxGvHDCIUdUURIYI4Jt4bWM+aIwGUhT9jYSt
         tPZX/SLTySEa9g9aFfsUh85RS3h0PfXixCQmc6kH7axdEjU7ZobKzxe/6+6X9tUUOFLQ
         Q0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774246710; x=1774851510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO3XIHcmmjQ0zV1naCsZ36TuYhMYUvYIozyPdv5Nv0o=;
        b=OUwW4V1lfm3PNHswueIfRV8N4EHgKYPfL+OsTROW8ncXz/Ot9WlNPcpNlMCHfZw0+d
         5uN/tYMpj5Og2EjLEYPRT9jjzEYIBPRMKB/zPh3ECIzI7xIvzjD7x63z/Pm++NrNTZnQ
         iKsVNwni1B+tiN7PmGcuSosevXsXYfbCWhXuaTyMRsG8UbZ61ysSa0+b74gbsJdpu9CQ
         VB2Zu7Vqk0aX+s7s8Potg+qmNvUIgyZ6fuXSLniQn+cd0FhaLia9/Ds6u8K/9Ov/oou6
         9NrDNHt98mBG6wi5LaMJ6xWxeDZ5I+81QsXIFoR/C41Ivy6sqIaw5H18Z1MgMY9kvpf7
         592w==
X-Gm-Message-State: AOJu0YzCDInblDUrTQkpxwmHsn//YFz5SOTgBaFYWeWfjFATC2E1IFuo
	DyTs/3D213Emf5WQQMKGrGy920yhSLZJ/CXXGCJdULdlHRljHz9AKaW7fyUig0VDvp7BYMbFAJz
	i/xroTtKmzlZ8ptGk8cvHjTdkhhDyRjueGf2j2TGMuw==
X-Gm-Gg: ATEYQzyl07p5w5v0UXOnyF6HLasNwQLYQS5LVKGawWiP5aZR8sQ9kirq4wfZZEkZwgp
	U/jr0mEcVCW2A6jDeBTGJyrN30lKVeEYC6jZYeWFaQvd6A8cx9/smjAZxxbebePkGJaUMNgcfOw
	D2KaHviFqmj/UsO3W4ozY5rcM3LGxSk4a/cguQoWKrqPXYUM9UlksX8tGCYnZanfYrbSRLQnROP
	3jQxeORTRMVMammTPCJHDBrZg2SbgX+suSVX79N+XFwwG5lpKmkuX7ETk4v4obrCQ3aQRyd8qez
	wU0jDIOvgvZ28GG08NLGx5iCVp/r5KpoR5whoTFPMBQ1aUlvNj9r4pKjASkm5zr87dhS/jJeh05
	ONOiJjKrWgc1CrT1M1ZC1WFYKbHRt8SwGCfvZbQ==
X-Received: by 2002:aa7:9062:0:b0:781:2291:1045 with SMTP id
 d2e1a72fcca58-82a8c248194mr8245506b3a.8.1774246709562; Sun, 22 Mar 2026
 23:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqfr5sacps.fsf@gitster.g> <20260322053207.60992-1-r.siddharth.shrimali@gmail.com>
 <d8e6f854-e838-439f-bc5a-27cbb4091e4f@gmail.com> <xmqqa4vz7400.fsf@gitster.g> <6460601f-ff72-4683-abd1-2ae4c8352a27@gmail.com>
In-Reply-To: <6460601f-ff72-4683-abd1-2ae4c8352a27@gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Mon, 23 Mar 2026 11:47:52 +0530
X-Gm-Features: AQROBzDQQWII_Zf_Xb-jq1a47swY4wtwtvvrrAg9AnrQlUS7GyJQP3F_sAreIH8
Message-ID: <CAGWgyh8E-=A+NKEAOz3xHPq96rf3j0tt7++3xvg7NoMCKq_Www@mail.gmail.com>
Subject: Re: [PATCH v3] backfill: handle unexpected arguments
To: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Mar 2026 at 07:12, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/22/26 9:01 PM, Junio C Hamano wrote:
> > Derrick Stolee <stolee@gmail.com> writes:
> >
> >>> +   if (argc) {
> >>> +           error(_("unknown argument '%s'"), argv[0]);
> >>> +           usage(builtin_backfill_usage[0]);
> >>> +   }
> >>
> >> Before we get too far into this: How does this interact with
> >> the ongoing change to introduce revision arguments to 'git
> >> backfill' [1]?
> >
> > Ahh, that one completely slipped my mind.
> >
> > Thanks for a doze of sanity.  This patch becomes completely
> > irrelevant if we are taking command line arguments.
> >
> > It will become the responsibility of the other topic to detect and
> > complain about excess command line parameters (unless the feature it
> > adds absorbs all of them, which may be the case).
>

Thank you for pointing this out, and apologies for missing the in-flight series.
I agree that this patch becomes irrelevant given the revision arguments work,
and it should be dropped.

> At the end of my series, the error output for an unknown argument now
> looks like this:
>
>    fatal: ambiguous argument 'unexpected-arg': unknown revision or
>    path not in the working tree.
>
That makes sense. Since backfill will now be passing arguments down to
the revision walking machinery, falling back to the standard revision parsing
error is exactly the right behavior.

> I'm not sure it's worth updating this,

I will drop this patch so it does not get in the way of your work.

> but I can incorporate a test
> that shows that this is handled.
>
> Thanks,
> -Stolee

Regarding the test, I think it would be worth adding one to your series to
explicitly verify the behavior for unexpected arguments, since the error message
from the revision walk machinery is less obvious to users than a direct
"unknown argument" message. But I will leave that decision to you.


Thanks also to Phillip Wood for the test_grep suggestion, and to Junio for the
guidance throughout this thread.

Thanks,
Siddharth
