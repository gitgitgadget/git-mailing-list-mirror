Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A344A20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 21:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbeLJVdc (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 16:33:32 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39325 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeLJVdc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 16:33:32 -0500
Received: by mail-ua1-f67.google.com with SMTP id k10so4381651ual.6
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjMtNbgGriBEJWqpF/+Nvfwooe9Hjb0ffp6hPblkZOQ=;
        b=MD27/1HC6RSU9dj/Qhj77+is36abAZrGY9QDO+yHOX8l6XGOwlpBpNZ+Zo7GybdPtm
         7P143gSqfwv0BI76ucrsbVVw6SbBtwxVvX2DhVnOpKjQc70H+hyNRSnwCZljwNxBGgp3
         CcUb69pWp27rOizQ/f0+CWomDqgWr3Ep5niu+XMtxAajqhTNT7BdtWNWAKpsagzjPkaI
         dAajM6L/9JwkViVxx/v2oJhSy1G1Sivm2oBPVPiPNzhAnX7XM9EYSkp+q2C10+obCpq+
         dtPG0kN1Lu5umidLrnXlJFhWa44wXSBdFQqVAIUn5OIZrnOaROHl9kqMwRvqwX2XMuwg
         lMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjMtNbgGriBEJWqpF/+Nvfwooe9Hjb0ffp6hPblkZOQ=;
        b=hZab+Pb8nNFcB05GUVLryjUR5cc4qaVi1tQlqg3yovIPV0x+JjnukEO6YPznmo/QF5
         3htkDzhk3fXXG/LNX9AnOVFHgQ25ZvYLbFz6JUKKwbGWC70SOQ+iPoqugt4FgCF+fgwY
         TLczGDbdjfdGcRgMeGBjnl6YOZr081JbdsnPpDsp18aB3UpkjFA8NwX6rYbiJPaQTbJL
         hv5LsX3DcxfvRv3+agjrnc8xesYVnmrybLoN2dUUWHa0pefxiWM28fjvi9PmBwrK8Lol
         onXFNIv8cOWd0Q/U9ZgBUZ7uraUgRNE+s+54gEW74WuOP89NUOT49SyYbXEidgTrKpll
         NdqQ==
X-Gm-Message-State: AA+aEWbDyo3Og25HWxZ13nYmsuSSkmJ0kKregGB4OPTWBIJUxO8OxsRU
        G5EtVcnydCEtmAsonlBcSR9IxOlxlQhCgtqgidk=
X-Google-Smtp-Source: AFSGD/Wp9d0E5iDIGoKiGera8jRky3to5lKY8eSr9ZrzqY3bbmGIwtPswnvA4EPwVbLqoIWOhcMqQeMw8qFlvnycMcY=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr6311574ual.20.1544477610745;
 Mon, 10 Dec 2018 13:33:30 -0800 (PST)
MIME-Version: 1.0
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
 <CAGyf7-FUHMEq_FfPNrH6uT2b-nCd_wi=Aww+OUuoDem11DROGA@mail.gmail.com>
 <CADHAf1Y8or_frf=Ecu-82z-jo06NKe7oqo1cxtsZsOxhKKxjAw@mail.gmail.com> <20181207072004.GA32603@sigill.intra.peff.net>
In-Reply-To: <20181207072004.GA32603@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 13:33:18 -0800
Message-ID: <CABPp-BHjR7Wq-D9tFMyPHZE1ogL5udOt8ri1rN3E1CasfD-2PQ@mail.gmail.com>
Subject: Re: Retrieving a file in git that was deleted and committed
To:     Jeff King <peff@peff.net>
Cc:     biswaranjan.nitrkl@gmail.com, Bryan Turner <bturner@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 6, 2018 at 11:48 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Dec 06, 2018 at 11:07:00PM -0800, biswaranjan panda wrote:
>
> > Thanks! Strangely git log --follow does work.
>
> I suspect it would work even without --follow. When you limit a log
> traversal with a pathspec, like:
>
>   git log foo
>
> that is not about following some continuous stream of content, but
> rather just applying that pathspec to the diff of each commit, and
> pruning ones where it did not change. So even if there are gaps where
> the file did not exist, we continue to apply the pathspec to the older
> commits.
>
> Tools like git-blame will _not_ work, though, as they really are trying
> to track the content as they walk back through history. And Once all of
> the content seems to appear from nowhere in your new commit, that seems
> like a dead end.
>
> In theory there could be some machine-readable annotation in the commit
> object (or in a note created after the fact) to say "even though 'foo'
> is a new file here, it came from $commit:foo".  And then git-blame could
> keep following the content there. But such a feature does not yet exist.
>
> -Peff

Hmm...sure, if the file is deleted on the only relevant branch through
history...but what if there were another branch where it weren't
deleted?  What does git blame do then?

In other words, do NOT restore the file as biswaranjan suggested, but
instead restore it this way[1]:

git checkout -b keep-foo $REVISION_BEFORE_FOO_DELETED
git commit --allow-empty -m "We want to keep foo"
git checkout A
git merge --no-commit keep-foo
git checkout keep-foo -- foo.txt
git commit


Now, when you run
  git blame foo.txt

blame should notice that foo.txt didn't exist in the first parent
history on A, so it won't bother walking it to find that at some point
foo.txt did exist there.  Instead, it'll walk down the second parent
and follow its history, where it should keep walking back and show all
the old changes...right?  Or did I mess up my testcase and
misunderstand something somehow?


Elijah

[1] Sidenote: it seems like those commands I gave should have simplified down to

git merge --no-commit --no-ff $REVISION_BEFORE_FOO_DELETED
git checkout $REVISION_BEFORE_FOO_DELETED -- foo.txt
git commit

But that seems to error out with "Already up-to-date"...even when
testing with older versions of git, so it wasn't any of my changes.
Not sure why the --no-ff flag doesn't work.
