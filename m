Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B58207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932843AbcILTaJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:30:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32848 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbcILTaF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:30:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so15045270wme.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oqspj7tq9hClWANNYUgEKdg561wtsRs4o8JeBWB/NDU=;
        b=lCFbY17hhBOFDjcjjWoNnS2o5jxTP+/WrM5uJGwZoLoAWc5QuUBHxwdmbOagg7Z7GM
         /MjMC+oUv1CVzPngRLtf+X9ZxkvGl01KBck0gZLaf2h1/LBfVxgQMfLzrfUEh/KeSEVJ
         m5ZdSHTURTaq6ih4Jqyun5QSU3luIrKq1DiPa+btmKxh9KPmk1zAMM/+ryb9Xg4JXTfz
         RXcZBKK4OTOtnO4ZNHFfW0rsVX7Sxay3NfW6haH7cmuLnxLt2caBhyf3BNKA6hYE4eZW
         ygEQpOC+oF1NmtkMBWw3RbGd4ffHoIjNC2WYNlTg+JZcQH+V6QUDbzzf3uqeDi7+ztcN
         kjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oqspj7tq9hClWANNYUgEKdg561wtsRs4o8JeBWB/NDU=;
        b=iTtWrYnj1pVJg2bRfW1XUPLAbh6aysM4CULcjk3rfJ3gLSwxFgbO6BOJ8O9wGWtnct
         +deSmrxh4gvNccchPW3y+1taRfviUIzarJ9au1CNkE2H9h4NKusnlRhxIFhpatZtmzIc
         0LrpEfnuOYyYVIRwdgW8flwwZGqOCOJBMMHr+N0lT5V1fVm4JftYtjW9NgX5VDJbcZg0
         7uqLEaVXPN1EpDsgmdugGQ4nRAXSYXF1hwMHfw0Jtnt7607Kxw3oGaTn8X8YrR0uPzaQ
         V/XpmiTW9it6Xdo06bLqKFH2qEHz/yILu3vQ49yb4o/MpLy47OdhVvGLay5hdo36FHRL
         J0JA==
X-Gm-Message-State: AE9vXwPDCuZ23Zg/4h4kVDqbpteqKgY7a94EasSCbJAyDYOQXLkMMHkDyjhsks4tMy8yqA==
X-Received: by 10.194.61.203 with SMTP id s11mr18222866wjr.141.1473708603840;
        Mon, 12 Sep 2016 12:30:03 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 188sm1688459wmo.1.2016.09.12.12.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2016 12:30:02 -0700 (PDT)
Date:   Mon, 12 Sep 2016 20:30:16 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        Ingo =?iso-8859-1?Q?Br=FCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v2 2/4] update-index: use the same structure for chmod as
 add
Message-ID: <20160912193016.GD8254@hank>
References: <20160904113954.21697-1-t.gummerer@gmail.com>
 <20160911103028.5492-1-t.gummerer@gmail.com>
 <20160911103028.5492-3-t.gummerer@gmail.com>
 <xmqqinu26ph0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinu26ph0.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/11, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > @@ -955,10 +941,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >  			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
> >  			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
> >  			(parse_opt_cb *) cacheinfo_callback},
> > -		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
> > -			N_("override the executable bit of the listed files"),
> > -			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
> > -			chmod_callback},
> > +		OPT_STRING( 0, "chmod", &chmod_arg, N_("(+/-)x"),
> > +			N_("override the executable bit of the listed files")),
> >  		{OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
> >  			N_("mark files as \"not changing\""),
> >  			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
> > @@ -1018,6 +1002,15 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >  	if (argc == 2 && !strcmp(argv[1], "-h"))
> >  		usage_with_options(update_index_usage, options);
> >  
> > +	if (!chmod_arg)
> > +		force_mode = 0;
> > +	else if (!strcmp(chmod_arg, "-x"))
> > +		force_mode = 0666;
> > +	else if (!strcmp(chmod_arg, "+x"))
> > +		force_mode = 0777;
> > +	else
> > +		die(_("option 'chmod' expects \"+x\" or \"-x\""));
> > +
> 
> I am afraid that this changes the behaviour drastically.
> 
> "git update-index" is an oddball command that takes options and then
> processes them immediately, exactly because it was designed to take
> 
> 	git update-index --chmod=-x A --chmod=+x B --add C
> 
> and say things like "A and B are not in the index and you are
> attempting to add them before giving me --add option".
> 
> 	git update-index --add --chmod=-x A --chmod=+x B C
> 
> is expected to add A as non-executable, and B and C as executable.
> Many exotic parse-options callback mechanisms used in this command
> were invented exactly to support its quirky way of not doing "get a
> list of options and use the last one".  And this patch breaks it for
> only one option without changing the others.
> 
> If we were willing to take such a big backward compatiblity hit in
> the upcoming release (which I personally won't be affected, but old
> scripts by others need to be audited and adjusted, which I won't
> volunteer to do myself), we should make such a change consistently,
> e.g. "git update-index A --add --remove B" should no longer error
> out when it sees A and it is not yet in the index because "--add"
> hasn't been given yet, or A is in the index but is missing from the
> working tree because "--remove" hasn't been given yet.  Then it may
> be more justifiable if "update-index --chmod=-x A --chmod=+x B"
> added A as an executable.  With the current form of this patch, it
> is not.

Thanks for the explanation, this change in backwards compatibility is
certainly not what I intended, but rather something I missed while
cooking up this patch.

> Can we do this "fix" without this change?

Yeah, let me see what I can come up with in a re-roll.

Thanks,
Thomas
