Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D135E1A0
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256054; cv=pass; b=OPzFwvaIz8CHBAvTLcNqWh23xP0FJk/CnWudsLDiRfFTpqXh9HCkYB0qprpEJkJuWTGZHNioxVJOU9kWeHvV0wynFE+ofZ9KZu5r+ShXw8GXtqxDQbwE+sZu+Anee1T3VSghB2uOrbSN8IBJoJtMoCHHbVPoha32TrFxJttFfK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256054; c=relaxed/simple;
	bh=tVS42282fAFswwzr9NijTkqd56jqYsbuYmKo1mSQjuU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=gf0KUnhEN85hHG6Lu5MTNk9sLvKxxKTeDZRT1DJvm+tY5lnkGbfJsArLCaHfUDTCQ0gajKtFvSufmYe8+vPDH3ta+kTi3b6nbk3Ml40ayOqSSl8UE5bnmq+U/yoDWoPp/Lfjz7NREDrhETUOXtIANEkMHTT1tD5GjD0skAInaic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTGTBlfN; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTGTBlfN"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ab03872a64so353313e0c.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 02:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781256050; cv=none;
        d=google.com; s=arc-20240605;
        b=UKuhA1Ofz+IdVt0A98E7lXDc06QKhaTaVxup2KRSgvhlDBOAlooZ/HXaSdr6t9NLRw
         yQw7XEwK3s9Mq36R1vSuBx1+1ktmnfC/1FNE4aqdnEug0berY2hUJX5MYqrzFHooW4Z2
         KMM25CWdJ4vNKHGHDlKgaEbG4QGYJ7gwZYpElnv12tuUWUncFrPpXqJ7zVpawM6kW8GZ
         /On7WVQ9+1glMHSr3jRlMnbXJFSpyfgfHa4Gyr7Gt0dpaBQQwCTRDalTjPwDCzy9ykb/
         fp61VXdBgNg+efvoulykH3FelnF5UeRrK9OwPYhS3mg3K77Mq0CQC7zxjudF0aGisKLj
         MxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=bpR00dsmjtoEnrBKwydcfFa5wbuY9IDuRwKcJMKSbVg=;
        fh=TlS1X/4+BAj0H7/WyyI5Wqi2J/R5LHv0MbnCr9s21vo=;
        b=k9WSR0QklolorSE8KqqQ9BwpKDTpcVDmympzmvhFxJkKnRPyJa+zgIvDVsjQzyFHm1
         AdUWUJWKqDFt4CVlY1UTmQ5u8gPNp+ec9q++tg1Tc/PhSyDayEqxa5GetROwAQWlMe4y
         c7MN8CCECESv5JI1yhenIdFD/AzKSkKgrhMNdyoLEqOyG8DOOG8Emkj1JKnF78NfjsgA
         G5rTjjfeJ6pyI2GBdeW+pn9GeAZNCNOobtPKu6OvP74X8n+M3FHcOYhhOrgkjrd1I+rx
         FZuUxTSuh1K7BbRxzHJPQFNUPhWchQzQzy9XF0fbtXimhKPqMLT0AZ3cfW9K6EeV6W2c
         uVXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781256050; x=1781860850; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpR00dsmjtoEnrBKwydcfFa5wbuY9IDuRwKcJMKSbVg=;
        b=TTGTBlfNQDgrq62bMwxwH250RkRdTl8UTx5f59GiQzjeQLBhAr92SozDZLEDTgdfk3
         e9F8GBBZnPH7wE6S1C0EScrxO56EBBasIQWsB9VOfArjf2VzIUKuL123T39Dhdi0J5KY
         +WJnDWCvtokmZ2hFyUrAq4KrRCApXgCm2O7FtPpt3uQCfz5UqDzKZy7TC/NpxbpQAE/0
         6FabZOtrGi8wq+AkI1ed5TxhtERdTQUJtLKYDdEg/+Mrw7wtYVyFpAnTGa4NONUfdD5I
         ickcARNOFJmXcmt1m5nbbxmzxi3VZ9Qh+Qbfwu64jykhxZuvi0zQjcwhdywQdb4CVa+3
         XD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781256050; x=1781860850;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpR00dsmjtoEnrBKwydcfFa5wbuY9IDuRwKcJMKSbVg=;
        b=VJ64KGt60c1ge4bJ6p/McEeCHktjhhd/dKn8mivsl0mK/ycqiFtwMNBII0LJgI9sYa
         E922UqKKiVU1zLjXRngNcA9znF3FahTLVjQaXremZzRemm4ko1C+CxrtWE7a4PEW3Jlk
         KpuhP/Ju7pCP1VN0ghXwo31qwwoaEv9acBNml4ufXR6MntrjvyzM7r0ZqChIeAEJ+nuX
         feDxs1njN1d1LHd4+HWpg5JxKvvEcFhu/5d6kUWtSLHwzb/SSkadAOOBVM02t8ZTV9M/
         PnuiC8iKmvGGyv69G3eVAwlMykw/1NeA5rr0+XfkEowwfgigfk8Mg9eiZWwlWt/4dUrh
         mlBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BuGMVo5XYK0oSX6A68N9B2CKr8+KodXtkogxNK3LX6CMohzLpgVu5VRi9J1YcS/rE4Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpYrF/3ph7argOBAsqc3o984vnLTmt5llH1J8G/JMVZT5pxPv
	fsgvh61dnvHoDaF6C8f/t5B9wLWTbRulRnZN/JSVPkMbSl8pzO1SqAWpe06t77pOjz5+4jMWSSL
	q2ba+FRjpZyOmFn35cdYTrrZOVnLdUFE=
X-Gm-Gg: Acq92OEB5phmxuPFeTTIBz7HOZWINr69MqKKNAWj+5p76yvdgUjzvGH9JXhwl5TmkQs
	iNY1yuXWeABplMbTTT+JvNNX9t9/Na1r+j/YiSiPNKG+MoaPQ9WzQYyk+TXOjiMPLKwVUOk3hZn
	ZiA21x8+Qmlh/V4aDDcgogBMrMf2v28alMr3EbWMJIGA42EP8FgobPAYS8ihMBeKTdpYWGIEwO1
	7OmFVlAPNme3nHvqGhMbeDNu33/9EeoCxnPJa6fAOXaNTkXklRW6lCRr2pWsmUlFSW5A9W6+O+z
	eBldaQeFWnAliVdkDaV/1AwS/hjjyV9FwDv7VhTI4NYqajTay77Guo4pw4fuwDaGdBusoR36lg=
	=
X-Received: by 2002:a05:6122:614d:b0:5a4:6b77:2d79 with SMTP id
 71dfb90a1353d-5bb6c081669mr754934e0c.6.1781256049769; Fri, 12 Jun 2026
 02:20:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 02:20:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 02:20:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-6-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-6-56c864b01c43@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 02:20:49 -0700
X-Gm-Features: AVVi8CdJPmu6fEpB7ayx4bu6SAuW0T5otgBOhmDf5lGaiQR1xCCm5x7nrFPg4Y8
Message-ID: <CAOLa=ZRUF61cp5JqXKwpNLf1BO3bhMFAT5Ph_-yvz1D9-qUSzw@mail.gmail.com>
Subject: Re: [PATCH 6/9] repository: free main reference database
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001a489906540afede"

--0000000000001a489906540afede
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> While we release worktree and submodule reference databases when
> clearing a repository, we don't ever release the main reference
> database. This memory leak went unnoticed because its pointer is
> kept alive by the "chdir_notify" subsystem.
>
> Fix the memory leak.
>

Funny, cause long ago I looked into this and thought I was clearly
missing something and eventually forgot about it. Good to know that I
was correct :)

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  repository.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/repository.c b/repository.c
> index 187dd471c4..e2b5c6712b 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -421,6 +421,11 @@ void repo_clear(struct repository *repo)
>  		FREE_AND_NULL(repo->remote_state);
>  	}
>
> +	if (repo->refs_private) {
> +		ref_store_release(repo->refs_private);
> +		FREE_AND_NULL(repo->refs_private);
> +	}
> +
>  	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
>  		ref_store_release(e->value);
>  	strmap_clear(&repo->submodule_ref_stores, 1);
>
> --
> 2.54.0.1189.g8c84645362.dirty

--0000000000001a489906540afede
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c945f42038e68560_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEpCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vcnoyOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEQzQy9pMjRhbDExMGRVM2FpRE1acFpkb2dQRU1WdAp6QkszTkNJTTI2
TUhFSWdQem1rMi92QkxxMHFKdHBEd1B6b2ZlbVBmOGN2STU0UjYxUW4vNUcxNyt6UjZrckRWCm1s
QTdOeGkrcTZOQW9IU1pHQ2RXWFNpZ2puVURIY2lCa0R3VVgvdTZaVG13ODBPQjdhM1JwaGJFb0JT
b1JNMm4KYXh5bnloZ25saTR3aTZlSElSRjZpL3ZBVTI5VlFwN0RBaTdjRHJuTEIrY1BWK3hCblBS
MGVHaXhtTGNnSzNzdQptQTJvTFlQV1J3a2xNNit0d2ZJajMvZUljYTBsU2ZpZEd1aDZHYTFObDI2
bDNZN0Q1VVVkZ25aWnN5TnRvNmxmCkhhT0NZbDFZOW1BUnVtSXdEWnRGaDhUd1R3cG1FT0xzKzN5
RmdXVVJDYko4bmhIOTQyeVF6c0c5TUZUZjZLamUKZmVJM3BwVnZyV0xPLzNtcmQ3TGMwbytTZzFs
Tkk0eTAzRW5pOWVvNGszMlRTaVdNMUNTYzFaZE9kWTBmRFJOeApSUldBREZOZXhvazRmdXFxTURx
czh4QjZqYWpOZlR2YXRSM2NSM29Zakdjc244dklPRElkVi80amVFRitsYW9LCjYxNVJ0cmI5WkxG
cDBvWU05VExvQytsbnFSZ2VvNTFZcXJxc1pnPT0KPWUyS3AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001a489906540afede--
