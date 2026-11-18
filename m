Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795001589;
	b=N4/2rwhvTadoaH3qzi9dDyNWnyMgMuumGlMvoVieN3wcDauW+BOhYNOAKU/sFh4yB/bd
	 X4Glu2uHWzv5OmdlOq3VP3OYhIEpJ6WoIRWwj9Rax+3QJoMDGy7CzF0K6e1HLCC5a7ZAs
	 PHewd3eS86C5DgXECuHmJRNP0sE9KYQ/hMOmczYkmsUWobeIW2bunmf5OVCB3KcE4j6Lh
	 /mfk2ADA5wQkDEf4MKo3W5aaISKpqeeEh2ppjtkyxjQKkwWkW1ga7fdELu80KR/2efEOf
	 zo/MmOxKoy/fLyKjFio8019AYPDkm8tPOyxK6eK75ndSI3yyVL3KzyyrVoJZu7ZE+xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=4E2/JQtRcvxkbPH/TADlelLEU27UQpiBs+Hyr7hE6es=;
	b=ZyqWhD0Z5JC4sJy0mZ55qOBKU46NC5LcBU7wITp2lesnLnYK9FQVOJ3GCo6TO9I5fKBu
	 xTrauxjAjjAYapkLZbcmDwPaICe9npyRAA7kJq0cOBL+1mUQ2NPDjL/nRkipHfSsOb2T3
	 4MlCcF4xh49EVuCOE34BP/Sd7YCzag3R22UPmSw+jzj5Z1lMfwVoqvWOu0s7bp2bIkYLl
	 Ttox6eCourli7Or/7chXOyNA23Mc3IWPEO9VaXSufkIPQ5JhY75K6BHWfmi2LD0gSU5Aa
	 GBM+ZxTOPJQZ390ChN5BoJLRZlHbClId/+bgozq1/ldaS3/H/0lEImmysA2aI4EOPkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wJe6S0hE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E274606A32F
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 11:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E274606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wJe6S0hE
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so590909e0c.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 03:33:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795001588; cv=none;
        d=google.com; s=arc-20260327;
        b=lB4GWVfgu7Z7ueYAKF4CdSxhnkvCj1l5TpqMkWb40TSYMvpiy4IxD28X6endARUema
         StWrHyPa98Sx5J1gMQvXZPs8cTvuOZ/BK34Fp9lWRRlklDeaSFlN6QjmR48FTD1Jzb3q
         yB6xYHgQVoS0xT00uQVMeo5wjRt+4mlYRhT/JQ6jr+u2W2bYI4t4/dMbhF9E2NLwBQ66
         Xmwv5VrrLzafmi8SdDSRPfvYhvM8UcHBfDX1EC/7rHjW5eG8Nh6gIStSOpRxOh19Dzz3
         yJtk1Nk68qJ0OsAVWNfKKRigKKVgPQ0watC0e9jRpRnkXnHaN1QSrTZ6Hs/QO87JqOqI
         Dimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=4E2/JQtRcvxkbPH/TADlelLEU27UQpiBs+Hyr7hE6es=;
        fh=rxPcrm0RwnV70tmaO7acw1Vi75GQVI36tB3bKGpWHfY=;
        b=JdAWkStQZHDBkxFa1o5zQUcxPsMYUp7Zp12fzZQk7K4cYiA7Dwed3V6D2R6C9DiXgd
         m04wnO4yyFR2Z+6foUounifeAZLT+Jkh5o5xSS5Xw9m0YYSvPZ8JEzFKaOkT4TymWTYk
         O+mbAtS3BOaOAsR4+XntkJFP1iekj0/jHTc4RkHa5kEQeGckPTG6SY7ENkM+hfXRSmB9
         HseIOxq2fKd8zi0+N5L/yEbM8/4a04cJMzeuia2ORww62iUibvQDUbHmKrwaoVvW+TJ9
         MsSHy89bn9UF1W+UbX45VZt3FcDpETdR5xbyps+xrD85D/0jhYvjoOAK/H2uUl5BuYVM
         XWKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001588; x=1795606388; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4E2/JQtRcvxkbPH/TADlelLEU27UQpiBs+Hyr7hE6es=;
        b=wJe6S0hE3S7PXvTIGzWk0dcsK0pVz1oYz5eTa6W+369IHv+ExRPNkIR0n0MJiEKikc
         S017Ux3KDIboOowTaaRUD6e41jzdWklTWz1qCJU2yDKBAnL2TWVUneWd+clLuQgo0CYB
         eS1B/O0Z6/QV5kNoIsnT6ka0ytHLZDX2ciOCn5qsQiCKITwL4DXxR3tvLDPJQi1fl0Cl
         w4nab2Gkc9f2dQ8eaIrxS28ifT5vHy8KNbvmWNs82L8MP/PJUxKxgNN4tdjdFeLBftXg
         pUolFYeZK9oCRtirS0/QfnHZid1BWtU3SF4HFfEXZn1hI8KSLoELpdJ4zXgv+AsIOjVn
         Lwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001588; x=1795606388;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4E2/JQtRcvxkbPH/TADlelLEU27UQpiBs+Hyr7hE6es=;
        b=ba2UIyjzTNicYedJdI71HSDW3I1LxHp6Cgq6KlIa+SQSlLXACwHmiD0HLvVsECVdLZ
         krh6gN+j2Wg5eq1xjWYSC59cTf9gSD9GNyZFsMxU9L0RZO7+S//ZbzGTv0AIdVw1j7ue
         C8ktZmFlidFPwmEcQxAIE9EnaFnhWdOd4p2Li1P6r0WF5grj00WhK7bssFi7U6gIwnWA
         mex4U0FfKGJGL4yGRrjgmnTkCQRUWUqaHr6v/DHPgC+3ar1tQcbiz4XfBVo7rScivcjp
         T+UtfgLaiGz6ETI6pqC38XceTD5GM03GqpIi7tIt0Uf5n+ypBlZtTnfHkSk6DGYkodaM
         hmxg==
X-Forwarded-Encrypted: i=1; AL+hErEYcNM7unScX3g5lAs4wIsxTH9iNeZ/cFuC9I2Lcgvwobap00+zZdDSHTnFsSuBhAuy6sg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+k7uUnhYrEYcru/ZQ3EPqiqd4MCPRBZyDhGxch4MTqgC1kwUE7
	az+h60R3Qw2xs04fg2jVm8R9g/hzlS4F4tFlAXMKNxAadJjTVSWye5iSMXNDNndNBfVJR8HpZsE
	2li6Op6qIRb0UxUWNx91+YLs9dbqWSI1p/w==
X-Gm-Gg: AYBFou3/PU/+J+3M6Xqc9NPUPatqdZDHIeBSA35lPIAXORMYElNy/sLCKa74V7mlNXu
	aHOLU7PCcEOpT26kdtNr+5nwAWj+rVOsKONGIDExByj/l1xZODZiEUc43iO9f1jPNYlSEqJ83SH
	BbxBqKgFASM6T/5DgHND1bSYg7Daw94H0P/I7POY9o3PQK8RgPKUF1KLT5GUuWsVX1OzB65O0w9
	mXswJsFWlpHnkmEVqh4ujglhVZ3Vr4CtAvxT8g06kruCgJsm7PdMZac+oTS/EQd05eyF4iAskpk
	G5p6ZI0wuC8rHuxZUV1KOFKrsBz0G57c8I6TX9rkIKt6FbFlQN2QnF2hUsVkGN4ZkEcVOYRcELH
	/RwtqTuYJi/IVPJxrac83BJzW+DZE1EAdChjNtMcuBLySnU+ZEb4T3GAWWSKCoSaMY1JS6Za4U5
	4sVmmQB6veX5dKk9LMB0okjRKRMQ0=
X-Received: by 2002:a05:6122:488e:b0:5ec:e237:b17a with SMTP id
 71dfb90a1353d-5ee647076cdmr1164947e0c.15.1795001587911; Wed, 18 Nov 2026
 03:33:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 03:33:04 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261118-pks-reflog-expire-performance-v1-2-10b9263566a8@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im> <20261118-pks-reflog-expire-performance-v1-2-10b9263566a8@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 18 Nov 2026 03:33:04 -0800
X-Gm-Features: Aa3M54pLiJcTMDpgrfnAEASx2cCJiOuchOxsjo2tp82eQLB-WKZjnhB9AxjNqQE
Message-ID: <CAOLa=ZQGJkyVY=e94hJVmLa2fuPVUfC3uFRsQTeoa95sUe3UcA@mail.gmail.com>
Subject: Re: [PATCH 2/4] refs/reftable: don't write new table when expire is a no-op
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000004f00906608b60ad"

--00000000000004f00906608b60ad
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 4216a18684d..e2027bb9c02 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2607,6 +2607,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  	struct strbuf referent = STRBUF_INIT;
>  	uint8_t *last_hash = NULL;
>  	size_t logs_nr = 0, logs_alloc = 0, i;
> +	bool has_changes = false;
>  	unsigned int type = 0;
>  	int ret;
>
> @@ -2696,17 +2697,25 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  				    logs[i].value.update.message,
>  				    policy_cb_data)) {
>  			dest->value_type = REFTABLE_LOG_DELETION;
> +			has_changes = true;
>  		} else {
> -			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash)
> +			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash &&
> +			    memcmp(dest->value.update.old_hash, last_hash,
> +				   ref_store->repo->hash_algo->rawsz)) {
>  				memcpy(dest->value.update.old_hash, last_hash, GIT_MAX_RAWSZ);

We can skip this second copy.

> +				has_changes = true;
> +			}
>  			last_hash = logs[i].value.update.new_hash;
>  		}
>  	}
>
> -	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
> +	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid)) {
>  		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
> +		if (!oideq(&arg.update_oid, &oid))

We now check if its changed, makes sense.

> +			has_changes = true;
> +	}
>
> -	if ((flags & EXPIRE_REFLOGS_DRY_RUN)) {
> +	if (!has_changes || (flags & EXPIRE_REFLOGS_DRY_RUN)) {
>  		ret = 0;
>  		goto done;
>  	}

Nit: it would be nice to mention that we exit early to skip writing any
new tables.

> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index a7027458395..d808f1887f6 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -912,6 +912,36 @@ test_expect_success 'reflog: expiry empties reflog' '
>  	)
>  '
>
> +test_expect_success 'reflog: expiry without changes does not write tables' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		test_commit A &&
> +		test_commit B &&
> +		test_commit C &&
> +		cp .git/reftable/tables.list expect &&
> +
> +		git reflog expire --all --expire=never --expire-unreachable=never &&
> +		test_cmp expect .git/reftable/tables.list &&
> +
> +		git reflog expire --all --rewrite \
> +			--expire=never --expire-unreachable=never &&
> +		test_cmp expect .git/reftable/tables.list &&
> +
> +		git reflog expire --all --updateref \
> +			--expire=never --expire-unreachable=never &&
> +		test_cmp expect .git/reftable/tables.list &&
> +
> +		git reflog expire --all --dry-run --expire=all &&
> +		test_cmp expect .git/reftable/tables.list &&
> +
> +		git reflog expire --all --expire=all &&
> +		! test_cmp expect .git/reftable/tables.list
> +	)
> +'

Nice. Could we add a similar test for the previous patch too?

--00000000000004f00906608b60ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 73f2657ec1ecfba9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yOWpPMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2VCQy93TGdrdDY2Y0FTRit5L2MrOVljOHVFazRhVwovdUVpWkhQL3M5
ckVrWit2YzBuTzJCdmduMmFsVmcwQ1JRMnF0TlZHYWwwdnhQeUpDaEtNT05DSzBmYnI4U21VClV6
aitBbjJHeDl0ME8ybXVSSi9jYXZ6VUtKTzd2Y3BLQjNaRjhHSU44TlVjZTdQajRWQ0x6SCtHZkJV
Y2t2dVYKbmZvNmk1d3Boc3hMU2xlU3MrU1lCcStMZEo1MlBJbDFFaW0vcmFaaHlXVnlJejRQbTdq
VGZCallPejkyOXZMcwpQTG5IeFBuV1RSdnhzOHNySmZBN2Z6Wnd0WlpsSUdSQUwvNnpLTndXR0V6
QzNGL1pJZUR2SG5KYi9mREVTNFd1CjJUcGs1em9va3ExK2djL2R6WWFrSktOWVBZdHN4eUpLK2Yw
YlAvalJXd3N6ejFadWptUXluVTZadUVRZjNJYUUKUDVMTDFyNUZpQ285Q0pCTllWMWQzQUp1MHVH
cmd6azNKQ3JOaGtGbGJMUGZwOHFJVU1HYkJreDNaL2YyYlZhbAo5M3pmbFZZNFo2QUJtVjQ5Rmhr
alNzL2V1T0oyTWhRMmQvKzlZYW5KZ3ZUT3pXVFdDSldUWmo1dXk3OVlnVWt4CkJPQ0N5NU1naFhB
elVUVTF2Qi9GdzRUUDFtRkoyVTUvOXlZaVBRMD0KPWtiUkIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000004f00906608b60ad--
