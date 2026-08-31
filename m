Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38D357D1D
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203143; cv=pass; b=Ci/gIWi+vxGEHPHEbYI0rdXzVDqdeqqIAP3jWIi/WLdHQTiOi/lH+rnXHZ+U1kdBK3lCwwHXDtqHpFPqA++p+sjXtBYvgwrCwcd+2CQZ59EgLa/UIdDIeI2RZxea0vg4XT/ba1NhMxYyZwJsMScFGrddjrqLcOPIPTOQ2OEJ3b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203143; c=relaxed/simple;
	bh=OPfwn/J5kU4tLqc82BUdtdWnbCNTrRgmSo7/XqA6c8k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S169xXvuRs9Jp2i7zqXDMIvZEzeVUf90jv5eHqoU1jtmq5oCTItzn9/gGRSZDcydzUJUvHMYfVlTZBp6RGgAkCbvBfnUK5A5TEt5wyQrCTsrJonIn0m1ux3IzhWBEZXuUt1Vg/iGuElF+w8sntx2G+DUYPsnokXK5oZ+j9LS5B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr84T69j; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr84T69j"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-96723c7151eso1082451241.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 12:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788203141; cv=none;
        d=google.com; s=arc-20260327;
        b=eDVumQMog2TScmPZ7oToBqMCIQeHrlhG60bijjOsWH4hSj9R1tzm8iJwYMyFMNmYgJ
         hvFtjd6vqjd+W3mCRs6rvhsnESNqoCfoRzygf63ihew9anlL8pn8hUddBWEvRM6Eyvy9
         y9ze5NseSQ5xRrt/rUniXtmUyexJ4Kb5vl6fez80jEWeH0xodVFCkPO4HhfN44KQ/dhk
         dODM7Grg4i58WOI+khs/hh8s4drItyHebdbslnZ91ZrF1LIhJDevhGqozD0KIlGu4qhp
         d/WSPd+1uDdpSV1g5vPBTmHkT8+imtzMv3RY3DnaMBlQgusr6qEyzD7sHU/xoDj59Fel
         AGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=JBU0gbEbtCCOGBnx0V4L77RtGrUBTLbj8OpTMt8YpPI=;
        fh=Rn9EFvid+bDsg8CskbihT0m5GvhnTPnaZZUMwd/52l4=;
        b=IHPACmtI1ai+fYXDlntg/4dDiwgl22KY/ftdGUXNyhWXKX052P0KC0r1ccnDkGwIKy
         5rTgXr8pA2vop5BWfMbQ8kecBgJ0o0Xde0bZWzmGNsYxBqJzpnmOuDA/J1RbbfjeywPV
         ym1UdxBP7zFLm6datzUHMBk0/GrYmRYrzNxKvoW38bvqRZygJ5Mcz4u/vmZIBVk0QBOh
         tQTYpmPbX6JMUkDdEw3NWP2iB4n9osewOd6plZ04gAXc8O/1PHeXhQNC4kwK8eZVvX9S
         /tJq6bXldLPhnDZcg40SitCauA2HZ/rR+bjPbFpYwfQjD5+3HO5fex4QkBRIRCswEQ49
         xcrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788203141; x=1788807941; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JBU0gbEbtCCOGBnx0V4L77RtGrUBTLbj8OpTMt8YpPI=;
        b=Lr84T69jeNjPgYGaRJ3wz0UtpYPmHQMWq1hBfG1H9COXnoDyQfEi5bYvitl6X/5blL
         7CU8tOYxwdnxRxTeXwo3v+i00y24gS16AndIVd+t0+W1S0G1hWgbZAQH94tXT3fxqfZW
         hUxuct909j5ElE9lM2j+CPyNGAbinjrKyxSTmEevLHLxRkF4NXjFR9syK7OUqeBkfKV3
         FNefqEUC+gwyn7vRPyGk5P3MwP3Dldytn4BFwzvgZ7ywJVq7HA7HAqQeGyVHF2psV7Aa
         p1kIjItqB9MxbHlTpf3TqhypDTpqhEBLbpV3jx0wJ+LcEBA3Ldx08wKMIh+rLwKl+e78
         wxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788203141; x=1788807941;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBU0gbEbtCCOGBnx0V4L77RtGrUBTLbj8OpTMt8YpPI=;
        b=PkC1h5HTUyPYKDXOGHJ0cNR7dwF61Q1pX/tRKfVgTK/5vGof5vsahkWsSrt/PRJYSP
         kN465kFQKej6MCHLquotYESozZ0oxWkw0dlwmK0oxmDaah+pqcNBJEKxb585ROKLB4ad
         jVsyvJIzrvljwvbBMhhved3ML1kGoruTwudVxk3q4zB0gkVkjJMVclvzQUjaFMQtwA13
         0ECTqX6KJpd9KOr/kqvvTKFqCuosESixyt4BMS4jS1KZH0fdRQl1D8SbLCKCyOZgHM8/
         gmARwZSA6/XUQ7tbMhY2+ozX7pJQJlk93kNZYbwLCbtapzpRzkf18EpeabyMzgwhNNIp
         MmjA==
X-Gm-Message-State: AFuF++ljcNobKDuoTBtgRRRDYIkYZwxJv/qCRS0NGVEH69IvKDwu9WHC
	9MBu9/+cPCNXdgWQJlCr5pLjvCBYTYbXHEdecQ1W4mg/6jxeWSFYlq3GxenKGOQ7I1GouC/MXLD
	YlQh6od6RYQnfiVc53CgD5axiQiDjpwM=
X-Gm-Gg: AR+sD12PvSqtYgtR/utT85WBDSkVD4ZrUBkYhzeXP3wmM6A9mu4KkRm3wb8zPYQMPfs
	5/cFgPRYWJJdnqZw5gRx3u74yATHmAN2rvbDpr0dYrC+1KFKh+xF+G0fzxxgEMgZHnx/kCcf5uO
	v03z0QG29HD79JwOW4dyuBE/hY8NMYMYklsIfpIKNwizOq7k/S7SPIgWNYzFY3mav30mP4MtA0q
	OD6fempNWJtQQ8qa81aNPQqZp7vXD2FnkAvpGwLkIV/m/R1/2pwAI8GSGc38RfNSWa3ehXQ6IS4
	+qsV+kQXsWNnHRYP1NPMlgDK3iQ4T+7PD6m2rIpLicEVDpuASzTjJuWo9ZDlYS4mugRCE8kI+It
	8e7sGDZlGbspEswC3HJBinY82+S9oZujJqqk=
X-Received: by 2002:a05:6102:8002:b0:779:dc0d:2b2d with SMTP id
 ada2fe7eead31-78598f4e1acmr8486454137.8.1788203136084; Mon, 31 Aug 2026
 12:05:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 14:05:35 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 14:05:35 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <apUi62Q_0CFBbBVO@pks.im>
References: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
 <20260826-758-introduce-hook-v4-2-6b14975ad957@gmail.com> <apUi62Q_0CFBbBVO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 14:05:35 -0500
X-Gm-Features: AcwNN1UR7wJNAw3U0ls_68wUs1kSdsjLVMW5mW6sSgDkRdv_QU7RwjYJfUXmQZM
Message-ID: <CAOLa=ZTrj9LRFHDXTYw-fNvmA5qOZrrU-8d-3aY1NB2J_zib5g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] receive-pack: move message generation to separate function
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000b69053065a5c7c7f"

--000000000000b69053065a5c7c7f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 26, 2026 at 12:19:38PM +0200, Karthik Nayak wrote:
>> Post the reference transaction, both `report()` and `report_v2()`
>> generate the message to be sent to the client. In v2, we also add
>> reports for each reference if available.
>>
>> Since they share common code,
>> move them to a common function. This will also help the following
>> commit, where we will need to regenerate the message during hook
>> failure.
>
> How about this instead:
>
>   After git-receive-pack(1) has committed the reference updates, we call
>   either `report()` or `report_v2()` to report to the client which of
>   the references we have updated successfully and which updates have
>   failed. The only difference between those two functions is that the
>   latter also knows to provide a more detailed report about how exactly
>   a given reference was updated.
>
>   In the next commit we're about to add another site that wants to
>   generate these reports. Refactor the logic into a shared function that
>   can easily be reused.
>

reads better, will swap in.

>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 86933d8d7e..70a686c142 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -2530,67 +2530,71 @@ static void update_shallow_info(struct command *commands,
>>  	free(ref_status);
>>  }
>>
>> -static void report(struct command *commands, const char *unpack_status)
>> +/*
>> + * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
>> + * For v2 protocol, set `add_reports` to true, which will also add additional
>> + * report per reference update.
>> + */
>> +static void generate_response(struct strbuf *buf, struct command *commands,
>> +			      const char *unpack_status, bool add_reports)
>
> Response sounds quite generic, so should this be renamed to
> `generate_report()` instead? If so, we could adapt the parameter to
> `detailed_reports` or somesuch thing.
>
> Other than that this patch looks good to me.
>
> Patrick

Yeah, I was thinking about it being too generic but didn't pay much
heed, since you also think the same, I'll change it.

Thanks

--000000000000b69053065a5c7c7f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6b0f8dc1c729ed50_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xVjBIMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDU0Qy85ZW5LZWkrUWM3ckF6WUVYN0lBQnN0VzIvNgpYM2RTQUdlRmU5
MXUzMmFjeWg2c1BndytPNGVHTXdISWxwcDJjdE9FSWRqUUl3UlZobnROdFVmL2lxaGxwU1BkClBM
QWMvTk1vQ0hTMy9mTEJNS1JoYVR3TDNEMEt3dXdlZHJjMG80V0xDZklHRmloR2R2MUkrdnkxYjhQ
dFZGWnAKSXpBNmVLZHROc3cwUm85bjU1TGNjaVJNQXVaWUZZSXBOR3N6ZDhMRE5WWkcxNXFYemZj
KzlBWXUyMmtnczRPaApNSWtHUlZnWWVRSnVXYlI5ZkZwd1laVHVSbVE2VzA0YlhCRS92Y055eUp2
K2pVOFcwY1JYWTBLaE5vclV0MU93CmZPaEg3NUdLR2o3eFBjMTE3Znl0U3NCN1M5VXhLVG9tVmxD
dzc3cllSWE5ZdExoNHZxKzc3NWpjN2hGMjlybDYKUStQQ1hxL012Szk3UXR3N2d4TjYrbGdYWHVB
bGxBK1A5cWsrdVNVYkJFdVI5WHg4ZHZvV2RYV2xlVW1SVnVjVwpLSTZqVVVCU3NlNnVDeXIrSU4y
RzdTNzBSRmN0b285MWovR2dCSVNlcWFnV21qUDQwaFVFckF4c3NCeldMSmJpCmZyN0lUTVFBS2hZ
S2lLclRwSlltQ3ZCenBnZWRaK3RhVkZFU2RKdz0KPXl0SkcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b69053065a5c7c7f--
