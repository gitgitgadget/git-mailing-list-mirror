Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16F140363
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450187; cv=none; b=Msep4yx4fhKRrNs4BvXiAtuFpxfHv4aeBO/Zd0RHMAg6dZvBz7iVmooicd9iPo04DNnHXen4DZeQ6UjuBmUaMxTHuPMQR4U0r4mKNNLYRtU4nuK4izNsDLhRhopWMo9HJc15/PPIALLF2xUIYVmouy58yMTizmL64SnI7bgfo/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450187; c=relaxed/simple;
	bh=R+u2bk77H+AkolWSjCCtCaBDKJXjOWnAvfwb0BoT2U8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq4MwN6egGnFRi6nat6AkO3FEL+nVln7a0I2AcMQaK4JHR4A2s9sPBlfUmn07m3q8stMQ5DN+aDkruiOaN7hG1zl9te5lXm2c2IPINshCvTbt/OmB0ZzVkUc+jhBCjF2EjdXPcuZESXdlvMh9ttD9md1FzwoyKtCzoAPxYlpK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJEZZ60f; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJEZZ60f"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e3d8d9f70so1956692fac.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720450184; x=1721054984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMPjl01ahgq9vfnVzqguB5r1e9b2sLSf81kHGahRknk=;
        b=KJEZZ60fX9HJ4e6BrI1RzVf8336f44pTDoVaR5icS+FWYkLUrNmE31qhHMZnrRMeQv
         NCLsfnOGB8MH5BFzeW0nWlvE9Ilf9/7ivhWaZMaDl6Xp5ZSttGLLJVmwj3nmsev2P1uu
         kMZCGIa4j1AWCS1IN5oOJgGufeZqAQHHRUyKKm9BjS1z5KOXH9X5usMQ9ZdZn4OO4PX6
         EBoY4kKiYcgyhN4noafJoh76HnXMpFPcPFUg63HN+M+9K51b2AR0MgBZW+j9dM1elRNT
         lGtCoi2b5NKFsJCBw2bpnax67tLV3dpoZ8tEc6WssgbRPnh85izkoTNdzh+t5RUxoJU0
         0tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720450184; x=1721054984;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMPjl01ahgq9vfnVzqguB5r1e9b2sLSf81kHGahRknk=;
        b=tXWTdXgVw525qLftWtO9rY5ICn5ovDLccA2yOGvG/C//S51ZgOg3I+P2fv+l/cADp8
         rNW6HcDeAZ5P/nfXoXT/l6wS5g5Q/nDy3xk2POqFyVSOoZArKWvJMEWZ+ReAxLFIROfM
         C7ubhY/ne09eHazR+LQSi/qJZDW/OtZoU/LVSjTqB6HBLasYk0F8UHSHBiQ9XLO9tUWb
         WUX+G3r8QyfVeTaB1jD1HmGgBGqWIQ+Gw9MflN5bDz88hnzQNXPSQQhkz+us01fMk+qd
         ojRIi3UcfZfQY5JkgH5CadfWmlupX6K9iNsOlLu6zJZHitL9P1qB16HCLC2zT72i/Wg5
         RePQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDyLtq835a1tiSij66GqbUDMdxkwC8hqN6d7OMOuDT97H7ODiom/paSILimV9mv6vEtlDtQpkXkqzvxeqU37Fqt65s
X-Gm-Message-State: AOJu0Yym2O6MOU9GwSwAyFJ6j+FKVqtR5RELf3+1wMj4howdkuQVd5T0
	xSNVub5bZY8XsrT6k6uMQ8ogpYtRee1MBMOZkQNKBqyEFOR2VP9IjajMDrHdVFIb8lLfmeBzm/e
	nV4gB6O3y2at+mHwf84w2VaGpYXc=
X-Google-Smtp-Source: AGHT+IHMnTJo3cOo0wiHnu7PKVapKnwkd5eiiDi6RS+mCyduyxlC/mckVYRLt3GiVKuVdVKPnUTytRRYcbHeMLdhWME=
X-Received: by 2002:a05:6870:8182:b0:25e:2208:6c8a with SMTP id
 586e51a60fabf-25e2b8cf279mr11156567fac.4.1720450184561; Mon, 08 Jul 2024
 07:49:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 07:49:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZovrI1yRmS0X2BHu@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux> <ZovrI1yRmS0X2BHu@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 07:49:43 -0700
Message-ID: <CAOLa=ZSgZMmfJWcPdKYyLrO-Mo0G-TKj3pYRREjvLt_ypuEk6g@mail.gmail.com>
Subject: Re: [GSoC][PATCH v8 3/9] fsck: add refs-related options and error
 report function
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001b18ac061cbd8623"

--0000000000001b18ac061cbd8623
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Add refs-related options to the "fsck_options", create refs-specific
> "error_func" callback "fsck_refs_error_function".
>
> "fsck_refs_error_function" will use the "oid" parameter. When the caller
> passes the oid, it will use "oid_to_hex" to get the corresponding hex
> value to report to the caller.
>
> Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
> macros to create refs options easily.
>

Carrying over from the previous commit, couldn't we simply do something
like:

    diff --git a/fsck.c b/fsck.c
    index eea7145470..32ae36a4fc 100644
    --- a/fsck.c
    +++ b/fsck.c
    @@ -1202,17 +1203,33 @@ int fsck_buffer(const struct object_id
*oid, enum object_type type,

     int fsck_error_function(struct fsck_options *o,
     			const struct object_id *oid,
    -			enum object_type object_type UNUSED,
    +			enum object_type object_type,
    +			const char *checked_ref_name,
     			enum fsck_msg_type msg_type,
     			enum fsck_msg_id msg_id UNUSED,
     			const char *message)
     {
    +	static struct strbuf sb = STRBUF_INIT;
    +	int ret = 0;
    +
    +	if (checked_ref_name) {
    +		strbuf_addstr("ref %s", checked_ref_name);
    +		if (oid)
    +			strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
    +	} else {
    +		strbuf_addstr("object %s", fsck_describe_object(o, oid));
    +	}
    +
     	if (msg_type == FSCK_WARN) {
    -		warning("object %s: %s", fsck_describe_object(o, oid), message);
    -		return 0;
    +		warning("%s: %s", sb.buf, message);
    +		ret = 0;
    +		goto cleanup;
     	}
    -	error("object %s: %s", fsck_describe_object(o, oid), message);
    -	return 1;
    +	error("%s: %s", sb.buf, message);
    +
    +cleanup:
    +	strbuf_release(&sb);
    +	return ret;
     }


> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  fsck.c | 22 ++++++++++++++++++++++
>  fsck.h | 15 +++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/fsck.c b/fsck.c
> index 7182ce8e80..d1dcbdcac2 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -1252,6 +1252,28 @@ int fsck_objects_error_function(struct fsck_options *o,
>  	return 1;
>  }
>
> +int fsck_refs_error_function(struct fsck_options *options UNUSED,
> +			     const struct object_id *oid,
> +			     enum object_type object_type UNUSED,
> +			     const char *checked_ref_name,
> +			     enum fsck_msg_type msg_type,
> +			     enum fsck_msg_id msg_id UNUSED,
> +			     const char *message)
> +{
> +	static struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_addstr(&sb, checked_ref_name);
> +	if (oid)
> +		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
> +
> +	if (msg_type == FSCK_WARN) {
> +		warning("%s: %s", sb.buf, message);
> +		return 0;
> +	}
> +	error("%s: %s", sb.buf, message);
> +	return 1;
> +}
> +

We don't free strbuf here.

>  static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
>  		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
>  		      struct fsck_options *options, const char *blob_type)
> diff --git a/fsck.h b/fsck.h
> index f703dfb5e8..246055c0f9 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -135,11 +135,19 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
>  						   enum fsck_msg_type msg_type,
>  						   enum fsck_msg_id msg_id,
>  						   const char *message);
> +int fsck_refs_error_function(struct fsck_options *options,
> +			     const struct object_id *oid,
> +			     enum object_type object_type,
> +			     const char *checked_ref_name,
> +			     enum fsck_msg_type msg_type,
> +			     enum fsck_msg_id msg_id,
> +			     const char *message);
>
>  struct fsck_options {
>  	fsck_walk_func walk;
>  	fsck_error error_func;
>  	unsigned strict:1;
> +	unsigned verbose_refs:1;

Nit: Here we have the subject 'refs' towards the end of the name.

>  	enum fsck_msg_type *msg_type;
>  	struct oidset oid_skiplist;

but here we have the subject 'oid' at the start of the name. Perhaps we
can rename this to 'skip_oids'?

>  	struct oidset gitmodules_found;
> @@ -173,6 +181,13 @@ struct fsck_options {
>  	.gitattributes_done = OIDSET_INIT, \
>  	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
>  }
> +#define FSCK_REFS_OPTIONS_DEFAULT { \
> +	.error_func = fsck_refs_error_function, \
> +}
> +#define FSCK_REFS_OPTIONS_STRICT { \
> +	.strict = 1, \
> +	.error_func = fsck_refs_error_function, \
> +}
>
>  /* descend in all linked child objects
>   * the return value is:
> --
> 2.45.2

--0000000000001b18ac061cbd8623
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 57eddcbc81961c6c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTC9JWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHVGQy8wZU8rV2QwSlppeG9QTkpWOXgvK1lYdUVSQQpjdDB3cFpvQmNT
VXF3anRHVks0VUlqQ1p2OStCWHpCb0NGQUFlcEhRVDVxWk9EZnpaVW1Nc29tZ1RialhVZVVyCnBF
VjVhb1BLTE5CZSsveDhzUjNSa2JqeUVsWWcwVHdlWStvYlVvNkxNZ1o0SHFOdUNJbGdjTEd3a1Jj
V2tSRngKV1Nzc3JCbTM5cThTMzdScDQydDVCY3Y2UitkdGtZKy8vTzc1dlE2dzNFTkRNc2tieDUz
VDUyOGVzRjZIenpnTwpUaUNFRE1reUsvYUQwMWV5SDl6dkpsRzZuRGwrWVZ6QkROQ1ZZakVZRitN
TFg1c0RpYkVvWTVRaTBMY1B6QXpHCmRWZ0pnNEVpbUVHNHByRDNMampKa0N4cXJ2Ky9BQ2pQVHps
ZUt1L0s1U05adzAzR1YzVUFXOGg5YVlUaHA4bVQKdWk2ZHBrTlBWMlBTVG5ZZS9PSE8wNUowdGc2
bUxZcE96a08rc1NFU01VeXBiSVRwU0R6eXJXMWRJWU1CVW1WcQptNHpkYkhMakRsUVJzVk9CR0pZ
VVBnczVveVhFN1dpci8rUWdnY1pQZEE4clNnTWI4ODNGSVA3QVpKZVdPS2hhCnd3SzRaNW1qT0Ri
bXNqNm5tRnRtVGVCQWM4aDN0M0V2ZUtoZ1BuUT0KPUZQOUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001b18ac061cbd8623--
