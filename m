Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264920C46B
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630514; cv=none; b=gOVeJv8oNu2HF+I8rw0nxGCFllP1xVraAPzEm+QdbdCuk6oJvaMeLOFa5uzuGv2XlD/B9N/EggN438NnczPjjVC7mSB/wFR/dd9mBvlPFmbOJFWjwkiDlC/bLc4vPne/32oBhT5jackjclmFBPvbA0C48pkAWjI8jQZ3pWnuvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630514; c=relaxed/simple;
	bh=m4y4Kd4adzEgWs441foeCPIXf0Px3Hqjdsr1AA1OBEk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ei8wWwHMM1+eXjOp6d7Nv8EtvGjA+AbdTDx8u70dmrh1N28ahYeuFnrZ7PoZxESYVaiG5sp3/9sG6D71OEpDtt7TMRyQIEIECVhW68/Lgd62owypZz4WqPh6psuIOipvyUJktOiGErY3syVG0bAsBejEp2bSAsgoGuGBhH8ltnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcEdFS7N; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcEdFS7N"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8641c7574a5so213150241.1
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 03:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737630511; x=1738235311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wBf+fHH1zysWGp+yViK9p+ztWj0iOJJrItV/F9LT5U=;
        b=WcEdFS7NsCzkup/ydfm+86GfnvnE+uuIhoJHLZMcn3gwqsyckDvuUfa1iXqTaKNpVv
         TZOoXmQChFhxEsAUljzEfDdGjKV+KHozCWEmpLD5jJ4/gpbV7o6EVsG18zSC0KqtkQ2x
         E4/Ce16TngTAepUHiJORZFfxZtL8OJr6y1383l4JRQpsmi6Oe1zvcsxThXQ6QVXtcOta
         njNapMxfUUs+ipOdHjckWWj9hUccNMUUFej/JTi4GLnYY42EiNE7c8QxCGw/jRgApg/n
         vRu0P089bZaxv3HspopOTjrk9DTcc/89jCFDG/LbCcf+prMuAIXiUPbKotNDYEsiYZnb
         TGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737630511; x=1738235311;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wBf+fHH1zysWGp+yViK9p+ztWj0iOJJrItV/F9LT5U=;
        b=KG+tXDLHSkjVprrkWaOR1p6ji67qXPDhm5nXqF/qFsOo+R+h69y2j549ltxCM+h0N2
         7l754wMrvTePOPSUaAt0/D8Nw65pgt4gUCSnDFCq9RKdf2VtYemcT3e/WsHUXPlxhSJR
         ODn8kHY6t4HBYDpYf4cqL8+COk1+1jtOoMhJDIV1GpHGBViV8/YICgPsSvjQ738Z7a0r
         UHHpEAVSvMbu/a8+bltoJglvLD3ijDamKbP5FJx+wtbw5Y/jXRizZaQXWlyTr9KTp5oW
         DI34PbDdXhCh9mZqD3KfMYPDPy3qXJuUQbPdhmhd/MYHzOEyLRWOVmrKTwIZhTnnc4Jl
         1Jxw==
X-Gm-Message-State: AOJu0Yx/APyziPd02Mj3AeZBlS5d6FFpe1OtrRtXlwEgGrxUKVAU5BBZ
	DDtAoywkqsG02lTaYec5lvgyen1ellj4SD51mVMSsb2KN+ckWfvQamIPg2uZs2C04CpTQmCHaZn
	LovTLUKofsRBKT1yl0LI4Z3zh2qY=
X-Gm-Gg: ASbGnctL/Cjyg+uoipxLFEE0J+JmKxBi8cHv6Y8cNYvWvEXiDKy1j7BzG50ZWpAi8TF
	Go8Y2pU4K7fEsvdkTrj3MGDLsG4oAhOTGXoTxqbHc3rQ1IZQ/HWyyrfsEd02rLYY=
X-Google-Smtp-Source: AGHT+IGdTPkR5vL+nKTXzC8RlekvoksPKwSxdBmZC5iT82hMYiDyfu4Ob0tPAXrjUJvQI012RKdfBp/r2qH/A1okKyo=
X-Received: by 2002:a05:6102:304b:b0:4af:98c6:bc97 with SMTP id
 ada2fe7eead31-4b690cde005mr19438308137.19.1737630511286; Thu, 23 Jan 2025
 03:08:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jan 2025 03:08:30 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250122150222.GA3348514@coredump.intra.peff.net>
References: <20250121215235.GA2753621@coredump.intra.peff.net>
 <20250122100319.2280647-1-karthik.188@gmail.com> <20250122150222.GA3348514@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Jan 2025 03:08:30 -0800
X-Gm-Features: AWEUYZlZM8wa0kpE9W_nFstd2J4ovuzu0eYW1JIMRf-Cwo8TSX46jzhDFo8R1wg
Message-ID: <CAOLa=ZQMhhznFj=QdTgq=ydiPVzFO7YsEzk4VZ7fwn-ZZ=W=bQ@mail.gmail.com>
Subject: Re: [PATCH] refs: fix creation of corrupted reflogs for symrefs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, nika@thelayzells.com, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000060704a062c5da1b9"

--00000000000060704a062c5da1b9
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Wed, Jan 22, 2025 at 11:03:19AM +0100, Karthik Nayak wrote:
>
>> The commit 297c09eabb (refs: allow multiple reflog entries for the same
>> refname, 2024-12-16) added logic for reflogs to exit early in
>> `lock_ref_for_update()` after obtaining the required lock. This was
>> added as a performance optimization as it was assumed that no further
>> processing was required for reflog only updates. However this was
>> incorrect since for a symref's reflog entry, the update needs to be
>> populated with the old_oid value. This is done right after the early
>> exit.
>>
>> This caused a bug in Git 2.48 where target references of symrefs being
>> updated would create a corrupted reflog entry for the symref since the
>> old_oid is not populated. Undo the skip in logic to fix this issue and
>> also add a test to ensure that such an issue doesn't arise in the
>> future.
>>
>> The early exit was added as a performance optimization for reflog-only
>> updates, but this accidentally broke symref reflog handling. Remove the
>> optimization since it wasn't essential to the original changes.
>
> Thanks for the explanation.
>
>> Reported-by: Nika Layzell <nika@thelayzells.com>
>> Co-authored-by: Jeff King <peff@peff.net>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
> I don't know if we need my s-o-b to delete a few lines of code, but just
> in case:
>
>   Signed-off-by: Jeff King <peff@peff.net>
>

I was looking at the docs and it doesn't specify if I should apply this
myself. I will go ahead and apply it for the next version, but it is
worthwhile to add to our documentation.

>> +test_expect_success 'update-ref should also create reflog for HEAD' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		test_commit A &&
>> +		test_commit B &&
>> +		git rev-parse HEAD >>expect &&
>
> Using ">>" here is unexpected. It's OK because we are in a new repo (so
> there is no leftover "expect" file from a previous test) but probably
> better to stick to ">" unless we really need to append.
>

Yeah, I agree, this should be `>`

> Plus I don't think there is really any need for a new repo. The
> important thing is just updating the branch via update-ref (it doesn't
> even have to be a rewind, but of course it has to exist already, so a
> rewind is the simplest thing).
>

I agree there is no need for new repo, but the way our tests are written
there is often a lot of context leak between them. This isolates that
behavior.

>> +		git update-ref --create-reflog refs/heads/main HEAD~ &&
>
> I agree with Patrick that we are probably better off just getting the
> branch name with symbolic-ref.
>
> So all together, something like:
>
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index e2316f1dd4..29045aad43 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -2068,4 +2068,13 @@ do
>
>  done
>
> +test_expect_success 'update-ref should also create reflog for HEAD' '
> +	test_commit to-rewind &&
> +	git rev-parse HEAD >expect &&
> +	head=$(git symbolic-ref HEAD) &&
> +	git update-ref --create-reflog "$head" HEAD~ &&
> +	git rev-parse HEAD@{1} >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
>

Thanks Peff! I'll add it in! It's now completely your patch :)

> -Peff

--00000000000060704a062c5da1b9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 32ed5936b4bd79fd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lU0l5d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1MrREFDZkVIc0V2RTl0UVRUSEtrUk55UFVHZXZXdwo4VVY2UXdKaXYv
dDdrYXRIcnFoOEFTUXA0TU1GZWFLM25UNjhpRFd0RVBzVUxQSzJJdlgvTzFQbXdQNjJnL2FnCnF4
ZGI4S3A4S0Nqb0Ezak1IS0NJMk9iOHcvL1JISGt5bHBqMnBQaithcDIrbGNmQkZpWkFQMzMwdC8r
Z2Z5ejkKVC9EQzRES3ZtMjJyckpBQ0JaQkFZWnZ1bHltUDZ6ZDJtTWlJS2cxQXZXY2hzcE83TGdY
dlhTb0VQZzU3NlpCSwpRMXdRVjN0TVdJWmU3SURWRmlIcFZMRnNKSmk5WFI5ZjRCZkZtcDA3djQ5
U0M4cGVYN1lINkNwU2lPcWVLT0dxClROUGE3aWh5cG1XMmppbjZUREZCTjdaUEUzSHI1eVRsbkhl
QWhVVnNWdml6ZytrRzBtZFZQRjFTelh5Wm9XeUEKR2diSVlKcUZlcTUwKy8xM0RmSUR2TnAyZzFJ
TkxEWkEzRUg0bmVFNi9GSTMySlRmd2NXZ3NwTXo2ejBaN29VVwpYMitPcDliVUhWdkVOYzlrelV4
ZnBFUGIrUHFqUVZBSjIrcEFWSzR2QmRpbWdhVDdacjhIS2ljeHhjbW14TXpyCnBYVTNqNWlRdUZN
UDMxb3pBUlNYZ0V5ZjNFWDdwaEVhYjNlNEExaz0KPXJMK00KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000060704a062c5da1b9--
