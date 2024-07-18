Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81813D89D
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309194; cv=none; b=NK0qqjKE5w2nwHGxh6qow38NcKqqdwvII594hVL8iTghcESCGw+IUNfMXnRmwH5Ido6ZMrB6SHGvzm1Tw2u1EaetjHGM2SL8CjfgevZPnTXaVf3qqtEc9kmDbKL4Tm7j5eSiso5jOs8BaT78f2h+fglX7Qh/c/FN3SRkq2s1WLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309194; c=relaxed/simple;
	bh=nHCbP2mt/9olSiELAxv/QqQrWkb3ReGIToxhlcNhpX4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atvwbH0ilfrm8FfvzXbgP/7s+OnZ2BSo/KaMPtsEespxSIeP5B3sPMXs2AcfFSS4VD2eWvPEs6/051CAcNzz3om/NaG1ADlcBhIFEkoZ2DCxNk492K6f43IdlW11SNcRG1R5pi7pUZl0nA1gxvqWk+WOpOlb+c5eYPT8TtnAdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPhCZ6VE; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPhCZ6VE"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c66909738fso854137eaf.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721309191; x=1721913991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MBM5qO6EtIs8S5I8pwYGYxwIs0qLe1MglNEcDT1o40=;
        b=fPhCZ6VE9i5sfRr1Mqkd1Q7tIZd5gZ9ftuI4CsuMURHvsGC775MzqgdKhSymjF2/BF
         a6/SFjKi4DMywaUyPHpBA8MkjLBCZeruXxH/qZPwV98SDKp2vjTz8xge404vsajr3Xly
         xCUKkwBD7N6K/YyrY0fIBBLzFYj0ZfOyMOyBvAk8DDgojE+swZeKpx7Oe59o4jZMmU3n
         rh9hlkGFusx7N0jeU9j6ub5wqGerqkzvzbOzl0HV7Em9l5kx9ZDTW9vDHxVVjqU2jk5A
         ngMZUFbVBW9EcZiRYoguYW1Sk+QZlNsb40OxdXrBOoJCeOTzJuaLbJgpEDWfB+9CTVMA
         1SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309191; x=1721913991;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MBM5qO6EtIs8S5I8pwYGYxwIs0qLe1MglNEcDT1o40=;
        b=sOSZayQIvEhiJcWtMlsFZd/mTC2nBKzu28aF19FkEuBCynBXKXI/C5K0tow8D5oaw4
         GU6+0acwWxpYdwrkRPvnWgOuXQBihIqrVynRGVY7CF6YLWKLSpuOUlvyXlbOnrjKy0Bg
         UOmbx57EJN9DLGkUSSZqHn6jKTCNyI9SRdJy3sX4OPiaH+6ATh4Gmr/T4FZqcqDmBEc5
         UDGWCnhs/0QsUbjw4rFzG8zHafmmJwPnSl9fYdLBKmUsZH2/LjgKzp7ioO5LMzwRfBV0
         FSlJonrJ4cxxbL/CgHWvZSQ4F588q4yqUSWuMgyrFFDRiw46+U1CFJS0Gnui9D04hfty
         PvLg==
X-Forwarded-Encrypted: i=1; AJvYcCVevszan6335kXJKkqMg6gxbQQYZhFJEgrK7Prjw7LXE7C3iXMir9WQC6xznUNtYnwJwYN1jaC2lknuI3w9T669aGyf
X-Gm-Message-State: AOJu0Yz0JIXU9tTgSjfdUiveiV5aInXefnKEt1Su4OvO646HTYliWlNo
	FtaUqMKYmpZrKb0NKxcdFWzIpJLnKQer570nBoQtXhbEDNqEHWYr76SkxDK4H3T5oEexE/rVsAw
	uYMj90FcnSudwcWiGn31XvAlmzQzhUh9b
X-Google-Smtp-Source: AGHT+IF+4RZNrgrHlK2s3TudqtAFlsLdO5oqsXCYupPXQN+Dr1vq1OFot64r3HRfXI7zRXupmSMSl9V6v2LYM1lFDgo=
X-Received: by 2002:a05:6870:210e:b0:260:e777:32a8 with SMTP id
 586e51a60fabf-260ef737686mr1216926fac.2.1721309190930; Thu, 18 Jul 2024
 06:26:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jul 2024 06:26:30 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZpPFElAYLVtRlq-e@ArchLinux>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux> <ZpPFElAYLVtRlq-e@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jul 2024 06:26:30 -0700
Message-ID: <CAOLa=ZS07xF-MYLoS8O2ynE5DdPJPEEwaPsUR893fYUC+U1ZwQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v11 02/10] fsck: add a unified interface for
 reporting fsck messages
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000dfe43a061d858631"

--000000000000dfe43a061d858631
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> The static function "report" provided by "fsck.c" aims at checking fsck
> error type and calling the callback "error_func" to report the message.
> However, "report" function is only related to object database which
> cannot be reused for refs. In order to provide a unified interface which
> can report either objects or refs, create a new function "fsck_vreport"
> following the "report" prototype. Instead of using "...", provide
> "va_list" to allow more flexibility.
>
> When checking loose refs and reflogs, we only need to pass the checked
> name to the fsck error report function. However, for packed-refs and
> reftable refs, we need to check both the consistency of the file itself
> and the refs or reflogs contained in the file. In order to provide above
> checks, add two parameters "ref_checkee" and "sub_ref_checkee" in
> "fsck_vreport" function.

Nit: It would be nice, if you described here, what is the expected usage
of "ref_checkee" and "sub_ref_checkee".

[snip]

> diff --git a/fsck.h b/fsck.h
> index bcfb2e34cd..61ca38afd6 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -114,19 +114,25 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
>  typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
>  			      void *data, struct fsck_options *options);
>
> -/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
> +/*
> + * callback function for reporting errors when checking either objects or refs
> + */
>  typedef int (*fsck_error)(struct fsck_options *o,
>  			  const struct object_id *oid, enum object_type object_type,
> +			  const char *ref_checkee, const char *sub_ref_checkee,

This makes me really wonder if this is the best way we can do this? This
seems to solve for the current situation, but what happens if you want
to also adding the reftable size or packed-refs size here? Would you
introduce another field?

would it be better to add a single `const struct *fsck_refs_info`
instead?

Perhaps something like:

struct fsck_refs_info {
       char *refname;
       union {
             struct {
                    ...
             } reftable;
             struct {
                    ...
             } files;
       } u;
}

Of course we can fill in the details as we need them.

>  			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
>  			  const char *message);
>
>  int fsck_error_function(struct fsck_options *o,
>  			const struct object_id *oid, enum object_type object_type,
> +			const char *ref_checkee, const char *sub_ref_checkee,
>  			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
>  			const char *message);
>  int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
>  					   const struct object_id *oid,
>  					   enum object_type object_type,
> +					   const char *ref_checkee,
> +					   const char *sub_ref_checkee,
>  					   enum fsck_msg_type msg_type,
>  					   enum fsck_msg_id msg_id,
>  					   const char *message);
> @@ -209,6 +215,17 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
>   */
>  int fsck_finish(struct fsck_options *options);
>
> +/*
> + * Report an error or warning for refs.
> + */
> +__attribute__((format (printf, 6, 7)))
> +int fsck_refs_report(struct fsck_options *options,
> +		     const struct object_id *oid,
> +		     const char *ref_checkee,
> +		     const char *sub_ref_checkee,
> +		     enum fsck_msg_id msg_id,
> +		     const char *fmt, ...);
> +
>  /*
>   * Subsystem for storing human-readable names for each object.
>   *
> diff --git a/object-file.c b/object-file.c
> index 065103be3e..bc63b80c48 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2470,11 +2470,13 @@ int repo_has_object_file(struct repository *r,
>   * give more context.
>   */
>  static int hash_format_check_report(struct fsck_options *opts UNUSED,
> -				     const struct object_id *oid UNUSED,
> -				     enum object_type object_type UNUSED,
> -				     enum fsck_msg_type msg_type UNUSED,
> -				     enum fsck_msg_id msg_id UNUSED,
> -				     const char *message)
> +				    const struct object_id *oid UNUSED,
> +				    enum object_type object_type UNUSED,
> +				    const char *ref_checkee UNUSED,
> +				    const char *sub_ref_checkee UNUSED,
> +				    enum fsck_msg_type msg_type UNUSED,
> +				    enum fsck_msg_id msg_id UNUSED,
> +				    const char *message)
>  {
>  	error(_("object fails fsck: %s"), message);
>  	return 1;
> --
> 2.45.2

--000000000000dfe43a061d858631
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 270095d8f26d0eb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hWkdBTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meCtVQy85UTUzSlFiamNyeDNYZWZtRUtPaVRIWWFmZAo3eFlCQXp1VG52
aFVSYVlrZjAwQ3E3YXVPcHZ0NHFKUjBGTS9kYzFRRVEzcEkrdkhaVFROQ1pTTFNWeVQrWUFKCnFP
ajh0ejUyZjQ2VzlUc1l0di9aNUYrM0FLSFYwOFpnbS9VdXJScU94TFZnWWZNMmY2c2RvUmt2VDMz
Y09kd2IKU3BwNFlJMHY4Wmw0UjRRNENMaDVBZmQ5UldKVmhIK3BnQzZ6Z1R2cWJhRENOTFFLS0d1
NTVsc21TdmNidHBPMgo5YTVjc292Sy9RRzlMVDRyb3A1cEt6OTZ4T3NreXNSMEUxUGprR0JuRmtW
WWN3N05jVUM3MEhnK2I3b0JnWVc0ClMyZjdkdW9hQnkyNnB1eDVTNzFwTU9RRUNiQS9ZY1dGVURx
d3I0NWZ4Z1d5MEk4VjNaTWdzWkRod3A5VGZVSWUKMngwYm0ybWJrQWROMWdieG9hVnhZcjNieURM
MEtmVUZzaHJCYzlMTXpjVnJjOTFKN01JRzdtcW1CeWlXMDZWegowZmRKNDlreTFnR1c1V3RUTGpv
bzNmbVpnRFNSVmFyZ2dQdEI4MkZUcUtaY1ZkdFBkbFB4UjhkV3Bha3NRQW9FCmxYRkRvVDZrWkhK
VjhOYjZQVGdvUnpLY1ZQVjhGQ3V0U2Q2d0NTcz0KPUFic3AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dfe43a061d858631--
