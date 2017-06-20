Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4DF1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbdFTChp (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:37:45 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35902 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdFTCho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:37:44 -0400
Received: by mail-oi0-f68.google.com with SMTP id g14so10903130oib.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pLEFv2UfLYxjzeoy9PZvCD5wFw0qNVgx+++fPOYCMuU=;
        b=n/nXGHjDkUFHNcc9c2G9UoXt2Jxv+0S9Ic8DCoC2zLKrfn1ABkB1k1BX5wmeUqVvUp
         cbfjTpzjbsoyMrI88P2mndqOo3jctbb9KWsTUvzHW9WjFO6xJvnL3m0TElhwvjTzMJHF
         s+MftfCGbLLnylvb+euCYJ4M2bv1gnve7XdJaICDHSzmGwgcM8GsUJ0fo0r3Ey5kd1BI
         VyRbdoSwD3u3QidAhAwEge9MZ0yEpgPVy+VX5wvpQsArtzr2A8B5bE4e1RbMp07t7K6K
         wQV5BVaVhxzrb86HzdM+nsS9YELiwHQ9khpxx1VKqRr3u54xY9VFgAMKt6pXogpuRhWU
         275w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pLEFv2UfLYxjzeoy9PZvCD5wFw0qNVgx+++fPOYCMuU=;
        b=ZtMCECvoTuZI3rIkteStRIAr3kwytCF68wby9OFSRwQQHPd6h2gjvl1hC8cLiAl1Lj
         cttQcJdQ9wDclnxLEsTcCqAuJWMSgmeXRiwFedrZK2d/fE6AYKeuArlKD2AO/Im8KSyA
         4WkMNVInCjN7Vv12IRy78DoJk14kS2uRYiOvtfU3gm9rXPnPzwkgV4Hjkoinn3Rn/0Ro
         QKrBSMMPsR/BY53G+HED/45xfw3k4Lg/KTj5QV9rugH+hDqRdIIKLVh2zrErpMfZ5U4i
         bcPqZXMupeL0yKJDZcoPJDRmwury9Au1F1zY+BAyFy5Xz02s/H5J+wCutcezsHZ078tW
         eDug==
X-Gm-Message-State: AKS2vOwfa53idK3FoekPxFK3SRqWddQvpu91xJ3XvPRKYvQRIbEcGkJ3
        KAKykQYhD1/QqzbwYz2+gLA8JEqgFw==
X-Received: by 10.202.55.195 with SMTP id e186mr14363364oia.13.1497926263415;
 Mon, 19 Jun 2017 19:37:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.36.136 with HTTP; Mon, 19 Jun 2017 19:37:22 -0700 (PDT)
In-Reply-To: <20170611212739.GA7737@hank>
References: <20170608005535.13080-1-joel@teichroeb.net> <20170608005535.13080-6-joel@teichroeb.net>
 <20170611212739.GA7737@hank>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Mon, 19 Jun 2017 19:37:22 -0700
X-Google-Sender-Auth: ZxbGYUqDSCnqtJfTqzdxLuTeO8s
Message-ID: <CA+CzEk9i8H2BAUrL854WJELCTa-O1ONMWa0uOcTsW=WxnB_22Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2017 at 2:27 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +
>> +int cmd_stash(int argc, const char **argv, const char *prefix)
>> +{
>> +     int result = 0;
>> +     pid_t pid = getpid();
>> +
>> +     struct option options[] = {
>> +             OPT_END()
>> +     };
>> +
>> +     git_config(git_default_config, NULL);
>> +
>> +     xsnprintf(stash_index_path, 64, ".git/index.stash.%d", pid);
>> +
>> +     argc = parse_options(argc, argv, prefix, options, git_stash_usage,
>> +             PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
>> +
>> +     if (argc < 1) {
>> +             result = do_push_stash(NULL, prefix, 0, 0, 0, 0, NULL);
>> +     } else if (!strcmp(argv[0], "list"))
>> +             result = list_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "show"))
>> +             result = show_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "save"))
>> +             result = save_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "push"))
>> +             result = push_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "apply"))
>> +             result = apply_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "clear"))
>> +             result = clear_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "create"))
>> +             result = create_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "store"))
>> +             result = store_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "drop"))
>> +             result = drop_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "pop"))
>> +             result = pop_stash(argc, argv, prefix);
>> +     else if (!strcmp(argv[0], "branch"))
>> +             result = branch_stash(argc, argv, prefix);
>> +     else {
>> +             if (argv[0][0] == '-') {
>> +                     struct argv_array args = ARGV_ARRAY_INIT;
>> +                     argv_array_push(&args, "push");
>> +                     argv_array_pushv(&args, argv);
>> +                     result = push_stash(args.argc, args.argv, prefix);
>
> This is a bit of a change in behaviour to what we currently have.
>
> The rules we decided on are as follows:
>
>  - "git stash -p" is an alias for "git stash push -p".
>  - "git stash" with only option arguments is an alias for "git stash
>    push" with those same arguments.  non-option arguments can be
>    specified after a "--" for disambiguation.
>
> The above makes "git stash -*" a alias for "git stash push -*".  This
> would result in a change of behaviour, for example in the case where
> someone would use "git stash -this is a test-".  In that case the
> current behaviour is to create a stash with the message "-this is a
> test-", while the above would end up making git stash error out.  The
> discussion on how we came up with those rules can be found at
> http://public-inbox.org/git/20170206161432.zvpsqegjspaa2l5l@sigill.intra.peff.net/.

I don't really like the "argv[0][0] == '-'" logic, but it doesn't seem
to have the flaw you pointed out:
$ ./git stash -this is a test-
error: unknown switch `t'
usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
[...]

I'm not sure this is the best possible error message, but it's just as
useful as the message from the old version.

>
>> +                     if (!result)
>> +                             printf_ln(_("To restore them type \"git stash apply\""));
>
> In the shell script this is only displayed when the stash_push in the
> case where git stash is invoked with no arguments, not in the push
> case if I read this correctly.  So the two lines above should go in
> the (argc < 1) case I think.

I think it's correct as is. One of the tests checks for this string to
be output, and if I move the line, the test fails.



I agreed with all the other points you raised, and they will be fixed
in my next revision.
