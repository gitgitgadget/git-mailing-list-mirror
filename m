Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699121;
	b=vlliqo/+Y4NJ/cdPmbn+CXwmReYp9fMnZTEy6DWappoJhffnTparjQCYqed5NbZIGlPZ
	 wPcmI/WdF7spe0VIxuM9cJRURXSi2PvggoVI2KvtnpRdiU2F2zNyAjEM6NVvChbYPKip/
	 soX+LbxmtGVznVfDwsmkftwg2RfNUOSJ3cmIRPtWwie9HyuqitPs5tyhZWcBS3nYsMpeO
	 RnHMwVEZ8p39qcV7goKiQp4jl8CMl3fss9MPHP5kBfNDRNdkWtW74SiZSPHiLxuJpmerD
	 DgBzx9spDhokRpRDnb1s06dfvwNKTn7CFb6vL71PTFrBQ41THXTfhwotvK35FTG8BmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jejg7yn+HvH40DqcCRAaRBb1UoPGwYjQLoTGlI1SKRo=;
	b=VDp10zWK4I0UsmyhF5XkTYF8yvCYuJlGm04+Q8Km3SLikTytM1PhC7Pdh3nIOS22kaPg
	 A/3V1IKdDF1MCepm348MfpVe5HWeNanib4V8n2BwO74XX0/5augdpPXiDbXL0wTIX9fMA
	 N6woUtsCb1lVugIKzSmmacC5Zo50AL//+qJc9Aa5DGTiymirjMLpnO4JO56/2Mr3o8ESD
	 AZEQWXtUn8jkysDzoqQ+UydqfLAFMs8lNXBtFQVOgo2t3eUI0WIuBaV4F+BA8fhu8tvLw
	 iGHAMaW7fu0LnKI72wQwKGXaJ+/RDLB3PNJRlJZImDEXroWHoEIV9F1Lf5qM/ouqCew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ykfOwqBk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030C606A32E
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 09:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5030C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ykfOwqBk
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so2532673241.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 01:45:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793699120; cv=none;
        d=google.com; s=arc-20260327;
        b=H2kw7RDqCKP+5mGJyDdQph9FHgrGj9ehRVgBVlP9sLcA5QvmBj0LIpkNp0Peuy9MAJ
         tuyAjyeOsKsKIIHgOdhsPx+MNJyfCdpEh8fV0lzeii11ZadXMHzQOYSOzt+RduuPENqv
         jjTwpfJwtTZky30AVzMG/AQkqHCAQza78mX05nSf4DAeSo5TqeJKH+nXdncNiktTINAN
         XuBESEEE0g1YZlbydo5iR475XSQAbnkqKt6HN13YxOFso9mHbp0kVnx6MBN1AgxFulWX
         TAsBdbe6F5+ZlLGbwHTaPu4D17W7sZ1edwGI/TP4HwPiTQVL8bvikcvDeedydwVPD5H9
         Dp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jejg7yn+HvH40DqcCRAaRBb1UoPGwYjQLoTGlI1SKRo=;
        fh=6+nl0nkFwf+uofPLyLU05Is6w6xvGE0LFwDiQ7Vpg5M=;
        b=g41jdp1lfAjesljWlA39hCw0Vz1muD3QbYpxxUvaQdt4jZrJgX1i4naMuMA9bEtAyR
         qalImvX3z1jWn7WNZin6Fq6lus39ndSHKBzPO3Lzhrjr4tGrmznuxG5XtNr1A6gOFV63
         k/l3LbQBktkbYJTrLJ6Ukrx2hhkldKSsX2kFxm2h+k3/8FOXSyVhQzOFK9pV8QJt0ipu
         +MAlKT52GJnSN0cy0/dFAeEVZK80rp8ua0MpMjYPNQCrZrgxUVljmSU1vC4o2TuRo+iN
         mIboq/bdo/v3acLoqdkfyYNUcD21gSL10051wd8c4QxpFtR0rui2aPyqp4YWLwWZkj1X
         Hlfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699120; x=1794303920; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jejg7yn+HvH40DqcCRAaRBb1UoPGwYjQLoTGlI1SKRo=;
        b=ykfOwqBkTExWNHYriT2uuL8lZ9LhjRydCXHNyERpL4HKxYTVOKXRKOctxWURSAP9UA
         sRXjXnD9uI/5zBn5P3BnXOc6/MqT2PDK0f86iTdjX0ekxXaGpvbP+tBOPRQ+J2gBkNuZ
         xYzX842M4VFS45ee1F84rlCGeYyn4j6j4ac+RxW/TYw6kjGQLjlAv0pPFl3PgQPQGZfx
         4tVc7S3jHJh+fHo/lb28690soWJkwRiugJWz0yavc/JgJh6Iw3itv56N/EGv1r5G0KvS
         oIWbji8LTdNlZhoMP9wEp8zbwyrSZ1XW4RRt0L556uTwBABZ7iA1N+aMlAI9ZtJvE1md
         DO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699120; x=1794303920;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jejg7yn+HvH40DqcCRAaRBb1UoPGwYjQLoTGlI1SKRo=;
        b=zVRP4seEQIBM6fERSKNviejefCOuVMsEnRyQ7IsM2QGSqOs4OEV06I6CIP9OLaGJqM
         P1QHea4BgdTh80PIG96c2UxJlVQJ0UmJN+yj+vMunAWX1eWvdn+KqMv0VOrd+t0dk77D
         84sItG3v80Q/u86q3inaOs6KVCwvWcbuN902LyApOehiD501msT0V9T9Vi0zVnui/dfr
         JYRrdy3P2NguYyY4u0YrDEqc5qBI3Cb/zsBMhC/c4wtQJpfiZzNfikRGxHODFX6/7Tuf
         2stiTuF631J5U/nYmIuTD1E3Ns+hR52NgtBpoB/DtR5WxkYMzOwxMCnO7/X3OoRwLBrJ
         WsRQ==
X-Forwarded-Encrypted: i=1; AKwUvBw52xQJUCU+/qKRtVjJV+mNVi4+dNML4iZ+cu25hCj/8Gs7xYZFdkv3Ky3tVyQpCVgGSvA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q/wcW4a25oBD4vTiaprE1dIeqa605TEg21u3FEn7mqJvVMEI1
	zinEZYSlNbnDMHOl7G/1fDbCciXuyTYSOTaYwG7DaRxH0oQ8dcKllEUrtEBKP7Hymic7ydOw7mR
	BL9nnG2pli9nwZLT7sbtoYzNih0iV+4VAWA==
X-Gm-Gg: AYBFou0siREz9t54ZkywXjlx9xz1S9urtLS5T5pNE9xKOeSAqIHVeARTKLMOIL8/hCJ
	IeZQGRttSyJoapl5K6q19P8ExBrtmFZsyBM8mszPmQV1RQl1we73WiE//0QhiuCjQIVYguD2vk7
	ZW7vJhcygPhpnWb7aOoVJL63oebrBb1tJ/dKFMnoWekP7y3dp7hdhx/J4c4FW7DS8rqHWm3sre3
	J2w8yrcVmQd/tCYHsVuKjU9EJq/BIQC4UILNAfc+2NbYG0RBbxHmVoRmKcFptnj9r2v+gv08U2C
	Ceru49ZI6Ey8kxIvTIzIuSLhRpBRdAjg9H2XZJA0ezb6WoERgBaTkf2MQ/TIBOIDSBblBdgAtgb
	9q0sc50WRFP3YmSY9OVP4aMcM5PqSpc+b+8OJtibfqa7a6jcz7eE71MlXk1lTg/e3LFyDomrNZ2
	Skkm60V20zF8aVW65RwiHgYzJqGXqvIsMmBkQSPLbVmndKMvaE
X-Received: by 2002:a05:6102:5811:b0:7b4:879c:bb8d with SMTP id
 ada2fe7eead31-7d0727b10fdmr4913072137.37.1793699120221; Tue, 03 Nov 2026
 01:45:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 03:45:18 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 03:45:18 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261103084930.15532-2-okhuomonajayi54@gmail.com>
References: <20261031104526.46711-1-okhuomonajayi54@gmail.com>
 <20261103084930.15532-1-okhuomonajayi54@gmail.com> <20261103084930.15532-2-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 3 Nov 2026 03:45:18 -0600
X-Gm-Features: AclHuK89OgwJK9t1AXt3jmbEbMIL_xfYkHjypaJ0T3avgwRX9NwnXGKzzXmN7yY
Message-ID: <CAOLa=ZSPHDWAUmqUev9PRdEB03cUW=NWrbXHjRyma6yUmV7Yng@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 1/2] notes-utils: use the passed repository
 for notes refs
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000e53c9e065f5c1e72"

--000000000000e53c9e065f5c1e72
Content-Type: text/plain; charset="UTF-8"

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> create_notes_commit() and commit_notes() receive a repository,
> but read and update the notes ref in the_repository.
>
> Use the repository they are given.
>

Nit: It would also be nice to talk about why this is the same repository
and if its safe to do this swap.

Sometimes it's also useful to look at the history and argue about why it
is the way it is.

For this file, all `the_repository` usages were removed first in
1d18d7581c (notes-utils.c: remove the_repository references,
2019-01-12), then it was added back in 2e5c4758b7 (cocci: apply rules to
rewrite callers of "refs" interfaces, 2024-05-07). So seems like the
latter was an automated addition of `the_repository`.

> Keep USE_THE_REPOSITORY_VARIABLE because
> init_copy_notes_for_rewrite() still uses the_repository.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  notes-utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/notes-utils.c b/notes-utils.c
> index 5c1c75d5b8..d4606bc576 100644
> --- a/notes-utils.c
> +++ b/notes-utils.c
> @@ -26,7 +26,7 @@ void create_notes_commit(struct repository *r,
>  	if (!parents) {
>  		/* Deduce parent commit from t->ref */
>  		struct object_id parent_oid;
> -		if (!refs_read_ref(get_main_ref_store(the_repository), t->ref, &parent_oid)) {
> +		if (!refs_read_ref(get_main_ref_store(r), t->ref, &parent_oid)) {

Here, the repository we read the reference from and the commit from
should be the same. So r == the_repository.

>  			struct commit *parent = lookup_commit(r, &parent_oid);
>  			if (repo_parse_commit(r, parent))
>  				die("Failed to find/parse commit %s", t->ref);
> @@ -61,7 +61,7 @@ void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
>
>  	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
>  	strbuf_insertstr(&buf, 0, "notes: ");
> -	refs_update_ref(get_main_ref_store(the_repository), buf.buf,
> +	refs_update_ref(get_main_ref_store(r), buf.buf,
>  			t->update_ref, &commit_oid, NULL, 0,
>  			UPDATE_REFS_DIE_ON_ERR);
>

Similar here.

> --
> 2.56.0

The patch looks good.

--000000000000e53c9e065f5c1e72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4f5dc136a107d813_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ycHJTd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNG9BQy9zRjZsU0hqbUVTQnNPTU5HbDM1bkM1ay9SNApiejEyVjBSVUdl
dUF2S0VGbzZReHpkVkFFRi9acVZvQk9VQ2ZQS2YwSWxQdnRlNWZTVExMTU1PZG5WVVVhYVhLCnRQ
MmxHcGlhVFJydmZPNnVJWDFVcGl4bDIydU12NXdWaFM5a3Z4NWV5dzFVQVd6NkY4am84NGM3bCtV
N0x6ZWUKRlV2NmFnRC9MOHVtanoxWXYvT2RsOU5jaEJITU5mbzI0Q292a05rb3FiMkJ0UkM0OWd1
bFFyWXhiYmZ0RlR2eApaQTNlbkhHWTJRUy9aWGpjYWNicXc1cUVuNGFPdiswSzk5OHJGQ0VnN2Yr
Z2phQnUzTjNGTUZ0MXphTFRLU1RHCnhBWHNRN001MHR4a0Jkak5veklEVUFQRm1WUE9qMlhYczk5
VTdmNVR4TS81RWpFRjAzbXBCMXRWTU1Qa2tBcy8KZks5a3kwTDNkS3A2cmlUaEZaQU80ekNQQmRL
RUZ4ZW9KYmg2OWN5SjljaS9qV2hibUx0bmhqOXY4TU10NEpwYQpzMkRia294SGt2R2UwTFNPMzY4
aGZHcy9LN2pWbjkyNS9VNzJYa2M0eUtMUWNQR3FsdFp3Tm9MSkFEU0cxSWVCCjBuVVg0UTd6NVIv
cUJLQjZya1RoM0wweW01RXpNSFdLTW5VTjg0ST0KPXh5RisKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e53c9e065f5c1e72--
