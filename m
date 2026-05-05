Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B933EF65D
	for <git@vger.kernel.org>; Tue,  5 May 2026 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969423; cv=pass; b=Did3hJ3Be3Sy+on6u6u7I1TvEmEzL5bMdxzlnVURuzagOiSSep6nwHnp72GByMBE0itMQehF5u2ZxOnSqD9tnXuV4eYZ9A71DTWK9+lhc4jcy9hD9pfCv9kGYMqS/ly22uDryv+HnjLvitLG0iLNyrsxzrp5ATZ6YR7ss5Zv0gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969423; c=relaxed/simple;
	bh=8jyjZGBUBVSeWuH3ByCX5xs126Yb+ht5T+7U3jVcrhI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDplhUEkLLA8aA9lpdoQM/tC5mpRUHyIohw+AdNnQWyPmxmRF0fbiAXtx7T6U+nx53F14Q156Jmcs7Ibi6Xs9gYnL0KnJ0BJRkWxTniAm5QeR5Mevlf9uPiVo4nQ/GhdSK/WBi4J/SuvaiCNBctiXVmADGzmlq1Wx6ah3mq38qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwDUmNas; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwDUmNas"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-95699e8e26aso1230355241.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 01:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777969421; cv=none;
        d=google.com; s=arc-20240605;
        b=AXUvNP6Yrw++3/vgslPI2dmlr78hw6WKMvEYIBroDX6gOTbCApYYo/GRmbTM85Ita9
         XA5t/rAin8w+smMy2x7v+Kk4Dk6t3C7wd/aBr5vJxkli/SzEXRwb75oIUH0qPRmPvexs
         UtxUEmXsLGrCcMbXAJa6DLo9IGw5+7igOoyGkp2Hvivb54zxnFzSXAlFk4dtDh7T+w1P
         q1XpKXZhA9ENfOev4FfW8XzKnwKUttfoGH1xpS2EGGDgAQ+i6/2V1YXd2JpJaESNyf0I
         J487LEztRhxLhHDNtnEstkJSu6sFNFZynuBzqg0cxmCW1gumHQc2g5sDeqoP0JiPIr7E
         pYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=J/ZzKwDL6zZ0Oco9CH7rXOySgk7HkY7AHdviwu4TrFY=;
        fh=Uv3BoY/4RM9pxrqM1sEzEr9JvpUQwCc0FATUaMK8DqE=;
        b=FE9d9jsKtgQwwOTMivaxPLzRLoNn+KhxQ1MpJCLpmyEMcSrH+CKYsY4eW1imXc1sV2
         MLxDW24uthmzD0W+VAV6XMumhaSjuf5/M7id8WZ4S4xM/Lylt7UCBJOe4FtD+wFeB/Uq
         BatGLPk3IEierTigMg35VFpCn0MTEVJngdgNoSvxHEw2rOyftRv8IMULPPLJGiRyTfVq
         3jzEdhNc/TmgPs7YrjTZv0C42Of08jhXQ5qNLnQRSi12esLlQLPsKd3R84Tfsg8J1pux
         Ctdj9zni3fk37E93UHyKQCCXu19bg4ZoKjuxoSnTZKXCYt3Syoa/KCRhrRMkbhPDwQwS
         edrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777969421; x=1778574221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/ZzKwDL6zZ0Oco9CH7rXOySgk7HkY7AHdviwu4TrFY=;
        b=qwDUmNaswap/QaUlBQPgxyO7tAdklbxUGhtPIy1j3XvVqzMIpkwUsdTAUliaEIQE31
         8UjjMLgQ8nFG1ofTAWRXixDG1kmsACsbnaZAkpLg50iiWR6qevE3Y9JEwH/ZfSlp7RBy
         wdC7eZXTi0T12xkzaiNZEn3uTLiJ6/ks3h3c0YOVhajkYEvQwRbPIhzsX3NK2ULwQKGn
         e02SEC7Z9mWLs/HFJR6GhNZthIN9yZx4X0IBosSzB4YU1Eq8E71XfTRSUTj3p1gk1+1+
         qNsupJucTpowVM7FAzgJXMRgHyKj3bqRdAXt4pPqxTLzXFgobnnVJcfb4pa8NaJSxS/3
         5Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777969421; x=1778574221;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/ZzKwDL6zZ0Oco9CH7rXOySgk7HkY7AHdviwu4TrFY=;
        b=NpxBCxAhA03h7EjZ2Txaohg9Qh9JpblI2/xp+z9obrZkqcKYUX30K/VJfWVYUp8Kfp
         PJ0fDnbAH7h89BM/jJ2bpFsLx7xFyzHS7Y4mUNBuYFbM58mpuhbDCU2JupJ2sf2Pqf0j
         EuPVvlMSer9RJNnFKwfSiEN2D1g8E2GN124pQ2iIrWRX8fDta/rHPJ8/tbmzQZp1tFVA
         LHEZCISx28Q4MG/8TD9sjpLXwXkV38U0KsRUckTvgH/OrSCMttO14YqSofSH7oF4L9rp
         wUXRRDbZONBkkTXtwdsWqz/xVJJZrppSDI1zgmFGCGTqtez8+TLKd5MsSQPyGbOPvWAq
         iExA==
X-Gm-Message-State: AOJu0Yy4ij1HQpBf1UpybmxEPt+fuZRwMS7DkhmYo7zQU1DdCq16PVsn
	GaWO7jnDkb84GJVyFOJHqp2Mnm7KsMs8lK73vppdYXg2YSe9CUIzjCmSUw5GHQcfHHUGwOtdu2M
	0LNBWSpEOltKX0hriGZJorj7Nj72L3iZClg==
X-Gm-Gg: AeBDiespzPhYOqwG6xrdMJeeiO7P32WC/GpsGP6J/IOLqAbvo6tz5iidC7hbN8XfcJi
	WbWygGIYw2YNSMBBC6FlWGASnD11yK+xzIiqYizX0iDkXqncYoOpDZgLyhgo8XVeBSm9uF5Q4Rp
	7wJvjQFJtT3/BjMWixguj8LRWEqTW85ffdgTbXFVYncNS1/RxscWB1kxkKSs1CvYF9Xiwu1OIxw
	rxp4tCp62fV4V6+kYREaX0eS2q3S7V4V6HqPTyeV+44YFDLSuGLVZ4Ll0I8hOE7XmfhdvVeaB5I
	PWKeUzwkHFdOLxulYWSO8pHRgPlrbdkxcYo/2tAmsRBsmzAh6fo=
X-Received: by 2002:a05:6102:4bc7:b0:610:6e69:5239 with SMTP id
 ada2fe7eead31-62d87558a50mr5111822137.23.1777969420857; Tue, 05 May 2026
 01:23:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 May 2026 01:23:39 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 May 2026 01:23:39 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <afmFmGo_Sg33Rv6V@pks.im>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
 <20260504-refs-move-to-generic-layer-v4-6-936ac2f0b1a3@gmail.com> <afmFmGo_Sg33Rv6V@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 5 May 2026 01:23:39 -0700
X-Gm-Features: AVHnY4L3hnxU-8ENkszamV2oaXld_tt9nfa2MyjPubuFqtNW_E1hlwJvsioDEJ0
Message-ID: <CAOLa=ZRj11QW16-E6dY2YxDWZ+3moV1h_-S1DfbFPJeOGTjHgg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] update-ref: handle rejections while adding updates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000c08dc206510dc390"

--000000000000c08dc206510dc390
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, May 04, 2026 at 07:44:10PM +0200, Karthik Nayak wrote:
>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 5259cc7226..6355c3dd3e 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -257,6 +266,31 @@ static void print_rejected_refs(const char *refname,
>>  	strbuf_release(&sb);
>>  }
>>
>> +/*
>> + * Handle transaction errors. If we're using batches updates, we want to only
>> + * die for generic errors and print the remaining to the user.
>> + */
>> +static void handle_ref_transaction_error(const char *refname,
>> +					 struct object_id *new_oid,
>> +					 struct object_id *old_oid,
>> +					 const char *new_target,
>> +					 const char *old_target,
>> +					 enum ref_transaction_error tx_err,
>> +					 struct strbuf *err,
>> +					 struct command_options *opts)
>> +{
>> +	if (!tx_err)
>> +		return;
>> +
>> +	if (tx_err != REF_TRANSACTION_ERROR_GENERIC && opts->allow_update_failures) {
>> +		print_rejected_refs(refname, old_oid, new_oid, old_target,
>> +				    new_target, tx_err, err->buf, NULL);
>> +		return;
>> +	}
>> +
>> +	die("%s", err->buf);
>> +}
>
> It's a bit weird that we pass in the error message as a strbuf given
> that we really only care about the actual message.
>

That's fair. I will add this locally but I think it is also not worth a
re-roll.

>> @@ -644,6 +699,10 @@ static void update_refs_stdin(unsigned int flags)
>>  	struct ref_transaction *transaction;
>>  	int i, j;
>>
>> +	struct command_options opts = {
>> +		.allow_update_failures = flags & REF_TRANSACTION_ALLOW_FAILURE,
>> +	};
>> +
>
> Nit: stray empty line between the variable declarations.
>

Same here.

> Other than that this patch looks good to me, thanks!
>
> Patrick
>

I'll hold off on a re-roll unless needed.

Thanks for the review again!

--000000000000c08dc206510dc390
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c0fc9ffab836b816_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uNXFRWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0JZREFDSUM0b09oY1krTHFuRFN1TUpoTm1Rbm5hMQpPdTRDdWhVdkNp
Myt0MG0ycGpkWlM0ZW9BYW5pcTRUUUM4VUcyK0pJV2luVVdRZWlqV0lPM2czTC9DelBvUTYyCnQ3
UkwyQ2hpZndDdXVnTFM1VzZIUDhlL21HVWtTMW1LMmFoRlAzMWcwRUN3QXdmb3Z2TlNadStjbWhS
UVBBL1EKWXplQUNjenlBRkFCci8rV0RHUEo1WnIwTjhxYktmTW00WWdWOW9jZ0lWZVc0NnUwOUNP
Z1ZJSlQ2blc4TEErZwp3Y3NUdk5NbVZRNFpvQ2toKzdQeTl5TGcrQUxJVjZjV0tiVnRxcVpSMDdG
T3ZxU1dMM2hWWUgxemRDL3dNWGoxCmVEcElTQ0VlN0JjY1BwVEVDL2tsb21Mb0JWcEg4M01VWHVu
ODdBTTBaeFBnTlZ2QlYrc3NFaXJOWWdaaEQ4YS8KbUlTYTVKTGhHUzllZCt0V2E1YzRtUi9DemFt
Rk5RZEd0VjhsbkFmSDU0cnBpV2d3OWpFMGQwL2tMT3pwTk9KMAovL3gzd2lrSUNIYUNPWHhHZzdK
Wkd5TWpaOFlBVTI5YTBqSnVWcGNvUmJ6dEcvZlMxTVV2QTZ6TkwwNzcvZm5aCmhGLytkT3o4Mm0z
bnVnVlBBdlFzZ01PWmx1ckVISGpFcllubURYTT0KPVhDVnUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c08dc206510dc390--
