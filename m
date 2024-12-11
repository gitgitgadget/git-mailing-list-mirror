Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08971209660
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912334; cv=none; b=nY4B+SlWuP6Ojp3fNCAKVb3tg6lthGB9b84krmO7luYNDK1X39TJQmB4vPB4rH/nmJM9hG9Py/20tEwmff0PEHo3Lfow3cvg46T2WcqXScItsTGwbhZwaZ4tsGqRqUakb9PuAeu+lfSKQLtCY3sowT7TxX14IBCVLL4Qa4A1oBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912334; c=relaxed/simple;
	bh=Bzjp6ZEgoe9ghXIc9HbgobQaowD8nBbOBj4aQednpr8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlB0Ongv/EquQfgy24HlUecHgXKLf0qVsnCauW8NY9b+6yRliYonb1YsfEjo6mHe60ITQH7NpcCHu29kJtd4/qHcF/CbsrRummFcBkVOeRMOeAZagOPsj3HK69D4H9fZmMf4f3PoL584qayJgQQH1fICCHS6NR3qIwIkS6JqOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHbhMIcJ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHbhMIcJ"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-85ba8b1c7b9so351080241.1
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 02:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733912332; x=1734517132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pP+F2O1hHGmXHR0IYb87ECaoCStdpwSw6k6opqSIg9A=;
        b=SHbhMIcJEyYJmpGAQFzYiLle/VoUms2keHH3mvh51OALRPWy7AeniCX/Frrha+a/uB
         3HHureefPJbY1OzhLLUTvhFZfrl0dushD/vrJzcvivXOndVZe2fMTb7KPKhEPYBXx8Xg
         eFezwFQfvD/RAdZBmc2TnDr6un8lJxSBbwL1A2/OAUdXtYqgF1bR/QTq6aFgjAW8L5kM
         fEJZgWY+KYehYg9rHfpkudGAKGFVptITy4I3M0IKmjr5etmwrjpv155fpHqNkCiZIih5
         8KU2G+xtSgD3NFkXmvfHyJLUyqOMS9whEF6joSFLsObnX6D+RtHQQ6QBLo5SuqdbccZW
         E5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912332; x=1734517132;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pP+F2O1hHGmXHR0IYb87ECaoCStdpwSw6k6opqSIg9A=;
        b=N867x7ib1h/VyuRBoiB76PSPkfYVjCFFG068i03vyYp2mMhwukBU8ZQ442KVsJvYrN
         TtwjYNK+3hxHF2NKFzekIMMEZeODJ6dPuOjBKDB1BCWw19m+8mr/XnVV9svEdV1Kj1tc
         puKdZZTKmNGYjJZOYEZ8AmnDCuM2eP5YqBoBE4FVwUzzCc0JCl8tX5Yu39C/+1HN7Pzc
         4JoozBQzu54yZLL3W4xzQ1VqQkszoAioTqRPlDUK1myLtBlCrItpCnNLlbkIBMlH/FLl
         I9VhFPCuViXkvB177uffgsx7eeQoICOIiYCngJ3EuVHldgKgjwk2xa9AXTiALoIpPjLT
         rVnQ==
X-Gm-Message-State: AOJu0YyH9bzfJiQKCsDCvbXcwt38r2FwtewrXN1/mAFuU1iMXUfMTkIh
	3Wj6mOunRruuCHz8Co56RUr4kTf3fKkbns/+da2/fwp6YfP6e7rxh2Ou5TYBEizyq28wUfyNMdt
	ggToGRz+rrPw8+KWtgGdkuCr7OCiZXSL5
X-Gm-Gg: ASbGncvdu7T+As/Qj6P2oju+X30HjQGLwN4gz7YDKv/NPTwgeG4nrpPgMof3SfN+mxm
	PPw7QIQ2626FsqdKZ8Rr8gcGz3M2msCp7f4ceKrqpQBaH7mFQbcqT1SJofxnaSK/ZZX73qw==
X-Google-Smtp-Source: AGHT+IFFrs/mePiHQV2pI1MCH75mAQV9+apH6ENSDoWxWMRQhw2aj7ELFYKl/WJ4n9WnThkpua+C8yZZX8KrnWeYdcQ=
X-Received: by 2002:a05:6102:5087:b0:4af:ef82:ce8d with SMTP id
 ada2fe7eead31-4b1ba223422mr1266954137.0.1733912331844; Wed, 11 Dec 2024
 02:18:51 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 04:18:51 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD0UAWib-GceEQi+ZzbosRcvSRbq-DuMLVVr9xuf8C03ow@mail.gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-3-d4bc37ee860f@gmail.com> <CAP8UFD0UAWib-GceEQi+ZzbosRcvSRbq-DuMLVVr9xuf8C03ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 04:18:51 -0600
Message-ID: <CAOLa=ZRuuS_TW=BPeC36eWfgcYegT5hVKd+pVLG6TDMMjJ7tsg@mail.gmail.com>
Subject: Re: [PATCH 3/7] refs/files: add count field to ref_lock
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000009cca500628fbec54"

--0000000000009cca500628fbec54
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Dec 9, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> When refs are updated in the files-backend, a lock is obtained for the
>> corresponding file path. This is the case even for reflogs, i.e. a lock
>> is obtained on the reference path instead of the reflog path. This
>> works, since generally, reflogs are updated alongside the ref.
>>
>> The upcoming patches will add support for reflog updates in ref
>> transaction. This means, in a particular transaction we want to have ref
>> updates and reflog updates. For refs, in a given transaction there can
>> only be one update. But, we can theoretically have multiple reflog
>> updates in a given transaction.
>
> Nit: Giving an example might help understand where multiple reflog
> updates can happen in a given transaction. Alternatively pointing to
> an existing doc that contains such an example or explanations might
> help too.
>

The use-case is added in the series. I've added a note about how this is
needed in reflog migration.

>> @@ -2572,18 +2588,25 @@ static int lock_ref_for_update(struct files_ref_=
store *refs,
>>                         goto out;
>>         }
>>
>> -       ret =3D lock_raw_ref(refs, update->refname, mustexist,
>> -                          affected_refnames,
>> -                          &lock, &referent,
>> -                          &update->type, err);
>> -       if (ret) {
>> -               char *reason;
>> +       lock =3D strmap_get(&backend_data->ref_locks, update->refname);
>> +       if (lock) {
>> +               lock->count =3D lock->count + 1;
>
> Nit:
>               lock->count++;
>

Will fix, thanks.

[snip]

--0000000000009cca500628fbec54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b0bff164c675f0fc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kWlp3a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0tkREFDTnhRLzlnRzlZWnQzZERKbkhERWdHQ2p6SQpyWEI5Y3I3U0VJ
RVBnOTR5R25jb2UyVDVHYXhhdmE5a2NJQStOQ2RuN2c4b3ZyNnhjZFdnN3puQnUrL0EwWk16CmhZ
TjgxTEk5WnQ0endxZFlDSkoraEdBcjBIRDJ6bFZTbStrYVhNSDhxMXlmNFNZWGxnQjlaNURFdncx
cjdkcHAKL2cvQkpaRVZVZ21YTGorRit5aVY2QlpLbFhjMTRJZSt0cnhNOWZ5TWtRWmQxNGhlTGk5
anZWdS9aYTZ0WXBFNAp6ZytuVEowMGlmYjlKMFRRL2s5SnltY2xxRmRnRXN1c29HWjVkZlhnaDlS
M1NmWFcwZEZ3QmxtTGR0a0dYK0JkCm9BZnUrbXN4ZXJEbStRenhWZC9rQi9VQjlpVW5STFlXTjVS
N2doaDJTSzVpTGNOZjY5RWZXSkdYdGtSWm5mTEcKTGMrZitXZ2pCMU9paWc0dGJLTFBFakFjMXJs
bmYwTzhaV25COWpDYmpFV3A4dFJBbmwwZHRMS2IxMTFvdkwxUApQNGFuQ1dycEVaZ3BYbEdvQUJM
RzdOMkVzU3lxeS9xMWxKMnBjY0ZjdTNNZkxaWlMzTUk4T05NVHh0blZoRjdPCm5TMUZWUmEzS1hW
NTErbzVPN3Bad0hIRjduOFNNNUwxTjBsVlJBWT0KPUVSTUoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009cca500628fbec54--
