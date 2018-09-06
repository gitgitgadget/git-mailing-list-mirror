Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126B51F404
	for <e@80x24.org>; Thu,  6 Sep 2018 14:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeIFShZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 14:37:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36045 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbeIFShZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 14:37:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so2473312wrt.3
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UhPDoYNMnmRzUBoDsO3uOMP98n972xH9qJXSsv91OLI=;
        b=FRoUAbsuE4DqTt1w30fgJC8sRcXFevELY4w0P+o+FevQfzIofWuivxFYyzKLMBOQJ8
         NH1vBIYRetYrDIqDz8Rw0PtHiyyVVJSBvJX8ETmM3/XVXDnIM9NtODEVtutlnMgAs5uH
         ZxKS/or60Z2yrtCaDT60WAunyzIxYmiRaZfB9HNrjDIhjb7TbjLGZ5pLKKJdS6vqj4bO
         EgSYXJmy1Z8EJjaLphWjnvwqhWj9HoaIY11dTgxgcdmMJlh9b1iJifTS3sQAuaz5jygk
         B8pRxYk60gqPreRrIEXO37M5QoUJFe4HUHu+4EbloUecglJ1/fpxyKHRa0GL2lCrOQHr
         QcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UhPDoYNMnmRzUBoDsO3uOMP98n972xH9qJXSsv91OLI=;
        b=UIUH9RZclkQCi+93jHRgoXtBlJvEkOgymVbGx/PhNAu+DjRwJwlgR4S3xGSFnPa25M
         XXAKs+wW9PHxrfCkI6V/VDMp96MVKRc0HzPvOlXa6QNMI7pB+lpieKiAjCAdRoPDnGEe
         6K2oiL7GHSaQtm6uggD5J74XbIyYX4ybiqnAkFcERkCylDzIGCtRZkTdiMjz6VWYO1Mi
         M90bhozYeNu6kMppfYBV+xXcm5XAuNOk7hmFr3f7Ey8pfCSCLJEEUq1PlyIVtLtAFBNI
         Y2WHvPkBVIy4Bd7s/HSGmm2aPwZUuokyXvxBQhQH1+O2NWIUeNbFcI6yG+WfZaEA4djA
         qKfg==
X-Gm-Message-State: APzg51AqSIsSy7ti0+T7QGdM7uXUP0Kyn/UTt+xf3ISpADnWfn1omRGm
        BpuvNjVMDfM23x/1vu3+j+g=
X-Google-Smtp-Source: ANB0VdYQZssVL2GbL2/K4+dfW2iI3ET6Mk4gLyA5ctCqYjb8raBoTer2RFZmvISZt3GSSNtB10wr+w==
X-Received: by 2002:a5d:4a44:: with SMTP id v4-v6mr2500619wrs.278.1536242501346;
        Thu, 06 Sep 2018 07:01:41 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id c9-v6sm4289365wrt.77.2018.09.06.07.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 07:01:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        pclouds@gmail.com
Subject: Re: [PATCH v3] Allow aliases that include other aliases
References: <20180905085427.4099-1-timschumi@gmx.de> <20180906101658.1865-1-timschumi@gmx.de>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180906101658.1865-1-timschumi@gmx.de>
Date:   Thu, 06 Sep 2018 16:01:39 +0200
Message-ID: <87pnxqrags.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, Tim Schumacher wrote:

> Aliases can only contain non-alias git commands and their
> arguments, not other user-defined aliases. Resolving further
> (nested) aliases is prevented by breaking the loop after the
> first alias was processed. Git then fails with a command-not-found
> error.
>
> Allow resolving nested aliases by not breaking the loop in
> run_argv() after the first alias was processed. Instead, continue
> incrementing `done_alias` until `handle_alias()` fails, which means that
> there are no further aliases that can be processed. Prevent looping
> aliases by storing substituted commands in `cmd_list` and checking if
> a command has been substituted previously.
>
> While we're at it, fix a styling issue just below the added code.
> ---
>  git.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/git.c b/git.c
> index c27c38738..64f5fbd57 100644
> --- a/git.c
> +++ b/git.c
> @@ -674,6 +674,7 @@ static void execv_dashed_external(const char **argv)
>  static int run_argv(int *argcp, const char ***argv)
>  {
>  	int done_alias = 0;
> +	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
>
>  	while (1) {
>  		/*
> @@ -691,17 +692,23 @@ static int run_argv(int *argcp, const char ***argv)
>  		/* .. then try the external ones */
>  		execv_dashed_external(*argv);
>
> -		/* It could be an alias -- this works around the insanity
> +		if (string_list_has_string(&cmd_list, *argv[0]))
> +			die(_("loop alias: %s is called twice"), *argv[0]);
> +
> +		string_list_append(&cmd_list, *argv[0]);
> +
> +		/*
> +		 * It could be an alias -- this works around the insanity
>  		 * of overriding "git log" with "git show" by having
>  		 * alias.log = show
>  		 */
> -		if (done_alias)
> -			break;
>  		if (!handle_alias(argcp, argv))
>  			break;
> -		done_alias = 1;
> +		done_alias++;
>  	}
>
> +	string_list_clear(&cmd_list, 0);
> +
>  	return done_alias;
>  }

[In my just-sent
https://public-inbox.org/git/87r2i6rbiy.fsf@evledraar.gmail.com/ I
should have said "the v3 thread"]

Thanks for working on this, comments:

If we don't have some test for these sort of aliasing loops that fails
now, we really should add that in a 1/2 and fix it in this patch in 2/2.

This error reporting is quite bad, consider:

    [alias]
        foo = bar
        bar = baz
        baz = foo

We then say:

    $ ./git --exec-path=$PWD foo
    fatal: loop alias: bar is called twice

That makes sense from an implementaion perspective, i.e. we lookup "bar"
twice. But let's do better. If I have aliase like:

    a = b
    b = c
    c = d
    d = e
    e = c

It should be telling me that my "e" expansion looped back to the "c = d"
expansion. Here's a patch to implement that, feel free to either squash
it in with my Signed-Off-By, or tacked onto a v4 version of this,
whichever you think makes sense:

diff --git a/git.c b/git.c
index 64f5fbd572..38f1033e52 100644
--- a/git.c
+++ b/git.c
@@ -692,8 +692,64 @@ static int run_argv(int *argcp, const char ***argv)
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);

-		if (string_list_has_string(&cmd_list, *argv[0]))
-			die(_("loop alias: %s is called twice"), *argv[0]);
+		if (string_list_has_string(&cmd_list, *argv[0])) {
+			struct strbuf sb = STRBUF_INIT;
+			int i, seen_at_idx = -1;
+
+			/*
+			 * Find the re-entry point for the alias
+			 * loop. TODO: There really should be a
+			 * "return the index of the first matching"
+			 * helper in string-list.c.
+			 */
+			for (i = 0; i < cmd_list.nr; i++) {
+				if (!strcmp(*argv[0], cmd_list.items[i].string))
+					seen_at_idx = i;
+			}
+			assert(seen_at_idx != -1);
+
+			for (i = 1; i < cmd_list.nr; i++) {
+				if (i - 1 == seen_at_idx)
+					/*
+					 * TRANSLATORS: This is a the
+					 * re-enttry point in the list
+					 * printed out by the "alias
+					 * loop" message below.
+					 */
+					strbuf_addf(&sb, _("    %d. %s = %s <== The re-entry point in the loop\n"),
+						    i,
+						    cmd_list.items[i - 1].string,
+						    cmd_list.items[i].string);
+				else
+					/*
+					 * TRANSLATORS: This is a
+					 * single item in the list
+					 * printed out by the "alias
+					 * loop" message below.
+					 */
+					strbuf_addf(&sb, _("    %d. %s = %s\n"),
+						    i,
+						    cmd_list.items[i - 1].string,
+						    cmd_list.items[i].string);
+			}
+			/*
+			 * TRANSLATORS: This is the last item in the
+			 * list printed out by the "alias loop"
+			 * message below.
+			 */
+			strbuf_addf(&sb, _("    %d. %s = %s <== This is where the loop started!"),
+				    i,
+				    cmd_list.items[i - 1].string,
+				    *argv[0]);
+			/*
+			 * TRANSLATORS: The %s here at the end is
+			 * going to be a list of aliases as formatted
+			 * by the messages whose comments mention
+			 * "alias loop" above.
+			 */
+			die(_("alias loop: When expanding the alias '%s' we ran into a loop:\n%s"),
+			    cmd_list.items[0].string, sb.buf);
+		}

 		string_list_append(&cmd_list, *argv[0]);

Now we'll print errors like:

    $ ./git --exec-path=$PWD a
    fatal: alias loop: When expanding the alias 'a' we ran into a loop:
        1. a = b
        2. b = c
        3. c = d <== The re-entry point in the loop
        4. d = e
        5. e = c <== This is where the loop started!

Or, in the much simpler case of foo = bar; bar = foo:

    $ ./git --exec-path=$PWD foo
    fatal: alias loop: When expanding the alias 'foo' we ran into a loop:
        1. foo = bar <== The re-entry point in the loop
        2. bar = foo <== This is where the loop started!

I haven't tested this much, so maybe there's some edge cases I haven't
thought of / bugs in this reporting code, but hey, that's what the tests
I suggested are for :)

It's a lot more verbose, but I think it's worth it to produce better
error messages.
