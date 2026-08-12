Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B9335081
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555311; cv=pass; b=VwSRdYZcUVAe0Lv7MhwTVUhy1AUx8c/fo+njFO4UqWKiVgAD0SOLDQwl7lghzMqjrpyTyy1Lo4JfLnY7AoPtRyKW6RnxZeGn2x7QsSFBxKBePkA0QSof2o/I+A/ogF3kLxdj8roTa3rJe2ayiuQqavw99ReaouyRD4mvuLD8LCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555311; c=relaxed/simple;
	bh=paPy3eX173nhzyFMtOS+ru3avHUT/baQRJI0UZYBNWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJJ0pY/v9k+tfnJAMt58Nu/lRPFd7T7cL/kh2v2YbC76zGcOTjVzgNqg1jWOuJ/QUfaXZBjAyU3tPLceEKrFow5IkUxzP6cUX5c8eIk6fYnwtxlH5m0lTNxhz9VyRyDoS+8FOwzX7+lcko7vRFqOauE12BzonPzt0OXoxfXyXww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbXjeGMd; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbXjeGMd"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso80180a12.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786555309; cv=none;
        d=google.com; s=arc-20260327;
        b=TPtywer/QzyIYTwhmqoQo5JL55GposSzyjWM21/OdG0B1jeKIm1NsFjUYtGuTwLrj2
         MBVW9DRJycfuPTLid8+c4Qf77NohqVXYUD84oR4q+8ANVEzSBbVwW0f90RpzARJhgLFB
         1t7q3KoCOp6lwTZZMF5IoEeQXUgzofTi0UfAo2/RzIC4jrjQL9UMuYYpwOug30TQVc5m
         Z8CRPpzc9W2UpypE9W3Hga9v06Hi2BeQB41rRr72iaZlUuyJqKuFY0z5hyoHPb5uBdm5
         kB+Lb2bgk8LfKZrdBAf9Xw2btPjVMX5jrTsDoLBYEpQZj7PAviaJs9adX79EOQ+ZfiRQ
         nVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37NKsZQ1WQPPPMuZYa2TgAM+LJBvpbLpV80qSgkPX50=;
        fh=pN7wu1zwD+xcQsXWuh1aXLiVhMCtwuxgzoUDjuwgVME=;
        b=KInSRJ5O+9P7s1PnA6HQ+SuQE4CYONTFYVT8P4c0hjDbENNSGC19gKs3skC4dS5amd
         TZ07HIAT/4KmX0y1bPOkmBHDVgNyLMTOx2qOkg9W3Dm/UXy3jVqJvBNVTqtheUxv4Yut
         ++5Eq4AYIUSDUGZKoEo/V0RVbkvQXKTFUIlgVYJqcvwICtbBxJVisJiQBsyDuLK0LAYh
         auZb1T6dSBMFBA5G5kT1jHqjFnfNZeJbkk1bVjjUMMOLULQ6jnyfU3R3Tlx+em0TpMoR
         tCQUI2FoCKVLjTD0Plas5t6YYXT5H+5xUk6nGS1r6QGJxkFPnt88pww5EVTVN0znfaf+
         sYtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786555309; x=1787160109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=37NKsZQ1WQPPPMuZYa2TgAM+LJBvpbLpV80qSgkPX50=;
        b=NbXjeGMdJj/NjpJLj3W3jH/VGGhoYobGhJJ2BwerJ6/qz3CENIO5GhrcgZ+NAOFvPY
         gf4g8Q0OyUxrgbkA20XemnoQAIXYx19nsiMn9n+tq3LCB5ctSjx9ykyzUCU3yy6GOWBz
         VneRe6jnBCsYD/SnBP1HeoDNVLTXSWMyCTrfatrTS2fEBTGnzVGyZSDZD9AyFXGRehWr
         sXtqd/SVHOBt2wj3O/f4bKmiznVgF3E3mk9NGIej5XT91KIN++CcxyaxaYGQyehzDzul
         oGDIQAf49qBUj9lYdi6mTFvpFCFruY8LMuGtSpHLksb9es2ompefztekgHGVWGruxomO
         n+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786555309; x=1787160109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37NKsZQ1WQPPPMuZYa2TgAM+LJBvpbLpV80qSgkPX50=;
        b=Qse4a9wh9c8p4CDnIhkQ/jUOY4apxMVBDluGLM9gAEFXwzzYAu1TPTv9cTUZBwOW4v
         vGTYPOLLBU6lmn7PdA+H5fq0H06nuOh/ERQHb6M6ZdCoIfnhi87fNJz0LK1k2CGPwmkG
         5GZpeKIFA4Erl4tsRAX92EunPkyU46r60h8WE6VCcEm9LqKRksGEJdMeJz+He3Z+vUpp
         V9I7WwDhO+ZsRk5QlajioyYoDmr8HAiFOrwRFeUIt3wyD5QM8iMgRWIUgqF4vlG7tzNK
         KxzuxmryN4MrgGubsLv1XqqQMP7w/mDepHV5icuxGv362AdKJ+DvvbUpRJXJNVSOjgxZ
         dXZg==
X-Gm-Message-State: AOJu0YxFObJmzlPvnQLdbX0k1G2PBt6PjZJECV0rkxwJ1e2kEGFjShOl
	YXrRKW38Q/8QglMSDevX/3RtXV3Crr4gHpen2XdZxObGetr1QiTn+hAjm9xWsrDBTlWoEYmcvkM
	3zJp/5Rjc68+sFM7npeFlrpPahF272UdyyKHD
X-Gm-Gg: AR+sD11+K0ALcqbeEBpFxDMklXkme/kmcJ1LEo+liuiZ05JrBt+6iJ5cXuwkfbG5xkU
	iomDRHoJpN1OhyWlDz00/7GiqHngsgA2VeBc0t95sArV6eZJa6wN7N9MuycKmdWw97YIqZIHAbU
	SQ6MNZ+5KstSaManCXbyFZOvo36i8iCVFMVvmf3ZAd1w+QyPc/ZE9H28Z/8GbAIsR9vE7vCyQpQ
	WO2yopcutme4/mc9dMbZj6ABGxI+nSynpgA5MxeTqk7TSflgYgqLI4YVPsuHCuJIwmbLWP+xRdA
	nSs0+wrWwbs7Lf+EwhBVWMNonzu95KzxFMdTeDHVjTq5AbbPdA2dhIxsJHDab7jtOHf5A+xR7HO
	3w9e8aMXpEDmm+8QroTqzriYN4VcFjkw=
X-Received: by 2002:a05:6a20:9f46:b0:3c3:750f:3cf9 with SMTP id
 adf61e73a8af0-3cc53125f55mr1007248637.11.1786555308858; Wed, 12 Aug 2026
 10:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com> <20260810174047.6524-5-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20260810174047.6524-5-r.siddharth.shrimali@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Aug 2026 19:21:35 +0200
X-Gm-Features: AUfX_myMQnAoncmeJ7xQdpIHgvoLZWh5-IvfEXn4eiG4E95uKo3ll6Uzugg5un4
Message-ID: <CAP8UFD3fF+Ka0Sqs3BSstur_HdqU3s==3ash91Ewwi_F-t2oDA@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 4/7] builtin/repack: enumerate promisor blobs for --drop-filtered
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, siddharthasthana31@gmail.com, 
	ttaylorr@openai.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:41=E2=80=AFPM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:

> +int enumerate_promisor_blobs(struct repository *repo,
> +                            const struct list_objects_filter_options *fi=
lter,
> +                            struct oidset *to_drop)
> +{
> +       struct oidset all_promisor_blobs =3D OIDSET_INIT;
> +       struct collect_cb_data cb =3D {
> +               .repo =3D repo,
> +               .set =3D &all_promisor_blobs
> +       };
> +       int ret =3D 0;
> +
> +       /*
> +        * The caller (cmd_repack) is responsible for validating that a
> +        * blob:limit filter and a promisor remote are present before
> +        * calling this function.
> +        *
> +        * Walk only promisor objects. every object visited here is a
> +        * promisor object, so it is recoverable from the promisor remote
> +        * as long as the remote still has it, the same assumption the re=
st
> +        * of partial clone relies on
> +

The sentence that ends with "of partial clone relies on" should be
finished with a full stop. And the next line should have a "*" as it
is part of a code comment.

> +        * We do not use write_filtered_pack() here because git repack
> +        * routes promisor objects through repack_promisor_objects()
> +        * before the filter machinery runs, so the filtered pack never
> +        * contains promisor blobs. Direct enumeration via
> +        * ODB_FOR_EACH_OBJECT_PROMISOR_ONLY is the correct approach.
> +        */
> +       ret =3D odb_for_each_object(repo->objects, NULL,
> +                       collect_promisor_blob, &cb,
> +                       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
> +       if (ret)
> +               goto cleanup;
> +
> +       /*
> +        * Apply the filter to find which blobs exceed the threshold.
> +        */
> +       ret =3D list_objects_filter__filter_oidset(repo,
> +               (struct list_objects_filter_options *)filter,
> +               &all_promisor_blobs,
> +               to_drop);
> +
> +cleanup:
> +       oidset_clear(&all_promisor_blobs);
> +       return ret;
> +}

[...]

> diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filter=
ed.sh
> index f27b09a30e..453053cc18 100755
> --- a/t/t7706-repack-drop-filtered.sh
> +++ b/t/t7706-repack-drop-filtered.sh
> @@ -1,9 +1,36 @@
>  #!/bin/sh
>
> -test_description=3D'git repack --drop-filtered option validation'
> +test_description=3D'git repack --drop-filtered enumerates filtered promi=
sor blobs'
>
>  . ./test-lib.sh
>
> +delete_object () {
> +       local repo=3D"$1" &&
> +       local obj=3D"$2" &&
> +       local path=3D"$repo/.git/objects/$(test_oid_to_path "$obj")" &&
> +       rm "$path"
> +}
> +
> +# pack the objects into a promisor pack inside "repo". it is a pack
> +# accompanied by an empty ".promisor" marker file. objects
> +# in such a pack are treated as recoverable from the promisor remote.

Here and in other places in this and other patches, code comments
would read better if they were proper sentences starting with an
uppercase letter (and ending with a full stop). Like:

# Pack the objects into a promisor pack inside "repo". It is a pack
# accompanied by an empty ".promisor" marker file. Objects
# in such a pack are treated as recoverable from the promisor remote.

> +pack_as_from_promisor () {
> +       HASH=3D$(git -C repo pack-objects .git/objects/pack/pack) &&
> +       >repo/.git/objects/pack/pack-$HASH.promisor &&
> +       echo $HASH
> +}
