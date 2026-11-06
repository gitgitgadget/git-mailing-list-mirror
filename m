Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793961446;
	b=BM9kuHnRl/9kC+2UBK/CHVta7aM5r4G/8ca1DPLHJcEhYdFnFpdYy8wWBn1D2rG2BJTy
	 UgBHFiv4BaIFFPtUKmlffKedkm9vkonbXF7B4gatgGVHVBfBR6RQO1bIHWjnvzxUKPkTX
	 AfXAnn2xnuJLd71A/z5Z2hPfzWVEx9gldPA2NHD7bTIRsP3QH4jxvx7lRloL1SZ8GmRjL
	 MFvWH6+jwaT0ED6XRG09PzPqwYEQFN3Zd1eGOTo45FrLLZf7KXVKtlQX20bjj4LnanGwa
	 EiWlQbom0YmAlWk5LgZqTDpqM3gCjWqlqK7tIsO89NzQq24kZRLbwRWy7PwRcJRkJ0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=vEiS/0CBCj5t+u2s+FyfnvUAV+lwju0ZhgHmX/aRfiw=;
	b=f/nWaNuI+dV9NOoFHlzXrKuHhiQvy7prcmQYea79xermhBkfsaNp0treatmPPnzKp+g8
	 FWzb5mhx2AMnie4XrL+tJr3uzfprGWEaUdpBByMIeji+MABmcbtbkfQHR4kvr1Yn0YCWC
	 Kos4IGku7e4cHYIpBoXgsnR5PvLot7RhP2QX1V70gz+f3yWgh3j1X4XgrhAm+Cud43pv6
	 vsG/+59MJdCdXXxR7JDc4xlcWhHJd96wxXHi5AAXdYwONJRGJ4/QGh6/L1yc4IHlOmvbX
	 DXNs54Ny4OpOlyeLIHdRh0+/xc/rinBTlkSXrUTjwxJKpBfGVZ+ZXlChdFJBmbmSBIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXkQX1nw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B75606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22B75606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXkQX1nw
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5e9528732b4so533282e0c.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 02:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793961445; cv=none;
        d=google.com; s=arc-20260327;
        b=MWUZkDB095ILj12MQJVZWren09aOB7spbA8XxCMOrchccL8by+fFa9Ve3fjR5cIBKh
         e3v2C03t6MbcImuNgwTero5HMpQBPkdPYKTeZG3NgxY5H2AradzYFPTNJkdY5gUn3Ndr
         ViYfiLi5gaR9wLmR1I8FyWYBc2/eyxunKWKIRgDHzIYXGGx+F3ra9eFjCQU9o5lUkFRp
         AdO0w7z6wODBM0fOLZZLDddlWVjZeYjiZLBtLmiXw8+LS05OohI8xN4xntFRgL/3FFmq
         03rfe5bkRH3CziEGtrmUpeM9wqCsr4dYSiyH6MP3k1oKQ2TBTlGARfyg7f2Y89B2wEdA
         yTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=vEiS/0CBCj5t+u2s+FyfnvUAV+lwju0ZhgHmX/aRfiw=;
        fh=8tbDd40FpJdxuUsl8xmPlmv4FTxuDDa24j1sQOSnQ1w=;
        b=BGFqmN40DS1LVOIF80XzunWuVLxZUIMZUil2XKd+T/xPB/mbA0WnrnIM2dDR675ihg
         vyEF3HIvMswLDe2omZKe0ARkP+ZC0EPLurDdzvoYyz9acIlvxcsrQkdWiCaYb2uwgFme
         Fau0OVisX7sipyvP8ZfZehR0cFBxn8y7VY1jGzmFtjZha1Atbsq1yV1u2Q+Qm49KNz4l
         hJ/zTvknHKHDBpTGsD/qKGt1bHts5EwqKsELrMwqVIXMLZV4QDC/R+NtsF+GPYgAsO2b
         JlWtPv1hSoYxDPF7AzyBBmhVzZlu0LlfzS4WM9oq1MeCYRnUg9/vDPGhhAfq6Fr8LfBx
         Zy0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793961445; x=1794566245; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vEiS/0CBCj5t+u2s+FyfnvUAV+lwju0ZhgHmX/aRfiw=;
        b=NXkQX1nwyWVmXZO/lBxHdE+YGnEWV5WIIg8IJxjgH2nrP6mndLSwUH4Q9tyXBCMSLj
         B/H/xaskMRPjzw3N1kCAfdymzNx0mraboejdTsjRwZUUZzmyfgQ1/t5dT3qa8zlJJN55
         vBTr7oOTXwSukVuJGwnu63+jG7do2aXd3ax1NOB+1bgJekkA+BCESxPqPCeu5zQJLpy6
         Cgf5UVqTqQTufURUNKB0GSuhPEpbZUFj6wJNaIxl29I2ZKOSXJZcaHi9bPtYB1yu0n1R
         NoL58V0LcCSUH0RiHMkiEI2nxyxM5OhrQYrF/A96yPcgatfZIsNp0xppOd7HaS20xyni
         AO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961445; x=1794566245;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vEiS/0CBCj5t+u2s+FyfnvUAV+lwju0ZhgHmX/aRfiw=;
        b=aIVFRB6mKXT4PxWbdMNp/mO1vu7JQ6jHIhewFFpKc7nIStT7WsRQyQ8cEotuqyZT1i
         mbYkWX95pORPPKdfeazO1EcC6XePpc/fUYg4e2tzCDIZYvfnjEtopHbUkgbmm4X31Ae+
         x2SwOWQbwJSjQbc10CgB9triN9Eo3N9+T8Af984OFZINPfv+k+O8LjdXTv4MIwivzs65
         LykKwYwLJSXdebZ7K0e73mX3wW15rvypdWONvKYPGiigXLGk9va6t3gKNCaVBNhS9GOS
         1/D90nzLuH4By/Sb8umGN+AGidEkbP/A9OHkv+9ZXMr8eQ9aFZlprssg7Sl71/RIs9AI
         wiZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjd7KeEVdLTd+KW9qYJ8Yy90WuEf7us/z0aChOHYCaPm/eaPanXTZV58/VnK6vifpo91w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+E5lEXrRLB8hLYgVzEipVMO1UvTdGDP8v/uk/t1McNfoL09Iqh
	FwhCPYN5gDyS2jUnMUzsYOz8bY8migzFdYG9mvedkcF2ZQJJAJKIfhy2yrWB2puXr6Sz2VfPPmg
	B7qr1kwrR6mTHYrbOFZeoTQVXYsKa7D4crA==
X-Gm-Gg: AYBFou11AjcExhiZ5MamIXSENMwlIcYpx+8Ne3yDEJKsFGzjQUHJNc/B1B+puDwT1rr
	FWth7TvpmwRibmIR8MdoWfwvKp431sVN7Vcnl1hUtlPld+KgiPVkRNNukosXVkc4aqihLKnT2Nr
	usCdccVwuGO8aOSC0R4lF3eC3qwA2YDCiFIdJck57YfkKybDiPCUuiV6hZKqh773Jme+I3uzNiv
	laWgBR8dAzhGHooT8VG7kXcVWt/geP9gH2qlzu3eOcP8x0XE6+4M7bNa2XA2q0SDK2viHPBW/OR
	jHKekccG6UYE3zwDsKRHDKk/mPlxnERxeysJG52eSveDyR9WE4tS5vsQL/rul0CKHgkKThV7CLW
	6ZIm02X4IUUlpK0THtoAr23m5k1ivbNa1F0GAI+a3Kf0MCFlBjvS2pV2EArq04FQbRmlVn7DtSK
	kHCAjxU2rC0rnxctvblJhvoH7fhd0=
X-Received: by 2002:a05:6122:4d83:b0:5c9:c60e:3a4a with SMTP id
 71dfb90a1353d-5ecc447655emr1044355e0c.22.1793961444978; Fri, 06 Nov 2026
 02:37:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 02:37:23 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261105-pks-storage-format-improvements-v1-1-870bb4212518@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
 <20261105-pks-storage-format-improvements-v1-1-870bb4212518@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 02:37:23 -0800
X-Gm-Features: AclHuK9PtNaJEeKQsr19P3NivJol4vf9yvmheo5KXWHMTTvy_zdQc6ioHPyZ7Z4
Message-ID: <CAOLa=ZR3jxonz2o+JKe=pyzSACwJH=uu3an141PEG1Ssq0pBWg@mail.gmail.com>
Subject: Re: [PATCH 1/5] refs: create leading directories
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ab70c6065f993257"

--000000000000ab70c6065f993257
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

The patch looks good.

> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
> index ee2bb66b99c..85d1e876b82 100755
> --- a/t/t1423-ref-backend.sh
> +++ b/t/t1423-ref-backend.sh
> @@ -284,6 +284,30 @@ test_expect_success 'initializing repository with --ref-storage-format and paylo
>  	test_cmp expect actual
>  '
>
> +for format in files reftable
> +do

This would run the loop for both the files and reftable CI jobs.

> +	test_expect_success "default ref storage format with $format backend and payload" '
> +		test_when_finished "rm -rf repo refdir" &&
> +		BACKEND="$format://$(pwd)/refdir" &&
> +		echo "$BACKEND" >expect &&
> +		git init --ref-storage-format="$BACKEND" repo &&
> +		test_path_is_dir refdir &&
> +		case "$format" in
> +		files)
> +			test_path_is_file refdir/HEAD &&
> +			test_path_is_dir refdir/refs
> +			;;
> +		reftable)
> +			test_path_is_dir refdir/reftable &&
> +			test_path_is_file refdir/reftable/tables.list
> +			;;
> +		*)
> +			BUG "unknown ref storage format: $format"
> +			;;
> +		esac
> +	'
> +done
> +

Should we instead do (untested):

test_expect_success "default ref storage format with $format backend
and payload" '
	test_when_finished "rm -rf repo refdir" &&
    format="$(test_detect_ref_format)" &&
	BACKEND="$format://$(pwd)/refdir" &&
	echo "$BACKEND" >expect &&
	git init --ref-storage-format="$BACKEND" repo &&
	test_path_is_dir refdir &&
	case "$format" in
	files)
		test_path_is_file refdir/HEAD &&
		test_path_is_dir refdir/refs
		;;
	reftable)
		test_path_is_dir refdir/reftable &&
		test_path_is_file refdir/reftable/tables.list
		;;
	*)
		BUG "unknown ref storage format: $format"
		;;
	esac
'

This eliminates the loop, while still testing both backends on their
respective CI jobs.

>  test_expect_success 'cloning repository with alt ref directory' '
>  	test_when_finished "rm -rf source repo refdir" &&
>  	mkdir refdir &&
>
> --
> 2.56.0.500.g5d06dc02cd.dirty

--000000000000ab70c6065f993257
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bdd99e23857d1159_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ydHJlRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHlzQy85ak1US21CbGtJejZCUGNBK2l2WVM3NWMwMApsK01XOXZ3QW9l
cS8xMWhRQUJiVFhCK0VyWXRzNWlBdXhnRHNPa1ZGUnlDaTdadmxxVlc1MGZVY3k1QU1EL3c0CmM1
N01iNU5PSmc0NmFFNFBjS2t6MHhXQllPSU5mNk9pSTkrQmxoVkpoM29GRThPL3JjUDA5QXhiRVlG
RVIwd0QKNmRvQ01EalQrWmVINldobFV3cFFpdWx4V0RJWFNmMXdiQXI1QnJoK09tcys4NzBvNEpP
Y09pVWkzS01EdDJVbQozWEpFSVR5V0Q2Q2pkTzFzejNJZXpHcEFpZHpaTUtBVjF5S01kbVZkVlkw
cGxRN2llZk81bk9UU05IKzA1MTFICmJrcFBNM0tZZ1FNbnN4WGxhR3BOdzE1dFhGYktibjI1Tzgz
Q0pLWTdqb2k4OXRLeU50REEzdVYvMFNhbmMvNFcKQUpPQmdLc1grUDVweUtsc1BTOCs1WjFtRFF0
MUdSemtpWnI0c2FsOU1PNjhIT0lrNnVQUXhpTEdnVU9hQUNRRwpMZ3NBdmJPVWZDRXR5Y2p2TGc0
dkNKdmZueDVKK0VVYWJPWGVkam56dXJwcThwKzRLNGFPcER6aXB2RFZXU3N1ClcxV21JUUdaZ2w0
OUFyMGVSbGlHM0pGZTI3T2txa2MzWTNWZ0ZpND0KPWl2Q20KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ab70c6065f993257--
