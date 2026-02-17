Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72F130C62C
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771320779; cv=pass; b=TO6XOMplAjpz84oe3z+dWiAi2R34PeBIdnAeLo+W+AYn/j0Uk3p2+EgYzI4sLFDA1nN1A0Adee2gmVIeHAnMJ0n/MaMPVvynx8pjsBUlLSrEAsQrvHaxrFix9ah+kDvzVk4+mLcZzFKE0PQPKg1/PJMbWG66/zv4tRV9YUlhg1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771320779; c=relaxed/simple;
	bh=2vRSKOLE37590rZbFC821p1I1yDNBVy92ykLmpsE2LU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xk11XuGV3HEL0Z3zhGTe2RQ4w5QrLVLJDQ5a7h2Ahh2dpWLaFCUDYQbNjXEYX5J9EGynLrhpMQm58ohXbh1pJEtTfVqZ5AAggQA5GzjrSY71C3hFRn/qy5/7Krr2QbxniiElpcmogFA5sarBVqbApb09CNLZdy1KLy6d8rrYt6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYVVh3Yw; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYVVh3Yw"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso2247691241.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 01:32:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771320777; cv=none;
        d=google.com; s=arc-20240605;
        b=h5GENdH/npwlF/RQPym0EXzLFpwQiGFwyqBIgTUiCtpiROWKY0+pg3yBkdu5kp3Dx9
         se6+PStRnzjz3lLk3/6BcaDFS+tairUoNMXkkjAXMd5zrhDCoihljWtEvJtjljZpvDMd
         i0FaA8R2JLvuzAAnu+yr6NWoK9k7uibS2EAbTYrmxwX+cdFQhfRwiaO/xFq5I97RDbWh
         YiUgaGzt1LXa8W98z1T9vfPfATtrQFDh9mcNgymzVYL0K/Vykf5jd9IKz8BoBlkOmzdv
         Y0uJauqC9RlYj+M+Tqk9pukgNLdAKf72Kep3F4Ideit1n8K7YLtn8UinvGoMNNddVMp+
         DSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=j/vydbXjVKiqW0JHlf40pW300KlGVBwDlQ/Em6sgSro=;
        fh=ty73qu/mjp6olkAb0/G4VGZeH6SWOLNBs8YQa03/qaY=;
        b=DN+915xZ46kc7WaSO/fMu3LPBVreR46a+tD5KxqT2CnN1E1kGFz9xc8/PSYWInfmwe
         j2kHx+S5stJcYc/5UuxyP/p8xzvd1FL/oidZctp98ytS5kfaChIZgm3WZZHL4BOXBm41
         aOtSn17Hq5+uPGjJB7Mt3HcY/8OpUSl6c+ebJ/ilWJeM9CvXp8Sy32Q3JHuSGclIOytU
         +J2I4z6wJ41kmJN5sjyRwyUJOh+nBgGRimc+PVRZTvXWQ5ffeG8gwH3tZMBXH6zKyaW2
         uRixPUGOSN7uXCFHR47wyOebhf0ooxHzSIKKZptJTPyr2qDuiEHn71i7nPAkkPu02LlD
         +xDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771320777; x=1771925577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j/vydbXjVKiqW0JHlf40pW300KlGVBwDlQ/Em6sgSro=;
        b=iYVVh3YwRExqxQxyxX4+krjDibUdZ685VAYVwIGWCp8Uvgvgf41KifVGsZYOADEMcn
         r0a3lEk4Cv/Non/ANtBF4wBvTLevajODeWQAufM/5aVyvX53/qqAK+wfnMBLONKxxDNH
         8gkNykRnOLGmg6y59eM42Dms3xetk/SDYZ0VwOGa3BeRtvTUlPirg37JggzdFf91NPrm
         uSkVb5aoAbWxmZl0XZnMxnrWmXbeP7xkrINZJ2TJ+rk6pmXWJcKSOAijWc5D8T6KHkwN
         0rw2wZW/id+qFMY10xcoTzu62pMFLBCBb0FEfk0xhKBoyFrOQER1mfuK9GH3MyoOm7Jn
         VfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771320777; x=1771925577;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/vydbXjVKiqW0JHlf40pW300KlGVBwDlQ/Em6sgSro=;
        b=IYtL4HUA6NUP6HGYTiFIcwSRYm4uHj7NErHfktzDb8EgmIzv5QXPWSFBPs9uVEcyzY
         hXENotxljo+VErahe7bLWK8K4UjTLjxyTOp7K2wG0w3P2GGfVBek8Rb2IOOFNmbw+Kex
         9NLOHzTwS3MZ4yVdR67RCwjGLh9/oJyLsYSfMU2DNXCm6Dqvxs+C8TlNJZardLmaSOob
         Hl3jpeLhZCijLGzlr5n/G54+XaEQ4ClCkUFl7sFSDBF93HuOudrGDWDNpwgcI0ustFlj
         l7DizmxEBHYb5VW0J+Kk1VqhwSb3Ec6jQ8YFHQNX4TVhRZ4+K7sswp4nqbxMoQjPBJdP
         S7mQ==
X-Gm-Message-State: AOJu0YzdhltuVi7hRo9iAsetWxpk6jMD415+cavX//ENZl3vSYuAkvIg
	/hDWcOU6v5790kadLj2NSmJZu5KIi1Ol2rXAiNW2YI4jCD6UKUl/lLm4S2agbKsnXgn+f2I52MP
	YjpAYDRYmusfAxLaHrfhBmW7YTb8eteY=
X-Gm-Gg: AZuq6aKh6K4a2llRUEij0MQMUVdsTvd91CBW8ok2adswqzgNbw3cODPg6ejALQ1aqC2
	bb+NN04638Lr+/2xIm+IJLz5Dr13Cs3nkUZ87MVH8VAHDfu9oJGcLF7OLWi/mW39DDOCyEx6QAb
	Fw1jU31iUKcQQkLCL3WIyE2EoQCb0NSiAyhOVMxA/+ib4kCRbIgGIwuxn1MbV24P0k4INgSWXEx
	Dz538TPseoJ6wOUM5pz2JUxBve3frSU0h36nvkc0FjYSKqMy3s42ag2zKCQ6qjZdrYvzHQkCVTT
	wZDpZxYodTOoFCbIXdt63Xl2tJv8LcVXrhibugKvJw==
X-Received: by 2002:a05:6102:3f15:b0:5fe:f14:e701 with SMTP id
 ada2fe7eead31-5fe1ae114c0mr5198658137.24.1771320777397; Tue, 17 Feb 2026
 01:32:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 03:32:56 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 03:32:56 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aZQXrRuX3nsnuyEw@pks.im>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-6-86a82c77cf59@gmail.com> <aZQXrRuX3nsnuyEw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 03:32:56 -0600
X-Gm-Features: AaiRm51zrt9n2cg416oOaMxZyEyQe_GWlMLrYnyjGR0qgYVtT73pzL_Kfn6zjls
Message-ID: <CAOLa=ZQFOLh6ixB4=ukPS44uE9k3-1Zw1U2bCYf+TsKyHEqLiA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000b881c4064b01c182"

--000000000000b881c4064b01c182
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

>> diff --git a/refs.c b/refs.c
>> index 87ef54abd4..6b3883a325 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2192,16 +2192,21 @@ int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *e
>>  {
>>  	int ret = refs->be->create_on_disk(refs, flags, err);
>>
>> -	if (!ret &&
>> -	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
>> -		struct strbuf msg = STRBUF_INIT;
>> -
>> -		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
>> -		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
>> -		strbuf_release(&msg);
>> +	if (!ret) {
>> +		/* Creation of stubs for linked worktrees are handled in the worktree code. */
>> +		if (!(flags & REF_STORE_CREATE_ON_DISK_IS_WORKTREE) && refs->repo->ref_storage_payload) {
>> +			refs_create_refdir_stubs(refs->repo, refs->repo->gitdir,
>> +						 "repository uses alternate refs storage");
>> +		} else if (ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
>> +			struct strbuf msg = STRBUF_INIT;
>> +			strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
>> +			refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
>> +			strbuf_release(&msg);
>> +		}
>>  	}
>
> Okay, this here is the reason why you've moved the stub creation into
> the generic parts. Makes sense.
>
>>
>>  	return ret;
>> +
>>  }
>
> There's a stray newline here.
>

Will fix.

[snip]

>> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
>> index 9912433b8c..b743c03a59 100755
>> --- a/t/t1423-ref-backend.sh
>> +++ b/t/t1423-ref-backend.sh
> [snip]
>> +test_expect_success 'initializing repository with alt ref directory' '
>> +	test_when_finished "rm -rf repo refdir" &&
>> +	mkdir refdir &&
>> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
>> +	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
>> +	(
>> +		cd repo &&
>> +
>> +		git config get extensions.refstorage >expect &&
>> +		echo $BACKEND >actual &&
>> +		test_cmp expect actual &&
>> +
>> +		test_commit 1 &&
>> +		test_commit 2 &&
>> +		test_commit 3 &&
>> +		git refs list >out &&
>> +		test_grep "refs/tags/1"	out &&
>> +		test_grep "refs/tags/2"	out &&
>> +		test_grep "refs/tags/3"	out
>> +	)
>> +'
>
> Should we also verify that the refdir contains the data and that the
> repository only contains stubs?
>
>> +test_expect_success 'cloning repository with alt ref directory' '
>> +	test_when_finished "rm -rf source repo refdir" &&
>> +	mkdir refdir &&
>> +
>> +	git init source &&
>> +	test_commit -C source 1 &&
>> +	test_commit -C source 2 &&
>> +	test_commit -C source 3 &&
>> +
>> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
>> +	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
>> +
>> +	git -C repo config get extensions.refstorage >expect &&
>> +	echo $BACKEND >actual &&
>> +	test_cmp expect actual &&
>> +
>> +	git -C source for-each-ref refs/tags/ >expect &&
>> +	git -C repo for-each-ref refs/tags/ >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>
> Same question here.
>
> Thanks!
>
> Patrick

We can verify that the repository only contains stubs, but to verify
that the refdir contains the data, we'd have to add backend specific
logic, I'm not sure that is the way to go.

--000000000000b881c4064b01c182
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 704aca016ff65507_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVU5jY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0tqQy85YXRpZlVWNFd3ZkdmeEdMdVJmekF4VWwyTApick9JaGRtZW1C
dFhOd1RmSTBkVklwN2tsV0dMK2JaUGkrZW5BRFE4YlBiUG1odnR4MG1ESWp6ZkFCZzBIelFKCkgx
VTZrVEVsV3h5T2lyYWpic1ZlOXFoOWV5QThlMW1DTGtVUUpIU1BJWFkwcnhKWHdNMlVzRW1jUWM4
VytqNDcKb0lVckVNWm9vZHZvczZRa0VwOGdmMkI1SzNadUMyN05tUm53dmtmams2VVdCMTVPK0xo
aDlNUUk3RkNxWllKdwozakpsdkpZYmJUbE9xN000bG9VSkZFMy95VEhDQkF4b0tCdlc2bG41UEww
T3E5a2s3MVlzUm5pT2oyNVVieElaCjdtNC8xbzhBTnJoLzEzSFY5RmthalVHR2ZrK1NDejFiNms0
djBxSlpHR213ZGRvMUkzZVBweUlLaW5SdjhmV3MKN25SS3BmMmRSSXRTNWRKelkydlZFQVg5U1E4
V3NXcGh6dnBncEM3RURRMnorQWxOYnhTY1o5VnNPUnM2TGJzcwpTbHRuREt0cW9aMWphTGo1WHZT
b2ZxM2hOallKb3NZRk45Y3NtelE3RHFvVGhoblc2SUhDdmNEZThlRDlnN1NwClBRZjZNNGpLd241
WVlEZlNCMi96ZU0zVGJTbm1qa1BsOFNIWFRTST0KPWM0MWEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b881c4064b01c182--
