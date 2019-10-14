Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226F31F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 12:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfJNMzs (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 08:55:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50692 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfJNMzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 08:55:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so17189080wmg.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iT6YjHOaQf0MraYbJ9RdUNSDftx3Y6xuHA71VK/4Skk=;
        b=tefIJ8IPJ0gj/DPTLZWz3njvxbX18p4pjRDGPh03Aqb6fpiN/GdjO4cg8jgD9evc2j
         PpU4TbJmdSQRWMdUdqvwPzjT1MEb2SsaTwZKD4oKi188DAIIcysUwSUih1B85AVOxdI+
         A+CbP7aNAWQAbDDucUqx+5KbWb61UzjKMxvWwiKUop75vWGzyhJ6Wq5wzw2rA2bM6LoT
         4Cj5iE8SMFE963ZAiUDCUJcHVqoEblvT8f2gXsmFUXOqAGbtPo1FxthMUwqj84pPGDt2
         2l+Jt91U5yXE8IN/S8iYOH3l5XUyVfx1DgIw99udTt4HfgVDYdX8SwvhFQ4BvvhRegc4
         vC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iT6YjHOaQf0MraYbJ9RdUNSDftx3Y6xuHA71VK/4Skk=;
        b=bg7tK9OBNr/JbWhdRg/Xk6Q3IpRxmvE4TQU2SkMTuPZv6taN5DhR8EzxYj/+0ALVBE
         WqUYgNjjzum7bDk5sLqt3Ius8ojmtGg1nIoRXVUXlOrri6viJxZuH1zqXxWUFuIUJTTV
         Da2WzhTxY16SmIiSexo7k/Tnk5HDPGiyvBt68m4zz8CmZhnmkNa6d8kQTCgKozU9NMsS
         F2nZdpM3/WXjIYX7AN+E/ilPdodmtRoXWUOGspJdpSyFQ83lsN6wULptSCOevi00fawp
         ra7N5Q9KqFg/ccIp9VohhIiqeBce8403WL7CIvEEdxa5fpTOoy7e9uGx0Z4OsTs1HEMV
         tW2g==
X-Gm-Message-State: APjAAAU/UqhIqB+DelUFzRcg6B0tA8K4nWrdXTeowsfxWca5FWq0GzxD
        67qds5lpwYKZhCDtopTlxKJgcpSPfIo=
X-Google-Smtp-Source: APXvYqz6bb+VEcqlYNJSFF+SHAry4IiYuFYFCZTHw6hWt3LYxRH+bTKwzaqBZyJ7xIETP3ol+5wJNA==
X-Received: by 2002:a1c:2e94:: with SMTP id u142mr15253729wmu.69.1571057743130;
        Mon, 14 Oct 2019 05:55:43 -0700 (PDT)
Received: from liskov.home (host109-157-47-110.range109-157.btcentralplus.com. [109.157.47.110])
        by smtp.gmail.com with ESMTPSA id z142sm28404800wmc.24.2019.10.14.05.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 05:55:41 -0700 (PDT)
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.383.git.gitgitgadget@gmail.com>
 <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
 <20191010230550.GA42541@generichostname>
 <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
 <20191011050111.GA94866@generichostname>
 <nycvar.QRO.7.76.6.1910111800220.46@tvgsbejvaqbjf.bet>
 <79463ee5-a171-53a8-4903-84a825c4e8d8@gmail.com>
 <xmqqo8ymg64c.fsf@gitster-ct.c.googlers.com>
From:   James Coglan <jcoglan@gmail.com>
Message-ID: <66b8ed45-4baa-37d9-c97f-72188ece32eb@gmail.com>
Date:   Mon, 14 Oct 2019 13:55:39 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <xmqqo8ymg64c.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2019 01:27, Junio C Hamano wrote:
> James Coglan <jcoglan@gmail.com> writes:
> 
>> - We don't want a general solution to this problem for everything
>> `strbuf` could be used for; it only needs to address the graph
>> padding problem.
> 
> Of course.  Somebody may use strbuf to hold rows of a table and you
> do not want to contaminate strbuf with fields like width of each
> column etc, that are very specific to the application.  IOW, strbuf
> is merely _one_ component of a larger solution to each specific
> problem, and the latter may be things like "struct graphbuf" like
> Dscho suggested, which might use strbuf as an underlying
> <byte-string, length> tuple mechanism, but that is an implementation
> detail that should not be exposed to the users of the struct (and
> that is why he did not call, and you should not call, the data
> structure "graph-strbuf" or anything with "strbuf").

Thank you for the clarification. I've now modified my patch to call the wrapper struct `graph_line` to better reflect its use. This was informed by uncertainty on this thread about whether the width calculation needs to take line breaks into account, so I wanted to name it to indicate it contains a single display line.

>> - We only want to count printing characters, not color formatting sequences.
> 
> OK.  But I'd phrase "count printing characters" as "measure display
> width" for at least two reasons.  Whitespaces are typically counted
> as non-printing, but you do want to take them into account for this
> application.  Also the graph may not be limited to ASCII graphics
> forever, and byte- or character-count may not match display width on
> a fixed-width display.
> 
>> - We only need to consider the width of a small set of characters:
>> { | / \ _ - . * }. We don't need to worry about Unicode, and the
>> simple character counting in graph.c was working fine.
> 
> I have to warn you that we saw attempts to step outside these ASCII
> graphics and use Unicode characters for prettier output in the past.
> If you can do so without too much complexity, I'd suggest you try
> not to close the door to those people who follow your footsteps to
> further improve the system by pursuing the avenue further.

That makes sense. All I've done for now is to put the calculations that were already being done behind an interface, consisting of just the operations graph.c actually uses, namely:

void graph_line_addch(struct graph_line *line, int c);

void graph_line_addchars(struct graph_line *line, int c, size_t n);

void graph_line_addstr(struct graph_line *line, const char *s);

void graph_line_write_column(struct graph_line *line, const struct column *c, char col_char);

Having this interface in place should not preclude extending this functionality to Unicode later, and may make it simpler as it puts all the disply width calculations in one place, rather than its current state where it's distributed across all the output functions and makes the assumption that all chars contribute one display column. It especially removes the need for statements like this that encode an assumption about what was printed:

    graph_pad_horizontally(graph, sb, graph->num_columns * 2);

>> To this end I've prepared a different implementation that
>> introduces the indirection described above, and does not modify
>> `strbuf`:
>>
>> +struct graph_strbuf {
>> +	struct strbuf *buf;
>> +	size_t width;
>> +};
> 
> Is there a reason why you need a pointer to a strbuf that is
> allocated separately?  E.g. would it make it harder to manage
> if the above were
> 
> 	struct graphbuf {
> 		struct strbuf buf;
> 		int width; /* display width in columns */
> 	};
> 
> which is essentially what Dscho suggested?

I used a pointer here because I create the wrapper struct in `graph_next_line()`, which is an external interface that takes a `struct strbuf *`:

int graph_next_line(struct git_graph *graph, struct strbuf *sb)
{
	struct graph_line line = { .buf = sb, .width = 0 };
	// ...
}

So I'm not allocating the strbuf here, just wrapping a pointer to it. I would prefer to define `graph_line` as having a `strbuf` inline but I've not found a way to do that without breaking the other functions that call `graph_next_line()`. Although, as far as I know both this wrapper struct and every `strbuf` it points to are stack-allocated so I'm more concerned about the extra dereference rather than allocation cost.

If there's a way to do this I'm open to suggestions.

>> +static inline void graph_strbuf_addch(struct graph_strbuf *sb, int c)
>> +{
>> +	strbuf_addch(sb->buf, c);
>> +	sb->width++;
>> +}
>> +
>> +void graph_strbuf_addchars(struct graph_strbuf *sb, int c, size_t n)
>> +{
>> +	strbuf_addchars(sb->buf, c, n);
>> +	sb->width += n;
>> +}
>> +
>> +static inline void graph_strbuf_addstr(struct graph_strbuf *sb, const char *s)
>> +{
>> +	strbuf_addstr(sb->buf, s);
>> +	sb->width += strlen(s);
>> +}
> 
> I'd probably introduce another helper that takes color code and
> graphbuf (also notice how I name the variables and types; calling
> something sb that is not a strbuf is misleading and inviting
> unnecessary bugs):
> 
>     static inline void graphbuf_addcolor(struct graphbuf *gb, unsigned short color)
>     {
>             strbuf_addstr(gb->buf, column_get_color_code(color));
>     }
> 
> if I were writing this code.  The goal is to make any strbuf_add*()
> that is done directly on gb->buf outside these helpers a bug--that
> way, grepping for strbuf_add* in this file would become a very easy
> way to catch such a bug that bypasses the graphbuf_add*() layer and
> potentially screw up the column counting.

That would be great, I'm just not sure how to fully decouple graph.c from `strbuf` so that I can properly block it from using the `strbuf` interface. What I have done is got a better separation between uses of `strbuf` and `graph_line`, so that the only functions that still use the `strbuf` interface are the `graph_line` interface, and functions that create a `strbuf` themselves (e.g. `graph_show_commit()`). Hopefully that separation makes the intent clearer and is a stepping stone to fully decoupling these interfaces.

> Other than these three points (i.e. naming without "strbuf" that is
> an implementation detail, embedded vs pointer of strbuf in the
> graphbuf, and making sure everything can be done via graphbuf_add*()
> wrappers to make it easier to spot bugs), it seems you are going in
> the right direction.  Thanks for working on this.

Thanks! For completeness, here is the current state of this patch after I've been through the feedback up to this point:

From 241180570fbaae04a2263c5ff1ab3b92f54f8004 Mon Sep 17 00:00:00 2001
From: James Coglan <jcoglan@gmail.com>
Date: Thu, 22 Aug 2019 09:30:08 +0100
Subject: [PATCH] graph: automatically track display width of graph lines

All the output functions called by `graph_next_line()` currently keep
track of how many printable chars they've written to the buffer, before
calling `graph_pad_horizontally()` to pad the line with spaces. Some
functions do this by incrementing a counter whenever they write to the
buffer, and others do it by encoding an assumption about how many chars
are written, as in:

    graph_pad_horizontally(graph, sb, graph->num_columns * 2);

This adds a fair amount of noise to the functions' logic and is easily
broken if one forgets to increment the right counter or update the
calculations used for padding.

To make this easier to use, I'm introducing a new struct called
`graph_line` that wraps a `strbuf` and keeps count of its display width
implicitly. `graph_next_line()` wraps this around the `struct strbuf *`
it's given and passes a `struct graph_line *` to the output functions,
which use its interface.

The `graph_line` interface wraps the `strbuf_addch()`,
`strbuf_addchars()` and `strbuf_addstr()` functions, and adds the
`graph_line_write_column()` function for adding a single character with
color formatting. The `graph_pad_horizontally()` function can then use
the `width` field from the struct rather than taking a character count
as a parameter.

Signed-off-by: James Coglan <jcoglan@gmail.com>
---
 graph.c | 194 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 99 insertions(+), 95 deletions(-)

diff --git a/graph.c b/graph.c
index f53135485f..2f81a5d23d 100644
--- a/graph.c
+++ b/graph.c
@@ -112,14 +112,42 @@ static const char *column_get_color_code(unsigned short color)
 	return column_colors[color];
 }
 
-static void strbuf_write_column(struct strbuf *sb, const struct column *c,
-				char col_char)
+struct graph_line {
+	struct strbuf *buf;
+	size_t width;
+};
+
+static inline void graph_line_addch(struct graph_line *line, int c)
+{
+	strbuf_addch(line->buf, c);
+	line->width++;
+}
+
+static inline void graph_line_addchars(struct graph_line *line, int c, size_t n)
+{
+	strbuf_addchars(line->buf, c, n);
+	line->width += n;
+}
+
+static inline void graph_line_addstr(struct graph_line *line, const char *s)
+{
+	strbuf_addstr(line->buf, s);
+	line->width += strlen(s);
+}
+
+static inline void graph_line_addcolor(struct graph_line *line, unsigned short color)
+{
+	strbuf_addstr(line->buf, column_get_color_code(color));
+}
+
+static void graph_line_write_column(struct graph_line *line, const struct column *c,
+				    char col_char)
 {
 	if (c->color < column_colors_max)
-		strbuf_addstr(sb, column_get_color_code(c->color));
-	strbuf_addch(sb, col_char);
+		graph_line_addcolor(line, c->color);
+	graph_line_addch(line, col_char);
 	if (c->color < column_colors_max)
-		strbuf_addstr(sb, column_get_color_code(column_colors_max));
+		graph_line_addcolor(line, column_colors_max);
 }
 
 struct git_graph {
@@ -686,8 +714,7 @@ static int graph_is_mapping_correct(struct git_graph *graph)
 	return 1;
 }
 
-static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
-				   int chars_written)
+static void graph_pad_horizontally(struct git_graph *graph, struct graph_line *line)
 {
 	/*
 	 * Add additional spaces to the end of the strbuf, so that all
@@ -696,12 +723,12 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
 	 * This way, fields printed to the right of the graph will remain
 	 * aligned for the entire commit.
 	 */
-	if (chars_written < graph->width)
-		strbuf_addchars(sb, ' ', graph->width - chars_written);
+	if (line->width < graph->width)
+		graph_line_addchars(line, ' ', graph->width - line->width);
 }
 
 static void graph_output_padding_line(struct git_graph *graph,
-				      struct strbuf *sb)
+				      struct graph_line *line)
 {
 	int i;
 
@@ -719,11 +746,11 @@ static void graph_output_padding_line(struct git_graph *graph,
 	 * Output a padding row, that leaves all branch lines unchanged
 	 */
 	for (i = 0; i < graph->num_new_columns; i++) {
-		strbuf_write_column(sb, &graph->new_columns[i], '|');
-		strbuf_addch(sb, ' ');
+		graph_line_write_column(line, &graph->new_columns[i], '|');
+		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
+	graph_pad_horizontally(graph, line);
 }
 
 
@@ -733,14 +760,14 @@ int graph_width(struct git_graph *graph)
 }
 
 
-static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_skip_line(struct git_graph *graph, struct graph_line *line)
 {
 	/*
 	 * Output an ellipsis to indicate that a portion
 	 * of the graph is missing.
 	 */
-	strbuf_addstr(sb, "...");
-	graph_pad_horizontally(graph, sb, 3);
+	graph_line_addstr(line, "...");
+	graph_pad_horizontally(graph, line);
 
 	if (graph->num_parents >= 3 &&
 	    graph->commit_index < (graph->num_columns - 1))
@@ -750,11 +777,10 @@ static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
 }
 
 static void graph_output_pre_commit_line(struct git_graph *graph,
-					 struct strbuf *sb)
+					 struct graph_line *line)
 {
 	int num_expansion_rows;
 	int i, seen_this;
-	int chars_written;
 
 	/*
 	 * This function formats a row that increases the space around a commit
@@ -777,14 +803,12 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	 * Output the row
 	 */
 	seen_this = 0;
-	chars_written = 0;
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
 			seen_this = 1;
-			strbuf_write_column(sb, col, '|');
-			strbuf_addchars(sb, ' ', graph->expansion_row);
-			chars_written += 1 + graph->expansion_row;
+			graph_line_write_column(line, col, '|');
+			graph_line_addchars(line, ' ', graph->expansion_row);
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
 			 * This is the first line of the pre-commit output.
@@ -797,22 +821,18 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_write_column(sb, col, '\\');
+				graph_line_write_column(line, col, '\\');
 			else
-				strbuf_write_column(sb, col, '|');
-			chars_written++;
+				graph_line_write_column(line, col, '|');
 		} else if (seen_this && (graph->expansion_row > 0)) {
-			strbuf_write_column(sb, col, '\\');
-			chars_written++;
+			graph_line_write_column(line, col, '\\');
 		} else {
-			strbuf_write_column(sb, col, '|');
-			chars_written++;
+			graph_line_write_column(line, col, '|');
 		}
-		strbuf_addch(sb, ' ');
-		chars_written++;
+		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, line);
 
 	/*
 	 * Increment graph->expansion_row,
@@ -823,7 +843,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		graph_update_state(graph, GRAPH_COMMIT);
 }
 
-static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_commit_char(struct git_graph *graph, struct graph_line *line)
 {
 	/*
 	 * For boundary commits, print 'o'
@@ -831,22 +851,20 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	 */
 	if (graph->commit->object.flags & BOUNDARY) {
 		assert(graph->revs->boundary);
-		strbuf_addch(sb, 'o');
+		graph_line_addch(line, 'o');
 		return;
 	}
 
 	/*
 	 * get_revision_mark() handles all other cases without assert()
 	 */
-	strbuf_addstr(sb, get_revision_mark(graph->revs, graph->commit));
+	graph_line_addstr(line, get_revision_mark(graph->revs, graph->commit));
 }
 
 /*
- * Draw the horizontal dashes of an octopus merge and return the number of
- * characters written.
+ * Draw the horizontal dashes of an octopus merge.
  */
-static int graph_draw_octopus_merge(struct git_graph *graph,
-				    struct strbuf *sb)
+static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line *line)
 {
 	/*
 	 * Here dashless_parents represents the number of parents which don't
@@ -886,17 +904,16 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
 
 	int i;
 	for (i = 0; i < dashful_parents; i++) {
-		strbuf_write_column(sb, &graph->new_columns[i+first_col], '-');
-		strbuf_write_column(sb, &graph->new_columns[i+first_col],
-				    i == dashful_parents-1 ? '.' : '-');
+		graph_line_write_column(line, &graph->new_columns[i+first_col], '-');
+		graph_line_write_column(line, &graph->new_columns[i+first_col],
+					  i == dashful_parents-1 ? '.' : '-');
 	}
-	return 2 * dashful_parents;
 }
 
-static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_commit_line(struct git_graph *graph, struct graph_line *line)
 {
 	int seen_this = 0;
-	int i, chars_written;
+	int i;
 
 	/*
 	 * Output the row containing this commit
@@ -906,7 +923,6 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 	 * children that we have already processed.)
 	 */
 	seen_this = 0;
-	chars_written = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -920,15 +936,12 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
-			graph_output_commit_char(graph, sb);
-			chars_written++;
+			graph_output_commit_char(graph, line);
 
 			if (graph->num_parents > 2)
-				chars_written += graph_draw_octopus_merge(graph,
-									  sb);
+				graph_draw_octopus_merge(graph, line);
 		} else if (seen_this && (graph->num_parents > 2)) {
-			strbuf_write_column(sb, col, '\\');
-			chars_written++;
+			graph_line_write_column(line, col, '\\');
 		} else if (seen_this && (graph->num_parents == 2)) {
 			/*
 			 * This is a 2-way merge commit.
@@ -945,19 +958,16 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			 */
 			if (graph->prev_state == GRAPH_POST_MERGE &&
 			    graph->prev_commit_index < i)
-				strbuf_write_column(sb, col, '\\');
+				graph_line_write_column(line, col, '\\');
 			else
-				strbuf_write_column(sb, col, '|');
-			chars_written++;
+				graph_line_write_column(line, col, '|');
 		} else {
-			strbuf_write_column(sb, col, '|');
-			chars_written++;
+			graph_line_write_column(line, col, '|');
 		}
-		strbuf_addch(sb, ' ');
-		chars_written++;
+		graph_line_addch(line, ' ');
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, line);
 
 	/*
 	 * Update graph->state
@@ -981,15 +991,14 @@ static struct column *find_new_column_by_commit(struct git_graph *graph,
 	return NULL;
 }
 
-static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
 {
 	int seen_this = 0;
-	int i, j, chars_written;
+	int i, j;
 
 	/*
 	 * Output the post-merge row
 	 */
-	chars_written = 0;
 	for (i = 0; i <= graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		struct commit *col_commit;
@@ -1016,29 +1025,25 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 			par_column = find_new_column_by_commit(graph, parents->item);
 			assert(par_column);
 
-			strbuf_write_column(sb, par_column, '|');
-			chars_written++;
+			graph_line_write_column(line, par_column, '|');
 			for (j = 0; j < graph->num_parents - 1; j++) {
 				parents = next_interesting_parent(graph, parents);
 				assert(parents);
 				par_column = find_new_column_by_commit(graph, parents->item);
 				assert(par_column);
-				strbuf_write_column(sb, par_column, '\\');
-				strbuf_addch(sb, ' ');
+				graph_line_write_column(line, par_column, '\\');
+				graph_line_addch(line, ' ');
 			}
-			chars_written += j * 2;
 		} else if (seen_this) {
-			strbuf_write_column(sb, col, '\\');
-			strbuf_addch(sb, ' ');
-			chars_written += 2;
+			graph_line_write_column(line, col, '\\');
+			graph_line_addch(line, ' ');
 		} else {
-			strbuf_write_column(sb, col, '|');
-			strbuf_addch(sb, ' ');
-			chars_written += 2;
+			graph_line_write_column(line, col, '|');
+			graph_line_addch(line, ' ');
 		}
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, line);
 
 	/*
 	 * Update graph->state
@@ -1049,7 +1054,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
-static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
+static void graph_output_collapsing_line(struct git_graph *graph, struct graph_line *line)
 {
 	int i;
 	short used_horizontal = 0;
@@ -1159,9 +1164,9 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 	for (i = 0; i < graph->mapping_size; i++) {
 		int target = graph->new_mapping[i];
 		if (target < 0)
-			strbuf_addch(sb, ' ');
+			graph_line_addch(line, ' ');
 		else if (target * 2 == i)
-			strbuf_write_column(sb, &graph->new_columns[target], '|');
+			graph_line_write_column(line, &graph->new_columns[target], '|');
 		else if (target == horizontal_edge_target &&
 			 i != horizontal_edge - 1) {
 				/*
@@ -1172,16 +1177,16 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 				if (i != (target * 2)+3)
 					graph->new_mapping[i] = -1;
 				used_horizontal = 1;
-			strbuf_write_column(sb, &graph->new_columns[target], '_');
+			graph_line_write_column(line, &graph->new_columns[target], '_');
 		} else {
 			if (used_horizontal && i < horizontal_edge)
 				graph->new_mapping[i] = -1;
-			strbuf_write_column(sb, &graph->new_columns[target], '/');
+			graph_line_write_column(line, &graph->new_columns[target], '/');
 
 		}
 	}
 
-	graph_pad_horizontally(graph, sb, graph->mapping_size);
+	graph_pad_horizontally(graph, line);
 
 	/*
 	 * Swap mapping and new_mapping
@@ -1199,24 +1204,26 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 
 int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
+	struct graph_line line = { .buf = sb, .width = 0 };
+
 	switch (graph->state) {
 	case GRAPH_PADDING:
-		graph_output_padding_line(graph, sb);
+		graph_output_padding_line(graph, &line);
 		return 0;
 	case GRAPH_SKIP:
-		graph_output_skip_line(graph, sb);
+		graph_output_skip_line(graph, &line);
 		return 0;
 	case GRAPH_PRE_COMMIT:
-		graph_output_pre_commit_line(graph, sb);
+		graph_output_pre_commit_line(graph, &line);
 		return 0;
 	case GRAPH_COMMIT:
-		graph_output_commit_line(graph, sb);
+		graph_output_commit_line(graph, &line);
 		return 1;
 	case GRAPH_POST_MERGE:
-		graph_output_post_merge_line(graph, sb);
+		graph_output_post_merge_line(graph, &line);
 		return 0;
 	case GRAPH_COLLAPSING:
-		graph_output_collapsing_line(graph, sb);
+		graph_output_collapsing_line(graph, &line);
 		return 0;
 	}
 
@@ -1227,7 +1234,7 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int i;
-	int chars_written = 0;
+	struct graph_line line = { .buf = sb, .width = 0 };
 
 	if (graph->state != GRAPH_COMMIT) {
 		graph_next_line(graph, sb);
@@ -1244,20 +1251,17 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 
-		strbuf_write_column(sb, col, '|');
-		chars_written++;
+		graph_line_write_column(&line, col, '|');
 
 		if (col->commit == graph->commit && graph->num_parents > 2) {
 			int len = (graph->num_parents - 2) * 2;
-			strbuf_addchars(sb, ' ', len);
-			chars_written += len;
+			graph_line_addchars(&line, ' ', len);
 		} else {
-			strbuf_addch(sb, ' ');
-			chars_written++;
+			graph_line_addch(&line, ' ');
 		}
 	}
 
-	graph_pad_horizontally(graph, sb, chars_written);
+	graph_pad_horizontally(graph, &line);
 
 	/*
 	 * Update graph->prev_state since we have output a padding line
-- 
2.23.0

