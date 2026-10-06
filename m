Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B73BCD36
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791319897; cv=pass; b=SunCA3/f7CABpiLwVr+zeT2UewiDjpEgbAzleEseqjizwvqb5XLLlbwWLaw8IO7q4KH5NgBtsyAaj0hY+ZwUFDCfs0HS32ipnuJgOrstBeiV9IkH4glfOJQMV561hmKOdWfOu2Jh4eGh/hX6GmaYa+ZD3oRTTuYqVcb8szijiXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791319897; c=relaxed/simple;
	bh=QY4lmgf+VMydzp69N8EDWTeU2RiCho62rcenWQGhvL4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=OSbuNfxBjhHzr3qrKYbu2OYdrPvhlZ3HzU8goHao/3pV+JF6IUlOX+4Vu5GUQH1QcvzL1IqjWdbMP+SPkt94IhNGZSfgwQxBGSR0WY9FeSHISsI4fZwXskjjYa9+kOkxzzHYWP568r+rKCTfk0f90UHCAUmm7Jbz9xb4yVv1trQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Urg1i+TP; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urg1i+TP"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-98076bb236eso547653241.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 13:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791319894; cv=none;
        d=google.com; s=arc-20260327;
        b=f1uW+aUeHGqtddFWZRd+rZ/vbRe2Teywr08A0huyIHWgHoD9Db0IRJEGlSo+NK6QD9
         lqMKJjzzBvXqvUcrj+0E0hMiTUQtkXkoGrjEiHIQQokXFmDfj4xGRghW0EHOU+SdGR82
         RWmHQc86GFfTGt0RQUK8ESJ8BzN1ma/pg1/KC47Rm30OsO7tVKr4rs06rAXROCnS5cwR
         XwPDrxCqekGWkl2AqwPMJIEMvqrGQp6BhbxLcVdeLHZENDPQoGiB5TD2Cgj2yw8bI+s1
         hFuKig0sQIhRkM0ot4nhwSVKBvftjZVZ5z74Te14P656FC4K7sR0PoIwNaXr0oquux6V
         BCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=KyI3F4lRad/Ve0gni+AYEI8BYlvGlHI1+WJG3PIutJQ=;
        fh=H0t2Pz7rnEaT3qx0A/hy0IpuEX4zlT9umB8rjil+oJs=;
        b=Qdv6/pOwWX8zFpmEjpy2zodgUncvnrJ9oRaS3o/5so5QT82qp6GcuuP6vdX9bmCIF6
         zwH/ZOFjspdTKzdhSf92lc1BwkjTVQ47yLo8NBPJa5yFO69J7YbrXNXef1Vog3joUIRf
         FlsFX7jP3AzfwUwA74BIuSFPmiNxbmeM4e+4eW9qpcUg9iB4VYAkT9eAmFKm0kIlYh3U
         /CNWf41Ub8Gok1ppD4s5hGz3f3hKPKBpJTRlddpLYN39WYQ5S/zrjqTg473hT5aScqPL
         Ox1UZA+B3Yu2q4Enyg0cu/h3J5WN4jgY6fg/LRrx6Q2LpUp5GJ1utGGmjRhIz1kBrRK9
         EEQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791319894; x=1791924694; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KyI3F4lRad/Ve0gni+AYEI8BYlvGlHI1+WJG3PIutJQ=;
        b=Urg1i+TPlwETUrIkm6K7dWUrL9ktp2ebTY3yCrRgdcn35S71WRxAF6z6w09glqk7jy
         02DZnUYeHIeptP8Lt7lHpJkNjIJrCV6NvETfbKgK6LLKqFh35nDjG/PFAygeBZu2ukC5
         HhwEn+Kva1ksVVyTGbs1j4KUvL2y81/6wEp2X3G/eJjVNIp7KwfO8FwYRZBnuSj14LOv
         zOEIPX/a8wu7NWgAU83d7S5bexkXv5Lcf0BOyCVKMV2iiMMwneVU7/uKu8rzNLooeprO
         zYm+ZN6SkOon3BqDYp99LKpb2oWAdjMMuqKrm+fvEqSor001YESA3vMqS+mg7xpao6qH
         BfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791319894; x=1791924694;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KyI3F4lRad/Ve0gni+AYEI8BYlvGlHI1+WJG3PIutJQ=;
        b=JmxWLma5dU/y1wfyoXA1V2hS2HvCbpYUJDXUdFwU7NGD1JPl9sByH00NgIzdrmFi2N
         572be33Y2dXpV0J3sWltqYO2lsfiWtmo8trQ0yBVE0gMr6J6UT5AQqYUnbaRD4RSwHmj
         2CI1my4GlsV1wnBX6YAALrTQq9g/yGICkXHGD8jb2t9fti4+8JE/PNBI7oj5Wex6CEtP
         2mVQXT0vO7KIomYiJdqGUb6PprUVvWfWjCFm2mh0RaPwND9ioRLnArltJbc+FuY+XaD+
         M8qN36IUBfMhgczQcuvqYArkCSgJMEdyWx79/TWjQi/ySYtZxo6LIdxNNqpMCSJHDb42
         u1Dw==
X-Forwarded-Encrypted: i=1; AKwUvBzdKH6cu6DfvTIA9JjNag6flMQgrCb3xrKUj0xuvSBWbqkL45VyXQv9t0jssgEPoz4J9o4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLedKGWHSAxxE7MUoyxMn5XMtb95jtVc8hxQRIP0OZJ7ykOBbjy
	DJEhQdW3lE2ZLvuWn3ahmaHX9SFSl6rha8yTg6ZDZVCbTMzlHH/VQKM08SbpTYYDhRejNzVZqAN
	pz0y/ZWCQePLJkPooBZxDZxzNeE8uSfY=
X-Gm-Gg: AYBFou39+ayaFiTBlf7o5dMwHqD9vlel//DSfBa/GSu7NV7OF8/BJG9oyR6q2XkUPSn
	pfEEkMz1KXmIWjrs545Chzv6YTvgltrgq9cccU30PdsqdyU+a/3QWgZxb1CxqZkngm12uqCR+Af
	VT2dpDL74ylVI/Axsip5jJ7Wivmcjq+R44ussiCSFwRS4zIBtQ1GqXPmZQA4j1Sas51UTkP8Zxn
	UsAob3XWkWJlmmDvtoU6CCLtFAM/4yz0do+ZR3vObxzEHVAFrzkxbkicudAvSP/XTrA3K2PHf0J
	4rgDE6YhGwijYXgkDt7XgcU0TV/wQDq2ko0TPwoJm9UUN0RGkYdw8SDn2o2/YtK5DL21nSl4CKH
	hHHGQAJUy1OO+xhhIBFk5KIzT8V8AZaikpb/VGr7c5GMSSg==
X-Received: by 2002:a05:6102:6886:b0:7b5:4f3e:708c with SMTP id
 ada2fe7eead31-7c87a50ff78mr871866137.18.1791319894135; Tue, 06 Oct 2026
 13:51:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 13:51:33 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 13:51:33 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-12-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im> <20261002-pks-odb-move-alternates-v1-12-8a63507b88c4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 13:51:33 -0700
X-Gm-Features: AclHuK82yaBtrCwuR4QNu7YQLgLubnmAoLFzM9wtes52Gs-MF1bkmBRFqjXsUzQ
Message-ID: <CAOLa=ZT8wHAkCHiRqG1Op3YuBR6M6X+f0Wtu2Q+TR2GTcC8q0g@mail.gmail.com>
Subject: Re: [PATCH 12/13] odb/source-files: move alternates into the backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f85160065d3229ec"

--000000000000f85160065d3229ec
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Originally, when designing pluggable object databases the goal was that
> the object database can have multiple sources, and every source attached
> to it could use a different backend. This would have allowed for quite a
> lot of flexibility, as you could trivially mix and match different kinds
> of object storages in whatever way you like.
>
> But while well-intentioned, this design led to a bunch of conceptual
> problems:
>
>   - We're now trying to read objects in source order, whereas we
>     previously tried to read objects via packfiles before trying to read
>     them via loose objects. This led to a performance regression when
>     using alternates or when using a quarantine directory.
>

Could the design be instead to use a mapping function which allows us to
map objects to sources, based on some characteristics of the object?

>   - Some data structures are supposed to only ever exist once, like for
>     example bitmaps and commit graphs. At the same time, those data
>     structures also span across the union of all objects, so they may
>     cross sources.
>

This is not really a problem for having multiple sources though.

>   - It is unclear how we can extend GIT_OBJECT_DIRECTORY or
>     GIT_ALTERNATE_OBJECT_DIRECTORIES to become backend-agnostic in a
>     backwards-compatible way. In general, introducing an object storage
>     extension into the current status quo where alternates may have to
>     be extended to become generic was proving to be painful.
>
>   - Some mechanisms of alternates assume way too much about how exactly
>     their backends work. Alternate refs for example assume that the
>     alternate is backed by a filesystem path, and that this filesystem
>     path may also allow us to read references. This is not a given
>     though, as backends may not even have local data at all.
>

These two points do make sense around moving alternates into the files
source.

> In short, there are a bunch of conceptual mismatches when we have
> alternates and pluggable object databases coexist. So while the original
> idea was nice, it does not result in a system that is easy to reason
> about.
>
> Correct course by moving alternates into the "files" source itself so
> that it becomes an implementation detail thereof so that we can avoid
> all of these shortcomings. While it's unfortunate that we cannot easily
> mix and match sources now, that ability doesn't go away. It's still very
> much feasible to introduce a new backend that allows for exactly that
> use case, and such a backend may also be a lot more flexible as we can
> now add new logic to determine which objects should be stored where. So
> the original motivation for having per-source backends can still be
> realized with the new architecture.
>

Okay, this makes sense, so the new source could be merged source of some
sorts, with internal logic which it uses to map to different sources.
Nice.

> Note that as part of this move, we also handle the GIT_OBJECT_DIRECTORY
> and GIT_ALTERNATE_OBJECT_DIRECTORIES environment variables in the
> "files" backend. This may be surprising at first, but object directories
> are very much a concept of that backend, too. So these variables would
> have bad interactions with other backends, and they create a bit of a
> mismatch with the eventual object storage extension that we plan to
> introduce.
>

Yeah, this makes sense. The term 'DIRECTORY' itself is not always
extensible to other sources.

[snip]


> diff --git a/midx.c b/midx.c
> index c0f82c4163..8638ddf0be 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -829,21 +829,15 @@ void clear_incremental_midx_files_ext(struct odb_source_packed *source, const ch
>
>  void clear_midx_file(struct repository *r)
>  {
> -	struct odb_source_files *files;
> +	struct odb_source_files *files = odb_source_files_downcast(r->objects->source);

We remove the the previous `if(r->objects)` check here, is that okay?

>  	struct strbuf midx = STRBUF_INIT;
>
> -	if (r->objects) {
> -		struct odb_source *source;
> -
> -		for (source = r->objects->sources; source; source = source->next) {
> -			files = odb_source_files_downcast(source);
> -			if (files->dirs->packed->midx)
> -				close_midx(files->dirs->packed->midx);
> -			files->dirs->packed->midx = NULL;
> -		}
> +	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> +		if (dir->packed->midx)
> +			close_midx(dir->packed->midx);
> +		dir->packed->midx = NULL;
>  	}
>
> -	files = odb_source_files_downcast(r->objects->sources);
>  	get_midx_filename(files->dirs->packed, &midx);
>
>  	if (remove_path(midx.buf))

[snip]

This is the only question I have in this big patch, I did a full read
and tried to compare the moves visually and they looked okay to me.

--000000000000f85160065d3229ec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d3516d8eb1a2c335_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRlgxTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmhMREFDa0RreFpyWHZVekRDS205eElCM294cm1WNwo1ZTUwMnRrYlJB
M29pUU1rRWlFdndrQkk4dmJadm10WElhMUFlNi9qNEZ2VkczK0dvZWlJa2tuQXF4cVRzc0hGCmRC
OWRRN2hFKzZLSEhZSTVoRmxPM3MvbW9zNjhrM3dLYkVmeDh3MkN1Rm8vakF2VlZMU0VJa1N6SE4r
ZXJKdHoKaGExN0R3bzFRN3Y1Y0VVQ2RwdUIvTG9NeE83WnBKckxTRkxsRW50RjhTd2dkYzJBRFFj
dE1YYVFvdk9SOUsxMQpJVU1TbHRjLzhPTUdZQUJvaURHQThoa0lyODFGUk9LNktNN3M1TjBjL1Rj
MnVyeTUrQUZtNVB6VEVkOEgzSi84CnVKRmtUNE16NEdKaUVzeHdJOXJRbXlpWXpWUTB1YW16WDJH
UVk3UnNMeXhBZENzM3dsRUU2UXJMZDA1UkhYRmoKOHBMRHpuZFpjL3RNcGZ1WHAyMEk1U1lvUmpn
a2d3UDBLUWNGbGMwaFR6YzRtTWcvVXlBRmlvdVZJVUNMSGFyeQo3RHQ2UUd4ckJ6SVVXMmp6a3RY
RVE4M3dhNmRWRndGNjdDWWorSlF4Nmh2Z0JVbmhoTUUrcVpWUE9NMUkxSVZiClgxMHVpSTB6Q1VK
WElsbyt3RVR5eG9OcGhQZGFtNUFQUUVFQm1Saz0KPXkrTHYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f85160065d3229ec--
