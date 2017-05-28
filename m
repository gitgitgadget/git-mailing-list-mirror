Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44941FD09
	for <e@80x24.org>; Sun, 28 May 2017 18:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbdE1Sva (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 14:51:30 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34635 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdE1Sv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 14:51:29 -0400
Received: by mail-io0-f195.google.com with SMTP id 12so5386245iol.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y1zdXe1Me5lhzXnVz0SV7KN887kAKHV8LIoUswK5EBo=;
        b=PPKOFFeJofOKUCUH5bdohT/cUAo3XePiEMas8b5P0tQJdB2Y/ypShhgQGYM9R2LRHC
         f/kdWOFbBmQQ2BwdaHVHxMdb8tcZICma5Q35qZCCWvZC5V5O+eBKmlDtbcF1PkyrpaIT
         RmgxU56NhUTfjCQzLUDw34ya4NebZn3pwGZyEaZnFCGIINVzXsHoELKwIg0xcPY8EwtV
         pbYbwfBMZCVPFlh/GjK7JSHvoTqUuEJ8hLc4XjRU8zd4PUW1LgQmPLfdIuoO0l3svs7x
         sh3kuExlvVfW7TJL6PRkM0l4eKhoTdL2KFo2rKaC8/CYQzOOM4kZ83S3zMePmDbPJXHM
         JdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y1zdXe1Me5lhzXnVz0SV7KN887kAKHV8LIoUswK5EBo=;
        b=WaY+sbj3xgdUSVqf+1SXH44XbML1ypb7kBpWAQlLkWTzTgQSGkmYzVZkeSRXywo9og
         vAeK671HRNw6M6SnIj1ITvF8/RE/YZ7XkVLCurm0rRWpvySG2X7JqSGffrKcPcof21Y/
         W0dv0C+4PcZxPkEwmO8HCzT11HTttokixaVeVnTv7SBoxBWdMIvrTK699cYfXewtt64H
         KqkqdTyS6yMrjGBH1dyjYFwzYS9WMVchuhH+RyezGVZizEqeW/NmIl/pvlykfCJSfn9s
         GNjnnTi3pUESWMlz6kese4/u9Jo8nybQuLQjWWF8PHriolk44e4iXYJX5ZD+iFRDqa/M
         cLtg==
X-Gm-Message-State: AODbwcCDCkbv+P8Be5bIkBlxziazVIIK2XSECLskNJPnQR6TPrN46Z2a
        GGXJM7QPL5Tg2jShuqiA3YGBUjRDow==
X-Received: by 10.107.178.12 with SMTP id b12mr9842971iof.50.1495997488661;
 Sun, 28 May 2017 11:51:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 28 May 2017 11:51:07 -0700 (PDT)
In-Reply-To: <20170528165642.14699-5-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-5-joel@teichroeb.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 May 2017 20:51:07 +0200
Message-ID: <CACBZZX6uXnE+BTfsiLNF2OT3Dsr-J99uUFEwcu-qK45OrU+1hQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 6:56 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> Implement all git stash functionality as a builtin command
>
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---

General note on this that I missed in my first E-Mail, you have ~20
calls to argv_array_init() but none to argv_array_clear(). So you're
leaking memory, and it obscures potential other issues with valgrind.

A lot of that's easy to solve, but sometimes requires a temporary
variable since the code is now returning directly, e.g:

@@ -1091,6 +1094,7 @@ static int list_stash(int argc, const char
**argv, const char *prefix)
        struct object_id obj;
        struct object_context unused;
        struct argv_array args;
+       int ret = 0;

        argc = parse_options(argc, argv, prefix, options,
                                 git_stash_list_usage, PARSE_OPT_KEEP_UNKNOWN);
@@ -1107,9 +1111,9 @@ static int list_stash(int argc, const char
**argv, const char *prefix)
        argv_array_pushv(&args, argv);
        argv_array_push(&args, ref_stash);
        if (cmd_log(args.argc, args.argv, prefix))
-               return 1;
-
-       return 0;
+               ret = 1;
+       argv_array_clear(&args);
+       return ret;
 }

But more generally this goes a long way to resolving the issue where
you have variables like out1, out2 or cp1, cp2 etc. which Christian
pointed out. I.e. you're not freeing/clearing strbufs either, instead
just creating new ones that also aren't freed, or not clearing
child_process structs, e.g. this on top allows you to re-use the same
variable and stops leaking memory:

diff --git a/builtin/stash.c b/builtin/stash.c
index bf36ff8f9b..4e7344501a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -729,7 +729,6 @@ static int do_push_stash(const char *prefix, const
char *message,

                if (keep_index) {
                        struct child_process cp = CHILD_PROCESS_INIT;
-                       struct child_process cp2 = CHILD_PROCESS_INIT;
                        struct strbuf out = STRBUF_INIT;

                        reset_tree(info.i_tree, 0, 1);
@@ -741,13 +740,18 @@ static int do_push_stash(const char *prefix,
const char *message,
                        argv_array_push(&cp.args, "--");
                        argv_array_pushv(&cp.args, argv);
                        pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
+                       argv_array_clear(&cp.args);
+                       child_process_clear(&cp);

-                       cp2.git_cmd = 1;
-                       argv_array_push(&cp2.args, "checkout-index");
-                       argv_array_push(&cp2.args, "-z");
-                       argv_array_push(&cp2.args, "--force");
-                       argv_array_push(&cp2.args, "--stdin");
-                       pipe_command(&cp2, out.buf, out.len, NULL, 0, NULL, 0);
+                       child_process_init(&cp);
+                       cp.git_cmd = 1;
+                       argv_array_push(&cp.args, "checkout-index");
+                       argv_array_push(&cp.args, "-z");
+                       argv_array_push(&cp.args, "--force");
+                       argv_array_push(&cp.args, "--stdin");
+                       pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0);
+                       argv_array_clear(&cp.args);
+                       child_process_clear(&cp);
                }
        } else {
                struct child_process cp2 = CHILD_PROCESS_INIT;
