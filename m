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
	by dcvr.yhbt.net (Postfix) with ESMTP id B03CE1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbfJOXsE (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:48:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46780 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbfJOXsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:48:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so25754376wrv.13
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BGT3EbO9ZYLqBk7hrLAJ7Xd8yRe8CXHs2mhfVF3MO0E=;
        b=CPEDPQhnJh7GSiX10z1t4N4cL+d3kyUwkt486WtTAeXsRpI06ZBPDxwnHakkeSupqC
         6ntm9MsPbTNYqS294TZkA9sdv7GxhU70La+aIO/+exq5F99vf12483LQ35V1FNAcn3aY
         lDDtaaAzKvAVZ40EVTB//tLtIc0lu1DoTeEnICDpQ530B5GUu3XU0Jjiv/x1ZPul1rGL
         FSUuERSbcBb2bAj657ABcX55UNUszDO5/aOqQjPh72qddkZUi2J4K1gkZQ4uUxbqC5RP
         oUKPJ3utHpQlnaJUAwT1FApyFMWheQqxs8DLYjSepRNQTLCKgJ3u5X2V+a491h/TLWwi
         FFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BGT3EbO9ZYLqBk7hrLAJ7Xd8yRe8CXHs2mhfVF3MO0E=;
        b=oq9lh/wQ8j0leuk87quaLKxnrH4chVXvamlaLEdvn1xaBfclPQjRZq6qLTU9YPYSNe
         I+Dut97NhM10UO27SR/4ye9CJPog/te2Dml/rsglxpH7uZk4JdI9cubkI4G4F3WuunfX
         /ByFqSqSGpD5KgYA9sX9104Y5ITuW7yOUs8TJxSxKZlYW1t/4p/E51pbHE8fdaQ6Ehsw
         Z2uUtIN+5LNXnNY79IHZvEV8oyePl/qAYITGvoS7zG0JIzFZ0EF0O2I7lUPA71R/iALa
         Txnd7WcK3G8GUqe9o/PGgWRPJLCV8cUIS/9xurfps7uGRM6Gyb0eeSxyiEJ28hKfvWZb
         CefQ==
X-Gm-Message-State: APjAAAVIj2CBLu3iQNZw/qqj2r/0Lwgvzk0gTEfjOqtaCKkfHpR52oIN
        gH6csKhK4W4BC7kUbKfAvKueV0Ko
X-Google-Smtp-Source: APXvYqwqQMh9vqjNw5cqqHTGmMYqwwpA+927z15R45DDUi4dlVAWIEDBlib0uNKhxXSmsKht5jKf8Q==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr44560wrs.205.1571183281078;
        Tue, 15 Oct 2019 16:48:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm29199164wrg.67.2019.10.15.16.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:48:00 -0700 (PDT)
Message-Id: <pull.383.v3.git.1571183279.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
References: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:47:46 +0000
Subject: [PATCH v3 00/13] Improve the readability of log --graph output
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

James Coglan (13):
  graph: automatically track display width of graph lines
  graph: handle line padding in `graph_next_line()`
  graph: reuse `find_new_column_by_commit()`
  graph: reduce duplication in `graph_insert_into_new_columns()`
  graph: remove `mapping_idx` and `graph_update_width()`
  graph: extract logic for moving to GRAPH_PRE_COMMIT state
  graph: example of graph output that can be simplified
  graph: tidy up display of left-skewed merges
  graph: commit and post-merge lines for left-skewed merges
  graph: rename `new_mapping` to `old_mapping`
  graph: smooth appearance of collapsing edges on commit lines
  graph: flatten edges that fuse with their right neighbor
  graph: fix coloring of octopus dashes

 graph.c                                    | 646 ++++++++++++---------
 t/t3430-rebase-merges.sh                   |   2 +-
 t/t4202-log.sh                             |   2 +-
 t/t4214-log-graph-octopus.sh               |  62 +-
 t/t4215-log-skewed-merges.sh               | 257 ++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  30 +-
 6 files changed, 673 insertions(+), 326 deletions(-)
 create mode 100755 t/t4215-log-skewed-merges.sh


base-commit: 108b97dc372828f0e72e56bbb40cae8e1e83ece6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-383%2Fjcoglan%2Fjc%2Fsimplify-graph-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-383/jcoglan/jc/simplify-graph-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/383

Range-diff vs v2:

  1:  c30f5bb43b =  1:  722ab8973a graph: automatically track display width of graph lines
  2:  d962eb2e02 !  2:  056c95d4ed graph: handle line padding in `graph_next_line()`
     @@ -18,6 +18,8 @@
          `graph_next_line()` and we must not pad the `graph_line` if no commit is
          set.
      
     +    Signed-off-by: James Coglan <jcoglan@gmail.com>
     +
       diff --git a/graph.c b/graph.c
       --- a/graph.c
       +++ b/graph.c
  3:  ecfcfbfd5c =  3:  376236ab0b graph: reuse `find_new_column_by_commit()`
  4:  50ce875ed9 =  4:  6a4717bf05 graph: reduce duplication in `graph_insert_into_new_columns()`
  5:  d2e8958eed =  5:  678b53b671 graph: remove `mapping_idx` and `graph_update_width()`
  6:  163600585c =  6:  8ed32b1c74 graph: extract logic for moving to GRAPH_PRE_COMMIT state
  7:  51495be940 !  7:  631ee3cecb graph: example of graph output that can be simplified
     @@ -86,6 +86,8 @@
                  |/
                  * A
      
     +    Signed-off-by: James Coglan <jcoglan@gmail.com>
     +
       diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
       new file mode 100755
       --- /dev/null
  8:  2ab0f9775b =  8:  c34a5eb160 graph: tidy up display of left-skewed merges
  9:  0e37c88c60 =  9:  2f75c697be graph: commit and post-merge lines for left-skewed merges
 10:  9bbf738e6d = 10:  f5c2791436 graph: rename `new_mapping` to `old_mapping`
 11:  67051ec31a = 11:  9b24893de6 graph: smooth appearance of collapsing edges on commit lines
 12:  503c846d2b = 12:  04ba5169bc graph: flatten edges that fuse with their right neighbor
 13:  07ddd509c5 = 13:  cd761b3a32 graph: fix coloring of octopus dashes

-- 
gitgitgadget
