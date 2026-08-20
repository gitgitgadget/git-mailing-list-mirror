Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8AA3976BE
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261030; cv=pass; b=rnGfnt0KC3M/tiF3aN7wRbaye8hU2KKaQDgOO6bN1SVc8afXjTnHgMYRnHgouM+V8lQBPFuKza+P/0n0rNk0Pfth6m3wc+D27RjXqTzbcArybDvYVOZZjM24pkhrYz36tIaqzvR+OdjIzqmzsRTZXEUgwMxG7TbbIadRqqxy9i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261030; c=relaxed/simple;
	bh=3RmUOz4jDKIsnAO7Plu8ONF3k0N1Isg1LNNFz9uITk0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZ0Qt1Np9GTkANULe6cdOWz6amV2okBbGCjdFcCIjBpjxag47HkesXtIA7Jikrl3xi1etFd1KIyMozjA2AAOl1Pu+bHmJ4Fy3bKOx1yr34g4/0fQ/aVWE9BspMVJ6ZpbnpJhsSRZdUfEz8AbXcAopworjDgDVexBJsabWvJObxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0zSaxCf; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0zSaxCf"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bfb3347dc4so364325e0c.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787261027; cv=none;
        d=google.com; s=arc-20260327;
        b=YAQhwtzKGnGsOhU8ht2ntMUQptct9P4C94cXSuFE+rsarlczqf8hYOQuVITQngU8ln
         pQFdd2ZUzDKfvf4xWCMk6icjYG+c0R40aqSlv1xivlXs9NHsI6+IDa+FYFiaLjNTMN58
         WpD2yC0kCwMKK8oh8NfvZhWI+lkockhhwmUc2Pq1NKDzIvkCBlek0BrDVUX60b1Or60/
         yUYri5/BttpwqoxtGuOriXWuzrjPyEkQhKi3f3Te0ND7mFVEjRT0eyXf6MhocgnSE3X5
         TpE279PWX4WsQ1dTIrCDIP1VnzHJzqmIeaapXUsdzIm3NauYPur7bJysLoYs/OiQ5CzL
         cENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bBmG4fvf5U33thohKzoBPuYAYMcBeeg20LRION4SVJM=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=U1S67M1RYDo17DGuCpLOa4CVqzQmenaOB5clpX6j5w00g/XAL9h00NkY5TwnW1Hwh2
         GPMMy6lp4QwNPjaCEDG9tNTaYhb/lqcxmv4mQK45VcIrbP7JWRMWZxJnpGols8/JP8UQ
         +Qw996GSa92ijU44p+GMgvn8ZHCXqDNyyH2+CSAK0OIUYc7d9w8VqCIHFtRHyM0Rt9Js
         9L5ppyKja2Y9Y5LUhiGqSq3COXymvRp878Aby2phR4eBratAMpRBoKIFdkxqVd47As8U
         JGkCp/pfxC36crgBMyyI33xaoChgzCs+WrxQw+OdVEaMDKfblvruVIkDGbEe3POAcqnh
         dvtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787261027; x=1787865827; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bBmG4fvf5U33thohKzoBPuYAYMcBeeg20LRION4SVJM=;
        b=c0zSaxCfIRu4VMDnCI47ZBNZursgwzx0fAtIhTCYpf/gjsw6Ymw8aYphcURvYa1F/k
         RAWiGqAPoqzxWltibKm7coZm7fJodYY/0SsDarXKy4Z0OSESmt+fTY6dGIld8kZpaBiP
         TPwNL0/tAsl809MlpkZNSr6wxMeNFCRLO62vOToMdl58dLOtdqBYsGmr+SbEenB+t5yi
         Wr788UZNMot+B5RkVoDxFuDZpBFpWDf5gk193eyvVGZ0EAC64GyxV+x2GKPLceO0dfgy
         /pu+H/DewI2kGx0qa/ZNKNAglDRyRlruVJugA3Yi2h7YlZ3rtuJ7IC8e6DqUUamJwlR2
         yINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787261027; x=1787865827;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBmG4fvf5U33thohKzoBPuYAYMcBeeg20LRION4SVJM=;
        b=dcQN2cC06ZTa2eAAXKZudoow97QTzGc2gJ54JBzp/80sUeAPi5D4bSlIBpRMyzpUmW
         pFIjzBCazCck8DgbKp0e0Zkk3Q47xN4zfligDLZyczkQyjm49hzqQL+ryeB7qQ4R3ws2
         63zHpaOBfyi+qKSiGO0ZoWOj1Z/KLuQzpk87htCwxTtexp8cZ/8oURp3i6XEvPnRzuK4
         xZogYWG1+JN9TBViPynKl+YGuXYcb82nUOSNkI5OUc9uNYQiLifjXbGYMEIHiv/+porx
         W4xWJw5cbhhYYl5tx/LdCArEzN96Nb17932772cbDC0nRHk/GBrwjmZ/QtTIZA938M6+
         MGYA==
X-Gm-Message-State: AFuF++lV5pRDjxQ46w2ioeHuqwx+Xnj5PZ6QDwN0wqehvv0gY7KkSZRU
	Wu5iykG/OWnQpcFSVN7L19fXBxQepLZiaZuWFDrXJ/BNgLKVFlXMBaVU15PJ91Z2M72yT/JKDgZ
	OSGNp8sv58kwjdipBLDFQXveqguzSlpWci8Lz
X-Gm-Gg: AR+sD10JT13kvhmifJ9lmXWFj+XoLFrkbde5KUzp2N32OKL8rdoc0diT0h0+k+Wlq5E
	1nPLrNd1C7ZVo66V/sKRp9hT/1uvQZwigifSp2ao3m3Rqwxzg0QbJ+MyqVaqLaQAWmOW+22DXZh
	mkC7+o0d0iMJSZ2MGsTH3zpqoVTq5ePkEshnxvnPFnfmC4CAyfgRxYAz1c5kWWvdU3JIEnXfwHQ
	axY2n+hzECwm3lwvVi0jUDZV6TH0fh6JOFORvUMYP+uX/Blqwwi267a27KPZgl6Eaey3Eg0NBdH
	bSjV/ABDD4bVoY670h8h+GEG4+AmEuoevD9vudoPDY6m8TZd4kRB2ZTEBOWkmmHK893OvT49TCP
	CaRicVkKpN0F28Wh8f2/VPZcIL2QlFMOtkYyY3AY4+lZt0A==
X-Received: by 2002:a05:6122:469e:b0:5bf:8469:c7a0 with SMTP id
 71dfb90a1353d-5c5ff6cd0fbmr751566e0c.3.1787261027445; Thu, 20 Aug 2026
 14:23:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 14:23:45 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 14:23:45 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aoaV1GBPWwvTsYRm@pks.im>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-1-6bf5305d4e43@gmail.com>
 <aoaV1GBPWwvTsYRm@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 14:23:45 -0700
X-Gm-Features: AcwNN1UU4WnHvptC7v_LMg1S5mVsjYAZfaE-bmAlNikPYwgwVS7oBSznSglhmQI
Message-ID: <CAOLa=ZTP66UT0Az5F2MBQ2aNPpcnKD+LOo8xwKJ2Skj4RdPEug@mail.gmail.com>
Subject: Re: [PATCH 1/3] reftable/stack: remove `REFTABLE_STACK_NEW_ADDITION_RELOAD`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a98c840659812258"

--000000000000a98c840659812258
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 19, 2026 at 03:19:37PM +0200, Karthik Nayak wrote:
>> In 80e7342ea8 (reftable/stack: allow locking of outdated stacks,
>> 2024-09-24), the `REFTABLE_STACK_NEW_ADDITION_RELOAD` was introduced so
>> that callers of `reftable_stack_init_addition()` can also reload the
>> stack if there was a concurrent update made before the lock was
>> obtained.
>>
>> Then 16684b6fae (refs/reftable: always reload stacks when creating
>> lock, 2025-08-12) updated all of the remaining call-sites to propagate
>> this flag to ensure that we always reload the stack whenever there was a
>> concurrent update.
>>
>> As all calls to `reftable_stack_init_addition()` inevitably propagate
>> the flag, it is safe to remove the flag and its associated code and make
>> the reloading of the stack the default flow. This makes it easier to
>> follow the flow and simplifies the logic.
>>
>> The only exceptions are:
>>
>>   1. Unit tests, where we explicitly do not propagate the flag. These
>>      tests are now modified with the new status quo.
>>
>>   2. `reftable_stack_clean_locked()`, which was propagating 0 to
>>      `reftable_stack_new_addition()` but was then manually reloading the
>>      stack after. Here the new flow will achieve the same, while also
>>      allowing us to remove the manual reload.
>
> libgit2 uses this flag though, so we'd have to adapt it, too. As far as
> I can see though all of the calls to `reftable_stack_add()` it has pass
> this flag.
>

Okay, that should be simple then! I can send in a pull request when/if
this lands.

>> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
>> index 5d22d84e80..5d224f8079 100644
>> --- a/reftable/reftable-stack.h
>> +++ b/reftable/reftable-stack.h
>> @@ -58,22 +58,13 @@ uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
>>  /* holds a transaction to add tables at the top of a stack. */
>>  struct reftable_addition;
>>
>> -enum {
>> -	/*
>> -	 * Reload the stack when the stack is out-of-date after locking it.
>> -	 */
>> -	REFTABLE_STACK_NEW_ADDITION_RELOAD = (1 << 0),
>> -};
>> -
>>  /*
>>   * returns a new transaction to add reftables to the given stack. As a side
>> - * effect, the ref database is locked. Accepts REFTABLE_STACK_NEW_ADDITION_*
>> - * flags.
>> + * effect, the ref database is locked.
>>   */
>>  int reftable_stack_new_addition(struct reftable_addition **dest,
>>  				struct reftable_stack *st,
>> -				const struct reftable_write_options *opts,
>> -				unsigned int flags);
>> +				const struct reftable_write_options *opts);
>>
>>  /* Adds a reftable to transaction. */
>>  int reftable_addition_add(struct reftable_addition *add,
>
> We're already busy adapting this function anyway, so do we maybe want to
> fix its name to `reftable_stack_addition_new` while at it?
>
> Patrick

I'm assuming you're talking about `reftable_stack_new_addition`? We
could, I could add another commit here.

--000000000000a98c840659812258
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1f9989d20b48c498_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSGNGOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2ZiQy80cTg4L0pmbFdUSlQvOTZSNVFJMldudjhYcgpYOTRLdENmc3NE
ODRDR3UzcmhZNktCZ05jS3BiK0FsUVR4WkJ5R3AyYVl1aFNsLzl0aHVVbXE0L0Q3MDFDZkhBCmxn
U2poMXZSRWJsaVBmN25mT2U1cWxyQ1l5QnRRVWVuclpnODlKQXpPS0Ixbm1ybEsvRk5LNDk4VE9S
VUxwK2EKRy9WRmx2K0lybktQWVJORUo0VHFXRTNSbFNsczVWUkNNU0Q0R0FiS1dLemdRKy9laWE2
RXdwUXF6SkhER1JUOApHTmlvcjRMTWJzdExsV1gwZEl6MlpLdHE3NVNzM0JMMkdsZnQvek9zS0xT
TzJQZllONitMdThidjNKNkI3d3FlCnEycFByd3BpNTc5TVRvbnpteDZHTDBheWpBRTl0dXRnQnpF
d2Z0djFOOWVyRjlDMWV4SzQ4QzFRMnFjQVZTcjEKNGJQbVhrNDlXdWZiTkgwaUdxMTFsVGlWNW1W
eG1KZm9mNEJ5YXY1N0srY2FQVnV1YXpzNUR3QXBydmhtSkQycwpmcER5ekk4dFgxRHhiUFFFTjJp
OG91blhMdm92SUJlaXdYZHBSV2k1OWo4RkF4ZG83cUlJZ2VLWjZiL3ZqZ1c5Cm5pMWtPd2ZSaFBp
T0tiWDM0ZE5QOFI0cmVtd1lMbE02RW1ybzlZQT0KPW5YYXcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a98c840659812258--
