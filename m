Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81DC71FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbcHWRet (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:34:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36303 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbcHWRes (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:34:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so18999112wmf.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p3ucyzunziR3fjcuzbw5t85m9MsDEAXXOlx3rg3Vj+o=;
        b=BdmAuqSr7F8T8ENI0HkuiDMV/Aizu8dQZ/jigC4qGOszjlkJ86t7eISuX2IqdIo8Nd
         xnGl2gJvIuMkTYJPV7GB7qE2n3d5fMER7m7E9ysUqMZRRD5CqB67mNZG8JrtM7w0RD6O
         xLcZOfiFXSy6asdBXDLk76STKzhhLWM/jtEMX5jexzDfmMAwzfhTbttfO6IvG7VMgfHR
         LUseEqQnCEKywh/TwDS+/e50xt1dY/H9M2gfEEALtUjZoqyPmbgOm5K8WOW2gFhZv84j
         H5/fZ8q4Vb7wIJGB4ZOAbG4YPR8Vb4BmwabUtyakAISIzeQ9k/qGrCA3D1fN87ypUKtJ
         SFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p3ucyzunziR3fjcuzbw5t85m9MsDEAXXOlx3rg3Vj+o=;
        b=UWPuj5MrtjT5aeTTqYp/PBtkJoJPWM3Ru0J6x1UyoAk6aweNf8yM0CU1+o1gPGLmQK
         v4yIPoTnA0xD8yUc1l2h5KT1VHGP8JzvKYkeUViTMMiDRZkoko/rOkjD7oQY26ouqdr4
         pS/rTVzYlGkfPwtAsnCAxsGiZbpjK4cQEJXb0McdRuopURnkdKC45jbI26URPEiiTBiF
         4IbMqSOPcCCnm1hknRp3w9gDgfXBGL41/pjOGDZxbgoQZFtLnWElWT3+Mz9A285HRCcT
         a6FoaFoVExRffmgXU4j1gvubqO5sBREQhwnWj1K2dK7OdA/JRKOd5TdijYBuBsUKt+ME
         UhQQ==
X-Gm-Message-State: AEkooutrc/rAq2kxYZPZllc53ctzUhSoEg2NUZrWTkYgg5ZzjnVLRM9AVdtwfqoGT9L7RG2b1l+3tgAw3W1DhQ==
X-Received: by 10.28.157.214 with SMTP id g205mr20071884wme.34.1471973687040;
 Tue, 23 Aug 2016 10:34:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.230.154 with HTTP; Tue, 23 Aug 2016 10:34:46 -0700 (PDT)
In-Reply-To: <xmqqy43t6ek8.fsf@gitster.mtv.corp.google.com>
References: <20160816162030.27754-1-ralf.thielow@gmail.com>
 <20160818185719.4909-1-ralf.thielow@gmail.com> <20160818185719.4909-2-ralf.thielow@gmail.com>
 <20160818185719.4909-3-ralf.thielow@gmail.com> <xmqqy43t6ek8.fsf@gitster.mtv.corp.google.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Tue, 23 Aug 2016 19:34:46 +0200
Message-ID: <CAN0XMOJCCaOCuTejgmiAYUDMJfdMEpv5ZATLrN4ruCaGK=FjnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] help: make option --help open man pages only for Git commands
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Joseph Musser <me@jnm2.com>,
        Philip Oakley <philipoakley@iee.org>,
        John Keeping <john@keeping.me.uk>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for being late in responding. It's been busy days.

2016-08-18 21:51 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
> The same comment applies to 1/2, too, in that the word "command"
> will be interpreted differently by different people.  For example,
> "git co --help" and "git help co" would work, with or without 1/2 in
> place when you have "[alias] co = checkout", so we are calling "Git
> subcommands that we ship, custom commands 'git-$foo' the users have
> in their $PATH, and aliases the users create" collectively "command".
>
> As long as the reader understands that definition, both the log
> messages of 1/2 and 2/2 _and_ the updated description for "git help"
> we have in 1/2 are all very clear.  I do not care too much about the
> commit log message, but we may want to think about the documentation
> a bit more.
>
> Here is what 1/2 adds to "git help" documentation:
>
>     +Note that `git --help ...` is almost identical to `git help ...` because
>     +the former is internally converted into the latter with option --command-only
>     +being added.
>
>      To display the linkgit:git[1] man page, use `git help git`.
>
>     @@ -43,6 +44,10 @@ OPTIONS
>             Prints all the available commands on the standard output. This
>             option overrides any given command or guide name.
>
>     +-c::
>     +--command-only::
>     +   Display help information only for commands.
>     +
>
> First, I do not think a short form is unnecessary; the users are not
> expected to use that form, once they started typing "git help...".
> If we flip the polarity and call it --exclude-guides or something,
> would it make it less ambiguous?
>

Sure.  Since "command" is understood as both Git command
and guide in this context, the name --exclude-guides would describe the
behaviour of that option less ambiguous.  I'll rename it.

>> This breaks "git <concept> --help" while "git help <concept>" still works.
>
> I wouldn't call that a breakage; "git everyday --help" shouldn't
> have worked in the first place.  It did something useful merely by
> accident ;-).
>

OK, I'll call it "doesn't work anymore".

>> diff --git a/git.c b/git.c
>> index 0f1937f..2cd2e06 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -528,10 +528,23 @@ static void handle_builtin(int argc, const char **argv)
>>       strip_extension(argv);
>>       cmd = argv[0];
>>
>> -     /* Turn "git cmd --help" into "git help cmd" */
>> +     /* Turn "git cmd --help" into "git help --command-only cmd" */
>>       if (argc > 1 && !strcmp(argv[1], "--help")) {
>> +             struct argv_array args;
>> +             int i;
>> +
>>               argv[1] = argv[0];
>>               argv[0] = cmd = "help";
>> +
>> +             argv_array_init(&args);
>> +             for (i = 0; i < argc; i++) {
>> +                     argv_array_push(&args, argv[i]);
>> +                     if (!i)
>> +                             argv_array_push(&args, "--command-only");
>> +             }
>> +
>> +             argc++;
>> +             argv = argv_array_detach(&args);
>>       }
>>
>>       builtin = get_builtin(cmd);
>
> The code does this after it:
>
>     if (builtin)
>                 exit(run_builtin(...));
>
> and returns.  If we didn't get builtin, we risk leaking args.argv
> here, but we assume argv[0] = cmd = "help" is always a builtin,
> which I think is a safe assumption, so the code is OK.  Static
> checkers that are only half intelligent may yell at you for not
> releasing the resources, though.  I wonder if it is worth doing
>
>     static void handle_builtin(int argc, const char **argv)
>     {
>             struct argv_array args = ARGV_ARRAY_INIT;
>             ...
>             if (argc > 1 && !strcmp(argv[1], "--help")) {
>                     ...
>                     argv = args.argv;
>             }
>             builtin = get_builtin(cmd);
>             if (builtin)
>                     exit(run_builtin(...));
>             argv_array_clear(&args);
>     }
>
> to help unconfuse them.
>

I'll do it this way.

Thanks!
