Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFF345EAD
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622846; cv=pass; b=jbq/kYxYht0qfOf3sdeu8ExrWixqjC9xpeCTnSo/rXs4pYLhFNjN7PSSy9bT9f0Lm1Q7vZ0cpQhYSlS4l7zsGOWpF2hWz9CeVJQAMOlDoV8u0/g3GBncFIK1Oe0V6c2wFIY0pPGHuI8p2TYEGzPsAwWhEfFwv7ObPov1X8vdFrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622846; c=relaxed/simple;
	bh=9dul95jXw5M74Y9US+7IgLIFtgTEL/5vko5z0w71cFE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBEiDo4kSuqGK2ZdOTtUjXIMIhb6lOAKXIfO6jnqQRMBXtJNUGMoP/Y/jG28QqFHmmaJRECgNCjJRXgp0Qh3p3e6fU4Wc6ZBoCN+V+m5z/m0AEeLfuzJ+jSNH3476AS3TqPGE2ZFqgAgAnWotoaXpjDbpHt6QotL7aLUBguQxRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHROgYHl; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHROgYHl"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-74dce749cc5so405062137.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 05:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786622844; cv=none;
        d=google.com; s=arc-20260327;
        b=K2K5D/X4izFgLRWCQpPqZbfaBTlmHkPq1EYTCNzv9GO+DVRlIgRQj2QSlzC3r9LePo
         3BbBaQU4urwuPwziZM7JA5sNY+0gbdTBI2odBFeFYFeX7rqDt8jK1QEmCQnpHqR/69a8
         hwkaaR/2Ya4nRMwixmm2LWSmj+JDZ//TpZ6iVVWoWMsXgMV/o/ZFfuvg4B/pRTRfwoqo
         1OlH6UnRVvMpBZ7hcJpw96J5bLOA/PEBGaGFfkQxsHOL4HjGMQObkadi9AxFnpnJ/n1f
         yF9y7H9cExRPbPd1DcOa6YQYoQUeOjjjl8iFMrI/J4Wit5sM5lQFtymxn8b4yH3hf7Le
         efRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DkIb1L3rKTFm9LVBc+x1DDZU76EYhauAzb+vEDxuTqM=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=HeSCmjbWk5e6Y05Yd+CcC/59pHG5/TkE+k3uPD1L4Qs2azPAp4QYfl94FcKBzVR5w/
         csPSRe+wfqgB1sSlMxjpa85c/0XNSZWtzbXrcafblhrWwTAKP8wk66Gn7yBXE4zjydbp
         dJqbdC2RkUAoZI4CKPV8FmccNDINIACob4oBzSYdX/Yy31CbY/Y7h9hJZU1gskZL+DVr
         XZ41WCW8R8mCNmPPaPjyH+RT5ttlNj/SxkfUcJ0Hr8K4pZ5+6V8qZhAgQ9rb4EzCa5OX
         yG9eDX5U85ltvdGi9ccJta4BGI7o+ZFRbfLz1QaXPPWw4/VjrKjWrbs3ZhdU5e9+CZ0n
         V27Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786622844; x=1787227644; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DkIb1L3rKTFm9LVBc+x1DDZU76EYhauAzb+vEDxuTqM=;
        b=HHROgYHlZTOxvDEu/DoBfo0TxStiCbPvqn81ILsbd4zkR+kKmcTIKSIgT7ZtbS7EgD
         nOCQlkvWYMO2m1Ro34KPlD2JvYVcKZpszcG4R75KEfyPKtiJSgaETYzNdph5zmNrTlZM
         G40KT7uTlR/IUY6p6zXSZ7+Ti8sCGeyJ/S5ubJHPnCW5SkdtacIuPyFIcO6eg8QfsYfg
         ULZ4CMVVE9so/5cAer34qSRpfjefyuhVonY2xhOydeOY7YB3E2xOpfJ35/cRTYYmGPJI
         mXz1yCCa0kLPU1wVWUzh6Yr3M1UwgI7iuYRkbcAC3EI5pVRwSBlZQdRmp2jML2/9oXmb
         3CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786622844; x=1787227644;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DkIb1L3rKTFm9LVBc+x1DDZU76EYhauAzb+vEDxuTqM=;
        b=ML+WCySg+jpSvdPDbgiWHJCC+Wu3cFItdsP3D3Fee7AfB2XfIrAJkRZGJ90Pkl2V9U
         9pOuMUeRyPuc4Y+ORMUX7dbcAspCTBafeTI59IE1U+XQMcPaHkKNY0xbS+EDDJIjRue/
         LitTIrMMsXfPWpLmf7t9O5GEByf7RuAIVtE01GGHP33/3ZDnsqdiuimC0F4Jqa7w4MZw
         u5DyyTLbil04bEq3xVoTtUkUkubxqV1hLDjkqjFBArZU1a91C9bUPm+sL8sJUcmoqacs
         RTV5RBAS1HX8wi+k1oygIJiJrgDHSADZjj0iCBD6rnwU4lhV2ZVMYFzT4C3ak5U3egxT
         aAnA==
X-Gm-Message-State: AOJu0YynzMzaI9hel6fQaitVhmRyhnMf2Lu3t9gdszxlc5TEDa4WGi/D
	SOsaeErlFd/daiomqvJiVPCwMjPwat6m2Tew4COhGVl7oXZ0AcHchd++5MdmCVx3hz/E7n2jqwJ
	Knmy/2WYMIs41DOrdFRQZL8TTaRF4fXLeO7/d
X-Gm-Gg: AR+sD12ODkwdIXGYPveTLr39OCWRZRQKK1PBBgKhpa4tz5HNV1Ukr4Z0rtNcvyhtvFb
	3Albdv1/AcarBnSg9ptMyN5qYC76IKDfouiHyCiPKOBSDsH/7Cj0qyl2/678iWzw9aEBXBHEXmA
	PobmPwZG7F8NJdF3nPA3u2iwiYRsVlsb4/8uNch2nTQJ9dlKS1dpbQiDSG+1g5C+DVYwKqUlwDl
	VP7JaVtAyLUkyrOZqgX2LcL3VbvIxQ7T0+dKpgZCJyX9WTDkMw/NqVI+fIo1KAmHINazYDf112y
	53HveizoD0LbeHO5DZq6nIkSUJNbQvjW6hCwQQS4FwTXCzVHzHJPSaGrUYZiKgyuQPzO0wD1yZg
	xlQ4s3+4BhigptF/M8dGg/Bwt60ugg7bV1XI=
X-Received: by 2002:a05:6102:8090:b0:738:1fcb:f276 with SMTP id
 ada2fe7eead31-76db527e124mr1234109137.1.1786622843724; Thu, 13 Aug 2026
 05:07:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 07:07:23 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 07:07:23 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <anxF0P0KVizediDg@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
 <20260807-pks-t7900-fix-flaky-test-v1-1-08d0ea0fbbc5@pks.im>
 <CAOLa=ZTAV=JqOvE0xkE4zmHMm=xx40_3g42ob9RDBRXmw3u6_g@mail.gmail.com> <anxF0P0KVizediDg@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 07:07:23 -0500
X-Gm-Features: AUfX_mxBvbnLnUUQnmDtadj2uhUQVUsyoU3onpfQktUJIzvqiB_BsQ0_YqchQ2Y
Message-ID: <CAOLa=ZRXoqtYfDYhTatXZt9ojP2_5WrtJY7exR_TEPHZVqEE2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] t7900: adapt some tests to use a throwaway repository
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f2c4b90658ec8b2a"

--000000000000f2c4b90658ec8b2a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 12, 2026 at 01:19:13AM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> > index 4238569b68..6735a9e082 100755
>> > --- a/t/t7900-maintenance.sh
>> > +++ b/t/t7900-maintenance.sh
>> > @@ -67,41 +67,57 @@ test_expect_success 'run [--auto|--quiet] with gc strategy' '
> [snip]
>> >  test_expect_success 'maintenance.auto overrides gc.auto' '
>> > -	test_when_finished "rm -f trace" &&
>> > +	test_when_finished "rm -rf repo" &&
>> > +	git init repo &&
>> > +	(
>> > +		cd repo &&
>> >
>> > -	test_config maintenance.auto false &&
>> > -	test_config gc.auto 1 &&
>> > -	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
>> > -	test_subcommand ! git maintenance run --auto --quiet --detach <trace &&
>> > +		git config set maintenance.auto false &&
>> > +		git config set gc.auto 1 &&
>>
>> So we change from using `test_config` to `git config`, I assume this is
>> because earlier since we used a shared folder, we had to undo any config
>> changes made. Now that's no longer needed. Nit: This is okay, but
>> would've been nicer to call out.
>
> The issue with `test_config` is that it executes `test_when_finished`,
> and that function cannot run in subshells. So we have to use `git config
> set` instead, but because it's a throw-away repository it doesn't
> matter.
>
> Patrick

Right, that slipped my mind entirely.

--000000000000f2c4b90658ec8b2a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d474a6417583a930_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wOXMzZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2JNREFDY3hjeDVNVTA4QlNyTWVUUGVvckpTbGpvdgoyV3Rwc3dCd3dS
WC9kTFh1WkpvU1NIUkJpMlhzakxnZy9JaktXeDhQZGZ6Sno1VkVDTmI1cXdXZTRoWkw4TS9GCnZG
ekt1Zlc5SjBWd2cwTE8wZWJKVXpwM0tzajBUVWJrbS9HM1NmZE9xVkFQRU9xRDNyQUJDaFpWaU1v
Z1c1YWQKa2czdHZlbDNPSHlnd1dpSUF5aStnODc4VGwxTTZNaUVnOEF5VzhxTUFxTUUrMTZxWDNi
clFvcjZ5RFpMeE1BegpSL1FvVVpxMjEzSTFwRGhLVHhFU3lieldvRkNTaE56TW9NTGhQbVhNeXZW
Z0xNV1ZST2o2THBaVDFoeUk3OUtuCjFsSkEvYlRVS0pTblhxSkxkdVNwY2ZoS3k5dVdhdzM5Lzdj
OUcySDJBUFlBTWQrY0hLV2lwUnFBRmF1SzRERXUKVjU1Yk9EZ3d6cUlXempxbWh4WVhDV3FIVWRX
R1BEUjNDZHRkNWR6b3VBK1ZGZk5SWW9QWTlQN05OalFhRWpuNwo0WGRyQ1cwUnhYVjFYY0lXZ1ZQ
SkNUckpScm1JdFR5YTVzN2ZUbTRHUG9jTjlYeGZURjR1V0RMVjNjS0RuYVUrCitNUkJhOWszSXpE
cGJlWC8wL0daa0NCOC9nWTBvU2tsTXNobTR0VT0KPUp1YTQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f2c4b90658ec8b2a--
