Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEEA5200B9
	for <e@80x24.org>; Thu,  3 May 2018 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeECRGb (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:06:31 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:37339 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECRGa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:06:30 -0400
Received: by mail-yw0-f193.google.com with SMTP id u83-v6so5866893ywc.4
        for <git@vger.kernel.org>; Thu, 03 May 2018 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1S1tBAVcjfHLKzbjSzRxc6fmTEG3OoG6JZT3ZG7dUrM=;
        b=vSclADMaBILwhO1sfDtld3WQaEiMbRecVgjOp+3N0cMvbd6CC+j+zoyLjTSl90cCxj
         1w6g1lr7oJE5qnfodXZABToF3zV86vhkQYzOGNSRHJ2EbJF8Y49KVZ3QEDlqMQJUlriR
         9FrivwolA6bkUAHDeO42vKKcNU5lIOPLSKFNvtH9IqdIg320m52wPkY30YAbm80BR32u
         QtlTuuCJJJvsoJAPlqH7PQCo98190NYiIWH3ABX+VJhjfpx95yaoJYDr6ZSLQAXAm1I5
         CZTI15z/XQiXs+kIfP/L3Ikwm3ECUfChYb4lJsQ3EPZNI5Yrmq1JgFeSHmWT6Fa3AFQf
         QmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1S1tBAVcjfHLKzbjSzRxc6fmTEG3OoG6JZT3ZG7dUrM=;
        b=FpCQ6dBXp4hbcJhQMOTqruD25sYD2ldZsHrB2EH1lez9/1qqrRZOqHM0zHQ3Pj0t47
         vUGjAs1Z7ZAsHvr+r5/OP7oNUBQI1IvXl6RT2UVreotgPCnCXv9T0XyIUIidK4nztrIz
         WMEDyJR2rZO+yNNyWn18Z+83HNiwieVa4Br+pxnhXpprysKNsxamahy7l0x2Xwb329lI
         v0UtCXM1O+n7jMjL1A6vnO43RK7E3GMgl7ZcU16Y+8KEE+53AtzLVpljjg3I0mHXMHR0
         abQpMBLAHiI9mtG2NHQiGLP8LG4PohC7cydZ0+F1yVGyTSzbmuoqVBat5oemOKo4Ekc5
         E/7w==
X-Gm-Message-State: ALQs6tA1MsDE29D2Rn5ixvEMXqjq0SyjIipZJuIk4aLUzZPyWVfpBJoI
        QBcAfsU+Y0Zmy7QJteCTcPNglbroaQUIfokFLhojeQ==
X-Google-Smtp-Source: AB8JxZqb1HQjtpmLQFqEm6aLYi5mDEclrqH4aYaXThf2rnv49Uw4Q14CPMQx00vGZ2U/v2HecX5voUchZq8JrRsQg1A=
X-Received: by 2002:a0d:fd84:: with SMTP id n126-v6mr13691502ywf.33.1525367189601;
 Thu, 03 May 2018 10:06:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 10:06:29 -0700 (PDT)
In-Reply-To: <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 10:06:29 -0700
Message-ID: <CAGZ79kYzZkdZKdR4hMK0V6D6=cm4damct01MGidGA0g-dtW+gQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 8:30 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:

> Note: due to differences in the diff algorithm (`tbdiff` uses the
> Pythong module `difflib`, Git uses its xdiff fork), the cost matrix
> calculated by `branch-diff` is different (but very similar) to the one
> calculated by `tbdiff`. Therefore, it is possible that they find
> different matching commits in corner cases (e.g. when a patch was split
> into two patches of roughly equal length).

Does that mean, we may want to tweak the underlying diff parameters for
this special use case eventually?

>
> -#define COLOR_DUAL_MODE 2
> -

Leave this out in the first patch?

> @@ -19,6 +23,279 @@ static int parse_creation_weight(const struct option *opt, const char *arg,
>         return 0;
>  }
>
> +struct patch_util {
> +       /* For the search for an exact match */
> +       struct hashmap_entry e;
> +       const char *diff, *patch;
> +
> +       int i;
> +       int diffsize;
> +       size_t diff_offset;
> +       /* the index of the matching item in the other branch, or -1 */
> +       int matching;
> +       struct object_id oid;
> +};
> +
> +/*
> + * Reads the patches into a string list, with the `util` field being populated
> + * as struct object_id (will need to be free()d).
> + */
> +static int read_patches(const char *range, struct string_list *list)
> +{
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       FILE *in;
> +       struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
> +       struct patch_util *util = NULL;
> +       int in_header = 1;
> +
> +       argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
> +                       "--reverse", "--date-order", "--decorate=no",
> +                       "--no-abbrev-commit", range,
> +                       NULL);
> +       cp.out = -1;
> +       cp.no_stdin = 1;
> +       cp.git_cmd = 1;
> +
> +       if (start_command(&cp))
> +               return error_errno(_("could not start `log`"));
> +       in = fdopen(cp.out, "r");
> +       if (!in) {
> +               error_errno(_("could not read `log` output"));
> +               finish_command(&cp);
> +               return -1;
> +       }

With the implementation of --color-moved, there is an option
to buffer all diff output in memory e6e045f8031 (diff.c: buffer
all output if asked to, 2017-06-29), so I posit that running this
diff in-core may be "not too hard". Famous last words.

In addition to that patch, we'd have to buffer commit messages
and buffer multiple commits, as that only buffers a diff of a single
commit.

The benefit would be no invocation of new processes, letting us
do more in core. This would allow for tweaking revision walking
internally, e.g. passing of options to this command such as rename
detection factors, can be passed through easily without the need
of translating it back to the command line.
Let's read on.

> +
> +               if (starts_with(line.buf, "diff --git")) {

When using the internal buffers, you would not need to
string compare, but could just check for the
DIFF_SYMBOL_HEADER.

> +               } else if (starts_with(line.buf, "@@ "))
> +                       strbuf_addstr(&buf, "@@");

So we omit line information for hunks. Makes sense,
though then we could also skip the "index ..." lines?

Stefan
