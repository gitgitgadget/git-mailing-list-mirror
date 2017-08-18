Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5091208D0
	for <e@80x24.org>; Fri, 18 Aug 2017 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbdHRUjC (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 16:39:02 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38198 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbdHRUjB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 16:39:01 -0400
Received: by mail-pg0-f48.google.com with SMTP id t80so43350285pgb.5
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iXEo/WydKfJ9S8Bh46tZmavZzjQDY5a6IZscnD6+kg8=;
        b=SrL4W2yweEQoCOkPtPpcs4otw6YIzUjW6rlffvLzWrLnV9bKcuqvRbDaxNq1coyY3z
         sb2fxA5SkYjJ+yVFyhQZVEcRXoP6bPYZl+5834oSbuMG5qvu6Bzam0fYm09G1i9qCyuo
         doeyhveDNPjsryWTRE69KansuOXrMMNbS0dfZbJgOmtJwbEjRLd9jCOgzKo+be1cYQ5M
         X+AbUHgkxzB0K2xg6okQO/YEsrn41t3xf+r6C5XwUz9OxRbIEDNfu9dH//nmvpPgUhV7
         1rRzTBA1BPII6I8nZWtYHHDbO3UmVw5lCJerOl1g6tfj/u99ZtGrxMF3G5q28vl5lzoi
         JvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXEo/WydKfJ9S8Bh46tZmavZzjQDY5a6IZscnD6+kg8=;
        b=M9m6bCJbD9kgxtMH6d5OA1dY7mMbWGaEo94C4L/PC0lDNc0JoMe9hDtPQvTW+M1/8s
         7KVoM5YAcYu/2oNZBhBonsbtd+Jj1jyLZNqrYEvidtpXulLo4qQx1KUxUrJSxASZmxng
         wfKZmQJUHjdOgn7La27yVW/OzaZ44O55/rhuZaDLS1XDWsXIVGWqDZgjs48ljZUKOeeV
         00JV6vWmmlAyx/3snZ7QALuZLDV2lw9bTnl+t/p4xRB4OsZ6lnrlRHccBOU1w5eOPknu
         cTEUl0DiLQz3ivlAkY/Vrw7ctWww5MvMW3R6Dnhais0JkuyhNMlAYlznLWw9SCMKffWV
         6B4Q==
X-Gm-Message-State: AHYfb5gBhzD3BWzl5QjYwykibNVOT2Adobo+Qkhhm/2fSphSF1b9bjo4
        T5gM55P5+NBS+g==
X-Received: by 10.84.216.30 with SMTP id m30mr8486011pli.385.1503088740755;
        Fri, 18 Aug 2017 13:39:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:70fd:e2e5:b6ce:5065])
        by smtp.gmail.com with ESMTPSA id j73sm15370026pfa.117.2017.08.18.13.38.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 13:39:00 -0700 (PDT)
Date:   Fri, 18 Aug 2017 13:38:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     R0b0t1 <r030t1@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [bug] Git submodule command interprets switch as argument and
 switch
Message-ID: <20170818203858.GK13924@aiede.mtv.corp.google.com>
References: <CAAD4mYi24dHNhG1MFkPaeVv9P-9UN_FxSvZmX6XFHrfA7K0hoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAD4mYi24dHNhG1MFkPaeVv9P-9UN_FxSvZmX6XFHrfA7K0hoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

R0b0t1 wrote:

> The issue is as follows:
>
> R0b0t1@host:~/devel/project$ git submodule add
> https://github.com/user/project -f
> Cloning into '/home/R0b0t1/devel/project/-f'...

Thanks for reporting.  Confusingly, I think this is intended behavior.
"git help submodule" explains:

	add [-b <branch>] [-f|--force] [--name <name>]
		[--reference <repository>] [--depth <depth>] [--]
		<repository> [<path>]

		Add the given repository as a submodule at the given
		path [etc]

Since the -f comes after <repository>, it is a <path>.

That said, there are a few related things wrong here.

The usage string above says I can put "--" before the <repository> to
make things extra unambiguous.  But when I try that, I get the following
result:

	$ git submodule add -- https://gerrit.googlesource.com/gerrit -f
	Cloning into '/tmp/t/test/-f'...
[...]
	Resolving deltas: 100% (215796/215796), done.
	/usr/lib/git-core/git-submodule: line 261: cd: -f: invalid option
	cd: usage: cd [-L|[-P [-e]] [-@]] [dir]
	Unable to checkout submodule '-f'

If I try to put the "--" between <repository> and <path>, I get another
confusing result:

	$ git submodule add https://gerrit.googlesource.com/gerrit -- -f
	'--' already exists in the index

"git help cli" is supposed to give advice about this kind of thing as
well --- e.g., it gives some sound advice about what form of flags
scripts should use (e.g., to always use the 'stuck' form --name=<name>
instead of --name name).  But it doesn't mention this issue of flags
belonging before other arguments.

Thoughts?

Thanks,
Jonathan
