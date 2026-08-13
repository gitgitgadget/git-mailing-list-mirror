Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585503EC808
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624101; cv=pass; b=LmJnTm6g6zjilVgd0bkMSQenaGU6LZqOsXcqCHB0X0Oc4hVJAqsPpkuSdvsM3G8W01BpRel4v2bm/LXbFQKWRhMJHI/lzlPP3ATimHmOnFm7Smp6sdi4D5WZ+3CiORLrzQLq6bvyQp6PHmlU4OkHJg/8PlUqe5pxoo1d8dSIHJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624101; c=relaxed/simple;
	bh=i+NDcWnKomGj3/jpC8IQmrsh0SfZF8Pz0wlSC9bcF50=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttsXvT7Dq1Yocen7CF7zoeEOknO0voOMYl6zdWuAWhUfCrRMCL1CYTnQmwTbAsii0fs068gdYMKeG0YfEw4k+EnvDErVqOHVtphxP1Qz8gVPehX9EX5pezpq4/YeHYoGhWZ/7jxbST3sv1yHk/PbKuXEiQMBTCWTXpGkgsv87j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtrGDu0Q; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtrGDu0Q"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-966e7380109so1461681241.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 05:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786624099; cv=none;
        d=google.com; s=arc-20260327;
        b=AWvmky8JvFO1Wr/1/fY6e6YZyzAlKxd6WZnkrmRN9C6SZMKP/em+zyMi/f4xcIF0Uf
         2P8v1oaQn5QmL6qgER9bug1BsdjQAW09phPGsXxBqaycT/jmz/Lp19uBBkt5QOKxs6oM
         sxDpnoD6CcdvC7mmZLBhJiiBGcvyW42kmjR0ag+rykX/c1gPdPsVCDFIwtU5MPiyF/tO
         LmG2U/xwKphWPjf4oJBrrFCn1paD2am5L7rxEniiIQdkqOd/1KGdtQvNaMx9FQ9vI7gg
         VvfU8U0J8qJ6w5Zwob03DWT3g+wNeVnRenrdWWnpv+8VjPfHZMATLJtOwq5waNcy2No8
         bxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pEgvvAT2QAjljmMqAgOdJZUKUYGKXFQLbuVZFx+dSn8=;
        fh=ps4lp2983zCOWUpk42SOuB/9SUMgaxH57ZqGbUEtfvA=;
        b=RrCwvhPOpGx5foY/TXSOVFdHQxqkwHSgaSVpgUcLJcYxkN1NgXCREwvlGEqEAyL5d7
         TdOEBem4XYiZc1yn6kktaNfNBD319vFWfo5oja1xb81kXL47nBs6oOnFWRdSPOtf4NTk
         zYtpVsAf6PE4qLTQS+MGQeMEuulixYDIxDCuCHiSq9ouEDH4uSXiM0Bq4JwGu5t5fwAv
         qTzjtUvMm8weqdPayxvztikZ65p2YTxz8mOfsOK1EsmrOEF79xClsHQeiw0If0UsD6CB
         NTobKftrcpD0c0FTTV76zTvp2x5xTSUrxbJL70QSY1n0lE8CfVDudOzoNm4fnbwUp7oo
         LR7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786624099; x=1787228899; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEgvvAT2QAjljmMqAgOdJZUKUYGKXFQLbuVZFx+dSn8=;
        b=NtrGDu0QgV+5mZq64PpSnVEnrHrW7L7y3dzvyTg+psg8A3yepiiicOswh1qAXnfVOr
         iE53ZUGVa7S9tvjjRMkh5wYGbSfvh6zhlevcwC6il0R0lCtNb4xroQ6xgyslNutG50YD
         e47xb+f/oFEEW0L4RHYUTjBSXWLFNQixt9JlQH1w6vVkonwjqb05OyXHzR6/OjJxx5no
         orkEZLUdffj4TLKRgwIyX2AlYSufUblgfCMXpbnKKt/iwjZYyHp5Jjc/iTD2YHf3insr
         bNMsipX6wVUQjjgVO9aCMtabVz7HAnEAGoW84aEe5RZ4b38MsKBWq2X1w9LbXCSLaR8k
         st6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786624099; x=1787228899;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pEgvvAT2QAjljmMqAgOdJZUKUYGKXFQLbuVZFx+dSn8=;
        b=KTn6ue8yEQOgjo4t2Pukx4Oa40jRS3+VH8iC1WSUh2Xa3RLcLVpw/L2AwunD59UHWm
         TppnS1NvziHEIuN8b9T/QQ3haaj3OicrBQgIkcGfqrWN9XlppBF1Dub7M5FJic+0Pz+n
         bqSX5rMo9arUGxj9N3DuZ0448ZBF1VsNkxRJIv7fZDlNigXOavGm2VfGX0jkRchDdCZ8
         e9APETmmVI+sWFKRWlur9VUghAXrpVWcOMJdG6Tqf3feM32bbgy9C8/+4lEGpEiG/W9f
         me09Q+9b+lep9a9cBrK8JMSgUTiwO/wQDX6OMyWQBOQYrUHpBcrW/hfOl8AWdd2PyTq2
         /3Ng==
X-Forwarded-Encrypted: i=1; AHgh+Rrvjc0r4kGLRmNhOYeYhmU97jxIHsrL2XpUNnGzowKrUOpcwvo/VQ0S2baRCOW1yWaWseI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6kljF96adFvxXfPbR7w7KbiJdK0BL0Wc09JgFuClfQDOSYgw
	UZS+TWEJZuzyctZtWpApppo+X4qIM87ry66czg6ymDPkMBmEyJqhq8OJ/skjCSKNLeB+xlmIXZN
	9zomc1WZjQTGc0HWsiJ5ToBISqZnyHPk=
X-Gm-Gg: AR+sD10kV7JJicA5s1wVI3ceBDp5BZuKIRiVGaayvpDwkXR59uXsrKvdkBxE/dkse1u
	S5G7+uqY+t4wkU7YEw8znukt6SQDEiq3b7aB/rLKMSsN1DyCBVw2Qii668LvTjz2JU8mblPXOiW
	c/q9Nlrr7kd7XFmyq7y77fBYmKVfRgxgHQveDswvQLOsOWol5Lv8Qsg1R3wgVFS1wU2eex65g8G
	7XBAdgrbvH1qlgs4ZsKG6rFGtkU5JWkGdO5BjifjC3tn7ejQljqds0CwB12yyAZO+phaisjd66/
	h/ZDdYoEbQSlDYklK1YCMQ/0rZyYhPOrNLmtxSVYfSVknAA7ihnh4jDg02J4AhUAxt0VtoY4x0q
	0rWT+HKLcZr/4NpWdphA9bWLjW0HOr7MaH60=
X-Received: by 2002:a05:6102:424f:b0:738:3525:43ff with SMTP id
 ada2fe7eead31-76db886e8d9mr1574734137.13.1786624099094; Thu, 13 Aug 2026
 05:28:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 05:28:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 05:28:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 05:28:18 -0700
X-Gm-Features: AUfX_mzUN3FQgMPMoPvBxOjl5kTrWx2l4V-JyfpozLWpcOXI27eQbE7gRAZdZAM
Message-ID: <CAOLa=ZTLq2xjkC12B=4wPJA9UJ1PWS4_iUAyqgcJ7GYnbM2YrQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] odb: eagerly load alternates
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c635b40658ecd611"

--000000000000c635b40658ecd611
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> when initializing the object database we only eagerly initialize the
> primary object database source. If the primary source has alternates,
> those alternates are only initialized the first time we really access
> the object database.
>
> When introduced in ace1534d6f (Introduce SHA1_FILE_DIRECTORIES to
> support multiple object databases., 2005-05-07), alternates were
> originally only loaded when a given object wasn't found in the primary
> object database. This was also reinforced by later optimization, for
> example in 693d2bc625 (Attempt to delay prepare_alt_odb during get_sha1,
> 2007-05-26), where we tried to avoid loading alternates in even more
> cases. But as Git has evolved, we eventually started to eagerly parse
> alternates all over the codebase, including on every single object
> lookup, and consequently deferring this operation does not really buy us
> much anymore.
>
> The result of this is that we have calls to `odb_prepare_alternates()`
> cluttered all over the code base. This is somewhat awkward, and as
> almost every Git command ends up reading objects at it doesn't even buy
> us anything.
>
> This patch series thus gets rid of the lazy-loading. Besides simplifying
> the codebase a bit, it also prepares us for moving alternates into the
> "files" backend as discussed in [1].
>
> The series is built on top of 010afd3166 (The 12th batch, 2026-08-07)
> with ps/odb-make-creation-pluggable at e927cfeb21 (odb: make creation of
> on-disk structures pluggable, 2026-08-07) merged into it.
>
> Changes in v2:
>   - Add a missing word to a commit message.
>   - Explain why we don't have to handle GIT_ALTERNATE_OBJECT_DIRECTORIES
>     when re-preparing the object database.
>   - Link to v1: https://patch.msgid.link/20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im
>

V2 looks good, I have one nit, but it's not work re-rolling :)

> Thanks!
>
> Patrick
>
> [1]: <amLgMqkqxR8mKIbT@pks.im>
>
> ---
> Patrick Steinhardt (4):
>       odb: decouple source path comparisons from `the_repository`
>       odb: eagerly initialize alternates
>       odb: drop `loaded_alternates` field
>       odb: drop `alternates_db` field
>
>  builtin/fsck.c         |   3 --
>  builtin/pack-objects.c |   3 --
>  commit-graph.c         |   4 --
>  loose.c                |   1 -
>  object-name.c          |   1 -
>  odb.c                  | 109 ++++++++++++++++++++++++-------------------------
>  odb.h                  |  22 +++++-----
>  odb/source.h           |   7 ++++
>  odb/streaming.c        |   1 -
>  pack-bitmap.c          |   2 -
>  packfile.c             |   1 -
>  packfile.h             |   2 -
>  12 files changed, 70 insertions(+), 86 deletions(-)
>
> Range-diff versus v1:
>
> 1:  25802adffa = 1:  721907c60d odb: decouple source path comparisons from `the_repository`
> 2:  1e73b730d8 ! 2:  3b2c23566c odb: eagerly initialize alternates
>     @@ Commit message
>          many calls to `odb_prepare_alternates()` cluttered around the code base
>          whenever we are about to iterate through the sources.
>
>     -    This lazy loading doesn't really add much value: the moment where read
>     -    any object we _have_ to load the alternates anyway. So given that most
>     -    of our commands would access the object database this optimization is
>     -    not really buying us much in the first place. Quite on the contrary, it
>     -    makes the code harder to understand and is a potential source of bugs in
>     -    case any callsite forgot to prepare alternates before we iterate through
>     -    the sources.
>     +    This lazy loading doesn't really add much value: the moment where we
>     +    read any object we _have_ to load the alternates anyway. So given that
>     +    most of our commands would access the object database this optimization
>     +    is not really buying us much in the first place. Quite on the contrary,
>     +    it makes the code harder to understand and is a potential source of bugs
>     +    in case any callsite forgot to prepare alternates before we iterate
>     +    through the sources.
>
>          Historically though there was a reason why we deferred lazy-loading: it
>          may happen that the repository has "core.ignoreCase" configured, and we
> 3:  2ca1aa2a37 = 3:  df5d7df91d odb: drop `loaded_alternates` field
> 4:  1e97c93bdf ! 4:  50a37ef385 odb: drop `alternates_db` field
>     @@ odb.c: void odb_free(struct object_database *o)
>       	pthread_mutex_destroy(&o->replace_mutex);
>
>      @@ odb.c: void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
>     - 	 * the lifetime of the process.
>     + 	 * Reprepare alt odbs, in case the alternates file was modified
>     + 	 * during the course of this process. This only _adds_ odbs to
>     + 	 * the linked list, so existing odbs will continue to exist for
>     +-	 * the lifetime of the process.
>     ++	 * the lifetime of the process. Consequently, we don't have to
>     ++	 * reprocess GIT_ALTERNATE_OBJECT_DIRECTORIES here.
>       	 */
>       	if (flags & ODB_PREPARE_FLUSH_CACHES) {
>      -		odb_prepare_alternates(o);
>
> ---
> base-commit: f6ad67a7977439ad8351d42e6ccfd11f714db765
> change-id: 20260804-pks-odb-eagerly-prepare-alternates-3efb0a38e0dd

--000000000000c635b40658ecd611
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 51ec75357b1bd5c5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wOXVHQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODQ3Qy80eHNMMkRUWGpvVmtKTGdNdkVUeVZJdVBaaApIWXQxWitHZWw0
RVRBUDVvOFgzdnZ4TDZ6SlM3dFJYUThVdktqUzBKemxkY2srYXdjdkpHL2N0RUNMVFI3UGowCnA0
b3Y0MHI1dExRam9FUnYzUkNHRDA0VEJ1dVRJc0h1NVFvalVSZ1F6QXBUWkl4ekd2UWcxejhCcXdh
OTVLSmgKc1hveWlmTWU2dy9XRmd5QmNiSyt4MUtBcS9LMEs4NTZlbE5nOENiUWNWOWwvTUNZNXlB
djJVRmdrTmt2bDFEbgo3bWFYRGZZa01vbHdwcUYyTEFFUkVNSDhwZjVyVjdNSFQ2c2lvK1U5cVpm
RUVlV0NMcHBxdC9KRjZBUjdxMy93CnFRTzFra3VHL0dKZnEzVDQxSXVObktMSjI2SjZXbGprSDR4
QzFOLzY5cStDS04wZytSakNvTHY2bThkNjN2dzcKVDB1SE5lV1AxYjVIREpOcUpjbEUzY2RlY3VI
UTduR2ExUjB3MXhxQy8wQmRUQVdaYTl6TmFSdENnYUVxNE41eQowT0xkZEtpYlp5OFVKRFlIQit6
dUVpSGwzOEdVVExORGxxajBsS0prTDE2RDgwcGFpdEVJNGI5NGRWMG56U3loCmlqd3JwMm12b2tp
YTRscUJVKzRhUm9sMVRMZUlLR2V0QlBlOWRtMD0KPWxqWTUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c635b40658ecd611--
