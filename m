Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B5C1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 23:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeDEXSZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 19:18:25 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35123 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEXSY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 19:18:24 -0400
Received: by mail-it0-f65.google.com with SMTP id v194-v6so6415633itb.0
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 16:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gPYwIxit6kLEQexI7Jf4T5p2gDXNuwB41mbtbbuJlrY=;
        b=lH4593kaxMEyY7BCxsxOA1Hz4HRnBordf3lsq0lNFnkNKppqZP46HwAVwYxqM9uCDD
         MQ4tfBRlzJxscROavD3XnexNdWmqfOuRyCOOMh5wqcQ0o7I57eZAyt2yjRbZSDLnoZbq
         x/b31ImKeQDY0XIp7lpi3W/YSK0KlMRU8h6mVL8260xc5ziL/resxFy04u0EB1b39sHA
         p0w3djqAM6nMQ/1QDkIXiAd7q9QROp1wLtpe8vn+7nNKL8Un2wh9/y2xjqHu/U5up0Ym
         kjTpF+J1dNrUaSfzPqbuFbRjFsOqNnuDkwnO8tfHc7H/Y4ARZgJyPY4o3aLE5gGRTv0t
         LZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gPYwIxit6kLEQexI7Jf4T5p2gDXNuwB41mbtbbuJlrY=;
        b=oW6muwZtH+fJuw31xHZqkhN0IHtG6J8mk+F3YP6a5kfKhcFbb0UKwc3opOIeladAus
         clrAV01R03WdMl7ukxxgGNcbx+7rflpoN8cN8gqGSawSoAtaNhpGBUPWeGeP1crAgwGc
         JyY6J+FplgOqlnQhzfw1jkQ2cOPHtWs+W0t/rQcRGrPgQT8wYTRqwErl0OATw/nzbHlJ
         qjeQmTHzUAnE11XOGe6lBF/csX2PRSg9ZbYl/jaaVQlbtV0bpooUfZIQUNwvaDpYvLvw
         xkjEL1slenAyQMW9BiKV0cKblzXoQ0U6ysKP7HkAwF251EiIYyfyDpph63Z487upUvtf
         0aMw==
X-Gm-Message-State: AElRT7EwtrA17tJh2wOPdFJ+D63B/ucV4S2ZnoQvl48CqXj/wAAWX9ug
        pSnuIO50/WKtI9KGM1jR7z33eK2+dh0hq3/G+2my3XewI7A=
X-Google-Smtp-Source: AIpwx492q9BnInAcvolwjD5o5LOVsGjJR6HZA5wX4JsAdfdKWApMpQ1nu/cgpOxC4swC2tQzR0vBTSEGPRatDMvPA00=
X-Received: by 2002:a24:624b:: with SMTP id d72-v6mr16707924itc.70.1522970304040;
 Thu, 05 Apr 2018 16:18:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.97.20 with HTTP; Thu, 5 Apr 2018 16:18:23 -0700 (PDT)
In-Reply-To: <5AC67C43.9080500@connotech.com>
References: <5AC67C43.9080500@connotech.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 5 Apr 2018 16:18:23 -0700
Message-ID: <CAGyf7-E9=Mm1oJdhwHTmg2byrOxMRFVEjmYHCFGqqP8pvK=vJg@mail.gmail.com>
Subject: Re: Self-inflicted "abort" in a newbie attempt at read-only
 exploration of a cloned repository?
To:     Thierry Moreau <thierry.moreau@connotech.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 12:42 PM, Thierry Moreau
<thierry.moreau@connotech.com> wrote:
> Dear GIT enthusiasts!
>
> This ends up with a "git checkout" command aborting. A bit frustrating at
> the early stage of GIT learning curve.
>
> My first goal is to clone repositories locally in order to explore the
> various linux kernel versions, with the rich GIT metadata.
>
> Thus, I clone:
>
> $  git clone --branch linux-4.16.y
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> linux-stable
> $  git -C linux-stable/ branch
> * linux-4.16.y
>
> So far so good. Then, I want to extract an earlier kernel version into a tmp
> dir:
>
> $  mkdir tmp
> $  git -C linux-stable/ --work-tree $PWD/tmp/ checkout linux-4.15.y
> $  git -C linux-stable/ branch
> * linux-4.15.y
>   linux-4.16.y

The documentation for --work-tree says:

--work-tree=<path>

Set the path to the working tree. It can be an absolute path or a path
relative to the current working directory. This can also be controlled
by setting the GIT_WORK_TREE environment variable and the
core.worktree configuration variable (see core.worktree in
git-config(1) for a more detailed discussion).

So passing --work-tree tells Git where to store your _files_, but it's
still using the same .git directory.

If your goal is to have worktrees for various versions, that implies
the git worktree [1] command might be more along the lines of what
you're looking for. An invocation based on above might look like this:
$ git -C linux-stable/ worktree add $PWD/tmp/ checkout linux-4.15.y

That should leave linux-4.16.y checked out in linux-stable, while
creating a full work tree in $PWD/tmp that has 4.15.y checked out.

Note that worktree is a newer git command. 2.17 has it, but old
versions like 2.1 won't.

[1] https://git-scm.com/docs/git-worktree

Hope this helps!
Bryan
