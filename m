Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFF3207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 18:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933300AbcJLSBV (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 14:01:21 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36382 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755266AbcJLSBL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 14:01:11 -0400
Received: by mail-qk0-f182.google.com with SMTP id o68so91498535qkf.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gforgegroup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NoIwhW4G3CGtvWqvxjyhJ0y1956wBJnDie/yqltRBO4=;
        b=YIfCngoG6KW1W8Af//WHjSLCJuLW2v3d8gOVglR3hjJDm+9OzDZGL04BoIcTUiBHgi
         EGC/dvQOy41broQcsRyGZAvjUaQiH9xP5inQ0oQbxv6bkfMMKbyF36ocuR0d+g4dgV6+
         KYxy6TBWpx9ULyPGrCwceAasta6/XDaLsTWwCTrfu63pnSnRtwR5KeEKRGB5+YZolOZg
         fYZ6UUEaBFsAsnhkgP2KLNijGPWCfdceOQwP8p3aYcBW4deWZHJ6/SH4Pywa9adRCLOa
         tTIUewRLj3hlYkVNr3axvVIo7yPAcEBN7NW2LAz+5XE3KJFz1EBaRwJyyI/y3bdfb7VS
         bueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NoIwhW4G3CGtvWqvxjyhJ0y1956wBJnDie/yqltRBO4=;
        b=meebwrS4imTg+1L4OlsmvF/X9zoCGq8cM8Pm+R1JymHL8dea3hN1xFmcZ908ZIp3Jx
         nchmUI/ms7CS/+ON10RQxHB3eYr290c8FP49IzPC6EOrx2XTVHJ/pdKfExYF3CSSEl9H
         jJJ9jJAsUPKSIeeiui/e3BiZH9oVG91dkZizXiRJmHBRkGfVOPPp3GgiFnhrQGkKz84S
         mO/EXKUKOpf8uGW7Beq5OP5t9mnCNKTWE3eBKB4RXeVPqiIrtC8sqhZA7cxWJ4VH04tn
         IQHfzJWS6JDHe5InjlREYZWj7y4i7F/GF50RzQ8naIgjs1ky7NMn/pz0UTP9rEX1pEdw
         +j3w==
X-Gm-Message-State: AA6/9Rkom6rOqVaioPgL23r7R/hnBn946tSc73/3/UfGd408DUYludICnQrDKgDMXClZ2Em0vIZgwFlIIyB9y/MM
X-Received: by 10.55.26.87 with SMTP id a84mr2185422qka.187.1476293756840;
 Wed, 12 Oct 2016 10:35:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.164.69 with HTTP; Wed, 12 Oct 2016 10:35:56 -0700 (PDT)
In-Reply-To: <20161012164104.zcxpcwqrp5h65qmc@hurricane>
References: <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
 <20161012164104.zcxpcwqrp5h65qmc@hurricane>
From:   Michael Tutty <mtutty@gforgegroup.com>
Date:   Wed, 12 Oct 2016 12:35:56 -0500
Message-ID: <CAOi_75JKPuOhL4BqE8nYkCAN9-wzDkD65TUvN6YDJWkB6HqSAA@mail.gmail.com>
Subject: Re: [PATCH] worktree: allow the main brach of a bare repository to be
 checked out
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have tested this successfully with git 2.10.1 built from source
(failing), then patched as above (passing).
Thanks!
     M.


On Wed, Oct 12, 2016 at 11:41 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> In bare repositories, get_worktrees() still returns the main repository,
> so git worktree list can show it. ignore it in find_shared_symref so we
> can still check out the main branch.
>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  t/t2025-worktree-add.sh | 8 ++++++++
>  worktree.c              | 2 ++
>  2 files changed, 10 insertions(+)
>
> On Sun, 2016-10-09 at 17:52 +0700, Duy Nguyen wrote:
>> On Sun, Oct 9, 2016 at 2:51 PM, Dennis Kaarsemaker > <dennis@kaarsemaker.net> wrote:
>> > On Sat, 2016-10-08 at 19:30 -0500, Michael Tutty wrote:
>> > >
>> > > The only exception seems to be merging to master. When I do git
>> > > worktree add /tmp/path/to/worktree master I get an error:
>> > >
>> > > [fatal: 'master' is already checked out at '/path/to/bare/repo']
>> > >
>> >
>> > The worktree code treats the base repo as a worktree, even if it's
>> > bare. For the purpose of being able to do a checkout of the main branch
>> > of a bare repo, this patch should do:
>> >
>> --snip--
>>
>> You're fast :) I'm still studying  8d9fdd7 (worktree.c: check whether
>> branch is rebased in another worktree - 2016-04-22). But yeah that
>> should fix it.
>
> OK, so here it is as a proper patch.
>
> D.
>
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 4bcc335..2996c38 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -138,6 +138,14 @@ test_expect_success 'checkout from a bare repo without "add"' '
>         )
>  '
>
> ++test_expect_success '"add" default branch of a bare repo' '
> +       (
> +               git clone --bare . bare2 &&
> +               cd bare2 &&
> +               git worktree add ../there3 master
> +       )
> +'
> +
>  test_expect_success 'checkout with grafts' '
>         test_when_finished rm .git/info/grafts &&
>         test_commit abc &&
> diff --git a/worktree.c b/worktree.c
> index 5acfe4c..35e95b7 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -345,6 +345,8 @@ const struct worktree *find_shared_symref(const char *symref,
>
>         for (i = 0; worktrees[i]; i++) {
>                 struct worktree *wt = worktrees[i];
> +               if(wt->is_bare)
> +                       continue;
>
>                 if (wt->is_detached && !strcmp(symref, "HEAD")) {
>                         if (is_worktree_being_rebased(wt, target)) {
> --
> 2.10.1-356-g947a599
>
>
> --
> Dennis Kaarsemaker <dennis@kaarsemaker.net>
> http://twitter.com/seveas



-- 
Michael Tutty, CTO

e: mtutty@gforgegroup.com
t: @mtutty, @gforgegroup
v: 515-789-0772
w: http://gforgegroup.com, http://gforge.com
