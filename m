Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48F628
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984304; cv=none; b=j4XUpA6JNJ++GMUoUWjLtwLukvX4E72unOAQMoj3ye2bQlWnVK5izuFq96qh5rBHIKbY03NTbUzqk5hjuBQx+i4WT+7q6pip2IKSPU3kJNAM2TmpQm/JF/ozkZsFJw7Z/tU48HuAxGQbu/HWk24MNb0D6Epe5mrHGatO8vZ5Sy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984304; c=relaxed/simple;
	bh=cEEEyIO+Q9iHPju/hxZ1+wIk9NtBmNEb3/qBISjukro=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyYQZIT4AKpArTN8pobqWMIwt7XRtWcgJLLZiOw4pmSHRKhUqZ5rAEwRQTi5ZKmr5T7XHRCbWA2XV+nrMUL/KPgY4RzCisEL1wsDao5UhTtMVF+eo9SXDr0rPdwtOs0t8trQbkEA7Cgwd3WRUZ2UHw3Xnx/UO2EyPghgjKdqR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0cBn1bg; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0cBn1bg"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2611da054fbso667386fac.1
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721984302; x=1722589102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9S2qqteUvEHqDLRXNWHhGgurOi0L6QncF5tUM/F/LwU=;
        b=G0cBn1bgdybmnGf8sp0VGaHOl0/EIYklrfFcj2LPHRoG5ROFKNEIOna8YYuupwUljB
         aGtjt9GN+82zKWmlX2aFdm366XQUyLbX/favtnzcVeItRZYk7qlUbzlPdpeiaZWClQGk
         N3V/A+n/PA86E4gen3v02z6llq1oIN2g+YKgUju80cNGVIV7y9PV9rGL/xkTQh4whQfk
         t5foyyjvMBGHAom4gkuSSyWSavptrX9So25lpIHRVAvaUEvbxPsTSXfTUBrv/cM7DP5O
         NrKJ9lTb5mQ7m9MHJ6TUiFQZzd70jFGXK4cVdHNH50hskfBhgVYT9VhyCNQxiNyA1jit
         Lq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984302; x=1722589102;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9S2qqteUvEHqDLRXNWHhGgurOi0L6QncF5tUM/F/LwU=;
        b=J/gNuvJwoxvKGw0Y1wAXR6ZWaSdC9+UBHG43UYRCjYPaeo1HhS9ae+b2DexDrM7mQJ
         datPDK8qkfCByokY8Vp9ZHA2ECk+k4/la0apVHwd5GABMtKXeMiPFr/kA8eXOfebE77a
         i3v4EgqmN3lFUo4+7W0DlZ8bEi/vlfoh0WdtRj0TWauCvGrnFFY0gLjfixS8LM0RsZZJ
         uA9WhL4fuja3VzC07qFNJ9UREBQI4BedAUyu5qIdF/hL6TC9VY1zE9eQ/7OSKbWVpBne
         3UThcbWgpZ/TNzsXMe6uHrFfBTc76lZxgLUtOCAaAr3+gNG+bUcq3SxsH+89ZLIYBTLz
         8gVA==
X-Forwarded-Encrypted: i=1; AJvYcCWKusW2D5TFI1RkJrVciXPmAJa1ZyvMI4reIDZ3Usy/9Xbeqe1jrajHLRjCF0g95GQm68ivi9D7j+/ckiRLYDSb/N0x
X-Gm-Message-State: AOJu0Yw6LBDFnVzBsJ11Rdy/bAXygED/lCbxqmmpX5mBwvNvzL+vVKwp
	SvKTYy7Qv4UWWFKdNVFjp/kyXgWNrtPpDSwbmpmj2I10wnjz8rrSCZacFVg2YDw/rczsxWWjVlZ
	7XELxR9KKFtdszi318R6L1DObSHg=
X-Google-Smtp-Source: AGHT+IF5l21uMCvrYkHuMf968Mt2L/zFrCJVNavMgrrER4MPgjJukxWyT14Y9Xd3D995b24tQknsaUcJcUzgf+m1jMU=
X-Received: by 2002:a05:6871:5b14:b0:25e:e6d:5247 with SMTP id
 586e51a60fabf-264a0ce640dmr6487516fac.14.1721984302180; Fri, 26 Jul 2024
 01:58:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 01:58:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240724144957.3033840-3-toon@iotcl.com>
References: <20240722080705.2614195-1-toon@iotcl.com> <20240724144957.3033840-1-toon@iotcl.com>
 <20240724144957.3033840-3-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jul 2024 01:58:21 -0700
Message-ID: <CAOLa=ZTuM9XsroDKizvtOB0d1mJ4t8ffi6_bMuX+R8qzUEW6Rw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] transport: introduce transport_has_remote_bundle_uri()
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000a40965061e22b6aa"

--000000000000a40965061e22b6aa
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

[snip]

> diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
> index 0c5fa723d8..bd558d5e57 100644
> --- a/t/helper/test-bundle-uri.c
> +++ b/t/helper/test-bundle-uri.c
> @@ -90,7 +90,7 @@ static int cmd_ls_remote(int argc, const char **argv)
>  	}
>
>  	transport = transport_get(remote, NULL);
> -	if (transport_get_remote_bundle_uri(transport) < 0) {
> +	if (!transport_has_remote_bundle_uri(transport)) {
>  		error(_("could not get the bundle-uri list"));
>  		status = 1;
>  		goto cleanup;
> diff --git a/transport.c b/transport.c
> index 12cc5b4d96..1a7d86fa40 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1536,7 +1536,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
>  	return rc;
>  }
>
> -int transport_get_remote_bundle_uri(struct transport *transport)
> +static int transport_get_remote_bundle_uri(struct transport *transport)
>

Why make it static?

>  {
>  	int value = 0;
>  	const struct transport_vtable *vtable = transport->vtable;
> @@ -1561,6 +1561,18 @@ int transport_get_remote_bundle_uri(struct transport *transport)
>
>  	if (vtable->get_bundle_uri(transport) < 0)
>  		return error(_("could not retrieve server-advertised bundle-uri list"));
> +
> +	return 0;
> +}
> +
> +int transport_has_remote_bundle_uri(struct transport *transport)
> +{
> +	transport_get_remote_bundle_uri(transport);
> +
> +	if (transport->bundles &&
> +	    hashmap_get_size(&transport->bundles->bundles))
> +		return 1;
> +
>  	return 0;
>  }
>
> diff --git a/transport.h b/transport.h
> index 6393cd9823..5ea9641558 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -294,10 +294,11 @@ const struct ref *transport_get_remote_refs(struct transport *transport,
>  					    struct transport_ls_refs_options *transport_options);
>
>  /**
> - * Retrieve bundle URI(s) from a remote. Populates "struct
> - * transport"'s "bundle_uri" and "got_remote_bundle_uri".
> + * Try fetch bundle URI(s) from a remote and returns 1 if one or more

Nit: s/Try/Try to/

> + * bundle URI(s) are received from the server.
> + * Populates "struct transport"'s "bundles" and "got_remote_bundle_uri".
>   */
> -int transport_get_remote_bundle_uri(struct transport *transport);
> +int transport_has_remote_bundle_uri(struct transport *transport);
>

Shouldn't this now be renamed to `transport_has_bundle_uri`? Earlier, we
were 'getting' bundle URIs from the remote. Now, we are abstracting that
away and simply asking, 'do we have bundle URIs'.

>  /*
>   * Fetch the hash algorithm used by a remote.
> --
> 2.45.2

--000000000000a40965061e22b6aa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2292be7b161c0160_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1halpTc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1NSQy85TmR3YjBmQ3EvaWtzUXV3RHFOMWZJOUp1OApDWi9iQnhwSVVw
TnNpWmVIdGVUS05kbGhlM2trTFR5S05LVUVaTEJsVXphTUZHL0hHaUpSdzFOT2R1MzE1dWN3Cjdk
S3FyY1hMRi9KclpBODN3SC9UL0d2eUZVV3dkWHVGaUk5eW1nd042NVBTQ0s1dVAyVkoxVC9MZHVD
d3pUVEoKNTNFL1NhdzhjeW5ONER0QnZKNitDSnVKQUFLeEFTMklyajd4YVpZM2M4WU95UDhybEVP
UTRkS1lGczZqS2ZMRgpCMzAzYWF1elI2Y3dsVVNZRTJOV2l4ditHS2RIWmF2aXpKYzhJSkRUL3dw
OG0xQUc2eDlIc3RzWEpadDR0eFgrCnhMUE5SYk5UYmxDQzFFLzgzL2YrQ0dnbHJVdzhiUmRsbDZp
YWFFanRxS2pVZlkydHlXcThDSERjQzJwZXkvTTkKdXlwUkhnKy9uSzlBRTE2K0t6MFI0RUtLNHlB
Z3g5ekptZW95cmsvVGh6M0tlNUJ6TUNEV05QbmdNYlU5czRScAphcy9mSVZibkhlZ0c1WGpKVm95
S3dRTWxpeHFNLzFCUXV2SjVLMmJhcEZDVHNQbC81TU1aMVN1Z1VuZms4cGtCCkEvVVB4Nm55Sjhw
amRuZkp6NzAvQld4KzNEVVdtMjFzQUhLU3ErTT0KPWhuLzYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a40965061e22b6aa--
