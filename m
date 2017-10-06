Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D381FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 02:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdJFCf6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 22:35:58 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:43643 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdJFCf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 22:35:57 -0400
Received: by mail-pf0-f176.google.com with SMTP id d2so5685950pfh.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 19:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UaOcyeny91C3YYogwwKwZcjSJ7IOnbZbDGHbQThN44c=;
        b=sKV6oNUoG6yhuGm15m65Yb7KNVt+bJx2Nos+3EveaG43GOTpatMMRUFYVkrdyyDMIN
         dfD/zn9NM+O7Io1jWNS22F93E4MDc5R+MaSi369byBipZaHrNG6u6G+pWwE48XA0n+59
         AWCr/6Ov7tCAx6M1HgsJEkFltTaE/0kcBo6/I0R3oTAkBlYEt9oEQQktGJ9iiUwfyOMg
         1tOazd7n2eNDifb80Z3VuRkN5AUyQHxe4Q9ALXAmFGuIiKGGgwDZWmr2mWKo2ZCyxO+V
         W/oIwrQkq/5YbyWvsuJ8nfIklrWR6l+jAhYL0g6ure2KIo2jTvoHdS7L+Kxat6Ec/6vY
         BARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UaOcyeny91C3YYogwwKwZcjSJ7IOnbZbDGHbQThN44c=;
        b=iQdEQ65PbOZxCDNP50iZZm2RwcURb5iJdbpVlusanv1vzjIMxNJrlhAzOWO+1cuamJ
         A2twBMT9Hejazsvc+KFt5kSYqohJq2vzSzg/XgKQue4HZ5+LN0b9PrCGxBIMifRmEvtk
         aam1BTouS3iHEuYD0yv9mac9gb1yBeJvXn/1LGvPlESXPCkD8pDmwd5qTv2we+t7Zx90
         4Q8hFuTii1p/VMZqJ/65JkEFIZXwl+D71V7zDPylOB9pZWX68Znq9U9XhmjT5G0KZCul
         tV7wPbfDhkiO+wKb1OWhUgOHXm53Y0b0gLrjaQ0BJX9VJNbqg+fTFqxu3hVFU3FTbeWL
         lntw==
X-Gm-Message-State: AMCzsaWVpYZeYXG7Gwl24z10Uc+008FtO5mlbCMMUnyK/3uU5AYK588O
        3LAkrhfDo+0VQ25J0Q1ZopA=
X-Google-Smtp-Source: AOwi7QArTeJoamfgWlgC7cV9sTllHYt/zKlt181T7OVVk8ZEHu3szw4INub9AeZ2S9G8oRQxbXsRew==
X-Received: by 10.98.150.203 with SMTP id s72mr653554pfk.199.1507257357218;
        Thu, 05 Oct 2017 19:35:57 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:78c3:3d0d:a9b5:4320])
        by smtp.gmail.com with ESMTPSA id d7sm410315pgf.20.2017.10.05.19.35.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 19:35:56 -0700 (PDT)
Date:   Thu, 5 Oct 2017 19:35:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     rpjday@crashcourse.ca, git@vger.kernel.org
Subject: Re: couple questions about git "logical variables" and "git var"
Message-ID: <20171006023530.GA134987@aiede.mtv.corp.google.com>
References: <20171005051104.Horde.8J0J7-XC6jD4AOgtYrou3Na@crashcourse.ca>
 <20171005095636.mpp2ohf7vp7mtzeb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171005095636.mpp2ohf7vp7mtzeb@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Oct 05, 2017 at 05:11:04AM -0400, rpjday@crashcourse.ca wrote:

>>  - GIT_AUTHOR_IDENT
>>  - GIT_COMMITTER_IDENT
>>  - GIT_EDITOR
>>  - GIT_PAGER
>>
>> first question -- what is it about precisely those four variables that makes
>> them "logical" variables in git parlance? just those four? no others?
>
> It was introduced in the very early days as a way for scripts to get
> access to "standard" values that would be computed the same way as the C
> portions of Git.  But it hasn't generally been kept up to date with new
> possible variables.
>
> It also only tells half the story. You have to know not just what's in
> $GIT_EDITOR, but you have to know the right way to evaluate it. There's
> a git_editor helper in git-sh-setup, but other scripting languages are
> on their own.

I am not sure I understand the complaint here.  git-var(1) says:

	GIT_EDITOR
	   Text editor for use by Git commands. The value is meant to be
	   interpreted by the shell when it is used. Examples: [...]

Are you saying that the output of the command should quote that
manpage, so as to tell the rest of the story?

>               We'd probably have done better to introduce a "git editor"
> command which can be run from any language.

I remember that we discussed this at the time but don't remember why
it didn't happen.  It seems like a good idea.

[...]
>> p.s. yes, i realize this command is deprecated in favour of "git config -l",
>> but as long as it's available, it should work as described in the man page.
>
> Yes, though I think fixing the manpage is the right way to make them
> consistent.

Agreed as well.  rday, care to take a stab at wording?

Thanks,
Jonathan
