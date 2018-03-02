Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03A9A1FAE2
	for <e@80x24.org>; Fri,  2 Mar 2018 11:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965609AbeCBLxk (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 06:53:40 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:39643 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964885AbeCBLxg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 06:53:36 -0500
Received: by mail-ot0-f172.google.com with SMTP id h8so8480623oti.6
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 03:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Btfv16rYdqLskLwEzLo89PyL8E9qUEYv51QLTRBD8p0=;
        b=li5TzB2GRSOYSdJy5owEUjNAP5hckJ/LeJqK6DmEO0Amc4riEg7/dH7pZHC8otiU9w
         2ID1+pDqm7/q23ve1Ot7mzjazKs+Hyys0ZfaU1tZbgYpbisr1SxB9WAKxo8g7JXvYZpA
         s05tedJyA3BjvAa/3ky0/ZrjbdlQXkCHVhd3yATecg+S577CG9oLpTZ5d6FYa8bWBIEZ
         t6Omov8z7Y/UBELUJhtznnszg0uYHTMeR/KnFjOKWCTtY/OQaFaybnyvUlbssQJc9YL4
         CuYCI5RMBn5Qv3kpT9uSsuZFDuIEVS9DTb/P0m1aOIw9+lt5IX+As57ALou/e1ZTcrQw
         Znow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Btfv16rYdqLskLwEzLo89PyL8E9qUEYv51QLTRBD8p0=;
        b=pm7SrBpPj29Byw+ZiuaOZ1CRlilxlFRMuiwbDomms9ppyceG+tWIV3BAylUApZKuqx
         tVV/RRGGGzc8W0zH+jwn6cWWaHTjgpJLdjiviCR8bTAs4kC5cmQbO3RwsK2HQSjxoYiz
         48eZ+glv/qUXt8ji6s/H8CoogKaXY1nFfGx0KWeWw2ldHsAKhvNb9CXqvP1B2/PC/WzH
         XIZ5eYZg680BxRusTrF5SlQOLHzLSGfW4b5SIb/qwxTd2DMRicZ4Xk/sOb3rvYrpvaw+
         en0+zwTXn56dL72BDlEPZ6134T34H50x8aQ3zhnFeY4dJfZMvlgVfW9LxVche62tM3wX
         86qw==
X-Gm-Message-State: AElRT7HvmIDwRfj0u6J9IXUsN4MHqzcfqBZvozn4K3Q/x7l91iw2C152
        eOMkvyYz+Gkv0X2wTdaJLAk3zNAsWpGWnW9Ojws=
X-Google-Smtp-Source: AG47ELs5Ew7ZBJUitKTyzfuZBlPTQTyq6u1Wd9rySHXtvDs73E6E8U6pTGFdDM810ODrPfM34tXn8QutSSiBI8dgjr4=
X-Received: by 10.157.54.204 with SMTP id s12mr3930434otd.304.1519991615628;
 Fri, 02 Mar 2018 03:53:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Fri, 2 Mar 2018 03:53:05 -0800 (PST)
In-Reply-To: <b34d74fa-f4c7-fb4a-49df-cd7ebd996d95@aegee.org>
References: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
 <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com>
 <adf7a7a0-3571-5b68-5d15-30a9067e3826@aegee.org> <CAPig+cTPFSbT7WxyoNEOSg=3Ft1pVzkgieGp44kHnZ9=NbYsqg@mail.gmail.com>
 <CACsJy8BUKCG-yiYX3ouMVa44iEo0swHpTkhW3ho_T0PCP81DSw@mail.gmail.com> <b34d74fa-f4c7-fb4a-49df-cd7ebd996d95@aegee.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Mar 2018 18:53:05 +0700
Message-ID: <CACsJy8CXEKG+WNdSPOWF7JDzPXidSRWZZ5zkdMW3N3Dg8SGW_Q@mail.gmail.com>
Subject: Re: Worktree silently deleted on git fetch/gc/log
To:     =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 6:34 PM, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=
=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2
<dilyan.palauzov@aegee.org> wrote:
> Hello Duy,
>
> thanks for your answer.
>
> Your assumption is correct: when renaming the directory apparently I have
> not adjusted /git/A/.git/worktrees/B/gitdir to the new location.
>
> I fixed the situation by renaming /git/B to /git/B.bak, creating a new
> worktree pointing to /git/B (with branch g), then deleting /git/B and mov=
ing
> /git/B.bak to /git/B .

Phew.. I was worried there was some serious bug that I missed even
after the last code inspection.

The good news is "git worktree move" command is coming so you don't
have to do this manual (and risky) operation.

I'm going to improve it a bit in this case either way, I think I have
some idea: (mostly to Eric) since worktree B is alive and kicking, it
should keep at least HEAD or index updated often. We can delay
deleting a worktree until both of these are past expire time.

Also Eric (and this is getting off topic), I wonder if the decision to
store absolute path in worktrees/../gitdir and .git files is a bad one
(and is my bad).

If we stored relative path in ".git" file at least, the worktree would
immediately fail after the user moves either the linked checkout, or
the main one. This should send a loud and clear signal to the user
"something has gone horribly" and hopefully make them connect it to
the last rename and undo that. "git gc" would have near zero chance to
kick in and destroy stale worktrees.

Another bad thing about absolute paths, if you backup both main and
linked worktrees in a tar file, restoring from the backup won't work
unless you restore at the exact same place.

Hmm?

> Consider adjusting the documentation as suggested below, possibly using a
> different wording.

Will do.

>
> Regards
>   =D0=94=D0=B8=D0=BB=D1=8F=D0=BD
>
> On 03/02/18 00:56, Duy Nguyen wrote:
>>
>> On Fri, Mar 2, 2018 at 3:14 AM, Eric Sunshine <sunshine@sunshineco.com>
>> wrote:
>>>
>>> As far as I know, there isn't any code in Git which would
>>> automatically remove the .git/worktrees/B directory, so it's not clear
>>> how that happened.
>>
>>
>> "git worktree prune" does, which is called by "git gc" and that was
>> actually executed from the command output in the original mail.
>>
>> =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=
=BE=D0=B2 did you move /git/B away manually? For example, you
>> originally created "B" with
>>
>> git worktree add /somewhere/B g
>>
>> then you do this at some point
>>
>> mv /somewhere/B /git/B
>>
>
> Signed-off-by =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=
=83=D0=B7=D0=BE=D0=B2 <git-dpa@aegee.org>
> ---
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 571b5a7..33655c4 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -15,8 +15,8 @@ DESCRIPTION
>  -----------
>  Runs a number of housekeeping tasks within the current repository,
>  such as compressing file revisions (to reduce disk space and increase
> -performance) and removing unreachable objects which may have been
> -created from prior invocations of 'git add'.
> +performance), removing unreachable objects, which may have been
> +created from prior invocations of 'git add', and calling 'git worktree
> prune'.
>   Users are encouraged to run this task on a regular basis within
>  each repository to maintain good disk space utilization and good
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.=
txt
> index 5ac3f68..4b0d32f 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -82,7 +82,7 @@ with `--reason`.
>   prune::
>  -Prune working tree information in $GIT_DIR/worktrees.
> +Prune working tree information in $GIT_DIR/worktrees.  Called implicitly=
 by
> 'git gc'.
>   unlock::
>  --
> 2.10.0.298.gc59cecb



--=20
Duy
