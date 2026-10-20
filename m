Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792476835;
	b=s3EtWMRjZIqh0eFt2M+sU4OUTLhpjjLF36rDs233IsMNty+0QkzPOGk6S/Cz5XNSJL8x
	 q7G949jZ88yhrm/CJAe7bC1kIEh7Gfjg8z80EVC1NFqqj2jW6Qy977ABKOQq7wC8+rntl
	 t//MP9f8U0w0+/OhAowpwyOfQkK3G5wcv3QmZp8FYNXWqwR65Khbc0aX53bCjq3CHXdc/
	 DEj1c8JBvF7kNCBSSIrBerw9a0tZ3abpv6kU8eICWw06TIVwmC9mJV/dXkvpVDH9jZHOn
	 MwSZiFSeuOp219K7Qe1+Km656o71qhsJiQuv0YYo6dJyNGtRDi7yznOXxdknC+JGuPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 From:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YDCAdJg8uD38HOUjJNqwhN16BORw0wBV1v+82lI0e0c=;
	b=JkhFDfSs3iu2Ffyf8s/stjIp47m6ApHn5uArrEDT7yYJJTdgyLbSiyHy8uwhaH6swo6M
	 Y7CWTZkYs+gkCTvD54QIsyG5k3b5tIQrAARH7QQIsGh+a7PqcwBqpBz4h5J8+3Tnh/xZC
	 5XaPMsgjkrHD/Cr+2Rh4o40f5z9HuALrMsPD+zINOOFWY0sgPM1LENUsoOcTdbahBMF+F
	 0/vBLfFeVq3cvkFo6iPIQTXa+RcxjTJcS4Dj4RiEI4tNNpq0bjVKurfA7LsRA/EDHpcoh
	 KPUbWNNrjzfC+DjefoXtfCvWHRStiR2HwJRZ42L9cmD6tyqT4EUKI2F+Edbv8yLLqLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=sph3r3.com;
	spf=none smtp.mailfrom=sph3r3.com;
	dkim=pass header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=EIZPudZI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE2606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2FE2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=EIZPudZI
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9178aabd30dso26354476d6.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 23:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792476833; cv=none;
        d=google.com; s=arc-20260327;
        b=RvZsY7MJrqWpdPpS1RIgktJlWeS0utv+W1ftUCOLK7R1caUkl6redT/H683YLQC1EB
         cwTe8tRlh/MgrlAvDrp6BW1P1uFGQJMKkl5E2uFGuoDv5Gleuah/++jPBzLi1XHXDpkr
         NzzuMGZx23oR0LspVjJCDl9agT8XDovOnFzhg1AItqmPJKZHFaySTSvYUh03uy6r6hby
         PlEggeCsw0Uylr8e9n0lX2HuZyF2Fr3jANt6tv79F/nooVYoS0oqWWzp+iEBkc9DGfxC
         uMweB+729mVumur/nggqC9+UznEr0Fr7cg0iPtfJ9HWKA9b1pPD6pqo3c1t3qT+WbQE5
         Tyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=YDCAdJg8uD38HOUjJNqwhN16BORw0wBV1v+82lI0e0c=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Nyj80CPr+ilMfDkAr8p2eBso8xr6drTKMOShKYOdr9pY7czUD/9Frgw44mN3jvd9DE
         2uGe6JgD1xn/XwtF4B/DyD3uLtbmzZoCkcztH24f3XizQa4lotEZ5hrMLiDNh2ZC59eU
         7BrNuYE4TFQAAg3Sw7XIrVuOQp2hHFybEptL1fdtu9OrO2tNSXxJfGn02GANYK4DVwjE
         DxCPr+gXgkXl0AnIra3gJ2n+eeH1GRbe/qWm12c9mQVDjhcLLhxR5dQEa1OWf+nYrlZb
         FNtYUBvbuY/eStBuKv3ia6Vg8Re1/+PYNK85rMqZ8e7u/57F7KA5ox/kPBqx3WEZ9GED
         8zBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sph3r3-com.20251104.gappssmtp.com; s=20251104; t=1792476833; x=1793081633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :references:in-reply-to:from:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDCAdJg8uD38HOUjJNqwhN16BORw0wBV1v+82lI0e0c=;
        b=EIZPudZIfEmOat1OLX8dKaIX0sSNWqKM7hQ9a0bxBdLtzg9a4faZYgktKShtWWaNtd
         Iy5ZquSZJx1WYdoiXYz1wwokxjqRX0jZcbcTUFKI5XOQMYaBNn4oJ65m1XMD9TVN97La
         lP2Js/n25eSRSlXkLCagIc/5CkEBtkx2Gcq4nHUa7Phqm0jawGSMeor3rC7W/Z74hLe/
         FftlZHmC0qByHcSoTrB+CoZ/T11dvvJwZ57/BCh4IoDRJ26529/woyt8eA9ELqEbbvPi
         onMG6i5fBs1KA8Dv3QaJaJjqlrRrC4npvi9OykXFPTEJh9hvwyt2r2x1jueJkkRFcG9g
         i0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792476833; x=1793081633;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :references:in-reply-to:from:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YDCAdJg8uD38HOUjJNqwhN16BORw0wBV1v+82lI0e0c=;
        b=viJEupOU1JLMA80Vt3LFLMHfB7fk6g4WVDfWyJtEf9j1TGb1M4eY86Y/1eOGhL92Hz
         UxhegWvDgtUElZhnuodmkovrxvf6hU11kPiIHf/HZR8Boj5/JcykouVtoROoqPB4VHvE
         fKnIb3dbAEU0vjxkahxc2EEnPu62rZHBCq/REqSJUdc+1ec0M4gC6NBEKLqAK97EKi8w
         Op7w4n8+TUC5k8t4s7DAfhOkczE/00LB28BzANloFDFOZg2VecMJ7ZxZ9WhTtjM03uOk
         b3SIhFbXyk1HrOUEt2Nx9Wa7uDZf13Yqyou409Yo97CTTv1ybMhyjE+8RdMkGHxySZ30
         FePQ==
X-Gm-Message-State: AFq9FYKnT7CSeZ1FUz1qw4zAUk2cbNulFqVEbA3i3FhM2W8GzC3s5dX8
	N9lns5qdVIGSJHKglQyGR1r25A056JmjFeLNlSMVR6CdBitLyByglRLWMIdBv4y60UX9UvpYGLO
	SYX6pik+Ruawmq9PDEv8KzkhphCsCNzPrbRGGFpuE1QynKUySWhWGtuo=
X-Gm-Gg: AYBFou1BgoqebqVc0iI1Ukw+ApPLcqVkqLy0kcLgr2VWaviguj5psgT9cDU3K0ek6Ot
	pmnWgaOF7de8RN0aCQ/WyIXjBKxjWEiJQ6TH1pxRBbIaMN+lZiZqCkN0/EEfwD36Sf4+/VG4M7P
	qIjkcfayvSzz60QJYY3Grtxa7nO9/EvU/Gv/q4CYhU85VvImeFXWDNj3KeWM0rVonBNe240h9d6
	eNZjsT2VFyFlR5yyZemt++Yb73D3BsveGSFW0kB4e3iQC5LflUfgspn7nlrTw62fZjOOtS/8L96
	AnfXSnFhglzipHsArMPswjRRwNk3pzmfrt/3wBKIwj6GrqLYEJTD7K+jkF43vLHeBgUF5oCC37G
	3DNQnztz2FX/JmASjPSokiUqiaFrIxDhXeU+uCIZ63KtpgFz3OfZR3TofQFNgKp8BpqLW+/pVkr
	u6kZ5qz18lVY/bLcyi1A2aoiJX+DQf+DcYeX/mGnoldlNR
X-Received: by 2002:a05:6214:d43:b0:90c:5947:7e60 with SMTP id
 6a1803df08f44-91bdec2966cmr155574846d6.4.1792476833492; Mon, 19 Oct 2026
 23:13:53 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 02:13:52 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 02:13:52 -0400
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: m@sph3r3.com
In-Reply-To: <e25693e2-1e32-46ae-945f-0a83b382e8a2@web.de>
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
 <e25693e2-1e32-46ae-945f-0a83b382e8a2@web.de>
Date: Tue, 20 Oct 2026 02:13:52 -0400
X-Gm-Features: AclHuK_7y9wI_-L_6tTILeAKIYAk8F3KSzb8QyiZh1jk_HcIrbaCfWrSzHSgKVM
Message-ID: <CA+h9NxT1A5fiJ1=B2e9QoYq_8SE9B2erKs+Lh19RPrh6Eq_GKA@mail.gmail.com>
Subject: Re: [PATCH v2] archive-zip: omit UT extra field if mtime is out of range
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9,

Thanks for updating this. I retested v2 and confirmed it fixes the
original 2106 case. The older file now gets replaced as expected.

I also found a separate time-zone issue with post-2038 dates when
using unzip -u. I don=E2=80=99t think that needs to hold up this fix; we ca=
n
track it separately.

Matt

On Mon, 19 Oct 2026 19:11:21 +0200, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> We write an Extended Timestamp Extra Field (ID 0x5455 =3D "UT") for each
> zip entry, like Info-ZIP zip(1) does.  Its time values are signed 32-bit
> integers (see e.g. https://libzip.org/specifications/extrafld.txt).
> Stop emitting them when the commit time doesn't fit in.
>
> Use a strbuf to prepare the extra field up front.  Keep it empty if the
> time value is out of range.  Like for the central zip directory we only
> care about the length-limited buffer aspect of the strbuf, not about
> NUL-termination.  This simplifies the conditional output by avoiding to
> repeat the condition.
>
> Reported-by: Matthew E. Luallen <m@sph3r3.com>
> Helped-by: Matthew E. Luallen <m@sph3r3.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Changes since v1:
> - skip tests of 33-bit timestamp on 32-bit architectures
>
>  archive-zip.c                   | 37 +++++++++++++--------------------
>  t/t5004-archive-corner-cases.sh | 28 +++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 22 deletions(-)
>
> diff --git a/archive-zip.c b/archive-zip.c
> index 6f73ca6d58..785689584c 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -24,6 +24,7 @@ static int zip_time;
>
>  /* We only care about the "buf" part here. */
>  static struct strbuf zip_dir;
> +static struct strbuf zip_extra_mtime;
>
>  static uintmax_t zip_offset;
>  static uint64_t zip_dir_entries;
> @@ -81,14 +82,6 @@ struct zip_dir_trailer {
>  	unsigned char _end[1];
>  };
>
> -struct zip_extra_mtime {
> -	unsigned char magic[2];
> -	unsigned char extra_size[2];
> -	unsigned char flags[1];
> -	unsigned char mtime[4];
> -	unsigned char _end[1];
> -};
> -
>  struct zip64_extra {
>  	unsigned char magic[2];
>  	unsigned char extra_size[2];
> @@ -129,9 +122,6 @@ struct zip64_dir_trailer_locator {
>  #define ZIP64_DATA_DESC_SIZE	offsetof(struct zip64_data_desc, _end)
>  #define ZIP_DIR_HEADER_SIZE	offsetof(struct zip_dir_header, _end)
>  #define ZIP_DIR_TRAILER_SIZE	offsetof(struct zip_dir_trailer, _end)
> -#define ZIP_EXTRA_MTIME_SIZE	offsetof(struct zip_extra_mtime, _end)
> -#define ZIP_EXTRA_MTIME_PAYLOAD_SIZE \
> -	(ZIP_EXTRA_MTIME_SIZE - offsetof(struct zip_extra_mtime, flags))
>  #define ZIP64_EXTRA_SIZE	offsetof(struct zip64_extra, _end)
>  #define ZIP64_EXTRA_PAYLOAD_SIZE \
>  	(ZIP64_EXTRA_SIZE - offsetof(struct zip64_extra, size))
> @@ -299,9 +289,8 @@ static int write_zip_entry(struct archiver_args *args=
,
>  {
>  	struct zip_local_header header;
>  	uintmax_t offset =3D zip_offset;
> -	struct zip_extra_mtime extra;
>  	struct zip64_extra extra64;
> -	size_t header_extra_size =3D ZIP_EXTRA_MTIME_SIZE;
> +	size_t header_extra_size =3D zip_extra_mtime.len;
>  	int need_zip64_extra =3D 0;
>  	unsigned long attr2;
>  	unsigned long compressed_size;
> @@ -315,7 +304,7 @@ static int write_zip_entry(struct archiver_args *args=
,
>  	const char *path_without_prefix =3D path + args->baselen;
>  	unsigned int creator_version =3D 0;
>  	unsigned int version_needed =3D 10;
> -	size_t zip_dir_extra_size =3D ZIP_EXTRA_MTIME_SIZE;
> +	size_t zip_dir_extra_size =3D zip_extra_mtime.len;
>  	size_t zip64_dir_extra_payload_size =3D 0;
>
>  	crc =3D crc32(0, NULL, 0);
> @@ -381,11 +370,6 @@ static int write_zip_entry(struct archiver_args *arg=
s,
>  		}
>  	}
>
> -	copy_le16(extra.magic, 0x5455);
> -	copy_le16(extra.extra_size, ZIP_EXTRA_MTIME_PAYLOAD_SIZE);
> -	extra.flags[0] =3D 1;	/* just mtime */
> -	copy_le32(extra.mtime, args->time);
> -
>  	if (size > 0xffffffff || compressed_size > 0xffffffff)
>  		need_zip64_extra =3D 1;
>  	if (stream && size > 0x7fffffff)
> @@ -412,8 +396,8 @@ static int write_zip_entry(struct archiver_args *args=
,
>  	zip_offset +=3D ZIP_LOCAL_HEADER_SIZE;
>  	write_or_die(1, path, pathlen);
>  	zip_offset +=3D pathlen;
> -	write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
> -	zip_offset +=3D ZIP_EXTRA_MTIME_SIZE;
> +	write_or_die(1, zip_extra_mtime.buf, zip_extra_mtime.len);
> +	zip_offset +=3D zip_extra_mtime.len;
>  	if (need_zip64_extra) {
>  		copy_le16(extra64.magic, 0x0001);
>  		copy_le16(extra64.extra_size, ZIP64_EXTRA_PAYLOAD_SIZE);
> @@ -546,7 +530,7 @@ static int write_zip_entry(struct archiver_args *args=
,
>  	strbuf_add_le(&zip_dir, 4, attr2);
>  	strbuf_add_le(&zip_dir, 4, clamp32(offset));
>  	strbuf_add(&zip_dir, path, pathlen);
> -	strbuf_add(&zip_dir, &extra, ZIP_EXTRA_MTIME_SIZE);
> +	strbuf_addbuf(&zip_dir, &zip_extra_mtime);
>  	if (zip64_dir_extra_payload_size) {
>  		strbuf_add_le(&zip_dir, 2, 0x0001);	/* magic */
>  		strbuf_add_le(&zip_dir, 2, zip64_dir_extra_payload_size);
> @@ -644,12 +628,21 @@ static int write_zip_archive(const struct archiver =
*ar UNUSED,
>  	dos_time(&args->time, &zip_date, &zip_time);
>
>  	strbuf_init(&zip_dir, 0);
> +	strbuf_init(&zip_extra_mtime, 0);
> +
> +	if (args->time <=3D 0x7fffffff) {
> +		strbuf_add_le(&zip_extra_mtime, 2, 0x5455); /* magic */
> +		strbuf_add_le(&zip_extra_mtime, 2, 1 + 4); /* payload size */
> +		strbuf_add_le(&zip_extra_mtime, 1, 1); /* flags; just mtime */
> +		strbuf_add_le(&zip_extra_mtime, 4, args->time);
> +	}
>
>  	err =3D write_archive_entries(args, write_zip_entry);
>  	if (!err)
>  		write_zip_trailer(args->commit_oid);
>
>  	strbuf_release(&zip_dir);
> +	strbuf_release(&zip_extra_mtime);
>
>  	return err;
>  }
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cas=
es.sh
> index 768b0ff85d..c776387ad6 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -227,4 +227,32 @@ test_expect_success 'tar archive with long paths' '
>  	git archive -o long_paths.tar $tree
>  '
>
> +test_lazy_prereq ZIPINFO_UT_EXTRA '
> +	"$ZIPINFO" -v "$TEST_DIRECTORY"/t5004/big-pack.zip |
> +	grep "UT extra field modtime"
> +'
> +
> +test_expect_success TIME_IS_64BIT 'zip archive with 32-bit mtime' '
> +	blob=3D$(echo foo | git hash-object -w --stdin) &&
> +	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
> +	git archive --mtime=3D"@2147483647 +0000" -o with_ut_extra.zip $tree
> +'
> +
> +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'zip archive with mtim=
e exceeding 32-bit' '
> +	blob=3D$(echo foo | git hash-object -w --stdin) &&
> +	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
> +	git archive --mtime=3D"@2147483648 +0000" -o without_ut_extra.zip $tree
> +'
> +
> +test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA 'UT extra field' '
> +	"$ZIPINFO" -v with_ut_extra.zip >actual &&
> +	test_grep "UT extra field modtime" actual
> +'
> +
> +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT,ZIPINFO_UT_EXTRA \
> +	'UT extra field omitted when mtime exceeds 32-bit' '
> +	"$ZIPINFO" -v without_ut_extra.zip >actual &&
> +	test_grep ! "UT extra field modtime" actual
> +'
> +
>  test_done
>
> Interdiff against v1:
>   diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-c=
ases.sh
>   index 20bab21048..c776387ad6 100755
>   --- a/t/t5004-archive-corner-cases.sh
>   +++ b/t/t5004-archive-corner-cases.sh
>   @@ -238,7 +238,7 @@ test_expect_success TIME_IS_64BIT 'zip archive with=
 32-bit mtime' '
>    	git archive --mtime=3D"@2147483647 +0000" -o with_ut_extra.zip $tree
>    '
>
>   -test_expect_success TIME_IS_64BIT 'zip archive with mtime exceeding 32=
-bit' '
>   +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'zip archive with mt=
ime exceeding 32-bit' '
>    	blob=3D$(echo foo | git hash-object -w --stdin) &&
>    	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
>    	git archive --mtime=3D"@2147483648 +0000" -o without_ut_extra.zip $tr=
ee
>   @@ -249,7 +249,7 @@ test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA =
'UT extra field' '
>    	test_grep "UT extra field modtime" actual
>    '
>
>   -test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA \
>   +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT,ZIPINFO_UT_EXTRA \
>    	'UT extra field omitted when mtime exceeds 32-bit' '
>    	"$ZIPINFO" -v without_ut_extra.zip >actual &&
>    	test_grep ! "UT extra field modtime" actual
> --
> 2.56.0
