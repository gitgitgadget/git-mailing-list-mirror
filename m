Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426166;
	b=d4YH0u71btKR4deceIAF01EZ6WAumW43xffihtFMs0IYmHcOrUbo5oyUnIqrXJVF28BY
	 3sath3BMTA+4HR6s2wasWFIA3Uo0OAaS6E0k8YiuWF6TaE+q7xzmMojlMZsoXILqqxX8I
	 SRCngw0txrqBbWdQdX319aHAHaYHyf+Pj3CmuKPMbnhuvuGowcLZsGKomCBbnUfn3ZdgH
	 ExizVSATFYH5WTQ65IIZDDX2sSG29FdK0oeYQfJZeReuMk3cI7esvs7Natw1OEvIc9WMU
	 zo/Un9Yk6ygozMNqlACupx1BihAsIdxPbnJn+0jjSC0r3oY3MZWTZTAn+yo9ETPenng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Nm4XABYLulNlC5AwA+PFCg1YKWO9qkrB9rqPSZKsCJs=;
	b=DpnOFs2NH8uhEG/cGnIT4prIfmuvAe8MeNV6Xye6vBjMpRnh51TNyA1ig7ChTOP9+TfI
	 cjqZC/jGfTRzfwgFFsdrdFP3OLHmC9zu3l2f7iTWQP+PjmK4nUIrawuTZLyxk3ccB7kzQ
	 FPwIJK4Ul+6BZ4u6+26o97YjlvOT8LBuC6PdOfvYVHzjRM/hkxKq6cnHcKQRMmsLtXZon
	 DNJ9VXFk2eZbZ7dBw/lTbwxfSdqvizrXJfEV8MU3OwEatpYl/V4el1mWyAJ1lm7rvZS6m
	 RULHpy9Ro9MdRDe85LQ6i9zjutA+dFCBLwnv0YiNCs7f9jQFGX9R2UQITVe3EsXzpIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="J/QMTdBb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFA606A321
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 09:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56FFA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J/QMTdBb
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67990a45e02so3037115d50.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 01:29:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795426165; cv=none;
        d=google.com; s=arc-20260327;
        b=m9TOnxh6EJ8uu787q3eXtl2vvejK602rJbHb+NG/n9P60yV1WYNRWqhCgUeIvP6ACX
         xlIDcQCrVzQqw1gRFkTkUQzrc9XLN7gMq1yEUEjt2RW6e36ad3J4K+xo3f+b4KKHadTL
         HFupi/ZALOXq2Up8RBkVqvSOGlPRo+gAfgM3dGVpEX9VtPbh/NQ5OFqESF9FtS2aAb/M
         R8T+LYCmDZ6snMFZcyP6gU77cfbbXZ7lg8LodLMmxoP/BIeScIbqVAdBr0oJHaK/fNax
         K+DXxn+no/OyVDfS80YzfP7tfSJr2E0ZVgoLm9k5fStSGv07rK6fWSyn3skVSWrhkB10
         i1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nm4XABYLulNlC5AwA+PFCg1YKWO9qkrB9rqPSZKsCJs=;
        fh=ogsZZuExLVI2Ooex3T0rvBc1lRpjfmqmxisbuLh4iTI=;
        b=ZYA0TWwHY25lUlwd7p+X/Qloc08MYQfdn1J4uysy07QCGSrnq5Myt7T2TJDpeoOl2Z
         yrq/s7pVmdui8mNhoy/dkkNAaQMUa+wLfb3uZ3fV1pV0h9eVaaLOIMBO5hhpz/uPbS88
         wscyeJivXiTxUeg6vwLi7tOsEEIqqzpruuV85D1C0gT5TeVd53jq6KxxG+QPz9n3W/3d
         RDKGYcWtGwFfjHQaaRCi/cO2N2fkq2ku05rqFsKJMokxs1kyBmnngm4Tn1cZEcAYuRhs
         f0LDTLZH3liC5n+FKqC7OEj/5xo0nNJKHF0EBLNbxw7XSjzKvjmGZrkK322DchrSr1yN
         +2sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426165; x=1796030965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nm4XABYLulNlC5AwA+PFCg1YKWO9qkrB9rqPSZKsCJs=;
        b=J/QMTdBbakum5Vpodi2kZbohznbQa2Y14DD8OaMsaiIRklm68RyQlTIHZXypiSNcEc
         6+hlG+/4kQTHpC18SnaZ9GHvfMd2aBFn1romFo/rGm2XdQjcTwnsV3vl/Toy4ieVU0VL
         9k8aRkr9yK/5Rb5Y6ppGUWEOportnuO47KsscjfmB6USmpAS8Qh+NfDaNAAyZ5VsxoJk
         plnPd8G6VBK94ox2w7JOvd+/Qfd3Y00M3qz+qpbXwhqAMkHCdEXG44F8j2r3RJ7asVbI
         06s3Ih/YvlXtRoUjvZALTFVKnBTrY/QgK1aRuXi8Z2j6YJMIFIEEMecOwGwsP1COoWBZ
         eCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426165; x=1796030965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nm4XABYLulNlC5AwA+PFCg1YKWO9qkrB9rqPSZKsCJs=;
        b=XgfeUdvKz2tslcjw4JGYPoFZZnfRoYVsEvnwBmsL2mEGzfu/svAQd9g5Rsif6wy+Ox
         x6wRLHijZTWOu5sGmQHl3Plt8MW6K/vaCSbPUVrfLZ3e+dKpdZ2DNZtV/c5OFx6xCaeR
         qKKY21m+YrAu/lNxPW0bPNUyzonP05nlUmFBjeoQWTtboPkXFcSFl4JHPQ7CU51g1Rzw
         Wy/kCzyG/wdU4BplefdJSbTzLxF5SgTvjFfbEFBAXFtvDr+pRGGilIOo7ff0f+UrQuTr
         9yHL2Fvtgfozrs1Sn51mvcT0fqSbxW6RT7EfHp/ZbpSF8wpSsbZ2RUVQ6xd8OF1nUYy4
         7nmw==
X-Gm-Message-State: APuU4Z9a5QkQZaPhtQOwivFGj0zHWd2FItB6hN/HACd2T/Hy6l9yZyqr
	NQy/yl45WMiLNSOwx/km75Kvnrxc7i0uGD+lBqiN/+DiXNH9Gl78HKuRn+OpRjrqy10nEiQ0aoX
	2MVHa94HzWQMSDztuSRJBOa1pQZmG92LUA1Sb/o8=
X-Gm-Gg: AZFdTZdbA9Z2r1UAQKhNg523IyygTdMWd+DCZxQH8Ef0Y6tK/eHaEYW/39MeUGr1Ml9
	kBW3OS59BNbdhq1CIVXOL1SzTveX8U9IWkSUONXfBobVBhp2IN4lQmtJm4d2QczEUrlz0TCl+6B
	I7S7KtDZcRlVqQ01ut94e/porcxfPyon56WEuyiZ2gPNe2fxUSVqyuPyTfU6SGt2GZ3RQd3DvWF
	RwhfHWxzzvS4muXxgVw073j4amVTefZmK82fFgyWtkbSaM/pLTTh7ns45mslvYxkf8cvO06q8Ml
	cGRThAb1qCKL+U7CFdMXf1WMEKfPRVgpBBNdYw6IK0l/+IQDK2FgDIsjVS2A+o6Z4j9cIWihWEv
	rhirxdqUH8H470ikY7hP46Pq5DpdJCXuxW/Ij7kiGPaaNOH1nwKwvS0qq9cntSNBOogmid0Y15d
	WlGOlSZYUeWh/zkvqUaYMykZlqGWMfTyDYDlXAtDMuzjiLEdrL1Etj04lVxW1ETm6aLhulxVmhR
	q1aG6GrXVIooL9pieEUKzQaduCbkVw/RtDL+Gjo
X-Received: by 2002:a05:690e:1c07:b0:67d:bd3b:3b63 with SMTP id
 956f58d0204a3-67df43f5d4dmr4387651d50.30.1795426165353; Mon, 23 Nov 2026
 01:29:25 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027153429.14131-1-okhuomonajayi54@gmail.com> <20261103155038.87456-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261103155038.87456-1-okhuomonajayi54@gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 23 Nov 2026 10:29:13 +0100
X-Gm-Features: Aa3M54p9Rgv79WYJHqTI5TCmUf-qFMkCaRiLZZNOLAyVL589OxnV4YbfBgkt8XM
Message-ID: <CAFpMFfDAc--MEvtgoJgcjmZMvDfGXZm5hn2iXXxopaPuXJZk=Q@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] negotiator/default: stop using the_repository
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

Gentle ping on this v2. It's in 'seen' marked "Needs review". Is there
anything you'd like me to change?

Thanks,
Okhuomon


On Tue, Nov 3, 2026 at 4:50=E2=80=AFPM Okhuomon Ajayi <okhuomonajayi54@gmai=
l.com> wrote:
>
> The default negotiator uses the_repository to parse commits,
> clear marks, and walk refs. fetch_negotiator_init() already
> has the repository but does not pass it down.
>
> Give default_negotiator_init() a repository parameter, store
> it on the negotiation state, and use it for those calls.
> clear_marks() receives the repository through its callback
> data. Drop USE_THE_REPOSITORY_VARIABLE.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
> Changes since v1:
> - Put the repository first in default_negotiator_init(), as
>   Christian suggested.
> - Pass ns to mark_common() in have_sent().
>
> Thanks, Christian, for the review.
>
>  fetch-negotiator.c   |  2 +-
>  negotiator/default.c | 28 ++++++++++++++++------------
>  negotiator/default.h |  4 +++-
>  3 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/fetch-negotiator.c b/fetch-negotiator.c
> index be383367f5..a5183bb3bc 100644
> --- a/fetch-negotiator.c
> +++ b/fetch-negotiator.c
> @@ -19,7 +19,7 @@ void fetch_negotiator_init(struct repository *r,
>                 return;
>
>         case FETCH_NEGOTIATION_CONSECUTIVE:
> -               default_negotiator_init(negotiator);
> +               default_negotiator_init(r, negotiator);
>                 return;
>         }
>  }
> diff --git a/negotiator/default.c b/negotiator/default.c
> index 19cdf3808c..f7cb52f10c 100644
> --- a/negotiator/default.c
> +++ b/negotiator/default.c
> @@ -1,5 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "default.h"
>  #include "../commit.h"
> @@ -18,6 +16,7 @@
>  static int marked;
>
>  struct negotiation_state {
> +       struct repository *repo;
>         struct prio_queue rev_list;
>         int non_common_revs;
>  };
> @@ -28,7 +27,7 @@ static void rev_list_push(struct negotiation_state *ns,
>         if (!(commit->object.flags & mark)) {
>                 commit->object.flags |=3D mark;
>
> -               if (repo_parse_commit(the_repository, commit))
> +               if (repo_parse_commit(ns->repo, commit))
>                         return;
>
>                 prio_queue_put(&ns->rev_list, commit);
> @@ -38,9 +37,10 @@ static void rev_list_push(struct negotiation_state *ns=
,
>         }
>  }
>
> -static int clear_marks(const struct reference *ref, void *cb_data UNUSED=
)
> +static int clear_marks(const struct reference *ref, void *cb_data)
>  {
> -       struct object *o =3D deref_tag(the_repository, parse_object(the_r=
epository, ref->oid),
> +       struct repository *r =3D cb_data;
> +       struct object *o =3D deref_tag(r, parse_object(r, ref->oid),
>                                      ref->name, 0);
>
>         if (o && o->type =3D=3D OBJ_COMMIT)
> @@ -78,7 +78,7 @@ static void mark_common(struct negotiation_state *ns, s=
truct commit *commit,
>                         struct commit_list *parents;
>
>                         if (!o->parsed && !dont_parse)
> -                               if (repo_parse_commit(the_repository, com=
mit))
> +                               if (repo_parse_commit(ns->repo, commit))
>                                         continue;
>
>                         for (parents =3D commit->parents;
> @@ -119,7 +119,7 @@ static const struct object_id *get_rev(struct negotia=
tion_state *ns)
>                 commit =3D prio_queue_get(&ns->rev_list);
>                 if (!commit)
>                         return NULL;
> -               repo_parse_commit(the_repository, commit);
> +               repo_parse_commit(ns->repo, commit);
>                 parents =3D commit->parents;
>
>                 commit->object.flags |=3D POPPED;
> @@ -179,9 +179,11 @@ static int ack(struct fetch_negotiator *n, struct co=
mmit *c)
>
>  static void have_sent(struct fetch_negotiator *n, struct commit *c)
>  {
> -       if (repo_parse_commit(the_repository, c))
> +       struct negotiation_state *ns =3D n->data;
> +
> +       if (repo_parse_commit(ns->repo, c))
>                 return;
> -       mark_common(n->data, c, 0, 0);
> +       mark_common(ns, c, 0, 0);
>  }
>
>  static void release(struct fetch_negotiator *n)
> @@ -190,7 +192,8 @@ static void release(struct fetch_negotiator *n)
>         FREE_AND_NULL(n->data);
>  }
>
> -void default_negotiator_init(struct fetch_negotiator *negotiator)
> +void default_negotiator_init(struct repository *r,
> +                            struct fetch_negotiator *negotiator)
>  {
>         struct negotiation_state *ns;
>         negotiator->known_common =3D known_common;
> @@ -200,10 +203,11 @@ void default_negotiator_init(struct fetch_negotiato=
r *negotiator)
>         negotiator->have_sent =3D have_sent;
>         negotiator->release =3D release;
>         negotiator->data =3D CALLOC_ARRAY(ns, 1);
> +       ns->repo =3D r;
>         ns->rev_list.compare =3D compare_commits_by_commit_date;
>
>         if (marked)
> -               refs_for_each_ref(get_main_ref_store(the_repository),
> -                                 clear_marks, NULL);
> +               refs_for_each_ref(get_main_ref_store(r),
> +                                 clear_marks, r);
>         marked =3D 1;
>  }
> diff --git a/negotiator/default.h b/negotiator/default.h
> index d23a8f2fb8..98bc989cff 100644
> --- a/negotiator/default.h
> +++ b/negotiator/default.h
> @@ -2,7 +2,9 @@
>  #define NEGOTIATOR_DEFAULT_H
>
>  struct fetch_negotiator;
> +struct repository;
>
> -void default_negotiator_init(struct fetch_negotiator *negotiator);
> +void default_negotiator_init(struct repository *r,
> +                            struct fetch_negotiator *negotiator);
>
>  #endif
>
> base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
> --
> 2.56.0
>
