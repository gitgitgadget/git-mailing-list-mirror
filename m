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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BAE41F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 16:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfJJQNq (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 12:13:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55999 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJJQNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 12:13:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id a6so7569962wma.5
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sHnjp65WELDg0aBB1yFF9ieUQesRkxBefxxFEg1HDmQ=;
        b=PIwFjL3ybSUAmrQ0IRhnM4cxlzwwNZpK/yYPWtCJ8V2jm3UzQjBVbJLxN9jfu5cwzT
         01Exy/h8UL3kz9LfsJQ4QYFm/eimywX3o5fWzkCLVBRWF6+mziI8DpKwQeIP+bz0gyg7
         RHkFobR4GOVWQ2g9/wKE1X162O/YVGOTODcvjJQpafoL3/E9ZbXGl/1fIAG3i88qajAW
         zvVK0QmbNOA2NeUFzx+KjR0aCkazvjnR+w/u8cte6PeQ+R85remKo+9lX43WGXYczlHE
         VMKA+MJWfxKLaSwwVDtYI9ytcjE+YVrwVp9N7KSMJMddxcKdQpDN6CenQgIRmrkjAvkl
         QIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sHnjp65WELDg0aBB1yFF9ieUQesRkxBefxxFEg1HDmQ=;
        b=U/ntR32dCroTnT5o6hzIgrpr50vFMUQVTO2XQSYB6JjWUW9GaTtGgf0uOIfhU0Izhn
         g8O4b+pcCT852GuzyLkF5z65g040BcYZy1JjNCDpRFAfRtp34PkE5oICuxYZ1My8DYcw
         +zkg9UWHyd4uxfPHDGzAaY4yEmtV2CY9aHYdnspRBnkeO8Z0B92na4YwtaVXi4cT90vt
         p5JfYNOmTHs58ViD0GE1mG185gfAvzTfLFJagRi6YGlBHgSXih3/eUJVbG+BhFg2DrSr
         3N1Q396vLqZlq5Vvn3AMTpLkRGJC65DLjJxWpIBJ1JpP9ettGUeHxMwvHpqlV0HCpMlm
         +cuQ==
X-Gm-Message-State: APjAAAVlbnu4G7tXViGHDiZu4cZeAuBfPzlI3YeahkNEzdIHs11/ZZF8
        udyy3FTuZXO7RMrZQdd89Mk1zP+5
X-Google-Smtp-Source: APXvYqyark5FB/FfuJUU+AWkZXungAALlFl38P/QfBKyJVWdX73niw9zOtht5ywHGsAFDmGkOB7RiA==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr8016491wmc.163.1570724022909;
        Thu, 10 Oct 2019 09:13:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11sm5475650wmd.32.2019.10.10.09.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:13:42 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:13:42 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 16:13:29 GMT
Message-Id: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/11] Improve the readability of log --graph output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches are designed to improve the output of the log --graph
command; their effect can be summed up in the following diagram:

    Before                    After
    ------                    -----

    *
    |\
    | *                       *
    | |\                      |\
    | | *                     | *
    | | |                     | |\
    | |  \                    | | *
    | *-. \                   | * |
    | |\ \ \                  |/|\|
    |/ / / /                  | | *
    | | | /                   | * |
    | | |/                    | |/
    | | *                     * /
    | * |                     |/
    | |/                      *
    * |
    |/
    *

These changes aim to make the edges in graph diagrams easier to read, by
straightening lines and making certain kinds of topologies display more
compactly. Three distinct changes are included.

First, if the first parent of a merge fuses with an edge to the left of the
commit, then we display that by making the edges fuse immediately rather
than by drawing a line straight down and then having it track to the left.
That is, where we currently display these graphs:

    | *             | | | *
    | |\            | | | |\
    |/ /            | |_|/ /
    | |             |/| | |

We will now display these merges as follows:

    | *             | | | *
    |/|             | |_|/|
    | |             |/| | |

This transformation is applied to merges with any number of parents, for
example we currently display 3-parent merges like this:

    | *-.           | | | *-.
    | |\ \          | | | |\ \
    |/ / /          | |_|/ / /
    | | |           |/| | | |

And we will now display them like this:

    | *             | | | *
    |/|\            | |_|/|\
    | | |           |/| | | |

If the edge the first parent fuses with is separated from the commit by
multiple columns, a horizontal edge is drawn just as we currently do in the
'collapsing' state. This change also affects the display of commit and
post-merge lines in subtle ways that are more thoroughly described in the
relevant commits.

The second change is that if the final parent of a merge fuses with the edge
to the right of the commit, then we can remove the zig-zag effect that
currently results. We currently display these merges like this:

    * |
    |\ \
    | |/
    | *

After these changes, this merge will now be displayed like so:

    * |
    |\|
    | *

If the final parent fuses with an edge that's further to the right, its
display is unchanged and it will still display like this:

    * | | |
    |\ \ \ \
    | | |_|/
    | |/| |
    | * | |

The final structural change smooths out lines that are collapsing through
commit lines. For example, consider the following history:

    *-. \
    |\ \ \
    | | * |
    | * | |
    | |/ /
    * | |
    |/ /
    * |
    |/
    *

This is now rendered so that commit lines display an edge using / instead of
|, if that edge is tracking to the left both above and below the commit
line. That results in this improved display:

    *-. \
    |\ \ \
    | | * |
    | * | |
    | |/ /
    * / /
    |/ /
    * /
    |/
    *

Taken together, these changes produce the change shown in the first diagram
above, with the current rendering on the left and the new rendering on the
right.

A final addition to that set of changes fixes the coloring of dashes that
are drawn next to octopus merges, in a manner compatible with all these
changes. The early commits in this set are refactorings that make the
functional changes easier to introduce.

James Coglan (11):
  graph: automatically track visible width of `strbuf`
  graph: reuse `find_new_column_by_commit()`
  graph: reduce duplication in `graph_insert_into_new_columns()`
  graph: remove `mapping_idx` and `graph_update_width()`
  graph: extract logic for moving to GRAPH_PRE_COMMIT state
  graph: tidy up display of left-skewed merges
  graph: commit and post-merge lines for left-skewed merges
  graph: rename `new_mapping` to `old_mapping`
  graph: smooth appearance of collapsing edges on commit lines
  graph: flatten edges that join to their right neighbor
  graph: fix coloring of octopus dashes

 graph.c                                    | 499 ++++++++++++---------
 strbuf.h                                   |   8 +-
 t/t3430-rebase-merges.sh                   |   2 +-
 t/t4202-log.sh                             |   2 +-
 t/t4214-log-graph-octopus.sh               |  85 +++-
 t/t4215-log-skewed-merges.sh               | 267 +++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  30 +-
 7 files changed, 649 insertions(+), 244 deletions(-)
 create mode 100755 t/t4215-log-skewed-merges.sh


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-383%2Fjcoglan%2Fjc%2Fsimplify-graph-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-383/jcoglan/jc/simplify-graph-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/383
-- 
gitgitgadget
