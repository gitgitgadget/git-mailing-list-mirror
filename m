Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D54193402
	for <git@vger.kernel.org>; Thu, 15 May 2025 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308999; cv=none; b=AIZS9GA6S/b4PcnSYuTrJEmB8Ne7dFsjyof6gXe3FNjMcloMlPQLk7noqTOKoYN5eWHN8ghEbqY91JAsUtHkfNm4D6b/aA4ePxL8WyShX1WgPm7z+EfvpbPFZ0jQFnrips+IyEOftcp/6SYV8nTRbaYSGANp2BsKxjeDLA6JEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308999; c=relaxed/simple;
	bh=GV77cZuoqri5QFPVAz8y9q5n7VvHh7rMz2BNJufLenE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DspGXqGZRW2Zv68S1B4n3gEt0aQv4T+6e3lFNN6wci0HxPnOPWHJemoO1weO8F2w2iYFyjcvpJ0jFqCKQEK7T+T9Arvwi53DUJ8gBof9xNtB1WYc/oDT5NC3f8Leh/qC0WW+sS9eCQh0y6hvw0cmS4/BS1hFg+ltqxBjKmYe/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/SjDk1d; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/SjDk1d"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8783bce9f84so204404241.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308996; x=1747913796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNZnEjCrX+vL3kJIIVuh6nbisbGAYMFe8tSdZkXPM9Q=;
        b=K/SjDk1dgoHEdJze7BRdx8zRxbzcW+2hkIt1u+IhaQF4OZGBVmol8CH9CQuBfooImt
         RJqLlbTK9PZ+MuLd5IjyAk9qtYXmgcFp26OWvTCgiLkFF9kR8RcvKL5aD7Fye8vXOSXV
         Dzwk/SefB54U4wASd1mV3X+agm4D6/fXZCZeG03CyUvfYJfS5L0z3e0Z/Emy+6c337QW
         BM4NNop/S+NsXuN7K88A3vjhMOzk4gUg2Wi/BCBZ7mL6E27uAtCsf5cRbVrmx1Ps1c4f
         p/INX8xzuNM8pV3LZV5rr++iLm1tSYVkS1ee1g3ngvL2sfN7bBAAPuz8y3ioqBojG05z
         krFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308996; x=1747913796;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNZnEjCrX+vL3kJIIVuh6nbisbGAYMFe8tSdZkXPM9Q=;
        b=ejphDB0C0Sh4vjTTD7dkwr1TYcvY/0zAiaI2bwtg2+iN5i1HcgmcZpfqANehzKGxmn
         ZQ0Di6070XK9iZ3b8JfGThQNLuhFoijcOpJYSydo/VOeBjUmSDXBvSTdlADNyufQMQ1F
         wKWM/wf4be4iIjgt58g0d3SUoJ0/L+4PDGIHbszwmaLCUAHEWCdATmgu7NilC8SAGseG
         isvXB0nfQCSpI9bNbSsaWvFxGBwkQOjaN6SPhiMSyGfw7hHQY1PusDkjCsGRCjI1e3PG
         4ZJW/xbTZqqRAYlvGAi+QDhx+Wf7SE8VdlY9ugKRS3J1f7VMAQvZoYeJ8XvGcESynZ8S
         M8ow==
X-Gm-Message-State: AOJu0YyXxvz1gi4Vp/sNqb89y7tOtMsbM6mezrxtXtj32BGhnQD4noaY
	ysremxhZwWwvHGHF14WARIrmyHvYKcdwVB7MWAl8CjO6jM39hU6KBthIhQes4bwNDI1jdT/xNHF
	ZjF5hUbkppoEQACQFoYF/CEku1QE=
X-Gm-Gg: ASbGnctpF7WCLBRbyY/m8QDGGjCI9SdVhxCi05RQhxIaPvzsQ4CLNeIXljYANjhoAOY
	qTjcCWq9aqHxKrozG9VoLEXVgqsHV05cnG80DNobRv+a7sKM+oJ0r/kFDVln8CWaOHiAFOUiByi
	xnj1bfarBfeWjwQfMew9tkS1I/ElffmQ6fA+kBNZS7lQ==
X-Google-Smtp-Source: AGHT+IEVrf1n9BURDJBiDsmyJzMBH1rgnPzGmhcu/QnFzr882BCXDvWH4ezoUTe4j+CZHPAAW//fKQJ4a+qsN+n63mQ=
X-Received: by 2002:a05:6122:789:b0:520:4996:7d2a with SMTP id
 71dfb90a1353d-52d9c7026edmr5383500e0c.10.1747308996158; Thu, 15 May 2025
 04:36:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 04:36:35 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 May 2025 04:36:35 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aCXQcSsc4p6u9ljZ@pks.im>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-1-7c65f46493d4@gmail.com>
 <aCSNFMeh3WMav_Rn@pks.im> <CAOLa=ZRbEqs6X1KJj-CikCANX-BC8r4RqbwoT06qmtF=x+7hQA@mail.gmail.com>
 <aCXQcSsc4p6u9ljZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 15 May 2025 04:36:35 -0700
X-Gm-Features: AX0GCFs3qbrI-hiWbnxZ4rrwj5T9yBRlBJw5JchmGqzAnqK67Lr8Q0iAaFhasUs
Message-ID: <CAOLa=ZRbrAwk_+P3Y1dXxpTw7Yuxbge6O53SoD-Y6KXsNW+7UA@mail.gmail.com>
Subject: Re: [PATCH 1/3] fetch: use batched reference updates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com
Content-Type: multipart/mixed; boundary="00000000000007866906352b143f"

--00000000000007866906352b143f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 15, 2025 at 11:13:32AM +0000, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> >> +	 * since pruning must be an independent step, to avoid F/D conflict=
s.
>> >> +	 */
>> >> +	if (!transaction) {
>> >> +		transaction =3D ref_store_transaction_begin(get_main_ref_store(the=
_repository),
>> >> +							  REF_TRANSACTION_ALLOW_FAILURE, &err);
>> >> +		if (!transaction) {
>> >> +			retcode =3D -1;
>> >> +			goto cleanup;
>> >> +		}
>> >> +	}
>> >> +
>> >>  	if (fetch_and_consume_refs(&display_state, transport, transaction, =
ref_map,
>> >>  				   &fetch_head, config)) {
>> >>  		retcode =3D 1;
>> >
>> > Don't transactions handle D/F conflicts for us? Isn't that the sole
>> > reason why for example `refs_verify_refname_available()` accepts an
>> > "extras" parameter that is supposed to contain refs that are about to =
be
>> > deleted?
>> >
>>
>> My understanding was a little different, from the documentation for the
>> function:
>>
>>   If extras is non-NULL, it is a list of additional refnames with which
>>   refname is not allowed to conflict.
>>
>> This is to capture additional conflicts. We want a way to avoid said
>> conflicts. That said, there is a 'skip' parameter which does exactly
>> what you're saying.
>
> Oh, right, my mistake -- that's what I actually meant.
>
>> But the transaction logic doesn't incorporate this
>> entirely. Specifically in the files backend, where we create a lock in
>> the filesystem, this would cause a conflict, consider the following:
>>
>>   =E2=9D=AF eza --tree .git/refs/remotes/
>>   .git/refs/remotes
>>   =E2=94=94=E2=94=80=E2=94=80 origin
>>       =E2=94=9C=E2=94=80=E2=94=80 dir
>>       =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 file.lock
>>       =E2=94=9C=E2=94=80=E2=94=80 dir.lock
>>       =E2=94=94=E2=94=80=E2=94=80 HEAD
>>
>> This is from the test 'branchname D/F conflict resolved by --prune', the
>> test prunes the existing reference 'refs/remotes/origin/dir/file' while
>> adding 'refs/remotes/origin/dir'. In 'lock_raw_ref()' we lock both and
>> read the reference, but this causes an issue since
>> 'refs/remotes/origin/dir' exists as a directory already.
>>
>> I would say this is logically solvable if we start treating conflict
>> resolution within updates as a first class problem. But perhaps that's
>> something of a patch series in itself and better solved outside of this?
>
> Fair enough, makes sense. Might be worth it to add a TODO comment there
> then?
>

Yeah totally agree, will add in a TODO here.

> Patrick

--00000000000007866906352b143f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 814c72a65aefd06d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbDBjRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3dLQy85djhIMWN4VWhwQlhXRTdyY1ZNTHIwbVlFTApPdC9BdWl5QjA0
Q2FLNzlyUXhIOWpoZmUvcktvdTR5RFVTWExlc2t5UTJpOTEyaVFaQjA3M2JoaDhmaGw5QUpQCjR2
Ly9vTk9weDZpR2E1OWlJTWgvK3d0UklJc0JnWVBZQ0svZnNLNWZZTnZpb2NkYzE5T21SSXExWllM
ZTlGekQKNkg3bno5c3hWV3FEZ3AwcTF4a3R1NVIzQTB5NUd5UTdCaExXZHV1c3FST0pNMm5DN0lX
djlMai96KytSOFNWaApqZE5QZWFEaHlWL1FJeVV5RzI4VUVvazNoaFVqckNqYUxVZmpTS1A4T0ps
NUl4cGFJL0pqVHczbXZvUUFtajQ4CmhNYzNNa2hGSnk0U3ZFdDU3Qmp4cDVnM0YrODcxbjN1cDhj
K2R2a2RxZEoySXZlNkhjRVh4SythMXE3M05jOGoKa21XTXBQeWtFVmxJUVBmWVRhWXZZRng4US9t
UDliVElyV2FOajJlalBtU0RVUGYvL1J0V1lPWmtYamxjNmRidAptSU1CU3AzVXo4cFRSYkNJaEk1
QStwTGh2N2FzY2xzZm9GdFB2bkI1RXB3cGh0TzNpbDM1R2U2MzZsMmx0M1pxCjR5UHdwakxnbzY3
RXl5U3N6R1lGVnRHeTFxL2xUTG1TWTNhNnhzTT0KPUNqRDYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000007866906352b143f--
