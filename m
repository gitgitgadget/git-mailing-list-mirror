Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795786905;
	b=c7Z49Vj2ALmgkJXcHtgUvKoZbR3UefARUPlz57UChVoXiP362HoQGSb8NnkSUQTTfOwd
	 USYCB8U2XQ9zuRbvavQ0id+wOA9HiP4s+2V0VEjCJLS4WIaIud2JPy7nD7gW8c6ZIgRAG
	 VfHGl11PcGNJI/Zm4nmOjcmajjKC7uGBfv7d8eu40fGiOhvhwAcTEHLA58zZSTmJBqNoT
	 KgUwVBwWSVdnYzeV+x4UO/QSEDh9oeskIk9rSchOCX9+bsRHefUndKaviRxsE7lawZXhQ
	 HkvgkVCwAITsz/PoRN8ojffa251OzVbwA6m/NW51y3gy/ePRLB7B9lIVFJDntQEU8QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tBba3w2lzP7+GonP2MeIBHWLzPuk233fqV1InBkq+nE=;
	b=HxiBfW4Zxo6l+g2xfM8YU7DSKlRqh386r+VAO0QH9SXCJCs2n/MQ+CXwNrNtnO0VSgfm
	 /wq9lkLOWPLhJTYyyeuXYybpFQQ4Xb2MYkPZYltTmydauDKDBcAbA+J3hCIIGF6C1shdU
	 UCsl3PeqlV3yX2grM3BSWa4asxwn5QYytBnvczJpN5aEjNvjJGl/I62wuUsY+KUpbKO2Y
	 a6jLUyywQIHfzNgsc/jSWk9nrHvVkYUKxvk5h6WaN340yg4hOhFlOf0yv+w9Ad4173aJr
	 cF5z8p4PhBbHs5ucRXWiVEp54kSWw4vwchPL55Y8UjTFOZ42ldQ0Q2yyeunLlsFFlvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jd0WYPGt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52868606A32F
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 13:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52868606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jd0WYPGt
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so3383783a12.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 05:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795786905; cv=none;
        d=google.com; s=arc-20260327;
        b=papSk5tZkkdzWmIrLp1Lnz/ksx7wAuRGjDWzQnYKmQwpjwa/vI1luyO0jC3HhvKyWb
         OE23/gB/j1r2ZmpTfj42JsajQEVbiGd4zS3SPfZVCCJjGM7At7iz5oylzh4p7ys9KtRV
         0csIqez7HRDHKW7riVr7kamYOji6hBrIu21ZQKVH2DgRv+/j3F1a1ksiFT0XD2fyvEkc
         mKnmMy7d7GhuLXJuMjwF0C8Kymi0nNHnhC3Bm3vtiCBzGuqUId8dMqgLOUd9ZnWYqpsB
         9c3XFvdhT5ftTRxDevIgaxDgj1tlwXBS+mdK1E53N3sNBVnI9gpssUUOg0iT3qrsrPOn
         ha9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tBba3w2lzP7+GonP2MeIBHWLzPuk233fqV1InBkq+nE=;
        fh=phSBB4Gfy8m+acE4awDfjgHwyCVFHuNo6MV9aQvmtHc=;
        b=TMqR53ZKn2dagLw6p//yW3wzH5LHZ2V27Hm3yJdzkoD4UzfdL4EBOvfkTxy95JJMrn
         jF38UMOUwMLWsMLMxk+7lk6RSK6zpFhb+kbUuZbOJIHyVSmsSUYSUSzkx5RiqI3JVUOc
         mz+TjGhp+dZkd10erTsh94dxFU7X0exIZD83j+fntcZ1v3wprUxJOJAvq1o0laUP1ShD
         fDb5VBN2l8PwCuk+SQCsiE0j6s4TVbJAOp2XQL9+hkG2mgMLMO4acOLgdK2q/RAOhKJg
         8xeP2zSHJRg+tQM+losxGCMwAlGngpR1mbJkJ2FyzsfhUQpglBBi+EczT7TPXfPmSTZo
         r9Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795786905; x=1796391705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tBba3w2lzP7+GonP2MeIBHWLzPuk233fqV1InBkq+nE=;
        b=jd0WYPGttYVgWfaVwdWXhRiYdjb8Jd0BzKFPcbq2r7zLp7yi6hM7ouCzA4iLank9K/
         wL+fnRCfxw9exKguj12p4NlmQWhXXJBcZvgXkqasA13qtQMVnbrajYQYcqw1xyeW5KrB
         YvKG6z3TUQFgVbvRGnTkzUwcqr6u44OcM4FTy5yRQr10bVEFT+BXnkIVG7IShUpxW7a9
         CaU+SuWcKeAc/5/PdlY4FAw/IzJ6CY+lkO50VAJgbXFAgdFL2yvc6rR7skcEVZ4+ROOb
         n/6GYE1qVaQ96l/ncTTD+kbHMDEvW0gGU3QosqPq3EJ4dQpb9mJvuIg+Ue6GuIsgbf+3
         sInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795786905; x=1796391705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tBba3w2lzP7+GonP2MeIBHWLzPuk233fqV1InBkq+nE=;
        b=Z06BoWb30hnIGifryKtsi+yIgGCdhMBJ8KT8DHAy2dxQ+mDKjRwamfRWwIox4l+Adj
         IVwV0JbYvTx9lTA1DjTUbyTPAyLjp0Pmfa8sIPhqcj/hL9Hl7CEj4f5DhGuqiDnWAOvc
         9MPThA3QlAe9XfjmnlzVHk0SAQnprvdIT1QOZsMrafAVUiAmI+ScRXin6/HbgL8kBTmT
         E16PS0W0GFlRO4wWIBIy3CsYQYHcIQJQmttiRBv+3gQhk7cYIvnjdYTUyD7uSrlauTe4
         F6owche2E8VzTMgaskMNY9CkX+ut/RLn6mV5W3bRdwkmAltEeCvtZhQtS3Wt7RfK32zR
         Ce1w==
X-Gm-Message-State: APuU4Z/wF/6dtY/LJOycXAnf7/7FJDVmkkUrY+GktBTGqAZ6RHXc+TOA
	2wfv/7cHEMPo3BAB4+yTKt/GH0ERIWYElzRgzs60clTJgT0v3TS1vnkNll3v6Kaxw5DsS3DLnJ5
	O5oeLL4MHRN7LAFEo7/yekviFB9hUi0c=
X-Gm-Gg: AZFdTZcGsgIqob1OOzUyL+qgwodQvCKQZOYcGEQs/AExw8khcsIZfuJpOD01yoFA1PR
	bAMPvyRu/rbhBFLsME+mDegaBLvSlFbEl7+vik1HhhBbe9wo6U3Ct9upn/qG7Walr83QLs0bLv9
	nLn/Ukj1uhR+gfQQjgEKmPsuvKxG5G4VK+cxQqe6lP/opJcrv4IhK7v0OQc8Vs8+0qhG3N23qYq
	qChcmmTtK4CbxUhgfFnN3B/geVOHgROKkJc1fdrrPX6iM8r6Xc/5JRkZsMGvy2k0GwKKuurvHKm
	Ohsko3++tdMykTQzysQoZ7G+WUXnKApBlYcHJPDLJkXKUz8ya0Z6N1Ea7hEtfe8rA+nR3Lim04I
	uUVC2iNc/YbdQ6/feCNroZPJp8OZEI7QIgH+t1yq5hMd9dDMVl18qP/4MUXX0NHLETm78+tY1be
	c9OTizWQ2T2GP+go3JPEhnW323ePweekQGwUftBpM12nsIiosBXOWy5XXnwFucaPbf7BiWx4+GE
	LyGr1jrIAUc8A==
X-Received: by 2002:a17:90b:5346:b0:3b0:9976:c1c6 with SMTP id
 98e67ed59e1d1-3b41c9bbe00mr22434318a91.66.1795786904503; Fri, 27 Nov 2026
 05:41:44 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
In-Reply-To: <pull.2509.git.git.1795774880142.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 27 Nov 2026 08:41:32 -0500
X-Gm-Features: Aa3M54rEmn1drxz0DlZ3XSw_pKj2pxdAXwXlv_ikj-IztQm3v4oCgNkDxtjWvc8
Message-ID: <CALnO6CCftBcJ_QwF5UEnjYqW=fLYYjQNccUEoGXKJEX9wCG54A@mail.gmail.com>
Subject: Re: [PATCH] status: warn about stale submodule URLs
To: Alessio Attilio via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Alessio Attilio <attilio.alessio@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alessio,

On Fri, Nov 27, 2026 at 5:28=E2=80=AFAM Alessio Attilio via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Alessio Attilio <attilio.alessio@protonmail.com>
>
> When a submodule URL changes in .gitmodules, the URL cached in
> .git/config can keep pointing at the old remote. That leaves users
> with no indication that later submodule operations may use a
> repository different from the one the project declares.
>
> Warn in git status so users can find and sync stale configuration
> before it causes a confusing fetch or update. Resolve relative URLs
> like git submodule sync does, and leave customized submodule remotes
> alone.

This sounds like a good problem to solve, as it makes it more obvious
when to run "git submodule sync"---especially if you don't trust one
of the 2 URLs involved anymore!

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> -static char *get_default_remote(void)
> -static char *resolve_relative_url(const char *rel_url, const char *up_pa=
th, int quiet)
> -static char *get_up_path(const char *path)

> diff --git a/submodule.c b/submodule.c
> +char *resolve_submodule_url(struct repository *repo, const char *url,
> +                           const char *up_path, int quiet)
> +char *get_submodule_up_path(const char *path)

I am somewhat surprised to see this refactoring: at a quick glance, it
looks like some static functions needed to be exposed to another
translation unit, but that was not explained in the proposed log
message. (We also teach the URL resolver about a repository, all at
the same time? And I can't see where get_default_remote ended up, but
that's probably my skimming.)

On top of that, our usual style is to first, in a preparatory patch,
move code around (making it easy to see the movement), then in
subsequent patches make the small needed changes for a fix or feature
(making it easy to see the isolated changes).

> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index e10c961268..bf28de1907 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -921,6 +921,61 @@ test_expect_success 'setup status submodule summary'=
 '
>         git add sm
>  '
>
> +test_expect_success 'status reports submodule URL mismatch' '
> +       test_when_finished "rm -rf url-test" &&
> +       test_when_finished "rm -f actual err" &&

Removing some of these files is a bit unusual, I think.

> +       test_create_repo url-test/source &&
> +       test_commit -C url-test/source initial &&
> +       test_create_repo url-test/super &&
> +       git -C url-test/super -c protocol.file.allow=3Dalways \
> +               submodule add "$PWD/url-test/source" module &&
> +       git -C url-test/super commit -m "add submodule" &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_must_be_empty err &&
> +       git -C url-test/super config -f .gitmodules submodule.module.url =
\
> +               "$PWD/url-test/updated-source" &&
> +       git -C url-test/super status --porcelain >actual 2>err &&
> +       test_must_be_empty err &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_grep "module.*different URL" err &&
> +       test_grep "git submodule sync" err &&
> +       git -C url-test/super submodule sync &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_must_be_empty err &&
> +       git -C url-test/super remote add origin ../source-parent &&
> +       git -C url-test/super config -f .gitmodules submodule.module.url =
\
> +               ../relative-source &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_grep "module.*different URL" err &&
> +       git -C url-test/super submodule sync &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_must_be_empty err &&
> +       git -C url-test/super config -f .gitmodules submodule.module.url =
\
> +               ../another-relative-source &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_grep "module.*different URL" err &&
> +       git -C url-test/super submodule sync &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_must_be_empty err &&
> +       git -C url-test/super/module config remote.origin.url \
> +               "$PWD/url-test/fork" &&
> +       git -C url-test/super config -f .gitmodules submodule.module.url =
\
> +               ../fork-source &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_must_be_empty err &&
> +       git -C url-test/super/module config --add remote.origin.url \
> +               "$PWD/url-test/another-fork" &&
> +       git -C url-test/super config -f .gitmodules submodule.module.url =
\
> +               ../another-fork-source &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_must_be_empty err &&
> +       git -C url-test/super/module config --unset-all remote.origin.url=
 &&
> +       git -C url-test/super config --add submodule.module.url \
> +               "$PWD/url-test/another-configured-source" &&
> +       git -C url-test/super status >actual 2>err &&
> +       test_grep "module.*different URL" err
> +'

I did not read the test script closely, but it seems we change some
submodule URLs and assert on status output, which is roughly what I'd
expect.

> diff --git a/wt-status.c b/wt-status.c
> index 238bb48643..e06c18d8e0 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -3,6 +3,7 @@
>
>  #include "git-compat-util.h"
>  #include "advice.h"
> +#include "config.h"
>  #include "wt-status.h"
>  #include "object.h"
>  #include "dir.h"
> @@ -23,6 +24,7 @@
>  #include "remote.h"
>  #include "refs.h"
>  #include "submodule.h"
> +#include "submodule-config.h"
>  #include "column.h"
>  #include "read-cache.h"
>  #include "setup.h"
> @@ -2692,8 +2694,103 @@ static void wt_porcelain_v2_print(struct wt_statu=
s *s)
>         }
>  }
>
> +static int submodule_has_custom_remote_url(struct repository *repo,
> +                                         const char *path,
> +                                         const char *url,
> +                                         const char *configured_url)
> +{
> +       struct repository subrepo =3D { 0 };
> +       const struct string_list *remote_urls =3D NULL;
> +       const char *remote;
> +       const char *remote_url;
> +       char *key, *up_path, *old_url, *new_url;
> +       int error_code, ret =3D 0;
> +
> +       if (!is_submodule_populated_gently(path, &error_code))
> +               return 0;
> +
> +       if (repo_submodule_init(&subrepo, repo, path,
> +                               null_oid(repo->hash_algo)) < 0) {
> +               repo_clear(&subrepo);
> +               return 0;
> +       }

I suppose in these cases we don't actually know the answer to the
question "submodule_has_custom_remote_url"=E2=80=A6 but I'm not sure if the
tri-state + behaving differently is worth it for a new warning yet, so
I'm ok with falling back to the current state of affairs for now.

> +       remote =3D repo_default_remote(&subrepo);
> +
> +       key =3D xstrfmt("remote.%s.url", remote);
> +       if (!repo_config_get_value_multi(&subrepo, key, &remote_urls) &&
> +           remote_urls->nr =3D=3D 1) {
> +               remote_url =3D remote_urls->items[0].string;
> +               up_path =3D get_submodule_up_path(path);
> +               old_url =3D resolve_submodule_url(repo, configured_url, u=
p_path, 1);
> +               new_url =3D resolve_submodule_url(repo, url, up_path, 1);
> +               ret =3D strcmp(remote_url, old_url) !=3D 0 &&
> +                       strcmp(remote_url, new_url) !=3D 0;

I'm not sure I follow this strcmp logic:

* remote_url is from the submodule's config, I assume from the .git/modules=
/=E2=80=A6?
* old_url is the resolved configured_url, which reading ahead tells me
is the superproject's config?
* new_url is the resolved url, which reading ahead tells me is also
from a pre-resolved submodule's config (aka "expected_url")?

So, I guess I'm actually confused about a few things:

* the terminology between caller (expected/configured) and callee
doesn't match; consistency might help
* the double-resolution of new_url seems odd?
* what are the 3 URLs involved? I suppose I was expecting a comparison
of 2, since that's what the log message describes (.gitmodules +
cached URL in .git/config).

> +               free(new_url);
> +               free(old_url);
> +               free(up_path);
> +       } else {
> +               /*
> +                * Multiple URLs are a local customization; sync would re=
place
> +                * them all with a single URL.
> +                */
> +               ret =3D remote_urls && remote_urls->nr > 1;
> +       }
> +       free(key);
> +       repo_clear(&subrepo);
> +
> +       return ret;
> +}
> +
> +static void wt_status_check_submodule_urls(struct wt_status *s)
> +{
> +       int i;
> +
> +       if (s->status_format !=3D STATUS_FORMAT_LONG &&
> +           s->status_format !=3D STATUS_FORMAT_NONE)
> +               return;
> +
> +       if (is_gitmodules_unmerged(s->repo->index))
> +               return;
> +
> +       for (i =3D 0; i < s->repo->index->cache_nr; i++) {
> +               struct cache_entry *ce =3D s->repo->index->cache[i];
> +               const struct submodule *sub;
> +               const char *configured_url;
> +               char *key, *expected_url;
> +
> +               if (ce_stage(ce) || !S_ISGITLINK(ce->ce_mode))
> +                       continue;
> +
> +               sub =3D submodule_from_path(s->repo, null_oid(s->repo->ha=
sh_algo),
> +                                         ce->name);
> +               if (!sub || !sub->url || !is_submodule_active(s->repo, ce=
->name))
> +                       continue;
> +
> +               key =3D xstrfmt("submodule.%s.url", sub->name);
> +               if (repo_config_get_value(s->repo, key, &configured_url))=
 {
> +                       free(key);
> +                       continue;
> +               }
> +               free(key);
> +
> +               expected_url =3D resolve_submodule_url(s->repo, sub->url,=
 NULL, 1);
> +               if (strcmp(configured_url, expected_url) &&
> +                   !submodule_has_custom_remote_url(s->repo, ce->name,
> +                                                    expected_url,
> +                                                    configured_url))
> +                       warning(_("submodule '%s' has a different URL in =
.git/config "
> +                                 "than in .gitmodules\n"
> +                                 "  run 'git submodule sync' to update i=
t"), ce->name);
> +
> +               free(expected_url);
> +       }
> +}
> +

Thanks
--=20
D. Ben Knoble
