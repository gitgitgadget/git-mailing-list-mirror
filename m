Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759E41F453
	for <e@80x24.org>; Sat, 29 Sep 2018 23:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeI3FaY (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 01:30:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36472 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeI3FaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 01:30:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id p89-v6so8945098ljb.3
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZFmdKZLmpqoMimv6idFEi/1pFwVv6sfbHggZAWIH72w=;
        b=jozG38gXiKGOmgvV9MSs9e8ip5b7Q3JG4A+q0owgj7qfK+dQKAScpFHMDiuYX2DFUb
         Y66O0K5OBBY/Gj4G5C2iJ6rN745lVCBFroJhSYwbQcHmU141BMw+8iHYf7vCgZgTi2zR
         TGhYlBPdQSw3izx1irIAi8977kIfVTb9WNcui6wWgkA4KNV0C9zDESB1CTUc6i2jNtQp
         S5pdCcmvvvOjYQuTt6yeTzYP19waQD4mGWtNbIuernFPnUk5A1u7f7o5/zwS8OUrh8YN
         HVZKGhyb92RNYA/LHUdqpnTONWX7j/0XeVJ2tmcwfGiFxF5rGy7X/RySjhQIdXUTPAOH
         hdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZFmdKZLmpqoMimv6idFEi/1pFwVv6sfbHggZAWIH72w=;
        b=c4sGn8gEtKNO0PSVchT5jd11Z7Vyf7GPFhqS9BMiTrAeS0aEnksYGhG0iIh1fCflux
         tFgs18RFT1Cc/KrEhVu3gGAAX0WblMnVSRp6IotkhZ3tWjwOWsY5HjWbv6vwRN1zUTf+
         s4F4AZgf3lconisoX/6mem6q+nKO5TAPx6TIf8bPO69tTx3NY+6rdDxl7sfWabvSgG/J
         Rn23EkInO9sjA2FR3AQFBCn//aBeOmCMTUq7gg31tvThmGFDDhlahlfk8uoLMfRiF85z
         s8+yzxa6G5REGXwMPLMDPhH04RxuGMjPTiJkEH3SuS4wBAxdw7ApMKnlPF+5LeFevKMA
         pb7Q==
X-Gm-Message-State: ABuFfogbw8I6kpvELvT7iiOs8HWOn3i/M5/HLc0DsXxUxhCjjqJ8QDu3
        PkTqtnAppjXUrQYXZOtmSfiuV0cpBfV1Af9mNJ+8LghtrToMlA==
X-Google-Smtp-Source: ACcGV61ojrjtUaIk66F9j7vvwd1cSicnjWkaMoUqiw4PXslCKavSXWY1aZCm/iRPyCS+LNFYtOmXLeVc+pJRB74p2jw=
X-Received: by 2002:a2e:99d3:: with SMTP id l19-v6mr2323864ljj.132.1538262004627;
 Sat, 29 Sep 2018 16:00:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:2e13:0:0:0:0:0 with HTTP; Sat, 29 Sep 2018 16:00:04
 -0700 (PDT)
From:   Stefan Xenos <sxenos@google.com>
Date:   Sat, 29 Sep 2018 16:00:04 -0700
Message-ID: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
Subject: Git Evolve
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, List!

I'm interested in porting something like Mercurial's evolve command to
Git. I'll be following up with a formal proposal shortly, but before I
do I thought I'd introduce myself to the list and find out if anyone
else is interested in this topic.

What is the evolve command?

Imagine you have three dependent changes up for review and you receive
feedback that requires editing all three changes. While you're editing
one, more feedback arrives on one of the others. What do you do?

The evolve command is a convenient way to work with chains of commits
that are under review. Whenever you rebase or amend a commit, the
repository remembers that the old commit is obsolete and has been
replaced by the new one. Then, at some point in the future, you can
run "git evolve" and the correct sequence of rebases will occur in the
correct order such that no commit has an obsolete parent.

Part of making the "evolve" command work involves tracking the edits
to a commit over time, which could provide a lot of other benefits:

- Systems like gerrit would no longer need to rely on "change-id" tags
in commit comments to associate commits with the change that they
edit, since git itself would have that information.
- You could directly view the history of a commit over time (ie: the
sequence of amends and rebases that occurred with that commit,
orthogonal to the history of the branch it is on). If you've used
mercurial, this would be a git equivalent to "hg obslog". If you've
used gerrit, this would be like the gerrit "change log" but it would
work for all commits and work offline.
- You can easily list all the changes that you have as works-in
progress. If you've used gerrit, this would be an offline equivalent
to the gerrit dashboard.
- You could choose to share the history of a commit with others, or
collaborate on and merge different variants of the same change.

Some information about Mercurial's evolve command can be found here:
https://www.mercurial-scm.org/doc/evolution/

Other similar technologies:

rebase -i can be used to solve the same problem, but you can't easily
switch tasks midway through an interactive rebase or have more than
one interactive rebase going on at the same time. It also can't handle
the case where you have multiple changes sharing the same parent that
needs to be rebased and won't let you collaborate with others on
resolving a complicated interactive rebase.

patch queues (topgit, stgit, quilt) address a very similar problem,
however since they're built on top of git rather than integrated with
it, most of them end up managing extra state that can get easily
damaged whenever you run a native git command that doesn't know about
the patch queue. Most of them also have various workflow problems that
aren't present in hg evolve.

Is anyone else interested in this? Please email me directly or on this
list. Let's chat: I want to make sure that whatever we come up with is
at least as good as any similar technology that has come before.
