Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B086353
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618150; cv=none; b=AJ0m/sy0kjO4Aj+EtXV8NbGWMyeVmpF13Fmm4tnM1zfyF7JQ6hrSXwuvQpSzu4SfSvk9zlT8zHQsk7L/mJpxOGggNlcQ1dDJSGUyH8+DvvnJ3c5fAsxgZS0ZKSl5zZoBmmye+nzEw4ypUmOvQ2sDNs5UQfKg3156iAkhJng1qyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618150; c=relaxed/simple;
	bh=Xd0d6Si56VsvbsV99PuNiCoZJja8JcrUTk5+hlDStDQ=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=VPex74XT9O+Zw1U5+lVvUDS3YxVV8jjq+Ibn5cf/CfyiIeuuiOnZZklQaQRYkcNUi/HtS6ZDesUdIQEhyE3+kCj8rSmaIw0gIr5vwHWgCznfMBP2Mqxzzaol8UKUjXM+ZqKbhLbeFz1arYk36fSs9mRR410NHNow59AL0lNPCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVaqQ5ZC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVaqQ5ZC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22403cbb47fso1717175ad.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743618146; x=1744222946; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQ8OK75sYMa6evpoAyTa8ldzzLZobKR8Eb2HbzDxnj8=;
        b=HVaqQ5ZCjcpHvrYPb3krf8yr3X5P1bTgecVDtSWb7JlTIGEn4RQ62vEH7ZgNtVhbz/
         JXKt1B4MithURkvN8MhblNI/RX1kLL1BaD69qGUmVWOy6P6RGhzZ8XrWmc3ZuYwv3ei1
         OdxsflSM1u/iyGMnwC1UuEToC04AJP1lrt/705f9tk4XcyuRnUdWDOvC2+RND4jbXm2Y
         L5R44ccYE2t2ujKgYeyy75um8CLoFsOeWaXTxEVjA+v6h9p8Lamx3dy0l29H9AtuilT9
         bbCtSymKeGWR1nwruc92uwmh6W7oW7b8UpUt4RXNM7uIH4l5AImXNet5/xMPISYa0BRV
         XnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618146; x=1744222946;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ8OK75sYMa6evpoAyTa8ldzzLZobKR8Eb2HbzDxnj8=;
        b=ZbIxBnqQf9j6iQGM/cSNb66H4F4ko1LH32lYyUBO38+GUkRP6mrMC7mSpxKWgd/v6/
         Av8KT7Quglbc9zmiYwL6FqTevcAtUxxtSEVipcSbFmC9tTnAH0/cky0dk9WyLBCwK3am
         yBQWXX3GcbAkWNibGkUqvg91GdXE737IcePAlwgxKRZ2A5RXACqYFWfGUqbr8rsIcqse
         8x+6kMvqBmKRkB9TJq6X7f2FADpo+bGm8r+tTNVNKHbjQBWmBL8fCv6TF1i4OFFxqK9M
         wwAziqh6Thri+erwHCzElo2JXjRIOD3yu4P5yX9rv0MQw2fco/sMQqJa6Vr+0sKUlD/H
         3xVw==
X-Gm-Message-State: AOJu0YytQ4lzYla/iM3E85Xnltbvz+LpmWJE0sK6cShQGBP79AdB216r
	xc2Or3ozqf4h3vhVscJliLti4+6BfEbxk3bHF/BqPR+daLv/i0MQGzhBSw==
X-Gm-Gg: ASbGnctlZ6hxmGUYd9CggbXAvw2MPrP52nMSxv6LzxC/QIBWItbA4P7ZY6SNJswWtKx
	cQUiqBljibGs7ckWoRfOjEKdMmsAbJLBmKvI2+fnLNRLxHMvNeed/Hs83Zk3p0GSKtzAN6vvUH3
	0eMKb0m2rqkKYDlYryjK0QVfzyY7cjODFD294IQ2Phzftjmdnbss6KMYkDbfxJ5ZoHO1iJm8L+D
	x3REjYVqBY0B1VIXIixbp2eYfWNll6Ilzd6V0cqF5eenLIm+erwqlLxxpOZfMpZ54Ha+jc+mzRU
	piceynkQz2yp3StRKATy1KbmMUq/NWF/aj+/0qd5kWJQfuSomO1j68aSLjYcxl+M9Cwsn5zyeGU
	r8A==
X-Google-Smtp-Source: AGHT+IEhaX/UMOAkQ1IKOnTcGY06vzthUq6Pkmu1stdCQMAVeinPJ0lSVwCHFwkHxvq+7SvlPq/16w==
X-Received: by 2002:a17:902:e549:b0:223:fbc7:25f4 with SMTP id d9443c01a7336-2292f95d954mr245492565ad.14.1743618146043;
        Wed, 02 Apr 2025 11:22:26 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:980d:2982:18aa:46f3:4595])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cec3esm111213495ad.122.2025.04.02.11.22.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Apr 2025 11:22:25 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: [GSoC] Project Proposal: Machine-Readable Repository Information
 Query Tool
Message-Id: <7EB151DA-0BDB-4D54-BBB8-CEE69F51F13A@gmail.com>
Date: Wed, 2 Apr 2025 15:22:11 -0300
Cc: ps@pks.im,
 karthik.188@gmail.com,
 shyamthakkar001@gmail.com
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

As you may noticed by the my interactions here, I'm going to send a=20
proposal for GSoC 2025!

I'm interested in the project idea currently entitled "Project Proposal:
Machine-Readable Repository Information Query Tool". My main motivations
on why I have chosen this idea is because I think it will be useful for
infrastructure teams and FLOSS researchers.

I'm sending here first version of my proposal. I'll be grateful if you
send me feedback on it! In this proposal I'm presenting myself again,
the possible use cases of this feature, a first idea on how it would
work and a activity schedule.

Thanks!

---


# Machine-Readable Repository Information Query Tool

## Contact info

- Name: Lucas Seiki Oshiro
- Timezone: GMT-3
- IRC:
- GitHub: https://github.com/lucasoshiro
- LinkedIn: https://www.linkedin.com/in/lucasseikioshiro/

## About me

My name is Lucas Oshiro, I'm a developer and CS bachelor from S=C3=A3o =
Paulo,
Brazil. Currently I'm pursuing a master degree in CS at University of =
S=C3=A3o
Paulo. My interest in Git dates from years ago and I even submitted a
patch to its codebase in the past, though I couldn't complete it due to
scheduling conflicts with my capstone project.

Having experience in the academia, industry and FLOSS, I highly value
code quality, code legibility, well-maintained Git histories, unit tests
and documentation.

### Previous experience with Git

Before this year, I haven't been involved directly with Git community,
however, I kept my interest in Git alive by:

- Translating the "Git Internals" chapter of Pro Git to Brazilian
  Portuguese: https://github.com/progit/progit2-pt-br/pull/81;

- Writing some blog posts about Git, for example:
  - one explaining how Git can be used as a debugging tool:
    https://lucasoshiro.github.io/posts-en/2023-02-13-git-debug/;

  - other explaining how Git merge submodules:
  https://lucasoshiro.github.io/posts-en/2022-03-12-merge-submodule/;

- Writing a compatible subset of Git in Haskell from scratch:
 https://github.com/lucasoshiro/oshit;

- Helping organizing a Git Introductory Workshop at my University:
  https://flusp.ime.usp.br/events/git-introductory-workshop/;

- Presenting some lectures about Git in a company that I worked some
  years ago, covering the Git internals (objects, references, packfile)
  and debugging and archaeology related Git tools (blame, bisect,
  pickaxe, ls-files, etc).

### Previous experience with C and open-source

I also have experience with C and some C++. During my CS
course, C was one of the primary languages that I used. I also
worked with C/C++, for example, in:

- Writing an AMQP message broker from scratch:=20
  https://github.com/lucasoshiro/amqp_broker;

- Contributing with simple patches to the IIO subsystem of the Linux
  kernel: =
https://lucasoshiro.github.io/floss-en/2020-06-06-kernel_linux/;

- Contributing to the Marlin firmware for 3D printers:
  https://lucasoshiro.github.io/floss-en/2020-06-30-Marlin/;

- Writing a module for the ns-3 network simulator, dealing with both C
  and C++ codebases (currently under development, I plan to write a
  paper and make the code available soon);

During my CS course I also was member of FLUSP
(https://flusp.ime.usp.br), a group in my university focused on FLOSS
contributions and from Hardware Livre USP
(https://hardwarelivreusp.org), another group that was focused on
working with open-source hardware.

As a master's student, I'm one of the Open Science Ambassadors of my
University (https://cienciaaberta.usp.br/sobre-o-projeto/, in
Portuguese), promoting the Open Science principles, which include
open-source software, in the unit where I study.

I also contributed to some other free/open-source software, which I list
here: https://lucasoshiro.github.io/floss-en/

### Activity in the Git community in 2025

Since when I decided to submit a proposal for GSoC, I sent some patches
to the Git codebase and git.github.io:

- My microproject, replacing some `test -f` by `test_path_is_file`:
  =
https://lore.kernel.org/git/20250208165731.78804-1-lucasseikioshiro@gmail.=
com/;

- Adding a paragraph to the merge-strategies documentation describing =
how
  Git merges submodules (based on the blog post that I mentioned
  before):
  =
https://lore.kernel.org/git/20250227014406.20527-1-lucasseikioshiro@gmail.=
com/;
 =20
- A patchset adding a new `--subject-extra-prefix` flag for `git
  format-patch`, allowing the user to quickly prepend tags like [GSoC],
  [Newbie] or [Outreachy] to the beginning of the subject. This patchset
  was rejected in favor of just using `--subject-prefix=3D'GSoC PATCH'` =
or
  similar. It can be seen here:
  =
https://lore.kernel.org/git/20250303220029.10716-1-lucasseikioshiro@gmail.=
com/;

- Given the feedback on the previous rejected patchset, I opened a Pull
  Request on git.github.io replacing the occurrences of `[GSoC][PATCH]`
  by `[GSoC PATCH]`;
 =20
- Adding a new userdiff driver for INI files, initially target for
  gitconfig files. Currently it is still under revision:
  =
https://lore.kernel.org/git/20250331031309.94682-1-lucasseikioshiro@gmail.=
com/.

Beyond contributions, I also helped people on the mailing list that
needed assistance on Git documentation.

## Project Proposal

Based on the information provided in
https://git.github.io/SoC-2025-Ideas/, the goal of this project is to
create a new Git command for querying information from a repository and
returning it as a semi-structured data format as a JSON output.

In the scope of this project, the JSON output will only include data
that can currently be retrieved through existing Git commands, for
example:

- `git branch`: information about branches, such as the commit that each
  branch currently references and their upstreams;

- `git tag`: information about the tags, such as the author or commit
  date and the messages they hold (in the case of annotated tags);

- `git remote`: the URL of each remote;

- `git log`: statistics about the commit history, such of the
  distribution of commits over time and by author, the distribution of
  lines changed by each author;

- `git submodule`: information about the submodules, mainly the commits
  that they are referencing and their remote URLs;

- `git rev-parse`: the current branch name, the current commit, the path
  of the repository top level directory, if the repository is a bare
  repository or if the repository is under bisection.

Given that the information that we want to compile are currently
accessible only through different commands with different sets of flags,
the user that wants to read them needs to have an advanced knowledge on
Git. Once having the repository details consolidated in a single
command, the user will be able to quickly retrieve what it desires
without navigating a complex combination of commands and flags.

### Use cases

Some use cases that will be benefited of this feature will be:

- CLI tools that display formatted information about a Git repository,
  for example, OneFetch (https://github.com/o2sh/onefetch);

- Text editors, IDEs and plugins that have front-ends for Git, such as
  Magit (https://magit.vc) or GitLens =
(https://www.gitkraken.com/gitlens);

- FLOSS repository tracking software, for example,
  kworkflow (https://github.com/kworkflow),
  ctracker (https://github.com/quic/contribution-tracker);

- Academic researchers on FLOSS projects that need statistics on the
  repositories that they are querying;

- Continuous integration workflows that perform checks on the
  repository before allowing a branch to be merged into another or
  before a deploy;

- Code quality tools that will be able to inspect the health of the
  commit history.

### Planned features

Since the features haven't been defined yet, this will need to be
planned after surveying people and projects that potentially will use
that:

- Searching on code hosting tools (e.g. GitHub, GitLab) for open-source
  software that retrieve data from Git and what they do with them;
 =20
- Contacting people in academia that use Git repositories as data
  sources for their researches and find out what valuable information
  this command can provide them;
 =20
- Contacting people from the industry, specially in infrastructure teams
  to understand the challenges they face when retrieving data from Git.
 =20
Given that I have worked in a infrastructure team and that I have
colleagues and professors at the university that currently research
FLOSS software and communities, I have contacts that can provide input
on what should be considered when developing this new command.

By now, it's not possible to decide how exactly this command would work,
but a first draft is this (supposing that `metadata` is the name of the
command and `--submodule` is a flag that enable the submodule metadata):

~~~
$ git metadata --submodule

{
  "symbolic_refs": {
    "HEAD": "main"
  },
  "branches": [
    {
      "name": "main",
      "commit_id": "ac72c22f3c8a9280c81171ccc6cedff3171344cf",
      "remote": "origin/main"
    },
    {
      "name": "feature",
      "commit_id": "1e373e02767337bd6b996da6598eed822a805878",
      "remote": "fork/feature"
    }
  ],
  "tags": [
    {
      "name": "v1.0",
      "message": "First version",
      "author_timestamp": "1743554265",
      "commiter_timestamp": "1743554265"
    }
  ],
  "remotes": [
    {
      "name": "origin",
      "url": "https://example.com/foo"
    },
    {
      "name": "fork",
      "url": "user@example.com/foo"
    }
  ],
  "submodules": [
    {
      "path": "my_dir/my_submodule_dir",
      "url": "https://example.com/bar",
      "commit_id": "94436069f106c0014897b1c93e8fc3e49c8fc156"
    }
  ]
}
~~~

### Development plan

Since this is a new command that is not directly related to any specific
existent command, it will probably be placed in a new file inside the
`builtin` directory.

The functionality of this command can be divided into two categories:

1. **Data gathering**: retrieving data from different sources, calling
   existent functions and reading data structures declared in other
   files;

2. **Data serialization**: formatting the gathered data in a JSON
   format. This represents two challenges: generating the JSON itself
   and designing the schema for how the desired data will be presented.
  =20
Since the exported data is already provided by other Git commands, it
probably won't be difficult to implement this side of the
functionality. The main task would be inspecting the existing codebase
and find the functions and data structures that will feed our output.

Designing the schema, however, requires special planning, as the
flexibility of semi-structured data like JSON may lead to early
bad decisions. A solution may emerge by analysing other software that
export JSON as metadata.

### Schedule

1. **Now -- May 5th**: Requirements gathering
   - Inspect codebases that uses Git as data sources;=20
   - Contacting academic researchers on FLOSS;
   - Contacting industry infrastructure professionals;

2. **May 6th -- June 1st**: Community bonding
   - Getting in touch with the mentors;
   - Present to the community a first proposal of the JSON schema;
   - Receive feedback from the community about the schema;
   - Present a first proposal on the command line interface;
   - Receive feedback from the community about the command line
     interface;

3. **June 2nd -- July 14th**: First coding round
   - Write data structures that correspond to the presented JSON schema;
   - Fill the data structures with data obtained from routines of the
     existing codebase;

4. **July 15th -- August 25th**: Second coding round
   - Implementing the command line interface option handlers;
   - Write the JSON serializer.

### Availability

2025 is my last year in my master's degree. Currently, I'm not attending
any classes and I am more focused on developing the software of my
research, performing experiments and writing scientific articles and my
thesis. Since my advisor is aware that I'm proposing a GSoC project, it
will be possible to work on Git while working on my master's tasks.

