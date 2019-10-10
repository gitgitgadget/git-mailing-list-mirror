Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5C911F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 21:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfJJVH7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 17:07:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:40371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfJJVH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 17:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570741671;
        bh=9Nh0gHJKs34Z/WcVOEHqdA0iQjoqj0cze5WtHSzHKv4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PggVrf0Wa/9taaEvvnbjMBfdceSDO6yJj9Upq3vCFPiLcbouddW1YDyC4LGyEe9ty
         YaLEkBz0xOUr5+QoV6Ld17B2dBlmgkbuLbsxJvkGLlJPGlxpTEnK6tuB1obrkH8Tue
         FBkcffzMgAYGZso7Slc8+Rdwo5KjybLHnV1LifP4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1iKbT42ntp-00Fg70; Thu, 10
 Oct 2019 23:07:51 +0200
Date:   Thu, 10 Oct 2019 23:07:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
In-Reply-To: <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
References: <pull.383.git.gitgitgadget@gmail.com> <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XPFZRkZG7yTEZR8jwnXszT//vNCdKSBLtB/khSu4KCPW32o/UCT
 D2aqSP4UkBXCd0ed1OzygNvzY1hd1mK5IiD8o4NBJlEsnS24jxKwvwS4fY8UraDfo7aZuDH
 7CdY976bLB5b+7n26fWEpCFEYkAPmcBYgb190+sWDuMas3HAxqQwHZx+fKa7cikeYSMW2uD
 GdBi1nTWuyn3kExLA8JNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k5r9bzjEM/w=:um15qhTli+mSzSCuCxUsUV
 kEaD5YTRBmc/wq4WtRlq1mlPG3uZtcjUEFrBURblXJDXwAARdt4uSEtlDxlzegcuabBuxuJjS
 bAAO4UveQ4gGSZphlwAkfqNSxSHEahT+J+2lpTtTkQ/5ueIDkIhG9zD7eThNZ7pvTRAd2xUJw
 Cm5shVU/mPsaDbjh+clCRK6IJHbtpoN3WFZWQjk1H1Dh4hT5skvcvrFmqium44GIlC+tKN5v1
 3eywK2JiVRJrc0fy3wGUhfTu8TAU0jn208nEkWiUKtylK95cHj0mSlIewi0WBEpxoITZ0uEF9
 SmjYf0SQZHtOV+/SzFeDIGyvpANLM0j1cS4aEf96f3NUapwoSTnwTRtJJgy7fVkDEuUH9xHTa
 LCYiWsIhqk9mSJbTM38AltNfI9r1w/G31kainlq3pVuolitkGWiRGTJ8GGJBhtCSnpuTkpVau
 PPOQaqmNspss36yxK/vhl3AKFyg36UbDQOINNyYBO3mZdf6Yg+pgd2/L6CxJrsbdb1QIYDwEk
 BJxL6b2MnPyOdVX0Ey+nQBhynaA9yM9mhyIA8KURzHmz+e31BIaQfUBOVvOppVNpxVS2FLGi4
 9ynGgbF3cqA42A3d6Vmj1UK08xRmS8Zfr42SCinQnZfoeIAzItw23Vx0C4kk2zhTn1h1w1Ey8
 ti7cad6JmDI0BwzhcP0i6Fbzdco4kydP/doxloVg7CVgX9POFWaLBlsQfZ+NsuFfvJGTpI1bI
 YvPjOBnrXamohcUZm04qchBw9HMuVSgFkhZ6KcbFA9ibiZOxhlL9NCkiq0G/n2fnHjVNXrc26
 lA8o1IfpZoW15HUgLC0TluU3wtl8utrfEDsJKdmGvsUk3riJVzKe220svxnUGObnzyh+1ksWZ
 oE/q8wu39aCynPa5ffn/JiOCvaDHDw+yyba8gJjLN+uLFaq0nLbSF7Ich6IU3/Fm99yKSo8KD
 7xd8MY4VqTKmVCENwWiJu6slSHzIJVeUcslhSmU9jCC8KcCvz/CvBhVpgZgkGA6mil+AdWJ4w
 QIWAjhY5RTVBGOYz7bVuEABpICHo9ZPovqkOahuxP5wtcP/N1vkqU4mxLG6LsAlZ/BQVZ5343
 UX04NywgsT6rD3kJASs7aqwB3IIUvg8PqMq9dQlj3tqW/rwVB6iHaonlGOCZ5NHl3IyFp0+CV
 DmnGp4oB65wujkuuuYXs4Imj6eVQBDG79TKAcb45P5EGv+ik0GueB1Mdm4YJaGUS9Nza03Shg
 4IYw67aOJ2U/RWhM4/WZsEsnIZUNfBXTvpOOYp2JdXjI/+sYoAeaVvbm47Sg=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

On Thu, 10 Oct 2019, James Coglan via GitGitGadget wrote:

> From: James Coglan <jcoglan@gmail.com>
>
> All the output functions in `graph.c` currently keep track of how many
> printable chars they've written to the buffer, before calling
> `graph_pad_horizontally()` to pad the line with spaces. Some functions
> do this by incrementing a counter whenever they write to the buffer, and
> others do it by encoding an assumption about how many chars are written,
> as in:
>
>     graph_pad_horizontally(graph, sb, graph->num_columns * 2);
>
> This adds a fair amount of noise to the functions' logic and is easily
> broken if one forgets to increment the right counter or update the
> calculations used for padding.
>
> To make this easier to use, I'm adding a `width` field to `strbuf` that
> tracks the number of printing characters added after the line prefix.

This is a big heavy-handed: adding a `width` field to `struct strbuf`
and maintaining it _just_ for the purpose of `graph.c` puts an
unnecssary load on every other `strbuf` user (of which there are a
_lot_).

So my obvious question is: what makes `width` different from `len`?
Since we exclusively use ASCII characters for the graph part, we should
be able to use the already-existing `len`, for free, no?

I could imagine that the `strbuf` might receive more than one line, but
then we still would only need to remember the offset of the last newline
character in that `strbuf`, no?

Ciao,
Johannes

> It's set to 0 at the start of `graph_next_line()`, and then various
> `strbuf` functions update it as follows:
>
> - `strbuf_write_column()` increments `width` by 1
>
> - `strbuf_setlen()` changes `width` by the amount added to `len` if
>   `len` is increased, or makes `width` and `len` the same if it's
>   decreased
>
> - `strbuf_addch()` increments `width` by 1
>
> This is enough to ensure that the functions used by `graph.c` update
> `strbuf->width` correctly, and `graph_pad_horizontally()` can then use
> this field instead of taking `chars_written` as a parameter.
>
> Signed-off-by: James Coglan <jcoglan@gmail.com>
> ---
>  graph.c  | 68 ++++++++++++++++++++++----------------------------------
>  strbuf.h |  8 ++++++-
>  2 files changed, 33 insertions(+), 43 deletions(-)
>
> diff --git a/graph.c b/graph.c
> index f53135485f..c56fdec1fc 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -115,11 +115,20 @@ static const char *column_get_color_code(unsigned =
short color)
>  static void strbuf_write_column(struct strbuf *sb, const struct column =
*c,
>  				char col_char)
>  {
> +	/*
> +	 * Remember the buffer's width as we're about to add non-printing
> +	 * content to it, and we want to avoid counting the byte length
> +	 * of this content towards the buffer's visible width
> +	 */
> +	size_t prev_width =3D sb->width;
> +
>  	if (c->color < column_colors_max)
>  		strbuf_addstr(sb, column_get_color_code(c->color));
>  	strbuf_addch(sb, col_char);
>  	if (c->color < column_colors_max)
>  		strbuf_addstr(sb, column_get_color_code(column_colors_max));
> +
> +	sb->width =3D prev_width + 1;
>  }
>
>  struct git_graph {
> @@ -686,8 +695,7 @@ static int graph_is_mapping_correct(struct git_graph=
 *graph)
>  	return 1;
>  }
>
> -static void graph_pad_horizontally(struct git_graph *graph, struct strb=
uf *sb,
> -				   int chars_written)
> +static void graph_pad_horizontally(struct git_graph *graph, struct strb=
uf *sb)
>  {
>  	/*
>  	 * Add additional spaces to the end of the strbuf, so that all
> @@ -696,8 +704,8 @@ static void graph_pad_horizontally(struct git_graph =
*graph, struct strbuf *sb,
>  	 * This way, fields printed to the right of the graph will remain
>  	 * aligned for the entire commit.
>  	 */
> -	if (chars_written < graph->width)
> -		strbuf_addchars(sb, ' ', graph->width - chars_written);
> +	if (sb->width < graph->width)
> +		strbuf_addchars(sb, ' ', graph->width - sb->width);
>  }
>
>  static void graph_output_padding_line(struct git_graph *graph,
> @@ -723,7 +731,7 @@ static void graph_output_padding_line(struct git_gra=
ph *graph,
>  		strbuf_addch(sb, ' ');
>  	}
>
> -	graph_pad_horizontally(graph, sb, graph->num_new_columns * 2);
> +	graph_pad_horizontally(graph, sb);
>  }
>
>
> @@ -740,7 +748,7 @@ static void graph_output_skip_line(struct git_graph =
*graph, struct strbuf *sb)
>  	 * of the graph is missing.
>  	 */
>  	strbuf_addstr(sb, "...");
> -	graph_pad_horizontally(graph, sb, 3);
> +	graph_pad_horizontally(graph, sb);
>
>  	if (graph->num_parents >=3D 3 &&
>  	    graph->commit_index < (graph->num_columns - 1))
> @@ -754,7 +762,6 @@ static void graph_output_pre_commit_line(struct git_=
graph *graph,
>  {
>  	int num_expansion_rows;
>  	int i, seen_this;
> -	int chars_written;
>
>  	/*
>  	 * This function formats a row that increases the space around a commi=
t
> @@ -777,14 +784,12 @@ static void graph_output_pre_commit_line(struct gi=
t_graph *graph,
>  	 * Output the row
>  	 */
>  	seen_this =3D 0;
> -	chars_written =3D 0;
>  	for (i =3D 0; i < graph->num_columns; i++) {
>  		struct column *col =3D &graph->columns[i];
>  		if (col->commit =3D=3D graph->commit) {
>  			seen_this =3D 1;
>  			strbuf_write_column(sb, col, '|');
>  			strbuf_addchars(sb, ' ', graph->expansion_row);
> -			chars_written +=3D 1 + graph->expansion_row;
>  		} else if (seen_this && (graph->expansion_row =3D=3D 0)) {
>  			/*
>  			 * This is the first line of the pre-commit output.
> @@ -800,19 +805,15 @@ static void graph_output_pre_commit_line(struct gi=
t_graph *graph,
>  				strbuf_write_column(sb, col, '\\');
>  			else
>  				strbuf_write_column(sb, col, '|');
> -			chars_written++;
>  		} else if (seen_this && (graph->expansion_row > 0)) {
>  			strbuf_write_column(sb, col, '\\');
> -			chars_written++;
>  		} else {
>  			strbuf_write_column(sb, col, '|');
> -			chars_written++;
>  		}
>  		strbuf_addch(sb, ' ');
> -		chars_written++;
>  	}
>
> -	graph_pad_horizontally(graph, sb, chars_written);
> +	graph_pad_horizontally(graph, sb);
>
>  	/*
>  	 * Increment graph->expansion_row,
> @@ -842,11 +843,9 @@ static void graph_output_commit_char(struct git_gra=
ph *graph, struct strbuf *sb)
>  }
>
>  /*
> - * Draw the horizontal dashes of an octopus merge and return the number=
 of
> - * characters written.
> + * Draw the horizontal dashes of an octopus merge.
>   */
> -static int graph_draw_octopus_merge(struct git_graph *graph,
> -				    struct strbuf *sb)
> +static void graph_draw_octopus_merge(struct git_graph *graph, struct st=
rbuf *sb)
>  {
>  	/*
>  	 * Here dashless_parents represents the number of parents which don't
> @@ -890,13 +889,12 @@ static int graph_draw_octopus_merge(struct git_gra=
ph *graph,
>  		strbuf_write_column(sb, &graph->new_columns[i+first_col],
>  				    i =3D=3D dashful_parents-1 ? '.' : '-');
>  	}
> -	return 2 * dashful_parents;
>  }
>
>  static void graph_output_commit_line(struct git_graph *graph, struct st=
rbuf *sb)
>  {
>  	int seen_this =3D 0;
> -	int i, chars_written;
> +	int i;
>
>  	/*
>  	 * Output the row containing this commit
> @@ -906,7 +904,6 @@ static void graph_output_commit_line(struct git_grap=
h *graph, struct strbuf *sb)
>  	 * children that we have already processed.)
>  	 */
>  	seen_this =3D 0;
> -	chars_written =3D 0;
>  	for (i =3D 0; i <=3D graph->num_columns; i++) {
>  		struct column *col =3D &graph->columns[i];
>  		struct commit *col_commit;
> @@ -921,14 +918,11 @@ static void graph_output_commit_line(struct git_gr=
aph *graph, struct strbuf *sb)
>  		if (col_commit =3D=3D graph->commit) {
>  			seen_this =3D 1;
>  			graph_output_commit_char(graph, sb);
> -			chars_written++;
>
>  			if (graph->num_parents > 2)
> -				chars_written +=3D graph_draw_octopus_merge(graph,
> -									  sb);
> +				graph_draw_octopus_merge(graph, sb);
>  		} else if (seen_this && (graph->num_parents > 2)) {
>  			strbuf_write_column(sb, col, '\\');
> -			chars_written++;
>  		} else if (seen_this && (graph->num_parents =3D=3D 2)) {
>  			/*
>  			 * This is a 2-way merge commit.
> @@ -948,16 +942,13 @@ static void graph_output_commit_line(struct git_gr=
aph *graph, struct strbuf *sb)
>  				strbuf_write_column(sb, col, '\\');
>  			else
>  				strbuf_write_column(sb, col, '|');
> -			chars_written++;
>  		} else {
>  			strbuf_write_column(sb, col, '|');
> -			chars_written++;
>  		}
>  		strbuf_addch(sb, ' ');
> -		chars_written++;
>  	}
>
> -	graph_pad_horizontally(graph, sb, chars_written);
> +	graph_pad_horizontally(graph, sb);
>
>  	/*
>  	 * Update graph->state
> @@ -984,12 +975,11 @@ static struct column *find_new_column_by_commit(st=
ruct git_graph *graph,
>  static void graph_output_post_merge_line(struct git_graph *graph, struc=
t strbuf *sb)
>  {
>  	int seen_this =3D 0;
> -	int i, j, chars_written;
> +	int i, j;
>
>  	/*
>  	 * Output the post-merge row
>  	 */
> -	chars_written =3D 0;
>  	for (i =3D 0; i <=3D graph->num_columns; i++) {
>  		struct column *col =3D &graph->columns[i];
>  		struct commit *col_commit;
> @@ -1017,7 +1007,6 @@ static void graph_output_post_merge_line(struct gi=
t_graph *graph, struct strbuf
>  			assert(par_column);
>
>  			strbuf_write_column(sb, par_column, '|');
> -			chars_written++;
>  			for (j =3D 0; j < graph->num_parents - 1; j++) {
>  				parents =3D next_interesting_parent(graph, parents);
>  				assert(parents);
> @@ -1026,19 +1015,16 @@ static void graph_output_post_merge_line(struct =
git_graph *graph, struct strbuf
>  				strbuf_write_column(sb, par_column, '\\');
>  				strbuf_addch(sb, ' ');
>  			}
> -			chars_written +=3D j * 2;
>  		} else if (seen_this) {
>  			strbuf_write_column(sb, col, '\\');
>  			strbuf_addch(sb, ' ');
> -			chars_written +=3D 2;
>  		} else {
>  			strbuf_write_column(sb, col, '|');
>  			strbuf_addch(sb, ' ');
> -			chars_written +=3D 2;
>  		}
>  	}
>
> -	graph_pad_horizontally(graph, sb, chars_written);
> +	graph_pad_horizontally(graph, sb);
>
>  	/*
>  	 * Update graph->state
> @@ -1181,7 +1167,7 @@ static void graph_output_collapsing_line(struct gi=
t_graph *graph, struct strbuf
>  		}
>  	}
>
> -	graph_pad_horizontally(graph, sb, graph->mapping_size);
> +	graph_pad_horizontally(graph, sb);
>
>  	/*
>  	 * Swap mapping and new_mapping
> @@ -1199,6 +1185,8 @@ static void graph_output_collapsing_line(struct gi=
t_graph *graph, struct strbuf
>
>  int graph_next_line(struct git_graph *graph, struct strbuf *sb)
>  {
> +	sb->width =3D 0;
> +
>  	switch (graph->state) {
>  	case GRAPH_PADDING:
>  		graph_output_padding_line(graph, sb);
> @@ -1227,7 +1215,6 @@ int graph_next_line(struct git_graph *graph, struc=
t strbuf *sb)
>  static void graph_padding_line(struct git_graph *graph, struct strbuf *=
sb)
>  {
>  	int i;
> -	int chars_written =3D 0;
>
>  	if (graph->state !=3D GRAPH_COMMIT) {
>  		graph_next_line(graph, sb);
> @@ -1245,19 +1232,16 @@ static void graph_padding_line(struct git_graph =
*graph, struct strbuf *sb)
>  		struct column *col =3D &graph->columns[i];
>
>  		strbuf_write_column(sb, col, '|');
> -		chars_written++;
>
>  		if (col->commit =3D=3D graph->commit && graph->num_parents > 2) {
>  			int len =3D (graph->num_parents - 2) * 2;
>  			strbuf_addchars(sb, ' ', len);
> -			chars_written +=3D len;
>  		} else {
>  			strbuf_addch(sb, ' ');
> -			chars_written++;
>  		}
>  	}
>
> -	graph_pad_horizontally(graph, sb, chars_written);
> +	graph_pad_horizontally(graph, sb);
>
>  	/*
>  	 * Update graph->prev_state since we have output a padding line
> diff --git a/strbuf.h b/strbuf.h
> index f62278a0be..3a98147321 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -66,11 +66,12 @@ struct string_list;
>  struct strbuf {
>  	size_t alloc;
>  	size_t len;
> +	size_t width;
>  	char *buf;
>  };
>
>  extern char strbuf_slopbuf[];
> -#define STRBUF_INIT  { .alloc =3D 0, .len =3D 0, .buf =3D strbuf_slopbu=
f }
> +#define STRBUF_INIT  { .alloc =3D 0, .len =3D 0, .width =3D 0, .buf =3D=
 strbuf_slopbuf }
>
>  /*
>   * Predeclare this here, since cache.h includes this file before it def=
ines the
> @@ -161,6 +162,10 @@ static inline void strbuf_setlen(struct strbuf *sb,=
 size_t len)
>  {
>  	if (len > (sb->alloc ? sb->alloc - 1 : 0))
>  		die("BUG: strbuf_setlen() beyond buffer");
> +	if (len > sb->len)
> +		sb->width +=3D len - sb->len;
> +	else
> +		sb->width =3D len;
>  	sb->len =3D len;
>  	if (sb->buf !=3D strbuf_slopbuf)
>  		sb->buf[len] =3D '\0';
> @@ -231,6 +236,7 @@ static inline void strbuf_addch(struct strbuf *sb, i=
nt c)
>  		strbuf_grow(sb, 1);
>  	sb->buf[sb->len++] =3D c;
>  	sb->buf[sb->len] =3D '\0';
> +	sb->width++;
>  }
>
>  /**
> --
> gitgitgadget
>
>
