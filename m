Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C962200B9
	for <e@80x24.org>; Mon,  7 May 2018 22:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeEGWZC (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:25:02 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33396 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeEGWZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:25:01 -0400
Received: by mail-yw0-f171.google.com with SMTP id g16-v6so9098404ywk.0
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JVYbeoncL5vc5UFKSidn6ZvWLnaPT35t8gQcppf/8Rs=;
        b=mkXqH2WfWy6AGF6Zqdhk6EEBVcw5IwDRrJW7w8d9WyMZiG59A7eVPGXpkGDIwXBCv1
         5YfTOgcbOlWO3tp6lqqhqPVb5L0w8u7QjJgXWWNXplKswjl8mmw1rMsJ6S4yy4QRpozI
         xauWMhM5gzBWXfXWZC1Rk8RM0WkE+Mblvy2EX+WCXITOJyaB+U131Yuq4YFMpdEvZRUX
         RXwBkOcSvouYYpHThIqhqtz/1oZxKayMMNCD6eLrSNelSEdWI617Z/uLqUEJljFsNYFy
         W1XCKbrWW9N/Jtr1dZfXJffNy1V3wJJIgvK/e/1ZlGpycp8aBXZ8DQ/xRuZPupxJ1Vbl
         /R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JVYbeoncL5vc5UFKSidn6ZvWLnaPT35t8gQcppf/8Rs=;
        b=sqQUUorcWf4QOIetk6xNwPblF5rmpaWL+kKlhBNIb71+7/gdx2ptNeK9YvMyd8Z13c
         l1FdA6ZEox+9AtOW7WcVySPZ13XMhDtqSeZxpH27lRYIxrMoTnu/gw4Bc6ikisKizytu
         aCW/5UIYL2RzyJ1NWnc8uOyAOkFgZbZjvVATnuiLsGLiltkfCklQJAbuVrdSIVOcecev
         X+rXL6BydVrHE7ThDVEr+8JkM/4Rpj0o6rxu7vQ+Kthb5S4WVN6BB2F4WN8FFJn09ZvR
         3VB6xReFWUSlTS6tik2lb+VH1IBC9yQHpYQJEBAqpD3L3kQvJAIbY0KUQu+jbAENrKVB
         GrGQ==
X-Gm-Message-State: ALQs6tCJkQzdRHaK++6RbDBJIdeLSVL7CtiimyQTkM650LjrRWyIaC1V
        CZ1s8/XEF3zvFNH1ztwJS+awS/E0+TKOafT51c0Brg==
X-Google-Smtp-Source: AB8JxZq78UURW5kRki6bg0CD+F0wpRgvzAQESQJBmNkauEujLWSjpfF4+0fxa5jais3iLITCQ95VNiVEF25M0Xj/NAY=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr21530322ywa.340.1525731900184;
 Mon, 07 May 2018 15:25:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 7 May 2018 15:24:59 -0700 (PDT)
In-Reply-To: <3b4591cd-6dde-31ee-f0b1-42b5353086e5@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com> <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
 <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com> <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet>
 <3b4591cd-6dde-31ee-f0b1-42b5353086e5@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 May 2018 15:24:59 -0700
Message-ID: <CAGZ79kZbRCH2OiTW1Ge31R9JN+vWD6tcjNWVGSzkSBcYZvwDjw@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 7, 2018 at 3:05 PM, Igor Djordjevic
<igor.d.djordjevic@gmail.com> wrote:

> List, rename, delete -- all these seem more as basic CRUD operations,
> where comparison is a more complex one. And not to get me wrong - I
> could see "branch diff" being part of "branch", but not really when
> "diff" already exists as a separate thing, already doing quite some
> (but still diff related, and configurable) stuff.

If we go with "branch --diff", because it has the CRUD operations already
there for branches, I might ask for "remote --diff" to diff two remotes. ;)
(That command "remote --diff" would not make any sense, would it?)

> Basically, what you (conceptually) call "two versions of the same
> branch", I simply call "two branches" (from usage standpoint).

If I diff 2 (topic) branches, which are based on a different version
from upstream, then I see changes from commits that I don't care
about, but this tool explicitly excludes them. Instead it includes
the ordering of the commits as well as its commit messages to
the diff.

So I would not say this tool "diffs two branches", as that is understood
as "diffing the trees, where each of the two branches points two",
whereas this tool diffs a patch series, or if you give Git-ranges,
then it would produce such a patch series in memory.


> And you may have a branch that got split, or more of them that got
> unified, so defining "previous branch version" may not be that
> straightforward - it`s really just "two commit ranges" (as man page
> defines it in general), with "two versions of a patch series" only
> being the most common/expected use case of the former.
>
> Finally, if user picks two totally unrelated "branches" to compare,
> he won`t get a really useful diff - but it`s the same as if he would
> compare two totally unrelated commits (where tree state massively
> changed in between, or having unrelated histories, even).

I used just that, but narrowed down the comparison to one file
instead of the whole tree.

> With something like `git diff --branch <commit1>...<commit2>` you
> would get yet another "diff look", useful for use case in question
> here.

Personally I think this patch series should neither extend git-diff
nor git-branch.

It should not extend git-diff, because currently git-diff can diff
tree-ishs (and does that very well) and comparing to
worktree/index.

It should also not extend git-branch, as that command is for
CRUD operations that you hinted at earlier (Earlier I proposed
git-remote --diff for diffing two remote, which makes no sense,
another one might be git-worktree, which also just does CRUD
for worktrees. It would be a bad idea to have "git worktree --diff")

Hence I propose "git range-diff", similar to topic-diff, that
was proposed earlier.

* it "diffs ranges" of commits.
* it can also deal with out-of-git things like patch series,
  but that is a mere by product and may not be desired.
  Just like git-diff can also compare two files outside a git
  repo, that would not be a good use case.
  Keep the name Git-centric!
* it autocompletes well.

Stefan
