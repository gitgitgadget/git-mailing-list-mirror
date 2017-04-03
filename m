Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDB21FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 20:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbdDCUbZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 16:31:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34321 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdDCUbY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 16:31:24 -0400
Received: by mail-it0-f68.google.com with SMTP id e75so9374564itd.1
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=scQPTD69rTvG4m7/d7BGFt0Vjbjf4qW/YGju6bmVaKg=;
        b=onyuEXpH1Rl7A7hdZ6f8TYyDRznzCJFcJ7O8euhbQHu0rwdO/9mBxGvlj2r6W456Iu
         pIe0SkjNInX/Ek14aXlpInchScqG3JTVw35Z083ZJvbAnjNdZX6YHs44jBS6ACP9z4e3
         D3736DV5tHdCsKuxnVppt/MHoqGvJy9gb2/U28Moc8AY+4AxWMzjauPqYKMsp8o+4OqU
         EqF5nm3XDfco0djn+dHmJ4KxHwtcKz2Znq2WRY68QFJ7J2+eLch4KLHQFRLp6JqFC5Xx
         YNQQgYSE54mPoVBG79t9fLhDk09ilD9RABrE4dVA91YOlK4P5Et0C5s7Csi/OM+jvBlq
         cUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=scQPTD69rTvG4m7/d7BGFt0Vjbjf4qW/YGju6bmVaKg=;
        b=FrJsO+ls98k6gpeMiYDuSzgEy7g8vbd39cDPLRPYtKFFcdas+E5Z7JINjgxVsh0oSd
         i/YDYwm3AU8NPEbzPFKKqlE/O9WVxk1TcYANaoTca9Ayj/eQXlviil/0nczm8u/g4NAD
         RSa9yQQN+rfd+K3BGQc67t6JDJ7qVw3eK4jMYq4RCsDt0Fx8KnSWZYE7YlTcBJUkVFrE
         sn5UJHPA2VzqdTnCkR5tRHwjKS9yr4h8jEDSC3K7lCm36+WhDUNtFWRjQd0w34SlQ223
         4PIMUx5fY75+8beBZ/w9vjIbB9zQrB77oF6HMNWdtkCpB+OuKYdlx+VqR9bKFQaBA06C
         CNPA==
X-Gm-Message-State: AFeK/H2ymX7jC8yJRsKeY55Aczf0rzC0xuax+wcSjDWIiTbZwoh3MFYpSwdvHLKjd9H4rZFskS52XcmeAkM5NA==
X-Received: by 10.36.61.131 with SMTP id n125mr11574317itn.91.1491251484056;
 Mon, 03 Apr 2017 13:31:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 3 Apr 2017 13:31:03 -0700 (PDT)
In-Reply-To: <20170403185306.36164-3-git@jeffhostetler.com>
References: <20170403185306.36164-1-git@jeffhostetler.com> <20170403185306.36164-3-git@jeffhostetler.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 3 Apr 2017 22:31:03 +0200
Message-ID: <CACBZZX7DFuLia8RzB908EG7+oWQiFGkFEq14bzT77A75msM98Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fsck: force core.checksumindex=1
To:     git@jeffhostetler.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2017 at 8:53 PM,  <git@jeffhostetler.com> wrote:
> Teach fsck to override core.checksumindex and always verify
> the index checksum when reading the index.

Sorry to only chime in about this at v4.

I think this patch & the documentation you added for
core.checksumindex in 1/4 would be much less confusing if you made
this a on-by-default command-line option like e.g. "full".

With this patch nothing amends the documentation to indicate that the
core.checksumindex is magically overridden when fsck runs, I think
something like this (needs amending to integrate) on top would make
this clearer:

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index b9f060e3b2..19b45b1b6f 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
         [--[no-]full] [--strict] [--verbose] [--lost-found]
         [--[no-]dangling] [--[no-]progress] [--connectivity-only]
-        [--[no-]name-objects] [<object>*]
+        [--[no-]name-objects] [--[no-]checksum-index] [<object>*]

 DESCRIPTION
 -----------
@@ -61,6 +61,11 @@ index file, all SHA-1 references in `refs`
namespace, and all reflogs
        object pools.  This is now default; you can turn it off
        with --no-full.

+--[no-]checksum-index:
+       Validate the checksum at the end of the index file, on by
+       default, locally overrides any "core.checksumIndex" setting
+       unless negated. See linkgit:git-config[1].
+
 --connectivity-only::
        Check only the connectivity of tags, commits and tree objects. By
        avoiding to unpack blobs, this speeds up the operation, at the
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f76e4163ab..8fe8ec1775 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -24,6 +24,7 @@ static int show_tags;
 static int show_unreachable;
 static int include_reflogs = 1;
 static int check_full = 1;
+static int fsck_opt_checksum_index = 1;
 static int connectivity_only;
 static int check_strict;
 static int keep_cache_objects;
@@ -656,6 +657,8 @@ static struct option fsck_opts[] = {
        OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index
objects head nodes")),
        OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head
nodes (default)")),
        OPT_BOOL(0, "full", &check_full, N_("also consider packs and
alternate objects")),
+       OPT_BOOL(0, "checksum-index", &fsck_opt_checksum_index,
+                N_("validate the checksum at the end of the index file")),
        OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check
only connectivity")),
        OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
        OPT_BOOL(0, "lost-found", &write_lost_and_found,
@@ -681,6 +684,9 @@ int cmd_fsck(int argc, const char **argv, const
char *prefix)
        if (check_strict)
                fsck_obj_options.strict = 1;

+       if (fsck_opt_checksum_index)
+               force_core_checksum_index = 1;
+
        if (show_progress == -1)
                show_progress = isatty(2);
        if (verbose)
