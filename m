Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12961274FDF
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493729; cv=pass; b=Dh4oUJdnEqN54/VYqxr6rgvghsAV/JhU96IRXoIjIW6XwXd4s+a8YHDFvGi4MHCO0AkRvtQub/7X45teZbUXXOonRuxoUwlnwcWq1mSzaVnkqWu0a7iybxl+fCGUk5vqDI4RRiD/wE/CboXJxO68M7AW2ek2w/dnaEg1FzCsDUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493729; c=relaxed/simple;
	bh=vZwFyh63VznhkqKI4TzZZdzXqJb8Ps6QHhBa4P7yXeA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m43wtxPwf+G23jO/LQKMStk4RUn8X0dIcK4NnsfvX26PuEuritGFBRyMB0HyB+Eqz1Y51tfauPqu7IYtZPJaWDqDo0x2/D/SWi+r5G3JQMpVQ6AW67QsPf5U7iOVjZv2hz0D4/eKV9isoifx2gHC8UIacwSAGo16l3n2oo37z1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkSy9BEp; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkSy9BEp"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5674cd243d9so1184060e0c.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 01:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771493727; cv=none;
        d=google.com; s=arc-20240605;
        b=brFMxlMcLuLss4Z5emVPY5A0de2BkOQiZQCgegiC+rsZ/w3kevQdvV9bFAjUWHps1p
         9ayIb0lAYYIzveiRzxFWFgpDjwSOHirGoWAFFZhpW63zMzwG3qNY2eq+OGoQCZ6lfL8b
         WvbSWgvoGNRfPqHQT76tCvALu0/2cRWNe8TsVBgUQlV9hS14TD3SEZwidVfDlNPDlCCd
         /h2mhHnILo+svtOzlaItpHrpYn6xIYhjEKMzV9gxU3wRu41Ix3he4EDtwTtBtnVToFZh
         ENoFPC4vP6x1h4WuAHG8wQ38TUOf+W1d2yePqXlAe3FGpsDMjvnbgdVpnJO8CCOh16IH
         C7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Fr2xHUEJdzIH4LCTvpqkwDxotAEdideVG0m6S8cjYHM=;
        fh=BeFMx2pc2pmCFRZpMQj/S72cOoJzz6l8NLKzSWgoIFE=;
        b=b5+haUNyCPRDGaxNjwQyQRkQFuDArvfbP/GFvSHRhv160lyfM34tLAO7T1DMeH6hu/
         0/9QwBk8qej2wL7WH9Z1oLfuYeo0ipBuwobSzxw3+58R4VpziadDiyJOLTJ3OtrjHnXn
         U3TWEaTdK3BicbZSWcnULf3bDSVMQOrhX9dWqmfP/SV+hRAqNIhqeMnhkB+nw0pqsQdM
         YcLeFnVpys4WowxajXKAriQzesKFUWqdo0r8L8C/9w9jzncIGyERUonzL+KPFwr1Z++J
         r4YkVIaD9Srkj5SlfsgKiTV7Jlq03wNGMjKpsCMkTOresV0LA7jbaj5CF2jKxq9A9gNT
         JYJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771493727; x=1772098527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr2xHUEJdzIH4LCTvpqkwDxotAEdideVG0m6S8cjYHM=;
        b=lkSy9BEpKBw+tbstweMx4R5dH+5eAXyKO0xFq81wvkNfcbwWIN2UsDielxu4mgcPUI
         iL/OihUfWc61t1bE1vw3IDqS/95EIFJsjj9kT8thKpXKSkfih3XylieLENf08uTChM31
         ejSjdnM/duX3C/+AkbKvs6gquGj5Z+Gju8hb0PnpMSEwoOnsw/Ep44QJmSLHrlrRTnso
         4y1JkIMoaTs4lVpSJQtpUP8pRLmJo6EtyeJZ4Io1unDJioitJ6lIZnlz6nvHJ9MBoFYU
         Ty99Pa2ExwpZ2hVjS0jXN7+C8bfCUlcdqEcQDTUvgvlgO40j1vEqKf/+tV+10cV4cido
         Ntlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493727; x=1772098527;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fr2xHUEJdzIH4LCTvpqkwDxotAEdideVG0m6S8cjYHM=;
        b=ZiKbDoAxHXFAtpHT3miLXY61NhXnNvs+n3SDR2VXw5yuRfbbZrgdqnjaAiqiGp5c3M
         M7Ix+d9w4QUyfRIrmpK7OLqYEy5AwcTK6YV4pSz79izsU8d4ACCQEkDsoPFUjX4JiPUb
         Cd0rCRoomzxyCN6e8sW3KLW1FAOJyeJFQNVhqn3Fa/x15ljgT15s3luGIJe8z8l/xVxt
         nU/3Sxx/ujgJeZrd00Sgn55w5IuhCedsUVlnRRyjTQHZpRTwY3Th66fgHD394IFlZmXA
         qeHVSC60ghd0pCFGvSC2dskqStLY2lFeIP7jYcGvdVlChvnNvtje3Nsdhe4y0wbsuCyN
         PcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXexnKJ8RJRj1bEbotomibds9koIg3YUwuy8WU951S707mPl55rvqkue2i5CLvHERswC+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPIdWqItWn+912BHGyH5tynWQix5uNHW+7nsQclG9bhGKGhXH
	XGPhK/GKYrdg0sGyOiiyhndCQPz7dIXTlY9uZ54rwoQmYnRvPg5DU0yCzP8eBRoS9PRCD/i9a3j
	9SQed7lnGrFPJCy28C4sP98y93I8RGPo=
X-Gm-Gg: AZuq6aLy3Ma0DvWCUTCo8bqoFCHT6E8hK/VN07vTjp93odfzpysfJDJ57Z63uQcQPpZ
	IXTI4mDlUmKsJiWckhHTzpYnCXzSxIjDYBx5BBBBn/nuJ9H6Ypalu9rXygukkImlajBOvsM/Xqg
	Hx5W2kWxZgIxQQ/jdM5SCHD2+pP7A7fejSdWRpxS49AHPa/ZiEdg76vtWWAlMTmFh+7UQIEycWx
	9jyadZlHE/+scpaJjL91pcviaNALol+2alx42M4ROyk+NhRcHFas0Dgk8XF8edCu1bNCZ6VSAMH
	1ElqwkcdLn0lWYnujdWdTlEBhfnIOsyETOlKewd5K3XNjZW27/Mh
X-Received: by 2002:a05:6102:32d5:b0:5f7:2566:5be0 with SMTP id
 ada2fe7eead31-5fe90bc36b2mr666940137.21.1771493726741; Thu, 19 Feb 2026
 01:35:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Feb 2026 04:35:25 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Feb 2026 04:35:25 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87jywacbrj.fsf@iotcl.com>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-6-86a82c77cf59@gmail.com> <87jywacbrj.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Feb 2026 04:35:25 -0500
X-Gm-Features: AaiRm52KTUZxsIzvlvBoa8UEmlaJahagrXkXvHs8s-ODWjS0SrgiTtzraHiMSnQ
Message-ID: <CAOLa=ZTs-pxqagQxMBB8xajhfEnvhn8i2uOm2EPD187TopCCxA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com, 
	ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000004dfbef064b2a0624"

--0000000000004dfbef064b2a0624
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Git allows setting a different object directory via
>> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references. In
>> the previous commit we extended the 'extensions.refStorage' config to
>> also support an URI input for reference backend with location.
>>
>> Let's also add a new environment variable 'GIT_REFERENCE_BACKEND' that
>> takes in the same input as the config variable. Having an environment
>> variable allows us to modify the reference backend and location on the
>> fly for individual Git commands.
>>
>> The environment variable also allows usage of alternate reference
>> directories during 'git-clone(1)' and 'git-init(1)'. Add the config to
>> the repository when created with the environment variable set.
>>
>> When initializing the repository with an alternate reference folder,
>> create the required stubs in the repositories $GIT_DIR. The inverse,
>> i.e. removal of the ref store doesn't clean up the stubs in the $GIT_DIR
>> since that would render it unusable. Removal of ref store is only used
>> when migrating between ref formats and cleanup of the $GIT_DIR doesn't
>> make sense in such a situation.
>>
>> Helped-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git.adoc |   5 ++
>>  environment.h          |   1 +
>>  refs.c                 |  23 +++++---
>>  setup.c                |  55 ++++++++++++++++-
>>  t/t1423-ref-backend.sh | 157 ++++++++++++++++++++++++++++++++++++++----=
-------
>>  5 files changed, 198 insertions(+), 43 deletions(-)
>>
>> [snip]
>>
>> diff --git a/refs.c b/refs.c
>> index 87ef54abd4..6b3883a325 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2192,16 +2192,21 @@ int ref_store_create_on_disk(struct ref_store *r=
efs, int flags, struct strbuf *e
>>  {
>>  	int ret =3D refs->be->create_on_disk(refs, flags, err);
>>
>> -	if (!ret &&
>> -	    ref_storage_format_by_name(refs->be->name) !=3D REF_STORAGE_FORMAT=
_FILES) {
>> -		struct strbuf msg =3D STRBUF_INIT;
>> -
>> -		strbuf_addf(&msg, "this repository uses the %s format", refs->be->nam=
e);
>> -		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
>> -		strbuf_release(&msg);
>> +	if (!ret) {
>> +		/* Creation of stubs for linked worktrees are handled in the worktree=
 code. */
>> +		if (!(flags & REF_STORE_CREATE_ON_DISK_IS_WORKTREE) && refs->repo->re=
f_storage_payload) {
>> +			refs_create_refdir_stubs(refs->repo, refs->repo->gitdir,
>> +						 "repository uses alternate refs storage");
>> +		} else if (ref_storage_format_by_name(refs->be->name) !=3D REF_STORAG=
E_FORMAT_FILES) {
>> +			struct strbuf msg =3D STRBUF_INIT;
>> +			strbuf_addf(&msg, "this repository uses the %s format", refs->be->na=
me);
>> +			refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
>> +			strbuf_release(&msg);
>> +		}
>>  	}
>>
>>  	return ret;
>> +
>>  }
>>
>>  int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err=
)
>> @@ -2216,6 +2221,10 @@ int ref_store_remove_on_disk(struct ref_store *re=
fs, struct strbuf *err)
>>  		if (format =3D=3D REF_STORAGE_FORMAT_FILES)
>>  			return ret;
>>
>> +		/* Alternate refs backend require stubs in the gitdir. */
>
> I find this comment rather confusing, you say "require stubs" and you do
> an early return. I had to read it more than once to understand. What do
> you think about:
>
>  +		/* No stubs required in the alternate refs backend,
>  +		 * stubs only should be created in the gitdir. */
>

But that's exactly what it is, this is the `remove_on_disk()` function,
and for general cases it makes sense to remove the stubs, but when using
alternate refs directories, the stubs shouldn't be removed, cause doing
so will mean the directory is no longer recognized as a gitdir.

>> +		if (refs->repo->ref_storage_payload)
>> +			return ret;
>> +
>
> --
> Cheers,
> Toon

--0000000000004dfbef064b2a0624
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: be1d6548a8a27a55_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVzJWd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3R3Qy80blRraGgxdGhmMi9NbmZibWJhT2NQbUY0WQpISEpXWE9UQXJ4
MHF4WlpxL3FKMXlLVmxZbXU5SGw4SFB2cDY2WCtYMm5DcjhWalhya1ZBVXZubVpFN1A4VmQ3ClRU
NFRSeXNaOGluZnBGaGN4YmlwZUtWbzBXa3lMbnhhZzFlWUtzYXByT1BBU0pTZkZoOG9CZWpnVHpt
QXZjaXgKQVlKMndqd1FRYjJuUkcxR0JoWlBVcEVCbEV2cWhOMjE0Wk9tRDZzYTFOUmRYS21hWXdu
YmorMzlJZ3RaWERuWgpqUE9KUU9FaXl2YXpuNGJSNHpLYVREZVFldkdUQ2twY3BtZG9rN1ZJWXFV
Yld5ajFwSVlqeVZDVW9rZXFEaXRyCkRXZ3dUTXZob25SVGI3NDJEdVhpSGQrU2NwS3pKajNsbldt
R0lEeGhveEt3ZUVCdmJ4OHRDcmNhNDM1bm41Qk0KajFvekJWbzlxQ2JPdjFodWpQZ0g2Wlk0b3dm
M2JBbENHUjhwdVh0OUpSVDZ3WnlPNGw0ZFErMlZJOWsrd2ZJVApLNzc1UTNTMVN3UkF0STVFZ20x
RG1mUlYvSE9nZWVzRXFWZHZZZzJCNlFiZFR0TzduSjV3ei9ySGwxc3BaczNNCmpOK0s5UlR4VWJW
L1lCQSt4SWt2elNVMHgrM3BnQTJOWVZmRlVUMD0KPTZlL0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004dfbef064b2a0624--
