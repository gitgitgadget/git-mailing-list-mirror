Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DBF71F404
	for <e@80x24.org>; Sat, 17 Mar 2018 19:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753735AbeCQTOn (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 15:14:43 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36804 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeCQTOl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 15:14:41 -0400
Received: by mail-wr0-f181.google.com with SMTP id d10so14756618wrf.3
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=likRHBGauv+3DRv+x3n5/BwsE6Es/ZdrEdrXMmJSwSo=;
        b=FkD4eORpA+FqlunaRDaEBZj10PTYW+k9klItuAiYgThVi0lQDOmXsq61eO/A2i6sle
         ahcCaPuUduEb7LCYlSfsW0GPkI6JyaSy+XZBJWm8gqttlNSK05eOn09YwnytVuIo1+qg
         I+WKD9qGUDXpn3v1b/DYFErmz6mNJelv7E5ispuJtYFAznoc91HCE+NMtucLRo7W9qds
         UH5NS2IQy2WteLiUimMGzxu+XS77P+gKOSYlmbAHr0EKePt2BkWwTWOe3hfwdR1eHfNn
         24j/HK4GsuyikcKFLK+ykKiig9i+qYM/jzNLhDmJ3+P7Dgk4FbDDdvsDCJmvx1dO8DvQ
         nUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=likRHBGauv+3DRv+x3n5/BwsE6Es/ZdrEdrXMmJSwSo=;
        b=l3AkX4qi5qNgx4r2P+2P7HWFLHnqHKmypv38KL6+RD3DTAbVMcbaub8rXSnvK3X0m/
         QXxEso5v2vpfZDfxc66F98bG9ICvlURlec0P9Ncg/XuU5IpRh9gSeqBtZtDRtl54SBJz
         4vllIIWkiENUwuC5zsxplznEB0uLsbzz1SCX7UEOPFt8uQfmn3CoJF0nQXwhA+ekjXaF
         4Od7RbFdL+L1dJ5oPauqXOzfm7UKSg0FVepaclx9PT3deIdvO8v2FHj4zsep3TeL/r1X
         0lOJRddWo801QnMDomxfDDUtrJKp0hToDpl1mAtXyAthEvZZEGhC0Ik0LJNK5co/8D34
         bwgA==
X-Gm-Message-State: AElRT7GV7SiDo3HgXxqWpNqUevr43pw1QUDYhIx30V1Gwqzj1E/pk01m
        lYOK2Qf3oA993lGdiN76upP/fwZfo10=
X-Google-Smtp-Source: AG47ELvq86pi645TMIiUV99KupY85mvIBQVjaSlPfBmTYnNVyxl4dVzYDXkKltvpzSvM5ZKldnIeCg==
X-Received: by 10.223.186.140 with SMTP id p12mr5067308wrg.162.1521314080240;
        Sat, 17 Mar 2018 12:14:40 -0700 (PDT)
Received: from andromeda.localnet ([92.184.102.143])
        by smtp.gmail.com with ESMTPSA id p79sm10973544wmf.34.2018.03.17.12.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 12:14:39 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC][GSoC] Project proposal: convert interactive rebase to C
Date:   Sat, 17 Mar 2018 20:14:29 +0100
Message-ID: <2564070.6kGkNsz7Qa@andromeda>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here is my first draft of my proposal for the GSoC, about the "convert=20
interactive rebase to C" project. Any feedback is welcome :)

=2D--
ABSTRACT
git is a modular source control management software, and all of its=20
subcommands are programs on their own. A lot of them are written in C, but =
a=20
couple of them are shell or Perl scripts. This is the case of git-rebase--
interactive (or interactive rebase), which is a shell script. Rewriting it =
in=20
C would improve its performance, its portability, and maybe its robustness.


ABOUT `git-rebase{,--interactive}`

git-rebase allows to re-apply changes on top of another branch. For instanc=
e,=20
when a local branch and a remote branch have diverged, git-rebase can re-un=
ify=20
them, applying each change made on the local branch on top of the remote=20
branch.

git-rebase--interactive is used to reorganize commits by reordering,=20
rewording, or squashing them. To achieve this purpose, git opens the list o=
f=20
commits to be modified in a text editor (hence the interactivity), as well =
as=20
the actions to be performed for each of them.


PROJECT GOALS

The goal of this project is to rewrite git-rebase--interactive in C as it h=
as=20
been discussed on the git mailing list[1], for multiple reasons :

Performance improvements
Shell scripts are inherently slow. That=E2=80=99s because each command is a=
 program by=20
itself. So, for each command, the shell interpreter has to spawn a new proc=
ess=20
and to load a new program.

Those commands can be other git commands. Sometimes, they are wrappers to c=
all=20
internal C functions (eg. git-rebase--helper), something shell scripts can=
=E2=80=99t=20
do natively. These wrappers basically parse the parameters, then start the=
=20
appropriate function, which is
obviously slower than just calling a function from C.

Other commands can be POSIX utilities (eg. sed, cut, etc.). They have their=
=20
own problems (speed aside), namely portability.

Portability improvements
Shell scripts often relies on many of those POSIX utilities, which are not=
=20
necessarily natively available on all platforms (most notably, Windows), or=
=20
may have more or less features depending on the implementation.


APPROXIMATIVE TIMELINE

Community bonding =E2=80=94 April 23, 2018 =E2=80=93 May 14, 2018
During the community bonding, I would like to dive into git=E2=80=99s codeb=
ase, and to=20
understand what git-rebase--interactive does under the hood. At the same ti=
me,=20
I=E2=80=99d communicate with the community and my mentor, seeking for clari=
fications,=20
and asking questions about how things should or should not be done.

Weeks 1 & 2 =E2=80=94 May 14, 2018 =E2=80=93 May 28, 2018
=46irst, I would refactor --preserve-merges in its own shell script, as=20
described in Dscho=E2=80=99s email.

Weeks 3 & 4 =E2=80=94 May 18, 2018 =E2=80=93 June 11, 2018
Then, I would start to rewrite git-rebase--interactive, and get rid of git-
rebase--helper.

Weeks 5 to 9 =E2=80=94 June 11, 2018 =E2=80=93 July 15, 2018
During this period, I would continue to rewrite git-rebase--interactive.

Weeks 10 & 11 =E2=80=94 July 16, 2018 =E2=80=93 July 29, 2018
In the second half of July, I would look for bugs in the new code, test it,=
=20
and improve its coverage.

Weeks 12 =E2=80=94 July 30, 2018 =E2=80=93 August 5, 2018
In the last week, I would polish the code where needed, in order to improve=
=20
for performance or to make the code more readable.


ABOUT ME

My name is Alban Gruin, I am an undergraduate at the Paul Sabatier Universi=
ty=20
in Toulouse, France, where I have been studying Computer Sciences for the p=
ast=20
year and a half. My timezone currently is UTC+01:00, but will be UTC+02:00=
=20
starting from March 25th, because of the daylight saving time in Europe.

I have been programming in C for the last 5 years. I learned using freely=20
available resources online, and by attending class ever since last year.

I am also quite familiar with shell scripts, and I have been using git for =
the=20
last 3 years.=20

My e-mail address is alban <dot> gruin <at> gmail <dot> com. My IRC nick is=
=20
abngrn.

My micro-project was "userdiff: add built-in pattern for golang"[2][3].

=2D--

You can find the Google Doc version here[4].

Regards,
Alban Gruin

[1] https://public-inbox.org/git/alpine.DEB.2.20.1609021432070.129229@virtu=
albox/
[2] https://public-inbox.org/git/20180228172906.30582-1-alban.gruin@gmail.c=
om/
[3] https://git.kernel.org/pub/scm/git/git.git/commit/?id=3D1dbf0c0a
[4] https://docs.google.com/document/d/1Jx0w867tVAht7QI1_prieiXg_iQ_nTloOya=
IIOnm85g/edit?usp=3Dsharing


