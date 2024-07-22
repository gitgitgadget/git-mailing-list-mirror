Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803C219FF
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632931; cv=none; b=nHyVVosPI7bkaJ9SfoYuse7V0Ac7A8uqdFABx8Dqeakj/kmgE3Jq7KdVS1KYucTAU1fCSM0RM7ZjUgfEH8Lgg9z4Jn2aWnMoMQQ9+xLSA5G11iEn02lcYivRrpEJt/o07jBNVBGC3l8aOrF1ODtbdnyvJeGDjtJhLfK4F626HVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632931; c=relaxed/simple;
	bh=kL4W46pLOgtwz/Kxb/cDNaKOQof+WjBW0L/+ETK1SLc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgjDATGFmdO9XelF47nN5qmZEKiFSlMCKHGUvC3fsuR7x9sbvxcl9LDdduOHv/pC2hlf5jZfbMnWKdNhDVcBO5eDfa27ft/kxltSyUhMi1oU1FgU/Yk2wLvWEtxxawCtml9gnxvP7p7XGDCaFxvQFNIp8+bRuay2gWVV+JQhX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aye4ppeq; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aye4ppeq"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260f1664fdfso1752055fac.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721632929; x=1722237729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeNR+1WzR9nP2flACDBA0Q55ePmha6vA65lGlYgeUOw=;
        b=Aye4ppeqrZqJUpYeRlBfQXUAh2HGuxC5ETFviH5OYeWMytSLeKE4iA0vSafTaja3A1
         b7qAeWDhnjDfJGmKnzBr9iMLTdwdPuCpnTiNR1ozBuib2AVIazAC58dSRbiP8zDvSpLl
         /fT1pyhfb0dPH8j+I0HUFQtHHGJC91PqObSKGKivkwpiKDSIpEzjjJt62IPQwbYWNa2X
         BHarkkWx0bYoWsgcTmP7OnpLeCbrjJ+moNqt40UfTbTY97Hnwn/ur75kwQyUCVxGADin
         2fIyI9u4p0RWuKC0sr78obYshceCB0MIIIRPKIur1Bdd3gE9Ab9pkf4jTQCURmXNXeDd
         BryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721632929; x=1722237729;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeNR+1WzR9nP2flACDBA0Q55ePmha6vA65lGlYgeUOw=;
        b=JjTPSYbLOQSotghsty9bGdE16rfl3G5Yp3A4bpYmcQc9PQtgLz7t1psjjJJPv3YSca
         zCR+cPqrYk9SnRJDBZPlVJ9iDkfZDKfx7yADZJmhATOd2MrFUW7oKbRIG18m5hTBsKQP
         Eogfk5kVHZayNx97bfzUWCNZIfmQ/KNtUmOnMgmmV6A3EqZe2KdKQKsKCfN+w1P+sT9d
         Neu664A1nmUKiLN8n74V11Jae9m22tsHGzY4dgv+IzzISesZyuC1R0um2zzvJCq5NEl6
         5mZCwISnM27q/6fttH4HDTLcyl5dn/zeARXitVIModcvyGRy0FP0qKYdG+qABxXH9gyn
         3wYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5b9nlqcdYt9RuRmyoDroazCN4HdR7rFtvZfJfBawCgG9F/rwW4fswQEFd85u7zM6UevZwxP09PGYMg4FEw0EXTkUL
X-Gm-Message-State: AOJu0YxWkmILPq6XaktUel+QPBtNls5gGywNCEceLQgy7wTXMDwZUuHB
	/CIRU/A7Qw1qvKznH2FgyTP77AtMXUiV21fgctW1Ft0dysD6OlzwprUA1dU40tGnp1aYzQjDCjH
	kH34J1YLhRkYThuRuJc0aJdFBTwU=
X-Google-Smtp-Source: AGHT+IFmkT2Xb9JaLUnLhgyss+kgJMnawZcavtsfDiyC7YbdwGKSC70FuU9305QwBz2RFLyWurTJu0a3UZYW4yuNwMk=
X-Received: by 2002:a05:6870:350f:b0:260:f244:a0ce with SMTP id
 586e51a60fabf-26384722691mr3443339fac.0.1721632928946; Mon, 22 Jul 2024
 00:22:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jul 2024 00:22:08 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbk2tl8zc.fsf@gitster.g>
References: <20240715093047.49321-1-karthik.188@gmail.com> <20240718081605.452366-1-karthik.188@gmail.com>
 <20240718081605.452366-6-karthik.188@gmail.com> <xmqqfrs6ycc3.fsf@gitster.g>
 <CAOLa=ZQhcb7O4i9E=Xn+9ZbaNhiY0gzD_a2kTqriegF2o-Eeyw@mail.gmail.com> <xmqqbk2tl8zc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jul 2024 00:22:08 -0700
Message-ID: <CAOLa=ZQmLFrvZOkysRuGO6=7ZEf3O7c9m1=iaTdRP_uMtHXrug@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] check-whitespace: detect if no base_commit is provided
To: Junio C Hamano <gitster@pobox.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="00000000000029f928061dd0e7a7"

--00000000000029f928061dd0e7a7
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Thanks Junio for explaining with examples, really nice of you! I'm on
>> the fence with this, even the existing change from the previous more
>> verbose code. I know this is shorter, but it is always more readable to
>> use the longer version with 'test'. I find it hard to remember the
>> specifics.
>
> You'd never remember unless you practice, but it boils down to one
> question: is it reasonable to expect that most developers who need
> to touch this code find it worth to learn to read and write shell
> scripts well in this day and age?  The answer is probably no.
>
> As you may remember, this R=${A-${B?}} dance started at
>
>   https://lore.kernel.org/git/xmqqwmlpb8er.fsf@gitster.g/
>
> where I said:
>
>     ...
>     in a separate "after the dust settles" clean-up #leftoverbits topic.
>
>     We could replace the first 7 lines with a single-liner
>
>        R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
>
>     if we wanted to, but all of that will be mere clean-up changes.
>
> Even the longhand to set a single R with if/elif cascade so that we
> can have a single location that invokes ci/run-style-check.sh was
> considered extra clean-up for #leftoverbits at least by me.
>
> But after seeing you used the ${A-${B?}} dance, which is more
> advanced than the #leftoverbits clean-up, I thought you were
> interested in using such a construct that pursues parameter
> expansion mastery, and that was the primary reason why the
> demonstration in the message you are responding to was added.
>
> I personally do not care too deeply which one to use wrt the
> readability, but
>
> 	R=${A-${B?}}
> 	if test -z "$R"
> 	then
> 		error
> 	fi
>
> looks strange and inconsistent by spreading the error check to two
> places.  The code would be better off if it were
>
> 	R=${A-$B}
> 	if test -z "$R"
> 	then
> 		error
> 	fi
>
> (or with R=${A:-$B}) instead.  Then it makes it clear that the
> author wanted to take care of the error case with the if part.

Yeah fair enough, we are deep into it and might and makes sense to make
it more consistent. I'll incorporate your suggestion and send in a new
version.

--00000000000029f928061dd0e7a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f8a9dd76f6b80605_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hZUNKMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWJkQy8wZE50bUY2TFdLaWZuTUVVdzRoT1oyY01uRwpPU0R2VWkxM3BG
SWZLMzlBbkRBZXRSdUZvYSs4dGlUVDJ4dG5ZOUlqN2tmcUZVSlpRdFVXVUQ5MXBoZWVSY2M1ClZL
UFM5SkNLK29zNG11OE03YUJJUHVOVi9FR2l6Sm1Wb1Jha3JuSThzcEswbXd5Zk1rVm9FaVg0TW5t
dURSenQKWkhTUlhsVkYyUll6Q2lHRGQ2TnVKL0Y2TFFWaU1aQjV5elpzbm9jcnRzRDRuRVYrbTlh
TkhDcWkvNzd3WjkyMAoxcHFGMEpFOFlTVTdockVob2tzYTFsSFRNdnFXM2cvM2R3eXpZZ0s5dDlC
ZUV2ZXZYTjJqbm1IT1h4K1ZMOHdTCitLTk41QVlZWVo0RXZEWFl2dlVpclZaZHZUMzVTT0t0N2Fr
UjBMd2ZKbGxkNEVXaEpRRnlDMDNsbU5NU2doUEgKVisxbjg4YjdzTlpDaUlqOHluMVpKN25FVDdP
RE5xQ3RHYXN4dWFOdzEydFYyTUdHRkZQQWNJMUxnaUtYQmhiawo5YnZKbXo4UFVodG9FMVJSUnEw
dEhidWxuQUd4UEhvVk8xLzNzeE1RWkE2V2Y3YVQ3RERoSSt5bHV0YWl3dUJmCllCYWc4eXNYZ1l1
SW92YjV3dzJSbCsrR3NaS1dKcUdSejV1aFJ6UT0KPW5NVUoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000029f928061dd0e7a7--
