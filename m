Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98F61F404
	for <e@80x24.org>; Fri, 16 Mar 2018 17:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932846AbeCPP2a (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 11:28:30 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48004 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754320AbeCPP20 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Mar 2018 11:28:26 -0400
X-AuditID: 12074414-ebbff70000000aea-00-5aabe2982819
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 70.CA.02794.892EBAA5; Fri, 16 Mar 2018 11:28:25 -0400 (EDT)
Received: from mail-lf0-f43.google.com (mail-lf0-f43.google.com [209.85.215.43])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w2GFSNOW010026
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:28:24 -0400
Received: by mail-lf0-f43.google.com with SMTP id a22-v6so15936856lfg.9
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 08:28:24 -0700 (PDT)
X-Gm-Message-State: AElRT7EC6ZgegooVzEMuTda+2vYhVuYV7dumo6Uvn6nfKdV1I1qnUofx
        javtkGHrcV+eLD4ZpqmlZSSY8tnzESDWecZRcBs=
X-Google-Smtp-Source: AG47ELuu6fHpGWGsQfvKnbPyG2MKZ7vMJyTqwdyQiHgw5bk5FN2IpaAZfn3WQvCJ1ZJRLNYk6GwemMDzNdty/tJ0fBo=
X-Received: by 10.46.137.71 with SMTP id b7mr1615704ljk.39.1521214102850; Fri,
 16 Mar 2018 08:28:22 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.46.135.152 with HTTP; Fri, 16 Mar 2018 08:28:22 -0700 (PDT)
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Fri, 16 Mar 2018 16:28:22 +0100
X-Gmail-Original-Message-ID: <CAMy9T_FaOdLP482YZcMX16mpy_EgM0ok1GKg45rE=X+HTGxSiQ@mail.gmail.com>
Message-ID: <CAMy9T_FaOdLP482YZcMX16mpy_EgM0ok1GKg45rE=X+HTGxSiQ@mail.gmail.com>
Subject: [ANNOUNCE] git-sizer: compute various size-related metrics for your
 Git repository
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1J35aHWUwc8XghZdV7qZHBg9Pm+S
        C2CM4rJJSc3JLEst0rdL4Mo43NDEXDDNpmLy9IPMDYxzVboYOTkkBEwk5iw/x9rFyMUhJLCD
        SeLk499sEM4jJolHP/6wQzgTGSXuTV/HAtFSLjF512Qou0hi8eIpzBB2ocSivavYQWxeAUGJ
        kzOfgNUICchJvNpwgxHC9pb4c3UJE4jNJqArsainGcxmEVCVeLD+HRPEnESJOXceMUPMCZBY
        uGEpWK+wQKxE54zbYDUiAloSf1btBbOZgebsWXuQDcLWlGjd/pt9AqPQLCRnzEKSWsDItIpR
        LjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJFxFdjAeOSl3iFGAg1GJh9fiwuoo
        IdbEsuLK3EOMkhxMSqK8zseBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4LWcC5XhTEiurUovy
        YVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHhrHwI1ChalpqdWpGXmlCCkmTg4QYbz
        AA0PAKnhLS5IzC3OTIfIn2K05/g260EbM8efvSDy27TnQPLGi9dtzEIsefl5qVLivM8eALUJ
        gLRllObBTYaloleM4kCPCvPuBRnOA0xjcLNfAa1lAlqbuW0FyNqSRISUVAOj9pWGJxsXn2U8
        sFPzivfB3a5vVL7qri52WjE7MPxlTuHr1U3+6eaBD7t47hSmqX2YFCmdffHOxzabPbtMJru7
        6N2MPGg7K1/V+LWgzq+zkUsFVlt/1lry6z9/43ujk+0CX87/7XqvuadVwWp98/aNbnHyCyYG
        J+hvDAm14K/a9VZoY9izZA8vJZbijERDLeai4kQAoNT4jCADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What makes a Git repository unwieldy to work with and host? It turns
out that the respository's on-disk size in gigabytes is only part of
the story. From our experience at GitHub, repositories cause problems
because of poor internal layout at least as often as because of their
overall size. For example,

* blobs or trees that are too large
* large blobs that are modified frequently (e.g., database dumps)
* large trees that are modified frequently
* trees that expand to unreasonable size when checked out (e.g., "Git
bombs" [2])
* too many tiny Git objects
* too many references
* other oddities, such as giant octopus merges, super long reference
names or file paths, huge commit messages, etc.

`git-sizer` [1] is a new open-source tool that computes various
size-related statistics for a Git repository and points out those that
are likely to cause problems or inconvenience to its users.

I tried to make the output of `git-sizer` "opinionated" and easy to
interpret. Example output for the Linux kernel is appended below. I
also made it memory-efficient and resistant against git bombs.

I've written a blog post [3] about `git-sizer` with more explanation
and examples, and the main project page [1] has a long README with
some information about what the individual metrics mean and tips for
fixing problems.

I also put quite a bit of effort into making `git-sizer` fast. It does
its work (including figuring out path names for large objects) based
on a single traversal of the repository history using `git rev-list
--objects --reverse [...]`, followed by using the output of `git
cat-file --batch` or `git cat-file --batch-check` to get information
about individual objects.

On that subject, let me share some more technical details. `git-sizer`
is written in Go. I prototyped several ways of extracting object
information, which is critical to the performance because `git-sizer`
has to read all of the reachable non-blob objects in the repository.
The results surprised me:

| Mechanism for accessing Git data                    | Time   |
| --------------------------------------------------- | -----: |
| `libgit2/git2go`                                    | 25.5 s |
| `libgit2/git2go` with `ManagedTree` optimization    | 18.9 s |
| `src-d/go-git`                                      | 63.0 s |
| Git command line client                             |  6.6 s |

It was almost a factor of four faster to read and parse the output of
Git plumbing commands (mainly `git for-each-ref`, `git rev-list
--objects`, `git cat-file --batch-check`, and `git cat-file --batch`)
than it was to use the Go bindings to libgit2. (I expect that part of
the reason is that Go's peculiar stack layout makes it quite expensive
to call out to C.) Even after Carlos Martin implemented an
experimental `ManagedTree` optimization that removed the need to call
C for every entry in a tree, it was still not competitive with the Git
CLI. `go-git`, which is a Git implementation in pure Go, was even
slower. So the final version of `git-sizer` calls `git` for accessing
the repository.

Feedback is welcome, including about the weightings [4] that I use to
compute the "level of concern" of the various metrics.

Have fun,
Michael

[1] https://github.com/github/git-sizer
[2] https://kate.io/blog/git-bomb/
[3] https://blog.github.com/2018-03-05-measuring-the-many-sizes-of-a-git-repository/
[4] https://github.com/github/git-sizer/blob/2e9a30f241ac357f2af01d42f0dd51fbbbae4b0b/sizes/output.go#L330-L401

$ git-sizer --verbose
Processing blobs: 1652370
Processing trees: 3396199
Processing commits: 722647
Matching commits to trees: 722647
Processing annotated tags: 534
Processing references: 539
| Name                         | Value     | Level of concern               |
| ---------------------------- | --------- | ------------------------------ |
| Overall repository size      |           |                                |
| * Commits                    |           |                                |
|   * Count                    |   723 k   | *                              |
|   * Total size               |   525 MiB | **                             |
| * Trees                      |           |                                |
|   * Count                    |  3.40 M   | **                             |
|   * Total size               |  9.00 GiB | ****                           |
|   * Total tree entries       |   264 M   | *****                          |
| * Blobs                      |           |                                |
|   * Count                    |  1.65 M   | *                              |
|   * Total size               |  55.8 GiB | *****                          |
| * Annotated tags             |           |                                |
|   * Count                    |   534     |                                |
| * References                 |           |                                |
|   * Count                    |   539     |                                |
|                              |           |                                |
| Biggest objects              |           |                                |
| * Commits                    |           |                                |
|   * Maximum size         [1] |  72.7 KiB | *                              |
|   * Maximum parents      [2] |    66     | ******                         |
| * Trees                      |           |                                |
|   * Maximum entries      [3] |  1.68 k   |                                |
| * Blobs                      |           |                                |
|   * Maximum size         [4] |  13.5 MiB | *                              |
|                              |           |                                |
| History structure            |           |                                |
| * Maximum history depth      |   136 k   |                                |
| * Maximum tag depth      [5] |     1     | *                              |
|                              |           |                                |
| Biggest checkouts            |           |                                |
| * Number of directories  [6] |  4.38 k   | **                             |
| * Maximum path depth     [7] |    13     | *                              |
| * Maximum path length    [8] |   134 B   | *                              |
| * Number of files        [9] |  62.3 k   | *                              |
| * Total size of files    [9] |   747 MiB |                                |
| * Number of symlinks    [10] |    40     |                                |
| * Number of submodules       |     0     |                                |

[1]  91cc53b0c78596a73fa708cceb7313e7168bb146
[2]  2cde51fbd0f310c8a2c5f977e665c0ac3945b46d
[3]  4f86eed5893207aca2c2da86b35b38f2e1ec1fc8
(refs/heads/master:arch/arm/boot/dts)
[4]  a02b6794337286bc12c907c33d5d75537c240bd0
(refs/heads/master:drivers/gpu/drm/amd/include/asic_reg/vega10/NBIO/nbio_6_1_sh_mask.h)
[5]  5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c (refs/tags/v2.6.11)
[6]  1459754b9d9acc2ffac8525bed6691e15913c6e2
(589b754df3f37ca0a1f96fccde7f91c59266f38a^{tree})
[7]  78a269635e76ed927e17d7883f2d90313570fdbc
(dae09011115133666e47c35673c0564b0a702db7^{tree})
[8]  ce5f2e31d3bdc1186041fdfd27a5ac96e728f2c5 (refs/heads/master^{tree})
[9]  532bdadc08402b7a72a4b45a2e02e5c710b7d626
(e9ef1fe312b533592e39cddc1327463c30b0ed8d^{tree})
[10] f29a5ea76884ac37e1197bef1941f62fda3f7b99
(f5308d1b83eba20e69df5e0926ba7257c8dd9074^{tree})
