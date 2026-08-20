Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618243FD36
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229673; cv=pass; b=Tbfz/Rr6YoaQBIuVk+nyTzZ5qjiruPsVmtliPHIdZy63NEP1u9flTB+yyvYI9lyQBLrDdpSMtcXYD/FhQ8FbxZ6zKo7C4D6i1yljXibNVky7JRAQcOD0RHRy6hjPZWyl8p16jw5p9hcOLbS8crWXIYW1HP65DenBz+jNF257P5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229673; c=relaxed/simple;
	bh=fb8fxBmKpGDEJQDWb6DAqNpmfNmYvdU2CxIGQ/5ziII=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCQ2+TOkHsksU7AfOFJyY6brgS19/LOFNbRTBJXBPHqspYoNFXVa+nhF14qJ3IZAYMWYANvIDQ20jLny1M4o10naK4BFMNChancHUiFmdOo8tUobyc1ZgA7v0TPRgWL24r8DTMLZS4zPf3UqoayZM7JKHtwlX6fK2UsAYrYdfKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbg9ODlg; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbg9ODlg"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bfb5e20a90so1753958e0c.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 05:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229671; cv=none;
        d=google.com; s=arc-20260327;
        b=YOFj+JFoL0iOPs8hHUtDsgX6zPmLtM/7ViNUNRm/kOn/HVmFbFZQtJcUxW5BMWEzah
         0CgLj1p3E8ZllGbgpDLwu2asMKg9JkcXH6nf/+gp8IaBIM1v7TmfugSUeDGwVbTAOg8X
         K8Kya/9vqXnX4W1IbeR1UzaN2xXP5l2UcVSq2NXw2jjR51kab8uycKFdQ7UFUh46WokI
         PO5In3jAOkFdTbhQMq6e0rlCMLgiXkmtRkqJc4ECqQZXgcbdZ8JNG3FTse7i34UhNj0N
         zRxQ6EL37hzb4zWvgABTmW6pUc/N+mc2m6QX3UwjvYePHhW/xDM60nwvuBSL7Gmw6fzs
         5k6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1T/eeTtDN6Gj9Tiu1xlfHHjLKA2IRfhyW/IXDoPTk68=;
        fh=B8FPOJCMjunalJKzyHUal576UouqEXyLMWS+I/GK7wo=;
        b=o+XAEbCAzHp6PTDnJx2GxCU1jsLyJlmzYpAVPTzq6svhfHuwy+hZWomQ0mu4+yT1R6
         rVkuz5LNsyFh4mXZPNJkFSBq2kZ5IpBzxPDdQT9mdr4DzvEUz8cxR7OXBSl7ReFsNdeW
         iDepM2xi3NTWS0WMA8K7VY/BlCMd+N35VKTvnFpCuBYI5ZRs9/4yt+bNpUGR7hRi1EXA
         i/yAxjH76KgoW3vPNZTSiNy7EVjCLfnVa1VOtqpRC/uwoGGAoWfRiTTehJzVcGBxixHV
         ZBl9c2a+KVn9nRLFN7PlEfx+7uK281EiTv+AeMoxQgRlV9pzeD67QRniJi+FWJwFC36V
         hvPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787229671; x=1787834471; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1T/eeTtDN6Gj9Tiu1xlfHHjLKA2IRfhyW/IXDoPTk68=;
        b=Wbg9ODlg6ry8yobToAYxdbhi8sFvpmlawMphAKjkWEmUtkN01Riv0zjqXMyKfcTW3N
         gh37PPYziQYnhastdzeQWT7NbhjYRdy4qvxw3I/rJDKGmOgnZi+LrNJvSe6y2EbDgGtV
         kLWhDBrKDpWphl7JYcVBdvvTcjoY2D5Lvr+n1AsScwPaQqXKiMQdQALb0xglJ84+UvWR
         ef1c5PPrJ4I2db3jdR7wqKWlcMuw6i6BfFsOS7fipf/OJ+ag1d3t+SJA1hHAJWVmQfv6
         hK2SQWfHlRhp2dMu/qu+Zl1TJOv4/FG86xJefSgIzYV1Q54uKhwfikacnTGEbqAAzzv+
         80ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787229671; x=1787834471;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1T/eeTtDN6Gj9Tiu1xlfHHjLKA2IRfhyW/IXDoPTk68=;
        b=b2enBRKkrtASbG6e95QgxXNFmrTQ0XtSy06YBLRia9Phk4QuN0VF9PR/wds2Dk/g/S
         1vOeaB5VWqlov6Y3MyYjaMOhO/sGrrQ7AUcSHU8WVz5WMsOg9FJWDVWzcOLidQMlNrup
         2A2PXFBHz/p9Nz6Qaevp6SssTZmrl35rA4OXF3yIpMkZTrk4A8an74XLQ7oayXlkhmHE
         V2bJjYrTowAqrvvRQjMf7PJeMT/S+wqb7oLlrxjiWQ2l6WbGKyL6LZ+wVsqic+U3j+D7
         4V9VIBSTRwaTTcYqaQj4Pd/GlXavvV4P+PB3DBR9hC8BM1FOomwAME8b3s5gShTdT7Mp
         e+ig==
X-Forwarded-Encrypted: i=1; AHgh+RraXcdqNtBgskCo1+o2kOckhK9EEiMcTWtuZdRDJBuqTy5JPpblHuHm+4qZ7aWshC2Zrp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTept1mPshU0X9ecTluwWQDIU92mNbnnYwfPsOELLfRjikoQFU
	eVSHyAbW7rvZwqd2rxlon10KkxX6vW+5Qn+ipNa9x+8JBR/ukGTkhwpj7aXJ6L/m8Gr2V89S4ld
	4WvllSIFbjsEqNkNeAuGe2VPuugK95MAcWhzW
X-Gm-Gg: AR+sD12Eo4QQoNyeXRExce0CbR+70xcn8EB1CQWa62MU2+2r321LsH4BQkKlvXFRYbg
	rlygQIx5wINpTsYscDG/tFr9xtIeTHoL7rAUJHO4P+i7d6ftHhxVJp9GCpr8lTteCvhH5fv5WLm
	nsSqx7kYFH0sJ9Er9eK/7ciR7N8+hmrGMvl5UzjJsSTHObkt4YSOzJuzf04enVva4gM6UrVUGQF
	Een5kUwtK2RXaQaPR/owO2bDSJnVqJNFlmxXbQYoIDanVHlnZrzAdeWcIfxRcD629Z/Jv2U7dcg
	M143eYGqNoniD6aNaQxfPjJCzXrRR3xxnRn8Zh9bR69wUuYaaSJqKEbZPdwiO0S7oZb6N1+LW2j
	LTUBCd1fSIOx9T9CCuC9ODR9OW6FRoEzDfE8=
X-Received: by 2002:a05:6122:790:b0:5c3:2f5c:55b3 with SMTP id
 71dfb90a1353d-5c5e3c085dbmr5453082e0c.3.1787229671209; Thu, 20 Aug 2026
 05:41:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 08:41:10 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 08:41:10 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260819-pks-odb-generic-corrupt-objects-v2-2-a984e3a0ad6f@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
 <20260819-pks-odb-generic-corrupt-objects-v2-2-a984e3a0ad6f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 08:41:10 -0400
X-Gm-Features: AcwNN1V4pZkFqof9M_IfN8I4OSdI6NmY21pnPHFXRImMaIydjzsu8hLFn-rlMIs
Message-ID: <CAOLa=ZSCf3CvTwtgj7RXncT6zPhyp4EX9r=g55uD+mTA1zp-5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] odb/source: introduce error status when reading objects
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000af5812065979d53e"

--000000000000af5812065979d53e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `read_object_info()` callback of `struct odb_source` is documented
> to return a negative error code in case reading the object has failed,
> and zero otherwise. This is overly broad though, as there are two very
> different kinds of failures:
>
>   - The object may not exist in the source at all.
>
>   - The object exists, but reading it has failed, for example because
>     its on-disk state is corrupt.
>
> This distinction matters to callers: when an object is corrupt in one
> source we may still find a good copy of it in another source, so we may
> still be able to proceed with a given operation.
>

But isn't that the same for an object not existing in a source? If it
doesn't exist in one source, we may find a good copy of it in another?

> The "packed" source already distinguishes these cases by returning a
> positive value for missing objects and a negative value in case reading
> the object has failed. But it is the only such source that distinguishes
> those cases, and the returned value is translated into a negative error
> code by the "files" backend anyway.
>
> Introduce a new error status that is specific to reading objects and
> adapt the infrastructure to return it. For now, we only discern
> successful reads from generic failures, which mostly matches the status
> quo. In subsequent commits though we're about to add an error that
> explicitly tells the caller that an object does not exist.
>
> Note that we keep the "packed" backend as-is with its positive return
> code for missing objects. This will be fixed in the next commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c                 | 16 ++++++++--------
>  odb.h                 | 15 +++++++++++----
>  odb/source-files.c    |  8 ++++----
>  odb/source-inmemory.c |  8 ++++----
>  odb/source-loose.c    |  8 ++++----
>  odb/source-packed.c   |  8 ++++----
>  odb/source.h          | 22 +++++++++++-----------
>  7 files changed, 46 insertions(+), 39 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index caf1d0f542..1b37b26376 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -547,9 +547,9 @@ static int register_all_submodule_sources(struct object_database *odb)
>  	return ret;
>  }
>
> -static int do_oid_object_info_extended(struct object_database *odb,
> -				       const struct object_id *oid,
> -				       struct object_info *oi, unsigned flags)
> +static enum odb_read_status do_oid_object_info_extended(struct object_database *odb,
> +							const struct object_id *oid,
> +							struct object_info *oi, unsigned flags)
>  {
>  	const struct object_id *real = oid;
>  	int already_retried = 0;
> @@ -696,12 +696,12 @@ static int oid_object_info_convert(struct repository *r,
>  	return ret;
>  }
>

Here and elsewhere. Shouldn't we explicitly return ODB_READ_OK or
ODB_READ_ERROR instead of relying on implicit conversion?

[snip]

--000000000000af5812065979d53e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6f4c66bdc4e22c2c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRzllTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFFDQy85Q0tNakNNZnpIbGF6NTVhdGRocEpqT2xGZgp2YUVBZUlDRnpu
bFdNTXVheFdhQlQ2M2k0cDl2ME56eEpTT2hVRGl2d05qMkZGSWpNTG1KcDNnRGo0MnJaM2tmCmtp
MkowYlpqUmhPd2lmVFhWSFpuWVV2WUJEVVpJeElCbFlUamNnNUNZNG4vek5NeGdlRytoWXQvQnov
bFBvczkKNzB5dDdVcFhkSGZlSklmMFhjUmc5OTYyWnU3OG84VFU3Y29YZlBzZmlMd042RDRtN0d0
RkVwUnh6TW5zSFVNcApMdGZCSFNkckpLVGpkUUhVNXMyM2ovdmFSczdyeXpiSFRRVzk0d3JycjJs
ZUM5aE1TTVJ1UUh3V3VFYnFjb2FoCjc3QUxabVRqbXVUVVZhbFZpeGk5S2hFdlZMbE1jNWZab20w
Snl3aHZWb3crZ0dzZnBLMllSV1d4TlltZXNxOS8KRDdVZ3oyU3pQR0xBeGEwNWE0d1kxL2toRzgx
WThBUkoyTlk4b2xYRnpxVUg4bFF1OTBJOVZKSUM3ZjV5enlFcgpkQ0s3VjUyd29FMm1hQkJxaFZT
dkFMZVJNUmd4ZDhFZ3BrNFFRbm9ZdS9tTi9xc0RuYmRVTGh2T2x6WDYyYjBsCnk0TmFEQnorK3di
bFJlUi9scVFTVkRCUDk4ell4dzBTckFuNVdkQT0KPTZxN2IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000af5812065979d53e--
