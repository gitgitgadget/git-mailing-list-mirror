Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35A531FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 18:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755714AbcLSSPK (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 13:15:10 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33229 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754930AbcLSSPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 13:15:09 -0500
Received: by mail-qt0-f175.google.com with SMTP id p16so152497463qta.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 10:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=emmIEyCX/cVmSVbeofhRizxPHSnuYBnKyKPM4OJkwJg=;
        b=eZ82gYKPaF8a3YqecF8KIgy1Wy4+CfgYrkGr+qJCfrQ70GFkKnct2Nb2qhbmyer7zC
         FuHqxsseBaxC7wibacJYm4mMXCGdfZpC/DV1n0N8Rsxv+5GV4gELW/SZa6oWw80zl/8n
         0MtaMWAst5gVc31MriWdcaE+y/NgAxNNFLMiz7f5gI5FeW14l7kMeHnWg2XQInOu/ncm
         8K6Kln5BXjS8XrAjVQQTawvo53WT8wVy9lUTwoQsSyF25b0xjRDOaY/iMXiFmFyRJ2Eh
         l1zbz9Be25/Hws7sgtiTr046E4YuJYrLyqfV+1Hv1pWCFeurKaIixAzXJIDnaWKVoLGX
         VibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=emmIEyCX/cVmSVbeofhRizxPHSnuYBnKyKPM4OJkwJg=;
        b=HiRQ4b8Yn/Un756O1ACPvbok03qT3nSexZgncPh04FnFvEfU0XwwGhcj3m6bpxEj31
         LeKw8gg4l4Ov3zTZqhxaIheq0aO2QmpOIHx+PGqu5BaQvDK42VCGPgq2h/dLURuupMJb
         Hq7e2PwqKV2LIA2IT1LymTpgEICVp8q12s+9eb63x1xP9BGMCpr571+JLTyNUaDe7Blu
         NGEaKko4kUvSdrulbXC5avcUeZ6XczIdo5VyYQZwhzWjSBEfC7UmgrcQ4vluYZU2J2va
         ovrJt/Y5Bh57wzPK22V+b3hTjaB2qZjAv0sVt4ukK5Ko5jmhHDO9RpzKegJdK3J8S8fp
         c17w==
X-Gm-Message-State: AIkVDXJpsF0KOA4VuDo8qraeT2UOJ0uRpsW1a+hOViZEivMCBJ3W9Jj1b6VxQ9hWz8KGt+NOtI5e+8tNLB6Bxgve
X-Received: by 10.200.58.65 with SMTP id w59mr15993909qte.54.1482171308675;
 Mon, 19 Dec 2016 10:15:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 19 Dec 2016 10:15:08 -0800 (PST)
In-Reply-To: <20161219053507.GA2335@duynguyen.vn.dektech.internal>
References: <20161212190435.10358-1-sbeller@google.com> <20161212190435.10358-7-sbeller@google.com>
 <20161219053507.GA2335@duynguyen.vn.dektech.internal>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Dec 2016 10:15:08 -0800
Message-ID: <CAGZ79kYPEiUGXR-qTbbHzaeOwbHH88mdx7GP8QX2Ff1bypcrwQ@mail.gmail.com>
Subject: Re: [PATCHv8 6/6] submodule: add absorb-git-dir function
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 18, 2016 at 9:35 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Dec 12, 2016 at 11:04:35AM -0800, Stefan Beller wrote:
>> diff --git a/dir.c b/dir.c
>> index e0efd3c2c3..d872cc1570 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -2773,3 +2773,15 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>>       free(work_tree);
>>       free(git_dir);
>>  }
>> +
>> +/*
>> + * Migrate the git directory of the given path from old_git_dir to new_git_dir.
>> + */
>> +void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_git_dir)
>> +{
>> +     if (rename(old_git_dir, new_git_dir) < 0)
>> +             die_errno(_("could not migrate git directory from '%s' to '%s'"),
>> +                     old_git_dir, new_git_dir);
>> +
>> +     connect_work_tree_and_git_dir(path, new_git_dir);
>
> Should we worry about recovering (e.g. maybe move new_git_dir back to
> old_git_dir) if this connect_work_tree_and_git_dir() fails?

What if the move back fails?

>
> Both write_file() and git_config_set_.. in this function may die(). In
> such a case the repo is in broken state and the user needs pretty good
> submodule understanding to recover from it, I think.
>
> Recovering is not easy (nor entirely safe) either, though I suppose if
> we keep original copies for modified files, then we could restore them
> after moving the directory back and pray the UNIX gods that all
> operations succeed.

There are different levels of brokenness available.
I just tried what happens if core.worktree is unset in a submodule
and that seems to not impact git operations (I only tested git-status
both in the superproject as well as in the submodule).

So I wonder why we set core.worktree at all here as it doesn't
seem to be needed.

Which means that the move of the git directory as well as the .git file
update to point at that moved directory are the important things
to get right.

So maybe:

1) rename the git dir or die
2) write the new gitlink
    If that fails remove the .git file (if it exists partially or empty)
    and undo 1) by calling rename again with swapped arguments
    and then die
3) set core.worktree
    If that fails, just warn the user
