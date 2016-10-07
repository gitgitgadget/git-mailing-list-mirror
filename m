Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0553E20986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbcJGSHQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:07:16 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34323 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753530AbcJGSHO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:07:14 -0400
Received: by mail-qk0-f171.google.com with SMTP id f128so30200268qkb.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oCY2TMl/LnwE725B0vtWk4odXbi97PF6yTKQGmBHS14=;
        b=d3XdQB7X0pjbViJ/lee/DehAw+mp1o87QYnqB8JQXobigKo9QKDlFQfdukAI9iP4S2
         tpam5l+ukugHscKKlV1VgC/YRgFkKpmaPPPzIvgIsznrRs7pP+/LKRynCj+PfaciCOEj
         vr6uysisrwIeQzCgXdFsoiJC0JbDOkoKtRmFPd97BVGiFXRmdFp/iJ6z/V5ajMTunSnZ
         fYwJhUwWiRy4Jb4EyIzDYuCLH3ABMJV8IBMIHv6+SdODvvC8oL720N5qC2472glI+Tne
         lYh/qTcpbE9Knp8gDZTzIG/ZcqsbL1rtHgeFI6ISZCV73TPVCg0vZ/3RgaPlMr7IZbQs
         snUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oCY2TMl/LnwE725B0vtWk4odXbi97PF6yTKQGmBHS14=;
        b=hdVEv/ZY0oKdr/ZurQhx392sHkMwBVz8Gr9L1uUwMyMIIjtziyAk4KcCIzMyzvpzbx
         Q/zmMcdy6mrmFcAqgtirKsIT0XGHd5O2f2AASe9Gdx3NCCDSvWnLI6aBDHX2jo7zjeo4
         ZiXsgEFtBnrqC9iRZ6FZW3mLlswVCECZMphMrhc6eJBGo7aIVRgssmN6hGY1RPCbR0gF
         QJkk+W0sJGi3Vhxo5JY1yYV6DnYSw7QecGb0+JV5YJE07IsaRV1An47F+2v2XN6UjsXv
         7elOadswFwzWfyQ3n/ZdC29y/Pt5gdW9jjbPLezDI/zd3TpgzHElyEYdLf4IBKxwoQke
         TQbw==
X-Gm-Message-State: AA6/9RnNUChFCa4y8XA+A31eoAFV/eKpjZtRL3msGilZKudpXaVQ7SbutHKTEdDLAgxe492r5cy7huzoggoCa7gL
X-Received: by 10.55.45.193 with SMTP id t184mr17757813qkh.58.1475863169759;
 Fri, 07 Oct 2016 10:59:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 7 Oct 2016 10:59:29 -0700 (PDT)
In-Reply-To: <10cd5be93601bc52388100e80b6c6735a7cacfb4.1475851621.git.hvoigt@hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net> <10cd5be93601bc52388100e80b6c6735a7cacfb4.1475851621.git.hvoigt@hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Oct 2016 10:59:29 -0700
Message-ID: <CAGZ79kZiY56-84aThH1F02E_HzCTAK3KSYLbyP1D5GUAt892cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] serialize collection of changed submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 8:06 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> To check whether a submodule needs to be pushed we need to collect all
> changed submodules. Lets collect them first and then execute the
> possibly expensive test whether certain revisions are already pushed
> only once per submodule.
>
> There is further potential for optimization since we can assemble one
> command and only issued that instead of one call for each remote ref in
> the submodule.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  submodule.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 5 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 2de06a3351..59c9d15905 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -554,19 +554,34 @@ static int submodule_needs_pushing(const char *path, const unsigned char sha1[20
>         return 0;
>  }
>
> +static struct sha1_array *get_sha1s_from_list(struct string_list *submodules,
> +               const char *path)

So this will take the stringlist `submodules` and insert the path into it,
if it wasn't already in there. In case it is newly inserted, add a sha1_array
as util, so each inserted path has it's own empty array.

So it is both init of the data structures as well as retrieving them. I was
initially confused by the name as I assumed it would give you sha1s out
of a string list (e.g. transform strings to internal sha1 things).
Maybe it's just
me having a hard time to understand that, but I feel like the name could be
improved.

    lookup_sha1_list_by_path,
    insert_path_and_return_sha1_list ?

> +{
> +       struct string_list_item *item;
> +
> +       item = string_list_insert(submodules, path);
> +       if (item->util)
> +               return (struct sha1_array *) item->util;
> +
> +       /* NEEDSWORK: should we have sha1_array_init()? */
> +       item->util = xcalloc(1, sizeof(struct sha1_array));
> +       return (struct sha1_array *) item->util;
> +}
> +
>  static void collect_submodules_from_diff(struct diff_queue_struct *q,
>                                          struct diff_options *options,
>                                          void *data)
>  {
>         int i;
> -       struct string_list *needs_pushing = data;
> +       struct string_list *submodules = data;
>
>         for (i = 0; i < q->nr; i++) {
>                 struct diff_filepair *p = q->queue[i];
> +               struct sha1_array *hashes;
>                 if (!S_ISGITLINK(p->two->mode))
>                         continue;
> -               if (submodule_needs_pushing(p->two->path, p->two->oid.hash))
> -                       string_list_insert(needs_pushing, p->two->path);
> +               hashes = get_sha1s_from_list(submodules, p->two->path);
> +               sha1_array_append(hashes, p->two->oid.hash);
>         }
>  }
>
> @@ -582,14 +597,41 @@ static void find_unpushed_submodule_commits(struct commit *commit,
>         diff_tree_combined_merge(commit, 1, &rev);
>  }
>
> +struct collect_submodule_from_sha1s_data {
> +       char *submodule_path;
> +       struct string_list *needs_pushing;
> +};
> +
> +static void collect_submodules_from_sha1s(const unsigned char sha1[20],
> +               void *data)
> +{
> +       struct collect_submodule_from_sha1s_data *me =
> +               (struct collect_submodule_from_sha1s_data *) data;
> +
> +       if (submodule_needs_pushing(me->submodule_path, sha1))
> +               string_list_insert(me->needs_pushing, me->submodule_path);
> +}
> +
> +static void free_submodules_sha1s(struct string_list *submodules)
> +{
> +       int i;
> +       for (i = 0; i < submodules->nr; i++) {
> +               struct string_list_item *item = &submodules->items[i];

You do not seem to make use of `i` explicitely, so
for_each_string_list_item might be more readable here?


> +               struct sha1_array *hashes = (struct sha1_array *) item->util;
> +               sha1_array_clear(hashes);
> +       }
> +       string_list_clear(submodules, 1);
> +}
> +
>  int find_unpushed_submodules(unsigned char new_sha1[20],
>                 const char *remotes_name, struct string_list *needs_pushing)
>  {
>         struct rev_info rev;
>         struct commit *commit;
>         const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
> -       int argc = ARRAY_SIZE(argv) - 1;
> +       int argc = ARRAY_SIZE(argv) - 1, i;
>         char *sha1_copy;
> +       struct string_list submodules = STRING_LIST_INIT_DUP;
>
>         struct strbuf remotes_arg = STRBUF_INIT;
>
> @@ -603,12 +645,23 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
>                 die("revision walk setup failed");
>
>         while ((commit = get_revision(&rev)) != NULL)
> -               find_unpushed_submodule_commits(commit, needs_pushing);
> +               find_unpushed_submodule_commits(commit, &submodules);
>
>         reset_revision_walk();
>         free(sha1_copy);
>         strbuf_release(&remotes_arg);
>
> +       for (i = 0; i < submodules.nr; i++) {
> +               struct string_list_item *item = &submodules.items[i];

You do not seem to make use of `i` explicitely, so
for_each_string_list_item might be more readable here?


> +               struct collect_submodule_from_sha1s_data data;
> +               data.submodule_path = item->string;
> +               data.needs_pushing = needs_pushing;
> +               sha1_array_for_each_unique((struct sha1_array *) item->util,
> +                               collect_submodules_from_sha1s,
> +                               &data);
> +       }
> +       free_submodules_sha1s(&submodules);
> +
>         return needs_pushing->nr;
>  }
>
> --
> 2.10.1.637.g09b28c5
>
