Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4651F424
	for <e@80x24.org>; Thu, 21 Dec 2017 18:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbdLUSzz (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 13:55:55 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:40684 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbdLUSzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 13:55:54 -0500
Received: by mail-qt0-f172.google.com with SMTP id u42so33614839qte.7
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wY9cVRStrJjPrC6Rj8QMeCF8UzyVPHdXsEJT0uUlsUQ=;
        b=cDwJCAW1ugQO+nK58NdZvYDGGZ0mztTy94j1Nx9WSpEIyj+snzCmtNQglSt5IYpNeR
         SiI0EiDtyTzyA3POumhXAs9qfNRFKOMYJTrDIBUX1wOiImFALh9pkf9K7NB/Kqu+T2Gq
         M0MPCKwjUfaeRv6VF48xly24UJypxlDB79gxDFYfvreg4zd9ozW+KqzYtxCg6ynVt6Za
         HDs4lxIG8Y5PWovOhxHc6dOranmSNVXKsAkjza/bd8wwv8hUPKMDuXYqZ4GnVGXSq4ZZ
         jYqlwbBOXRof7pyWrUrLeQ4EsJZrwC6qADVaghX8ult3jmDoCq2OFEZkvP5X0ngxlixx
         XP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wY9cVRStrJjPrC6Rj8QMeCF8UzyVPHdXsEJT0uUlsUQ=;
        b=AgPZ8lsjALEAufdyovQr2QD4wcy/dSQnAGa7QgViZEHsiLm6qQOI2a+187r1rAWFli
         7K2AlL13IAsUQLvX910YLMb6pLKO8Ko3WAsUoRTunJkp/9jhV6xX8zZrYoznqaS6mjMu
         GkTTULAFwhThhO+pDVYYQkFXP3sJE96DyaPlIC6gi8OMlH2RiJ6LjrKbENw7cMY3P+Yq
         kxjyEKTLtoKfKQiwMtcxwMEcrzYSpscdTVsUnUFr7it0sg+3dQC/7sUPD+7GB1sykKox
         ZOrm3mtTH9zdUsrP2rWqs1SgrbKn3UKjLWEx1NfsG/oifI2e1ETBC9/IpIvg/55zpAzn
         3Sxw==
X-Gm-Message-State: AKGB3mIGd8PYMGxmDKBvncM7NxhGkPthopBE+rvGWBx0zIffJCu2VjpU
        j+CEsyL6UZV37t54pu5XQorto2x+HpVUrnK4I96ovA==
X-Google-Smtp-Source: ACJfBotlJ3czM5dRhZY0/uDc73mVGlLDtAGjj119UWtpA3fEwN3bVqVcYXndxqOz2Z5PkzXX78fNbPppwaJhtDV+InE=
X-Received: by 10.237.61.181 with SMTP id i50mr17161967qtf.29.1513882553663;
 Thu, 21 Dec 2017 10:55:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 21 Dec 2017 10:55:52 -0800 (PST)
In-Reply-To: <CAFBGMVMmLX4BjkQ8Xd4bQBCgoYYxWTU-p2pNF=b8JNsUsKXwUA@mail.gmail.com>
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
 <20171219180230.254881-1-sbeller@google.com> <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbqntXuYuLGF7zjXfQ5X998QdEba20yy8A0cqS=DaRxFA@mail.gmail.com>
 <CAFBGMVO+P99hJ_nKgCJ4OqhMEdRdc3m8KHNS1pPrrhU_0wS6=A@mail.gmail.com>
 <CAGZ79kZf8GL1DY6Vmc-byEOOy+hrKF8X8qRPM6jNO-La+rD4uw@mail.gmail.com> <CAFBGMVMmLX4BjkQ8Xd4bQBCgoYYxWTU-p2pNF=b8JNsUsKXwUA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Dec 2017 10:55:52 -0800
Message-ID: <CAGZ79kauYRLaPKsUKxvsc-T+KzMt2UsyoDLzdyZON_vjp6y28w@mail.gmail.com>
Subject: Re: [PATCH] Re: Bug with "git submodule update" + subrepo with
 differing path/name?
To:     Andreas Urke <arurke@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 21, 2017 at 8:21 AM, Andreas Urke <arurke@gmail.com> wrote:
> If I am entering into undefined behavior territory with the renaming
> then there might not be any point to pursue this further, but in any
> case, script below:
>
> Apologies up-front for the verbosity, there are probably a lot of
> unnecessary steps and git shortcuts missed - I just wanted it to
> exactly match my scenario. Note that it is divided into two parts as
> it requires you to edit .gitmodules.
>
> Part 1:
>
> cd ~/
> # Make sub repos and add a commit to each
> mkdir super && cd super
> mkdir sub1 && mkdir sub2
> cd sub1
> git init && touch first && git add . && git commit -m "first"
> cd ../sub2
> git init && touch first && git add . && git commit -m "first"
> cd ..
>
> # Make super repo, add subrepos, and commit
> git init
> git submodule add ./sub1
> git submodule add ./sub2
> git add .
> git commit -m "first"
>
> # Edit .gitmodules, change sub2 name and path to sub2_newname:
> # $ cat .gitmodules
> # [submodule "sub1"]
> # path = sub1
> # url = ./sub1
> # [submodule "sub2_newname"]
> # path = sub2
> # url = ./sub2_newname
>

A couple of things here:
(a) In a script you could do this via
    git config -f .gitmodules --rename-section <old> <new>
(b) This is not just undefined, but rather Git explicitly assumes
    the user does not rename the section themselves.

The reason for this is found in gits history:
1. submodules were invented
2. submodule configuration such as where to obtain
    the submodule from needs some place, and at the time
    submodule.<path>.url inside the .gitmodules file seemed
    like a good idea.
3. "What if we want git-mv, git-rm support for submodules?"
    Or for example when bisecting and jumping between revisions
    where the submodule exists or does not exists. To solve
    this problem, the concept of a "submodule name" was invented,
    such that the submodules git dir can be put into the
    superprojects .git/modules/<name> dir, and the working tree
    only needs to have a ".git" file pointing at that gitdir. The the
    working tree of the submodule can be removed while keeping
    the submodules git dir (with potentially important information
    such as local-only commits) around! Success!

    The transition path is also easy:
    These newly "named" submodules have an additional entry of
    'submodule.<name>.path =<path>'. Note how the subsection
    part of the config changed its meaning, but that is ok, as the
    name is allowed to be equal to the <path> value, and keeps
    all config related to one submodule in one section. Easy but
    confusing as now we have to adhere to a couple assumptions:
    The <path> value must match where it is in the working tree,
    the <name> however must not be changed because that is
    where we'll find its repository inside the superproject.
    And confusingly these two keys have often the same value,
    for this historic reason.

4. (rather lately): We need to fix the submodule mess.
    While in (3) we were unclear about name/path issues,
    and tried to be super backwards compatible, now we'd
    rather want the submodules to be well-defined. So we'll
    try to write some docs, such as gitsubmodules [1] in addition
    to the usage manual of "git submodule"[2]. Of course there is
    still the description of the .gitmodules file[3].

[1] https://www.kernel.org/pub/software/scm/git/docs/gitsubmodules.html
[2] https://www.kernel.org/pub/software/scm/git/docs/git-submodule.html
[3] https://www.kernel.org/pub/software/scm/git/docs/gitmodules.html

I guess in [1] we'd want to add a discussion on what the <name> and
what the <path> is for and why one can change but not the other.

I think you ran into trouble here because you and Git had
differing assumptions on some part of the submodule model.
Is there any part of the documentation, configuration or some
commands that would have helped explaining some of these things?
(i.e. What do we best patch to help others from running into the
same issue?)

Thanks,
Stefan
