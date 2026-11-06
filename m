Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793973005;
	b=buCirTIUSG+Zqk26lpde0bI6LR8fuUnh7Ei+Zl52RvYtGkNuforyMjD6Fl534T7QtNL6
	 klxgyCcTrxhJhShEIfP/qq9YCSJ/udPWEPdsUdriOWbGYELiaJdrFBHpfCDpfeCjtBLPA
	 QTGnPvF0b/Y63bbFanSvmbf+cCdkkh0ONJeeQ2qNZbaVutH5zH0Y49NfPDH/yW9FAMVFH
	 TnFHPGw0A08YIHmcm9TzcCuT8cPKVMDH/xXqmKKI8VQjZdEd2SW1+4nmGtLZU+VfyLKb8
	 HyKPE6KjuVLtxOkaz2U29J2jZ+qKX7pSCVFfgWo7nH3h7UmXst8eCvAuZm4URlbrHCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Di/oqmYS40fOrdAByuJ8JwPuZACCSJxbA/GjZhy0mFI=;
	b=pQJx9nbF1J3Mg3PTUeX8wULNwH+mfVc6P8YWvC8gBbra7DHGEUdC1Sj1Ptqeo1EbByGR
	 bfXjPTMTDiPHsHcmqMRhNR3tlXMOwVRut2jDfRekHDwKxMMx94imwxaUnYu9CiJ9Fp012
	 onF6ZPd2xlHPssc7kiWejf72lszxeSkY/1cYXsS4bYtKu3vWh9Pl69ZMWUGDmfg1pAhOD
	 VZKqiA++7hTyb9kyCnPTm8+HJf6/BUKnMiigIBEMN8W6qeXAsdZmVvTscQEqypCS6iN1s
	 BzR250+ZV/VOTgaxJgKr8YIAIbhiOm9t5VxiCF5LxBMDmPJqWWASSUj2tCmgJKIAFZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OeZm7Ssd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053C606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 13:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2053C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OeZm7Ssd
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-14394530ec6so968632c88.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 05:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793973004; cv=none;
        d=google.com; s=arc-20260327;
        b=PkNdGc+yRb0w8jgnBP1Ao+keUGO8sa0KunEm5iPJAA1uf2GYX+QJBAhL18Jzvl5qHM
         WpcV2AY0rloKfSlRrTy0Z41AYLlceXi+eQl/Px1hQWoAnGfz7DcWVkCKU57de8d0ue3M
         UHvWQAAHBWQrV5UToTHYGgCIfjbGOuWGk/NV0wLzGe766tLyVBIXXtcm9oViYIQKspW0
         LcC6xwaVPzLze0gIPbGsEVG4vFZGt7hK7mXPKrd3AqOVBwGAEQlxPqKqzQ/59rFuTVLO
         WNHdaL+mUP9mRojwiZ+xeGDtfU4ptT7Q94/24L5MwKKxNZNvCXY76xHCZw/RZJFVB75R
         6mmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Di/oqmYS40fOrdAByuJ8JwPuZACCSJxbA/GjZhy0mFI=;
        fh=pGNsfNKYTwKJYsyyXvW9xZsTULt0IJk2mo7GWVx6Prg=;
        b=aTIzFSme7wrmd0N8PyWGOL9sJgeh0koTlHWtG7G/9I5IyHyUqIGIow/7iivFwSvoJJ
         wryzRpTfSyQIPFtNTEqmGVFWqvnq5aHx8hU2j4EPZlXfCk73g564WBXVjjJsW/qnvSIW
         YwGjN8VYZI7srbyfEN5vT7Qwldoyb5PnPzHxx2B5qUDIv3ojBwmqlWfKvTr3wFZCL3CQ
         ULsRh83UxYH7wSDj+G9fD61Ym4YenNrAVJt9NPa+7JCwBOz0zkRZ2wFgqN4NIXX3+KNm
         UpumGdI4bYP3jKml6PprJDAwEFMWLX+CsAjVj5qHQFQLYL2rZuZDzFe1k9yElmgObVPn
         4M8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793973004; x=1794577804; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Di/oqmYS40fOrdAByuJ8JwPuZACCSJxbA/GjZhy0mFI=;
        b=OeZm7SsdUFGvVWa7vYiJKsIEUQhi6RnKlRijwN7C4Uighu8oT2Rg3Z1Ko3N3PxZXp4
         3ihzm2bG4B59Fotqy3FqjykLcfImRB/eZD+b9Vqf35Gs/r1fG+GnWqKYmOfgBqcoRecG
         PPQ8dFABeRzKyEOApG6iZapMksAvn/efQEKNp3by9/JSnUpM5DVaaOrSZS++ickJAXNX
         EKK9xEetpV6OmYWSO3dd7vq1N6JA59Bjh4NK7SQN7X8Z04fdJihVjZT6IsKaEUQOXCUJ
         MMGni3F2nHJVrpVrq9IojbY4XcUpbii72XvEg5sF5YD6DJtg8tYtT6vzk/Hnfxvz3bYy
         AHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973004; x=1794577804;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Di/oqmYS40fOrdAByuJ8JwPuZACCSJxbA/GjZhy0mFI=;
        b=EOA5sh3CtQyFpcmzGMmkOVsS9FLsXzYckBH9OVvS7IxJvIz863XqvC3Q8D97QWBPoE
         KdO2fo+tcFrWTaTnn84yXIPLddw3b7GhVjx3t8TZLbAKGDgv4O/tI7IHThyfcRXjyiLg
         W4KWn3HUevzbYusSn4glzt056Ybmoq3wFgRPgI16DX8pG9PweC1FthBCx99pSo7w1Uuw
         0ZouiYAC1Yye+uqV8IoawdBAdHTZ+IQAXLyB/mz4eVjqCQuBAyOf1L5hiWOCxFIQsSIN
         p6059zdl7fIvfsrqk112vSVP7B47WXH7ZzdJMxQerehjupTVAyzDtEt30hJxbNuK1pSo
         ezfw==
X-Gm-Message-State: APuU4Z++kxKTf9peP3/TmjSW+sQ5y69l4mXkuFBhzCxBc+Hufl5A0urG
	7YRfWAEEZrMO1et8KQNIL/N6XAQuKXIqq5jMV6FLtoUJdwjB8vbdGwMyS2LZ4oyLSmMLF18Ily9
	CiCOUtV0rVV5W4eCEDJFwiMhLfKMcuWo=
X-Gm-Gg: AYBFou0VUHZP9p54eWofXVFoiFWfmM9o6L/4ZnX/yD2PSwL/45vy6H8ewIwVx355dhd
	1wGJP57UjvEHNbL2V15fI+ac9AVuteb9+OdAW/3+9zWsu3i6O2ovlzcCaBCZ25BdG6C4wr7DJkj
	qTdf2qK5ZZ7GdojqLUmjWOQrTbqyQ0wuwMcn4/oXncyEN/z2mPagQ+Nm4nGAoX6StOE4G4BrwDY
	Be89UX5MA7ryLAKHsO3B8gH2svJLkybxU7rEJd+1YMU1HEHtO1LneOeCpsZQRx+1iNTyOqm/z1E
	It3+xfiucwONoL6WPnzdNgdykWIJbN2kbzSgDKKdIugDRDQxpUYijoWQGKYK2ee4FUOI/c2qhnD
	zPBltAnRPEyNKcvTxsH3chr2N46qKeSrtHL0p6po4njIugs9xujOrsDo85fhgkZu4BGYtO91V9v
	57woa+e+LdZrR4YAAouWPIumfslj8=
X-Received: by 2002:a05:7022:28f:b0:18d:5ef2:1644 with SMTP id
 a92af1059eb24-1b25d33902emr3086674c88.30.1793973004072; Fri, 06 Nov 2026
 05:50:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 05:50:01 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <au28e2L4LEMziCfI@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
 <20261029-pks-rerere-subcommands-v2-2-07d5ba18e882@pks.im>
 <CAOLa=ZT6XJK_duCu5E+i-PxXzaCt-JUOsHAsTdysc7EYY3pBdg@mail.gmail.com> <au28e2L4LEMziCfI@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 05:50:01 -0800
X-Gm-Features: AclHuK_7IBt0nFjw-hkhmE_sx9QXjOp0bQKMO6AjvTWpzsd-zxRQ3gk9ocshAeE
Message-ID: <CAOLa=ZS+sJcPh1Q2Zz4Dz_hkbJCEd_sQzhSTbaZwEWL0nqDJnw@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] rerere: convert flags into an enum
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000a5802b065f9be361"

--000000000000a5802b065f9be361
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Nov 06, 2026 at 05:51:13AM -0500, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > diff --git a/rerere.h b/rerere.h
>> > index dd9da03d6db..f13790c5dcd 100644
>> > --- a/rerere.h
>> > +++ b/rerere.h
>> > @@ -39,10 +33,27 @@ struct rerere_id {
>> >  	int variant;
>> >  };
>> >
>> > +enum rerere_flags {
>> > +	/*
>> > +	 * Auto-update the index with previously recorded resolutions. This can
>> > +	 * be used to explicitly override "rerere.autoUpdate".
>> > +	 */
>> > +	RERERE_AUTOUPDATE = (1 << 0),
>> > +
>> > +	/* Reverse of RERERE_AUTOUPDATE. */
>> > +	RERERE_NOAUTOUPDATE = (1 << 1),
>> > +
>>
>> Nit: From my understanding, RERERE_NOAUTOUPDATE outputs the conflict
>> resolution information to the stderr instead of updating the index.
>> Perhaps that's something to document?
>
> Well, the fact that it prints to stderr is not specific to NOAUTOUPDATE.
> We print messages in both cases, just at different times:
>
>   - When `RERERE_AUTOUPDATE` is set we print the messages in
>     `update_paths()`.
>
>   - When `RERERE_NOAUTOUPDATE` is set (or `RERERE_AUTOUPDATE` is simply
>     unset) then we print the message in `do_rerere_one_path()`.
>

I didn't dig enough to find the former.

> The messages are different of course, but I don't really think that this
> matters for the flag here. What we might want to say though is that we
> don't update the index, but the working tree does get updated.
>
> Will adapt, thanks.
>
> Patrick

Sounds good.

--000000000000a5802b065f9be361
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e39174cef0281dd2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ydDJ3WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDB2REFDRVZaTTcxdVBqY3VXYmdNMHp1bkJCbWNwcgpGd05Ld25jTkxV
RVRIOXg2d2dyUkdQWFZmTEdINmFiUEpEelllNG9iUTFMdzMrMjJmSW4vS1QyNGNZcGdLNmRVCmgw
dDhFNUhjSjFVZjF3NUo1cnpJVTVzWHd4eVhUQzJLSjJpcG80TFVnMXBBWmpTYkwvR1B1T2ZKaTNP
aEM4a2oKVWxBUHMwRHF3WDZpbVlwZnZrNmRWMmlUN2t6M3ZsSUhMN1BNbHNib29WRWgwaXRHMitE
bFRIR01SZTc3a05EcQpKS3Vrc25LaFJ1eFhoODB6OTBwaU9mdUhUblpjcW9rT2poNUMwc0VHdzVR
UUE2ZHFxZDhoTlpwaUljbEEzVUkvCkNEYVFiZUF3NFAwNEswYklCaGRCMkNpMnVxZHEwNlI2TXND
T2hEL1JHQnR4ekdtZFBlNUdYV2NQL3IyeGdjb08KYVQ1dmo3Q3padE5ucVdIY1U2N3VZcFRUTGZR
ZWdPQTBSZW9wenVZQ2FJV0RXTDNFeG83VzJrVjNuRS9KMXkzKwo1OUp1YXhuUXV0eFlHU0xzVDdQ
RElVWFMxM3pFeFY5Zm51VDhDMHZSRWRjVmdRZVp0MXR3RDArNWlaYklVMklNCi9QSXgrLytPbWFU
SGs2a0pIVG9na1RnTUE5UzBtWm5jVjVhQWdhbz0KPWZiUnYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a5802b065f9be361--
