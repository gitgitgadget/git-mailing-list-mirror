Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70781F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 20:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfHOUNb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 16:13:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36297 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOUNa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 16:13:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so1780748pgm.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WB2h2U8oyPfPWoEyBojbCmw34KWE/naz3ksOKRN0N8s=;
        b=TIeGGCcwZwIYu5qcn4G/ou1FlKVw8ZfWyntjpm2MFyQQTNNXDE1xhuyg8AXPHVDSoc
         1ZmoMdr/tK5H+tmzkDSkRxzH9wg6Q3/tP3iSVPYPpqrvuFIGD3VyCBTtqMtQEAaCT0Df
         pMSyXAXkXuJSm9c0Y/5N/rlAXMVeJaXyUkupzYHAfU3d/P0WNXBYuyzPXEHnKL3F+3BF
         9ZKGTUjlbWNZrZK0hodGD0VkblKj+O9VKGD9ktgiT3h757wU8B+FBv2MRw/kmYlrAact
         zCulKndr1w3lNXqgTewkhERWsr+4TE3K/J+9CfSXNprx7hXfuGKSaIkRdrZbA3QUTZzC
         rqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WB2h2U8oyPfPWoEyBojbCmw34KWE/naz3ksOKRN0N8s=;
        b=dNsXQjePJBG+nKzabSlVREVIgxUTKTu1BDoVS1TE7b3zq0TENk9chh8zEVxKhD7kCO
         bfPwubS810EzWcrVw46qB5SAe7KN769r5gPz5GSrNm7osDu08GWayMQC8Zj1B2UKoXel
         77X58XVJaPXE/bnYAaBGygXAwBHKBEU7ApIXpYsxhpO8fqWBQ4kOWD6qyIBHFfUsZmsx
         f7j5mL/Wfn6wjIs+Uesc1Ksi7jLQisqBhQ79BrSDUfZ3DWCfSW26ZEPwyF26WeEhoS67
         Hp0ibkqjeJhBcE9lrkMdgGbyvxr++6uG8G/PlNhFFjqCLRqUgMusI01pDK7dm40pJyeX
         Ov5g==
X-Gm-Message-State: APjAAAUcXjvaDo979HmOjhYqVAG/zfrjGw8uawsuywPKAYx697fdO/1i
        1WNw1+xqdNP0LlmK/UNBiCOhKQ==
X-Google-Smtp-Source: APXvYqx4AoClroEXqWi5LXqIwRSz2dthIMDm0Sc5NiFN9Cxnu6bwFi91dsTvbSYGj5rH8fc/eTA1XQ==
X-Received: by 2002:a17:90a:30ad:: with SMTP id h42mr3741138pjb.31.1565900009067;
        Thu, 15 Aug 2019 13:13:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id v21sm3635482pfe.131.2019.08.15.13.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 13:13:28 -0700 (PDT)
Date:   Thu, 15 Aug 2019 13:13:24 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
Message-ID: <20190815201324.GA208753@google.com>
References: <20190815023418.33407-1-emilyshaffer@google.com>
 <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 10:15:24AM -0400, Derrick Stolee wrote:

> >  - Do we want to advertise the Git mailing list for bug reports?
> 
> That is possible. Isn't there another mailing list for git users?

I know there's an IRC channel for Git users, I dunno about mailing list.
I'm worried that places I name as points of contact will grow stale,
although I suppose #git on freenode isn't really going anywhere, for
example. (But as a counterexample, I hope that nobody sends something
like this to #git-devel, which seems to have a lower population than
this mailing list.)

> 
> I could see a patch added on top of this for git-for-windows/git that
> changes the instructions to create issues on GitHub.

Indeed; I imagine we'd probably like to patch it to ask for bugs in our
bug tracker.

> 
> >  - Which config options should we filter to avoid accidentally receiving
> >    credentials?
> 
> The remote URLs are pretty sensitive. Not only do users sometimes put passwords
> or PATs into their URLs, the literal name of the repo could be a secret.

Now here's where I start to wonder. We often debug internally by asking
for the remote URL and replicating the issue there, which is why I
mentioned it explicitly in the commit message. But I hadn't considered
folks including the password in the URL.

Well, I suppose anybody can keep a local patch to change the config
filter pattern. I'll try to make it easy to spot and modify.

[snip]

> At first I was alarmed by "What? another shell script?" but this command should
> prioritize flexibility and extensibility over speed. Running multiple processes
> shouldn't be too taxing for what we are trying to do here.

If shell scripts are entirely deprecated I can convert it, but doing it
in C seemed like overkill when I really just wanted "what are all the
commands we would ask the user to run and tell us the output?". I
figured also that it would be a little more immune to bitrot to output
the contents of porcelain commands here.

> > +	echo "[Git Config]"
> > +	# TODO: Pass this through grep -v to avoid users sending us their credentials.
> > +	git config --show-origin --list
> > +	echo
> 
> Config options to consider stripping out:
> 
> 	*url*
> 	*pass* (anything "password" but also "sendmail.smtppass")

Done, thanks.

> 
> > +	echo "[Configured Hooks]"
> > +	find "$GIT_DIR/hooks/" -type f | grep -v "\.sample$" | print_filenames_and_content
> > +	echo
> 
> Remove the sample hooks, but focus on the others. Will this look like garbage if a hook
> is a binary file?

Yeah, I'm sure it will. I'll add a check to
print_filenames_and_content() so it can tell us if there is a hook
installed there, even if we can't see the content.

> 
> > +
> > +	echo "[Git Logs]"
> > +	find "$GIT_DIR/logs" -type f | print_filenames_and_content
> > +	echo
> 
> As mentioned before, I've sometimes found it helpful to know the data shape for the object
> store. Having a few extra steps such as the following could be nice:
> 
> 	echo "[Loose Objects]"
> 	for objdir in $(find "$GIT_DIR/objects/??" -type d)
> 	do
> 		echo "$objdir: $(ls $objdir | wc -l)"
`echo "$objdir: $(ls $objdir | wc -l) objects`
I'll add context so we don't need to have the bugreport script memorized
in order to read a bugreport :)
> 	done
> 	echo
> 
> 	echo "[Pack Data]"
> 	ls -l "$GIT_DIR/objects/pack"
> 	echo
> 
> 	echo "[Object Info Data]"
> 	ls -lR "$GIT_DIR/objects/info"
> 	echo
> 
> 	echo "[Alternates File]"
> 	echo "========"
> 	cat "$GIT_DIR/objects/info/alternates"
> 	echo
> 
> That last one will collect information on the commit-graph file, even if it is an
> incremental file.

Thanks Stolee, these are awesome and exactly the kind of feedback I was
hoping for.

> 
> I think this is a great start, and I'll take some time later to try it out.
> 
> Thanks,
> -Stolee

Awesome. I'm excited to hear how it goes.

 - Emily
