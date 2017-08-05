Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13BE1F991
	for <e@80x24.org>; Sat,  5 Aug 2017 10:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdHEK2H (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 06:28:07 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37913 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdHEK2F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 06:28:05 -0400
Received: by mail-it0-f67.google.com with SMTP id f16so280858itb.5
        for <git@vger.kernel.org>; Sat, 05 Aug 2017 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BJAGc370u9lqXW9dp/MdyA+9xGe/REoagF6so8SrcbE=;
        b=e7up2fJisXV6gXZaMCDhKTasF0Co6rPoVpZeHkYg+hmgYEHYIRY91kgsS7pIPQeEs+
         /BWuTSLfXlg9CiRHhz6qgH9jkF1qguLQbuIWCIN4Ws+OLfl1K+zrNV9TR1we5k3g2F6n
         iwGL1dup7BIp+lmjcsFFYtfSarAume8o5P/3M8j5X3Zs02yzoZZ4wL5tLe9QZY5kv2o7
         VWLXkt47zBxB5T1+KrWOChoBy+Xbpd4cHbullvD9NUipxHQPKI55jw+7XBlWSrXKdMGw
         6NCl1vUmzZu40vsejw14SggJbfENfzAXIeZr+Yjp3YPhhsjbzd2Ij+4QWYPYTGKlWh7z
         3ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BJAGc370u9lqXW9dp/MdyA+9xGe/REoagF6so8SrcbE=;
        b=EbPwBKlBseCvQVETT9So+944smcz/cQIQlLn++EdDJHhu+E3pQFvT+rnBMBiH7vtiW
         2NBHYgnAR1TGfZnjbByCTFVLqeh+aymrcUV+6LJxCgEUFVISZRYJMxP6J7iYJfFe6fRj
         M0hG/79JjGdIzWnTaVNvC65sort2bOTtD46D/KjtMlBL93lYYlZsHgBUtPtuRSnxrwqc
         DBGyfed6KAsrU729jvEheuJzzsWLR79GAH2ysbs0tuIhVKaP2iXoXDCCkUC9KJTaL/Sh
         sGsoe+zdC0CDKmtXGXS19uvDdaUhAQ5rVitqeWjStv0fccIV10OC5PRD7vjLPwIR+d2k
         qTmw==
X-Gm-Message-State: AIVw113U5lyMZKMhOcK37KwDNTp3GHJyNh+Y84DexIMspG6rI+CKNbuY
        HKwnuHXRSrC6vM1P5gYazBxlK+QINg==
X-Received: by 10.36.89.140 with SMTP id p134mr5128118itb.20.1501928884433;
 Sat, 05 Aug 2017 03:28:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.149.134 with HTTP; Sat, 5 Aug 2017 03:28:03 -0700 (PDT)
In-Reply-To: <CAP8UFD3_zX0=h9tuNA-w+30V4P8zZGyUCEnpciTkwRWpXjjmNg@mail.gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-9-pc44800@gmail.com>
 <CAP8UFD3_zX0=h9tuNA-w+30V4P8zZGyUCEnpciTkwRWpXjjmNg@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Sat, 5 Aug 2017 15:58:03 +0530
Message-ID: <CAME+mvUAspzuzbB4pFiQeOtT7NGRTO25M-k8o8hoysMFLGy_0w@mail.gmail.com>
Subject: Re: [GSoC][PATCH 08/13] submodule: port submodule subcommand
 'summary' from shell to C
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 4:57 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Jul 31, 2017 at 10:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>
>> * variable head was no longer used in module_summary() and instead the strbuf
>>   was utilized.
>
> Good but there might be a few problems in the way it is used. See below.
>
>> +static int compute_summary_module_list(char *head, struct summary_cb *info)
>> +{
>> +       struct argv_array diff_args = ARGV_ARRAY_INIT;
>> +       struct rev_info rev;
>> +       struct module_cb_list list = MODULE_CB_LIST_INIT;
>> +
>> +       argv_array_push(&diff_args, info->diff_cmd);
>> +       if (info->cached)
>> +               argv_array_push(&diff_args, "--cached");
>> +       argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
>> +                        NULL);
>> +       if (head)
>> +               argv_array_push(&diff_args, head);
>> +       argv_array_push(&diff_args, "--");
>> +       if (info->argc)
>> +               argv_array_pushv(&diff_args, info->argv);
>> +
>> +       git_config(git_diff_basic_config, NULL);
>> +       init_revisions(&rev, info->prefix);
>> +       gitmodules_config();
>> +       rev.abbrev = 0;
>> +       precompose_argv(diff_args.argc, diff_args.argv);
>> +
>> +       diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
>> +                                        &rev, NULL);
>> +       rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
>> +       rev.diffopt.format_callback = submodule_summary_callback;
>> +       rev.diffopt.format_callback_data = &list;
>> +
>> +       if (!info->cached) {
>> +               if (!strcmp(info->diff_cmd, "diff-index"))
>> +                       setup_work_tree();
>> +               if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
>> +                       perror("read_cache_preload");
>> +                       return -1;
>> +               }
>> +       } else if (read_cache() < 0) {
>> +               perror("read_cache");
>> +               return -1;
>> +       }
>> +
>> +       if (!strcmp(info->diff_cmd, "diff-index"))
>> +               run_diff_index(&rev, info->cached);
>> +       else
>> +               run_diff_files(&rev, 0);
>> +       prepare_submodule_summary(info, &list);
>> +
>> +       free(head);
>
> It is a bit strange to have this function free() an argument it is passed.
>
>> +       return 0;
>> +
>
> Spurious new line.
>
>> +}
>> +
>> +static int module_summary(int argc, const char **argv, const char *prefix)
>> +{
>> +       struct summary_cb info = SUMMARY_CB_INIT;
>> +       int cached = 0;
>> +       char *diff_cmd = "diff-index";
>> +       int for_status = 0;
>> +       int quiet = 0;
>> +       int files = 0;
>> +       int summary_limits = -1;
>> +       struct child_process cp_rev = CHILD_PROCESS_INIT;
>> +       struct strbuf sb = STRBUF_INIT;
>
> [...]
>
>> +       if (!capture_command(&cp_rev, &sb, 0)) {
>> +               strbuf_strip_suffix(&sb, "\n");
>> +               if (argc) {
>> +                       argv++;
>> +                       argc--;
>> +               }
>> +       } else if (!argc || !strcmp(argv[0], "HEAD")) {
>> +               /* before the first commit: compare with an empty tree */
>> +               struct stat st;
>> +               struct object_id oid;
>> +               if (fstat(0, &st) < 0 || index_fd(oid.hash, 0, &st, 2, prefix, 3))
>> +                       die("Unable to add %s to database", oid.hash);
>> +               strbuf_addstr(&sb, oid_to_hex(&oid));
>> +               if (argc) {
>> +                       argv++;
>> +                       argc--;
>> +               }
>> +       } else {
>> +               strbuf_addstr(&sb, "HEAD");
>> +       }
>> +
>> +       if (files) {
>> +               if (cached)
>> +                       die(_("The --cached option cannot be used with the --files option"));
>> +               diff_cmd = "diff-files";
>> +
>> +               strbuf_reset(&sb);
>
> strbuf_reset() does not free the memory allocated to sb.buf...
>
>> +               sb.buf = NULL;
>
> ...then this makes sure that the memory previously allocated to sb.buf
> will not be free()d.
>
> Maybe instead of the above 2 lines just: strbuf_release(&sb)
> Or maybe just don't set sb.buf to NULL.
>
>> +       }
>> +
>> +       info.argc = argc;
>> +       info.argv = argv;
>> +       info.prefix = prefix;
>> +       info.cached = !!cached;
>> +       info.for_status = !!for_status;
>> +       info.quiet = quiet;
>> +       info.files = files;
>> +       info.summary_limits = summary_limits;
>> +       info.diff_cmd = diff_cmd;
>> +
>> +       return compute_summary_module_list(strbuf_detach(&sb, NULL), &info);
>
> Maybe you could pass: "sb.len > 0 ? strbuf_detach(&sb, NULL) : NULL"
> This way if sb has previously been released or reset, NULL will be passed.
>
> I would suggest though to just pass sb.buf and to strbuf_release(&sb)
> after calling compute_summary_module_list() and before returning from
> module_summary() instead of having compute_summary_module_list() free
> its first argument.
> If you do that then compute_summary_module_list() should be changed so
> that when it is passed "" it will behave in the same way as when it is
> passed NULL.
>
We can avoid it to behave same for "" and NULL, by checking if diff_cmd
is "cmd_diff_files", since its value is set NULL by this case.

ret = compute_summary_module_list(strcmp(diff_cmd, "diff-files") ?
NULL: sb.buf, &info);
strbuf_release(&sb);

instead of:
ret = compute_summary_module_list(sb.len ? sb.buf : NULL, &info);
if (sb.len)
strbuf_release(&sb);

>> +}
