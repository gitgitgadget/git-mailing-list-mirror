Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424C14FB9B9
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561421; cv=pass; b=Ctolwy1lccVcTcOzACBdQrv01GlRbBUAKRkVNj1I++o3Iy9Std9VmZyN2O/09ecdQPocJYnx8gUyPefCOW8apPPGOyLOjZa5fkheZW3/SdCOUgkeFfGTAcZbNapwLY+rUu6K9K8FNIwDJUDnh3vIWNSxv77naHBdhdObIKEzE+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561421; c=relaxed/simple;
	bh=MSgURqLSJwhasKwHF4Xn51wqPO163vbVJ8Zlmjcw+rQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4qKXJFieH18JyU9dPa9hK5AtM9TBXmEagay/Ffs9rvoTpd1OJOUkYCnU9xRZ0yMwDhanG3Mp2W0jxU4MfoTTh+innJesZFZUB4PmrBn4/XhKHp7M/1m4JDIVPNY3vc3eiCDVPnhFZ5fp2eTCJlj3BJLHDPI1OHmLrAPHP2oGLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZdj2D+7; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZdj2D+7"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-980a6b896c9so13967241.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 15:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788561419; cv=none;
        d=google.com; s=arc-20260327;
        b=AamaKZ2buTZFTy6LC3CjPEF1GBqqnt/i+5j8oQqbHeLgNL/Uk1Lc1JZ/CSJ/eFX6q5
         4eFml6V3SXjVtGfebrmL7MgzNHaopyAWNGTCgOotWLTluV+4f9xDbxruAEupEGIPgepb
         e031X9Bk+Z7lhwrl+rC5rXR/QQkwjqMcSFmXh7/Afl+z08PpvWuSGI5JZHsgGUym+EVq
         76KVlFHTbVNqlAmCE7ShCGISKKU73M26fatDt1igkJz9GXkpPtu7x/VFMcVmmkW4Jkg4
         dBPNfuCbB7AQVsQ67oJRZokB/uTeNNqjOfMSZYCo9ZYVVOdDi8dgdoY0+viGcOT7cyfD
         cFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=YO3wQ86kjEEaxRIDxve4bM6JDp7aRoDnO5qQZZpyZjg=;
        fh=D0btfWjcKOPOipZBCDpAsNJdWJiBHsihxDYLZzunAzQ=;
        b=ZVNi9gwLD69LlxATbgaZ3o5bqwxO3TnoG9rFElEtAjJo6F5US6Gm0WNWIY79uDP+D5
         vNd2SW8T7NwZSYemc8a/Dgyaw4Fqmd8CYPwz3jZGX0hjz1vyhin/UFOONNCPEABqds1k
         LotbSz7JkjV1mDnFk5N5yBccDNZY5t0sAwSGztVX4QLtW9q5TQL+BK/XrdzHnZymp0ce
         36xgCRF4IxiyVS3ZfwmbPJpfA+SHYGy/sF7wQvHhtQWbffG+k2JCN1XqpKYjX2KmtsuW
         AgbTNS14D7MZvhleAtneDM48uHFdvy6PTiKHMmf8/9o5bJGkyFA0Uvp647degUp8bL4K
         ru2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788561419; x=1789166219; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YO3wQ86kjEEaxRIDxve4bM6JDp7aRoDnO5qQZZpyZjg=;
        b=eZdj2D+7ZZoIP59OOkrpAXP25YxmBu+GYyoDgKgS2mYmMHHOPq2IDtxwGWb+Q88ch9
         juwDQ8lccWRQDrFCedR6edsujM05aeraOxIEDlgnhH6Mr58GqXXce0qTvQOZeyLlkE0S
         HG0llXLU4z6eOS6aOqhL20GWDp50WYb6EU6grH8APNAK0kve4J5BlKjQXT26UeiVU+G4
         nyUo3IweM8l+oZ54+f4tgd/AFZmmcer/w4pPl4Ed0SUXs4eNGpr5caP7P4Mv9+/8VVA6
         kxu0thjVnEXQlyeWwyPr5swGvcyZ0bGROzkv9+xCZMYqsuyHIhe4Ppqfm1p4A4334foR
         kTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788561419; x=1789166219;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YO3wQ86kjEEaxRIDxve4bM6JDp7aRoDnO5qQZZpyZjg=;
        b=DfF50Zf3M6YU8HgTtWv/JhMwEqZg9WoAV3R6F9tKgxmXZpEOOJnqAki0lLnR5ASYwr
         gLOY6apf2BlMtQsu8Drjb/YI6Dxg5W+Wi8odJrFDuLOZuUYRMDHUisixs7U4pe3v7oFv
         GauOem5pw/K4blJ4pjIfN/yVOXF0I0k5BjxkQjKHP35gklCVkiHB4Z8/7hPDzMxo3u/S
         IHLzcp8NREUCF71ygst5P61g1WmSk7h9iGsMdFI5OST+7tLrELCVKhWv9D5bUzKHmc8X
         kdML0NLlwuQzhbyTsyPOJ7kj8jVdG5quspP4Je2eTD9v6N94CNyGO5l9iHwQICMfs8qb
         DqBg==
X-Forwarded-Encrypted: i=1; AKwUvBxmqyOucxs7NANWRxKFru92auIi7tLytNGCvXrk00UZoMNtOZ8NtY+VFsgurXWSbnGlVvw=@vger.kernel.org
X-Gm-Message-State: AFuF++nPaWDCJSRZ8+6F0CMgvYnF/Lx730X4CzyGDgyrro0MKLmcPVtO
	EGR7kZHKCOYX7Z3Py9ymXGnXXaGLT83JpHBr122f/kxtEZZ+s8h8Y1Rc6y2JAmL8nUeNGvywr6j
	YlVY5QyOpxiGm6lOPiT8Z2GBTN3b/dOw=
X-Gm-Gg: AYBFou3uz7bhbGNgf3R8bx93d7Wg6NaZ0wDt2klP8ptEC8Bz+zSzMBol89t8YYj173M
	/kZEFky9ysw6BVSxwlyfn/90oSqgh2/KI32R7yHlNpUK1130heKVpKxi+3oexg/E+VTCAO+79qV
	FVh5cstJTtiYN4ccQSx9XMEmrCtXVD6ZX9NiOi43vmcFiRdUtK8glwhwTZI/Sv9ZBF+BKTYciU2
	MHoqdYFLy6zmFmngGuVa6xOs/2Wog+ynEYOxMxzHiPFoT8hTfl3y3ozsJNql5ok6gfIip/Hzt/L
	f9s2C8LgLCp640kvbDVcQ//SblTXSc/Vxp2faffoDYSIZ6s0mgU+DfJ0wS7z31RgZDUHOfL4BRE
	Wh7nYxz6fpUaGOykyUBM8QGTcn2nWNngN8f0=
X-Received: by 2002:a05:6102:4193:b0:785:8ad4:57f2 with SMTP id
 ada2fe7eead31-78a4a5392f3mr1819106137.2.1788561418946; Fri, 04 Sep 2026
 15:36:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 15:36:57 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 15:36:57 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-7-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
 <20260902-pks-odb-registering-in-memory-sources-v2-7-c6ca12fdea4d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2026 15:36:57 -0700
X-Gm-Features: AcwNN1UPGQl3yyFmWnur8GsHP1h47iD-CLEAbBXsOWpymsJ8OwfFvdUF9r5HPuA
Message-ID: <CAOLa=ZSW=kZ4BQ9updQ9jvTs=g1oWe_24LpAaSW082iQkQcFrA@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] odb: remove infrastructure to register submodule sources
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000000927a0065aafe8bc"

--0000000000000927a0065aafe8bc
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The preceding commits have removed the last two users of
> `odb_add_submodule_source_by_path()`. The mechanism was only ever
> meant as a transitional crutch while migrating submodule object
> access away from "add the submodule ODB as an alternate of
> the_repository" towards explicitly passing the submodule repository,
> see a35e03dee0 (submodule: lazily add submodule ODBs as alternates,
> 2021-08-16). Remove it.
>
> As GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB is now a no-op, remove its
> documentation and the exports from the test suite, as well.
>

Okay so the last two commits removed the last two sources which
registered the submodule as an in-memory odb.

That leaves us to cleanup all the code around it.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c                                  | 36 ----------------------------------
>  odb.h                                  | 14 -------------
>  t/README                               |  7 -------
>  t/t5526-fetch-submodules.sh            |  3 ---
>  t/t5531-deep-submodule-push.sh         |  3 ---
>  t/t5545-push-options.sh                |  3 ---
>  t/t5572-pull-submodule.sh              |  3 ---
>  t/t6437-submodule-merge.sh             |  3 ---
>  t/t7418-submodule-sparse-gitmodules.sh |  3 ---
>  t/t7814-grep-recurse-submodules.sh     |  3 ---
>  10 files changed, 78 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 6d5943e5ea..2f8a70a90c 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -388,12 +388,6 @@ struct odb_source *odb_find_source_or_die(struct object_database *odb, const cha
>  	return source;
>  }
>
> -void odb_add_submodule_source_by_path(struct object_database *odb,
> -				      const char *path)
> -{
> -	string_list_insert(&odb->submodule_source_paths, path);
> -}
> -
>  static void fill_alternate_refs_command(struct repository *repo,
>  					struct child_process *cmd,
>  					const char *repo_path)
> @@ -549,23 +543,6 @@ void disable_obj_read_lock(void)
>  	pthread_mutex_destroy(&obj_read_mutex);
>  }
>
> -static int register_all_submodule_sources(struct object_database *odb)
> -{
> -	int ret = odb->submodule_source_paths.nr;
> -
> -	for (size_t i = 0; i < odb->submodule_source_paths.nr; i++)
> -		odb_add_to_alternates_memory(odb,
> -					     odb->submodule_source_paths.items[i].string);
> -	if (ret) {
> -		string_list_clear(&odb->submodule_source_paths, 0);
> -		trace2_data_intmax("submodule", odb->repo,
> -				   "register_all_submodule_sources/registered", ret);
> -		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
> -			BUG("register_all_submodule_sources() called");
> -	}
> -	return ret;
> -}
> -

Nice, so this remove the code to add the submodules as alternates.

>  static enum odb_read_status do_oid_object_info_extended(struct object_database *odb,
>  							const struct object_id *oid,
>  							struct object_info *oi, unsigned flags)
> @@ -614,16 +591,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
>  			}
>  		}
>
> -		/*
> -		 * This might be an attempt at accessing a submodule object as
> -		 * if it were in main object store (having called
> -		 * `odb_add_submodule_source_by_path()` on that submodule's
> -		 * ODB). If any such ODBs exist, register them and try again.
> -		 */
> -		if (register_all_submodule_sources(odb))
> -			/* We added some alternates; retry */
> -			continue;
> -

Right so this is the retry mechanism when readin an object fails.

[snip]

The rest look in order.

--0000000000000927a0065aafe8bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 66cb97632fb1dd90_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xYlNBY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1c5REFDZnR5RVV6ZmlXa081Y2R1MmlIUytLK0VZdAprL0dlL3lkdlBF
TEJXS3AxU21FVU4vZFNCV2JPeGxNT1J0RnlmejdTZStQYmc5aTdlRWxFUkp1L0JMUFNiN0pWClBT
a1ZTNm83WUdrZFFiN3hyTCtnZUZ5NmRzUTBNS3BIeEhZV0duaVdIZmUvUk92azMzRG85d2xaWWY5
SjFSMjgKYzgrS0ZIUGtzSDNXNHkzWk1vb0J4R3lMcUc0UURBQTVpVTNueWFLU3hSblZGZmZKN3c5
M2VKMUUxR1QvYXhObgpsTnh0ZDRtQVJEUys5Ry9uTzNlL1NPYk01TTdidXJ5SGRVS3FtaHlobm1v
eXppTk40ZXpGeVZrQXAzT3oyZGthCnBWU2RjY25QTDFjN1dPTGs0NWxZMDIxejJhYzRLK0xwRFYw
ZlhWTnpjVGYyS0ppejgzK2V2NnYzMm9tcFJxclcKbDJiYTZxZldEWWpERlZBc1l2U1N2NnlEcmRK
NlB5eVpxVk9qYjM1NmljcCtIeThmNzlHZm5keVMvb01UUmZpYwpPRHNmOFU2SCtjZFkwNGkwVVpY
ei90eFd6SjFKb2orVXREMXJRTGc5WWQ2bVZ2Z2M4eENyaFg1Y1RpOEJkeWJGCmZkcFlnN2FnaEV2
cm5RS3Y1QTB2MkVUYmdLbTZmQThpb2MvU3hOMD0KPW9nVFYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000927a0065aafe8bc--
