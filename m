Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04601F403
	for <e@80x24.org>; Mon,  4 Jun 2018 21:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeFDVz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 17:55:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35253 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeFDVzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 17:55:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so1205997wme.0
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hbWiUkPYznZugYUfd7WhOutwSTFAYWgK3f2Ut/15+uo=;
        b=kwtqeQwdytUZBOUrdNR9d8b8vsJhlY3916gKV+YGFo+hF1GjCeQ9HSNma7eIsP21ye
         amYN8UVUlxPkB7Kujyja9ftyWHIa5XsAfSUXMbdicUQd1xly6tOFEGDTwN5wQxwSoQXN
         mccQHRApOlXG75OkSguhEqbqay4dA/iEJcWeaSsCz0/gC+LzqbPVBCp+IgY3p/8JP/ph
         nNxZJQgxyxLHDYBIQh1WPiieYn3auwormG/6k5i75wxefbz3347d74oHmuQlQAYrGHJm
         Th3sYhUSzffPZ+K8Vi5UwH8gRbiJPqn0xYWqB6pH6O+leDVwerNuiMqdtGEB6rwwnI+D
         O7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hbWiUkPYznZugYUfd7WhOutwSTFAYWgK3f2Ut/15+uo=;
        b=t7MafXoLrH53ih208Hs8hR2r0/f1p64bvhWpIAAKrYFX94CkxMW+3lxR+wD0mCd5Mr
         yJiQsuITf0n6qCcqPQzZxqotQJCOwzGBVKWadGGVT8kVou3x9zTo8bzE0xiv41yNPnJ7
         r4PxK3R2V9xL74Tv34HT4SgogDKuKHnDHBFRTMgb6jz2a6f6AhuzFGzyXkNDoYMd+0Ky
         RRknTGKxHiuYLHO/0IJowgDxp2RDzFY+Cz/lxsNSvhO33gTREA9ZlM0L7ls4z7xyhYMK
         Pq2Z0YHdN3gf8R4LgYCSACkxgT3Od1ZHToKL/aHbYG+GxBn/6s45mKVb5cyZd0UUW+t/
         Q+iw==
X-Gm-Message-State: ALKqPwfW/DI8mdpMfSRAjeMwaM1aaNHSLUW+c74lIg2aZrXQSnUl5HM0
        SqS+ZZPkiNCoxJqJi5xhjeQ=
X-Google-Smtp-Source: ADUXVKKqMcah/rd7HcoSSOIGjOzUA/FSJESQvT4PXwq9WIeWTRaccLRKFhrmhaKPSUaqNArzDb+FBw==
X-Received: by 2002:a50:f552:: with SMTP id w18-v6mr25868365edm.230.1528149324433;
        Mon, 04 Jun 2018 14:55:24 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id w22-v6sm8630911edw.42.2018.06.04.14.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Jun 2018 14:55:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] refspec: initalize `refspec_item` in `valid_fetch_refspec()`
References: <CAN0heSr6dPa+--Mut0+3Zgy-mWF0d2762vKU=d08CKhR8BnKmA@mail.gmail.com> <20180604144305.29909-1-martin.agren@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180604144305.29909-1-martin.agren@gmail.com>
Date:   Mon, 04 Jun 2018 23:55:22 +0200
Message-ID: <87tvqiz06t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 04 2018, Martin Ågren wrote:

> We allocate a `struct refspec_item` on the stack without initializing
> it. In particular, its `dst` and `src` members will contain some random
> data from the stack. When we later call `refspec_item_clear()`, it will
> call `free()` on those pointers. So if the call to `parse_refspec()` did
> not assign to them, we will be freeing some random "pointers". This is
> undefined behavior.
>
> To the best of my understanding, this cannot currently be triggered by
> user-provided data. And for what it's worth, the test-suite does not
> trigger this with SANITIZE=address. It can be provoked by calling
> `valid_fetch_refspec(":*")`.
>
> Zero the struct, as is done in other users of `struct refspec_item`.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> I found some time to look into this. It does not seem to be a
> user-visible bug, so not particularly critical.
>
>  refspec.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/refspec.c b/refspec.c
> index ada7854f7a..7dd7e361e5 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -189,7 +189,10 @@ void refspec_clear(struct refspec *rs)
>  int valid_fetch_refspec(const char *fetch_refspec_str)
>  {
>  	struct refspec_item refspec;
> -	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
> +	int ret;
> +
> +	memset(&refspec, 0, sizeof(refspec));
> +	ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
>  	refspec_item_clear(&refspec);
>  	return ret;
>  }

I think this makes more sense instead of this fix:

diff --git a/builtin/clone.c b/builtin/clone.c
index 99e73dae85..74a804f2e8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1077,7 +1077,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();

-	refspec_item_init(&refspec, value.buf, REFSPEC_FETCH);
+	refspec_item_init_or_die(&refspec, value.buf, REFSPEC_FETCH);

 	strbuf_reset(&value);

diff --git a/builtin/pull.c b/builtin/pull.c
index 1f2ecf3a88..bb64631d98 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -684,7 +684,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
 	const char *spec_src;
 	const char *merge_branch;

-	refspec_item_init(&spec, refspec, REFSPEC_FETCH);
+	refspec_item_init_or_die(&spec, refspec, REFSPEC_FETCH);
 	spec_src = spec.src;
 	if (!*spec_src || !strcmp(spec_src, "HEAD"))
 		spec_src = "HEAD";
diff --git a/refspec.c b/refspec.c
index 78edc48ae8..8806df0fd2 100644
--- a/refspec.c
+++ b/refspec.c
@@ -124,11 +124,16 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 	return 1;
 }

-void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
+int refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
 {
 	memset(item, 0, sizeof(*item));
+	int ret = parse_refspec(item, refspec, fetch);
+	return ret;
+}

-	if (!parse_refspec(item, refspec, fetch))
+void refspec_item_init_or_die(struct refspec_item *item, const char *refspec, int fetch)
+{
+	if (!refspec_item_init(item, refspec, fetch))
 		die("Invalid refspec '%s'", refspec);
 }

@@ -152,7 +157,7 @@ void refspec_append(struct refspec *rs, const char *refspec)
 {
 	struct refspec_item item;

-	refspec_item_init(&item, refspec, rs->fetch);
+	refspec_item_init_or_die(&item, refspec, rs->fetch);

 	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
 	rs->items[rs->nr++] = item;
@@ -191,7 +196,7 @@ void refspec_clear(struct refspec *rs)
 int valid_fetch_refspec(const char *fetch_refspec_str)
 {
 	struct refspec_item refspec;
-	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
+	int ret = refspec_item_init(&refspec, fetch_refspec_str, REFSPEC_FETCH);
 	refspec_item_clear(&refspec);
 	return ret;
 }
diff --git a/refspec.h b/refspec.h
index 3a9363887c..ed5d997f7f 100644
--- a/refspec.h
+++ b/refspec.h
@@ -32,7 +32,8 @@ struct refspec {
 	int fetch;
 };

-void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch);
+int refspec_item_init(struct refspec_item *item, const char *refspec, int fetch);
+void refspec_item_init_or_die(struct refspec_item *item, const char *refspec, int fetch);
 void refspec_item_clear(struct refspec_item *item);
 void refspec_init(struct refspec *rs, int fetch);
 void refspec_append(struct refspec *rs, const char *refspec);

I.e. let's fix the bug, but with this admittedly more verbose fix we're
left with exactly two memset() in refspec.c, one for each type of struct
that's initialized by the API.

The reason this is difficult now is because the current API conflates
the init function with an init_or_die, which is what most callers want,
so let's just split those concerns up. Then we're left with one init
function that does the memset.
