Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDA29CB24
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094960; cv=none; b=XIkv04j6BSVtbOjyqC2k5EwF+JVUsWkYyJkrST59gbrYXNMctTIpiWLRMmBTsXoh+fAQFygtuktsik0QJQuqT2g39HEigWIi++SQpe9kgtvc66xTZpz/LuTtFlJ21SgPLscSsnltsIn8RhRrGf3HddXdTp1e9Efq/CvAePy8d4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094960; c=relaxed/simple;
	bh=DMt2CwFR3fbabXsx+rwRk3NdnWPhsG5XTUBH/w/kwQ0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0QfnMmrVnmoSEymEiPv7nMtZwVO2Ui8IYNscRGeG4aah3l+TiddrRQwqU/SKbnwDlRWb5ix44sVAGUGvADgEIOSe2U7lQS5GXKXce7JRWj8sf+PZPVV0Y2nn6Tqn2A6SKOi4tMacZtQCugPqDQQ+mQZx8MkYHaGVOn0jjWwZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtgX8qNm; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtgX8qNm"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8e11df47db5so371506241.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758094958; x=1758699758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=09PGgYu6O9mrlmUBVHynvlGj2D4jZa3t15WeiNbg0g8=;
        b=LtgX8qNmVaqHGV7mYS7azuqvpSmH1NjW5xy5nAlmfzddnmNHr/BIYKZE4GsPTQ+1kc
         Y1w/7qIgxRjOJLjM1IFC4w7SNqhHG/mJvIX7pRo9bZHUeqNn2qq/s+R2hrfEfNNYxLz5
         Xw7oFav4E7WaiibKkOvC2wrF0rfEefRJo73+Jv4EuSHx8k4uwP6jiDp9AzgfbD9t8FKv
         ghDReHbRtKK/lOnU/dWgnPIoo6nEVqsAvNhVEZRsbl9tpoGmld9UQ2IxtluZb9/Aya+N
         tAxHTxuqKeqYiGAL0V458ccjsH1X+uckdSNsov1BrrVVZcIiMxBd2bpIMVwA05+baRIf
         dP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094958; x=1758699758;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09PGgYu6O9mrlmUBVHynvlGj2D4jZa3t15WeiNbg0g8=;
        b=VPuPV+4SBXtRyRTZPQ45xQFnufkO2uYuk+ZxnlaUWf/SQ8GI8DihiYhGF/Pv1qcz/A
         NkSqy6ex8uuyO808Fd6fWMPpxyLDiYvu/KQqBrIkuoPs0ZM9KDJxMdVgsml6hBxPd/dh
         0St4BnyGNMPcJyZR5YSrsAZiVKRiqkFhuy84wX4pukvyucFr1TNbQTuOq+MD0Zw+r7No
         2rI4dd/FHavJo4RwX0iMjzwX6THLgD1Hgde/6L6kcR0IsiTFhZO6oV1o2DR/IRHgeXNA
         4QWIz1hwfBrBVl+32yzdF86xxra3CwvJQU345rSNvdGZFpoCYu3pHdEocj/iqC1FeMyU
         GgXQ==
X-Gm-Message-State: AOJu0Yxo3Sjbo2bqPB+v/z/jVbjccW+ec6GPD1Uab9EtoONbIuczAist
	TrIT0woh2A0VFi0Z6MDblOuS8ydzv7fet1qQHiSP/ZcY0HxjpvZ/gk0cMYdy+0cb5x+bITznPUz
	gEpQI7D1kvTYY0F8cd32xEo/XnsJVbDY=
X-Gm-Gg: ASbGncu23jrF7gDUf+04lqGv2LeL3f72cLg1zy/sx7a8tuHcFo63vkaw4T/52Ut5S5d
	mtdMd1pA8zD3I8FiTFR3W41FdyhyvS3mqWt4EkwqopPTtutrolD5pxsbmBSHdHvDKMI6qFC20gs
	wBgutqR8sWwLsiH4jfDA9p4GkXVm9fVLtTQZZSQ90K4CJH21wLBPxoBHxsiHq0cX9jmaDflHO7T
	xCOo6VNEY79DcZQ0vl797qNhnhu/EtaKcmpltND
X-Google-Smtp-Source: AGHT+IE05/fO8oSh1R8uwX0NnsJmElC4uO8of1GVpMOuBmdvVuer4bTUkeY/aOmlnsAsHUTib+0D5s5H1MczxNAcdQY=
X-Received: by 2002:a05:6102:b15:b0:4fc:f5a:490a with SMTP id
 ada2fe7eead31-56d63ef6758mr270576137.20.1758094957732; Wed, 17 Sep 2025
 00:42:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 03:42:37 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 03:42:37 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <bp4vpyje3ehlq2uezjmkuk5qdigi6fo73sh7eyoofvxxbau7go@oksetdbbtqz7>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-3-195569740b57@gmail.com>
 <bp4vpyje3ehlq2uezjmkuk5qdigi6fo73sh7eyoofvxxbau7go@oksetdbbtqz7>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 03:42:37 -0400
X-Gm-Features: AS18NWDPqEuBfhfHfa02Rg359tnRTVOvck7OEaWTfeUoppA-mS1gizD8NM2vyqY
Message-ID: <CAOLa=ZQW_yYaBmMQk7uovGiK2mxDd2R-wY=w8BS-_LXU2rJUBg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] refs/files: handle F/D conflicts in
 case-insensitive FS
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000700225063efa6192"

--000000000000700225063efa6192
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/09/13 10:54PM, Karthik Nayak wrote:
>> When using the files-backend on case-insensitive filesystems, there is
>> possibility of hitting F/D conflicts when creating references within a
>> single transaction, such as:
>>
>>   - 'refs/heads/foo'
>>   - 'refs/heads/Foo/bar'
>>
>> Ideally such conflicts are caught in `refs_verify_refnames_available()`
>> which is responsible for checking F/D conflicts within a given
>> transaction. This utility function is shared across the reference
>> backends. As such, it doesn't consider the issues of using a
>> case-insensitive file system, which only affects the files-backend.
>>
>> While one solution would be to make the function aware of such issues,
>> this feels like leaking implementation details of file-backend specific
>> issues into the utility function. So opt for the more simpler option, of
>> lowercasing all references sent to this function when on a
>> case-insensitive filesystem and operating on the files-backend.
>>
>> To do this, simply use a `struct strbuf` to convert the refname to a
>> lower case and append it to the list of refnames to be checked. Since we
>
> s/a lower case/lowercase/
>

Will change. Thanks.

>> use a `struct strbuf` and the memory is cleared right after, make sure
>> that the string list duplicates all provided string.
>>
>> Without this change, the user would simply be left with a repository
>> with '.lock' files which were created in the 'prepare' phase of the
>> transaction, as the 'commit' phase would simply abort and not do the
>> necessary cleanup.
>
> So IIUC, this also isn't related to the batched updates change and is
> just an existing issue caused by case-insensitive filesystems and F/D
> conflicts. With this change, we now properly detect F/D conflicts in
> these situations and thus are able to cleanup lockfiles that would
> previously be left behind.
>

Yup. That's correct!

>> Reported-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs/files-backend.c | 19 +++++++++++++++++--
>>  t/t5510-fetch.sh     | 20 ++++++++++++++++++++
>>  2 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 69e50a16db..817b56f4ce 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -905,8 +905,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>>  		 * If the ref did not exist and we are creating it, we have to
>>  		 * make sure there is no existing packed ref that conflicts
>>  		 * with refname. This check is deferred so that we can batch it.
>> +		 *
>> +		 * For case-insensitive filesystems, we should also check for F/D
>> +		 * conflicts between 'foo' and 'Foo/bar'. So let's lowercase
>> +		 * the refname.
>>  		 */
>> -		item = string_list_append(refnames_to_check, refname);
>> +		if (ignore_case) {
>> +			struct strbuf lower = STRBUF_INIT;
>> +
>> +			strbuf_addstr(&lower, refname);
>> +			strbuf_tolower(&lower);
>> +
>> +			item = string_list_append_nodup(refnames_to_check,
>> +							strbuf_detach(&lower, NULL));
>
> For case-insensitive file-systems, we instead append a lowercased
> version of the reference name which gets used to check for F/D
> conflicts. Makes sense.
>
>> +		} else {
>> +			item = string_list_append(refnames_to_check, refname);
>> +		}
>> +
>
> -Justin

--000000000000700225063efa6192
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ea191161a94fbd1c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qS1ptc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3NCQy85c1E5dWtrMkhEZm00Nks4bW12UXowbDdWaApVK000Q043ZG5h
OVVIdmVaWHM4cDRveEY3R1Y5Vkt0MUJrd1MvUmplL1NEVWQ5bVIrSUNZZ0RkYjZJZzdzSkJHCnR3
VjkxTU9zQ20rSkhaamMwaFN5OHFqVGFYcjd0Qm4xeWVRc2NCVk1MR0ZVZFp0bGR3dW5SeXhlbWRH
OXR2dFoKVlZYSmJ2MzNzcVlKa240bXVPVUNpYk4xNk5lbTluak9qRnlkc2QyZEhLeVkrQXh0dy9W
L01CVStHNDVoejU4UApWUk5MendMSEdlUk40WXdkVjJTeGFmNzRYck1KbjQvQmVyRi9wOFV5SzBS
MjNOd0pYSVJya2JxcHVUWUkrRzhBCmgvcDRteDB2WkJZcVc2L2FEMi9sdVZRTi83WURLbFQ1V0Jx
bTA5SUVCb1pVRlMvQkdFd3hSRU13LzZEQ25qWm0KbDhnck5GTFlCb2JncWtUTDZES2VQdHVCT1FV
R0NPN09VRmtjZ0Fnd0NFUFB1UTV2WS9kdmdUOHpqRWFueThyYgo0SUxBWmFpazdFMzlsbW9UWHRL
Q2xoUEtRbHk2d3B4SVVXdkFocnV2eVFKaG5HMTRDWFhlcEc0ZmxtRks2aEtjCkhCVjRzS2MxVlRo
RVlFRVd1L0tSM2FuQzB5ZXF1TFNSSmVERTNCYz0KPSs5eGkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000700225063efa6192--
