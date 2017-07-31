Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0925A1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 23:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbdGaX2D (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 19:28:03 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35019 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdGaX17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 19:27:59 -0400
Received: by mail-qk0-f194.google.com with SMTP id a77so69512qkb.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 16:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PhI9Dxyp8Tm/UaWHFtvjL6wNDAEk9ew1792yZxR14ls=;
        b=UcfNXuLQkgzd9EsKmNUkA77VNAlH+cwjsnT/zupFCRwUroUlQqfdB4eGStH4LcJ9qY
         JpfqIu7LIqYNAqrlcH2C2mKGQlTzEwsL2WW5Sf5nAHhpCpCmbsy6ikAOiYXwcl5aHW9N
         cRmik1J+kWwKNi2gbL45Yx+9qRWLc6WSvn97hpJQR/5ZLhvWMExkVyWMpIhI3frH9ZYK
         a5OCiU0tj4bbp9xXNDglHOv1QCA+PGkPOlN995knyNBi5lD0aosRrnl/1utqkgQR2WeB
         CbeA3/+zjuwmzhxNl+N5Bij1vSQKAMxe+4XGIUuBXWdzBbDW4lXwowQ9CbVHLUlBciA9
         M3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PhI9Dxyp8Tm/UaWHFtvjL6wNDAEk9ew1792yZxR14ls=;
        b=d92JS5xpv8sWIEvFk+/Izj7fg57wRDbVLHYQyOGC9TJWYJp+BXGKM4oU+xycKMhTot
         ybGWOQVkU4FblkdYwKabjXbXb2dwI+NCqCfQM0NJCZ05/0DDxFMDxcZV+sb9ycZrbS5q
         t61i1gsTRDChcx6rbxqjcwpyXBczSalVzaYhFV0iLodx5+kzn1OU9Adrbjh0NHnfRSKF
         aOrQPXCcEy3dTZpcDCpvTL3u2bfdEnGez/ZjuG5n5Az1jLBQbSgXoZe4nI4fYqMKIjXn
         2Yyp23Bvp4ZoxysWV1qOW9wO3WD317m15022axzS4qZhgAL3x6mEv8diPhC6FSir3R8n
         /H2w==
X-Gm-Message-State: AIVw112pb70Sk3JZJfp//hbNI0EkVSwg31fl4nC36bUo52Fj0pkSmsHQ
        cNcXyVCCHz6V9hkh9LUaPSipjRS7tg==
X-Received: by 10.55.111.4 with SMTP id k4mr22277183qkc.287.1501543678880;
 Mon, 31 Jul 2017 16:27:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Mon, 31 Jul 2017 16:27:58 -0700 (PDT)
In-Reply-To: <20170731205621.24305-9-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-9-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 1 Aug 2017 01:27:58 +0200
Message-ID: <CAP8UFD3_zX0=h9tuNA-w+30V4P8zZGyUCEnpciTkwRWpXjjmNg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 08/13] submodule: port submodule subcommand
 'summary' from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 10:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> * variable head was no longer used in module_summary() and instead the strbuf
>   was utilized.

Good but there might be a few problems in the way it is used. See below.

> +static int compute_summary_module_list(char *head, struct summary_cb *info)
> +{
> +       struct argv_array diff_args = ARGV_ARRAY_INIT;
> +       struct rev_info rev;
> +       struct module_cb_list list = MODULE_CB_LIST_INIT;
> +
> +       argv_array_push(&diff_args, info->diff_cmd);
> +       if (info->cached)
> +               argv_array_push(&diff_args, "--cached");
> +       argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
> +                        NULL);
> +       if (head)
> +               argv_array_push(&diff_args, head);
> +       argv_array_push(&diff_args, "--");
> +       if (info->argc)
> +               argv_array_pushv(&diff_args, info->argv);
> +
> +       git_config(git_diff_basic_config, NULL);
> +       init_revisions(&rev, info->prefix);
> +       gitmodules_config();
> +       rev.abbrev = 0;
> +       precompose_argv(diff_args.argc, diff_args.argv);
> +
> +       diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
> +                                        &rev, NULL);
> +       rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
> +       rev.diffopt.format_callback = submodule_summary_callback;
> +       rev.diffopt.format_callback_data = &list;
> +
> +       if (!info->cached) {
> +               if (!strcmp(info->diff_cmd, "diff-index"))
> +                       setup_work_tree();
> +               if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
> +                       perror("read_cache_preload");
> +                       return -1;
> +               }
> +       } else if (read_cache() < 0) {
> +               perror("read_cache");
> +               return -1;
> +       }
> +
> +       if (!strcmp(info->diff_cmd, "diff-index"))
> +               run_diff_index(&rev, info->cached);
> +       else
> +               run_diff_files(&rev, 0);
> +       prepare_submodule_summary(info, &list);
> +
> +       free(head);

It is a bit strange to have this function free() an argument it is passed.

> +       return 0;
> +

Spurious new line.

> +}
> +
> +static int module_summary(int argc, const char **argv, const char *prefix)
> +{
> +       struct summary_cb info = SUMMARY_CB_INIT;
> +       int cached = 0;
> +       char *diff_cmd = "diff-index";
> +       int for_status = 0;
> +       int quiet = 0;
> +       int files = 0;
> +       int summary_limits = -1;
> +       struct child_process cp_rev = CHILD_PROCESS_INIT;
> +       struct strbuf sb = STRBUF_INIT;

[...]

> +       if (!capture_command(&cp_rev, &sb, 0)) {
> +               strbuf_strip_suffix(&sb, "\n");
> +               if (argc) {
> +                       argv++;
> +                       argc--;
> +               }
> +       } else if (!argc || !strcmp(argv[0], "HEAD")) {
> +               /* before the first commit: compare with an empty tree */
> +               struct stat st;
> +               struct object_id oid;
> +               if (fstat(0, &st) < 0 || index_fd(oid.hash, 0, &st, 2, prefix, 3))
> +                       die("Unable to add %s to database", oid.hash);
> +               strbuf_addstr(&sb, oid_to_hex(&oid));
> +               if (argc) {
> +                       argv++;
> +                       argc--;
> +               }
> +       } else {
> +               strbuf_addstr(&sb, "HEAD");
> +       }
> +
> +       if (files) {
> +               if (cached)
> +                       die(_("The --cached option cannot be used with the --files option"));
> +               diff_cmd = "diff-files";
> +
> +               strbuf_reset(&sb);

strbuf_reset() does not free the memory allocated to sb.buf...

> +               sb.buf = NULL;

...then this makes sure that the memory previously allocated to sb.buf
will not be free()d.

Maybe instead of the above 2 lines just: strbuf_release(&sb)
Or maybe just don't set sb.buf to NULL.

> +       }
> +
> +       info.argc = argc;
> +       info.argv = argv;
> +       info.prefix = prefix;
> +       info.cached = !!cached;
> +       info.for_status = !!for_status;
> +       info.quiet = quiet;
> +       info.files = files;
> +       info.summary_limits = summary_limits;
> +       info.diff_cmd = diff_cmd;
> +
> +       return compute_summary_module_list(strbuf_detach(&sb, NULL), &info);

Maybe you could pass: "sb.len > 0 ? strbuf_detach(&sb, NULL) : NULL"
This way if sb has previously been released or reset, NULL will be passed.

I would suggest though to just pass sb.buf and to strbuf_release(&sb)
after calling compute_summary_module_list() and before returning from
module_summary() instead of having compute_summary_module_list() free
its first argument.
If you do that then compute_summary_module_list() should be changed so
that when it is passed "" it will behave in the same way as when it is
passed NULL.

> +}
