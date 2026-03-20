Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD0A328B7D
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997306; cv=pass; b=gV4/aJWk3HWruLse63V6OqNg75Aqp3PP67fbEIBmGWubI30kbKJwOglKVjSIntyjM0PI3j+J0hjhUQDNsj5lUopgC0Dop04fYW9DCVxNnkYC6W3qf/lx4WqpS93AWbb4yuqfkwETpc/iC1sKoa7gSWIJ0VAxrfabgoEWHvxufOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997306; c=relaxed/simple;
	bh=DhEi3d9XMT4DFK+w50FswW4XNVVsjgLotnjLcyVcf0A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=NAhUI4IR3r0DPqXPvEt3GVkQEJlR3hWHuQv0LttMaEigwLMZymvRBmx8gNULUbmVuLyFmMfG7MDNfYGDcnuargFhszutPxoZ3e7Ttj16GPzjT5d6FXdfLOoxHJVHqj89FPES96raQhS4O7GTdTHE1sKve50l5vOSPL5ha4+eJJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMfIGqcI; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMfIGqcI"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-60294768235so299537137.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 02:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773997304; cv=none;
        d=google.com; s=arc-20240605;
        b=LCeQoltQZ9vcR0Vvu2RfoNuux8F1rvwinOMWiBNOB7y+RbC+FgcVaUvSFgD2l0yGdO
         MowMPIJEZ4tEpswK8vJ7lL/PnNI8F+Xw1nn0+dB9R23j6qZmF+wtSDVOdDPHa91ZE3vf
         1w+Dv/RZb34O4X6qrXaOg/qMxEPK1KBstkmymb+CgWO7ml9kSGoeOLZFvsQwlWpzyuid
         sH09DgcpR39fN5bgjDDnXRiH7y+4lsj20zj+i0O4oXyy1mAjCQzGqarqQ2z6UHlKKc2q
         qbW9lZI8VZqISKrEmvyd8FyBrG8UT0S45H7z0mJj0BG2zkdWB0d/VP40ErEDVTmaRcN7
         j6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=iN7GUmLbe7V61AT4RAuDgW79RdRXK0+E/XqCaySfEtE=;
        fh=2C0NXKhR0y9dHbTW4MXxRlcJOAV1HnyXxe0DHq5j0lY=;
        b=YNnKIlg4Lyi4gBSm3+JLjCc7y2jQhOIZaXC8hsBF9tpuQaKCFOwoupU4f6G6kDxL2d
         qzhVHKFO3Y5TlKQvWlN7gQdQ0/qRtk/mhvYNenspRvlQwzreaPvhwhDkFnI+dxDQCjfR
         YpXHxT7/BHBaEdGkgeMqD0NcOSkS5AnCpsHO1wACIgHN3M7kmA8CaLAP0nWDb5sslYuW
         5bOlYxABr/bwuwviOxz0cmCLaHAFw5aMom6K88YJ4AYEZsNO/VRHORSsTTJYj4U9hRcS
         +H+mBY5tOXhAxqZtPJ+TKlNl4VpRfV7JulzxjsxB3fABpsJrAQZO50T9CxoHaY/TlMya
         1nlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773997304; x=1774602104; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iN7GUmLbe7V61AT4RAuDgW79RdRXK0+E/XqCaySfEtE=;
        b=dMfIGqcIkuqAW8SGn/cvpyEvpnlUTCOOYi/VXAUUbhFABoiYk7cCzO8of2efZ3LL+0
         duf6aY07rytB5Z55Q/IX/Ate03KgHF451/p2rRPxecZXUzCptS6Ukc9CwWCxq3ZiTKTV
         FPGcvIHnGgSydcQK8JjntiIckuoXcDUMTr+VPjK/o3Hl8ERN7cgRJQ/FeVmdrUV4kxF9
         /oiLzD0QWlV0VI2PL+lPqyLW9ZRRHEJJrPE6xKLeynjq6qOHQHBe3WEEZ2r3Bz3hizif
         lKNzw3x5uT0mxKknrCVD5X6/4g+tNT3iGG1vRp+p31bmZt+ZbITevFCY15HTv46YAHfw
         jiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773997304; x=1774602104;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iN7GUmLbe7V61AT4RAuDgW79RdRXK0+E/XqCaySfEtE=;
        b=kT7kpyiORymOJe8Hbr3IzT49kB0t3w4ZW8cB6YkHy13FpE502Pf6sGecHEVa1NBBcs
         xQbB323RopS4mQDtXwlXHatMsamBJ10kXedl4kV8elYz8KDf5pmE2aSrF6Q4+oH0kB55
         HSG+EowgEl94GTNxSgWaEv6qEkani5o7BTK27vNLoeT5piYilQ6inSdrPFs2r5+Z+nNo
         Z9fsZ9IMEVbk0vorQbiRgvA+O6XXLmt9FF1qexIiMNWs0K96ltywcZT3slcROFY4INyY
         JRIsS0/HqBnymaYVErEZMfuzofUU9+yeaZ1X1G4+cgTv24g1NugCZB8+5xenEayjUOFG
         t5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUBqGSCWUCslVeveYx7HxDkKZu1sodczGPNYnIaVNn3pp930qqVyMZHRcI0qgt4NZwVOg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbR9wPF1tOhb7pDvEx13fnNZe5Yj+Xj5KVsURcGZSVt9AKZMzm
	gDUrp9eDv1KVfrjRTrwHnhBiCPhyeYryhengYK4QQpU4nwK1m4E6r6NGcrj8ggX1nvXySAGzw4C
	4WF2DzFetpmGGbTXgo4vAhGGGVhjbrHvxiQ==
X-Gm-Gg: ATEYQzyoPrdWdlu1/5b3pY81GjvVzM/0djW2q34HJY6U5SkuVYPkiOVQzmYE+APCKRe
	CXilvfAugw3AyJeFPtLoPPJh2qhK9ZE3F82WzHLkKPSlGhX4gXxQGe2XmCuiGrY463qsaHYakmY
	kGdaHEzwF7m/HFPWPKos8hEislxxNN44EL8lGqeOwfm4w1fzf3ys0nuaHNgfFQDY1/ggVMjlVL7
	yJQnZI2BROXBLmMDapCgD1yWgaQoqcYH3ULwOJK7bIRJOr7DZkrMP5d5MjjFbftOd7PulIPc3bn
	6rXYC4Li
X-Received: by 2002:a05:6102:508c:b0:602:9b21:eef3 with SMTP id
 ada2fe7eead31-602aed1bd51mr1262836137.27.1773997303647; Fri, 20 Mar 2026
 02:01:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 02:01:42 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 02:01:42 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-3-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im> <20260319-b4-pks-odb-source-abbrev-v1-3-5ddebad292b0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Mar 2026 02:01:42 -0700
X-Gm-Features: AaiRm516bq0V5DjGJUoMvZmwcWvsrEpH0QDWZQS49zjXbKq4g17tDDgrfHxI6-E
Message-ID: <CAOLa=ZRpCunxE_F1AG-aFqHiyVZ=c+T_wFwpfxC7vFm7dKxqAw@mail.gmail.com>
Subject: Re: [PATCH 03/14] odb: introduce `struct odb_for_each_object_options`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001dfc8e064d70ef1e"

--0000000000001dfc8e064d70ef1e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `odb_for_each_object()` function only accepts a bitset of flags. In
> a subsequent commit we'll want to change object iteration to also
> support iterating over only those objects that have a specific prefix.
> While we could of course add the prefix to the function signature, or
> alternative introduce a new function, both of these options don't really
> seem to be that sensible.
>
> Instead, introduce a new `struct odb_for_each_object_options` that can
> be passed to a new `odb_for_each_object_ext()` function. Splice through
> the options structure into the respective object database sources.
>

Yeah I like this pattern, really cleans up the arguments sent into a
function. Making future additions to the struct produce a localized diff
rather than modifying the function params each time. Nice.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c     |  7 +++++--
>  builtin/pack-objects.c | 12 +++++++-----
>  commit-graph.c         |  5 ++++-
>  object-file.c          |  6 +++---
>  object-file.h          |  2 +-
>  odb.c                  | 26 +++++++++++++++++++-------
>  odb.h                  | 16 ++++++++++++++++
>  odb/source-files.c     |  8 ++++----
>  odb/source.h           |  6 +++---
>  packfile.c             | 12 ++++++------
>  packfile.h             |  2 +-
>  11 files changed, 69 insertions(+), 33 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b6f12f41d6..cd13a3a89f 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -848,6 +848,9 @@ static void batch_each_object(struct batch_options *opt,
>  		.callback = callback,
>  		.payload = _payload,
>  	};
> +	struct odb_for_each_object_options opts = {
> +		.flags = flags,
> +	};
>  	struct bitmap_index *bitmap = NULL;
>  	struct odb_source *source;
>
> @@ -860,7 +863,7 @@ static void batch_each_object(struct batch_options *opt,
>  	odb_prepare_alternates(the_repository->objects);
>  	for (source = the_repository->objects->sources; source; source = source->next) {
>  		int ret = odb_source_loose_for_each_object(source, NULL, batch_one_object_oi,
> -							   &payload, flags);
> +							   &payload, &opts);
>  		if (ret)
>  			break;
>  	}
> @@ -884,7 +887,7 @@ static void batch_each_object(struct batch_options *opt,
>  		for (source = the_repository->objects->sources; source; source = source->next) {
>  			struct odb_source_files *files = odb_source_files_downcast(source);
>  			int ret = packfile_store_for_each_object(files->packed, &oi,
> -								 batch_one_object_oi, &payload, flags);
> +								 batch_one_object_oi, &payload, &opts);
>  			if (ret)
>  				break;
>  		}
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index cd013c0b68..3bb57ff183 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4344,6 +4344,12 @@ static void add_objects_in_unpacked_packs(void)
>  {
>  	struct odb_source *source;
>  	time_t mtime;
> +	struct odb_for_each_object_options opts = {
> +		.flags = ODB_FOR_EACH_OBJECT_PACK_ORDER |
> +			 ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
> +			 ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
> +			 ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS,
> +	};
>  	struct object_info oi = {
>  		.mtimep = &mtime,
>  	};
> @@ -4356,11 +4362,7 @@ static void add_objects_in_unpacked_packs(void)
>  			continue;
>
>  		if (packfile_store_for_each_object(files->packed, &oi,
> -						   add_object_in_unpacked_pack, NULL,
> -						   ODB_FOR_EACH_OBJECT_PACK_ORDER |
> -						   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
> -						   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
> -						   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
> +						   add_object_in_unpacked_pack, NULL, &opts))

Plus this is so much easier to read now.

[snip]

The rest looked good.

--0000000000001dfc8e064d70ef1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4cedc5b38f1297d2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tOURQUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXZ5Qy85Rk5wZURtYXZUdkg1eEVPY2VJaE54WWx4Swp1akptK3FzQlJ6
dktKdk9MMDFkVFBQRDVRb1Q1emNGejdZYitiUjN6enhGbHA5QkJ2QmY4L2NxTVRwQ2ErMkJXCnlJ
bzZEL3crdmtmYncxWGY1UUdRdGw5LzFGNFpBZkxhVHNGbHFNeVo5dGJkRHNXdjExUDlFS3hzYkxm
ZlhwSGYKZG1CSWx4R0dod0ExVFVmODlvc3Q4TkN0WUphczVPQzVFbzRIQ3NDbjdnRGd1MG1aY1BV
OUFSenJacG5pSlhRZApGL1FUMHI4V2hiclFPRW45Qy94TWQ4cFc2YnZxWi8wTml1ejVEYmNJL2ZS
K1YwNSswQkphaUJQckd1OE9wOWQ4CjREclduWWMzQWNzVkhXOEE3T0hxTGp5TTRveVAydmplZXFv
VVhzeS9VdE9FVHZ0KzJydWszRkNDVVRFVm1wUy8KYVBZc3N6Umg5aWxPblBSc2UrVEZ0dFJMYmhM
eDlmWmZDK0hrRnJ1OEVrRjI4a1ZMM3JzRlpRTS9MbDB5cmRNTApsUmFydzhuNmJ2L3BnUTc3TzBu
OWNQc29oVllWN2wxRkEvY3JnL095SllTaWgxNlQ5dXNHOUo5ZkQ3Y25XK2FmCjJqclk5Y0doYlo1
ckMydEc1UDdJK1lxZWZFckFmUHBQMVlpTmNvdz0KPXZqT3cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001dfc8e064d70ef1e--
