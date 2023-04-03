Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C824C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 20:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjDCUAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 16:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjDCUAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 16:00:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8752105
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 13:00:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg48so121855582edb.13
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680552032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+krchVGT6oBGCX5yf/WeHIKUrs1Jj0g2NiSbzdHCyk=;
        b=VgeYq2sg5kxhnNPkn+uzQWzWXmsyzbtRXtSkOcGBJV8CYrMtNwQrq5gKcFftVeCarl
         8+30J+BZ+r4KRLoa2NGZVXKUThMM7pBud1LotGs/P3SUBJLTbBsWIdHeNkHYQJHpTcRL
         xRPP6R4IoDlF/rY3eSpwGZV35X6NJe8gekt5KEoQE7oPwEtNoe2y/W/tQz38CQT2wIyd
         G1yWq/KaqsUjo1dSBLmk4VAf1hVa0zPTMbm3m5u7WpAMLXNx1LL/1NKQFG0urMNMGMC6
         lXKMnpgAmSS6iqF0CQaurS2bUmjlUNODwNMyyS9YKNdScXcV8wWgtsXSroB7LBNI95QY
         /iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680552032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+krchVGT6oBGCX5yf/WeHIKUrs1Jj0g2NiSbzdHCyk=;
        b=t2l4NlTXdwsezj7cipp5k9zMlIljaw4f2R9kH+p1uD3nGNBPF3tpmZKtGzHfBt88iJ
         qqKCslx9ERmJRSPReSNK3ki5gXNzwavwORnJiHWc90jgEsnuujEctW5sQHMVtC08wltb
         t/7Sxab3GAeIrfUyZckreiOvGr4IqH0S+2sgBFpzxy9W64nKtX7V/J4yYKyXjqY7np0V
         D5XG5mgAIDWFFKeQlMD4ZhulHp0sGRwRoz1XJjt3X0CAcgoBYUsCYR5uqvffgTWZ/Ch+
         r9zzJm5qTLxqB8ffTQWlcSQW0qDiMw60W9f/8rUyd7PD6n1/JN4lvwPOIXF0LFo1vqvO
         RL1w==
X-Gm-Message-State: AAQBX9em/rpuQk2z7vBYj92LB+ydsVAiNLqXyFJ0YZ6YOvsbTSE2iaTh
        sfY94bd+vY//ty+1ht+VusWZgyjxdXOH8Z/uXgideMJ58aKicJ39leI=
X-Google-Smtp-Source: AKy350aIX/smDHSaEpALClmq8+eZSDdteJNV2isn9n3bJAdfWNWwjOP9PfnZeqoV+59M9mBqwj933JvVUyX91jqYs5Y=
X-Received: by 2002:a17:906:c003:b0:932:777a:d34b with SMTP id
 e3-20020a170906c00300b00932777ad34bmr18012898ejz.14.1680552031546; Mon, 03
 Apr 2023 13:00:31 -0700 (PDT)
MIME-Version: 1.0
From:   RAGHUL NANTH <nanth.raghul@gmail.com>
Date:   Tue, 4 Apr 2023 01:30:19 +0530
Message-ID: <CAPnUp-nH=LNJNZZj_V3j-Lehm3JahibzpoN11WY-KO_Jsanz8A@mail.gmail.com>
Subject: [GSOC][Proposal V1]
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am sorry for sending my proposal late. This unfortunately forces
this to basically be the final draft. If you have any advice on things
I could change, I would still appreciate them. Thank you

## More Sparse Index Integrations

### Personal Info

Name: Raghul Nanth

Email: [nanth.raghul@gmail.com](mailto:nanth.raghul@gmail.com)
Mobile No: (+91) 6382298677

Education: National Institute of Technology, Tiruchirapalli
Major: Computer Science

Github: [NanthR](https://github.com/NanthR)

### Project Synopsis

I would like to work on the "More Sparse Index Integrations" from the
[SOC 2023 Ideas page](https://git.github.io/SoC-2023-Ideas/), which aims
to integrate "sparse-index" with the remaining git commands, wherever
possible. The project is expected to be of medium difficulty, and take
up approximately 175 to 350 hours.

**Sparse-index** is a feature that reduces the working directoy's index
(a Git structure where information about the files tracked by git is
maintained), and allows it to work with "sparse-checkouts". This makes
certain commands like "git-add" or "git-commit" faster to execute.

**Sparse-checkout** is a feature that allows the user to restrict their
working directory with only the files one is working on currently. This
is useful when the user only has to modify a small subsection of a given
project

### About me

I have been involved in development for the better part of 3 years. I
have worked on some medium sized projects, but have never really been
involved with open-source.

My participation in the Git community started fairly late, but in the
little time I had, I have been able to understand the Git workflow, the
internals of the project, commonly used functions and test setup. The
documentation, especially the
[MyFirstContribution.txt](https://github.com/git/git/blob/master/Documentat=
ion/MyFirstContribution.txt),
[MyFirstObjectWalk.txt](https://github.com/git/git/blob/master/Documentatio=
n/MyFirstObjectWalk.txt)
and
[sparse-index.txt](https://github.com/git/git/blob/master/Documentation/tec=
hnical/sparse-index.txt)
helped me get up to speed on both the technical aspects I needed to
understand and the prerequisites for contribution.

I do anticipate my prior experience with the project will make the
further progress a lot smoother.

### Community benefits

Sparse-index aims to provide a better working experience for people
working with large monorepos, and my work on this project could enable
more commands that people use to work with sparse-index, thus enabling
speedups in more of their workflow.

### Related Work

- [Integration with
  "grep"](https://lore.kernel.org/git/20220817075633.217934-1-shaoxuan.yuan=
02@gmail.com/)
- [Integration with
  "rm"](https://lore.kernel.org/git/20220803045118.1243087-1-shaoxuan.yuan0=
2@gmail.com/)

### Patches (Current Work)

- [describe: enable
  sparse-index](https://lore.kernel.org/git/pull.1480.v3.git.git.1680155957=
146.gitgitgadget@gmail.com/T/#m7bf44d073e179c5715946c00ce805fec23f64c19)
    - **Status**: In review
    - **Description**: Add sparse-index integration for describe. Add
      functional and performance tests for the same.

- [diff-index: enable
  sparse-index](https://lore.kernel.org/git/20230403190538.361840-1-nanth.r=
aghul@gmail.com/T/#u)
    - **Status**: WIP
    - **Description**: Add sparse-index integration for diff-index. Add
      functional and performance tests for the same.

### Plan

The general idea of integration remains the all the involved commands,
depending on how they are setup, and based on the current logic of the
command involved, we might first have to alter the current logic before
attempting to add sparse-index support. This is based on Shaoxuan Yuan's
ideas.

1.  Investigate the command's logic and modify it wherever necessary
(Especially compatibility with sparse-checkouts). Add tests for the
same. [7 - 10 days]

2. Disable the command_requires_full_index setting in the building and
ensure that the current intended functionality is intact.

3. Add tests to t1092-sparse-checkout-compatibility.sh for the built-in.
Verify functionality, and if the command interacts with the working
tree, make sure to test both in-cone and out-of-cone behavior.

4. Add tests to ensure that the index is not expanded by the command.

5. Add performance tests to demonstrate speedup
(p2000-sparse-operations.sh)

[Points 2 - 5 should be able to be completed in approximately 8 - 15
days ]

The first step will not be a necessity in all the commands and hence can
be skipped if not necessary. Without extending the timeline, 4 - 5
integrations are expected to be completed by the end of the GSOC program
period.

### Timeline

I would be able to officially start the project as soon as the start of
the Community Bonding Period (May 4). I am confident of this as I
already have a basic understanding of the process I would need to follow
to accomplish the goals of the project.

Even though exact dates are hard, there should roughly be, from my
estimation, **one sparse-index integration every 20ish days**, starting
on May 4.

Integration schedule:
    - git-diff-tree
    - git-write-tree
    - git-worktree
    - git-check-attr
    - git-am

Depending on the underlying implementation functions that these commands
use, they could have already been made sparse index aware. In that case,
the time to integration reduces significantly, as the only additions
would be to change the command_requires_full_index option and add tests.

### Availability

I will be completely free during the months of May-June and I will be
able to fully spend my time for the project. I would be starting work
after that, so I would need to juggle my time between the two.

I do not have the most free schedule, but I think I can manage my time
enough to be able to contribute effectively to the project.

I will be able to work on average 6 hours a week for 6 days a week
during the initial period. Following that, my contributions during the
weekdays will decrease, but I believe I can make up for that during the
weekends.

### Post GSoC

I understand the importance of having GSOC participants who continue to
be part of the community after the project ends. And I do intend to
honor that idea. Being part of open-source is always a cool idea, and
having the opportunity to help with something as widespread as "git"
will always be exciting to me. I also feel I will be able to learn and
make some important contributions to the project with my continued
participation.

I would also ideally like to create blogs about the development of Git.
The methods and systems Git uses for its development is not apparent to
a new developer and giving a more gentler introduction could help more
people get into the project.

Thanks,
Kind Regards,
Raghul

### References
- [Make your monorepo feel small with Git=E2=80=99s sparse
  index](https://github.blog/2021-11-10-make-your-monorepo-feel-small-with-=
gits-sparse-index/),
  Stolee
- [Bring your monorepo down to size with
  sparse-checkout](https://github.blog/2020-01-17-bring-your-monorepo-down-=
to-size-with-sparse-checkout/),
  Stolee
