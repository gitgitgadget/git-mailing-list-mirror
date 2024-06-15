Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884C3C28
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718452079; cv=none; b=i6h6yYp2s7JSNNRwzk34EGWb4GUXN6Tj9zpqSO5gRkuw9Qydq3rRd+3ohaVuDmKksu4lcUGe2bSvfk44wmuUg5SSgyniLn32wir+zlLMQe5Vi+cxCnidoPrv9xijEWBRL+NPE4hV7e1abCfM5ohNkZhbUzELbhYjqFC7bilREjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718452079; c=relaxed/simple;
	bh=632D6PMNe/nHUw+trjOt/XixCq4ewbikySEB5REK0Fk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6sTQgoyoFmfbwdp15WCUf2wYtyKJqor7pZ7/RigVp/bME9ZAmya2HCmEa/Z/iJVkzbFu9f8Cn8/WBas1cr1Q0xIJndTj8W8atMQXZJmJC6gFf0HNpbriX70MKRmyfKikfVZhefuzGe7TtyBusIvh6MKXWRaNB+WxoSPIZEKUQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2vQUy5R; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2vQUy5R"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f9a4f9923aso1614302a34.0
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718452077; x=1719056877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMNZARZsEWDKdM8OkRsGIlpS72gEt73TRWHVu/H2lZc=;
        b=Y2vQUy5RJCvUlnEO36oE7YHCoCtY40PHGvgfI+bdBY25S9EoH8hovpTWuq/KpTHPPa
         Tp8zGXrUj0enuSivI0JMwTXVgn3FeuEIce6kDoBEZfu15vkmT7H28ttCyROlWGcNqdvJ
         q+dlYtXM//UIKwSA5f4sKXOZ7yyVuwS4tDvUanvq9GLhcUjFg/Vh+CVenMecM95EenCw
         FViHKHVI0aaKnI41hIX5wbB1Pbduapjduo1hwoWzYQb9ouIPkr/CTO8YUqDrs3mvVbJJ
         qskPM8PoE7/kHD4dVwhEM2Jfgcr2phJIb7oYLCpoqRghpNZSgWse4wX4FKTJLhNNnkLw
         yTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718452077; x=1719056877;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMNZARZsEWDKdM8OkRsGIlpS72gEt73TRWHVu/H2lZc=;
        b=EY1PwCsnHbbQclchjLJpLOCCRXcXJu6SP95uMwy1V9zCAyD/LzB4JJXjvn6jUtwrw2
         TQ/BeXP7dNPKdO+kDGS7LkiVtPLL/kPdPMihA7lQlUuWM/RZhQ0Wr4sR20+5VQeYn523
         LVRbm4M/tyqWPTefhcqnKRnCNtT/QMsFRdrWZ5/Irvk1dk9o+lhNqTi/CUn+pNJ1Cbn6
         Q4KkWnL/PWSUcX3b6keN6RVYnnZBjMrGChuRk5Amooi4ni/Xu3iwYqLnMI18bi5jDhDu
         AO5z1gb60LLYNWIADHI6oCrDHqJ6iWVaVTJ7K9hfUTlU78KzUIQwou4WmWHBp5fmOKIx
         mdiQ==
X-Gm-Message-State: AOJu0YyhBJ0o+5WSLZkT2Z0ES9vHZqYL/VJ1ixfJQufDHI6Xmf9b5F5q
	l79gCQi78LbtAaR09e1E+wlbD6zDd1s3ewCD18HHgtLLz1+buSk2SaW8OnOB2hZkH4a6lm8ntDC
	U6qDooHPw37HMZ5MKwUYOW7jnq4vXAogI
X-Google-Smtp-Source: AGHT+IE98iTWGUZkue/SWcMyfb0Zib9I7Z+CVh/QUZdJsn0RdYi2d1YtiiCNEinz43NR+5K5KUvcxrUIbAkAJnmUVbs=
X-Received: by 2002:a05:6870:9725:b0:254:ada1:aa29 with SMTP id
 586e51a60fabf-258429d808amr5373445fac.27.1718452076668; Sat, 15 Jun 2024
 04:47:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Jun 2024 07:47:54 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwmmsiakq.fsf@gitster.g>
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
 <xmqq1q58ejnw.fsf@gitster.g> <xmqqcyorcldv.fsf@gitster.g> <xmqqwmmsiakq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Jun 2024 07:47:54 -0400
Message-ID: <CAOLa=ZT_ZSV7gCexZhcKBvqJCva5UEY+66TgqDUoBo=q=pOqzQ@mail.gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
To: Junio C Hamano <gitster@pobox.com>, darcy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, darcy <acednes@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000980d78061aec4d80"

--000000000000980d78061aec4d80
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The CI build on Windows tells me that my worry was warranted.
>>
>>   https://github.com/git/git/actions/runs/9424299208/job/25964281907#step:4:643
>>
>> (GitHub seems to show the breakage details only to those who are
>> logged in, so you'd need to be logged in to visit that link)
>
> So here is what I accumulated in SQUASH??? patches on top of your
> topic while waiting for an updated version to unbreak the CI.
>
>  * The "end of git time" timestamp does not fit in time_t on 32-bit
>    systems, so I updated it to use timestamp_t at least for now.
>
>  * t0006 has two tests that use TIME_IS_64BIT,TIME_T_IS_64BIT
>    prerequisites; I introduced HAVE_64BIT_TIME to simplify them.
>
>  * nobody passes $4 to check_parse to tell it to expect a failure,
>    so I removed it.  It always expects success.
>
>  * check_parse now honors a global variable REQUIRE_64BIT_TIME that
>    is used as the prerequisite to run its test_expect_success; the
>    "near the end of git time" tests you added use the mechanism to
>    pass HAVE_64BIT_TIME prerequisite.
>
> The last one is a bit questionable, as it only "punts" on 32-bit
> systems, instead of making sure we get the expected error messages.
> I think it is OK to punt here and have a separate test that checks
> timestamp around year 2040 for that condition.
>
>  date.c          |  2 +-
>  t/t0006-date.sh | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/date.c b/date.c
> index 95776c8a92..bee9fe8f10 100644
> --- a/date.c
> +++ b/date.c
> @@ -870,7 +870,7 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
>
>
>  /* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
> -static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
> +static const timestamp_t timestamp_max = (((timestamp_t)2100 - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
>
>  /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
>     (i.e. English) day/month names, and it doesn't work correctly with %z. */
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index e8fdf361ad..fd373e1b39 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -8,6 +8,11 @@ TEST_PASSES_SANITIZE_LEAK=true
>  # arbitrary reference time: 2009-08-30 19:20:00
>  GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
>
> +if test_have_prereq TIME_IS_64BIT,TIME_T_IS_64BIT
> +then
> +	test_set_prereq HAVE_64BIT_TIME
> +fi
> +

This does make sense, I did check and noticed that the two are always
used together everywhere, so outside of these patches, it perhaps would
also make sense to combine them altogether.

>  check_relative() {
>  	t=$(($GIT_TEST_DATE_NOW - $1))
>  	echo "$t -> $2" >expect
> @@ -80,14 +85,15 @@ check_show raw "$TIME" '1466000000 -0200'
>
>  # arbitrary time absurdly far in the future
>  FUTURE="5758122296 -0400"
> -check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
> -check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT,TIME_T_IS_64BIT
> +check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" HAVE_64BIT_TIME
> +check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" HAVE_64BIT_TIME
>
> -check_parse() {
> +REQUIRE_64BIT_TIME=
> +check_parse () {
>  	echo "$1 -> $2" >expect
> -	test_expect_${4:-success} "parse date ($1${3:+ TZ=$3})" "
> -	TZ=${3:-$TZ} test-tool date parse '$1' >actual &&
> -	test_cmp expect actual
> +	test_expect_success $REQUIRE_64BIT_TIME "parse date ($1${3:+ TZ=$3}) -> $2" "
> +		TZ=${3:-$TZ} test-tool date parse '$1' >actual &&
> +		test_cmp expect actual
>  	"
>  }
>
> @@ -133,6 +139,7 @@ check_parse '1969-12-31 23:59:59 Z' bad
>  check_parse '1969-12-31 23:59:59 +11' bad
>  check_parse '1969-12-31 23:59:59 -11' bad
>
> +REQUIRE_64BIT_TIME=HAVE_64BIT_TIME
>  check_parse '2099-12-31 23:59:59' '2099-12-31 23:59:59 +0000'
>  check_parse '2099-12-31 23:59:59 +00' '2099-12-31 23:59:59 +0000'
>  check_parse '2099-12-31 23:59:59 Z' '2099-12-31 23:59:59 +0000'
> @@ -147,6 +154,7 @@ check_parse '2100-00-00 00:00:00 +00' bad
>  check_parse '2100-00-00 00:00:00 Z' bad
>  check_parse '2100-00-00 00:00:00 -11' bad
>  check_parse '2100-00-00 00:00:00 +11' bad
> +REQUIRE_64BIT_TIME=
>
>  check_approxidate() {
>  	echo "$1 -> $2 +0000" >expect

I think this patch looks good. I also think we should probably look into
fixing the 2099 limit overall. I think Jeff already posted a patch to do
the same already:

https://lore.kernel.org/r/20240604093345.GA1279521@coredump.intra.peff.net

--000000000000980d78061aec4d80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c9c7105fb21aab86_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1adGYyY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2p4Qy93Skc4V1doWjZKOU9jYlZDYTluU3lDMGc4VwowSCtLNlpaTFV6
aUlXS1dBaDVadTY0N3d3RFZMZUxwY0VPUHJZRkF3OWhGZ1NVdS82b25vM0ljMnhGUFY3SFNYCjcr
a0ovWUhqWkN5QVVXS1RTcHQ1eU9RUWdZUHd3LzZ6ZUMxTXh1ZHlabFZWMm5EOTNjTEpWbXFuQ1ND
cnpSY1YKR3p5b2xwb3dpTFVzZ3lUdXR0K1laN0FUUDdyNHE4ekZMUHNLdERZUkhkZ3VYSVYxcFZR
NXpTNkU2MzJ6K1ZmTgp0ek5DY2szTFlJcG9xbytxaTZBWDVSbXFESklpNWNyMUdSQms4Rjdtb250
STJOK1Z2djR0cE5SSG5kNUhwdlBBCm9qWTFacCtndGVJZGVwRFoxdm1peU81S0R1M09UZjN2Um1I
dHFLUFl2N0t5REhMWExCM05xTHF0dktUeXlZN1EKMGczcjd1NzVBems3NytrejViVGFxbXZZeTRX
ZTVVUFlrV0kreVI1YmRoRi9ud1hucDRvbW9mMUEvSjRQYnNISQp3dUxSYVRmYWJPcWx0dmFSMDZs
eFJXNVZkMGxjOXRiWlVIZHRTUFpUZDRhUWI5LzdCWCtHeWtCdHMzY0N5Q2lQCmczcHJlWnp4cWdm
TVlucTBjbmtoZldqYlJjd0tEUEZCLzhIZVU5ND0KPW9RdzUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000980d78061aec4d80--
