Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAB01F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeAZTiy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:38:54 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38690 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeAZTix (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 14:38:53 -0500
Received: by mail-yw0-f195.google.com with SMTP id m84so583956ywd.5
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 11:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PpDcIZa+g1q8uY4+qC7ki3bs7uZ+FmkTn6Mv/bv+bp8=;
        b=ADkZxine39/W8H/bxA0U9JYFJ3OYVfCVRKPM6NndGTHLR43XLHH0gpeHvlOSOEVon7
         stVcEZecQ8YuQJ+9HautuXZZESAUC1QPLWRAMhlwD8bXmo6nQsHVmaSrvDf5u0pWvW13
         MdYVt9fS0thf4Pe7msa0rG9ua4qGvF9NIoOkyts9bb1CFnSCh/5eks+F49iDCqzc90/J
         duXAOEcCaLJpjfVTwHxxIoXV4voHd0wIcZ7+I/bHXcA8ek70Wt04UvJUxmMni7tcoy4V
         KmLtlWXD/eVJIvzV64IC7IIRQkXjM9ucPDsn/YsDzUu3X6gciddtFhlVmZ8Cl1a+amaz
         /U0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PpDcIZa+g1q8uY4+qC7ki3bs7uZ+FmkTn6Mv/bv+bp8=;
        b=FTvm2wjoHd/ebmRMudGZcJ3gmXyI/lR+O+srkaWSiOlapW8Q8td95XR0whe4jultbD
         f1Ix3Tr2FyhqMsaH9M8rfrcLNhlHbNLXxf5LteHIeJwg0S5vm3btzRZgYyWxVGWlYOXf
         w3Tc7pjO5f1IL/ZgyaDZkhejJECUtOKXkCrPxzc/D+neyjdoQQdNNYDuRB3UVQyGnmYz
         CGaOZmISdn11440IvoXXg8xFqCCj6g+Eqgmw1+bQUx/m7PGd2SrmJqa+UVMUCcnCtExL
         u9N6+Lkm83CHXATrSEGZVHIY/chU9vDEOp+VP3ep6E2OXbgePjsleEYQXKtKy1nfVVMU
         9saA==
X-Gm-Message-State: AKwxytcSmHAf40W2olmnMhW16VP/FEx9aieOI7Gk7s9pPwU5M70di671
        0eQ9qCcnTN2bcYFHiMnCuGX00ito+52xgNDiwocjsw==
X-Google-Smtp-Source: AH8x227qO8cqWLeVKPfQBKxwKU9B1DcdDYyYnTz9N1EnidYZjSrvu21Tl/DoYNbCNwpK5jzigOyU76GfJN4Wlz9ykc0=
X-Received: by 10.129.108.149 with SMTP id h143mr12002962ywc.373.1516995531977;
 Fri, 26 Jan 2018 11:38:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 26 Jan 2018 11:38:51 -0800 (PST)
In-Reply-To: <20180125140231.65604-12-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-12-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Jan 2018 11:38:51 -0800
Message-ID: <CAGZ79kbR_GUGRhXBU187LchHKqxFd42Rc=w+jOEfrigmEAgNaw@mail.gmail.com>
Subject: Re: [PATCH 11/14] commit: integrate packed graph with commit parsing
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 6:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
> Teach Git to inspect a packed graph to supply the contents of a
> struct commit when calling parse_commit_gently(). This implementation
> satisfies all post-conditions on the struct commit, including loading
> parents, the root tree, and the commit date. The only loosely-expected
> condition is that the commit buffer is loaded into the cache. This
> was checked in log-tree.c:show_log(), but the "return;" on failure
> produced unexpected results (i.e. the message line was never terminated).
> The new behavior of loading the buffer when needed prevents the
> unexpected behavior.
>
> If core.graph is false, then do not load the graph and behave as usual.
>
> In test script t5319-graph.sh, add output-matching conditions on read-
> only graph operations.
>
> By loading commits from the graph instead of parsing commit buffers, we
> save a lot of time on long commits walks. Here are some performance
> results for a copy of the Linux repository where 'master' has 704,766
> reachable commits and is behind 'origin/master' by 19,610 commits.
>
> | Command                          | Before | After  | Rel % |
> |----------------------------------|--------|--------|-------|
> | log --oneline --topo-order -1000 |  5.9s  |  0.7s  | -88%  |
> | branch -vv                       |  0.42s |  0.27s | -35%  |
> | rev-list --all                   |  6.4s  |  1.0s  | -84%  |
> | rev-list --all --objects         | 32.6s  | 27.6s  | -15%  |

This sounds impressive!

> @@ -383,19 +384,27 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
>
>         if (!item)
>                 return -1;
> +
> +       // If we already parsed, but got it from the graph, then keep going!

comment style.

>         if (item->object.parsed)
>                 return 0;
> +
> +       if (check_packed && parse_packed_commit(item))
> +               return 0;
> +
>         buffer = read_sha1_file(item->object.oid.hash, &type, &size);
>         if (!buffer)
>                 return quiet_on_missing ? -1 :
>                         error("Could not read %s",
> -                            oid_to_hex(&item->object.oid));
> +                       oid_to_hex(&item->object.oid));
>         if (type != OBJ_COMMIT) {
>                 free(buffer);
>                 return error("Object %s not a commit",
> -                            oid_to_hex(&item->object.oid));
> +                       oid_to_hex(&item->object.oid));
>         }
> +
>         ret = parse_commit_buffer(item, buffer, size);
> +

I guess the new lines are for readability?
Not sure if will play out nicely with merges in this area, though.
(I touch this area of the code as well in the not yet sent out series
adding the repository as an argument all over the place. Not your
problem, just me getting anxious)

> @@ -34,6 +34,8 @@
>  #define GRAPH_CHUNKLOOKUP_SIZE (5 * 12)
>  #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
>                         GRAPH_OID_LEN + sizeof(struct packed_graph_header))
> +/* global storage */
> +struct packed_graph *packed_graph = 0;
>
>  struct object_id *get_graph_head_oid(const char *pack_dir, struct object_id *oid)
>  {
> @@ -209,6 +211,225 @@ struct packed_graph *load_packed_graph_one(const char *graph_file, const char *p
>         return graph;
>  }
>
> +static void prepare_packed_graph_one(const char *obj_dir)
> +{
> +       char *graph_file;
> +       struct object_id oid;
> +       struct strbuf pack_dir = STRBUF_INIT;
> +       strbuf_addstr(&pack_dir, obj_dir);
> +       strbuf_add(&pack_dir, "/pack", 5);
> +
> +       if (!get_graph_head_oid(pack_dir.buf, &oid))
> +               return;
> +
> +       graph_file = get_graph_filename_oid(pack_dir.buf, &oid);
> +
> +       packed_graph = load_packed_graph_one(graph_file, pack_dir.buf);
> +       strbuf_release(&pack_dir);
> +}
> +
> +static int prepare_packed_graph_run_once = 0;

Okay. :(
Seeing new globals like these, gives me extra motivation to
get the object store series going.
