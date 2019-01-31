Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8221F453
	for <e@80x24.org>; Thu, 31 Jan 2019 05:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfAaFzR (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 00:55:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37745 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfAaFzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 00:55:17 -0500
Received: by mail-io1-f65.google.com with SMTP id g8so1641421iok.4
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 21:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8xrUBzNPS4i4udMgjnbHIg3nXRpvy/ReNOUi0/eZkI=;
        b=ea0I/p1wD3EfSvyCbOZVxnWqb5JkcMIqFWH7s9hOflK0DJ5vbuMETkjvBdI0ybG8Hn
         YHww+9sWl/zWEK19QEfOeiLOxbu2zEKNrWEzo+BkkHYGHbIaI96s+Wca2svdujXj/8Ok
         4yJ9yfLdSgdcQULSHskJPsTO8xzKN/9iE2nye6DGkJ/CzScqbwU5vKS6WyoSpn1cm9s+
         epszsS1kn4rt0mt82L9/puVCHHVjnaCT4oc5d18gyvuZRAeLyWq8YkxnI0MNAaG1NMAb
         VUdOfYPygy+DZzM8eWv6g2mOF3z4v5jIFUpKzzakbHk8ETWsnwBldyi0vu1+mcv/WlnI
         8BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8xrUBzNPS4i4udMgjnbHIg3nXRpvy/ReNOUi0/eZkI=;
        b=GU4QCi5Sf6rfPd7aoxHAI+N0JG9aikzm/CNdXQCMmYZJ4l1UXwXphfVRjKKaC1gyiQ
         MUKZqlMjFQsfwujmW15WQ4Wbwkt/PCOcZh4dh39pQ5AICYt2BoYVxr2Fn65sjriYpird
         6tH7hCzi0OOR7flaYF3eXYw5FNkOjQ4+XSzzwvZShnK0pOUNWyViAAUqB0xHQIgWcM1f
         e07mTcTPrZ7zU8aVhht85oSGgUs5opOPsaIQAeMCT27L7No9+0LFlJa5cyB4cxP/hcTV
         7Wv4jC+48QRolz+IhmE2c/mKP80OYDcWyywnc9vJ9w0AjNSmKZCtnzOgIac0oYM2aH06
         uc7Q==
X-Gm-Message-State: AHQUAuYMXMTs41MQJCgEALRcIY+y2gFtFOtY6MIQWi7uPYuTsMiLe+yj
        remOL+z5qlU2qvC1/azPWnvTcMUVJyeY92DH+J8=
X-Google-Smtp-Source: AHgI3IZemoRh/cU1Cx2Mn+6CGexkEfbf7WIPgoJcopBLgwefczTR/QUOD1GpzCF4EjCXbS7byJ+lxbjU8oWB1eCt3a8=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr16437252ior.282.1548914116454;
 Wed, 30 Jan 2019 21:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
In-Reply-To: <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 31 Jan 2019 12:54:50 +0700
Message-ID: <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 2:23 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Dec 11, 2018 at 7:12 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Dec 10, 2018 at 7:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Duy Nguyen <pclouds@gmail.com> writes:
> > >
> > > > Elijah wanted another mode (and I agree) that modifies worktree but
> > > > leaves the index alone. This is most useful (or least confusing) when
> > > > used with <tree-ish> and would be default in restore-files. I'm not
> > > > saying you have to implement it, but how do the new command line
> > > > options are designed to make sense?
> > >
> > > I'd model it after "git apply", i.e.
> > >
> > >         git restore-files [--tree=<treeish>] <pathspec>
> > >
> > > would work only on the working tree files,
> > >
> > >         git restore-files --tree=<treeish> --cached <pathspec>
> > >
> > > would match the entries in the index that match pathspec to the
> > > given treeish without touching the working tree, and
> > >
> > >         git restore-files --tree=<treeish> --index <pathspec>
> > >
> > > would be both.
> > >
> > > I have never been happy with the phraso, the (arbitrary) distinction
> > > between --cached/--index we use, so in the very longer term (like,
> > > introducing synonym at 3.0 boundary and deprecating older ones at
> > > 4.0 boundary), it may not be a bad idea to rename "--index" to
> > > "--index-and-working-tree" and "--cached" to "--index-only".
> > >
> > > But until that happens, it would be better to use these two
> > > consistently.
> >
> > I agree that consistency is important, but trying to distinguish
> > between "--cached" and "--index" is _extremely_ painful.  I still
> > can't keep the distinction straight and have to look it up every time
> > I want to use either.  I don't know how to possibly teach users the
> > meaning.  Could we introduce synonyms earlier at least, and make the
> > synonyms more prominent than the "--cached" and "--index" terms in the
> > documentation?
>
> For git-checkout I think --index and --cached fit. For restore-files,
> if you come up with better names, I'll gladly use that. Otherwise I'll
> just use these.

I've changed my mind. I'm not using --index and --cached for "git
restore" (formerly "git restore-files"). So how about this?

git restore --from=<tree> <pathspec> will update both the index and worktree.

git restore --from=<tree> --keep-index <pathspec> will not update the index

git restore --from=<tree> --keep-worktree <pathspec> will not update worktree

And I'm thinking of adding these to "git reset" too. It will have the
forth form:

git reset [--keep-index] [--keep-worktree] [--keep-nothing] [<commit>]

which is similar to --soft, --mixed and --hard, but with better names:
--soft is --keep-worktree and --keep-index, --mixed is --keep-worktree
and --hard is --keep-nothing (i.e. the only change is HEAD).

Although, if I work it out, I might just ignore "git reset" and make
sure "git switch" and "git restore" can do whatever "git reset" can
then remove its "common command" status. This part is more thinking
out loud, but "git switch" can have a new form

git switch --reset-branch [--keep-worktree] [--keep-index] <start-point>

which resets "HEAD" (and switch of course) but do not enter detached
mode. This covers a common use case of "git reset [options] <commit>".
Then either "git restore" learns about "--abort-in-progress" to abort
cherry-pick/merge/revert, or those commands have a new --abort and
--quit option...
-- 
Duy
