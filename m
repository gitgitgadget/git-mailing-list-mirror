Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461DC2116E0
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722388; cv=none; b=kr+bihaF/FIm1OpmxhEo+W4gvmHDiq/6a0PSe+6plz0W/SeG8gjYF+/aKJYG5YeN7Hf1fz/+jOCphvrEBPOmgv1kTmhqSg8amsj/K7eJy9P71blDtLxuwLMRy+zihBJJ6PYrW2Z48cXZI8qJua2/E0cRhUhVo+zdRzudjnP35gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722388; c=relaxed/simple;
	bh=Dgng/Cg5YYgN2LC8V68CCJwA2wiESG+3oW8uFHfN1vA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=twGU2swY2Ygkh2jxPVq0EbcmFtrVF5jrKiuAesg6CbD0tI30er1Wio18JNcdlwVGJsgHQixTxelbjztkvUzEMFjcHY6Zr6NP7hZtQy6OsBHUARPRaPddYDLP1RXX7WlS+QAzaAYFIERE08LO1aBQ9Ks1cpVr+C/K21nvkRzFbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZYFEgm5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZYFEgm5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d71bcab69so2423007b3.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755722386; x=1756327186; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MESt08ep9qouuxI7anqRNDcJrGxn1DUCcgNX4gNAZc=;
        b=SZYFEgm5Rqdd1Sl3axULkAf+nGA/A2/wwjN6N8ejdr4b8E1t9pcyGXiBRa615p1CBp
         TVeL3u4HD9lOFyX2sDj5QEEPAJPAhbhTQLjN+9h1YewfuLI1PJY9uo6CYIoMHkv4Mee8
         /ZyS6iURzEurF0R6mqhu4XMaqVqTpdD5LjscTuhxRJvd8S8fh/10RgfDWEVBwwa0nYCE
         kuyA85woak8Rd7n2AKQwLY/GaCmIfD4sqsp9ZdEeP0+Lcn8W9cO8TXk/N0GjVOI67VLB
         QjBWxkzl+TSyALcXpVbf/y9HB0JcmEgGvoD7pSIVJWzwCBlKlVMRG4MDnCM/jk04QhpR
         rhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755722386; x=1756327186;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MESt08ep9qouuxI7anqRNDcJrGxn1DUCcgNX4gNAZc=;
        b=xQweSrqi9yDL7Ce5ot6UhNCWSto28m+gKrKnb3dG5JsFOwBaCPSZJWXwZFz4UtH5+8
         k9UN05VLVz8heYsjsdtA2liGvGF2khUeL0RcBM9pJ0ef0qz6+xXpHFF/K2R/w2dxXaxL
         +c7o0wbmYHXggVwbhfBJDGDAe/QxQzrFKjZJlTiPY31Bgn5Sh15rabfVcwVke4yv+5Lb
         DxTxnLtMLYie9s6fqBRQdf8RTUA8vrq26Q+63Cjg4EW1Yj2tIXumiGTY/qOjWI3pE3tk
         +2O0SwUwkgjuqYj8B0kbNOP2U/VB4E4jpODjfffw4B1xEJyddr9zt7kByNKc6iEC0txt
         qnNQ==
X-Gm-Message-State: AOJu0YyK+RWylXxEBcbhh73htxEjhs++p8hSwsoNVK27Vh//Ghz8nNdY
	2YfJ9yxm+lt1JDzWpbvyyFzlvIr5u11CleyR6I+7PUe4n8eB3V0A/Ys3on4Tv1K7
X-Gm-Gg: ASbGncslW4VlndsOrcx76NmOL9OMpAFkVAaulwGkmfBEDh8dufFlUi6SemTExkTRC46
	LtxXVp2CPQL3QpyNMGK+9/rCMo2UIFLhdmeSz/lELdpHxVYlyNXNECvLPYJlLjKANAzhAWnRNUr
	FODCS3+7YJpMXHQj4vNZFIkwEqVujEHD+1uvA4p0/3PkVxFnHE/6kyp6XG/z1lp7RdGpW+ZovmC
	EeWQXWiNb9h8QQnJj17FBdPEoQr9tk7aeSRxMjadcHf4m/DHA/xFGlCHIwGoelV/eFgQA3zptuU
	/o6L6KTn/F98lmKhDqpJzKmZenC5Rv9o02+d7TPT+5spH8LNOOH1gnUN6hutrTQe3YVqlm/TFQd
	SxQauT3M00rAyCjQwNBqbLKSakHxsMdgI+FBEW0ogM7VzQacraqcaqROsB5krkg==
X-Google-Smtp-Source: AGHT+IFkJK1M/B1PsShx2MembTAfLU+jlcu4brBC78hWa+q1oGqPMNCs92DiLsNDQu6Su+lPsGGkuw==
X-Received: by 2002:a05:690c:e18:b0:71e:719c:491c with SMTP id 00721157ae682-71fc8930f1dmr2897407b3.18.1755722385897;
        Wed, 20 Aug 2025 13:39:45 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:98b8:ef87:b2ce:efc8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0be8b0sm38791777b3.66.2025.08.20.13.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 13:39:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 05/11] builtin/history: implement "drop" subcommand
Date: Wed, 20 Aug 2025 16:39:34 -0400
Message-Id: <F0D09FB0-5978-4BFA-87D1-BE5FA49EA839@gmail.com>
References: <20250819-b4-pks-history-builtin-v1-5-9b77c32688fe@pks.im>
Cc: git@vger.kernel.org
In-Reply-To: <20250819-b4-pks-history-builtin-v1-5-9b77c32688fe@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 19 ao=C3=BBt 2025 =C3=A0 06:57, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
>=20
> =EF=BB=BFIt is a fairly common operation to perform an interactive rebase s=
o that
> one of the commits can be dropped from history.


> diff --git a/builtin/history.c b/builtin/history.c
> index d1a40368e0..183ab9d5f7 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -1,20 +1,311 @@
> #include "builtin.h"
> +#include "commit.h"
> +#include "commit-reach.h"
> +#include "config.h"
> +#include "environment.h"
> #include "gettext.h"
> +#include "hex.h"
> +#include "object-name.h"
> #include "parse-options.h"
> +#include "refs.h"
> +#include "reset.h"
> +#include "revision.h"
> +#include "sequencer.h"
> +
> +static int collect_commits(struct repository *repo,
> +               struct commit *old_commit,
> +               struct commit *new_commit,
> +               struct strvec *out)
> +{
> +    struct setup_revision_opt revision_opts =3D {
> +        .assume_dashdash =3D 1,
> +    };
> +    struct strvec revisions =3D STRVEC_INIT;
> +    struct commit_list *from_list =3D NULL;
> +    struct commit *child;
> +    struct rev_info rev =3D { 0 };
> +    int ret;
> +
> +    /*
> +     * Check that the old actually is an ancestor of HEAD. If not

The =E2=80=9Cold commit=E2=80=9D perhaps?

> +     * the whole request becomes nonsensical.
> +    */
> +    if (old_commit) {
> +        commit_list_insert(old_commit, &from_list);
> +        if (!repo_is_descendant_of(repo, new_commit, from_list)) {
> +            ret =3D error(_("commit must be reachable from current HEAD c=
ommit"));
> +            goto out;
> +        }
> +    }
> +
> +    repo_init_revisions(repo, &rev, NULL);
> +    strvec_push(&revisions, "");
> +    strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
> +    if (old_commit)
> +        strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oi=
d));
> +    if (setup_revisions(revisions.nr, revisions.v, &rev, &revision_opts) !=
=3D 1 ||
> +        prepare_revision_walk(&rev)) {
> +        ret =3D error(_("revision walk setup failed"));
> +        goto out;
> +    }
> +
> +    while ((child =3D get_revision(&rev))) {
> +        if (old_commit && !child->parents)
> +            BUG("revision walk did not find child commit");
> +        if (child->parents && child->parents->next) {
> +            ret =3D error(_("cannot rearrange commit history with merges"=
));
> +            goto out;
> +        }
> +
> +        strvec_push(out, oid_to_hex(&child->object.oid));
> +
> +        if (child->parents && old_commit &&
> +            commit_list_contains(old_commit, child->parents))
> +            break;
> +    }
> +
> +    /*
> +     * Revisions are in newest-order-first. We have to reverse the
> +     * array though so that we pick the oldest commits first. Note
> +     * that we keep the first string untouched, as it is the
> +     * equivalent of `argv[0]` to `setup_revisions()`.
> +     */
> +    for (size_t i =3D 0, j =3D out->nr - 1; i < j; i++, j--)
> +        SWAP(out->v[i], out->v[j]);
> +

But doesn=E2=80=99t this swap out->v[0] on first iteration? I only skimmed t=
he code that built it up, but it doesn=E2=80=99t look the comment is right =F0=
=9F=A4=94

Rest looked reasonable, but I don=E2=80=99t know the sequencer APIs very wel=
l.=20=
