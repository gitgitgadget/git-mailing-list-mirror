Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12BDC1FAF4
	for <e@80x24.org>; Mon,  6 Feb 2017 02:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbdBFC1K (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 21:27:10 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33485 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbdBFC1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 21:27:09 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so7695044pgd.0
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 18:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7497xcToqrsbqYRWFtcVj8nXD+u6QuNxnxvDHufD214=;
        b=MmBW+kWQo4cAVrZTeK4w+C0aXdzDHwuwh8uELvRIFJW0NVga8AqbHNiFpfUqUIC0Q7
         8SSzB1Yhh2pAWq27qLnNdcNPPzlaSHO2F7VzGmBHl0z9j6a9l6twIbyloPEMuMfX0YsZ
         zEi/EcGOSEm+FuOiAdaVbUvMmV9kIWElEj8qLiZ84dhtqU0B33gdoBD7g8SphIiTzNj3
         c+SNyKZdjXf6W4pnGf0GX1vuD10TlxiYnC3GmQFMVsNcKa5sLmIKQPwoucwD1GWwOSxG
         oz+3hhAZorhpS99xNTgs22qkHIZjfLtDsY1BVGmm6YpuYjBkT4/sDeNvoCtEJwYJ3JAk
         Vg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7497xcToqrsbqYRWFtcVj8nXD+u6QuNxnxvDHufD214=;
        b=Dyb0OxuK46SAWnmvTwQp86Dy81O3N5EqfyqRHULPoKsfgHyqhf243A8Ddq6WH0oyMa
         EhMxU3YwhYdhlxf0/sxe+rslT/68eXpSfqOmyslT8hd1fabY81MRv068m3MzBXJVNDMU
         miTN+E/XjGBp4RIuc5IxJq3/JMg9e6IGsyS2SXgc6eSI4A/O1VZgHtpiAU1I/XrfTpFA
         2pH5hexmPrVPM9vWckc3GtJce8dWWf5dO9W6/Re7IHtUhuYIRHC6VptMwdQwuMR7TZ4x
         WF7fwpgPHeLOLb1Gd5sG/GED3GxvIX4UYZnLfaLks5gfNQpTIXTqVNkRfvQj/Gqemz5Z
         Zyog==
X-Gm-Message-State: AIkVDXLlZDshUoly7/0tE+i+kZgQdZAAv4NONwsr0qQeLJIRn4oZcVdZiwGL0SiBMBMpHw==
X-Received: by 10.84.170.195 with SMTP id j61mr14134849plb.26.1486348028920;
        Sun, 05 Feb 2017 18:27:08 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id m136sm84705822pga.22.2017.02.05.18.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Feb 2017 18:27:08 -0800 (PST)
Date:   Mon, 6 Feb 2017 02:27:05 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pranit.bauva@gmail.com, Matthieu.Moy@imag.fr,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous
 branch"
Message-ID: <20170206022705.GA3323@ubuntu-512mb-blr1-01.localdomain>
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
 <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,
On Sun, Feb 05, 2017 at 04:15:03PM -0800, Junio C Hamano wrote:
> Siddharth Kannan <kannan.siddharth12@gmail.com> writes:
> 
> > @@ -158,6 +158,51 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
> >
> >  	if (quiet)
> >  		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
> > +
> > +	/*
> > +	 * Check if any argument has a "-" in it, which has been referred to as a
> > +	 * shorthand for @{-1}.  Handles methods that might be used to list commits
> > +	 * as mentioned in git rev-list --help
> > +	 */
> > +
> > +	for(i = 0; i < argc; ++i) {
> > +		if (!strcmp(argv[i], "-")) {
> > +			argv[i] = "@{-1}";
> > +		} else if (!strcmp(argv[i], "^-")) {
> > +			argv[i] = "^@{-1}";
> > +		} else if (strlen(argv[i]) >= 4) {
> > +
> > +	...
> > +		}
> > +	}
> > +
> >  	argc = setup_revisions(argc, argv, rev, opt);
> 
> "Turn '-' to '@{-1}' before we do the real parsing" can never be a
> reasonable strategy to implement the desired "'-' means the tip of
> the previous branch" correctly.  To understand why, you only need to
> imagine what happens to this command:
> 
>     $ git log --grep '^-'
> 
> Turning it into "git log --grep '^@{-1}'" obviously is not what the
> end-users want, so that is an immediate bug in the version of Git
> with this patch applied.
> 
> Even if this were not a patch for the "log" command but for some
> other command, a change with the above approach is very much
> unwelcome, even if that other command does not currently have any
> option that takes arbitrary string the user may want to specify
> (like "find commit with a line that matches this pattern" option
> called "--grep" the "log" command has).  That is because it will
> make it impossible to enhance the command by adding such an option
> in the future.  So it is also adding the problems to future
> developers (and users) of Git.

Understood!
> 
> A correct solution needs to know if the argument is at the position
> where a revision (or revision range) is expected and then give the
> tip of the previous branch when it sees "-" (and other combinations
> this patch tries to cover).  In other words, the parser always knows
> what it is parsing, and if and only if it is parsing a rev, react to
> "-" and think "ah, the user wants me to use the tip of the previous
> branch".

Ah, okay. I will do another one of the suggestions as my micro project
but continue to look into this part of the code and try to find the
right place to write the code to implement the present patch.

> 
> But the code that knows that it expects to see a revision already
> exists, and it is the real parser.  In the above snippet,
> setup_revisions() is the one that does the real parsing of argv[].
> The code there knows when it wants to see a rev, and takes argv[i]
> and turns into an object to call add_pending_object().  That codepath
> may not yet know that "-" means the tip of the previous branch, and
> that is where the change needs to go.
> 
> Such a properly-done update does not need to textually replace "-"
> with "@{-1}" in argv[]; the codepath is where it understands what
> any textual representation of a rev the user gave it means, and it
> understands "@{-1}" there.  It would be the matter of updating it to
> also understand what "-" means.
> 
> A correct solution will be a lot more involved, of course, and I
> think it will be larger than a reasonable microproject for people
> new to the codebase.
> 
> I didn't check the microproject ideas page myself; whether it says
> that turning "-" unconditionally to "@{-1}" is a good idea, or it
> hints that supporting "-" as "the tip of the previous branch" in
> more commands is a reasonable byte-sized microproject, I think it is
> misleading and misguided.  Can somebody remove that entry so that we
> won't waste time of new developers (which would lead to discouraging
> them)?  Thanks.

Thanks a lot for writing this detailed reply! I will definitely take
into account all of the points mentioned here in the future patches I
send.

- Siddharth Kannan
