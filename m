Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865251F51A
	for <e@80x24.org>; Mon, 14 May 2018 17:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeENR1N (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 13:27:13 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:38390 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbeENR1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 13:27:12 -0400
Received: by mail-oi0-f41.google.com with SMTP id k17-v6so11435367oih.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9J97fndogPM2i2rRTwh/4h8IJssesJiITtF/w1iJcpw=;
        b=Of5ZmvxYfPfA1T2ACdSsP4flJzT+Oi2oGreR9PGyYeao/0m9FVomcxb3822ILrlqWk
         U6uBG4LLa3cewIHDymXmooJ/bSBJ95UdjTxQug9Gp5+ep3f+h1x/P4le7LVFpFZJt1Ce
         YpwxRURJS69tV/WeWuFRL4udB10a6KGh+Hj6hNw4/apqmmCEClcSiVjLZ4b8UyvyQb2d
         HN6g6Akwv1cDNqcdGEc5P+OxEvIYzrXd6tHgx229hQPgTA9yBgHLC6wVAFNs5zUjbJsV
         0HpDfa+BA+5Rz7MABSgK6EOH0Juxw7mDNcLmt4gGocnGzV2+VODwH4gRVCMG5vQJx3wZ
         zV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9J97fndogPM2i2rRTwh/4h8IJssesJiITtF/w1iJcpw=;
        b=X1pwFKhre7XHa0OAY2qfgZx5WT8dUxpZjddVBQEAkDAbsn+QGCsv+nS0t3fDPc96GR
         0fKApGh6luoscsEzfRK3ofa4mVH8QT7VH2D1BKY1Us5YOKdu8XxMz0Qm/XFY2AnI48hm
         5SXjnLJcmBRo9CiScXv+tdTJE1EN9t/3gZ25gFhEHyI7VK7YMzfH6uUAOzpzaSZmDKG+
         zbuTGAxpR/jOyDa1zWNQ6gpafBlRRz3gpE0jEROMcpV8YwVG4lnecMVWZBsm4oZvgc+M
         npNGEW3cyONAepnxk0EQeOn9CvdTn3e1U/WoOO8gUEixV40taQmN4FBqG293w0YIts4w
         0Xlw==
X-Gm-Message-State: ALKqPwfdX5asySjeaontm34KM0kv5WTDPT5Tj8gOL5+R+yrZLf/zFHzh
        KGtuBzw9Pm69qkV0UmLehgNYEh0IJqwTwXvGqIE=
X-Google-Smtp-Source: AB8JxZrZdDM2gPW48bUwnZNdXfcXXkfsvhfeQ15dgf4Ie45z5NE9PJtasq+JyNTBsHb03rAbreVsSRrDmArUQn0oawQ=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr7623778oig.34.1526318829675;
 Mon, 14 May 2018 10:27:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Mon, 14 May 2018 10:26:39 -0700 (PDT)
In-Reply-To: <ef3709f1-d9c2-860a-23d3-8d496294e1ac@gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com> <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
 <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com> <ef3709f1-d9c2-860a-23d3-8d496294e1ac@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 14 May 2018 19:26:39 +0200
Message-ID: <CACsJy8CwwseqL9M=-ML6hwgHG_GSK6pfeQU+MGWsx6=WCCZtmQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 7:03 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Am 08.05.2018 um 17:24 schrieb Duy Nguyen:
>> On Mon, Apr 23, 2018 at 7:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> I haven't looked at the implementation, so this may be an entirely
>>> stupid suggestion, but would it be possible to instead render the
>>> completions as?
>>>
>>>     % git checkout --<tab>
>>>     --[no-]conflict=                   --[no-]patch
>>>     --[no-]detach                      --[no-]progress
>>>     --[no-]ignore-other-worktrees      --[no-]quiet
>>>     --[no-]ignore-skip-worktree-bits   --[no-]recurse-submodules
>>>     --[no-]merge                       --theirs
>>>     --[no-]orphan=                     --[no-]track
>>>     --ours
>>>
>>> This would address the problem of the --no-* options taking double the
>>> screen space.
>>
>> It took me so long to reply partly because I remember seeing some guy
>> doing clever trick with tab completion that also shows a short help
>> text in addition to the complete words. I could not find that again
>> and from my reading (also internet searching) it's probably not
>> possible to do this without trickery.
>
> The fish-shell does something like that.
>
>     > git status --<tab here>
>     --branch  (Show the branch and tracking info even in short-format)
>     --help                       (Display the manual of a git command)
>     --ignore-submodules                 (Ignore changes to submodules)
>     --porcelain    (Give the output in a stable, easy-to-parse format)
>     --short                      (Give the output in the short-format)
>     --untracked-files              (The untracked files handling mode)
>
> Another tab will put a selection-cursor on the displayed list - you can
> navigate that list with Cursor-Up/Cursor-Down, select an entry and that
> entry will be inserted into the commandline. That selection process
> would be useless if the options are presented as "--[no-]x" because THAT
> cannot be inserted into the commandline without manual editing. And
> that's the point of the fast option selection process.

Good to know.

BTW I looked at the git.fish completion script [1] and see that recent
effort to help automate more in git-completion.bash might help there
too. I notice a lot of options and help text hard coded there, if
someone can explain to me how git.fish uses those, maybe I can change
git to export something suitable for git.fish to use too [2].

For example with latest git (in 'master') doing this

    ./git add --git-completion-helper

gives you the list of all options of "git add". Giving the help text
for each option is definitely possible (I just didn't see any use for
it until I looked at zsh/fish completion scripts) and maybe more in
the future.

[1] https://github.com/fish-shell/fish-shell/blob/master/share/completions/git.fish
[2] But then if your script has to work with old git versions too then
this is a moot point.
-- 
Duy
