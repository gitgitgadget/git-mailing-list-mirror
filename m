Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC21E5724
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998596; cv=pass; b=cJDgQSbBm0kfAdXEDH1he/v5DHkLjrbiM2VK+ZsUNqe5rTO403eEj8cLjUMSdQ0fQIj7Vd5p0CcIk8HmIanux2w+vinRRGvicSDt8yD1G6hn8aD34hy7vXoH9XINjxxSgNJXjDzF3t9ReZjjZmeC3NmNWTD8I1r2bJ6Q85ziCp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998596; c=relaxed/simple;
	bh=zzrt+MhbsPMJzGHgKt/1zV7xwr2nMLiKxSio42X0k04=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=UL9tokQmJD6ACuIfoRH7pvnqm+Cb58n7lqTrZHcBJB+uVMEIG3S20tbkh4CV+B6TkppwKh+JVYFKeGDGU/4kWvCM/7X+pnRLt7gdSNRiNu5++zaFp8u9EuAbFvq1Lc/2CRbI6I7Wsgz7olRJLfKpspPdO8J12SOm9aONEG6aEa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQLbFohe; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQLbFohe"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94a231b285dso879056241.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 02:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773998594; cv=none;
        d=google.com; s=arc-20240605;
        b=ehHU1528xFlqugpmDbMqz1vsS/QyUiqLFrNbKbQDKtwfDSZDJKWa8/IBWCsBhNtRPc
         9DEfGpS/vSzIEb/SR20rLI36hlQ8FZPI09kfvWekDfsdie9BYTLdFXA3lSCRnVYakeBZ
         ZOctJaTKKBjLESO4w9RAq/2w4lIFAHQrwmIlBoooWNnBhUp06351QdLJtmZZ4TiNl75g
         Q10Epcr+1ukquWx1Csl7SYLy9zBhZZG1V+LLtqcjZKxIUYTMVoXCip8PMydsALyArLHW
         NlxAYDo+WfuC//GZHkWJ/ic/liVC8Vx1sFnlVhZRbAlYfXEy+ZN8NKYWBZuMOE8Iyn7g
         gZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=c6OISUkB2m0N2/w6RbMgCS+WOol4j624Cph/yPCaN8w=;
        fh=UkZy/o0I42qC/0gcHJxx9y2Zl1GzBe73ZzJ3Po1sUWU=;
        b=flzBOA6x+GeS4894cmkRS4mk0sLAxf+8nKQMOWbyh2/N0w3U+gxc/b4js3bxbepNXV
         YtLg5fiqNF61tZYJz67fQnd4OpQ0FyLo1Qohb1ioGuGmgCkvJjvLN5g27h4AAleK28oW
         M2YsCvPBX+vahPcrCZHwPyTO5VgHGXdAwNgGGpWTGAfTnnoq5+BZEpigOi+H1mvpEkE8
         RXRIwjkU8ga2TyW5AXMhhSqHEKnCCAC8BT0RCwVHasBL7neQFPzp6fL7xe+QsWVVGwc2
         2UiHd8/sVUyy7rmZ0KKOjqgU81mx3L9dv40XDr3tSxkhQsh/KdByoH5F0criiRASkfoL
         7rfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773998594; x=1774603394; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6OISUkB2m0N2/w6RbMgCS+WOol4j624Cph/yPCaN8w=;
        b=JQLbFohe9HjyeNuHNTtC+Ne5Nd3xRRxDuiJH3KNXsYNI15XMwzAPAXl7Teg2wjFzhG
         FiBuA2KDERiyO52WR9N0qTjwCX8mpBWYtxYTDUO4QaHnsqmJU7FgcOP2HIRtzRA/TFBA
         bpmLVX7KZzBd56Js/KbYcOmfP6fjZu989VA6HRqfOeDGG+/mhOYq1UaGyHURE35QcQpE
         Kj/bXV6eZz7GEHM9+d2XoGsf1wvreCxsvWUBpB6GsVOcCO56i1/XGIaJJWc7rUG3m46S
         wL4MYouWOSEyDu3EGFvVF/l6whZMAfsPYn7OTuTfB1BLCMQ5spIgBGxca5NfrV8WWbqM
         je/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998594; x=1774603394;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6OISUkB2m0N2/w6RbMgCS+WOol4j624Cph/yPCaN8w=;
        b=e2DDd8FOkNJqHcy78K2u6QfAQ3muegoxQ+Jt44A8B4NVapPOzjcoxUCcAwxxde2UOi
         FAJZij5hKs37nID25np9x75goq73e7o1cR9FIy6XqEU0TsNgdTQt0r1XqVlGJzl2OOKF
         CJJdi5kFsX91a/ZUTzgCt/f0mqUb/5rWY1LSg8YnAuRG9uYs25Kg7wUoxdPSt2e4uTxc
         8NdSKGYATMsuuDKr86XldUQj2++0WHIdgBRfEWB144+24feduD2OVal9d9NWKToGd8Xa
         oqwchBOYk2yR50NEtU7/kz+7IjO0WVnEmsBJ5S5HE0H5Zuw/PzG4aGgXsLh859aULDCt
         QxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8aNJlfp4IELGAAKE3Q9i2rGveu5swoNrtrl78/yo/Q1BdjhN92j89dKE8vguXRXVwxKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz93FIFbfr9oMAZ8K4lwuA96NF1v+vtO0aI6fCrDU13Uzvzqj9F
	YyYWVTOvsg86ywzVt/8ys9I92bxBmH9Gb2bmfvvrdw0E7Fbd0CPMYaMiqWfdx8v/WNYYfQXrHOy
	VRAl7oLLzWbki17I1kU4DD4fji94P1+8=
X-Gm-Gg: ATEYQzy4rvnMN4TAFz6PLAvC4lDm8zzbZav5ik7NfGO+e/EfdFAo7ookeyrWXj1KcPP
	gE1pq813+rVtR1vUGIB9UAl82DaNLUNP7oD3NYYz3YA9y0BfIK2LKmcYtdNZP/fV0lvKiEZKrt9
	6/o2a863S8CSELhmqAeymtlm3OvcvS32Eh71E+mT/zw62PGT+kh9AX9sIQXCX29fpvGP5LsTSnY
	yD2u4Hk25HetULZw+hGEdY+Z1c0AOr3zg2hQixLuMNls438CDMb39JlcGcLwL2SJX4NdlZEZfRq
	hCnvhyui
X-Received: by 2002:a05:6102:6a83:b0:5ee:a494:1747 with SMTP id
 ada2fe7eead31-602aede04a7mr1125389137.36.1773998594398; Fri, 20 Mar 2026
 02:23:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 02:23:13 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 02:23:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-7-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im> <20260319-b4-pks-odb-source-abbrev-v1-7-5ddebad292b0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Mar 2026 02:23:13 -0700
X-Gm-Features: AaiRm52XyFdreygNd_lChIAqCOPG5TDeFhZoyvWazouRdd-wXYOuXdN37uLqifc
Message-ID: <CAOLa=ZSC=uTPg516dGSEnRcWgr4J9iDBQ+8D=o0F+jT1jkK-sA@mail.gmail.com>
Subject: Re: [PATCH 07/14] object-name: backend-generic `repo_collect_ambiguous()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000d4c6d064d713cb4"

--0000000000000d4c6d064d713cb4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `repo_collect_ambiguous()` is responsible for collecting
> objects whose IDs match a specific prefix. The information is then
> used to inform the user about which objects they could have meant in
> case a short object ID is ambiguous.
>
> The logic to do this uses the object disambiguation infrastructure and
> calls into backend-specific functions to iterate through loose and
> packed objects. This isn't really required anymore though: all we want
> to do is to enumerate objects that have such a prefix and then append
> those objects to a `struct oid_array`. This can be trivially achieved
> in a generic way now that `odb_for_each_object()` has learned to yield
> only objects that much such a prefix.
>
> Refactor the code to use the backend-generic infrastructure instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-name.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/object-name.c b/object-name.c
> index fd1b010ab3..4c3ace150e 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -448,8 +448,8 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
>  	return 0;
>  }
>
> -static int repo_collect_ambiguous(struct repository *r UNUSED,
> -				  const struct object_id *oid,
> +static int repo_collect_ambiguous(const struct object_id *oid,
> +				  struct object_info *oi UNUSED,
>  				  void *data)

So these modifications are so that it matches the callback function
type.

>  {
>  	return collect_ambiguous(oid, data);
> @@ -586,18 +586,19 @@ int repo_for_each_abbrev(struct repository *r, const char *prefix,
>  			 const struct git_hash_algo *algo,
>  			 each_abbrev_fn fn, void *cb_data)
>  {
> +	struct object_id prefix_oid = { 0 };
> +	struct odb_for_each_object_options opts = {
> +		.prefix = &prefix_oid,
> +		.prefix_hex_len = strlen(prefix),
> +	};
>  	struct oid_array collect = OID_ARRAY_INIT;
> -	struct disambiguate_state ds;
>  	int ret;
>
> -	if (init_object_disambiguation(r, prefix, strlen(prefix), algo, &ds) < 0)
> +	if (parse_oid_prefix(prefix, opts.prefix_hex_len, algo, NULL, &prefix_oid) < 0)
>  		return -1;
>
> -	ds.always_call_fn = 1;
> -	ds.fn = repo_collect_ambiguous;
> -	ds.cb_data = &collect;
> -	find_short_object_filename(&ds);
> -	find_short_packed_object(&ds);
> +	if (odb_for_each_object_ext(r->objects, NULL, repo_collect_ambiguous, &collect, &opts) < 0)
> +		return -1;
>

And finally we simply call the generic `odb_for_each_object_ext()` with
the prefix options set.

>  	ret = oid_array_for_each_unique(&collect, fn, cb_data);
>  	oid_array_clear(&collect);
>
> --
> 2.53.0.1055.ga2ffed1127.dirty

--0000000000000d4c6d064d713cb4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a4b094a4bfbfe5a5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tOUVmOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHJtQy9zR1ZWRFVBWGpSU0V0SjZwbWxUa1VlRGo2TQpBSXhxSGdUc1dh
bW41RHBFajdsQllka0xzQW5DalA4MkJwKzQ4VHA2NFBqcm9scW85T0xTRFIzcnE1OWdvNGhDCm12
QmsybmMxbGRvOU83TXIwYVVBbzlsSkFjUXRFNXN0WVMyV3ROeGVPWGYvMUVoMVJnVVl2L2hFR2dB
MXBjc3cKR3MxOFlWOUlSTWhaSGdaVlh5YlJtMlJvclhvTGFoNDh3bk1qWElURmpRajJOODVIM2ZY
YUpNRDUrelIyMGVqdwpDYVd1Tm5SL3dzeGlLTTNkclU0TnluaGtXTC9lZ0xyZGwzdmNPYVZIVjFo
VEQ1dnRQMGNlWGp6Q0ovdWpvLzVKCnhRcVN2VFNOMzdqV2dDK2NsOU9rZjdMTk5ELzJpSDZ3QXI4
eG5FSVc3T3hTUlhKL0wrajVmcHlzcDU5RmlvUVIKUzUzQzRZNTU5ZGh4bmU0a0lUWXdnelVxVURL
eTJ6bWdyRjNISW12L0lzQkdNbzE1UXluRFIrb1J6TkIxTGtnTwpKaEllcWU4aWpMMEJTNUVKMG40
ZW16SE9YZlNzWXhNS29ya3hXc3JYM1JyMGZyZDcxQTVEdlVGY2pOUzhIeHd1ClptWEdWbSt2WTV0
UWd2L1FhWDVURjJGbnVMb2w1MlhGbXQySjZ2ST0KPTRhOXUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d4c6d064d713cb4--
