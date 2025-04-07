Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EC224FD
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997460; cv=none; b=YATlZLipNvEP/OC3dulwY43Y72EwJ+f8YPrvW6grA8L8Mh09EUjDnexjKuEtAvYMzx1W7fDDTX3CpqdV5hcTeZYQLQy0zeJjHsVuB7dFg/P04bue6mhOj0MdrIZqdddRnVZ+BGqHAAEITaNWDMGo07LGE43YAt2HR5VfFBWtsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997460; c=relaxed/simple;
	bh=6vkZFKrWotma9UC/AyLkd0Ho4EAJDnKeGmLAb7pi3wU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=GaRLDR99vd3rMRTi6pYO2uQRhit6NN/Yr8KW6stuPvOE8LJmSsRXPufvJyA4nVZl6VnSoMHq7MuQjMFvPkl9pXwRggrCyrypA7S+tDzwkELrGghC6dGnmx09f3gyVpfEO1PCzYB0ZbzqMk+QsWgNvf1fVg3q011zHkwx4BvOFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo2juB35; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo2juB35"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7370a2d1981so3101396b3a.2
        for <git@vger.kernel.org>; Sun, 06 Apr 2025 20:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743997456; x=1744602256; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uidz4u3KLVSpKmXMEP2kAsFatsOO9eXysvWkujcQJgU=;
        b=Bo2juB35MSoHPMknNzLx1sL932h10pzxHNIkanFCDNwijWjW+HNsND5Z07iWBFjrWz
         /LBLSCCaREasVxweaWEioHvpW5nbrQbAjdV+Jn52uA6cRzaeR4yAH2vCsm+VxGPU3X1e
         3yBZH64JH8Itj3VYGcFmv1sRMUxlK+DjZxP83vSIC1IaSm6Dcf7ekbIqc1saQRdLZd5Q
         h0RpMswfVX/5lmXUP/8JZ9ZibnCjcEjvy+UkjRHQsae4Nl2Spl+/HbmnXKENJ48+VLmJ
         zfHTdeyFN8Snq2JxWYPrBItc/ykDfA7CqOcvlh7fIcnUcCM5RPXLfLnLdjSWihKt9DC2
         e0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743997456; x=1744602256;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uidz4u3KLVSpKmXMEP2kAsFatsOO9eXysvWkujcQJgU=;
        b=amdawbdabvS4r5SfdxEgjvyh264E7vdwl+vyKM+CBzAie/u/CDVjJ+T7KT8FwUT3ab
         fsfR4I6t57iuXJexlMpqy8h6ohh7vw7mOJ+AXAps9ujgc6cQSoaH8io2WCMqf7nrmeu+
         dQVxo+OyoaJWzqHbAt2yqAZR9iiAMtDR3ufk7k9jIR4Hcs4yBKIhL88QEHfAM23CQGKO
         uO6sIT5dyvFYNGYuHXZ1LXZgr/lRP0ul47THvY+4tuHLU+DD4eugCSpU3PokPgQTJ3JF
         U+18zFRpeXyYhLS+JNRbez+6FJZp/TaTarDKx303tuCSDoXFF4UqWBWjm5D27cCxfQUu
         xXbw==
X-Gm-Message-State: AOJu0Yxf0J7YhE9s8peZ9/KRRHbUNE917YIcG+8LN/1oSPkQijMFInox
	HePbFk2zof9/M8fii3Ortva+Npbxu6hA0nB6NaWlqu5FW1Qsx1+CSIkqtQ==
X-Gm-Gg: ASbGnctlY+acGN9I1/NDb89VBiAT7t4u2kOcs96Bni5np4YygSi97I170nYJqzIjxa7
	pjP2wYtfjZaYA+a8LwXgvs0s2EPMSVH8LTmvo+DQiYkV80BieIakLuBGmK0FZZ6pYtZSFt2SSxB
	Bg1H+VUkFUetXQOmqTzF89Uu/srh8GCVkCDFjMuMQBNqB3r32CdMkwsJPdnJc0bHdH6NuWujDId
	udt/O4kd99j+Vmfpxdpy653Ewa3uW33b20hzmUKlUXO4eDTRwNfHWqeD8OK1/xOk29PSEWiQuCJ
	tppxZQzv5CuJ1n22Ctj3vbbyqrqoYP6h0WG/2HCDKIQ00vRJlyg+yl9hRwSUE2NIODmCEB4WVQ=
	=
X-Google-Smtp-Source: AGHT+IFxmZLdujp8YVqUC/XmB28GeMYnupNvGkz/RTS99B/iaOEhQqEtFlFtTN3Ui0qcn40FiuIgcg==
X-Received: by 2002:a05:6a20:9e4b:b0:1f5:8622:5ecb with SMTP id adf61e73a8af0-201046ff3b0mr19567241637.34.1743997456134;
        Sun, 06 Apr 2025 20:44:16 -0700 (PDT)
Received: from smtpclient.apple ([189.62.149.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41aba7sm6401472a12.71.2025.04.06.20.44.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Apr 2025 20:44:15 -0700 (PDT)
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
Subject: [GSoC v2] Project Proposal: Machine-Readable Repository Information
 Query Tool
Message-Id: <985FB467-6B19-4387-9B7B-BE3B185B087A@gmail.com>
Date: Mon, 7 Apr 2025 00:44:01 -0300
Cc: ps@pks.im,
 karthik.188@gmail.com,
 shyamthakkar001@gmail.com
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hello again!

This is the second version of my GSoC proposal. I made some changes =
based on
Patrick review of v1 by Patrick Steinhardt:

- Detailing the status of my patches;
- Focusing in `rev-parse` features, listing all that Patrick suggested =
and
  searching for a few more that may be useful;
- Given it is more focused on rev-parse, the parts about surveying users
  and projects for features was reduced but not entirely suppressed, as =
I'll
  need to find __where__ and __why__ this new command will be important. =
But
  now this will not be as important I as thought it would be;
- Changed the expected output, which becomes very smaller compared to =
what I
  thought it would be;
- Detailing a little bit more some examples of functions that I expect =
to use
  for retrieving data to populate the JSON that will be outputted;
- Breaking the schedule into 6 steps, bringing part the development of =
the
  JSON serializer to the beginning.

Thanks again for the review. I plan to submit the final version 20 hours =
from
now.

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

- Writing an AMQP message broker from scratch:
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
com/,
  merged to master;

- Adding a paragraph to the merge-strategies documentation describing =
how
  Git merges submodules (based on the blog post that I mentioned
  before):
  =
https://lore.kernel.org/git/20250227014406.20527-1-lucasseikioshiro@gmail.=
com/,
  merge to master;

- A patchset adding a new `--subject-extra-prefix` flag for `git =
format-patch`,
  allowing the user to quickly prepend tags like [GSoC], [Newbie] or =
[Outreachy]
  to the beginning of the subject:
  =
https://lore.kernel.org/git/20250303220029.10716-1-lucasseikioshiro@gmail.=
com/.
  This patchset was rejected in favor of just using =
`--subject-prefix=3D'GSoC
  PATCH'` or similar;

- Given the feedback on the previous rejected patchset, I opened a Pull
  Request on git.github.io replacing the occurrences of `[GSoC][PATCH]`
  by `[GSoC PATCH]`, merged to master;

- Adding a new userdiff driver for INI files, initially target for
  gitconfig files:
  =
https://lore.kernel.org/git/20250331031309.94682-1-lucasseikioshiro@gmail.=
com/.
  Currently it is still under revision.

Beyond contributions, I also helped people on the mailing list that
needed assistance on Git features and documentation.

## Project Proposal

Based on the information provided in
https://git.github.io/SoC-2025-Ideas/, the goal of this project is to
create a new Git command for querying information from a repository and
returning it as a semi-structured data format as a JSON output.

In the scope of this project, the JSON output will only include data
that can currently be retrieved through existing Git commands. The main
idea is to centralize data from `git rev-parse`, which currently is
overloaded with features that doesn't fit its main purpose.

Some of the data that we expect to retrieve and centralize are:

- The hashing algorithm (i.e. `sha1` or `sha256`), which currently can
  be retrieved using `git rev-parse --show-object-format`;

- The Git directory of the repository, currently retrieved by running
  `git rev-parse --git-dir`;

- The common Git directory, currently retrieved by running
  `--git-common-dir`;

- The top level directory of the repository, currently retrieved by =
using
  `git rev-parse --show-toplevel`;

- The reference database format (i.e. currently, `files` or `reftable`),
  currently retrieved by running `git rev-parse --show-ref-format`;

- The absolute path of the superproject, currently retrieved by running
  `git rev-parse --show-superproject-working-tree`;

- Whether this is a bare repository, currently retrieved by running
  `git --is-bare-repository`;

- Whether this is a shallow repository, currently retrieved by running
  `git --is-shallow-repository`.

Given that the information that we want to compile are currently
accessible with different sets of flags, the user that wants to read
them needs to have an advanced knowledge on Git. Once having the
repository details consolidated in a single command, the user will be
able to quickly retrieve what it desires without navigating a complex
combination of commands and flags.

### Use cases

Some use cases that will be benefited of this feature will be:

- CLI tools that display formatted information about a Git repository,
  for example, OneFetch (https://github.com/o2sh/onefetch);

- Text editors, IDEs and plugins that have front-ends for Git, such as
  Magit (https://magit.vc) or GitLens
  (https://www.gitkraken.com/gitlens);

- FLOSS repository tracking software, for example,
  kworkflow (https://github.com/kworkflow),
  ctracker (https://github.com/quic/contribution-tracker);

- Any other tool that integrates with Git and currently relies on
  `rev-parse` to get information about the repository;

### Planned features

This project consists of one big feature: produce the JSON with
repository metadata. At first, this should be populated with the data
that currently can only be retrieved through `git rev-parse`, like the
ones listed before.

Other data may be added depending on the demands of the Git community
and the community.

By now, it's not possible to decide precisely how this command would
work without it being more discussed. But a first draft on how it would
be invoked and the output that it will produce is:

~~~
$ git metadata

{
    "object-format": "sha1",
    "git-dir": ".git",
    "common-dir": ".",
    "toplevel": "/home/user/my_repo",
    "ref-format": "files",
    "superproject-working-tree": "/home/user/my_super_repo",
    "bare-repository": true,
    "shallow-repository": false
}
~~~

This first draft will be sent to the mailing list in order to get
feedback from the Git community.

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

Since the exported data is already provided by other Git commands, it
probably won't be difficult to implement this side of the
functionality. The main task would be inspecting the existing codebase
and find the functions and data structures that will feed our output.
For example:

- Reference database format: `git rev-parse` retrieves it from
  `ref_storage_format_to_name`;
- Whether the repository is bare: `git rev-parse` retrieves it from the
  function `is_bare_repository`;
- Whether the repository is shallow: `git rev-parse` retrieves it from
  the function `is_repository_shallow`.

Designing the schema, however, requires special planning, as the
flexibility of semi-structured data like JSON may lead to early
bad decisions. A solution may emerge by analysing other software that
export JSON as metadata.

### Schedule

1. **Now -- May 5th**: Requirements gathering
   - Present to the Git community the proposal, asking what are the
     features that it demands;
   - Inspect codebases that uses Git (specially `rev-parse`) as data
     source;
   - Studying more deeply the codebase, specially the `rev-parse` source
     code;

2. **May 6th -- June 1st**: Community bonding
   - Getting in touch with the mentors;
   - Present to the community a first proposal of the JSON schema;
   - Receive feedback from the community about the schema;
   - Present a first proposal on the command line interface;
   - Receive feedback from the community about the command line
     interface;

3. **June 2nd -- June 31th**: First coding round
   - Decide how the CLI should behave, that is, what should be exported
     by default, what should be outputted only by using flags and what
     should not be outputted by using disabling flags;
   - Write a minimal JSON serializer, focusing on export only the
     top-level object with only string values;
   - Define a simple data structure that holds only one field of the
     data that we want to export;
   - Introduce a first version of the command, outputting the first data
     structure using the first JSON serializer;
   - Write test cases in different scenarios comparing the output of the
     new command with the outputs of the existing commands;
   - Write a minimal documentation file for the new command, making it
     explicitly that the command is experimental and it's still under
     development;

4. **July 1st -- July 14th**: Second coding round
   - Fill the data structure with all other string fields that should be
     exported;
   - Add flags for filtering the data output;
   - Write tests for each one of the new fields and flags;
   - Improve the documentation file, explaining what the command does,
     its output format and what the flags that were implemented so far
     do;

5. **July 15th -- August 15th**: Third coding round
   - Improve the JSON serializer, allowing other data types: array,
     number, boolean, null and nested objects;
   - Fill the data structure with the remaining non-string fields;
   - Write flags, tests and documentation for the types that were
     implemented in this round;

6. **August 16th -- August 25th**: Fourth coding round
   - Polish the documentation, providing examples on how to use it and
     notes on why this command was created;
   - Finish remaining work from the previous rounds that still need to
     be concluded;

### Availability

2025 is my last year in my master's degree. Currently, I'm not attending
any classes and I am more focused on developing the software of my
research, performing experiments and writing scientific articles and my
thesis. Since my advisor is aware that I'm proposing a GSoC project, it
will be possible to work on Git while working on my master's tasks.

