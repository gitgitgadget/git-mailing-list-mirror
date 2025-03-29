Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736D175D53
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743243978; cv=none; b=Z4eBdPoYzLTAPg2NhLuXMO+ydCJDRCVQWkyTlwDJkXFwSMoNDiKXa6YwFK28yc7cjMNJ7+waWCuM6c7qdbinmcO9tAhPQw1Cvw6uROjIAzCXxmhUDR2mE+EMiQ8E7CLzcgd5L9haj5vA+w9w1cZWlywYxnmfnswBg8eLQj2w1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743243978; c=relaxed/simple;
	bh=sm43H1iCHEvj96CEku59Qq4JyDRVJbxgyeyigyMZYJo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRgkkhF32cpYa4klmQ5eh/RdphkLFsPPPjeVea6aAB9cktV/+85qVHIa7nuI73SiJhGKA3tvWd8yU4Aa7C/1T8K6fvByw6H2f28cDJZtOLRY+2j2t0FK9rqRKxniga0UY4bgLoKJqbQ2/bm3wUg0h+r2fxu73v16MTC9YvhB7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ6FFiCc; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ6FFiCc"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d3907524cso1293523241.0
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743243976; x=1743848776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEfxLqLRoHmMp1DDSjUS1Kf8KDjzDolpu8PuGDRlrsc=;
        b=QQ6FFiCcaL2CATWI1t3RwhOzPKEyTp4ejANgEwmZiRcZF2olN6HHcHsAjMoUjyPZoS
         T4Zi9XACbmyEQMjtg44rY+Vq5tYK9lPbdXpr7F05j4RUEQ3vMVgZg4bInbUCzfEvRTB3
         Ru+uBrp3GnohIBwMbPCVRrk5IDMpDukz/CH26ZFz6LQObB7cVmNFaK+jZ8lRJJ98VOeY
         /A4P/oXXDHAkvZBaDUAZLHysaDh5ebdKz13iuQsu/re1aOACnr4FIG4bOSv5hjA0R0p4
         fQQ6b/U7IHnxR4X7jPsavWQgbTJhtqsOjVCRJN4r1v/xWIw9feraV0NZxXluI2ROoghG
         93hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743243976; x=1743848776;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEfxLqLRoHmMp1DDSjUS1Kf8KDjzDolpu8PuGDRlrsc=;
        b=LX3UxN9BrxTStdZv5ElQvMccO90xaIBESWcOMIXvoB8lQExTfKvtfl4Oc4KKB+ECFg
         jwUibUfW+yJ6WtY79DE00rFBx3DNxzxW4R//6+i5i0WqG/YAAhYE3Z3NS+ymRuj2h2TL
         dGJm38ecr5rUAuTUsUCBzUF9tOvBjNAEaoXzM+jeCn9mDE4MZEQBPYqsB6EucTdPbNYN
         AF/1GnaxKm9v/LJMkYT7JvHdI6weIeqr0LjUJgrJwTL/IMvrADj82MzwakaKgd7hgVGQ
         wTs1oKBnLGdg449C1uUeZ6Do3FsaalZI5GaOuzxG3+NjomQCCy7uK/bBdlRbIvW6ssnW
         tJtA==
X-Gm-Message-State: AOJu0YwlWBeR5amWiCuMDAfr04R3DbnnYqoA6uwMIN3rp8LYfKDlDq1o
	CPsaeDrdw62FAckw2Jkg9vY+r4HUKtPTbapXaEPJUYt5XkcAWUpDuNfBsmsdsDcmzquj/X6Pk1o
	/5RaoE64FeSNLf1vZo6YK2GEQJBg=
X-Gm-Gg: ASbGncu1XjZPxmqP28a/5mACqnbHSJmbeAzuYVkFMg6dXDV/UgC8bSoXvqsM24VV9VC
	3p8+H1zSd7EZ9iXfpS6JhTA/nVrOxVrOG7FEbuErRQYFOemBXWbS4m3dADEUsJnSqyeZEMuajmN
	MlV5Bzx3k0UEUslEO3B2oSICcazkgnoeTBzCSHXFAUhgjl10p9gzrIv3vQjoL4
X-Google-Smtp-Source: AGHT+IFhprCmu4GrSD1xDg8XFAEcC8oNrXMgmwo0VlqaVvPQQsRQwGcXHdIK0VS8pGhZkgTb6yuLf3goR+Z+M/Vcon8=
X-Received: by 2002:a05:6102:4b83:b0:4c1:7ece:88d9 with SMTP id
 ada2fe7eead31-4c6d39a12ccmr1576600137.21.1743243975921; Sat, 29 Mar 2025
 03:26:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Mar 2025 03:26:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z-ZI-M2jBf5pqMoA@pks.im>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com>
 <Z-ZI-M2jBf5pqMoA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 29 Mar 2025 03:26:14 -0700
X-Gm-Features: AQ5f1Jq4oDGVVpEpZzBnJjnsSNKcQczc5MiyDQrDRNB3rBYxKmKgFZJfE_Hip-0
Message-ID: <CAOLa=ZRgAQ+FKznxOaOe0ou_6vRPOA7SorhxwvGeBZ07SasgqA@mail.gmail.com>
Subject: Re: [PATCH v2] blame: print unblamable and ignored commits in
 porcelain mode
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com, gitster@pobox.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000f130ad0631789d77"

--000000000000f130ad0631789d77
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Mar 26, 2025 at 10:06:10PM +0100, Karthik Nayak wrote:
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index c470654c7e..528bfef249 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -351,6 +351,19 @@ static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
>>  		write_filename_info(suspect);
>>  }
>>
>> +/*
>> + * Information which needs to be printed per-line goes here. Any
>> + * information which can be clubbed on a commit/file level, should
>> + * be printed via 'emit_one_suspect_detail()'.
>> + */
>> +static void emit_per_line_details(struct blame_entry *ent)
>
> Tiny nit, feel free to ignore: should this something like
> `emit_porcelain_per_line_details()` to highlight that this is part of
> the porcelain format?
>

That's a great point, will add that in.

>> +{
>> +	if (mark_unblamable_lines && ent->unblamable)
>> +		printf("unblamable\n");
>> +	if (mark_ignored_lines && ent->ignored)
>> +		printf("ignored\n");
>> +}
>> +
>
> Another tiny nit: you may use `puts()` instead of `printf()`. I don't
> mind it much though, both versions work equally well.
>

Yeah, I think some compilers also do this translation. But I'll change
it as anyways I'm going to push a new version.

>> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
>> index 370b768149..306fc61057 100755
>> --- a/t/t8013-blame-ignore-revs.sh
>> +++ b/t/t8013-blame-ignore-revs.sh
>> @@ -158,6 +158,16 @@ test_expect_success mark_unblamable_lines '
>>  	test_cmp expect actual
>>  '
>>
>> +for opt in --porcelain --line-porcelain
>> +do
>> +	test_expect_success 'mark_unblamable_lines with $opt' '
>> +		sha=$(git rev-parse Y) &&
>> +
>> +		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
>> +		test $(grep ^unblamable actual | wc -l) -eq 2
>> +	'
>> +done
>> +
>
> Okay, makes sense. We cannot batch the information on the first time
> we've seen the commit here because both the "unblamable" and "ignored"
> properties are properties of the line, not of the commit. So we'd expect
> to see the information per line in both modes.
>
> Patrick

Thanks for the review.
Karthik

--000000000000f130ad0631789d77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7b2d06fa551afd79_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mbnlzVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFU0Qy85OUtCSXdRTTkwbnZrdGVUK1BieGlTZmhyKwp3T0V3YityZTc0
d1lpcUdNVEpGWDROTGhETlNleXFscWFBYXg0VTI4MjlWTDJ5M0RLR203cFRDY0hYUUY0YmQxCjh2
blBwZUxZdmdzRnNxSzFDTUs3dGdaL0UvTFdBNHV4VkUzQ3V1MDlNSGE3QjlFT3RHamtneXpQQkc5
VkZmWFAKN1VFZDdscWNEL0tEZ3FzazJXUmJYQmJMeWp0UnFrdmlyY1RWMUUxL29DUlo1YzdqQ1hV
bWxiczVqL1lnMjV5UQpwNG1hcU5JK3lpTzRCQjdXV0RYVTNOS1JHMzZUY2Fha1hNeTZ0NlhpekdJ
QkpzWWR3YTRyNTZaSEQ1V1R1UDJOCmZNeFJCc0thRFRzNi9sTTV2M2RhcVdEODJheVNBT3hsa0Ex
OUNQM2o2bVVnek1WLzgxQkYrdG5zbGNIUjdiczAKRnZzUkZPVjFOUDlLcnpLOTVNNGFmWklMZGdv
cFlNUnVBTTM4Sm03U0NPR3VuUEVJQ0Y3YThQREJPc3Bsd3RCZgovVnJLcnlRSzkxRERQdHpHTU9M
MU1UdzRCdG52Ri8rSjhlSS9vODNEbDhmMHRvcjhkRU1vSmo3YVh3aWh2UUZKCi9qNlZiQVdSOE9P
bDRWa0c1bVk4TGhwdHNLbzVjVjhqa0hKK0tkVT0KPXU3YzkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f130ad0631789d77--
