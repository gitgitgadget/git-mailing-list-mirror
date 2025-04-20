Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F15BA27
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146933; cv=none; b=Xo/a9YDnaiKUGeklP5EUcokDNlVd/eCgTL5RIhZvYruOA+xMiEeI7AYEASdR6E/dDQUlCk9ZeKIiPWSec0xXgVqDJM6E1E0NbZMS7KbgrOJmkLNtOn1fHRmVM0y9fCLDEFjPJKcsEEYvGdVSnndLb+I3GGp2iwwXLAfkhMx13cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146933; c=relaxed/simple;
	bh=2F9wlL5CEVLlnn4jgY9CHDqy4syHMcimrSPKQOxAwwE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYQZz9ozYw5dvRrTET9a5h1ZVMJ7C9IQe9QEU6F0tQDIUdgGvP30k7AlrXzvwVh0moCESyuACqAg2xzLMa/eP9Slj82yZC70J1+0UA1Y8yzOe1xtuR03uzGtcHNlpNiVeDNFkRYFrd/3DsTH5878Cwcqk/+JA24URJwkKJDXSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmyn5Dux; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmyn5Dux"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5240a432462so2814159e0c.1
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745146929; x=1745751729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu7B43zh15Yr850Bum4NNqkOdVEQshCTw9nbeW9VnwI=;
        b=bmyn5DuxQQNhx87aJ/+FKBPD4qVmy7p79VD+ZLFBzz4ZVpz/HbJdL4Qdf+ZgWwgPaW
         y6x08Qs8UlNzdJLxPjbsRO4loZ01jxhvbTNahIalhUwZHe4JLXbNdSjZSBX96bb6T7oV
         kPlsl2Ca7KSq4+BJuQPGVMRhRrq82SSGN5ZrXuot4v/wOWkh7PxdU4DGRJ2VOzrE6B3b
         9XFG1/NVOZFqhpLrLOwXrdgzaDnkmk9Fvk95mwI4rBnMoZQ8iulh8wIVqfHZWKqWRZJ6
         7Vy84G4gFPck7h/BkCbv0+z1l3zdKIbSYDmN1nRyugf5UUT87JP1vS/5YBRhqhBnQpyK
         0EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745146929; x=1745751729;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu7B43zh15Yr850Bum4NNqkOdVEQshCTw9nbeW9VnwI=;
        b=xCkzkR9NNPZXhymJIuZI0aTwM1eZVwC8RcT4lsup+CRNwOUfBWQCKA7QE/MsBxiTTg
         cjng4+/yR8YVYBrMm9aMfYn/J74/6403h9Jdh5mA39o/aKUr0htJbLU1vAggkY4HsGDG
         eratAlOrUpw0CSZblc/ndcEbKGDq8NViDz31EEGoxfFDx1hGXehKmo3iSjKXIWoNAPWi
         8e13CWhsP4L+oGi31vQRjBDyi8m/9nuJSbDiYGgBFY51O1wnt7R9CBJkYXlaXXqTVXgm
         1pYkl4vppHFplrxas5UCh+8kckFAiEznzeIOIv0tVRU+amT+3kmBAK5n3Ycf/sTzouGO
         x/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVkcw9VQJHHy6a3J8Sd5FGYlQj+8kV4O3t9/23E1cwyRn1UtmGtmESW+EUHpshqGWiAfwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4P32/ChXHfgyLTtlh/+xgVK1Dchnjh7vGk4jjNgkYK2sdwLC2
	gTmLzgckwb+jOxVT9lzFU2tuJpfb8kiIpXgGRQ/6MIdZgJTJ912t9jdyVB++5+ZQSynnO27JZPk
	w86xd7LUVOrUuEL8rg7DwNibKOgg=
X-Gm-Gg: ASbGnctpMDKiLQadap926aDvJ1msk+smuRZ9hmWq0Zqixd1EFFq6Fpv4yzwiLJO9h7J
	1z7szYJKmdmA4VLGTwzVJDwZ2FOHubLay2/xa0fpZDsThFZo/fqiddE01i60FklGIoJDeUrj9rH
	7lhhfDSFXet86VwiL0KMcMtm0E67mkyfJDQMJGeWAud6h29X0QuJb2Ugql
X-Google-Smtp-Source: AGHT+IEelXW+x6Bf17J8kqcrEOpjZPO4uxpN2SkRzEZlVye1iTxT0dqXRZHNA4wgZA7AWvYwuMothFTjJNfHgmY3BLM=
X-Received: by 2002:a05:6122:6584:b0:527:b7a3:dda8 with SMTP id
 71dfb90a1353d-529269e16a6mr5084672e0c.7.1745146928963; Sun, 20 Apr 2025
 04:02:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Apr 2025 07:02:08 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Apr 2025 07:02:08 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <f7d086eb-e616-4bf6-a679-6894ad6eaa85@gmail.com>
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
 <20250414-505-wire-up-sparse-via-meson-v3-4-edc6e7f26745@gmail.com> <f7d086eb-e616-4bf6-a679-6894ad6eaa85@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Apr 2025 07:02:08 -0400
X-Gm-Features: ATxdqUEHTeot4AKKGCKiF6-m-C9TGmemcs4o_yArnEaXA_l-flTAaw8H6txRj7Y
Message-ID: <CAOLa=ZRPjeGP-yF_p-vve22mW8SrtqV_i_4JrjmGt1hRSqrGPg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] makefile/meson: add 'check-headers' as alias for 'hdr-check'
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: toon@iotcl.com, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000c83bf8063333ae27"

--000000000000c83bf8063333ae27
Content-Type: text/plain; charset="UTF-8"

phillip.wood123@gmail.com writes:

> Hi Karthik
>
> On 14/04/2025 22:16, Karthik Nayak wrote:
>> The 'hdr-check' target in Meson and makefile is used to check if headers
>> can be compiled individually. The naming however isn't readable as 'hdr'
>> is not a common shortforme for 'header', neither is it an abbreviation.
>>
>> Let's introduce 'check-headers' as an alternative target for 'hdr-check'
>> and add a `TODO` to deprecate the latter after 2 releases. Since this
>> is an internal tool, we can use a shorter deprecation cycle.
>
> Thanks for renaming this. I've left one small question at below but this
> basically looks good to me.
>
>> diff --git a/Makefile b/Makefile
>> index ac32d2d0bd..961ee508be 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -3326,8 +3326,10 @@ HCC = $(HCO:hco=hcc)
>>   $(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
>>   	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
>>
>> -.PHONY: hdr-check $(HCO)
>> +# TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
>> +.PHONY: hdr-check check-headers $(HCO)
>>   hdr-check: $(HCO)
>> +check-headers: hdr-check
>>
>>   .PHONY: style
>>   style:
>> diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
>> index 0d51e5ce0e..60c175a094 100755
>> --- a/ci/run-static-analysis.sh
>> +++ b/ci/run-static-analysis.sh
>> @@ -26,7 +26,7 @@ then
>>   	exit 1
>>   fi
>>
>> -make hdr-check ||
>> +make check-headers ||
>>   exit 1
>>
>>   make check-pot
>> diff --git a/meson.build b/meson.build
>> index b1be2b3cbb..745cb30165 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2062,7 +2062,9 @@ if git.found() and compiler.get_argument_syntax() == 'gcc'
>>       hco_targets += hco
>>     endforeach
>>
>> +  # TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
>>     alias_target('hdr-check', hco_targets)
>> +  alias_target('check-headers', hco_targets)
>
> This looks good. One minor question which isn't worth a re-roll on its
> own - in the Makefile the check-headers target depends on the hdr-check
> target which means the two will always use the same dependencies. Here
> we make check-headers depend on hco_targets instead which means that in
> theory the two targets could get out of sync if the dependencies of
> hdr-check changed. Is it possible to have a meson target that depends on
> hdr-check directly?
>

That's a good question, I didn't think much about it then, but looking
into it, seems like we can do

  diff --git a/meson.build b/meson.build
  index 3bf3d65e8b..39319e2610 100644
  --- a/meson.build
  +++ b/meson.build
  @@ -2055,8 +2055,8 @@ if git.found() and
compiler.get_argument_syntax() == 'gcc'
     endforeach

     # TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
  -  alias_target('hdr-check', hco_targets)
  -  alias_target('check-headers', hco_targets)
  +  hdr_check = alias_target('hdr-check', hco_targets)
  +  alias_target('check-headers', hdr_check)
   endif

   foreach key, value : {

Not sure if there is a more idiomatic way, but this works. Will add in
the next version.

> Best Wishes
>
> Phillip
>
>>   endif
>>
>>   foreach key, value : {
>>

--000000000000c83bf8063333ae27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9b78fafe7da7635f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nRTFDOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1pnQy85NERsaWxCcHFuN1I2NTlyQjhGaHU0Tk16Zwo2ZUpaK3hDZC9J
SW5jZGNVSGxtUEdDenhjVWFrYmdhcHZDNlMwUnI0TkhTRnlPeXBuWHNXZWR3Z1JMck9iZWx1CjJm
ZnJOaXE3Mk9vdW1iL1Z5RmE4ZStWSE9xODVmSjdETy9aNFFCZW1HOUlPK1JudVRVMFZKbW5rYU1T
L2JTWnUKa2ZpMmI1eTZGT3Bvc3dVQ2F6ajhtRG4wQ2ROWTh2ZmNoUS96TVdmRjcwTVgreWEyRy9l
M0grdTNmSVV6RENZcQpVbkhmZnB6dkV4Z3duelNLQStZWXpjTnJQRnZYREZEdmluaWlvSi9GVUZl
RXBpUmhaaW5DOVJWcGxuY2szVWNlCk9wVTIzbWI2Ymo1bnNWVkUxWU4ra0ZDd1RLdEM4YStPd0RK
KzFCL2YyNzA1YWFuQk55NXNiQXgxRUIyMUF5NlQKY0ZDbjc0VXRJTGtEQ3p4emVoVVV2Y29tbDd6
V1orVmFrK1NQVU5VYUFZOVVjK0dBQ1kzRFB5YlVhMk1uU0ZDYgoyRUZKTktIQ3p1WVBoemMreWd5
cDJaQ3FIaHArQkVDM3oya1NrTkppeXJIU1B1eHpiRUdIWURJQnczMUo0RUxsClV5RER6N1hHc1dM
U1RHOGxvaGhzKytoYnVtcUxFcThIYkk2dFZnRT0KPUZQcFQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c83bf8063333ae27--
