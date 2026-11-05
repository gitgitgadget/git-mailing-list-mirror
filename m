Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793880257;
	b=5EPgEVKUPJHj68cYpIyNCGH4a3MY+3I1yvcwPLeXxbTRvqxhm+8JBwMYGmyRfbv0j+kx
	 itZIQz+PmLw0aJ6DGqlT5uej6/La0Zzh+O9Rffr2sc/f1znF/PqCVUi9iUDovdrPvF9ML
	 03zaMhxGpKXD5I8MEhG3l5BWYsJz3pxInLMvrlAVU8A0IJY4vzqUz6eHa6mTtcSO3eiCq
	 r+Bm/nyPh8+4SekqrH67MGBU2TU7ckOn+VNSIm/xlaMQZrmPd3Apyrrrv9STm4vduhqwh
	 IcepJbSqN7I51KIZ8fZYJjedjlNcvOeT+HZKC+DhQvq+a44NggfqfEfap09NY+bF/Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=GccHPcrGZ+BAPfwQl7ZbOdS4+QLUEtmP/7lfRw3Q4VU=;
	b=1CJcffYJF1SukvPn5KV1IpI5Qyx62GCmkaQGZ2f14nceA6d6yG1nAnZu76izOaQWu3zZ
	 GOutryFqQuaiIZhUtL2ZQeQdQ44b/hk3CQ2+CICFu1bz07Cks02Gh8pGltjfxT8hx5R8C
	 Kk1cYtxC5OEA39UOqEqLkmpHrBWYQ7odAkqQurNeo9h8CEu6HnB6oOvP39VWR7VWvDiPR
	 AF/WXZt72S99TMXW7U8LH83OufQyWfSVBq4LDi1z0bIhHnX1VtzkMD9p4VxG81yfHD1XT
	 ui1c+GbLClUNF5j4170D1QbZQAkZBEPCnQ1KOTMc55TIw0lFucRm8TzF7FXOZpErCEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O2dTFI48;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC716606A32C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC716606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O2dTFI48
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91b52ba422cso22964736d6.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 04:04:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793880255; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9LRiswlWE7RjjF1zcaSVdd24blsgMj76Sjud3SacjCoFQU9LB/al4nNLN1GK5U1gv
         lnFo9Z5irtWnLWXZwE36oC3peDWBfw/egsAV0/xvVr1kem7JosGZIlrQeGG9vpji6xQC
         OkURc2WghUuiCUbSDXa+EtyfejBdQkLvpqjp12ZixyX+kjBm8tTeRXqZNgmekzeqdpX7
         rfCNwI9H+nlZnwgMUBptc5Neg4OGK7t7PqRONknQocYkJ9CdplogoLTB5x7dNZ5mvQyY
         jRDJQavNICOMtG7fxY7iJs8k3X35ETqFA9rzAlGKJQPnS32O0710/Uy8WIJDuLim5vRi
         MX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=GccHPcrGZ+BAPfwQl7ZbOdS4+QLUEtmP/7lfRw3Q4VU=;
        fh=jFpBo47i7lSwA7fB48ETjSSalcY74ytcd6yOFas+z2s=;
        b=jcVou7z2vh90ZC1dwJmi7rxyhx2UIVAmrBu1HVQaiC+GqVZFE3TX8N7IsoIjrHlyMd
         DeGO1T1KRckXPwG1TSnhVFUwGqJ9laJwHVVq4l1DUDBVp2l9ZoyaX7YpHOXDhggFODgV
         aihsqO6aynDLUtLwFn+vCy2aiLf74aBTzC0cbFekMRLnYK9HXGAnn7Au3nZ83EF75CW/
         Z55ABJ6ict2yddJhiuk9dCyOs24ZBt+ZcV3UMWmp6l7RltWg4cxEgyLJg4o/kOg9UXzv
         ZWXnw6CFQ+43VS19EOgq+PwcG2ctnVmDzvcikKKLtGPC0rkUeRb4eOBgEYqvrmY8/veW
         C+PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793880255; x=1794485055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GccHPcrGZ+BAPfwQl7ZbOdS4+QLUEtmP/7lfRw3Q4VU=;
        b=O2dTFI48uwREvRSLS3jBI+y0c/S/SEKIrTt/jclN6VHfu1qbpN07MraEf+LCY16hpV
         bvVuWAHv31s6MbMvpnfaxZ+YG41JVDYL/9JGZH7zGCxWm+3ox4lu1IBCGJePKTrXy4iN
         SOF+VqKMBEM02mXStYmL9dqHEv7Pd1F1URpqITs015vYksBRUMKWWM+C0vnt+zBL7/96
         W8lrNK6oV6gqYCvIJXjmwLuaGT/uLIshZPj0cjokPT742OOSLFI8fmVLw4oDfDXhMn1N
         0TtCCgST9Jxng55H52OiLBFRcWIMGYsxF5UPEGUVqiiUwX0Zh7q7Tf15j2dzXKcGKT7G
         TAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793880255; x=1794485055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GccHPcrGZ+BAPfwQl7ZbOdS4+QLUEtmP/7lfRw3Q4VU=;
        b=aSr6gafEMD++N+mVe9eT6Z3w/6JbhMW/qX6IpPDYIrvWxk2zbU65+rJ0TDbQMvheeu
         fIQatItetUjWpa5ZQCi/mmIUlLKx+lYEAofaJugdq4Q2oUWDTMZO9OcN5LMaGtbu/2kF
         MF2XlmJwdJYfCwzfLRcQLQjSm89SI/jjwP7PFJgS3fXXlJpHus0UOyudiY5XQLl8fsRB
         p93AeKErqU7GtYCPHQFSwa/+N0RpXJfK/gqUi2Ba62YTVFSdJPctDWQSj7ad2rNcPh6c
         Eo2hwajCHZof+fLzI/PjVJmulnejSvtSAYUqtVls6EVGAXlcTElAGT8IObYQwy9FW4dl
         WVoQ==
X-Gm-Message-State: APuU4Z8mXDM13brYqk7Ep5ro45AMeApSOZNioYYh1wWTY1fZ/BCqFuo5
	udP054rNhLf1XoYdZpqDH8hgswsvROsud7YK9Y03IHixk51n4PBiTf1gaWtQAKlXTkBvOAJ6vzj
	qoCmg/u22ZdFrskcz21EMcqAH7KJ2PITg1XmAyXY=
X-Gm-Gg: AYBFou3TELX0USp89kUxT4nf3ItDqJdrxYkWKKG5d4H8SFlWDsXtmRRn9lKZnYHHEcP
	IyfNeHaSJrk4hxxVQJGGZKym09actLG9nkYsjcs4m4BZn/iuRdIe2CUd/WspbU17GF21fnUXcxf
	jOJKMyBYKEFRb6TU6sjpeiB8E3pTzIbrxlQxGDU7CJZBuUsjANRsc3a6qRrkL0T8UGYJ1cme5uf
	eaQHAmhRpFnSxPRl3sPXUaTvKZbeUyXxgPADsrcSCQFc9/v63Eh7OfE1pUS50QmztS4ticFcR4Q
	Sjf7v5zffQT/ZeKixlbQH6or5xb9Ot5RI+0wz5cvaU7h5nE/2jcoV5XnOERiAOxjgMRZWWzusml
	HC46BsysECeno6VTTeytIx03g6xQ//mzReT5XMuxUt0oCCfmNJXgbNMtR37mLSvHSyyHeFRzaIX
	D0+wciPs+6hFVE/XTIDP/fJwPXKs6FWizPNB8hZ5zoF+gK1Q01jsP1BU6sEuuQXXfQyEVC2KV2q
	SPI
X-Received: by 2002:a05:6214:cc4:b0:91e:8a02:6eb8 with SMTP id
 6a1803df08f44-91e8a027094mr66377426d6.54.1793880253645; Thu, 05 Nov 2026
 04:04:13 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Thu, 5 Nov 2026 17:33:59 +0530
X-Gm-Features: AclHuK8lXBBxbPdWhmsN9JV2iszEYqXtDzwBOT-7UIvWSGEB4CHSewFiVlvfWWU
Message-ID: <CABh_KWjbEGaf33n-qKJDC+-cipfMvzUm6=mwDuV5s7yEYBL5dg@mail.gmail.com>
Subject: [Outreachy][Proposal]: Reduce Git's global state to enable Git's libification
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, kaartic.sivaraam@gmail.com, 
	christian.couder@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git community,

I am sharing my draft proposal for the December 2026 Outreachy
internship. I would appreciate your feedback and suggestions.

# About Myself

I am from Karnataka India [UTC+05:30 (IST)]. As a BCA(Bachelor of
Computer  Application) Graduate.I have a good foundation of
programming and have worked with some programming languages.I have
practical knowledge developing own software projects and contributing
to open source projects.while learning how to use Git and GitHub for
version control and managing changes in my projects it became
interested in using different publicly available open source
repositories. This led me to become curious about how Git works
internally, How its source code is structured, and how its developers
keep such a huge project going.

This pushed me to look into the source code of Git. I learned about
the C concepts that are needed to understand the code such as
pointers, structures, functions and looking at how the different parts
code communicates with itself. I looked into the Git code related to
repositories and learned about concepts such as the_repository, struct
repository \*repo, global state and explicit dependencies. This taught
me that when contributing to a well established open source project
there is more to it than just writing code. You need to understand the
existing functionality, look at past changes and ensure that the code
is tested properly.

I made some contributions while preparing for this project. I made
changes to test scripts, test-path and safe integer arithmetic in
diff-delta. I worked on a submodule-related change involving
repository-specific commit abbreviations and made an updated patch
series for review. I gained practical experience of looking at
existing code, creating patches, testing and getting my code reviewed.

When i got to know about this project is while watching videos on
YouTube about Git and contributing to open source projects I
discovered Outreachy. I submitted my initial application and looked
through the list of projects available. I found the Git project,
'Reduce Git's global state to enable Git's libification'. As I was
already interested in Git and GitHub and had begun learning about C
programming, I decided to choose this project as it fit my interests.
I began preparing for this project by completing the microproject,
looking at Git's source code, looking into past changes and
researching potential areas to contribute to for my main project.

I am interested to involved with this Outreachy internship project for
December 2026 as it will give me the opportunity to understand and
contribute to a key part of Git's internal design. I am interested in
understanding how to replace implicit dependencies on global state by
passing the required repository or index information explicitly. I
would like to learn how this can help make the code more testable,
maintainable and reusable.

I hope to boost my C programming and problem solving skills during
this internship. I hope to make useful and thoroughly tested changes
to Git. I am happy to look into the existing implementation, talk to
maintainers, learn from code reviews and improve my work using
technical feedback and collaboration with community.

## 2. My understanding about Project

### 2.1 What is Git's global state?

while looking  Gits source code,I learnt that global state is
information that different parts of program can acces without
receiving it directly as an argument.This can be useful,But it can
also hide what a function depends on so.

ex: In Git is `the_repository`.It is a global pointer to `struct
repository` object.Code can use it to access information about the
current repository. For example, `the_repository->index` gives access
to that repository's index.

The problem came here is a function may appear to need only the
arguments shown in its definition, while it also gets important
information from a global variable. That makes the dependency less
obvious. It can also make it harder to test the function with a
different kind of repository or index. This is the kind of dependency
I am interested in understanding and reducing in the pathspec code.

### 2.2 What does libification mean?

I understood libification makes Gits internal code easier for other
programs to use as a software library,rather than only using it
through Git's command-line programs.

One problem is that some Git functions rely on global information like
`the_repository`. A function that gets information this way may be
harder to use when another program needs to work on a particular
repository or when more than one repository is involved.

One way to reduce this hidden dependency is to pass the information
the function needs as an argument. ex: a function can receive a
`struct repository \*repo` to work with a particular repository, or a
`struct index_state \*istate` to work with a particular index.

This helps the function's dependencies clearer and can make it easy to
test and reuse. I understand that passing repository or index
information explicitly is only one part of libification; other parts
of Git may need further changes as well.

### 2.3 What has already been done?

I discovered while looking at source code Git developers have been
working to reduce global state. Two important structures used to store
repository-specific information are repo_config_values and
repo_settings.

ex: I looked at was `core.attributesFile`. Previously this was stored
in a global variable called `git_attributes_file`. When multiple
repositories are used in the same process, one repository's
configuration could overwrite the value used for another repository.
This was refactored so that the value could be stored in the
attributes_file member of repo_config_values.

Another ex:I looked at was `core.hooksPath`. Previously this was
stored in a global variable called `git_hooks_path`. This could cause
problems when multiple repositories used different paths for their
hooks in the same process. This was then refactored to store the value
in struct repo_settings. A function called
repo_settings_get_hooks_path() was also introduced to load and cache
the value for the required repository. These research helped me to
understand how Git uses various repository specific structures to
reduce global state.

In Google Summer of Code 2026 there was a project called "Refactoring
in order to reduce Git's global state". This aimed to reduce global
dependencies by refactoring Git's environment handling and moving
selected values into appropriate repository-specific structures,
including repo_config_values. Some examples of these values include
`protect_hfs`, `protect_ntfs`, `trust_executable_bit`, `ignore_case`,
`excludes_file` and various program settings.

This work provides useful context for the current Outreachy project.
The earlier refactoring focused on reducing global state in Git's
environment and configuration handling. The current project takes the
broader goal further by looking at how parts of Git can become
suitable for use as a library. My proposed pathspec investigation is a
possible contribution to that ongoing effort, rather than a claim that
pathspec work was assigned or approved by the earlier GSoC mentors.

In the v2.56 release notes for Git there are several examples of
changes made to reduce global dependencies. These include functions in
`copy.c` being modified to take a repository argument, the use of
repository aware versions of the tempfile and lockfile APIs. Parts of
the refspec API were changed to remove their dependency on the global
the_repository by passing the hash algorithm explicitly. And
repository pointers are passed in ref and worktree related functions.

Overall from looking at these changes, it seems(i'm assuming not sure)
that reducing global state is a continuous process. As developers need
to understand what each value is used for, and find the correct
repository/structure to store them in. Some of the information will
need to be made explicit. The December 2026 Outreachy project
continues this larger effort by making Git's internal code more
suitable for libification while maintaining its existing behaviour.

## 3. Previous Contributions and Preparation

### 3.1 Contributions to Git

While preparing for this project, I contributed to Git. I became
familiar with reading code, finding issues, and making and testing
changes based on feedback from maintainers.

| Contribution | Pull Request and mailing-list discussion | Status as
of 5 November 2026 |
|---|---|---|
| Avoid pipes in the `t0001-init.sh` test script | [PR
#2260](https://github.com/gitgitgadget/git/pull/2260); [v2
mailing-list discussion](https://lore.kernel.org/git/pull.2260.v2.git.17926=
66211685.gitgitgadget@gmail.com)
| Integrated into `next`. A later mailing-list status update says it
will merge to `master`. The GitHub PR remains open and is not marked
as merged. |
| Modernize test path checks in `t2030` | [PR
#2256](https://github.com/gitgitgadget/git/pull/2256); [v3
mailing-list discussion](https://lore.kernel.org/git/pull.2256.v3.git.17922=
99943380.gitgitgadget@gmail.com)
| Integrated into `seen`. The GitHub PR remains open; the latest
recorded status update says it needs review. |
| Use safe integer arithmetic in `diff-delta` | [PR
#2276](https://github.com/gitgitgadget/git/pull/2276); [v9
mailing-list discussion](https://lore.kernel.org/git/pull.2276.v9.git.17931=
20160248.gitgitgadget@gmail.com)
| Integrated into `seen`. The GitHub PR remains open; the latest
recorded status update says it needs review. |
| Use the submodule repository for commit abbreviations | [PR
#2288](https://github.com/gitgitgadget/git/pull/2288); [v6
mailing-list submission](https://lore.kernel.org/git/pull.2288.v6.git.17938=
21554097.gitgitgadget@gmail.com);
[v6 commit](https://github.com/git/git/commit/01c3cc25738c43d61aff153805e02=
db872ff21de)
| v6 was submitted on 4 November 2026. The GitHub PR remains open. The
latest status information available for v6 does not show maintainer
acceptance or integration. The focused
`t4041-diff-submodule-option.sh` tests passed 48/48 with both SHA-1
and SHA-256. |

Integration into `next` or `seen` is part of Git's review process and
does not mean that a GitHub PR has been merged into `master`. All four
GitHub PRs remain open and are not marked as merged as of 5 November
2026.

### 3.2 Source-code preparation

I looked at different area of Git source code, which includes
including `repository.c`, `repository.h`, `environment.c`, `alias.c`,
`alias.h` and `builtin/help.c`. I also read the Git v2.56.0 release
notes to see what had changed recently in the effort to reduce global
state.

I investigated how `the_repository` is used as a global pointer to the
main repository structure. I also looked at how functions receive
repository pointers (`struct repository \*repo`) as arguments to
access repository-specific information.

I looked at `alias_lookup()` in `alias.c` and examined how it uses
`the_repository`. This helped me understand that a function can
receive some information through its arguments while still relying on
global state for other information.

I also investigated `is_bare_repository()` and the changes made in
commit `7ff3a5895b`. The change separated the initial `--bare`
command-line option from the repository-specific bare configuration.
This helped me understand why these different types of information
need to be stored separately.

I became more familiar with commands such as `git grep`, `sed`, `git
log`, `git show` and `git diff`. I used them to locate functions,
follow the flow of code and understand changes between commits. This
made me more comfortable investigating the codebase and understanding
how global dependencies can be reduced.

I also checked `init_pathspec_item()` in `pathspec.c`. This is a
separate area from the skip-worktree matching helper: it uses
`the_repository` for repository-dependent path-prefix handling and
error reporting. This showed me that there may be other repository
dependencies in pathspec processing, but they need to be assessed
individually. I have kept this as possible follow-up investigation
rather than including it in the initial implementation scope.

### 3.3 My knowledge about the project through case studies

I Looked at two examples in Git to understand how global state has been red=
uced.

For `core.attributesFile`, I found that the value was previously
stored in the global variable `git_attributes_file`. It was later
moved into the `attributes_file` member of `struct
repo_config_values`.

For `core.hooksPath`, the value was previously stored in the global
variable `git_hooks_path`. It was moved into `struct repo_settings`. A
function called `repo_settings_get_hooks_path()` was also introduced
to load and cache the value for the relevant repository.

By seeing at these changes helped me understand that reducing global
state involves deciding where information should be stored and how the
correct repository should access it.

I also looked at a more recent pathspec change, commit `dd674df326`
("pathspec: use match for sparse-index expansion checks"). This change
addressed a heap-buffer-overflow involving prefixed wildcard pathspecs
with a sparse index. It changed the checks to use `item.match`, which
includes the path prefix, consistently instead of using
`item.original`. This is relevant prior work because it shows that
pathspec changes involving prefixes and sparse indexes need careful
compatibility and memory-safety testing. My proposed helper
investigation is separate from that change, and I will check for
overlap rather than assume the work is related or already covered.

## 4. Problem Identification and Proposed Contribution

### 4.1 Why investigate pathspec?

A pathspec can be used by Git commands to tells which files or paths
to target. It can be used to find a specific file, directory or group
of files using patterns.

Pathspecs are used by several Git commands such as `git add`, `git
rm`, `git grep` and `git diff`.

While watching how pathspecs are implemented in Git, I noticed that
some of the pathspec-processing functions use the global pointer
`the_repository` to get information about the current repository. This
creates an implicit dependency.

Pathspec processing seems like a useful area to look for. Making
dependencies on specific repositories or indexes explicit can help
reduce global state and make the code more reusable in different
repository contexts.

### 4.2 Current technical observation

In my examination on `pathspec.c`, I found that there is a function
called `find_pathspecs_matching_skip_worktree()` that checks which
pathspecs match index entries marked with the skip-worktree flag or
located outside the sparse-checkout area.

The function accesses the index via `the_repository->index`, but does
not accept it as a parameter. Instead, it uses the global pointer
`the_repository`. This has created an implicit dependency on the
global repository.

One possible improvement would be to pass a `struct index_state
\*istate` argument to the function. This would make the required index
explicit and allow the function to use the index supplied by its
caller.

I investigated the inline wrapper for this function in `pathspec.h`.
This function is called `matches_skip_worktree()`, and calls
`find_pathspecs_matching_skip_worktree()`. The wrapper also caches the
matching results so they can be reused on subsequent calls.

Any change to the helper will also require reviewing and updating the
wrapper and its callers.

### 4.3 Current call-site investigation

I checked the source code and found four call sites for
`matches_skip_worktree()`: one in `pathspec.c`, two in
`builtin/add.c`, and one in `builtin/rm.c`.

Each of these callers will need to be considered when changing the
helper and wrapper interface. The caller must provide the appropriate
index state so that the function works with the intended repository.

Interestingly, in `builtin/rm.c`, the `cmd_rm()` function has a
`struct repository \*repo` argument already. However, the variable is
marked as UNUSED. The surrounding code still refers to
`the_repository` to get the index. Therefore this caller will need
further investigation to determine how to pass the correct index.

The changes should only be made to the relevant helper, wrapper and
callers. We should not make any assumptions that by updating these
call sites it will mean that the `git add` or `git rm` command is now
free from global state.

### 4.4 Proposed project objective

I want to look into reducing a specific global repository/index
dependency in Git's pathspec code.

My initial investigation focuses on
`find_pathspecs_matching_skip_worktree()`, which currently obtains the
index through `the_repository->index` instead of receiving the index
it should use as an argument.

I will look to examine two possible API approaches:

1\. Keep the specialised helper and add an explicit `struct
index_state \*istate` parameter. I would then review how this
parameter should pass through the inline `matches_skip_worktree()`
wrapper and its callers.

2\. Investigate whether the existing
`find_pathspecs_matching_against_index()` API could be extended with
another `ps_skip_worktree_action` option to support the required
matching behaviour.

I will compare these approaches by looking at the existing API design,
the effect on callers, whether the required matching behaviour can be
represented clearly, and the amount of change each approach
introduces. I will discuss the findings with mentors and maintainers
before selecting the implementation.

I will also review the four identified call sites and determine which
index state each one should use. If the selected design and Git's test
infrastructure allow it, I will add a targeted regression test to
check that the helper uses the index supplied by its caller and that
existing sparse-checkout behaviour is preserved.

After this initial investigation and focused change, I may look into
whether other pathspec functions could also receive repository or
index information explicitly. Any further work will depend on the
technical findings and feedback from Git maintainers.

The aim is to reduce the reliance of selected parts of Git's pathspec
code on global state while preserving existing behaviour.

### 4.5 Scope boundaries

I intend to keep my initial work focused on the identified global
index dependency in `find_pathspecs_matching_skip_worktree()` and the
API changes needed to address it.

**What I will do initially:**

- Investigate the helper's reliance on `the_repository->index`.

- Compare the two API approaches described in Section 4.4 before
selecting an implementation.

- Review the inline wrapper and the four identified call sites, and
determine the correct index state for each caller.

- Investigate and, if feasible, add a focused regression test for the
selected implementation.

- Test the changes to ensure existing skip-worktree and
sparse-checkout behaviour is preserved.

**What I may investigate as follow-up work:**

- Depending on the initial findings and feedback from Git maintainers,
investigate `init_pathspec_item()` and selected parsing functions.

- Look into other pathspec functions only where there is a clear
repository/index dependency and a technically justified benefit to
making it explicit.

- Discuss any wider changes with mentors and maintainers before
expanding the scope.

**What I will not promise as part of the initial contribution:**

- Rewrite the whole pathspec subsystem.

- Remove all global variables from Git.

- Guarantee that `the_repository` will be completely removed from
pathspec functions.

- Claim that Git will become fully thread-safe as a result of this change.

- Make unrelated changes outside the agreed pathspec scope.

I will aim to make a focused and well-tested contribution while
preserving existing functionality. Any follow-up work will depend on
technical justification and maintainer guidance.

### 4.6 Feedback from Usman Akinyemi

During proposal preparation, I received technical feedback from Usman
Akinyemi about making the project objective and expected contribution
clearer. His feedback emphasized that the goal should not be described
simply as passing a `struct repository \*repo` argument. The important
point is to reduce hidden reliance on the global `the_repository` by
using the appropriate repository context and, where the function works
with an index, making the required `struct index_state \*istate`
explicit.

He also asked me to clarify what I expect to contribute and how the
work will be carried out over the internship timeline. I have used
this feedback to keep the proposed work focused on a specific
dependency, explain why the helper needs index state, identify the
callers that need investigation, and make the implementation and
testing plan conditional on the technical findings and
mentor/maintainer guidance.

This feedback helped me improve the proposal's technical explanation
and planning. It should not be read as approval of the specific
`find_pathspecs_matching_skip_worktree()` contribution or of either
API approach. I will confirm the suitability and final scope with the
mentors and Git community before treating it as agreed work.

---

## 5. Technical Implementation Plan

I will approach the work in stages. The first priority is to confirm
that the identified pathspec dependency is a suitable contribution and
that it does not overlap with existing upstream work. I will then
establish the current behaviour, compare the possible API designs, and
agree on a focused change with mentors and maintainers before
implementing it. The initial contribution will remain the main
deliverable. Further pathspec work will only be considered if the
initial change is completed, there is a clear technical reason, and
mentors agree that it is useful.

### Phase 1: Understand the Current Implementation

- Review the relevant implementation in `pathspec.c` and the
declaration/wrapper in `pathspec.h`.

- Understand the responsibilities of
`find_pathspecs_matching_skip_worktree()` and how it identifies
entries marked with `CE_SKIP_WORKTREE` or located outside the
sparse-checkout area.

- Understand how the relevant index is represented by `struct index_state`.

- Trace the helper, wrapper and callers, and record how each caller
currently obtains repository and index state.

- Review the wrapper's cached matching results and determine whether
the cache remains correct if the helper receives an explicit index. In
particular, check whether cached results are associated with the
correct index context.

- Investigate the lifetime and ownership of each index pointer that
could be passed to the helper. Do not assume that a repository pointer
or index pointer is interchangeable across callers.

- Pay particular attention to `cmd_rm()` and its currently unused
`struct repository \*repo` parameter; determine the correct index
context from the surrounding code.

- Review relevant existing tests and record the current behaviour
before changing anything.

### Phase 2: Compare the API Approaches and Agree on a Design

- Investigate adding an explicit `struct index_state \*istate`
parameter to the specialised helper and passing it through the
`matches_skip_worktree()` wrapper.

- Investigate whether `find_pathspecs_matching_against_index()` could
be extended with an additional `ps_skip_worktree_action` option that
expresses the required matching behaviour clearly.

- Compare the approaches for API clarity, semantics, caller impact,
cache correctness, maintainability and size of change.

- Confirm that any proposed action has a precise meaning. Do not
assume that the existing `PS_IGNORE_SKIP_WORKTREE` option provides the
inverse matching behaviour needed by the specialised helper.

- Discuss the findings with mentors and maintainers and select a
design only after the behaviour and trade-offs are understood.

- If the pathspec candidate is unsuitable, overlaps with upstream
work, or is not the right priority, discuss a different focused
contribution with mentors rather than forcing this design.

### Phase 3: Implement the Agreed Initial Change

- Make the smallest change that removes the identified implicit index
dependency, following the agreed API design.

- Update the helper declaration and definition, the inline wrapper and
only the callers affected by the selected design.

- Determine the correct index state at each affected call site; do not
mechanically pass a repository's index without checking its ownership
and intended use.

- Review the wrapper cache so that cached results cannot be
incorrectly reused for a different index context.

- Keep the change limited to the agreed helper/API and necessary
callers. Do not treat it as a complete removal of global state from
pathspec or from `git add`/`git rm`.

- Build Git and run the initial focused checks before preparing a
patch for review.

### Phase 4: Add Focused Tests and Validate Behaviour

- Check whether Git's C unit-test infrastructure can construct two
independent `struct index_state` instances for the proposed regression
scenario.

- If feasible and agreed, add a focused test that uses the same
pathspec with different index states and verifies that the result
follows the index supplied to the helper.

- Include the relevant skip-worktree and outside-sparse-checkout
behaviour in the test design where the infrastructure permits.

- If a two-index unit test is impractical, discuss and use an
alternative regression test that demonstrates the bug and protects the
intended behaviour.

- Run the existing tests relevant to the selected change, then expand
testing only where the implementation could affect additional cases.

### Phase 5: Review, Refine and Consider Any Follow-up

- Submit a small, clearly explained patch and provide the exact test result=
s.

- Respond to maintainer feedback, revise the patch and rerun affected
tests after each meaningful change.

- Investigate any compatibility issue revealed during review and keep
the fix within the agreed scope.

- Treat investigation of `init_pathspec_item()`, `parse_pathspec()` or
`parse_pathspec_file()` as optional research, not as a promised second
implementation.

- Only propose a follow-up change if the initial contribution is in a
reviewable state, the additional dependency is technically justified,
and mentors agree that it should be pursued.

- If no follow-up is appropriate, use the remaining time to improve
tests, documentation, review responses and handover for the initial
contribution.

The primary aim is one focused, technically justified and tested
contribution. Acceptance or merging is determined by the Git
maintainers and is not something I can promise in advance.

---

## 6. Testing and Validation Strategy

Testing will be guided by the final design and by the parts of Git
that the change can affect. I will first establish the current
behaviour, then add a focused regression test if the test
infrastructure supports it, and finally run the relevant existing
tests. I will not treat every pathspec edge case as part of the
initial test scope unless the selected change could affect it.

### 1. Establish the Existing Behaviour

- Record how `find_pathspecs_matching_skip_worktree()` currently
obtains and uses `the_repository->index`.

- Check how the helper handles entries marked with `CE_SKIP_WORKTREE`
and paths outside the sparse-checkout area.

- Review how `matches_skip_worktree()` caches and returns matching results.

- Trace the relevant callers and record the expected behaviour for each one=
.

- Use this baseline to identify what the regression test needs to demonstra=
te.

### 2. Investigate a Focused Regression Test

- First check Git's existing C unit-test conventions and whether
separate `struct index_state` objects can be constructed safely in a
test.

- If feasible, prepare two index states with different skip-worktree
information and run the same pathspec against both.

- Check that the result follows the index explicitly supplied to the
helper, rather than silently using the global repository index.

- Consider the helper's outside-sparse-checkout behaviour as part of
the test design where appropriate.

- Check that test setup and cleanup respect the ownership and lifetime
of index entries and related data.

- If this exact two-index test is not practical, discuss an
alternative focused regression test with mentors and maintainers.

### 3. Build and Run the Focused Test

- Build Git after the implementation changes.

- Compile and run the focused test if one is added.

- Where practical, verify that the test exposes the old behaviour and
passes with the corrected implementation.

- Follow the existing test conventions for setup, registration and cleanup.

- Investigate and fix compilation errors, test failures or
memory/lifetime problems introduced by the change.

### 4. Run Relevant Existing Tests

For the initial helper/API change, I expect to begin with:

- The relevant pathspec tests.

- `t/t3705-add-sparse-checkout.sh` for relevant `git add`
sparse-checkout behaviour.

- `t/t3602-rm-sparse-checkout.sh` for relevant `git rm`
sparse-checkout behaviour.

- Any additional focused test identified during source investigation
or requested during review.

I will investigate sparse-index, prefixed pathspec and wildcard
pathspec cases where the selected change could affect them. I will
extend the test set if the implementation or review identifies a
concrete risk. Cases such as `PATHSPEC_NO_REPOSITORY`, `git diff
--no-index` and path-prefix handling will be included if a follow-up
change reaches pathspec initialization or parsing; they are not
blanket requirements for the initial helper change.

### 5. Retest After Review

- Rerun the focused test and affected existing tests after making
review-driven changes.

- Record the commands run and their results accurately, including
failures and limitations.

- Investigate failures before attributing them to the patch.

- Use sanitizers or broader test runs if a concrete memory-safety or
compatibility concern makes them relevant, and where the environment
supports them.

- Report what was tested and what was not tested in the patch
discussion and final handover.

---

## 7. Thirteen-Week Work Plan

The internship is scheduled for 7 December 2026 to 8 March 2027. I
plan to dedicate around 30 hours per week. This is a provisional work
plan; the final technical scope and priorities will be agreed with the
mentors. The plan prioritises completing and reviewing one focused
contribution rather than promising a second refactor before the first
one is stable.

### Weeks 1=E2=80=932: Onboarding, Confirm Scope and Complete the Design

- Confirm the development environment, Git contribution workflow,
communication rhythm and test commands with mentors.

- Review the current upstream state and check for overlapping work.

- Revisit the helper, wrapper and callers, including the wrapper cache
and index pointer lifetime/ownership.

- Compare the two API approaches described in Section 4.4.

- Present the technical findings, risks and test options to mentors
and maintainers.

- Agree on the initial contribution and its acceptance criteria.

- If the pathspec candidate is unsuitable or overlaps with ongoing
work, discuss an alternative focused task with mentors.

**Output:** An agreed initial scope and design direction, or a
documented alternative task. No implementation will be started on an
uncertain design simply to meet a pre-set milestone.

### Weeks 3=E2=80=934: Implement the Agreed Focused Change

- Implement the smallest agreed change to make the required index
dependency explicit.

- Update the relevant declaration, definition, wrapper and affected callers=
.

- Check the wrapper cache and ensure it does not reuse results for the
wrong index context.

- Verify the index state used at each affected call site, including
the `cmd_rm()` path.

- Build Git and run initial focused checks.

- Prepare a small patch with a clear explanation of the problem and design.

**Output:** An initial implementation and patch ready for focused
testing and review.

### Week 5: Develop the Regression Test

- Investigate and, if feasible, implement the two-index regression
test described in Section 6.

- Check setup, cleanup, index ownership and the expected behaviour for
both index states.

- If that test design is not practical, discuss and implement an
appropriate alternative test.

- Build and run the test and record the result.

**Output:** A focused regression test or an agreed alternative, with
test results recorded.

### Weeks 6=E2=80=937: Run Compatibility Tests and Submit for Review

- Run the relevant pathspec and sparse-checkout tests.

- Check the affected `git add` and `git rm` behaviour.

- Investigate sparse-index, prefixed and wildcard cases where they are
relevant to the selected change.

- Submit the focused patch to the Git community and provide test results.

- Respond to initial review comments and revise the patch where needed.

- Publish the required progress update and describe the work accurately.

**Output:** The initial contribution submitted for review, with
relevant test coverage and review feedback being addressed.

### Weeks 8=E2=80=9310: Review, Refine and Validate the Initial Contributio=
n

- Prioritise maintainer feedback on the initial contribution.

- Revisit design decisions if reviewers identify a simpler or safer approac=
h.

- Fix issues, update tests and rerun affected test suites after changes.

- Investigate any newly identified compatibility or lifetime concerns.

- Keep communication clear by explaining changes and reporting test results=
.

- Only if the initial contribution is in a stable, reviewable state,
discuss whether a small follow-up investigation is useful. Do not
assume a second implementation is required.

- If no follow-up is appropriate, use this period for further review,
testing and refinement of the initial patch.

**Output:** A more complete and carefully reviewed initial
contribution. A follow-up is optional and depends on mentor agreement
and available time.

### Week 11: Final Technical Review

- Review the complete patch and its rationale.

- Confirm that the tests cover the behaviour changed by the implementation.

- Address remaining review comments where possible.

- Run the relevant tests again after the final code changes.

- Record any unresolved issues or limitations honestly.

**Output:** A final refined patch or patch series, with its review and
testing status clearly recorded.

### Weeks 12=E2=80=9313: Final Validation, Documentation and Handover

- Run the final focused tests and any additional tests agreed with mentors.

- Review the final implementation, test results and outstanding review poin=
ts.

- Document the design choice, changes made, test commands/results and
known limitations.

- Prepare a handover summary describing what was completed, what was
submitted, what was accepted or integrated if applicable, and what
remains.

- Complete the required Outreachy blog reports and final report.

**Output:** A tested and documented contribution, together with an
accurate handover and final report. The final status may be submitted,
under review, accepted or merged depending on the maintainers'
decisions; merging is not a guaranteed deliverable.

---

## Work-plan Flexibility

The above plan is a suggested timeline. I may need to make changes
based on technical issues, mentor guidance, or feedback from the
community. The aim is to create a small, useful, and well-tested
change. Any further changes to pathspec or its parser will only be
considered if there is a clear technical reason and mentors agree. The
first two weeks include a decision point: if the pathspec candidate is
unsuitable, overlaps with existing work, or cannot be given a clear
and testable design, I will discuss an alternative focused
contribution with mentors rather than force the proposed change. If
the two-index test is not practical, I will agree on an alternative
test strategy. If review takes longer than expected, I will prioritise
improving and validating the initial contribution rather than starting
a second refactor.

The aim is not to remove all global dependencies in Git. The aim is to
make a meaningful contribution by improving how repository and index
state are handled explicitly. If the initial pathspec change overlaps
with existing work or is not considered appropriate, I will discuss
alternative approaches with mentors and adjust the scope accordingly.

## Blogging and Progress Reports

During the internship, I will follow Outreachy's blogging
requirements. I understand that interns are expected to publish at
least three reports and to blog every two weeks about their
internship. I will use the introduction, midpoint and final report
prompts provided by Outreachy, and write shorter progress updates
between those reports when required.

My reports will cover:

- **Introduction:** Introduce myself, the Git community and the
project; explain why I applied, what I learned during the contribution
period, the contributions I am proud of, and what I hope to learn
during the internship.

- **Mid-point progress:** Describe the work completed so far, link to
contributions, explain technical challenges and what I learned from
mentors and the community, and mention any changes to the project
scope or timeline.

- **Final report:** Describe the results of my work and link to
contributions, explain what I learned, identify any remaining work or
ways the community could continue the work, and discuss my plans after
the internship.

I will also share shorter updates about my progress, implementation
decisions, testing results and challenges every two weeks. I will
follow the instructions and deadlines sent by Outreachy and make sure
that my reports accurately describe the work I have completed.

---

---

## 8. Risks and Mitigation

### Risk 1: Existing global dependencies are more widespread than expected

The pathspec implementation may contain additional dependencies on
`the_repository` or other repository-related global variables beyond
the helper identified during the preliminary investigation.

**Mitigation:**

- I will review the relevant functions and their callers before making
API changes.

- I will check how repository and index state are accessed and used.

- I will make changes incrementally, starting with the selected
skip-worktree helper.

- I will investigate any further dependencies before increasing the
scope of the change.

- I will not assume that a focused change has removed all global dependenci=
es.

### Risk 2: Existing Git behavior may change accidentally

Changes to how the helper accesses index state may cause unwanted
changes to current pathspec matching and skip-worktree behavior.

**Mitigation:**

- I will analyse the current behaviour and document it.

- I will investigate and, if feasible, write a focused regression test
using two separate index states.

- I will check that the outcome depends on the index passed to the
helper, rather than the default global index.

- I will run focused tests covering relevant pathspec, `git add` and
`git rm` operations.

- I will check that existing behaviour, compatibility and error
handling are preserved.

### Risk 3: Sparse-checkout and sparse-index edge cases

The change may interact with current sparse-checkout behavior,
skip-worktree entries, or sparse-index behavior.

**Mitigation:**

- I will test relevant skip-worktree entries and check that they
behave as expected.

- I will test relevant pathspec forms, including prefixed and wildcard
pathspecs.

- I will run the relevant sparse-checkout tests.

- I will investigate sparse-index compatibility and look for possible
regressions.

- I will use sanitizers where appropriate.

### Risk 4: API changes may affect multiple callers

The helper may require changes to multiple callers. Some callers may
access repository or index state in different ways.

**Mitigation:**

- I will identify and review all known callers.

- I will check which repository or index context each caller uses.

- I will pay particular attention to `cmd_rm()` and how its repository
context should be used.

- I will compare the API options and discuss the most suitable
approach with maintainers.

- I will keep the resulting changes focused.

### Risk 5: Maintainer feedback or existing upstream work may change
the proposed scope

The pathspec change is still open for feedback. There may be other
changes by maintainers or contributors that affect its suitability or
scope.

**Mitigation:**

- Share the initial investigation and focused change early.

- Ask for feedback before making wider changes to pathspec.

- Check for upstream changes and possible overlap throughout the work.

- Adjust the implementation based on feedback from maintainers.

- If the scope is unsuitable or overlaps with existing work, discuss
an alternative contribution with my mentors.

### Risk 6: The proposed regression-test approach may not fit Git's
test infrastructure

The two-index regression test may require a different setup or
location based on Git's existing C unit-test conventions.

**Mitigation:**

- I will look at the existing C unit tests in Git.

- I will study how index states, cache entries and `CE_SKIP_WORKTREE`
are set up.

- I will make sure the test is placed in the appropriate location,
registered and cleaned up correctly.

- I will discuss the testing approach with maintainers if necessary.

- I will build Git, compile the test and run it to verify the implementatio=
n.

### Risk 7: Wrapper caching or index lifetime is handled incorrectly

Making the index explicit may expose issues if cached pathspec matches
are reused for a different index, or if a caller passes an index whose
lifetime or ownership is not appropriate.

**Mitigation:**

- I will inspect how the wrapper cache is keyed, populated and reused
before changing the API.

- I will verify whether the cache must be tied to the supplied index
or invalidated when the index context changes.

- I will trace the lifetime and ownership of each index pointer at the
affected callers.

- I will avoid retaining an index pointer beyond the lifetime
guaranteed by its owner.

- I will include these findings in the design discussion and add
focused tests for any cache behaviour that the selected change could
affect.

---

## 9. Communication and Review Strategy

Throughout the internship, I will keep in communication with the Git commun=
ity.

My strategy will include:

- Using the public Git mailing list to communicate.

- Asking clear and specific technical questions.

- Submitting small, focused patches early to receive feedback.

- Carefully reviewing feedback from maintainers and contributors and
providing responses.

- Making necessary changes and resubmitting updated versions of the patches=
.

- Explaining the technical reasoning behind the implementation and API choi=
ces.

- Keeping patches concise, well-tested, and easy to review.

- Clearly stating test results, including any failures or limitations.

- Discussing any major changes to the proposal scope with my mentors.

During my initial research, I emailed the Git community on 2 November
2026 to ask whether my proposed pathspec contribution would be
suitable and to discuss the possible implementation approaches.

The discussion can be found here:

https://gitlist.dev/t/66745

I will use feedback from the Git community and my mentors to improve
my implementation approach. As the pathspec contribution has not yet
been approved, I will not consider it confirmed until I receive
guidance from maintainers.

---

## 10. Expected Outcomes and Deliverables

My primary goal is to complete one focused, technically justified
contribution that reduces the identified hidden index dependency in
the agreed part of Git's pathspec code, while preserving existing
behaviour.

The expected work and deliverables are:

- A documented analysis of the helper, wrapper, relevant callers,
cache behaviour and index ownership/lifetime.

- A comparison of the two API approaches: adding an explicit `struct
index_state \*istate` parameter to
`find_pathspecs_matching_skip_worktree()`, or extending
`find_pathspecs_matching_against_index()` with a clearly defined
`ps_skip_worktree_action` option.

- A design selected after technical investigation and discussion with
mentors and maintainers.

- One focused implementation of the agreed design, including only the
necessary changes to the helper/API, wrapper and affected callers.

- A focused regression test if Git's test infrastructure supports the
proposed approach, or an alternative test agreed during the
investigation.

- Relevant build and test results, including sparse-checkout and `git
add`/`git rm` checks where affected by the change.

- A patch explanation, review responses and revisions based on
maintainer feedback.

- A final summary of the implementation, tests performed, review
status and any remaining limitations.

Investigation of other pathspec functions, such as
`init_pathspec_item()`, `parse_pathspec()` or `parse_pathspec_file()`,
is optional follow-up work. It will only be pursued if the initial
contribution is in a stable state, there is a clear technical reason,
and mentors agree that it is appropriate.

The exact implementation and test deliverables will depend on the
technical findings and the design agreed with the Git community. I can
commit to careful investigation, focused implementation, testing and
review; I cannot promise that a patch will be accepted or merged
within the internship period.

---

## 11. Relevant Experience and Skills

During my preparation for this project, I have learned C programming
fundamentals, explored Git's source code, and gained practical
experience contributing to Git.

I have worked on the following:

- Learning C programming, including functions, structures, pointers,
function arguments, return values, and accessing structure members.

- Understanding global variables, global state, and explicit
dependencies, including how repository context can be passed to
functions.

- Exploring Git's source code, including `repository.c`,
`repository.h`, `environment.c`, `alias.c`, and `pathspec.c`.

- Understanding `the_repository` and `struct repository \*repo`, and
investigating how repository-specific state is accessed.

- Studying previous refactoring work, including how
`is_bare_repository_cfg` was split into separate responsibilities.

- Exploring repository configuration and state management, including
`core.attributesFile` and `core.hooksPath`.

- Using commands such as `git grep`, `git log`, `git show`, `git
diff`, and `sed` to explore Git's source code, understand its history,
and examine changes.

- Contributing to Git through changes involving test scripts,
test-path checks, safe integer arithmetic, and repository-aware commit
abbreviations for submodules.

- Creating and revising patches, responding to review feedback, and
learning how contributions are discussed within the Git community.

- Exploring Git's testing framework and understanding how tests help
verify existing behaviour.

This preparation has helped me understand the importance of repository
context, ownership of state, and careful refactoring in Git. Although
I am still developing my C programming and Git internals knowledge, I
have gained practical experience exploring Git's codebase and
contributing changes. I would like to build on this foundation by
making a focused contribution with appropriate testing during the
internship.

## 12. Availability and Commitment

I am available for this internship between 7 December 2026 and 8 March 2027=
.

I can dedicate around 30 hours per week to the internship.

During this period, I will:

- Consistently dedicate time to the project.

- Implement changes using an incremental approach.

- Take time to understand the existing codebase.

- Write tests and run them.

- Participate in discussions and communicate with my mentors and the
Git community.

- Take feedback into account and improve patches where needed.

- Keep track of my progress and communicate any issues.

I understand that contributing to an open-source project requires
continuous learning, patience, and teamwork. I will work consistently
on my contributions, learn from feedback, and aim to make a useful
contribution to the Git project.

## 13. References / Useful Links

The following links provide additional information about the Git
project and how to get involved. They also include examples of work I
have done previously and research I have carried out into the
technical side of my proposed contribution.

### Official Git Information

- Outreachy Project Selection for December 2026:
https://www.outreachy.org/apply/project-selection/

- Git Source Code: https://github.com/git/git

- Git Documentation: https://git-scm.com/docs

- Git Contribution Guidelines:
https://github.com/git/git/blob/master/Documentation/SubmittingPatches

- Git Coding Guidelines:
https://github.com/git/git/blob/master/Documentation/CodingGuidelines

- Git Mailing List: https://lore.kernel.org/git/

- Git General Application Information:
https://git.github.io/General-Application-Information/

- Git Microproject Information:
https://git.github.io/General-Microproject-Information/

### Previous Contributions

These are examples of contributions I have made to the Git project,
including work involving source code, test files, and preparing and
revising patches based on review feedback.

- PR #2260 =E2=80=93 t0001: avoid pipes in test scripts:
https://github.com/gitgitgadget/git/pull/2260
  This was my microproject contribution. I updated the `t0001-init.sh`
test script to avoid using pipes.

- PR #2256 =E2=80=93 t2030: modernize test path checks:
https://github.com/gitgitgadget/git/pull/2256
  This contribution modernizes the path checks in the `t2030` test.

- PR #2276 =E2=80=93 diff-delta: use safe integer arithmetic:
https://github.com/gitgitgadget/git/pull/2276
  This contribution updates the integer arithmetic used in
`diff-delta` to use safer operations.

- PR #2288 =E2=80=93 t4041: use submodule repository for commit abbreviatio=
ns:
https://github.com/gitgitgadget/git/pull/2288
  This contribution uses the submodule's repository context when
determining commit abbreviations.

Mailing-list versions of these contributions:

- PR #2260 v2: https://lore.kernel.org/git/pull.2260.v2.git.1792666211685.g=
itgitgadget@gmail.com

- PR #2256 v3: https://lore.kernel.org/git/pull.2256.v3.git.1792299943380.g=
itgitgadget@gmail.com

- PR #2276 v9: https://lore.kernel.org/git/pull.2276.v9.git.1793120160248.g=
itgitgadget@gmail.com

### Relevant Source Code and Tests

- `pathspec.c`: https://github.com/git/git/blob/master/pathspec.c

- `pathspec.h`: https://github.com/git/git/blob/master/pathspec.h

- `builtin/add.c`: https://github.com/git/git/blob/master/builtin/add.c

- `builtin/rm.c`: https://github.com/git/git/blob/master/builtin/rm.c

- Sparse-checkout tests for `git add`:
https://github.com/git/git/blob/master/t/t3705-add-sparse-checkout.sh

- Sparse-checkout tests for `git rm`:
https://github.com/git/git/blob/master/t/t3602-rm-sparse-checkout.sh

### Research into the Project

Discussion about the scope of the proposed pathspec contribution,
including possible API approaches and whether related work is already
planned.

https://gitlist.dev/t/66745 (2 November 2026)

Background on previous changes involving repository state and global
dependencies:

- Git v2.56.0 release notes:
https://github.com/git/git/blob/master/Documentation/RelNotes/2.56.0.adoc

- Commit `7ff3a5895b`, which split the concerns of
`is_bare_repository_cfg`: https://github.com/git/git/commit/7ff3a5895b

- Commit `dd674df326`, which uses `item.match` consistently for
sparse-index expansion checks and adds coverage for prefixed wildcard
pathspecs: https://github.com/git/git/commit/dd674df326

- Git's official 2026 GSoC ideas page, including the project
'Refactoring in order to reduce Git's global state':
https://git.github.io/SoC-2026-Ideas/

## Acknowledgements

I would like to thank Usman Akinyemi, Junio C Hamano, Patrick
Steinhardt, Harald Nordgren, Phillip Wood, Pablo Sabater, Okhuomon
Ajayi, my mentors, maintainers, and members of the Git community for
taking the time to review my contributions, answer my questions, and
share their technical feedback. Their guidance and effort have helped
me understand the codebase better, improve my patches, and learn from
the contribution and review process. I sincerely appreciate their time
and support.

## 14. Conclusion

Reducing global state makes dependencies clearer and helps Git move
towards being usable as a library. During my preparation, I explored
Git's source code, read about earlier refactoring work, and
investigated how repository and index information are used in pathspec
processing.

My initial area of interest is
`find_pathspecs_matching_skip_worktree()`, which currently gets the
index through `the_repository->index`. I want to investigate how this
dependency could be made explicit. I will compare adding a `struct
index_state \*istate` parameter to the specialised helper with
extending the existing `find_pathspecs_matching_against_index()` API.
I will discuss the options with mentors and maintainers before
deciding which approach is most suitable.

I also want to investigate a regression test using two separate index
states, if Git's test infrastructure supports that approach. The test
should help check that the helper uses the index supplied by its
caller and that existing pathspec and skip-worktree behaviour is
preserved. Any further pathspec changes will depend on what I find and
on feedback from mentors and maintainers.

I know that this work will involve learning more about Git's code,
testing carefully and responding to review feedback. I hope to build
on the preparation I have already done and make a focused contribution
to the Git project.
