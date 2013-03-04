From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v2] Revert "graph.c: mark private file-scope symbols as static"
Date: Sun, 3 Mar 2013 19:12:44 -0500
Message-ID: <CAHmME9oAiZDcAeMCE=haUmC9yeC0crZCKB-WrxQ3CVd1YrBdHQ@mail.gmail.com>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
	<87haktwr2a.fsf@pctrast.inf.ethz.ch>
	<20130303102946.GH7738@serenity.lan>
	<7vk3pob38d.fsf@alter.siamese.dyndns.org>
	<20130303214206.GL7738@serenity.lan>
	<7vppzg9k0n.fsf@alter.siamese.dyndns.org>
	<20130303232413.GN7738@serenity.lan>
	<7vzjyk83gn.fsf@alter.siamese.dyndns.org>
	<20130304000337.GP7738@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Lars Hjemli <hjemli@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Mar 04 01:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCJ9C-0002cW-RB
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 01:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab3CDAU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 19:20:29 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:35535 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab3CDAU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 19:20:28 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Mar 2013 19:20:28 EST
Received: from homiemail-a1.g.dreamhost.com (caiajhbdcbef.dreamhost.com [208.97.132.145])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 33457818E
	for <git@vger.kernel.org>; Sun,  3 Mar 2013 16:13:25 -0800 (PST)
Received: from homiemail-a1.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 64E0E34806E
	for <git@vger.kernel.org>; Sun,  3 Mar 2013 16:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc:
	content-type; s=zx2c4.com; bh=yVNJxSFV/Yv9TEIoWIL0NwVjXaQ=; b=JZ
	wXftYsyGFEgsmJXKnSglBcIuGU0A2c3bCirvpGFE2SHbtgiylrikrgFPisYYO+Rj
	D1T3Wrm5+XQ2H/0QDrHMd0G5ZJniMUBMTunR8EyjbNOZGlVxAZcOn1m570PIMrMy
	xLfMIQwXf4ljy3yuIkPkqqAK9IUYWcU3zNYtjYWBc=
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com [209.85.214.170])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jason@zx2c4.com)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTPSA id 427BE34806C
	for <git@vger.kernel.org>; Sun,  3 Mar 2013 16:12:45 -0800 (PST)
Received: by mail-ob0-f170.google.com with SMTP id wc20so1587019obb.1
        for <git@vger.kernel.org>; Sun, 03 Mar 2013 16:12:44 -0800 (PST)
X-Received: by 10.182.245.33 with SMTP id xl1mr14008080obc.91.1362355964701;
 Sun, 03 Mar 2013 16:12:44 -0800 (PST)
Received: by 10.76.143.37 with HTTP; Sun, 3 Mar 2013 16:12:44 -0800 (PST)
In-Reply-To: <20130304000337.GP7738@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217385>

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

On Sun, Mar 3, 2013 at 7:03 PM, John Keeping <john@keeping.me.uk> wrote:
> This reverts commit ba35480439d05b8f6cca50527072194fe3278bbb.
>
> CGit uses these symbols to output the correct HTML around graph
> elements.  Making these symbols private means that CGit cannot be
> updated to use Git 1.8.0 or newer, so let's not do that.
>
> On top of the revert, also add comments so that we avoid reintroducing
> this problem in the future and suggest to those modifying this API
> that they might want to discuss it with the CGit developers.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> On Sun, Mar 03, 2013 at 03:32:08PM -0800, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> > I think CGit expects to have to respond to changes in Git, so I don't
>> > think it's worth restricting changes in Git for that reason - it's just
>> > a case of exposing useful functionality somehow.
>>
>> I think you misread me.
>
> You're right - this makes more sense that what I originally thought you
> meant :-)
>
>> It is not about restricting. It is to use their expertise to come up
>> with generally more useful API than responding only to the immediate
>> need we see in in-tree users. We want a discussion/patch to update
>> the graph.c infrastructure to be Cc'ed to them.
>>
>> For example, with the current codeflow, the callers of these
>> functions we have in-tree may be limited to those in graph.c but if
>> there are legitimate reason CGit wants to call them from sideways,
>> perhaps there may be use cases in our codebase in the future to call
>> them from outside the normal graph.c codeflow.
>
>  graph.c | 32 ++------------------------------
>  graph.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 30 deletions(-)
>
> diff --git a/graph.c b/graph.c
> index 2a3fc5c..b24d04c 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -8,34 +8,6 @@
>  /* Internal API */
>
>  /*
> - * Output the next line for a graph.
> - * This formats the next graph line into the specified strbuf.  It is not
> - * terminated with a newline.
> - *
> - * Returns 1 if the line includes the current commit, and 0 otherwise.
> - * graph_next_line() will return 1 exactly once for each time
> - * graph_update() is called.
> - */
> -static int graph_next_line(struct git_graph *graph, struct strbuf *sb);
> -
> -/*
> - * Set up a custom scheme for column colors.
> - *
> - * The default column color scheme inserts ANSI color escapes to colorize
> - * the graph. The various color escapes are stored in an array of strings
> - * where each entry corresponds to a color, except for the last entry,
> - * which denotes the escape for resetting the color back to the default.
> - * When generating the graph, strings from this array are inserted before
> - * and after the various column characters.
> - *
> - * This function allows you to enable a custom array of color escapes.
> - * The 'colors_max' argument is the index of the last "reset" entry.
> - *
> - * This functions must be called BEFORE graph_init() is called.
> - */
> -static void graph_set_column_colors(const char **colors, unsigned short colors_max);
> -
> -/*
>   * Output a padding line in the graph.
>   * This is similar to graph_next_line().  However, it is guaranteed to
>   * never print the current commit line.  Instead, if the commit line is
> @@ -90,7 +62,7 @@ enum graph_state {
>  static const char **column_colors;
>  static unsigned short column_colors_max;
>
> -static void graph_set_column_colors(const char **colors, unsigned short colors_max)
> +void graph_set_column_colors(const char **colors, unsigned short colors_max)
>  {
>         column_colors = colors;
>         column_colors_max = colors_max;
> @@ -1144,7 +1116,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
>                 graph_update_state(graph, GRAPH_PADDING);
>  }
>
> -static int graph_next_line(struct git_graph *graph, struct strbuf *sb)
> +int graph_next_line(struct git_graph *graph, struct strbuf *sb)
>  {
>         switch (graph->state) {
>         case GRAPH_PADDING:
> diff --git a/graph.h b/graph.h
> index 19b0f66..0be62bd 100644
> --- a/graph.h
> +++ b/graph.h
> @@ -4,6 +4,25 @@
>  /* A graph is a pointer to this opaque structure */
>  struct git_graph;
>
> +/*
> + * Set up a custom scheme for column colors.
> + *
> + * The default column color scheme inserts ANSI color escapes to colorize
> + * the graph. The various color escapes are stored in an array of strings
> + * where each entry corresponds to a color, except for the last entry,
> + * which denotes the escape for resetting the color back to the default.
> + * When generating the graph, strings from this array are inserted before
> + * and after the various column characters.
> + *
> + * This function allows you to enable a custom array of color escapes.
> + * The 'colors_max' argument is the index of the last "reset" entry.
> + *
> + * This functions must be called BEFORE graph_init() is called.
> + *
> + * NOTE: This function isn't used in Git outside graph.c but it is used
> + * by CGit (http://git.zx2c4.com/cgit/) to use HTML for colors.
> + */
> +void graph_set_column_colors(const char **colors, unsigned short colors_max);
>
>  /*
>   * Create a new struct git_graph.
> @@ -33,6 +52,20 @@ void graph_update(struct git_graph *graph, struct commit *commit);
>   */
>  int graph_is_commit_finished(struct git_graph const *graph);
>
> +/*
> + * Output the next line for a graph.
> + * This formats the next graph line into the specified strbuf.  It is not
> + * terminated with a newline.
> + *
> + * Returns 1 if the line includes the current commit, and 0 otherwise.
> + * graph_next_line() will return 1 exactly once for each time
> + * graph_update() is called.
> + *
> + * NOTE: This function isn't used in Git outside graph.c but it is used
> + * by CGit (http://git.zx2c4.com/cgit/) to wrap HTML around graph lines.
> + */
> +int graph_next_line(struct git_graph *graph, struct strbuf *sb);
> +
>
>  /*
>   * graph_show_*: helper functions for printing to stdout
> --
> 1.8.2.rc1.339.g93ec2c9
>
