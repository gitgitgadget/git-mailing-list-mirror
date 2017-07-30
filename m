Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B6D208A0
	for <e@80x24.org>; Sun, 30 Jul 2017 06:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbdG3Gdn (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 02:33:43 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33036 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdG3Gdm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 02:33:42 -0400
Received: by mail-io0-f193.google.com with SMTP id q64so11851228ioi.0
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 23:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FKrb9i04K+RmCCcFzZIaV+wpwdRSgGlgaIR0Fr3zw5A=;
        b=qsp2M4IOoefGVxfYARidGGtbZ4FTS1Rx/6yGnKTmKPt1LXbP603mmbFjyLCklybr3l
         6IQ5Ra/Sm8loAmZztAdv6+BJgxnsJFaAByfAlURD5n9q0gFL9jlpiRVfxmK5HhWYU6Hh
         Bg2AyUALFDKbDled6r3GfDzsgI5/7vQDkFiO0tJS7ic6teerJdfdYdj+wIytn3636bun
         96ZulPeMFj/TGOTQtP3RePvkdJT/jj5k6S5FIUC79EuRfE9DoNFUHROKbrZUnhGTb91g
         41M32pQEO1SpNDOt7B1MW2MSmUL8s/oMD/GSFQ2glaNMhTBijd5Pm6/DDrN7IvIKOUk7
         HjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FKrb9i04K+RmCCcFzZIaV+wpwdRSgGlgaIR0Fr3zw5A=;
        b=cWpgT2zv3oiMS9d1DImfWlBJ5Y5sByKTdbPYNAT4m9U34PNCzyP2iIVfULJiIMavED
         K1YZ0E+HgQzeyo9NKVvdlTuJ26nOa3S4x5TuYzM3MDSHyL80tSgS+Y0uspXzWerKRGFr
         SG/kt3/JrVuk5rOKifeOt6SqUBo/LgQMMvDhXgd2sbDw1i9ZWObNERIQbhbucgklfQgZ
         4ITp2k9xTQi3o+kpFcXTi/xBBYdyL28PT7j4+y8vOkNIraS0iWJnbaysj7wDBNfS4rGH
         enrYoyA/z5W4H9pHV+gphRqbgxbpEDrvwcu/PwmQLrur1ioO5iwBlaMoTILvAROuDpNF
         B3Qw==
X-Gm-Message-State: AIVw1119ur7nNi5Kjdh2iTs0wls/t6eFy4/LRE4P+bngNU4xFepZT/KS
        +kvMOCw2U12e+2nlr7pvQmsqGycLmw==
X-Received: by 10.107.26.130 with SMTP id a124mr14361134ioa.120.1501396421362;
 Sat, 29 Jul 2017 23:33:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.149.134 with HTTP; Sat, 29 Jul 2017 23:33:40 -0700 (PDT)
In-Reply-To: <CAP8UFD2XWm-m1CZoX121mhQ+WunCRTMJT5RjrZAXKBY3axcSJQ@mail.gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com> <20170729222401.12381-1-pc44800@gmail.com>
 <20170729222401.12381-9-pc44800@gmail.com> <CAP8UFD2XWm-m1CZoX121mhQ+WunCRTMJT5RjrZAXKBY3axcSJQ@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Sun, 30 Jul 2017 12:03:40 +0530
Message-ID: <CAME+mvXs-xu4K60A_SoWoOCS3m6NbLQApPVyy9LfM3mc5mGQFw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 08/13] submodule: port submodule subcommand
 'summary' from shell to C
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 30, 2017 at 10:58 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Jul 30, 2017 at 12:23 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>
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
>> +       char *head;
>> +       struct strbuf sb = STRBUF_INIT;
>> +       int ret;
>> +
>> +       struct option module_summary_options[] = {
>> +               OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
>> +               OPT_BOOL(0, "cached", &cached, N_("Use the commit stored in the index instead of the submodule HEAD")),
>> +               OPT_BOOL(0, "files", &files, N_("To compares the commit in the index with that in the submodule HEAD")),
>> +               OPT_BOOL(0, "for-status", &for_status, N_("Skip submodules with 'all' ignore_config value")),
>> +               OPT_INTEGER('n', "summary-limits", &summary_limits, N_("Limit the summary size")),
>> +               OPT_END()
>> +       };
>> +
>> +       const char *const git_submodule_helper_usage[] = {
>> +               N_("git submodule--helper summary [<options>] [--] [<path>]"),
>> +               NULL
>> +       };
>> +
>> +       argc = parse_options(argc, argv, prefix, module_summary_options,
>> +                            git_submodule_helper_usage, 0);
>> +
>> +       if (!summary_limits)
>> +               return 0;
>> +
>> +       cp_rev.git_cmd = 1;
>> +       argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
>> +                        argc ? argv[0] : "HEAD", NULL);
>> +
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
>> +       head = strbuf_detach(&sb, NULL);
>
> I am not sure this "head" variable is really needed.
>
>> +       if (files) {
>> +               if (cached)
>> +                       die(_("The --cached option cannot be used with the --files option"));
>> +               diff_cmd = "diff-files";
>> +
>> +               free(head);
>> +
>> +               head = NULL;
>
> If "head" isn't used, "strbuf_reset(&sb)" could be used instead.
> If "head" is still needed, "FREE_AND_NULL(head)" could be used.

Thank you for reviewing this patch.
As suggested, here we can remove the variable head, and instead use
the strbuf struct.
But in the above lines, along with strbuf_reset(&sb), later we are
also required to set
sb.buf to NULL.

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
>> +       ret = compute_summary_module_list(head, &info);

we may even remove the variable ret, but passing strbuf_detach(&sb, NULL) here
to the function compute_summary_module_list(), and then later on free(head) at
the end of the function compute_summary_module_list().

Thanks,
Prathamesh Chavan
