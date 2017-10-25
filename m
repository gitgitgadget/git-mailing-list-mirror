Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BEAE1FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 04:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbdJYEOa (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 00:14:30 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:55366 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdJYEO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 00:14:29 -0400
Received: by mail-io0-f176.google.com with SMTP id p186so26159537ioe.12
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B2HI3fMWvy39uEdOCk8OB3+ZgS/vCcvM5p76wbanXaU=;
        b=f1c0ZSjN7eF6Mc2asU+YAlfkyTHNZDnuyXBpujkx0iiVpNUkACrP1utfybGmdR3Tne
         C29s+7E7ZxlQwep1PherYymfce1iT19K8X0RoftOY8Bq6tPpGeAwrQlwVJ6BYcrXxWsB
         tUDpVsh6fKkMJwtEBOiONhtM3ryYxDKqJaJYv1kVtHUlCgfVUu4FKGp2CGak3uNhRLSS
         AjoRLQBvF2dwMfeiEwhWwH4xS7HB58IHMP40q0emcLeXzn0jFKRZ0fQu8uslddFk3ibX
         O8mbo+bhV5fS9tm919bfn5COo24LqpHQ65lkxrWJzOZ5Js+xK4YVOlhrUXXTABEYqVay
         LhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B2HI3fMWvy39uEdOCk8OB3+ZgS/vCcvM5p76wbanXaU=;
        b=CJYN6dg7wNbOMQfD8KTkLR1+Jd9DkFfGhX0kmuex0M7tycgOt8c2e7TTSjcKC/Oxgr
         dRGUGXMyNEhEAJ1urbhOQ/gKJgnLJnE0e6s5MFYmM3HGqED8N2JnBHYoOaF7j0m+zA+D
         PIu/wpUB6WG9qmbZjJKYblH79c5dGkvpGQavFNBumokzPwZFUSCWLm0mE227Jd/jIB3R
         nNqe5+MXm4h3XzaV1VVbTqOdj95A2cF8TNRlWDPokHusYoBjiALJeTPBQoVnU4qhQWaC
         4k3pZbdTrLK5DYtyHoBre6iccQUY1oxd125SK3EXUNNZaC4C1d9Cl+qTGCkqFjeD8X/H
         K0yA==
X-Gm-Message-State: AMCzsaXYw/F/LYRu44zby4q9mIJlILfy6GpoVWL3Jz3Ihl6zwuEfVyDr
        raSV5ed/v6Wko+VvahI3dz3pKT0rmREABRD9COfTTg==
X-Google-Smtp-Source: ABhQp+SPxKSfH19OlOo/RtKW2E3R0goFidmpb50cxxD3ogxPf6Lk1E+rI7ItjX2w5GPoMFly+G9CzBXr2IBPj4uyd90=
X-Received: by 10.107.8.100 with SMTP id 97mr23905849ioi.83.1508904868338;
 Tue, 24 Oct 2017 21:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.174.66 with HTTP; Tue, 24 Oct 2017 21:14:27 -0700 (PDT)
In-Reply-To: <20171024185332.57261-8-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com> <20171024185332.57261-8-git@jeffhostetler.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 24 Oct 2017 21:14:27 -0700
Message-ID: <CAGf8dgJmwtN-v9SQfjUJOBreGQ==iM1G-oGBh3oYH_DE4NYyLA@mail.gmail.com>
Subject: Re: [PATCH 07/13] list-objects-filter-options: common argument parsing
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 11:53 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> + * <arg> ::= blob:none
> + *           blob:limit:<n>[kmg]
> + *           sparse:oid:<oid-expression>
> + *           sparse:path:<pathname>

I notice in the code below that there are some usages of "=" instead
of ":" - could you clarify which one it is? (Ideally this would point
to one point of documentation which serves as both user and technical
documentation.)

> + */
> +int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
> +                             const char *arg)
> +{
> +       struct object_context oc;
> +       struct object_id sparse_oid;
> +       const char *v0;
> +       const char *v1;
> +
> +       if (filter_options->choice)
> +               die(_("multiple object filter types cannot be combined"));
> +
> +       /*
> +        * TODO consider rejecting 'arg' if it contains any
> +        * TODO injection characters (since we might send this
> +        * TODO to a sub-command or to the server and we don't
> +        * TODO want to deal with legacy quoting/escaping for
> +        * TODO a new feature).
> +        */
> +
> +       filter_options->raw_value = strdup(arg);
> +
> +       if (skip_prefix(arg, "blob:", &v0) || skip_prefix(arg, "blobs:", &v0)) {

I know that some people prefer leniency, but I think it's better to
standardize on one form ("blob" instead of both "blob" and "blobs").

> +               if (!strcmp(v0, "none")) {
> +                       filter_options->choice = LOFC_BLOB_NONE;
> +                       return 0;
> +               }
> +
> +               if (skip_prefix(v0, "limit=", &v1) &&
> +                   git_parse_ulong(v1, &filter_options->blob_limit_value)) {
> +                       filter_options->choice = LOFC_BLOB_LIMIT;
> +                       return 0;
> +               }
> +       }
> +       else if (skip_prefix(arg, "sparse:", &v0)) {
> +               if (skip_prefix(v0, "oid=", &v1)) {
> +                       filter_options->choice = LOFC_SPARSE_OID;
> +                       if (!get_oid_with_context(v1, GET_OID_BLOB,
> +                                                 &sparse_oid, &oc)) {
> +                               /*
> +                                * We successfully converted the <oid-expr>
> +                                * into an actual OID.  Rewrite the raw_value
> +                                * in canonoical form with just the OID.
> +                                * (If we send this request to the server, we
> +                                * want an absolute expression rather than a
> +                                * local-ref-relative expression.)
> +                                */
> +                               free((char *)filter_options->raw_value);
> +                               filter_options->raw_value =
> +                                       xstrfmt("sparse:oid=%s",
> +                                               oid_to_hex(&sparse_oid));
> +                               filter_options->sparse_oid_value =
> +                                       oiddup(&sparse_oid);
> +                       } else {
> +                               /*
> +                                * We could not turn the <oid-expr> into an
> +                                * OID.  Leave the raw_value as is in case
> +                                * the server can parse it.  (It may refer to
> +                                * a branch, commit, or blob we don't have.)
> +                                */
> +                       }
> +                       return 0;
> +               }
> +
> +               if (skip_prefix(v0, "path=", &v1)) {
> +                       filter_options->choice = LOFC_SPARSE_PATH;
> +                       filter_options->sparse_path_value = strdup(v1);
> +                       return 0;
> +               }
> +       }
> +
> +       die(_("invalid filter expression '%s'"), arg);
> +       return 0;
> +}
> +
> +int opt_parse_list_objects_filter(const struct option *opt,
> +                                 const char *arg, int unset)
> +{
> +       struct list_objects_filter_options *filter_options = opt->value;
> +
> +       assert(arg);
> +       assert(!unset);
> +
> +       return parse_list_objects_filter(filter_options, arg);
> +}
> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> new file mode 100644
> index 0000000..23bd68e
> --- /dev/null
> +++ b/list-objects-filter-options.h
> @@ -0,0 +1,50 @@
> +#ifndef LIST_OBJECTS_FILTER_OPTIONS_H
> +#define LIST_OBJECTS_FILTER_OPTIONS_H
> +
> +#include "parse-options.h"
> +
> +/*
> + * Common declarations and utilities for filtering objects (such as omitting
> + * large blobs) in list_objects:traverse_commit_list() and git-rev-list.
> + */
> +
> +enum list_objects_filter_choice {
> +       LOFC_DISABLED = 0,
> +       LOFC_BLOB_NONE,
> +       LOFC_BLOB_LIMIT,
> +       LOFC_SPARSE_OID,
> +       LOFC_SPARSE_PATH,
> +};
> +
> +struct list_objects_filter_options {
> +       /*
> +        * The raw argument value given on the command line or
> +        * protocol request.  (The part after the "--keyword=".)
> +        */
> +       char *raw_value;
> +
> +       /*
> +        * Parsed values. Only 1 will be set depending on the flags below.
> +        */
> +       struct object_id *sparse_oid_value;
> +       char *sparse_path_value;
> +       unsigned long blob_limit_value;
> +
> +       enum list_objects_filter_choice choice;
> +};
> +
> +/* Normalized command line arguments */
> +#define CL_ARG__FILTER "filter"
> +
> +int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
> +                             const char *arg);
> +
> +int opt_parse_list_objects_filter(const struct option *opt,
> +                                 const char *arg, int unset);
> +
> +#define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
> +       { OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
> +         N_("object filtering"), PARSE_OPT_NONEG, \
> +         opt_parse_list_objects_filter }

Thanks - this does make it easier to have a standard argument name and
description everywhere.

> +
> +#endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
> --
> 2.9.3
>
