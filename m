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
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F081F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 23:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfJOXlP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 19:41:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39326 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfJOXlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 19:41:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so25810253wrj.6
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RDPyH3WvtIhE6Ay/hZFKfeZwrutVWx+GFm3OJsqv2KE=;
        b=cnhG1nCyqryPWTVb7E2Ra3hxLDmVLQ3xZjMIzIrfGGHdOQnjVBu7oZskZU0WG2HUOe
         zO/5dMHHcjIC7K3jfkDUy0RAKv7guCv5zOX8pYIhDy2cOD3Yq0//WUdjhks1XWx+9kLW
         fBVih/K9euXm8ResJr4qdP+uP64soOL9w8Lpnodonb6bNySRvt5MOiQBTBRvKXFNT2Xo
         zQ1DGk/82CCrUMuBrr8XLtLOAYBGz4HgOP0a809F933y9OcNuAlWyd7dncf49Vy6ifDL
         4IRqJPyRBZ/ocmA+5rVhZ453RhgNE+CW7oazQhimLBI/ipjCbu9HZJGOWHiXx0A0rNNd
         pUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RDPyH3WvtIhE6Ay/hZFKfeZwrutVWx+GFm3OJsqv2KE=;
        b=erzv/DkvVl3ITlMe/EWb/JWV/bTfkbsT5P9f6TgoB85zFC4df3GObrAxk06NVUR4cl
         Ltlr9k+oXjbosH5xbIN1ZVrlzuX9vkajZd+u1v8s0skGs6GH1E6kPz6WPuQqn2IGJmUV
         9qMPmdn56Kb4GxeUor6s4LvIVMZ3NqcCwYePYdnOyV5+hSVrHrHokObMheHbfvK160Kb
         zgAfWc+2RrFAOGu0VwekpyBC+3VTZX0IzaQxf0LTE/MR3PhqSnS2q3gwA9xKv7nmcAgQ
         Hfa7nayEIGScuFxrlMOwNed60s/emirwtpXF1rUmZ0DsVrheJCoSWwSHGqRu/7whIlwC
         Q0wg==
X-Gm-Message-State: APjAAAVOQjBmLz2p449GfD8af8O41nXDXnvompPpu9cXqPToparfPzVH
        hbSJ81cwL6C9kk3VsRvvHgNEM78T
X-Google-Smtp-Source: APXvYqw+/rjVZ5RQy0FORDJ9GNV7xrdlkctiSIstZksNi/gc9kW3etpWOpkn3Yrmz3V1gxWiD9U/rw==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr46366wro.378.1571182866194;
        Tue, 15 Oct 2019 16:41:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm63537117wrc.55.2019.10.15.16.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 16:41:05 -0700 (PDT)
Message-Id: <pull.383.v2.git.1571182864.gitgitgadget@gmail.com>
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   "James Coglan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 23:40:51 +0000
Subject: [PATCH v2 00/13] Improve the readability of log --graph output
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-383%2Fjcoglan%2Fjc%2Fsimplify-graph-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-383/jcoglan/jc/simplify-graph-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/383

Range-diff vs v1:

  1:  4bc0a05961 !  1:  c30f5bb43b graph: automatically track visible width of `strbuf`
     @@ -1,13 +1,13 @@
      Author: James Coglan <jcoglan@gmail.com>
      
     -    graph: automatically track visible width of `strbuf`
     +    graph: automatically track display width of graph lines
      
     -    All the output functions in `graph.c` currently keep track of how many
     -    printable chars they've written to the buffer, before calling
     -    `graph_pad_horizontally()` to pad the line with spaces. Some functions
     -    do this by incrementing a counter whenever they write to the buffer, and
     -    others do it by encoding an assumption about how many chars are written,
     -    as in:
     +    All the output functions called by `graph_next_line()` currently keep
     +    track of how many printable chars they've written to the buffer, before
     +    calling `graph_pad_horizontally()` to pad the line with spaces. Some
     +    functions do this by incrementing a counter whenever they write to the
     +    buffer, and others do it by encoding an assumption about how many chars
     +    are written, as in:
      
              graph_pad_horizontally(graph, sb, graph->num_columns * 2);
      
     @@ -15,22 +15,18 @@
          broken if one forgets to increment the right counter or update the
          calculations used for padding.
      
     -    To make this easier to use, I'm adding a `width` field to `strbuf` that
     -    tracks the number of printing characters added after the line prefix.
     -    It's set to 0 at the start of `graph_next_line()`, and then various
     -    `strbuf` functions update it as follows:
     +    To make this easier to use, I'm introducing a new struct called
     +    `graph_line` that wraps a `strbuf` and keeps count of its display width
     +    implicitly. `graph_next_line()` wraps this around the `struct strbuf *`
     +    it's given and passes a `struct graph_line *` to the output functions,
     +    which use its interface.
      
     -    - `strbuf_write_column()` increments `width` by 1
     -
     -    - `strbuf_setlen()` changes `width` by the amount added to `len` if
     -      `len` is increased, or makes `width` and `len` the same if it's
     -      decreased
     -
     -    - `strbuf_addch()` increments `width` by 1
     -
     -    This is enough to ensure that the functions used by `graph.c` update
     -    `strbuf->width` correctly, and `graph_pad_horizontally()` can then use
     -    this field instead of taking `chars_written` as a parameter.
     +    The `graph_line` interface wraps the `strbuf_addch()`,
     +    `strbuf_addchars()` and `strbuf_addstr()` functions, and adds the
     +    `graph_line_write_column()` function for adding a single character with
     +    color formatting. The `graph_pad_horizontally()` function can then use
     +    the `width` field from the struct rather than taking a character count
     +    as a parameter.
      
          Signed-off-by: James Coglan <jcoglan@gmail.com>
      
     @@ -38,23 +34,50 @@
       --- a/graph.c
       +++ b/graph.c
      @@
     - static void strbuf_write_column(struct strbuf *sb, const struct column *c,
     - 				char col_char)
     - {
     -+	/*
     -+	 * Remember the buffer's width as we're about to add non-printing
     -+	 * content to it, and we want to avoid counting the byte length
     -+	 * of this content towards the buffer's visible width
     -+	 */
     -+	size_t prev_width = sb->width;
     + 	return column_colors[color];
     + }
     + 
     +-static void strbuf_write_column(struct strbuf *sb, const struct column *c,
     +-				char col_char)
     ++struct graph_line {
     ++	struct strbuf *buf;
     ++	size_t width;
     ++};
     ++
     ++static inline void graph_line_addch(struct graph_line *line, int c)
     ++{
     ++	strbuf_addch(line->buf, c);
     ++	line->width++;
     ++}
      +
     ++static inline void graph_line_addchars(struct graph_line *line, int c, size_t n)
     ++{
     ++	strbuf_addchars(line->buf, c, n);
     ++	line->width += n;
     ++}
     ++
     ++static inline void graph_line_addstr(struct graph_line *line, const char *s)
     ++{
     ++	strbuf_addstr(line->buf, s);
     ++	line->width += strlen(s);
     ++}
     ++
     ++static inline void graph_line_addcolor(struct graph_line *line, unsigned short color)
     ++{
     ++	strbuf_addstr(line->buf, column_get_color_code(color));
     ++}
     ++
     ++static void graph_line_write_column(struct graph_line *line, const struct column *c,
     ++				    char col_char)
     + {
       	if (c->color < column_colors_max)
     - 		strbuf_addstr(sb, column_get_color_code(c->color));
     - 	strbuf_addch(sb, col_char);
     +-		strbuf_addstr(sb, column_get_color_code(c->color));
     +-	strbuf_addch(sb, col_char);
     ++		graph_line_addcolor(line, c->color);
     ++	graph_line_addch(line, col_char);
       	if (c->color < column_colors_max)
     - 		strbuf_addstr(sb, column_get_color_code(column_colors_max));
     -+
     -+	sb->width = prev_width + 1;
     +-		strbuf_addstr(sb, column_get_color_code(column_colors_max));
     ++		graph_line_addcolor(line, column_colors_max);
       }
       
       struct git_graph {
     @@ -64,7 +87,7 @@
       
      -static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
      -				   int chars_written)
     -+static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb)
     ++static void graph_pad_horizontally(struct git_graph *graph, struct graph_line *line)
       {
       	/*
       	 * Add additional spaces to the end of the strbuf, so that all
     @@ -74,30 +97,55 @@
       	 */
      -	if (chars_written < graph->width)
      -		strbuf_addchars(sb, ' ', graph->width - chars_written);
     -+	if (sb->width < graph->width)
     -+		strbuf_addchars(sb, ' ', graph->width - sb->width);
     ++	if (line->width < graph->width)
     ++		graph_line_addchars(line, ' ', graph->width - line->width);
       }
       
       static void graph_output_padding_line(struct git_graph *graph,
     +-				      struct strbuf *sb)
     ++				      struct graph_line *line)
     + {
     + 	int i;
     + 
      @@
     - 		strbuf_addch(sb, ' ');
     + 	 * Output a padding row, that leaves all branch lines unchanged
     + 	 */
     + 	for (i = 0; i < graph->num_new_columns; i++) {
     +-		strbuf_write_column(sb, &graph->new_columns[i], '|');
     +-		strbuf_addch(sb, ' ');
     ++		graph_line_write_column(line, &graph->new_columns[i], '|');
     ++		graph_line_addch(line, ' ');
       	}
       
      -	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
     -+	graph_pad_horizontally(graph, sb);
     ++	graph_pad_horizontally(graph, line);
       }
       
       
      @@
     + }
     + 
     + 
     +-static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
     ++static void graph_output_skip_line(struct git_graph *graph, struct graph_line *line)
     + {
     + 	/*
     + 	 * Output an ellipsis to indicate that a portion
       	 * of the graph is missing.
       	 */
     - 	strbuf_addstr(sb, "...");
     +-	strbuf_addstr(sb, "...");
      -	graph_pad_horizontally(graph, sb, 3);
     -+	graph_pad_horizontally(graph, sb);
     ++	graph_line_addstr(line, "...");
     ++	graph_pad_horizontally(graph, line);
       
       	if (graph->num_parents >= 3 &&
       	    graph->commit_index < (graph->num_columns - 1))
      @@
     + }
     + 
     + static void graph_output_pre_commit_line(struct git_graph *graph,
     +-					 struct strbuf *sb)
     ++					 struct graph_line *line)
       {
       	int num_expansion_rows;
       	int i, seen_this;
     @@ -114,34 +162,66 @@
       		struct column *col = &graph->columns[i];
       		if (col->commit == graph->commit) {
       			seen_this = 1;
     - 			strbuf_write_column(sb, col, '|');
     - 			strbuf_addchars(sb, ' ', graph->expansion_row);
     +-			strbuf_write_column(sb, col, '|');
     +-			strbuf_addchars(sb, ' ', graph->expansion_row);
      -			chars_written += 1 + graph->expansion_row;
     ++			graph_line_write_column(line, col, '|');
     ++			graph_line_addchars(line, ' ', graph->expansion_row);
       		} else if (seen_this && (graph->expansion_row == 0)) {
       			/*
       			 * This is the first line of the pre-commit output.
      @@
     - 				strbuf_write_column(sb, col, '\\');
     + 			 */
     + 			if (graph->prev_state == GRAPH_POST_MERGE &&
     + 			    graph->prev_commit_index < i)
     +-				strbuf_write_column(sb, col, '\\');
     ++				graph_line_write_column(line, col, '\\');
       			else
     - 				strbuf_write_column(sb, col, '|');
     +-				strbuf_write_column(sb, col, '|');
      -			chars_written++;
     ++				graph_line_write_column(line, col, '|');
       		} else if (seen_this && (graph->expansion_row > 0)) {
     - 			strbuf_write_column(sb, col, '\\');
     +-			strbuf_write_column(sb, col, '\\');
      -			chars_written++;
     ++			graph_line_write_column(line, col, '\\');
       		} else {
     - 			strbuf_write_column(sb, col, '|');
     +-			strbuf_write_column(sb, col, '|');
      -			chars_written++;
     ++			graph_line_write_column(line, col, '|');
       		}
     - 		strbuf_addch(sb, ' ');
     +-		strbuf_addch(sb, ' ');
      -		chars_written++;
     ++		graph_line_addch(line, ' ');
       	}
       
      -	graph_pad_horizontally(graph, sb, chars_written);
     -+	graph_pad_horizontally(graph, sb);
     ++	graph_pad_horizontally(graph, line);
       
       	/*
       	 * Increment graph->expansion_row,
      @@
     + 		graph_update_state(graph, GRAPH_COMMIT);
     + }
     + 
     +-static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
     ++static void graph_output_commit_char(struct git_graph *graph, struct graph_line *line)
     + {
     + 	/*
     + 	 * For boundary commits, print 'o'
     +@@
     + 	 */
     + 	if (graph->commit->object.flags & BOUNDARY) {
     + 		assert(graph->revs->boundary);
     +-		strbuf_addch(sb, 'o');
     ++		graph_line_addch(line, 'o');
     + 		return;
     + 	}
     + 
     + 	/*
     + 	 * get_revision_mark() handles all other cases without assert()
     + 	 */
     +-	strbuf_addstr(sb, get_revision_mark(graph->revs, graph->commit));
     ++	graph_line_addstr(line, get_revision_mark(graph->revs, graph->commit));
       }
       
       /*
     @@ -151,18 +231,26 @@
        */
      -static int graph_draw_octopus_merge(struct git_graph *graph,
      -				    struct strbuf *sb)
     -+static void graph_draw_octopus_merge(struct git_graph *graph, struct strbuf *sb)
     ++static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line *line)
       {
       	/*
       	 * Here dashless_parents represents the number of parents which don't
      @@
     - 		strbuf_write_column(sb, &graph->new_columns[i+first_col],
     - 				    i == dashful_parents-1 ? '.' : '-');
     + 
     + 	int i;
     + 	for (i = 0; i < dashful_parents; i++) {
     +-		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
     +-		strbuf_write_column(sb, &graph->new_columns[i+first_col],
     +-				    i == dashful_parents-1 ? '.' : '-');
     ++		graph_line_write_column(line, &graph->new_columns[i+first_col], '-');
     ++		graph_line_write_column(line, &graph->new_columns[i+first_col],
     ++					  i == dashful_parents-1 ? '.' : '-');
       	}
      -	return 2 * dashful_parents;
       }
       
     - static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
     +-static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
     ++static void graph_output_commit_line(struct git_graph *graph, struct graph_line *line)
       {
       	int seen_this = 0;
      -	int i, chars_written;
     @@ -179,41 +267,55 @@
       		struct column *col = &graph->columns[i];
       		struct commit *col_commit;
      @@
     + 
       		if (col_commit == graph->commit) {
       			seen_this = 1;
     - 			graph_output_commit_char(graph, sb);
     +-			graph_output_commit_char(graph, sb);
      -			chars_written++;
     ++			graph_output_commit_char(graph, line);
       
       			if (graph->num_parents > 2)
      -				chars_written += graph_draw_octopus_merge(graph,
      -									  sb);
     -+				graph_draw_octopus_merge(graph, sb);
     ++				graph_draw_octopus_merge(graph, line);
       		} else if (seen_this && (graph->num_parents > 2)) {
     - 			strbuf_write_column(sb, col, '\\');
     +-			strbuf_write_column(sb, col, '\\');
      -			chars_written++;
     ++			graph_line_write_column(line, col, '\\');
       		} else if (seen_this && (graph->num_parents == 2)) {
       			/*
       			 * This is a 2-way merge commit.
      @@
     - 				strbuf_write_column(sb, col, '\\');
     + 			 */
     + 			if (graph->prev_state == GRAPH_POST_MERGE &&
     + 			    graph->prev_commit_index < i)
     +-				strbuf_write_column(sb, col, '\\');
     ++				graph_line_write_column(line, col, '\\');
       			else
     - 				strbuf_write_column(sb, col, '|');
     +-				strbuf_write_column(sb, col, '|');
      -			chars_written++;
     ++				graph_line_write_column(line, col, '|');
       		} else {
     - 			strbuf_write_column(sb, col, '|');
     +-			strbuf_write_column(sb, col, '|');
      -			chars_written++;
     ++			graph_line_write_column(line, col, '|');
       		}
     - 		strbuf_addch(sb, ' ');
     +-		strbuf_addch(sb, ' ');
      -		chars_written++;
     ++		graph_line_addch(line, ' ');
       	}
       
      -	graph_pad_horizontally(graph, sb, chars_written);
     -+	graph_pad_horizontally(graph, sb);
     ++	graph_pad_horizontally(graph, line);
       
       	/*
       	 * Update graph->state
      @@
     - static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
     + 	return NULL;
     + }
     + 
     +-static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
     ++static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
       {
       	int seen_this = 0;
      -	int i, j, chars_written;
     @@ -227,40 +329,81 @@
       		struct column *col = &graph->columns[i];
       		struct commit *col_commit;
      @@
     + 			par_column = find_new_column_by_commit(graph, parents->item);
       			assert(par_column);
       
     - 			strbuf_write_column(sb, par_column, '|');
     +-			strbuf_write_column(sb, par_column, '|');
      -			chars_written++;
     ++			graph_line_write_column(line, par_column, '|');
       			for (j = 0; j < graph->num_parents - 1; j++) {
       				parents = next_interesting_parent(graph, parents);
       				assert(parents);
     -@@
     - 				strbuf_write_column(sb, par_column, '\\');
     - 				strbuf_addch(sb, ' ');
     + 				par_column = find_new_column_by_commit(graph, parents->item);
     + 				assert(par_column);
     +-				strbuf_write_column(sb, par_column, '\\');
     +-				strbuf_addch(sb, ' ');
     ++				graph_line_write_column(line, par_column, '\\');
     ++				graph_line_addch(line, ' ');
       			}
      -			chars_written += j * 2;
       		} else if (seen_this) {
     - 			strbuf_write_column(sb, col, '\\');
     - 			strbuf_addch(sb, ' ');
     +-			strbuf_write_column(sb, col, '\\');
     +-			strbuf_addch(sb, ' ');
      -			chars_written += 2;
     ++			graph_line_write_column(line, col, '\\');
     ++			graph_line_addch(line, ' ');
       		} else {
     - 			strbuf_write_column(sb, col, '|');
     - 			strbuf_addch(sb, ' ');
     +-			strbuf_write_column(sb, col, '|');
     +-			strbuf_addch(sb, ' ');
      -			chars_written += 2;
     ++			graph_line_write_column(line, col, '|');
     ++			graph_line_addch(line, ' ');
       		}
       	}
       
      -	graph_pad_horizontally(graph, sb, chars_written);
     -+	graph_pad_horizontally(graph, sb);
     ++	graph_pad_horizontally(graph, line);
       
       	/*
       	 * Update graph->state
      @@
     + 		graph_update_state(graph, GRAPH_COLLAPSING);
     + }
     + 
     +-static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
     ++static void graph_output_collapsing_line(struct git_graph *graph, struct graph_line *line)
     + {
     + 	int i;
     + 	short used_horizontal = 0;
     +@@
     + 	for (i = 0; i < graph->mapping_size; i++) {
     + 		int target = graph->new_mapping[i];
     + 		if (target < 0)
     +-			strbuf_addch(sb, ' ');
     ++			graph_line_addch(line, ' ');
     + 		else if (target * 2 == i)
     +-			strbuf_write_column(sb, &graph->new_columns[target], '|');
     ++			graph_line_write_column(line, &graph->new_columns[target], '|');
     + 		else if (target == horizontal_edge_target &&
     + 			 i != horizontal_edge - 1) {
     + 				/*
     +@@
     + 				if (i != (target * 2)+3)
     + 					graph->new_mapping[i] = -1;
     + 				used_horizontal = 1;
     +-			strbuf_write_column(sb, &graph->new_columns[target], '_');
     ++			graph_line_write_column(line, &graph->new_columns[target], '_');
     + 		} else {
     + 			if (used_horizontal && i < horizontal_edge)
     + 				graph->new_mapping[i] = -1;
     +-			strbuf_write_column(sb, &graph->new_columns[target], '/');
     ++			graph_line_write_column(line, &graph->new_columns[target], '/');
     + 
       		}
       	}
       
      -	graph_pad_horizontally(graph, sb, graph->mapping_size);
     -+	graph_pad_horizontally(graph, sb);
     ++	graph_pad_horizontally(graph, line);
       
       	/*
       	 * Swap mapping and new_mapping
     @@ -268,74 +411,66 @@
       
       int graph_next_line(struct git_graph *graph, struct strbuf *sb)
       {
     -+	sb->width = 0;
     ++	struct graph_line line = { .buf = sb, .width = 0 };
      +
       	switch (graph->state) {
       	case GRAPH_PADDING:
     - 		graph_output_padding_line(graph, sb);
     +-		graph_output_padding_line(graph, sb);
     ++		graph_output_padding_line(graph, &line);
     + 		return 0;
     + 	case GRAPH_SKIP:
     +-		graph_output_skip_line(graph, sb);
     ++		graph_output_skip_line(graph, &line);
     + 		return 0;
     + 	case GRAPH_PRE_COMMIT:
     +-		graph_output_pre_commit_line(graph, sb);
     ++		graph_output_pre_commit_line(graph, &line);
     + 		return 0;
     + 	case GRAPH_COMMIT:
     +-		graph_output_commit_line(graph, sb);
     ++		graph_output_commit_line(graph, &line);
     + 		return 1;
     + 	case GRAPH_POST_MERGE:
     +-		graph_output_post_merge_line(graph, sb);
     ++		graph_output_post_merge_line(graph, &line);
     + 		return 0;
     + 	case GRAPH_COLLAPSING:
     +-		graph_output_collapsing_line(graph, sb);
     ++		graph_output_collapsing_line(graph, &line);
     + 		return 0;
     + 	}
     + 
      @@
       static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
       {
       	int i;
      -	int chars_written = 0;
     ++	struct graph_line line = { .buf = sb, .width = 0 };
       
       	if (graph->state != GRAPH_COMMIT) {
       		graph_next_line(graph, sb);
      @@
     + 	for (i = 0; i < graph->num_columns; i++) {
       		struct column *col = &graph->columns[i];
       
     - 		strbuf_write_column(sb, col, '|');
     +-		strbuf_write_column(sb, col, '|');
      -		chars_written++;
     ++		graph_line_write_column(&line, col, '|');
       
       		if (col->commit == graph->commit && graph->num_parents > 2) {
       			int len = (graph->num_parents - 2) * 2;
     - 			strbuf_addchars(sb, ' ', len);
     +-			strbuf_addchars(sb, ' ', len);
      -			chars_written += len;
     ++			graph_line_addchars(&line, ' ', len);
       		} else {
     - 			strbuf_addch(sb, ' ');
     +-			strbuf_addch(sb, ' ');
      -			chars_written++;
     ++			graph_line_addch(&line, ' ');
       		}
       	}
       
      -	graph_pad_horizontally(graph, sb, chars_written);
     -+	graph_pad_horizontally(graph, sb);
     ++	graph_pad_horizontally(graph, &line);
       
       	/*
       	 * Update graph->prev_state since we have output a padding line
     -
     - diff --git a/strbuf.h b/strbuf.h
     - --- a/strbuf.h
     - +++ b/strbuf.h
     -@@
     - struct strbuf {
     - 	size_t alloc;
     - 	size_t len;
     -+	size_t width;
     - 	char *buf;
     - };
     - 
     - extern char strbuf_slopbuf[];
     --#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
     -+#define STRBUF_INIT  { .alloc = 0, .len = 0, .width = 0, .buf = strbuf_slopbuf }
     - 
     - /*
     -  * Predeclare this here, since cache.h includes this file before it defines the
     -@@
     - {
     - 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
     - 		die("BUG: strbuf_setlen() beyond buffer");
     -+	if (len > sb->len)
     -+		sb->width += len - sb->len;
     -+	else
     -+		sb->width = len;
     - 	sb->len = len;
     - 	if (sb->buf != strbuf_slopbuf)
     - 		sb->buf[len] = '\0';
     -@@
     - 		strbuf_grow(sb, 1);
     - 	sb->buf[sb->len++] = c;
     - 	sb->buf[sb->len] = '\0';
     -+	sb->width++;
     - }
     - 
     - /**
  -:  ---------- >  2:  d962eb2e02 graph: handle line padding in `graph_next_line()`
  2:  a130574191 !  3:  ecfcfbfd5c graph: reuse `find_new_column_by_commit()`
     @@ -71,7 +71,7 @@
      -	return NULL;
      -}
      -
     - static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
     + static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
       {
       	int seen_this = 0;
      @@
     @@ -88,17 +88,17 @@
      +			par_column = graph_find_new_column_by_commit(graph, parents->item);
      +			assert(par_column >= 0);
       
     --			strbuf_write_column(sb, par_column, '|');
     -+			strbuf_write_column(sb, &graph->new_columns[par_column], '|');
     +-			graph_line_write_column(line, par_column, '|');
     ++			graph_line_write_column(line, &graph->new_columns[par_column], '|');
       			for (j = 0; j < graph->num_parents - 1; j++) {
       				parents = next_interesting_parent(graph, parents);
       				assert(parents);
      -				par_column = find_new_column_by_commit(graph, parents->item);
      -				assert(par_column);
     --				strbuf_write_column(sb, par_column, '\\');
     +-				graph_line_write_column(line, par_column, '\\');
      +				par_column = graph_find_new_column_by_commit(graph, parents->item);
      +				assert(par_column >= 0);
     -+				strbuf_write_column(sb, &graph->new_columns[par_column], '\\');
     - 				strbuf_addch(sb, ' ');
     ++				graph_line_write_column(line, &graph->new_columns[par_column], '\\');
     + 				graph_line_addch(line, ' ');
       			}
       		} else if (seen_this) {
  3:  21a36efd7b =  4:  50ce875ed9 graph: reduce duplication in `graph_insert_into_new_columns()`
  4:  674b992371 =  5:  d2e8958eed graph: remove `mapping_idx` and `graph_update_width()`
  5:  d5d60ca9a2 !  6:  163600585c graph: extract logic for moving to GRAPH_PRE_COMMIT state
     @@ -35,8 +35,8 @@
       	else
       		graph->state = GRAPH_COMMIT;
      @@
     - 	strbuf_addstr(sb, "...");
     - 	graph_pad_horizontally(graph, sb);
     + 	 */
     + 	graph_line_addstr(line, "...");
       
      -	if (graph->num_parents >= 3 &&
      -	    graph->commit_index < (graph->num_columns - 1))
  -:  ---------- >  7:  51495be940 graph: example of graph output that can be simplified
  6:  12c0916cb1 !  8:  2ab0f9775b graph: tidy up display of left-skewed merges
     @@ -4,7 +4,7 @@
      
          Currently, when we display a merge whose first parent is already present
          in a column to the left of the merge commit, we display the first parent
     -    as a veritcal pipe `|` in the GRAPH_POST_MERGE line and then immediately
     +    as a vertical pipe `|` in the GRAPH_POST_MERGE line and then immediately
          enter the GRAPH_COLLAPSING state. The first-parent line tracks to the
          left and all the other parent lines follow it; this creates a "kink" in
          those lines:
     @@ -187,7 +187,7 @@
       void graph_update(struct git_graph *graph, struct commit *commit)
      @@
       static void graph_output_pre_commit_line(struct git_graph *graph,
     - 					 struct strbuf *sb)
     + 					 struct graph_line *line)
       {
      -	int num_expansion_rows;
       	int i, seen_this;
     @@ -246,7 +246,7 @@
       
      +const char merge_chars[] = {'/', '|', '\\'};
      +
     - static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
     + static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
       {
       	int seen_this = 0;
      -	int i, j;
     @@ -272,7 +272,7 @@
      -			par_column = graph_find_new_column_by_commit(graph, parents->item);
      -			assert(par_column >= 0);
      -
     --			strbuf_write_column(sb, &graph->new_columns[par_column], '|');
     +-			graph_line_write_column(line, &graph->new_columns[par_column], '|');
      -			for (j = 0; j < graph->num_parents - 1; j++) {
      -				parents = next_interesting_parent(graph, parents);
      -				assert(parents);
     @@ -280,37 +280,37 @@
      +			for (; parents; parents = next_interesting_parent(graph, parents)) {
       				par_column = graph_find_new_column_by_commit(graph, parents->item);
       				assert(par_column >= 0);
     --				strbuf_write_column(sb, &graph->new_columns[par_column], '\\');
     --				strbuf_addch(sb, ' ');
     +-				graph_line_write_column(line, &graph->new_columns[par_column], '\\');
     +-				graph_line_addch(line, ' ');
      +
      +				c = merge_chars[idx];
     -+				strbuf_write_column(sb, &graph->new_columns[par_column], c);
     ++				graph_line_write_column(line, &graph->new_columns[par_column], c);
      +				if (idx == 2)
     -+					strbuf_addch(sb, ' ');
     ++					graph_line_addch(line, ' ');
      +				else
      +					idx++;
       			}
       		} else if (seen_this) {
     - 			strbuf_write_column(sb, col, '\\');
     - 			strbuf_addch(sb, ' ');
     + 			graph_line_write_column(line, col, '\\');
     + 			graph_line_addch(line, ' ');
       		} else {
     - 			strbuf_write_column(sb, col, '|');
     --			strbuf_addch(sb, ' ');
     + 			graph_line_write_column(line, col, '|');
     +-			graph_line_addch(line, ' ');
      +			if (graph->merge_layout != 0 || i != graph->commit_index - 1)
     -+				strbuf_addch(sb, seen_parent ? '_' : ' ');
     ++				graph_line_addch(line, seen_parent ? '_' : ' ');
       		}
      +
      +		if (col_commit == first_parent->item)
      +			seen_parent = 1;
       	}
       
     - 	graph_pad_horizontally(graph, sb);
     + 	/*
      
       diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
       --- a/t/t4214-log-graph-octopus.sh
       +++ b/t/t4214-log-graph-octopus.sh
      @@
     - test_expect_success 'set up merge history' '
     + test_expect_success 'log --graph with tricky octopus merge, no color' '
       	cat >expect.uncolored <<-\EOF &&
       	* left
      -	| *---.   octopus-merge
     @@ -322,7 +322,7 @@
       	| | * | 3
       	| | |/
      @@
     - 	EOF
     + 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
       	cat >expect.colors <<-\EOF &&
       	* left
      -	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
     @@ -333,51 +333,88 @@
       	<RED>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
       	<RED>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
       	<RED>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
     +@@
     + 	cat >expect.uncolored <<-\EOF &&
     + 	* left
     + 	| * after-merge
     +-	| *---.   octopus-merge
     +-	| |\ \ \
     +-	|/ / / /
     ++	| *-.   octopus-merge
     ++	|/|\ \
     + 	| | | * 4
     + 	| | * | 3
     + 	| | |/
     +@@
     + 	cat >expect.colors <<-\EOF &&
     + 	* left
     + 	<RED>|<RESET> * after-merge
     +-	<RED>|<RESET> *<MAGENTA>-<RESET><MAGENTA>-<RESET><CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
     +-	<RED>|<RESET> <RED>|<RESET><BLUE>\<RESET> <MAGENTA>\<RESET> <CYAN>\<RESET>
     +-	<RED>|<RESET><RED>/<RESET> <BLUE>/<RESET> <MAGENTA>/<RESET> <CYAN>/<RESET>
     ++	<RED>|<RESET> *<CYAN>-<RESET><CYAN>.<RESET>   octopus-merge
     ++	<RED>|<RESET><RED>/<RESET><BLUE>|<RESET><MAGENTA>\<RESET> <CYAN>\<RESET>
     + 	<RED>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> * 4
     + 	<RED>|<RESET> <BLUE>|<RESET> * <CYAN>|<RESET> 3
     + 	<RED>|<RESET> <BLUE>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
      
       diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
     - new file mode 100755
     - --- /dev/null
     + --- a/t/t4215-log-skewed-merges.sh
       +++ b/t/t4215-log-skewed-merges.sh
      @@
     -+#!/bin/sh
     -+
     -+test_description='git log --graph of skewed merges'
     -+
     -+. ./test-lib.sh
     -+
     -+test_expect_success 'setup left-skewed merge' '
     -+	git checkout --orphan _a && test_commit A &&
     -+	git branch _b &&
     -+	git branch _c &&
     -+	git branch _d &&
     -+	git branch _e &&
     -+	git checkout _b && test_commit B &&
     -+	git checkout _c && test_commit C &&
     -+	git checkout _d && test_commit D &&
     -+	git checkout _e && git merge --no-ff _d -m E &&
     -+	git checkout _a && git merge --no-ff _b _c _e -m F
     -+'
     + 	| *   G
     + 	| |\
     + 	| | * F
     +-	| | |
     +-	| |  \
     +-	| *-. \   E
     +-	| |\ \ \
     +-	|/ / / /
     +-	| | | /
     ++	| * \   E
     ++	|/|\ \
     + 	| | |/
     + 	| | * D
     + 	| * | C
     +@@
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'log --graph with left-skewed merge' '
     ++	cat >expect <<-\EOF &&
     ++	*-----.   0_H
     ++	|\ \ \ \
     ++	| | | | * 0_G
     ++	| |_|_|/|
     ++	|/| | | |
     ++	| | | * \   0_F
     ++	| |_|/|\ \
     ++	|/| | | |/
     ++	| | | | * 0_E
     ++	| |_|_|/
     ++	|/| | |
     ++	| | * | 0_D
     ++	| | |/
     ++	| | * 0_C
     ++	| |/
     ++	|/|
     ++	| * 0_B
     ++	|/
     ++	* 0_A
     ++	EOF
      +
     -+cat > expect <<\EOF
     -+*---.   F
     -+|\ \ \
     -+| | | * E
     -+| |_|/|
     -+|/| | |
     -+| | | * D
     -+| |_|/
     -+|/| |
     -+| | * C
     -+| |/
     -+|/|
     -+| * B
     -+|/
     -+* A
     -+EOF
     ++	git checkout --orphan 0_p && test_commit 0_A &&
     ++	git checkout -b 0_q 0_p && test_commit 0_B &&
     ++	git checkout -b 0_r 0_p &&
     ++	test_commit 0_C &&
     ++	test_commit 0_D &&
     ++	git checkout -b 0_s 0_p && test_commit 0_E &&
     ++	git checkout -b 0_t 0_p && git merge --no-ff 0_r^ 0_s -m 0_F &&
     ++	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
     ++	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
      +
     -+test_expect_success 'log --graph with left-skewed merge' '
     -+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
     ++	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_done
     + test_done
  7:  6c173663aa !  9:  0e37c88c60 graph: commit and post-merge lines for left-skewed merges
     @@ -183,10 +183,10 @@
      @@
       
       			if (graph->num_parents > 2)
     - 				graph_draw_octopus_merge(graph, sb);
     + 				graph_draw_octopus_merge(graph, line);
      -		} else if (seen_this && (graph->num_parents > 2)) {
      +		} else if (seen_this && (graph->edges_added > 1)) {
     - 			strbuf_write_column(sb, col, '\\');
     + 			graph_line_write_column(line, col, '\\');
      -		} else if (seen_this && (graph->num_parents == 2)) {
      +		} else if (seen_this && (graph->edges_added == 1)) {
       			/*
     @@ -204,33 +204,67 @@
       			if (graph->prev_state == GRAPH_POST_MERGE &&
      +			    graph->prev_edges_added > 0 &&
       			    graph->prev_commit_index < i)
     - 				strbuf_write_column(sb, col, '\\');
     + 				graph_line_write_column(line, col, '\\');
       			else
      @@
       				else
       					idx++;
       			}
      +			if (graph->edges_added == 0)
     -+				strbuf_addch(sb, ' ');
     ++				graph_line_addch(line, ' ');
      +
       		} else if (seen_this) {
     --			strbuf_write_column(sb, col, '\\');
     +-			graph_line_write_column(line, col, '\\');
      +			if (graph->edges_added > 0)
     -+				strbuf_write_column(sb, col, '\\');
     ++				graph_line_write_column(line, col, '\\');
      +			else
     -+				strbuf_write_column(sb, col, '|');
     - 			strbuf_addch(sb, ' ');
     ++				graph_line_write_column(line, col, '|');
     + 			graph_line_addch(line, ' ');
       		} else {
     - 			strbuf_write_column(sb, col, '|');
     + 			graph_line_write_column(line, col, '|');
      
       diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
       --- a/t/t4215-log-skewed-merges.sh
       +++ b/t/t4215-log-skewed-merges.sh
     +@@
     + 	| *   G
     + 	| |\
     + 	| | * F
     +-	| * \   E
     ++	| * |   E
     + 	|/|\ \
     + 	| | |/
     + 	| | * D
     +@@
     + 	| | | | * 0_G
     + 	| |_|_|/|
     + 	|/| | | |
     +-	| | | * \   0_F
     ++	| | | * |   0_F
     + 	| |_|/|\ \
     + 	|/| | | |/
     + 	| | | | * 0_E
      @@
       	test_cmp expect actual
       '
       
     -+test_expect_success 'setup nested left-skewed merge' '
     ++test_expect_success 'log --graph with nested left-skewed merge' '
     ++	cat >expect <<-\EOF &&
     ++	*   1_H
     ++	|\
     ++	| *   1_G
     ++	| |\
     ++	| | * 1_F
     ++	| * | 1_E
     ++	|/| |
     ++	| * | 1_D
     ++	* | | 1_C
     ++	|/ /
     ++	* | 1_B
     ++	|/
     ++	* 1_A
     ++	EOF
     ++
      +	git checkout --orphan 1_p &&
      +	test_commit 1_A &&
      +	test_commit 1_B &&
     @@ -239,31 +273,34 @@
      +	git checkout 1_p && git merge --no-ff 1_q -m 1_E &&
      +	git checkout -b 1_r @~3 && test_commit 1_F &&
      +	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
     -+	git checkout @^^ && git merge --no-ff 1_p -m 1_H
     -+'
     -+
     -+cat > expect <<\EOF
     -+*   1_H
     -+|\
     -+| *   1_G
     -+| |\
     -+| | * 1_F
     -+| * | 1_E
     -+|/| |
     -+| * | 1_D
     -+* | | 1_C
     -+|/ /
     -+* | 1_B
     -+|/
     -+* 1_A
     -+EOF
     ++	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
      +
     -+test_expect_success 'log --graph with nested left-skewed merge' '
     -+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
     ++	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'setup nested left-skewed merge following normal merge' '
     ++test_expect_success 'log --graph with nested left-skewed merge following normal merge' '
     ++	cat >expect <<-\EOF &&
     ++	*   2_K
     ++	|\
     ++	| *   2_J
     ++	| |\
     ++	| | *   2_H
     ++	| | |\
     ++	| | * | 2_G
     ++	| |/| |
     ++	| | * | 2_F
     ++	| * | | 2_E
     ++	| |/ /
     ++	| * | 2_D
     ++	* | | 2_C
     ++	| |/
     ++	|/|
     ++	* | 2_B
     ++	|/
     ++	* 2_A
     ++	EOF
     ++
      +	git checkout --orphan 2_p &&
      +	test_commit 2_A &&
      +	test_commit 2_B &&
     @@ -276,36 +313,32 @@
      +	git merge --no-ff 2_r -m 2_G &&
      +	git merge --no-ff 2_p^ -m 2_H &&
      +	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
     -+	git checkout 2_p && git merge --no-ff 2_s -m 2_K
     -+'
     -+
     -+cat > expect <<\EOF
     -+*   2_K
     -+|\
     -+| *   2_J
     -+| |\
     -+| | *   2_H
     -+| | |\
     -+| | * | 2_G
     -+| |/| |
     -+| | * | 2_F
     -+| * | | 2_E
     -+| |/ /
     -+| * | 2_D
     -+* | | 2_C
     -+| |/
     -+|/|
     -+* | 2_B
     -+|/
     -+* 2_A
     -+EOF
     ++	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
      +
     -+test_expect_success 'log --graph with nested left-skewed merge following normal merge' '
     -+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
     ++	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'setup nested right-skewed merge following left-skewed merge' '
     ++test_expect_success 'log --graph with nested right-skewed merge following left-skewed merge' '
     ++	cat >expect <<-\EOF &&
     ++	*   3_J
     ++	|\
     ++	| *   3_H
     ++	| |\
     ++	| | * 3_G
     ++	| * | 3_F
     ++	|/| |
     ++	| * |   3_E
     ++	| |\ \
     ++	| | |/
     ++	| | * 3_D
     ++	| * | 3_C
     ++	| |/
     ++	| * 3_B
     ++	|/
     ++	* 3_A
     ++	EOF
     ++
      +	git checkout --orphan 3_p &&
      +	test_commit 3_A &&
      +	git checkout -b 3_q &&
     @@ -317,34 +350,32 @@
      +	git checkout 3_p && git merge --no-ff 3_q -m 3_F &&
      +	git checkout 3_r && test_commit 3_G &&
      +	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
     -+	git checkout @^^ && git merge --no-ff 3_p -m 3_J
     -+'
     -+
     -+cat > expect <<\EOF
     -+*   3_J
     -+|\
     -+| *   3_H
     -+| |\
     -+| | * 3_G
     -+| * | 3_F
     -+|/| |
     -+| * |   3_E
     -+| |\ \
     -+| | |/
     -+| | * 3_D
     -+| * | 3_C
     -+| |/
     -+| * 3_B
     -+|/
     -+* 3_A
     -+EOF
     ++	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
      +
     -+test_expect_success 'log --graph with nested right-skewed merge following left-skewed merge' '
     -+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
     ++	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'setup right-skewed merge following a left-skewed one' '
     ++test_expect_success 'log --graph with right-skewed merge following a left-skewed one' '
     ++	cat >expect <<-\EOF &&
     ++	*   4_H
     ++	|\
     ++	| *   4_G
     ++	| |\
     ++	| * | 4_F
     ++	|/| |
     ++	| * |   4_E
     ++	| |\ \
     ++	| | * | 4_D
     ++	| |/ /
     ++	|/| |
     ++	| | * 4_C
     ++	| |/
     ++	| * 4_B
     ++	|/
     ++	* 4_A
     ++	EOF
     ++
      +	git checkout --orphan 4_p &&
      +	test_commit 4_A &&
      +	test_commit 4_B &&
     @@ -354,30 +385,9 @@
      +	git checkout -b 4_s 4_p^^ &&
      +	git merge --no-ff 4_r -m 4_F &&
      +	git merge --no-ff 4_p -m 4_G &&
     -+	git checkout @^^ && git merge --no-ff 4_s -m 4_H
     -+'
     ++	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
      +
     -+cat > expect <<\EOF
     -+*   4_H
     -+|\
     -+| *   4_G
     -+| |\
     -+| * | 4_F
     -+|/| |
     -+| * |   4_E
     -+| |\ \
     -+| | * | 4_D
     -+| |/ /
     -+|/| |
     -+| | * 4_C
     -+| |/
     -+| * 4_B
     -+|/
     -+* 4_A
     -+EOF
     -+
     -+test_expect_success 'log --graph with right-skewed merge following a left-skewed one' '
     -+	git log --graph --date-order --pretty=tformat:%s | sed "s/ *$//" > actual &&
     ++	git log --graph --date-order --pretty=tformat:%s | sed "s/ *$//" >actual &&
      +	test_cmp expect actual
      +'
      +
  8:  23f13bbefa ! 10:  9bbf738e6d graph: rename `new_mapping` to `old_mapping`
     @@ -146,7 +146,7 @@
      -		int target = graph->new_mapping[i];
      +		int target = graph->mapping[i];
       		if (target < 0)
     - 			strbuf_addch(sb, ' ');
     + 			graph_line_addch(line, ' ');
       		else if (target * 2 == i)
      @@
       				 * won't continue into the next line.
     @@ -155,17 +155,15 @@
      -					graph->new_mapping[i] = -1;
      +					graph->mapping[i] = -1;
       				used_horizontal = 1;
     - 			strbuf_write_column(sb, &graph->new_columns[target], '_');
     + 			graph_line_write_column(line, &graph->new_columns[target], '_');
       		} else {
       			if (used_horizontal && i < horizontal_edge)
      -				graph->new_mapping[i] = -1;
      +				graph->mapping[i] = -1;
     - 			strbuf_write_column(sb, &graph->new_columns[target], '/');
     + 			graph_line_write_column(line, &graph->new_columns[target], '/');
       
       		}
     -@@
     - 
     - 	graph_pad_horizontally(graph, sb);
     + 	}
       
      -	/*
      -	 * Swap mapping and new_mapping
  9:  f9ced9090d ! 11:  67051ec31a graph: smooth appearance of collapsing edges on commit lines
     @@ -77,15 +77,15 @@
       	int *old_mapping;
       	/*
      @@
     - 				strbuf_write_column(sb, col, '\\');
     + 				graph_line_write_column(line, col, '\\');
       			else
     - 				strbuf_write_column(sb, col, '|');
     + 				graph_line_write_column(line, col, '|');
      +		} else if (graph->prev_state == GRAPH_COLLAPSING &&
      +			   graph->old_mapping[2 * i + 1] == i &&
      +			   graph->mapping[2 * i] < i) {
     -+			strbuf_write_column(sb, col, '/');
     ++			graph_line_write_column(line, col, '/');
       		} else {
     - 			strbuf_write_column(sb, col, '|');
     + 			graph_line_write_column(line, col, '|');
       		}
      @@
       		}
     @@ -177,19 +177,76 @@
       	<BLUE>|<RESET><BLUE>/<RESET>
       	* initial
       	EOF
     +@@
     + 	| | | * 4
     + 	| | * | 3
     + 	| | |/
     +-	| * | 2
     ++	| * / 2
     + 	| |/
     +-	* | 1
     ++	* / 1
     + 	|/
     + 	* initial
     + 	EOF
     +@@
     + 	<GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 4
     + 	<GREEN>|<RESET> <YELLOW>|<RESET> * <MAGENTA>|<RESET> 3
     + 	<GREEN>|<RESET> <YELLOW>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
     +-	<GREEN>|<RESET> * <MAGENTA>|<RESET> 2
     ++	<GREEN>|<RESET> * <MAGENTA>/<RESET> 2
     + 	<GREEN>|<RESET> <MAGENTA>|<RESET><MAGENTA>/<RESET>
     +-	* <MAGENTA>|<RESET> 1
     ++	* <MAGENTA>/<RESET> 1
     + 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
     + 	* initial
     + 	EOF
     +@@
     + 	| | | * 4
     + 	| | * | 3
     + 	| | |/
     +-	| * | 2
     ++	| * / 2
     + 	| |/
     +-	* | 1
     ++	* / 1
     + 	|/
     + 	* initial
     + 	EOF
     +@@
     + 	<RED>|<RESET> <BLUE>|<RESET> <MAGENTA>|<RESET> * 4
     + 	<RED>|<RESET> <BLUE>|<RESET> * <CYAN>|<RESET> 3
     + 	<RED>|<RESET> <BLUE>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
     +-	<RED>|<RESET> * <CYAN>|<RESET> 2
     ++	<RED>|<RESET> * <CYAN>/<RESET> 2
     + 	<RED>|<RESET> <CYAN>|<RESET><CYAN>/<RESET>
     +-	* <CYAN>|<RESET> 1
     ++	* <CYAN>/<RESET> 1
     + 	<CYAN>|<RESET><CYAN>/<RESET>
     + 	* initial
     + 	EOF
      
       diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
       --- a/t/t4215-log-skewed-merges.sh
       +++ b/t/t4215-log-skewed-merges.sh
      @@
     - | * | 1_D
     - * | | 1_C
     - |/ /
     --* | 1_B
     -+* / 1_B
     - |/
     - * 1_A
     - EOF
     + 	| | * D
     + 	| * | C
     + 	| |/
     +-	* | B
     ++	* / B
     + 	|/
     + 	* A
     + 	EOF
     +@@
     + 	| * | 1_D
     + 	* | | 1_C
     + 	|/ /
     +-	* | 1_B
     ++	* / 1_B
     + 	|/
     + 	* 1_A
     + 	EOF
      
       diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
       --- a/t/t6016-rev-list-graph-simplify-history.sh
 10:  50756edcf7 ! 12:  503c846d2b graph: flatten edges that join to their right neighbor
     @@ -1,6 +1,6 @@
      Author: James Coglan <jcoglan@gmail.com>
      
     -    graph: flatten edges that join to their right neighbor
     +    graph: flatten edges that fuse with their right neighbor
      
          When a merge commit is printed and its final parent is the same commit
          that occupies the column to the right of the merge, this results in a
     @@ -109,7 +109,7 @@
       
       	/*
      @@
     - static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
     + static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
       {
       	int seen_this = 0;
      -	int i;
     @@ -127,41 +127,86 @@
       				assert(par_column >= 0);
       
       				c = merge_chars[idx];
     - 				strbuf_write_column(sb, &graph->new_columns[par_column], c);
     + 				graph_line_write_column(line, &graph->new_columns[par_column], c);
      -				if (idx == 2)
     --					strbuf_addch(sb, ' ');
     +-					graph_line_addch(line, ' ');
      -				else
      +				if (idx == 2) {
      +					if (graph->edges_added > 0 || j < graph->num_parents - 1)
     -+						strbuf_addch(sb, ' ');
     ++						graph_line_addch(line, ' ');
      +				} else {
       					idx++;
      +				}
      +				parents = next_interesting_parent(graph, parents);
       			}
       			if (graph->edges_added == 0)
     - 				strbuf_addch(sb, ' ');
     + 				graph_line_addch(line, ' ');
      
       diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
       --- a/t/t4215-log-skewed-merges.sh
       +++ b/t/t4215-log-skewed-merges.sh
      @@
     - | | * 3_G
     - | * | 3_F
     - |/| |
     --| * |   3_E
     --| |\ \
     --| | |/
     -+| * | 3_E
     -+| |\|
     - | | * 3_D
     - | * | 3_C
     - | |/
     + 	| *   G
     + 	| |\
     + 	| | * F
     +-	| * |   E
     +-	|/|\ \
     +-	| | |/
     ++	| * | E
     ++	|/|\|
     + 	| | * D
     + 	| * | C
     + 	| |/
     +@@
     + 	| | | | * 0_G
     + 	| |_|_|/|
     + 	|/| | | |
     +-	| | | * |   0_F
     +-	| |_|/|\ \
     +-	|/| | | |/
     ++	| | | * | 0_F
     ++	| |_|/|\|
     ++	|/| | | |
     + 	| | | | * 0_E
     + 	| |_|_|/
     + 	|/| | |
     +@@
     + 	| | * 3_G
     + 	| * | 3_F
     + 	|/| |
     +-	| * |   3_E
     +-	| |\ \
     +-	| | |/
     ++	| * | 3_E
     ++	| |\|
     + 	| | * 3_D
     + 	| * | 3_C
     + 	| |/
      @@
       	test_cmp expect actual
       '
       
     -+test_expect_success 'setup octopus merge with column joining its penultimate parent' '
     ++test_expect_success 'log --graph with octopus merge with column joining its penultimate parent' '
     ++	cat >expect <<-\EOF &&
     ++	*   5_H
     ++	|\
     ++	| *-.   5_G
     ++	| |\ \
     ++	| | | * 5_F
     ++	| | * |   5_E
     ++	| |/|\ \
     ++	| |_|/ /
     ++	|/| | /
     ++	| | |/
     ++	* | | 5_D
     ++	| | * 5_C
     ++	| |/
     ++	|/|
     ++	| * 5_B
     ++	|/
     ++	* 5_A
     ++	EOF
     ++
      +	git checkout --orphan 5_p &&
      +	test_commit 5_A &&
      +	git branch 5_q &&
     @@ -175,64 +220,9 @@
      +	git checkout -b 5_s 5_p^ &&
      +	git merge --no-ff 5_p 5_q -m 5_G &&
      +	git checkout 5_r &&
     -+	git merge --no-ff 5_s -m 5_H
     -+'
     -+
     -+cat > expect <<\EOF
     -+*   5_H
     -+|\
     -+| *-.   5_G
     -+| |\ \
     -+| | | * 5_F
     -+| | * |   5_E
     -+| |/|\ \
     -+| |_|/ /
     -+|/| | /
     -+| | |/
     -+* | | 5_D
     -+| | * 5_C
     -+| |/
     -+|/|
     -+| * 5_B
     -+|/
     -+* 5_A
     -+EOF
     -+
     -+test_expect_success 'log --graph with octopus merge with column joining its penultimate parent' '
     -+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'setup merge fusing with its left and right neighbors' '
     -+	git checkout --orphan 6_p &&
     -+	test_commit 6_A &&
     -+	test_commit 6_B &&
     -+	git checkout -b 6_q @^ && test_commit 6_C &&
     -+	git checkout -b 6_r @^ && test_commit 6_D &&
     -+	git checkout 6_p && git merge --no-ff 6_q 6_r -m 6_E &&
     -+	git checkout 6_r && test_commit 6_F &&
     -+	git checkout 6_p && git merge --no-ff 6_r -m 6_G &&
     -+	git checkout @^^ && git merge --no-ff 6_p -m 6_H
     -+'
     -+
     -+cat > expect <<\EOF
     -+*   6_H
     -+|\
     -+| *   6_G
     -+| |\
     -+| | * 6_F
     -+| * | 6_E
     -+|/|\|
     -+| | * 6_D
     -+| * | 6_C
     -+| |/
     -+* / 6_B
     -+|/
     -+* 6_A
     -+EOF
     ++	git merge --no-ff 5_s -m 5_H &&
      +
     -+test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
     -+	git log --graph --pretty=tformat:%s | sed "s/ *$//" > actual &&
     ++	git log --graph --pretty=tformat:%s | sed "s/ *$//" >actual &&
      +	test_cmp expect actual
      +'
      +
 11:  ea0df1d94a ! 13:  07ddd509c5 graph: fix coloring of octopus dashes
     @@ -81,7 +81,7 @@
       
       static int graph_needs_pre_commit_line(struct git_graph *graph)
      @@
     - static void graph_draw_octopus_merge(struct git_graph *graph, struct strbuf *sb)
     + static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line *line)
       {
       	/*
      -	 * Here dashless_parents represents the number of parents which don't
     @@ -142,103 +142,69 @@
       
      -	int i;
      -	for (i = 0; i < dashful_parents; i++) {
     --		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
     --		strbuf_write_column(sb, &graph->new_columns[i+first_col],
     --				    i == dashful_parents-1 ? '.' : '-');
     +-		graph_line_write_column(line, &graph->new_columns[i+first_col], '-');
     +-		graph_line_write_column(line, &graph->new_columns[i+first_col],
     +-					  i == dashful_parents-1 ? '.' : '-');
      +	int dashed_parents = graph_num_dashed_parents(graph);
      +
      +	for (i = 0; i < dashed_parents; i++) {
      +		j = graph->mapping[(graph->commit_index + i + 2) * 2];
      +		col = &graph->new_columns[j];
      +
     -+		strbuf_write_column(sb, col, '-');
     -+		strbuf_write_column(sb, col, (i == dashed_parents - 1) ? '.' : '-');
     ++		graph_line_write_column(line, col, '-');
     ++		graph_line_write_column(line, col, (i == dashed_parents - 1) ? '.' : '-');
       	}
      +
      +	return;
       }
       
     - static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
     + static void graph_output_commit_line(struct git_graph *graph, struct graph_line *line)
      
       diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
       --- a/t/t4214-log-graph-octopus.sh
       +++ b/t/t4214-log-graph-octopus.sh
      @@
     - 	test_tick &&
     - 	git merge -m octopus-merge 1 2 3 4 &&
     - 	git checkout 1 -b L &&
     --	test_commit left
     -+	test_commit left &&
     -+	git checkout 4 -b R &&
     -+	test_commit right
     + 	test_cmp expect.uncolored actual
     + '
     + 
     +-test_expect_failure 'log --graph with normal octopus and child merge with colors' '
     ++test_expect_success 'log --graph with normal octopus and child merge with colors' '
     + 	cat >expect.colors <<-\EOF &&
     + 	* after-merge
     + 	*<BLUE>-<RESET><BLUE>-<RESET><MAGENTA>-<RESET><MAGENTA>.<RESET>   octopus-merge
     +@@
     + 	test_cmp expect.uncolored actual
       '
       
     - test_expect_success 'log --graph with tricky octopus merge with colors' '
     +-test_expect_failure 'log --graph with tricky octopus merge and its child with colors' '
     ++test_expect_success 'log --graph with tricky octopus merge and its child with colors' '
       	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
     --	git log --color=always --graph --date-order --pretty=tformat:%s --all >actual.colors.raw &&
     -+	git log --color=always --graph --date-order --pretty=tformat:%s L merge >actual.colors.raw &&
     - 	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
     - 	test_cmp expect.colors actual.colors
     + 	cat >expect.colors <<-\EOF &&
     + 	* left
     +@@
     + 	test_cmp expect.uncolored actual
       '
       
     - test_expect_success 'log --graph with tricky octopus merge, no color' '
     --	git log --color=never --graph --date-order --pretty=tformat:%s --all >actual.raw &&
     -+	git log --color=never --graph --date-order --pretty=tformat:%s L merge >actual.raw &&
     - 	sed "s/ *\$//" actual.raw >actual &&
     +-test_expect_failure 'log --graph with crossover in octopus merge with colors' '
     ++test_expect_success 'log --graph with crossover in octopus merge with colors' '
     + 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
     + 	cat >expect.colors <<-\EOF &&
     + 	* after-4
     +@@
       	test_cmp expect.uncolored actual
       '
       
     --# Repeat the previous two tests with "normal" octopus merge (i.e.,
     -+# Repeat the previous two tests with an octopus merge whose final parent skews left
     -+
     -+test_expect_success 'log --graph with left-skewed final parent, no color' '
     -+	cat >expect.uncolored <<-\EOF &&
     -+	* right
     -+	| *---.   octopus-merge
     -+	| |\ \ \
     -+	| |_|_|/
     -+	|/| | |
     -+	* | | | 4
     -+	| | | * 3
     -+	| |_|/
     -+	|/| |
     -+	| | * 2
     -+	| |/
     -+	|/|
     -+	| * 1
     -+	|/
     -+	* initial
     -+	EOF
     -+	git log --color=never --graph --date-order --pretty=tformat:%s R merge >actual.raw &&
     -+	sed "s/ *\$//" actual.raw >actual &&
     -+	test_cmp expect.uncolored actual
     -+'
     -+
     -+test_expect_success 'log --graph with left-skewed final parent with colors' '
     -+	cat >expect.colors <<-\EOF &&
     -+	* right
     -+	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><RED>-<RESET><RED>.<RESET>   octopus-merge
     -+	<RED>|<RESET> <GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <RED>\<RESET>
     -+	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET>
     -+	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET>
     -+	* <GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> 4
     -+	<MAGENTA>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 3
     -+	<MAGENTA>|<RESET> <GREEN>|<RESET><MAGENTA>_<RESET><YELLOW>|<RESET><MAGENTA>/<RESET>
     -+	<MAGENTA>|<RESET><MAGENTA>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET>
     -+	<MAGENTA>|<RESET> <GREEN>|<RESET> * 2
     -+	<MAGENTA>|<RESET> <GREEN>|<RESET><MAGENTA>/<RESET>
     -+	<MAGENTA>|<RESET><MAGENTA>/<RESET><GREEN>|<RESET>
     -+	<MAGENTA>|<RESET> * 1
     -+	<MAGENTA>|<RESET><MAGENTA>/<RESET>
     -+	* initial
     -+	EOF
     -+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
     -+	git log --color=always --graph --date-order --pretty=tformat:%s R merge >actual.colors.raw &&
     -+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
     -+	test_cmp expect.colors actual.colors
     -+'
     -+
     -+# Repeat the first two tests with "normal" octopus merge (i.e.,
     - # without the first parent skewing to the "left" branch column).
     +-test_expect_failure 'log --graph with crossover in octopus merge and its child with colors' '
     ++test_expect_success 'log --graph with crossover in octopus merge and its child with colors' '
     + 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
     + 	cat >expect.colors <<-\EOF &&
     + 	* after-4
     +@@
     + 	test_cmp expect.uncolored actual
     + '
       
     - test_expect_success 'log --graph with normal octopus merge, no color' '
     +-test_expect_failure 'log --graph with unrelated commit and octopus child with colors' '
     ++test_expect_success 'log --graph with unrelated commit and octopus child with colors' '
     + 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
     + 	cat >expect.colors <<-\EOF &&
     + 	* after-initial

-- 
gitgitgadget
