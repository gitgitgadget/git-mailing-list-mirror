Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FD45D5D9
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037703; cv=pass; b=L3q0O0nHRxUdsHdaoqqJNIHUqRhAXrf/wyQJhnFCc6ehsyy7AgROu4UPlKRcaWTkmIiq0n7HmiNx03+39J+acVzzdDuvZO9CV3tB8K9XDDV7Ep7JCz5ESgT5ym+MKSbU/LsZ7n1u/U6Xvj9dYR84i8zcHpErYDdV5sErvZ4VPYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037703; c=relaxed/simple;
	bh=WaFIN/R1nS+ROe54ldpMdJxyRo4S8TEzNHN2Kzw5o60=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4UJ5Dxn9QOWUmYUdONo5H5UDBbORy3Z8oC1PJh0fCOOWI77zJ72Qgk7V5pCk3tKOAP+p3mjL7ChEbKvmkil0i7sHtMqS5lCVfJX5TRqDDI49pmg9FccrPjWbWdtFm/kL1HAe7GiJtcCAbxi/75ULOIw8Wd2AMPmYU5IZXH0Kho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqA36xu9; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqA36xu9"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-97c441e66f0so4106020241.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 03:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789037692; cv=none;
        d=google.com; s=arc-20260327;
        b=qwqUzre/JuANvAqDUy/VewJ5PV9rTzK1z3vF9fFqdG9VdQEFHXt4hhtvlhs+b5GeWG
         RfK7A9ukXVZN6l5wokWX0iuVmNilQ/yxiErk9HWeAwGVkp2D/2hk0+q5DKQVSdgv1XEv
         vW60/8OHhzzHS9Ilm7SJpE3vDb6H9aF5PRJ02aKL5ADrXLPWFmSB+fvWyY7F/PkUdknU
         6yuqlhx0vf8EWpRW/3QZDk1X2L0qTHyIL8z80XXc+66QzVXFhDEZsuUZ39nW8EHYblNk
         +yZm57zNBFrSkxosDqE1hNNyGq+LIVPTKof4hxJaYKrrRJTLbK25AJ0Ru4Fs2+3jrCln
         pzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9X8ZJ/Kx9ijDsvtr2EOOzlkYMGiFcsKSHDX4PZvKRYg=;
        fh=sShHwtf2qMXlnwsY1Tf76ElIEPa1qUdf1fZzXhKWXJ4=;
        b=re6vImYoq0eEftFSkkKgjQxWqcsEQRfw5ZQt7Ji0SINWSZMClQvSacLorm98FYhPck
         xfDBxWOV8k+5oePdBlM1+tbotOzmlKNokAEuWvjx1Ramn3Pt7Dgbm/SAnCy2q8+kSW1k
         CXMV1MW7rKWKjbZg/bDCsO+mqq3F+sQQvnDGMpbZcMIlFZt2EEFcLKmUYzszPW5g4cie
         z8Y9ZCcRyFafqsfgn37if5F84CdzniSychzsmR4WcC230Hv+pRqkyxTDQfmyhiUFpr8Z
         Hpaqy0Ery0KbNsCoqzryyFXcX3dGyb8QnQ/tY48H2dlbVzE4mgpAb7+zfC7OoO9QXSWS
         3V5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789037692; x=1789642492; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9X8ZJ/Kx9ijDsvtr2EOOzlkYMGiFcsKSHDX4PZvKRYg=;
        b=gqA36xu9f85IbUErAwLdattN0kvlB15Vhu37ONBq1ftd8Ha+Le6yZGxXmKyVSawHTg
         8g0l8D93CM/c7hJnB7YGcHz3MOloHbZgS5muBJ/4UtxfBLnplxiZVV/HLHc5gaqqJEty
         8eyJTUAs0kbh3+9vCkmO2lTB27FcQGn/E8ToKh3UYYm3blgAIs6zqycagg9rUtpgqE3b
         7/WnvDn8ScWYuRTuT9pan9pKxC4jmJe2A//kJnSqO4v3hAFWhTkwMNhNL7US5Wr/s6Ui
         57w8p6F3lufZl3xkpN5NLq19XM3iHOemq1MHKsxvoSioSkncmxW5noGUPCMy2orkxvZb
         bHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789037692; x=1789642492;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9X8ZJ/Kx9ijDsvtr2EOOzlkYMGiFcsKSHDX4PZvKRYg=;
        b=grGfXPO0XA5rkaBpM+lgCoPmTlQjql/t/57fVdEzCZpnuHKIlTa4wHwnJxuW3tNepw
         eUfjJ9+u6cJeUPt4OgfGzaq/vDyOkjLoTo9bfaVTqUi9A7EKbAaUU/HhyyUIvhZEKdTv
         0IE25lmkQmgCH2g2PpF9+/OSAtOXjtB8eSz962PuIZXwB3ZycSGmeSRJu7JASaGzUZAW
         BUTtFjn7A7CkvaerYsjr4VVQ2P3qb8Hq6+pN9yglAGFcDkrbUeq1a4umLkjPLqrx7wrE
         GooL8VFUrP0ZkZuYU4eWj9v8mx/vgsvSg69s5s/51BjPU7zrChXZ6e5qoUfOclHOPRNh
         LE2w==
X-Forwarded-Encrypted: i=1; AKwUvBy7TZyvTtIusfsRiOB9xS96C2DrG8oboWB9v72j+tlcVxomfVLSJpSvu+SeUF8RvTiGTkU=@vger.kernel.org
X-Gm-Message-State: AFuF++l+iihr7G6kbdjJdtaYkwUHrRnGOayOgDFSVe5uA5VFkIhMbwr4
	DmQsVTadERRsx3hmNbAK2rJuHMqqG3FC1W6pWrg8JW1xlrO86gwGVBCWJNHdWU6AlFiMKdnrhP/
	gb/oarK9wPInLQh86bBnaIFt/zRVYv2JGyQ==
X-Gm-Gg: AYBFou3v7MK+FfrqmxgsnVdhTjTe8+NsdoFpl/CEvOP/KzfwqbpG0iT+fvB2AAqA/8F
	1mppUkYBbegA4LSC9ylo6T+093wHIWiezXQEAFp/eFF4b+PY/wcxPKCTWUzqFbHuXu3KltiWaky
	gXxFRcl1/BfHHnX3JYuC4LgsFbLIexEqXKJYLzRLMl+flE2LVceiyRIePnsRuDbT6IvFpe5K/Hw
	PzZOToIFQtNnTa5zHOBHuiNIz+xWsFswTkqTADisOmhAZCT1twDS8I8QLEq2Dlm8UZWVGL4aGgk
	4pRoJ2ZpYlLr7gQ14LBtaQdgAt/cW/03DPhtUpIpA059lDnv296h9En3m1ObGHeLEqTit8YZIpQ
	MNHEQtb8sVxmk3qJjjupvMrT/aUH4jPN77+C3xAyqQOQ/zK9sLTZ9auk=
X-Received: by 2002:a05:6102:6b09:b0:77b:28c1:210e with SMTP id
 ada2fe7eead31-78f67ba56cbmr7899282137.1.1789037691890; Thu, 10 Sep 2026
 03:54:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 05:54:50 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 05:54:50 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZRu6D16En7hSmT19geC6OvptRXQg98ZAaDgoh4X5Yc6qw@mail.gmail.com>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-5-d8a78ffc32e4@pks.im> <CAOLa=ZRu6D16En7hSmT19geC6OvptRXQg98ZAaDgoh4X5Yc6qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 05:54:50 -0500
X-Gm-Features: AcwNN1XAIKlMqgk5AU2fnvto-JJqtbDStRK29MHcuFc3hPV5KDWzDDCxiFpsNdA
Message-ID: <CAOLa=ZQLdB23c0b0tzUeYew=Gkqc11fLnROy0RUCUBg6qxxy4w@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] builtin/clone: move setup of alternates for shared
 local clones
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001d9730065b1ecc1c"

--0000000000001d9730065b1ecc1c
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> When cloning a local repository with "--shared" we add that repository
>> to the new repository's alternates. This is done in `clone_local()`,
>> which is responsible for performing local clones.
>>
>> Move the logic into `collect_alternates()` to unify our setup of
>> alternates. Furthermore, this will allow us to set up alternates right
>> at creation time of the object database.
>>
>> Note that the logic for cloning a local repository with "--no-shared" is
>> not yet part of `collect_alternates()`. This will be handled in the next
>> commit.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  builtin/clone.c | 23 ++++++++++++++---------
>>  1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 8786a49332..011fc867c8 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -220,7 +220,8 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
>>  	fclose(in);
>>  }
>>
>> -static void collect_alternates(struct strvec *alternates)
>> +static void collect_alternates(struct strvec *alternates,
>> +			       const char *src_repo, bool is_local)
>>  {
>>  	if (option_required_reference.nr || option_optional_reference.nr) {
>>  		struct add_one_alternate_data data = {
>> @@ -234,6 +235,16 @@ static void collect_alternates(struct strvec *alternates)
>>  		for_each_string_list(&option_optional_reference,
>>  				     add_one_alternate, &data);
>>  	}
>> +
>> +	if (is_local) {
>>
>
> Shouldn't we also check for `option_shared` here?
>
>> +		struct strbuf commondir = STRBUF_INIT;
>> +
>> +		get_common_dir(&commondir, src_repo);
>> +		if (option_shared)
>> +			strvec_pushf(alternates, "%s/objects", commondir.buf);
>> +

So we do it here, but then commondir is initiated but unused otherwise.

>> +		strbuf_release(&commondir);
>> +	}
>>  }
>>

[snip]

--0000000000001d9730065b1ecc1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7da4fae2a9340ee7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaWpIa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEpBQy85R2hqRHpnWGlrbkVCb3ZBdXJIUHdJZkRvcQpTZkFtWE95THdO
ZnRxZXY1YUlqRytwakpucTYrWDVlWVlENjhOc1BaYTlMcktZMFlSZjZvUHdVR1YyYTJlTkI4ClAy
b05QNUZGSk1RbHpsMFByeGszWnBqbU9CTElOOFpOK0VsODF4TjM5NTR1bFB1TVdhM3E1SUR5R29h
ZHh6V2oKdDNJK2lJamlERzM2S2hTR1gzMnhSSUtXMndDSy9ZWlJFL2d2N3FVSnRnNEg3b3hBbUh6
WHcvOUJSYmRPbVZrZAppTGdzS0Y5UVF5YklBOXh6RVAxM2c2OTlBblVWWXNudXZJeERTZjVHTlZB
T0NMZWF1RlZRWlpJeFNoYUI5RklyClErekloSUp5cktJS2x0eVkwbUwwRkc3QVo5UDJ0WDFtQnVR
OUZ4cXFLNUlRbXZyaEJMcjZNSkJZaG52RGF3WHAKc3FiNnNyTGVPckYzZUFrRFV0dlhtZ2ZJY0ZY
bzdvbzJqQys4WGttaVlTZTZ6bWhNRkFvZnlCdXlwYm5nZVZwMQp6dUF0OW1XSHNuK2FuNTVINnZX
d2lTMk5jN3dxWWtzRmFXbk5NSTJCeFh3ZFFHV0F1R1NjQ20va1RSbWhEVktTCk9aYjYrbTAvV3Rh
V1ZweDZrcTJiaFEzeUViRENsa2NIbFRSOUorMD0KPU9QSnQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001d9730065b1ecc1c--
