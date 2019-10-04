Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8EB1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 12:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbfJDMjc (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 08:39:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43328 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387470AbfJDMjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 08:39:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so4349431lfl.10
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zDXGuRyOcH5NL3raryf46t/rRMeul0nm3v1XP2VU8kY=;
        b=PAR6omly8KZGuF5581qoCKK5AngTG19cd9dxtt3J4EpEyeEYGcyhXkbuwqRWgg7lyk
         sHrJIcK/B8KWXSDjyKLyXqwtuLdgpDMSkIwYzOXglBYlYtS2qvLHJorw8Jxf7sU1rJOb
         9ZFlCQNw5z1jzGKYtMsizIqfP++46TrN+7dYY5PchMP5so5D3pNQpqkjohUuQeelg6vv
         Fv+8hsJeyJ9CpFbgbnOhdAP11jUMblaQaTji5T9PbS5nX+gzQuh2lligVKx0jilUj3yr
         DGwPvun7/warsmWkBSYs3Xr9aGmQr6P1aFe1cgjp0QgaGlVAyMliQ+0e9PCE3zfb6+q7
         0Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=zDXGuRyOcH5NL3raryf46t/rRMeul0nm3v1XP2VU8kY=;
        b=M43aDPM/dbTkqlqP5SKFNCy94iOslIUv1SIZrekl9LuRh9QfkQGCfmUzZ8bCzAflr2
         yMEOV1HcIhvKB2dlYMiScyKZZU5+cH/h6k0cKioj5cfoX1VnUHmExedc56/AU2yEb7/B
         Q4nJgqLyq+CEyPipIvASsaaOk77iNQju+cYCxT26o+vnmZ4XoAx8uCLBjKCoxh3+psRl
         w5mIaUiWK8EyNMXiuFvearCfZXiR9n/91ZE5edEGwZCmZ2hFb+0Hh3gU/3UDADMfNyZi
         yHOSzuvyTgs8XlxS6/jsd/jdg3+SLL1Ykn0M3Xx8S1+9vQ0EWaESwo8gNB+B7BqdgSEG
         V9Zg==
X-Gm-Message-State: APjAAAWKX3GnkzLlgClJbVOHS7qnmDpWNHLRUa92rwMCmFJtxMQAZY7B
        CG0/Xsuy10PGSwP9NsF2RQs=
X-Google-Smtp-Source: APXvYqytKsRibytnghZvsppXjspyDQ1i58lmKYhc73o6WqBb9+EnAjhMc3xI7G46FqvO1qvIuAUlvw==
X-Received: by 2002:a19:da01:: with SMTP id r1mr9213229lfg.150.1570192769928;
        Fri, 04 Oct 2019 05:39:29 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id o15sm1129852lff.22.2019.10.04.05.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 05:39:28 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Pierre Tardy <tardyp@gmail.com>, Elijah Newren <newren@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster\@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
        <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
        <CAJ+soVcmMwy7GgLcV-m1kNEsHYirHMQQeFuEYZanbCNUK4_zHg@mail.gmail.com>
        <1b988670-381b-1c92-069b-3cb66254861c@gmail.com>
Date:   Fri, 04 Oct 2019 14:39:28 +0200
In-Reply-To: <1b988670-381b-1c92-069b-3cb66254861c@gmail.com> (Derrick
        Stolee's message of "Wed, 25 Sep 2019 10:02:16 -0400")
Message-ID: <86tv8oofb3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 9/25/2019 9:36 AM, Pierre Tardy wrote:
[...]
>> And why restrict on DVCS?
>> Isn't it admitted that the distributed version control is nowadays
>> much better in term of software productivity?
>> Is there some use cases that "traditional" centralized VCS are better
>> on, and on which we gave up as a goal?
>
> My intention was "let's be the best at what  Git is good at: distributed
> version control." There are some legitimate reasons why someone would
> pick something like Perforce instead.
>
> Some things, like *file locking*, are just easier in centralized systems.
> I know that Git-LFS created a locking mechanism that pushes even further
> toward a centralized system. However, it relies on users following a
> very careful pattern (lock, pull, edit, push, merge, unlock) to avoid
> conflicts. Further, that only works if you are on a common trunk.
> Release branches or forks do not have this concept.

Well, there is (or perhaps was, as the latest release is from 2013) DVCS
named Veracity that tried to be better than other DVCS in corporate
environment.  It did include file-locking:
  http://veracity-scm.com/
  https://ericsink.com/vcbe/html/veracity_locks.html


But perhaps there would be a better solution to handling file types that
do not support conflict resolution at all than file-level locks: see the
=E2=80=9CGit for games: current problems and solutions=E2=80=9D presentatio=
n by John
Austin at Git Merge 2019:
  https://www.youtube.com/watch?v=3DK3zOhU3NdWA&list=3DPL0lo9MOBetEFqBue4vN=
cTEnkBjgIQU1Q3&index=3D8&t=3D0s

Though the tool mentioned here had not seen any significant development
since Feb 1, 2019 (well, at least in the public repo at GitHub).

From Git Rev News: Edition 48 (February 27th, 2019)
  https://git.github.io/rev_news/2019/02/27/edition-48/

GR> John Austin, game studio technical lead from A Stranger Gravity and
GR> Funomena in =E2=80=9CGit for games: current problems and solutions=E2=
=80=9D talked
GR> about major problem with using Git in game development workflows,
GR> namely many and large binary files, for which file conflicts are
GR> lost work (minor change, like adding voiceover or changing equalizer
GR> settings results in large changes to files). File locking is one
GR> possibility, but it doesn=E2=80=99t play nicely with Git =E2=80=93 it i=
s inherently
GR> centralized. He introduces a new tool, [Git Global Graph][1] (a work in
GR> progress), which can be used to check at commit time if it wouldn=E2=80=
=99t
GR> create a divergent version of a file. The idea is that there should
GR> be only a single path through commit graph with changes to binary
GR> files.

[1]: https://github.com/Kleptine/gitglobalgraph


Best,
--=20
Jakub Nar=C4=99bski
