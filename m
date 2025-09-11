Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0554652
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585664; cv=none; b=RTWoGKP0aaKypPwBEKg2mLr7CzepItDxiO+JzulOSW5tPH1HnPuxDlAenFpa4RVCGXK9931UZMbbBNdd343lftrs35RzW+WLub+YtIQ4/JIMXDF1EM+Mr2MXwzwloTusVeDV45o6eDDb8sbleTgrTE3JLJzg3s4xXUAZOGrMxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585664; c=relaxed/simple;
	bh=DAGszaeUkU08jtD7eG6llft55HNugkA8r7gRvJqp18c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd9ccoDnXu/2a8pY2xgTMOdAPtAuDyel9xngNbIFROKCJIMzqDlqlyJsYVv5QLBfl81JlSFn4RU1Afg9zgVsvoQ/ineBwHb6yaQQUmEZFdixT3KC7fMtnQJW+il897qZJnRcrEfrE2FVTUy8z0nFZcquJ1k5c9OgqAQyCfIHBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsHWxKLQ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsHWxKLQ"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5290c67854eso398506137.3
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757585661; x=1758190461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZe+venJDuBl33YgGTt0Dzk4nVt+1FHzY/ghyfyrkl4=;
        b=KsHWxKLQnqj1MaYHiQKIUqqITnXw4CEhacWP+xdCU5xEt/wBlQaBt/M3A3Apwy4A/e
         MGB7oNf6qETjroF2v8atfsskkVlU+JMQLDZLLZ97kZ4tfBE9+m0LNoBg5+n349Y4BlM7
         IPHnEu14Tj/j3vo11+f7BD0d2xPNA0HLyV5RJeah/8eI/UxFSPsB5NJRieszUNdBW0XO
         9C4jV7qcynmbO8pM54pyaS/5l8alAfMKAjGhG4o6jgXcIYyEuyOk/OVsWOA7thhwEDqI
         I2r1Vs+9LG7Q2KZ+Ta47Hw6Xd//Y8m9XsYloXVxvpNeMW1hypD1XvkPTdEBU5kat/7uT
         2N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757585661; x=1758190461;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZe+venJDuBl33YgGTt0Dzk4nVt+1FHzY/ghyfyrkl4=;
        b=wkrm2ghYmTpiO0bONUkv8AppcPeiPyx+kcbFZmeT4i7+m3fpQh+JTb2+3P9Vccn8mJ
         YTcDEFtb5dLCPyldCBa7m8z4SMfizMgzEaisJA6KksxUJWFr/TgOCI+4MzF+9Nb6+flw
         F4wDpFJbbIygbbKCji7sYhpIFTR5Zoe87XdhYrjVO4rPD7GptkIgV5Tr3vO55Pk9PJoJ
         6MegowFH82sCmZPuRMpv3O8hypwsNo15ycjEat0qUC8k59ENOL2olSlLn8lyZ4TYLkC7
         Og5hsraeLWfiT4+WUjZrcZzmhjC7byZVxgt1FePTiU5c7C8h5C0r19lZwO/ZoOTgRj2v
         v2ng==
X-Gm-Message-State: AOJu0Yx7Nc0lagwH3kvpkpF0/eEG+gQZtuaLDgQ0xB8N7NXuBTCPnjve
	fW/NzMVa3I9GAuOHxvO2APuF8igdhdDkWPV19K2mUfyoSLnquKz6PixTzBx+FbBi265a07Ow3Iy
	hsdTbUmc/uBP8tqyBZNvm9/cNcNJm2zo=
X-Gm-Gg: ASbGnct3cV2KVw5yz75snvT5Cft2NWqiu8KL6vH+WGB1oQld1fwiaBAQ+BM1Lm3MZfq
	jQ8aM7Z8KzW8do+FvMitaBUdZIzfAqlBWJ9i7xDoWz7Fh/eqEMAmmC+QBjD7BiWYF2xAZEM+NX2
	cQy+zWpQ45jEwYalExGCGF38ZbRDHbXKieptONehBnYn8siPU0fnAjd+zAI1JZQphBJOMgQNOfo
	dsbxgEhxHm59gta0+khEswvGu+M3+M8IUWeo+GEdH/V9MXp++1R1WACgpU4e2o=
X-Google-Smtp-Source: AGHT+IHfpJZF9H919yexyU7Mm40dSVPdE3DtuXPgvNcUY6+qatULIRc3Y7+5gS6Fqj+IS/tcoRmWZRBPyW3ds1xlaaQ=
X-Received: by 2002:a05:6102:f88:b0:51f:65da:4ada with SMTP id
 ada2fe7eead31-53d218dd118mr7913484137.17.1757585661484; Thu, 11 Sep 2025
 03:14:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Sep 2025 03:14:20 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Sep 2025 03:14:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aL_SydrNjXdQrtFC@pks.im>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
 <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-2-b2eb2459befb@gmail.com>
 <aL_SydrNjXdQrtFC@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Sep 2025 03:14:20 -0700
X-Gm-Features: AS18NWAOYOy7ZRJbdcFsjUaLoW8LX5sTGBgcv3wOEfAqciNaR5SAf2VZbdSlnBY
Message-ID: <CAOLa=ZTf=Es5MJvdC=zTUWoJnASF=Mqf9+RXrnHOYDZ9YuFEtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] refs/files: use correct error type when lock exists
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Joe Drew <joe.drew@indexexchange.com>, peff@peff.net, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000003ff96063e83cd7b"

--00000000000003ff96063e83cd7b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 08, 2025 at 02:37:36PM +0200, Karthik Nayak wrote:
>> When fetching references into a repository, if a lock for a particular
>> reference exists, then `lock_raw_ref()` throws the generic error
>> 'REF_TRANSACTION_ERROR_GENERIC'. This causes the entire set of batched
>> updates to fail.
>
> This isn't quite accurate anymore as we may also raise
> `REF_TRANSACTION_ERROR_CASE_CONFLICT` now.
>

Good catch, will fixup.

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 58005d2732..2730713d23 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -790,9 +790,13 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  			goto retry;
>>  		} else {
>>  			unable_to_lock_message(ref_file.buf, myerr, err);
>> -			if (myerr == EEXIST && ignore_case &&
>> -			    duplicate_reference_case_cmp(transaction, update))
>> -				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>> +			if (myerr == EEXIST) {
>> +				if (ignore_case && duplicate_reference_case_cmp(transaction, update))
>> +					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
>> +				else
>> +					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
>> +			}
>> +
>>  			goto error_return;
>>  		}
>>  	}
>
> Hm. So if I understand correctly, we now return CREATE_EXISTS in case we
> have a conflict with a preexisting case-conflicting reference, but we
> return CASE_CONFLICT in case we have a conflict with an update in the
> same transaction?
>

It's not a reference, rather the lock that causes the conflict. So a
preexisting case-conflicting reference lock would raise the GENERIC
error. Which would fail all updates.

> It feels awkward, but I guess that's the best thing we can do. We
> happily overwrite case-conflicting preexisting refs, so we wouldn't even
> see EEXIST in that case. So the only case where we still see that error
> is on a D/F conflict, and in that case it makes sense to return
> CREATE_EXISTS.
>
> I feel like this should be added as a comment though, as it gives some
> important non-obvious context.
>

Yeah, it would be beneficial, will add some comments here.

> Patrick

--00000000000003ff96063e83cd7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b1bb095efc17e5f7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qQ29Qc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0VhQy80NlZwMEgzVUVwSDhkR2w0TDFkZ01uMWhLTwo5QjlVbTc0b0da
cFAwUVlONmFLb3UrYkM1a2xRYVhxUVVlLzZuSWhLWFpVYjgxQm1DVGFGM3BvWlc2SnhKWlhZCllY
U2Jjbkd6S3duZ1c1eFhHcGhNV1BmUnltTkhrRys1OHM3ZjhDampDZHJFR2tFZzZnZ0RoN0djVmdF
MzlWRXkKMDFlakpKSDhJdElXY0h5WmQvTGNFYlFTZTNHSWY4b1lBQjJrTXJpRU9nTzNqZnNsS2k4
NTNFdnZxVVdHOVF3RQpuamNVYTFzMnlpUXRvbzNoUXpjaS9RdjU5N1pDNERHZGV6OElWNFQzYUhk
a2kxSW5sMTdvaUFITVg4OGpOT3E2CktrSDRodWtMQnFWTjZaZTgrK1ZxazZuY2tqTE5LNlF5TjFQ
czNUTk5PNU1MMzR0ejREOEJGZzBLd1dvMytzeGkKRzAyRjBhU2dBS1M5RnhKUHlxaHJVSHVEWUhu
ZEUrY3loa0ZvSDl3MjJsSGVMWm1ncC81Ym1oRVFJYWhlZjZGQwpCdzZ2dVArcU8vYWN3Zkh0OHdw
VnFOK3ZPRUxVRExLdVpMVEoweitkSDU3dHh2b2dPSVlwQWUwNitRaG55cVYrCkxkRXNHallCRnJZ
SjFUR2YwRXMveU1rNmE0dEIrYnF5U0pPZkdMTT0KPXdnRFAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000003ff96063e83cd7b--
