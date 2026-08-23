Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851C35201F
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787499553; cv=pass; b=J7Efm0PkieEGC0tbVevOHJ+MDS9QuM/XPtMPG9S4KCVxeeoBWqSBfkOqWKlJhChKp4SlZC9TgR82G7fkA80DHrUmHH58sdISHIEL9tY8yJ/E9MoOMerPyHxBlAA5EMGvV4UnwXlhZ4W5LbvAL8Bj/SzkJgls1mCCg7atqX2o8uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787499553; c=relaxed/simple;
	bh=31bGDhl3mhPAs91kcln3x4xe9W37AxgAqxjf6bclkPc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aakY73tFGOJHb3RknqoE0STgX86LIjsXPNf63D5IEsHONZpCUH4wQ/rr2pBTdzSAstkZxTGOwUjyQ1QJ6vQW+orpfAzLcozw2LyTPHaQKy5c0+9vE5NLVRQY+pS6BYzL1vIihJK0LLEjm7Y1hwpFIzKXi9sbRIsET1tpS5kDr2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPQLuNQ9; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPQLuNQ9"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc11a30a259so2657123a12.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 08:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787499551; cv=none;
        d=google.com; s=arc-20260327;
        b=nqw57bT3kkH8thpzUZNJrCGjgMH4n7VrquIvovF+H8lo7INmmmCMONA3F85B49VPsj
         p1OutCJ88J+n6XVwMucMzKPNQGt9XW9/UhdxpR6REhSCgg4g7M5b6Nu10XIUC5VCiUeZ
         y1oe6FZ4DL6FAofqcbPKgnW1eAroLp/un6cQW/URXhIqigHzUB1NnVpJRdOFeV8UJU5Y
         OhWrulTqrnEX7tLuVKrmtiT/O+cetoKxeC3LT2uFZsFEg5aG7fnsWnBHLVqK8t3rGZsd
         CrT2mXpPKWuVdLwmQSQjpEONcL48RtGnXY2ya+QlULuYyL93r0IhBHFtV1oph+QuCyi/
         Skzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=C9Q2TOdhSqghdHNrmhOrBX0THOo3SkXPsB9YzfmVvJQ=;
        fh=1m+XsQH2FcrBTIcMIJPnwO8mEqt8/O/U6XNxt92+ynQ=;
        b=KO9/aNk5o73Bg63wIxZyi+8Z3/8YcBxKQom2BLwheSLOG9DrKZi6jyPHOvezSzb3CO
         mN3Ptz4IXbEGZqqsvzZebMlFBg8xC/Yey4TFEviPIzqCkpvADH5WwqPXRWPA61KaZf96
         1jhHvP3h0u2RfQoDh65QfG4zsoN7zl0ZVGpN1U4LP1Qq+pgWYb16JnaWhauetC/deO/I
         tp5ToGZVjaQVj9mDeIu1SdTaGyeNz7oZIL/5Bm9Cm6H9uNjtvgyH3wKrRj7+1wRzKodQ
         1YkSP1ubZOPIS/LzKhvpf7OUJAAfnkCWRI07XIxaqYAtI5b9wLms9bQ0HXR4bWgQyH0A
         lNzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787499551; x=1788104351; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9Q2TOdhSqghdHNrmhOrBX0THOo3SkXPsB9YzfmVvJQ=;
        b=qPQLuNQ9ZFmIQP/aHM1sK/mvo7Oz9o7mkG3UOnEKFW2/bUK6CVdBZnVjdsa2l6Z5ou
         TP6KION2qmgtYNzVZhqOLq/jzzytOjjhwl5mdAEbqU05DiOBAULD1w1W9+pFHIrRkc8O
         8Q5cmQACfssC7v/ErtnxLSlV29HrDH82Pddf9Ptg6/NT5Mu9VoUDGL37Vx2I/iCoOXOB
         rG0V8loA/ypp0ePNVQQKbRxNGQ+fUwBiHyi92BIRb/VGy+PL18cKSF04fk5BrQlt2ed1
         HgXzbAYlSEa3B0+/gvV8SDF/Vd0jt2cBtCBOQkq31A+q8Z7fFoIUzD93HsZs7UKQetTk
         5hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787499551; x=1788104351;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C9Q2TOdhSqghdHNrmhOrBX0THOo3SkXPsB9YzfmVvJQ=;
        b=OgLGHIMwzZzRwckKs6G4+7/7kEipb2lFpWFuTWn8iSkt3bIEzc1BzYjjcplMPqZlAh
         bSZZ+uuf4WwofQAQUAS/cHWem6M/0cAkjQIiFCtLqhRF1x84f9crr1CthkBFagvX8HfI
         x/TirtZArTXzU7wTmimTvqGH1AwwKxjLsmEi6+iO0LZBogzzfeqcxp4xjNIXImWfNGzT
         a53XYBX5wwvZsg4HqT1JZb6mUGNc7JkH8crPaNCzVnHeEN7ka9N2jk25UMFEPlrqBtuI
         KVXWJaTHn9SVTE0Ob2brderW2nQUBGCBZ1YI/MjhHfHC9/22qAJIl1fsKKgIto8vvZcX
         BCVQ==
X-Gm-Message-State: AFuF++msWfAJmuu445YPaIZW0KK6OfMTgW8DhIIzXjnn9rUP9ChZxV4v
	/qsZpxstnbFl/NjqEfKALY23q3itWIJvJmNu74aecFYOLUr+pCy1Xu2KxQBNPVB83aXyLw9cuVY
	kV6tadmuHRi5QrlzTyiv+8heZ1Mxtx0S6zQP+
X-Gm-Gg: AR+sD13f1yWUl0UviB/E4+Pap7Wlb+57OJZCtR00YMlrLwhS+MSU5XsrWwMu0o4+EYt
	RiLU55LNZ7+5uX2VfVN+lGdWjEpBmbxjpa5F8aw8gUO1N1NAgBpC+Uy89BO4r/CnAd7ynyA7WEV
	lSB+X8MvV7sUtV/TjXBpCPuQW+ZPBby62PYt0n9vk9vkuLg8xctEYbocAki5fd99JWmW+qQpDUu
	4uPVqUTuroA2UYox2TG8Z3Ji0PnEllfC7XT21mNTfEW32D4UsogT6Ap9YLaUuQSoOYyGsSE6qS9
	ZtneyAjPF6ZTAf/fYZJMfI3gMT5Ml4igSK8ou1Td1rizUqUfzXXo53Ezf3qwGBdKqIFfqBJZTYd
	P4A/hBSHzT0zxn+3oZmAjInR2riI0Nqpgns94aeOzZoJc5g==
X-Received: by 2002:a05:6a20:9d96:b0:3bf:6237:4d3f with SMTP id
 adf61e73a8af0-3cd4bc45418mr24100490637.18.1787499551423; Sun, 23 Aug 2026
 08:39:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 Aug 2026 10:39:08 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 Aug 2026 10:39:08 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aoXcvhFbUJruALIe@denethor>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
 <20260819-740-optimize-reloading-the-reftable-stack-v1-3-6bf5305d4e43@gmail.com>
 <aoXcvhFbUJruALIe@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Aug 2026 10:39:08 -0500
X-Gm-Features: AcwNN1Wfk88KBE0wyZL6H4J2d7f_1K1PkHoUbNNtHX-wiEZBxRPSCNSwhMs1ruA
Message-ID: <CAOLa=ZT4WuBh2eansJhzMm5F39UCTiOP1vgQ+yfQK0syzbm1uw@mail.gmail.com>
Subject: Re: [PATCH 3/3] reftable/stack: avoid reloading the stack when
 already locked
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000ccb8ea0659b8ab50"

--000000000000ccb8ea0659b8ab50
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 26/08/19 03:19PM, Karthik Nayak wrote:
>> When making modifications to the reftable stack, the stack obtains a
>> lock to the list file and removes the lock after the commit phase. Since
>> most operations reload the stack to ensure we have the latest state, any
>> branched operation during the locked phase could trigger a state reload.
>>
>> To prevent data loss due to concurrent writes, state reload is necessary
>> right after obtaining the lock. But any reloads after that are just a
>> no-op. Now that the struct has access to the lock file status, simply
>> skip reloading if the lock is present.
>
> Makes sense.
>
>> Benchmarking with a fixed, non-symbolic target OID shows a modest but
>> consistent ~1-2% improvement in clock time for `update-ref` across ref
>> counts ranging from 2,000 to 100,000.
>>
>> We can see better improvements in the number of syscall counts. On
>> master, the number of calls to `newfstatat()` grows linearly with the
>> number of refs created. With this patch, the number is now a constant:
>>
>>   refcount   master   patch
>>   --------   ------   ------
>>   1,000      1,059       55
>>   5,000      5,059       55
>>   10,000     10,059      55
>>   20,000     20,059      55
>>
>> Reported-by: Jeff King <peff@peff.net>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  reftable/stack.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/reftable/stack.c b/reftable/stack.c
>> index e449af9c03..433a611ed1 100644
>> --- a/reftable/stack.c
>> +++ b/reftable/stack.c
>> @@ -553,14 +553,21 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
>>
>>  /*
>>   * Check whether the given stack is up-to-date with what we have in memory.
>> + * If skip_if_locked is set skip stack reloading if the stack is currently
>> + * locked. Stack reloading must _not_ be skipped right after obtaining the
>> + * lock, to check for concurrent updates which may have happened.
>> + *
>>   * Returns 0 if so, 1 if the stack is out-of-date or a negative error code
>>   * otherwise.
>>   */
>> -static int stack_uptodate(struct reftable_stack *st)
>> +static int stack_uptodate(struct reftable_stack *st, int skip_if_locked)
>>  {
>>  	char **names = NULL;
>>  	int err;
>>
>> +	if (skip_if_locked && st->list_lock.fd != -1)
>> +		return 0;
>> +
>>  	/*
>>  	 * When we have cached stat information available then we use it to
>>  	 * verify whether the file has been rewritten.
>> @@ -623,7 +630,7 @@ static int stack_uptodate(struct reftable_stack *st)
>>
>>  int reftable_stack_reload(struct reftable_stack *st)
>>  {
>> -	int err = stack_uptodate(st);
>> +	int err = stack_uptodate(st, 1);
>
> Ok, this appears to be the only call site where is actually want to skip
> if there is a lock present. Could we instead just not invoke
> `stack_uptodate()` in such cases? That way we don't have to change its
> function signature and can leave all other existing call sites alone.
>
> -Justin

We want to selectively invoke `stack_uptodate()` based on if the lock
file exists. If we move that logic outside of `stack_uptodate()` further
callees would have to replicate that logic. While that's not an issue,
missing it becomes easier. So I made this explicit choice.

--000000000000ccb8ea0659b8ab50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b2c0c1f053d2a5b4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xTEZCa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXhuQy85bUJHVWtXQytiNVA0N3J0aUF3anRYSGVtZgo4VjZjc2tJU1Na
R2pYZDZCNGZscDQ4WXhJY2FJcEJhSk1vWGEreFdVNHZPOGFxb1M5aG9tQk1ET2ZHT3ZzS0hHCnZI
ZUU0OGR3Q2xKYmdCSkg1UTdYVER0MysvT1crUjZETXFLTW0wNjF2alhoWURQSEJQb2NscE5nRjVt
Q0NYaDMKQ1J1ZUJjZkJqaGkxZUxEMnk2RHhQMGlPdHY5NUZSL0hZeS9rMEgvTVJoV2dXbEd5ZHRJ
L1BXRlRYQURXTW5KMQpod2VHSEF5a3FuTnFuNEI5NlJ3YTNkTGdrSEJsdTZ4YUZPOUltYmJCUnlh
ek4wczNQYTFQemUzUWRIS3JQZXR0CjRpQlJOVE4xTGdVSURrbWtkODNlRWFudVp4N3ZLSVcydFdR
OC8vd2FtcEoybUFndG53R2VUN2MzbHhBblVsWWMKdW5aV2NEQlJHMXl0TktmM25DTVlpUXhFZHlC
bmMzVStMOW54UzhMV3Izcy9EMlpqcjlzeXV2NjBxSlFpMVdRZQoxMXZ3MU05WXl1dXgySXRiUTNP
M2oxb1cxZEh1Qm9HcjNWNHUxNEcwbjcyUmU0YXRRamJHYWMybGZvMVJUaEM1ClVOV2JxOEtKUzVC
dmZYTFFJa0Jub1h4NGlJdXJGemVoRXJMMktyYz0KPUtHR0MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ccb8ea0659b8ab50--
