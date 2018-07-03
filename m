Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34A41F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 23:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeGCXPm (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 19:15:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:46730 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeGCXPl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 19:15:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id e23-v6so782081ywe.13
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E5et0yBInDhSrtYbiQO7cALGzEwzwnSLoqZnxHDEup0=;
        b=GgXHh/qvfmtrmGskfwwF2eE9f0PBtR97H5og+Dmx4y5+bdQVXPYIyilRxMX9NWm3/E
         i26Hpo7RjxKm5J7PQvASxbpZdINoMw4yoLz0z8kVtmgVOZIvrQc3jeuzMam5Qke/SS32
         8L5ELqQIR7/INKQQN8ZCqKtipjXjXfB6mW/22VZ5O4SeEKFTlvJv9TL6uPvDHjyx4p6C
         NU9J+5mT8wzHU5QnezaQugZ+gUyPW9QEV3wOWLDOKO72mx0uWngSWxisJxm48ntY4Zp7
         K/TFNNKNAoN4qF7ZEuIUl56Q9hn0oHdTBB4AzAvtjndbbJmC+Suu3sD9FoUuYODhqOJq
         9UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E5et0yBInDhSrtYbiQO7cALGzEwzwnSLoqZnxHDEup0=;
        b=So7HV70YYy3YSog4xsaB4rDv8nfl3whdReQQiSGI5e0i7hkWsKg2MtNWyZzrzueYc6
         m4BTe3kTYgiOjuVRGxeyBqyj0WY4VJbGI1H+5QIrHtSojMQ/J8850jWZ8+/mjZj9OOfI
         xiqa5qhBGHSwDNAedN9S9OZicZASTK9qmy2NsZtzDo34wx5yP1aRnqDYR0DpzBBaKzZc
         uorE61XLDt/Qcv53UQLBxOs1FYDrNL8pRvT8upZROjc7EZgTbg7e+kV96GA5YM7OAQtk
         9B48PYbaV5vNDaBPmVy5+BfFf+9V7+dPjOeJPLvNwsSTlWXzGsFjcILZmAmFfrrLEM+Q
         mPFA==
X-Gm-Message-State: APt69E2KrLqDJy89DLSVjEL9jwkj+v1cFGPmuWcehPOSsCAql/rKHqXC
        tuy+gUjYo5bADv/fU4lX931W70qe
X-Google-Smtp-Source: AAOMgpehxMoh5EdFHIEkZy8br8bhsk1cNhdJD+MVLXZPQU2czmxMx4Z5nov0j07g9WQXrWw6AoRaRA==
X-Received: by 2002:a81:23d7:: with SMTP id j206-v6mr14282766ywj.100.1530659740073;
        Tue, 03 Jul 2018 16:15:40 -0700 (PDT)
Received: from [10.20.131.237] ([70.63.112.210])
        by smtp.gmail.com with ESMTPSA id w64-v6sm824500ywe.46.2018.07.03.16.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:15:39 -0700 (PDT)
Subject: Re: [PATCH 1/3] ls-tree: make <tree-ish> optional
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20180703035802.24060-1-jyn514@gmail.com>
 <CAPig+cT9XB-nJFm0rD9RckBzcbk9vh8Hz=3XOA-HA-JoXssG_A@mail.gmail.com>
From:   Joshua Nelson <jyn514@gmail.com>
Message-ID: <26b538bd-df59-d9a6-460d-0b1042b35250@gmail.com>
Date:   Tue, 3 Jul 2018 19:15:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT9XB-nJFm0rD9RckBzcbk9vh8Hz=3XOA-HA-JoXssG_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 07/03/2018 03:15 AM, Eric Sunshine wrote:
> Thanks for contributing to Git. As this seems to be your first
> submission to the project, don't be alarmed by the extent and nature
> of the review comments. They are intended to help you polish the
> submission, and are not meant with ill-intent.
> 
> On Mon, Jul 2, 2018 at 11:58 PM Joshua Nelson <jyn514@gmail.com> wrote:
>> use syntax similar to `git-checkout` to make <tree-ish> optional for
>> `ls-tree`. if <tree-ish> is omitted, default to HEAD. infer arguments as
>> follows:
> 
> Nit: Capitalize first word of each sentence.
> 
> This commit message explains what the patch changes (which is a good
> thing to do), but it's missing the really important explanation of
> _why_ this change is desirable. Without such justification, it's
> difficult to judge if such a change is worthwhile. As this is a
> plumbing command, people may need more convincing (especially if other
> plumbing commands don't provide convenient defaults like this).
> 
>> 1. if args start with --
>>         assume <tree-ish> to be HEAD
>> 2. if exactly one arg precedes --, treat the argument as <tree-ish>
>> 3. if more than one arg precedes --, exit with an error
>> 4. if -- is not in args
>>         a) if args[0] is a valid <tree-ish> object, treat is as such
>>         b) else, assume <tree-ish> to be HEAD
>>
>> in all cases, every argument besides <tree-ish> is treated as a <path>
> 
> This and the other patches are missing your Signed-off-by: (which
> should be placed right here).
> 
> The three patches of this series are all directly related to this one
> change. As such, they should be combined into a single patch. (At the
> very least, 1/3 and 2/3 should be combined; one could argue that 3/3
> is lengthy enough to make it separate, but that's a judgment call.)
> 
> Now, on to the actual code...
> 
>> diff --git builtin/ls-tree.c builtin/ls-tree.c
>> @@ -163,10 +163,39 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>>             ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
>>                 ls_options |= LS_SHOW_TREES;
>>
>> +       const char *object;
>> +       short initialized = 0;
> 
> This project frowns on declaration-after-statement. Move these to the
> top of the {...} block where other variables are declared.
> 
> Why use 'short'? Unless there's a very good reason that this needs to
> be a particular size, you shouldn't deviate from project norm, which
> is to use the natural word size 'int'.
> 
> 'initialized' is too generic, thus isn't a great name.
> 
>>         if (argc < 1)
>> -               usage_with_options(ls_tree_usage, ls_tree_options);
>> -       if (get_oid(argv[0], &oid))
>> -               die("Not a valid object name %s", argv[0]);
>> +               object = "HEAD";
>> +       else {
>> +               /* taken from checkout.c;
>> +                * we have a simpler case because we never create a branch */
> 
> Style: Multi-line comments are formatted like this:
> 
>     /*
>      * Gobble
>      * wobble.
>      */
> 
> However, this comment doesn't belong in the code, as it won't be
> particularly helpful to anyone reading the code in the future. This
> sort of note would be more appropriate in the commit message or, even
> better, in the commentary section just below the "---" lines following
> your Signed-off-by:.

I wasn't aware I could put comments in email generated by
git-send-email, thanks for the tip :)

> 
>> +               short dash_dash_pos = -1, i = 0;
> 
> Same question about why you used 'short' rather than 'int' (especially
> as 'dash_dash_pos' is declared 'int' in checkout.c).
> 
> Is there a good reason why you initialize 'i' in the declaration
> rather than in the for-loop? A _good_ reason to do so in the for-loop
> is that doing so makes the for-loop more idiomatic, reduces cognitive
> load on readers (since they don't have to chase down the
> initialization), and safeguards against someone adding new code
> between the declaration and the for-loop which might inadvertently
> alter the initial value.

No good reason, it happened to end up that way after I finished
debugging. I've changed it to a more conventional declaration.

> 
>> +               for (; i < argc; i++) {
>> +                       if (!strcmp(argv[i], "--")) {
>> +                               dash_dash_pos = i;
>> +                               break;
>> +                       }
>> +               }
>> +               if (dash_dash_pos == 0) {
>> +                       object = "HEAD";
>> +                       argv++, argc++;
> 
> 'argc' is never accessed beyond this point, so changing its value is
> pointless. Same observation for the 'else' arms. (And, even if there
> was a valid reason to modify 'argc', I think you'd want to be
> decrementing it, not incrementing it, to show that you've consumed an
> argument.)
> 
>> +               } else if (dash_dash_pos == 1) {
>> +                       object = argv[0];
>> +                       argv += 2, argc += 2;
>> +               } else if (dash_dash_pos >= 2)
>> +                       die(_("only one reference expected, %d given."), dash_dash_pos);
>> +               else if (get_oid(argv[0], &oid)) // not a valid object
> 
> Style: Use /* comments */ in this codebase, not // comments.
> 
>> +                       object = "HEAD";
>> +               else {
>> +                       argv++, argc++;
>> +                       initialized = 1;
>> +               }
>> +       }
>> +
>> +       if (!initialized) // if we've already run get_oid, don't run it again
>> +               if (get_oid(object, &oid))
>> +                       die("Not a valid object name %s", object);
> 
> Can't you accomplish the same without the 'initialized' variable by
> instead initializing 'object' to NULL and then checking it here?

I think my code wasn't very clear here - 'initialized' checks if 'oid'
has been initialized, not 'object'. AFAIK, structs can't be initialized
to NULL, but my C is not very good so I'd be interested to learn otherwise.

I'm writing a new patch with variable names that are more descriptive.

> 
>     if (object && get_oid(object, &oid))
>         die(_("not a valid object name: %s", object);
> 
