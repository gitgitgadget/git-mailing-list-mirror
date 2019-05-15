Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677DB1F461
	for <e@80x24.org>; Wed, 15 May 2019 10:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEOKai (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 06:30:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45807 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfEOKai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 06:30:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so1131904pfm.12
        for <git@vger.kernel.org>; Wed, 15 May 2019 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OENvZeaVFhmPJLpD3Pwz/jDXHbprWvz73uyQfzXAe0I=;
        b=qLVdbom5M/na3kw/VGB1veUijr4cwAF9gyDyfLCD7oFgAxBhxjf0lE/GIwpBfkmo0M
         6ricUmPY4zOakuwqsfeRpK/nTPwkUEFRYYCx26wAv04YuctguHBEjTIaGg8rqS/MSnV2
         a+qvfqUN3v27RfG8r8SyCjgPFpWwJTtOZOtJEOYk3noVwOqGWUoM2+pI7RsMkOtV0lsz
         ydmiLjtksXHk9Jc2T3bB4yabIx8lrJK+++DP6XXSTIV2CBs92N0kcC2AyaiGvx7qzYbB
         JK3nfTJ0Ppjr2/yt2nWBsQBxC7G+gvZjBVrxwBul4jkgIO245ZB876WRG0HBpg99hK5Q
         PPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OENvZeaVFhmPJLpD3Pwz/jDXHbprWvz73uyQfzXAe0I=;
        b=e2Dn3y+1bFyx0Eo/YWsGirPVHoQrvxOrW9aETqVVbxnicbW9ui+m0xzl94Qlm2q5qx
         AWn6vmBlcntcsq9L7aq0IMuhI/uTrTJh+ANu9rMF5zh9a9wEfk4ImaprFGXBpIy4Zthl
         9Js4ay/L+oJYm0rVp/NJ45i3jI192AL6kPFdk9mZZQm3GBlN78P0GgNOJi0uOBJGAb8N
         nLIRYqrZdB7/bapQsvXLd74PY8udNjOJNT7gOmDJSPsnPJ5BYtAVIP1g8yR6MDFKGuXE
         +zPGHbllPr6kFxxUIs9aNtpS6AO1oXOrX9w6zFgv23qU8yaGoKx7vKHE3sc2B8w80XXr
         I2Gg==
X-Gm-Message-State: APjAAAUi9hL2ySKp+YcU/OC1hvYtQquJ8pXtx+JY9a3soRuiz//xsgbz
        uLLPOC/ZWu5sxRmpqRL6MEM=
X-Google-Smtp-Source: APXvYqxMFiTm9yMFCKl9Qpn6hOrlu8gzZSUZ16ig7bGzbSPwEsh/Cg+uTOZW9B8a9JEQUxMPVyaiyA==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr47460222pfu.206.1557916237058;
        Wed, 15 May 2019 03:30:37 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id g17sm2634540pfk.55.2019.05.15.03.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 03:30:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 15 May 2019 17:30:31 +0700
Date:   Wed, 15 May 2019 17:30:31 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Poughon Victor <Victor.Poughon@cnes.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feedback on git-restore
Message-ID: <20190515103031.GA29149@ash>
References: <3E55146A6A81B44A9CB69CAB65908CEA6B91353C@TW-MBX-P01.cnesnet.ad.cnes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E55146A6A81B44A9CB69CAB65908CEA6B91353C@TW-MBX-P01.cnesnet.ad.cnes.fr>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 09:38:59AM +0000, Poughon Victor wrote:
> Hi
> 
> I came across a description of a new git command currently in
> development called 'git restore'. Since it's still not out, and the
> original poster [1] seemed to ask for feedback, I though I'd send
> some here. Hope that's ok!
>

Absolutely. And this is even better because other people could also
comment on.

> Reading the documentation [2] I find it very confusing. In
> particular when comparing the following two commands:
> 
> $ git restore --staged file
> $ git restore --worktree file
> 
> With the current proposal, the first will restore the index from
> HEAD, while the second will restore the worktree from the index. In
> other words, the source for the restore is different in both
> commands, even though neither specify a source!
>
> This means that git-restore really does two different things
> depending on some other not obvious context. Unfortunately that's
> typical of the (often criticized) obscure interface of git. To be
> fair that behavior is documented in [2]. But still, having a
> variable default value for --source depending on other arguments is
> very confusing.

I think it depends on whether use actively use the index, or you
mostly ignore it and always do "git commit -a" and friends.

When you do use the index, the "worktree <-> index <-> HEAD" is the
three stages that you are aware, in that order, and restoring from the
"next" stage is expected.

It does feel natural for me that we "restore worktree from the index"
and "restore index from HEAD". But maybe I'm just too used to the old
way of thinking? Let's see what other people say.

This is also consistent with other commands, for example "git diff
--staged/--cached" compares the index and HEAD and "git diff" compares
worktree and the index. You would need extra effort e.g. "git diff
HEAD" to compare the worktree and HEAD.

If your workflow ignores the index, which should always match HEAD,
then different default source is practically gone, since
index == HEAD.

> So in summary, I'd make two recommendations for this command's UX:
> 1. Make --source default value always HEAD if unspecified
> 2. Rename --staged to --index

This --index vs --staged was discussed and --staged is a compromise.
The problem is --index means something different in existing
commands. It specifies that you want to target both the index _and_
worktree. --cached on the other hand only targets the index [1].

It's confusing, yes. But --index/--cached is part of Git and we cannot
just ignore our baggage and redefine --index to "just index". That
will create more confusion and inconsistency between commands.
"--index" is simply not available.

So the compromise is we leave --index/--cached alone and gradually
move to the --staged/--worktree combo (for other commands as well).
Eventually I hope people will move to the second pair and mostly
forget about --index/--cached. And in a very long long time in the
future, maybe we can deprecate/remove/redefine --index/--cached.

[1] https://github.com/git/git/blob/pu/Documentation/gitcli.txt#L179-L199

> Some examples of those:
> 
> $ git restore --index file # reset the index from HEAD
> $ git restore --worktree file # reset the worktree from HEAD

I should also note that --worktree is the default, you can just write

$ git restore file

and achieve the same thing. Writing --worktree is only needed when you
want to make it clear to the reader you're restoring the worktree.

> $ git restore --worktree --source=index file # reset the worktree from the index
> $ git restore --index --worktree file # reset both the index and worktree from HEAD
> $ git restore file # reset the worktree from HEAD 
> 
> [1] https://news.ycombinator.com/item?id=19907960
> [2] https://github.com/git/git/blob/pu/Documentation/git-restore.txt
> 
> Best,
> Victor
> 
> 
> 
