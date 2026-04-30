Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC83164C3
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542740; cv=pass; b=r7Lw/Mq4A6gxrdDX4T01w7Ut6+Nakta9AbWLl3mFi5w30nOl/DI91eB7BF8pgWhEe6Seh4yY5Kh7A86vhJXqjgQdWEEYXK8ASkCz6gkw0TeiC+SkzagzeoiIDxn5W9YGIIswN29833Wc1pnBr7eCyqqShdy8CWAvaOUgB/CYmQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542740; c=relaxed/simple;
	bh=e7K0+UNW2tzpiN19ZGkVcTRRuoFPZiMOklLIX8hLPcM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMCwq1WPTf4EVzpbCj+fIm/waXC954d51RTpToXL/BwLVcg0i3a4fBMw6h774SbLgHKUwqnXAEwkOiTi+/3BByYyESUF/WFX6nfE2XKMxAicFXyVD6uPqPoqfKuPYa59myBraDLT4+rZ5Y7e/m6pFWB5p4WF8beFdDNrs04HxcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRbCXZsg; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRbCXZsg"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso450602241.2
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 02:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777542738; cv=none;
        d=google.com; s=arc-20240605;
        b=e7pNsdorW7sA20rVxGSa2Xbv64g5KUAnFR5npYhP66BoLxmt3WTkgyQAtyWfDVGn+h
         27KFmIs9S9DYqdVEG9Pz4mHIQ4ngZDFtDqBi4PaHd99ZWQbveZbJldN2t4T5qKdohK7y
         Vu/M1CpL9XvZ9Ennr3HRanPs2M0UmISG1Z3vhEK0jo49C9zKzLRn5sMamEWlw/i2FW86
         uGSJrNHe7VoipOle9KPchRVSSE3mYz87yEJkQ6SiFpCD7OavhqIFfEyWwNrZl0Q8il6L
         gcGWcnq2RDXgKCtrRleAkeGg2RXZRcSQ5domRbs1eliV/x9zjmD8zOYUZJ95BIXFwGzF
         KajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ysD/NQL5sJdVYU7LzJ9JIKvQMWN4bvH4UB1q/G8EO1M=;
        fh=CXjOW4ncwyQiq1jOOKNp/MxfwETfRm8jQw46qrw6aWI=;
        b=lcsQtrUUhKeZ8a3NuVlfoWcauaRaSNqKEwKCV5uUDDrNqVgI6Uh6xvLSZs3zL7IyJA
         pOF7YEp1fmk5yZrbIpRCiCd4AVrwQBiGsD2PgIas9WZEjnFmo9/XrNeaE7S+Xecg2Dk3
         OFF4paeF1eKB0cl2XE3rydgPMrTWR+ns9V5aqBb3sF3b+6kM/AJb7r+AuBrRNmFWWJ+l
         mhAKhh/gjp8WaHWIHEk6BCiv7v1LUMCHPxs+1TAf7U1IGlC7nqV3jeyqhz/NN80pRlFC
         ZRJ7FAj4JILFgRMZ3kibMxfeVzTy7Sqg49hEFMS+MbXL2zb1JucF2cz20XiRkxmJRE2U
         2r9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777542738; x=1778147538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysD/NQL5sJdVYU7LzJ9JIKvQMWN4bvH4UB1q/G8EO1M=;
        b=GRbCXZsgWHgBXA5DtnrDt8UZZSyyMHKhIvdJGOUnrsD8mCq6peRcd16GAyEFT1f+3s
         J3229yqetuN0LlChw781AGsralXGrimE9v97Tt0mr6xdRZAgLAs7j/wIQRHspyfcPwbb
         UpJtw7WZsI9Yx5ex9cU961nMCHF+iwU1zfem7av9OCGhTSl8yc8qFKq+Ad7m5rVf6ugs
         Pi3sRsaDKAiV+nLw5Kfc5WIUWiPzwVclYTNOHMWqpi5DbnyT82VqD/h8bVCUDR6awyOI
         gC26hpAiXisIaORFCtzTMZJczZDpaTsl/Ko6gF+9D4FEs10RRGfvaIaykWKuQyL2XZZQ
         G4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777542738; x=1778147538;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysD/NQL5sJdVYU7LzJ9JIKvQMWN4bvH4UB1q/G8EO1M=;
        b=W1o5zLH56zLucqss1/PT36d8/7siKUGM6LNTP/XeqUwsnpmTv6L3U3bkpdmvrHQD67
         86xZvtfJM6mKZySkKOabvck08X/eNsZG5xqtDzhJCDrIF79ARle3ri5LMu1MvZ/soePR
         f6+YHYPbIA23Q1/6Tg+Yi0oCnhoaimkAtcVKhQDQlXytN9y+ChmoSjoFC091y+NRdIIu
         Zzhs2UTK/76zW6Lwt9gL9cNqThx34ZlqxT8+LPopy80oDT9zXD3oOilVAsYGIO96/AbE
         VkO/4KJY1vrV2I9E9gLeGy0C85pZIZGxv3tmsiP39AtSerh0/dSUjZapbxiuKk8ZJL9p
         2YWw==
X-Forwarded-Encrypted: i=1; AFNElJ/V0vVEvcILHEQsUUnbavMVJeKg7DL1jlEE7PE4Apdb3dYqgZbW9k4f5KXcXX0xyM9XQxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2WowufGmJKUZ3nhL5vVEXpDl4xosNPA6n8WznW6rFIuhUbBv
	h/ws/+dq1ti59TL7ENDyo6YBF6XXBEO5pD6zqKNP+dAUiXlViUiPtJjGnjY/XWD1MxlA0X79QdQ
	6BaiWTwXJWA1oF+osE+xSh9PWsZiZhE7joA==
X-Gm-Gg: AeBDiesV4srLI4g2La3MAguarfETQ8mWz1ZKukglBFRuXwHoceEu++z2JFrQOdabgGO
	/jh8DY7o4zNsqAhpo3lrxdUsRSPiEJXFGh1K28PcGaYfHK8fTv3JHU62bvn58p2X4cqzcysuciF
	YqmSnZlToENBwC1ypj12vwQOy5wN/djDcv2LeoM1BjguWWra+Tf/aEtcdSBKfI8+LlD/mfshvMZ
	P4+LKWPDatgjsg1KG4g99N1MZWRnBKrAtsHyc/O2GOdC6aLYJ7M1/1ChHC3ebTfCPmCd9BPu9CX
	OmJt4k3TnT+Cr+Ff4HhVbNjkgxigzcQIA0Tgu8V5EmE4X5pNHSGH
X-Received: by 2002:a05:6102:4b13:b0:610:2912:adc9 with SMTP id
 ada2fe7eead31-62ad55ceee2mr956330137.28.1777542737753; Thu, 30 Apr 2026
 02:52:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 02:52:16 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 02:52:16 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87v7dagdjk.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
 <20260427-refs-move-to-generic-layer-v3-6-e4638dfb7897@gmail.com> <87v7dagdjk.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 02:52:16 -0700
X-Gm-Features: AVHnY4JpgRiWM-svh3DeU7DuhdDeA5TJmDnezsHToYAXqgYTaxzYJvCUQAlPSvo
Message-ID: <CAOLa=ZQ3P=K0iX9w4GvMPPBXrUMuZrBkt=MxYg+nDt5_-vyMRw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] update-ref: handle rejections while adding updates
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000751c8e0650aa6b78"

--000000000000751c8e0650aa6b78
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -289,22 +300,35 @@ static void parse_cmd_update(struct ref_transaction *transaction,
>>  	if (*next != line_termination)
>>  		die("update %s: extra input: %s", refname, next);
>>
>> -	if (ref_transaction_update(transaction, refname,
>> -				   &new_oid, have_old ? &old_oid : NULL,
>> -				   NULL, NULL,
>> -				   update_flags | create_reflog_flag,
>> -				   msg, &err))
>> +	tx_err = ref_transaction_update(transaction, refname,
>> +					&new_oid, have_old ? &old_oid : NULL,
>> +					NULL, NULL,
>> +					update_flags | create_reflog_flag,
>> +					msg, &err);
>> +
>> +	/*
>> +	 * Generic errors are non-recoverable, so we cannot skip the update
>> +	 * or mark it as rejected.
>> +	 */
>> +	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
>>  		die("%s", err.buf);
>>
>> +	if (tx_err && opts->allow_update_failures)
>> +		print_rejected_refs(refname, have_old ? &old_oid : NULL,
>> +				    &new_oid, NULL, NULL, tx_err, err.buf,
>> +				    NULL);
>
> I realize I've made this suggestion, but I think I've made a mistake.
> When opts->allow_update_failures is falsey and tx_err is truthy we
> should die also. Don't we?
>

Nice. I didn't think of that either.

> I'm not sure what the nicest way is to write this, but maybe:
>
>         if (tx_err) {
>             if (tx_err == REF_TRANSACTION_ERROR_GENERIC || !opts->allow_update_failures)
>                 die("%s", err.buf);
>
>             print_rejected_refs(refname, have_old ? &old_oid : NULL,
>                                 &new_oid, NULL, NULL, tx_err, err.buf,
>                                 NULL);
>         }
>
> How did test coverage not find this?
>

Because:
1. The function only returns `REF_TRANSACTION_ERROR_GENERIC` as of this
commit.
2. We only seem to be testing this scenario for batched updates.
3. I'll fix this and add some tests.

> --
> Cheers,
> Toon

--000000000000751c8e0650aa6b78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7d521ad90e7ec91e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uekprNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlF2Qy85allSakk2ZmgzQnZTbTE5eHFrSU1QYkpkZQpTVjhGK2RlWHUr
Tmk1MldTSmFzWi9zRmwrZEYrVEhMSVArRG5lYWhTKzdncHFzNDNycVBneW05cEVSVXB3TVR0Cklh
dG81bEx0UmlLMEVKTlZTUWNtN3hjTjBpOW16NUtkaStjQ3JJVzB2UUo2S0hteVYyVFpTQzRoZU9M
NEN6dmkKRjdpZDk0QlE4MWd1bU5JZ2ZlVy9sUmtSaVRtSEhFRWVyRkFIRXc3VTdQRjVXcnFTT0Nv
elp1VUc1NXh3eVFocQpuVzJUbFJQQkM3ZWw0eGhNOERBS2tqN043WDVZSGtoc3YwVmMzRWF1ODhT
WkVXbTdCaFNxTmtPZjlhSC9ZYkdaCmQyM24yT0pER0srQlZiSHlycHFOd0RrT0tjcmhuQUZGM1RQ
OERZcjNBNzlCRlB5WkU5Y3RWRTlvN0h6UFVKblAKSTV6VThvVmYrZFI1MmtqUFAwd2REVkl6UTFR
YjNTTDFDUlBTYXhFa0F2Z0dweFRFRVZ6SUQ5b3VNbHRuUGIwdgppZmZ0TTZyY1paR2FXUzZsV1VY
eHVqS1F5UnFZVjh6SlZGcFc2dWhuQW1kUHc4OGE3OUdmSjRDZXNhbjdYN3ptClcrM04zWkdoZ1d4
dmh1OUJFUVV2OGlDcDYwM2I3V095bjBmQkZsYz0KPUVWVWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000751c8e0650aa6b78--
