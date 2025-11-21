Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A729346E53
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722863; cv=none; b=bEB/5Ly0sW6ZPS1ohzloQwwIC8tYR2+MPjase5OpLF6SW7Fku+L41/8Ndh2f6jC7A/hrYCPA1t4B6C7gHL8DA8iDejvys+6DAiydzEB6DyZudq3/eD5g1bgR4k8RvWsnYLmk5iH67oX8TakEhfsqEUIwhLHB4fFooDckwuVYmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722863; c=relaxed/simple;
	bh=tWYqYOtWyMifCKlpMtfx3IEiZrghPyq6DoYHrnNPn8I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mw4ui7txUs+Vx1MBGBp4z7FIY+7eBqx+rtHG9sEQ20SY6BegoiYSL4YdXhCFYmieuHrXwKzdh/46uJulM6foXju4tHmlzO8/KY5xt2H1uKiuhKtnN6WNOS0QGKgcPGW1a1wOnkDD8NSEFE64uasWzmc8U2tJDmgQIAqn7ro+MCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isqHLtX4; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isqHLtX4"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dfc6be7df3so659046137.0
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 03:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763722860; x=1764327660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywAkOsIYXdvC3Q9Xn7wIVZkdzTZ2oZKXR8YD7VvIW3Y=;
        b=isqHLtX4fnR5C3rWCT9wmcc+ofSeVWNBA4TwjJVJB+GIeTeknWJsVvcESTUUTEXQ7w
         2+iCEfYexuvVg3IHq5y+v5R1v3YZLIMIpG4vvoAMqaKObOjS1QScWnKCUIM1bFVtu3x7
         fNQtwZQR2L8m0UTL3yRouZ4UcXfdayGx8G5FOZ+djPk8JY2uUQXjhoWFwxGSjlhMi+RA
         5Q5KMH9HiG0AbWlgaA1liUit8gWzBZAz7sguqxNP5SOjE2phQ3ltRCPyXX4VrQcTE7sS
         aR8WrsHwCTqzdjinjkCp/xTI09MCfvV9fkPB5eHYHbpGRL47UDFnw/Y3ZUp0t22RDMbj
         NN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763722860; x=1764327660;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywAkOsIYXdvC3Q9Xn7wIVZkdzTZ2oZKXR8YD7VvIW3Y=;
        b=pp9Wj8zS790HG1cfdzkdvxn/XUbnYMFjnRb6TaRcavt8nCP62WU522s3IbuL3bArSY
         2IDnV1KA+sJQFfrCpUxD8GAO4QNJ/yAPjpsHGmntXfeU/7aNIJ78z8qzR6YNkGqtRIPY
         RSWusNfIAqEU55ue7YLEkmdJvDvnbz0saX1NTTi5URC3eD7QUtcSgMvfUmbmSk7csXzf
         KLsnyzX+s7sh7GraAnInOKHLKGJc8TdDUndf0m6gMnksOL6gHj5qMEviuKSoEuL3LALc
         Bd9d8jII4q3WkyI3baxsW5t/P4dU790AFL1Z3tqEXLT/8WqvooZpUxW6z0K2Bo8i1EG2
         +RSw==
X-Gm-Message-State: AOJu0YyS950Mw+gtiwFeAZwCnIWcTZH+22qNVPYbY6zg1i2PEuNjM4ru
	2fm9Y2CPcvMIiy7Hkq9sGtTxzv5V/neFow+c6a08c4zDuqqcp6yJFNrBXS2FMPGptp3fjXIQ+2Y
	dotKLf+vnM11doW2Y1i87p33H0mGaVN5VTg==
X-Gm-Gg: ASbGncu13KcTsdx/vGkLI89nrHytDLHrOznMzbuMOv+/gmW/7yIzo2scK+KueYgHdVx
	NdvO4/Kmj0cZ+fgweX3FQOuOxBK8+Z3n5Ddapl6N4z/TOtrFGY7oPQc24S1GXrAOwxCKtc6Hojy
	d5lANXrGQVivo7SZk33c0Z/sRKl06AZNVW7q1ZSX4JQYBcfq3C+8hvofAGIUtN7eG2NdrHyYuVg
	2PozNtK+SFxEUAIfTPFqIPjuJ2WIXSnxAN9MssPzvsaVr7m/0Y41w9kx3R6bEoOdgvaEC+3omjh
	3OsMJgV+RkBEgmtGspUNOO1o2D5F3w==
X-Google-Smtp-Source: AGHT+IE1I6Q91dsfY7HSBdeSDKxJLlI6HqNzg+1mk1HKWW7R2HGnSIRNjTrih87RhNUhOQTWMNh1+Wx4JiZSyAEeya8=
X-Received: by 2002:a05:6102:442a:b0:5db:cc25:dd7e with SMTP id
 ada2fe7eead31-5e1de3a6ddcmr381093137.34.1763722859756; Fri, 21 Nov 2025
 03:00:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Nov 2025 11:00:58 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Nov 2025 11:00:58 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6oxaae6.fsf@gitster.g>
References: <20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com>
 <20251119-fix-tags-not-fetching-v7-3-0c8f9fb1f287@gmail.com>
 <CAPig+cRjN85S3oCvazAvUD_V0EwkzdvKAm+DC66+uVijF5=HQA@mail.gmail.com> <xmqqo6oxaae6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Nov 2025 11:00:58 +0000
X-Gm-Features: AWmQ_bn0BMtjrHE-f_U0GLqlEUPL1HQ9_tY2mtkaYdAQkyVza574wMq0iI-O2So
Message-ID: <CAOLa=ZSQZhXEVGXzwg1bWd7En+vz8dzYHZTM+8AvW8UnDk-Fag@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] fetch: fix failed batched updates skipping operations
To: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000089deed064418ba0b"

--00000000000089deed064418ba0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Wed, Nov 19, 2025 at 4:47=E2=80=AFPM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>>> Fix a regression introduced with batched updates in 0e358de64a (fetch:
>>> use batched reference updates, 2025-05-19) when fetching references. In
>>> the `do_fetch()` function, we jump to cleanup if committing the
>>> transaction fails, regardless of whether using batched or atomic
>>> updates. This skips three subsequent operations:
>>> [...]
>>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>> ---
>>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>>> @@ -1639,6 +1639,93 @@ test_expect_success "backfill tags when providin=
g a refspec" '
>>> +test_expect_success REFFILES "FETCH_HEAD is updated even if ref update=
s fail" '
>>> +       test_when_finished rm -rf base repo &&
>>> + [...]
>>> +       git init --bare repo &&
>>> +       (
>>> +               cd repo &&
>>> +               ! test -f FETCH_HEAD &&
>>
>> Is this supposed to be asserting that the file does not exist or that
>> the path is not a file? If the former, then test_path_is_missing()
>> would be a better choice.
>
> Thanks for carefully reading.  Personally, I think this is not
> needed, as we have just created a new repository.  It might be
> even better to replace it with
>
> 		rm -f FETCH_HEAD &&
>
> to clarify that we do want to see this _created_ with a failing "git
> fetch", not merely left behind.
>

That's fair.

>>
>>> +               git remote add origin ../base &&
>>> +               >refs/heads/foo.lock &&
>>> +               test_must_fail git fetch -f origin "refs/heads/*:refs/h=
eads/*" 2>err &&
>>> +               test_grep "error: fetching ref refs/heads/foo failed: r=
eference already exists" err &&
>>> +               test -f FETCH_HEAD
>
> More importantly, should we inspect the contents of this file to see
> what gets recorded.  If we are fetching foo and bar, and we made foo
> fail, do we expect foo and bar in the file?  Or do we expect only bar
> in the file?  Something else?

I would say we should. Let me send in a version with these changes.

Thanks,
Karthik

--00000000000089deed064418ba0b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aea779a1f56877cf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rZ1Jta1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEZlQy80dmlGN3JQTkYyMFZOUGR3ODk3LzFROU02awpVTjZodmdlNVd6
N0czK1ZiT0NOU2F4RlQyL1RBNk5rTWxXUEE1VFlRT2NtM1MrenppQzNQcmE5YUgxajFpdHJaCkVZ
c3dVTkN4R09iNXpCRFhtS3BDQmJYOGEyMVFsYVVlZlZTdE15QlQ0WUp0TDRSU1cwR3hmdk9YRUJh
b3BjREMKSU5sWmdndy8zSUVoV1NteXJRNjJCRFA2b2NFNGRjWEtYRmg0aFlzdC9oc3EwZ09hK1hP
eFhiN05xQzJSZGhmdgp6a3N2TTR3aGFtYnBtMkJZcmtzUXg2NldQanFMb0VuQ214TUJ1ZGNyU1VH
aTVQUk1SV3BOTHNvMTd1eGF0RXVlCldKRUlXYXVhYkljdCtTVFZleW1POFVreGxnbmw4d2xqZnhV
REh3TkdSN1hXUzhyN0VmSVlBT3dpM2pJR3o4b0IKK0w5TUxhc0l2V0F0UTM3dDNXY1Q4eEpaSkdq
QmV0cGZaZUR4VWwrdU9KR2h3RTZ3akJzb21jUXZROXpBbWVJVApjSU1NYlJPZGZKOVpJZDNzVmZS
akVuZndwdGlEVU5PMGNudFJHTnhqaVlBQ0YxbXVZQUxDWVBoSEVralk1bjl0Cnp2RzduaGE3L0Uv
TkhXVmVwRGtnb0R5Mjh2QURIb3dCWmhVRUovYz0KPWZ6eFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000089deed064418ba0b--
