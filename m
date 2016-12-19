Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826C21FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932380AbcLSQ6Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:58:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:49843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbcLSQ6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 11:58:22 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAgzj-1cQUJD3yx9-00BtH6; Mon, 19
 Dec 2016 17:58:13 +0100
Date:   Mon, 19 Dec 2016 17:58:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
In-Reply-To: <xmqqlgvhuj82.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191548090.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de> <xmqqlgvhuj82.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XS0ChjKjlDE1N6WIml+D3yqyMgGVPwBzfPNSCSDNUEy9yu6y60C
 5nR3nsM62O5PzGoecaNGAs2QVn7taCB7C5P3vfw2/NNPPVooqgV3LOOyza9NRJFK7IkMLrz
 ucvv6P1yoQVOhK4JlrznuNk9qF4nsYoy/4aDV1xMH+DAubOaECqitIo+EvpZvcddUTV8v5a
 ghFf8iMSoyZyXJXn9Ml7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:971z4tAVtII=:NIee/otgVWNKscKTuCZIOZ
 Baj8J72+nUtQDXcyNxzghNlCTkhRuokreSVpSoVOJrepRRLXG/rBOA2DUso4BWYsimKu/IKw0
 iNzCW+YqpYkZFMm6M58CdQ09jepfNUMM0L+gyh5ANhoe52nSmDpmJVgytFr4z4jALCeJg9ovO
 xySInDFoMBOZXO9KS8vOtYitAkRL1LdURsUB8BNSTz0/f5ZO8TpGpkXQYmIO8NU3ExE/38wFo
 teaOv8uGR8D+F2i9BMhnhQ4rAm3nQUAdL09yH4ThyQEUPfkt6GSlmYSdRoLpLVI5r9jwArSjy
 T2KQDx/S8dzY9KY5jvhVlyIArHt7iViDQLkmdcz98CPktMB7GQqrnbASA0TbPKhMx426luz7V
 zIEletPLkW1b5vFPTdsEX9eeGZ7vwMZPmJQ2SSL+V32qq3wQmgU94hXYj3glSKmhLTonL51VS
 izQ4g+uDe9e3ha6jAcSTlpqZGOfNiOlehess+kLCaOla55relsY5gFUqTnyDetC0ZW3fMFexx
 4VnvPMG6Nit8H8ppNd4TN0XizqziQ083OCxNavMiyD37Hd7jE3TocAKhxp06NAOtgJtKMx6j1
 bdhGC2zZoL28lY5qbT1A4SU1QC9HQM06IXmgaKO3eB3ik+4AKoSaICOaUWZYceUQ8ynerx5Uz
 if8s26h2t8UffRNnc09vwClk6yOySJ/z4LPuHHI01EYSr08FCtUCxRmM00fKBdnHyRLEuIR20
 2QNvBiKp78mTWsx1dXqQLC93FUlA0uetBieGY9GbeXG+Zp/EazMqD/Ckx58VC9WWcOrwGp5Q0
 9dfrqbJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 15 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/sequencer.c b/sequencer.c
> > index f6e20b142a..271c21581d 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -45,6 +45,35 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
> >   */
> >  static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
> >  /*
> > + * The commit message that is planned to be used for any changes that
> > + * need to be committed following a user interaction.
> > + */
> > +static GIT_PATH_FUNC(rebase_path_message, "rebase-merge/message")
> > +/*
> > + * The file into which is accumulated the suggested commit message for
> > + * squash/fixup commands. When the first of a series of squash/fixups
> 
> The same comment as 03/34 applies here, regarding blank line to
> separate logical unit.

Same rationale here: the path functions are one big continuous block, with
comments obviously applying to the immediately following line only.

> > +static int update_squash_messages(enum todo_command command,
> > +		struct commit *commit, struct replay_opts *opts)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	int count, res;
> > +	const char *message, *body;
> > +
> > +	if (file_exists(rebase_path_squash_msg())) {
> > +		char *p, *p2;
> > +
> > +		if (strbuf_read_file(&buf, rebase_path_squash_msg(), 2048) <= 0)
> > +			return error(_("could not read '%s'"),
> > +				rebase_path_squash_msg());
> > +
> > +		if (buf.buf[0] != comment_line_char ||
> > +		    !skip_prefix(buf.buf + 1, " This is a combination of ",
> > +				 (const char **)&p))
> > +			return error(_("unexpected 1st line of squash message:"
> > +				       "\n\n\t%.*s"),
> > +				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
> > +				     buf.buf);
> > +		count = strtol(p, &p2, 10);
> > +
> > +		if (count < 1 || *p2 != ' ')
> > +			return error(_("invalid 1st line of squash message:\n"
> > +				       "\n\t%.*s"),
> > +				     (int)(strchrnul(buf.buf, '\n') - buf.buf),
> > +				     buf.buf);
> > +
> > +		sprintf((char *)p, "%d", ++count);
> 
> Do we know the area pointed at p (which is inside buf) long enough
> not to overflow?

Yes, we know that: p2 points to the byte after the parsed number, and said
byte is a space (ASCII 0x20), as verified by the if() above.

> If the original were 9 and you incremented to get 10, you would need one
> extra byte.

Exactly. That extra byte (if needed) is 0x20, as verified above, and can
be overwritten.

If that extra byte (to which p2 points) is *not* overwritten, i.e. if the
new count requires the same amount of space in decimal representation as
the previous count, it is now NUL, as tested here:

> > +		if (!*p2)
> > +			*p2 = ' ';
> > +		else {
> > +			*(++p2) = 'c';
> 
> p2 points into buf; do we know this increment does not step beyond
> its end?  What is the meaning of a letter 'c' here (I do not see a
> corresponding one in the scripted update_squash_messages)?

This clause is entered only when the space needed by the previous count
was not sufficient to hold the new count, at which point we know that not
only the space after the old count was overwritten, but also the 'c' of
the "commits" string.

Therefore, this clause reinstates the 'c' and inserts the space, so that
everything is groovy again:

> > +			strbuf_insert(&buf, p2 - buf.buf, " ", 1);
> > +		}

Having said that, I just realized that this code was only safe as long as
the squash messages were not localized.

I changed the code to imitate more closely what the shell script does. It
made the code a little more verbose, but it should work better as a
consequence, and I am pretty certain you will find it easier to verify
that it is correct.

> > +	}
> > +	else {
> 
> Style: "} else {" (I won't repeat this, as it will become too noisy).

It is not necessary to repeat this, either, as I took the first such
comment as a strong hint to look at the entire patch series and fix it
appropriately.

> 
> > +		unsigned char head[20];
> > +		struct commit *head_commit;
> > +		const char *head_message, *body;
> > +
> > +		if (get_sha1("HEAD", head))
> > +			return error(_("need a HEAD to fixup"));
> > +		if (!(head_commit = lookup_commit_reference(head)))
> > +			return error(_("could not read HEAD"));
> > +		if (!(head_message = get_commit_buffer(head_commit, NULL)))
> > +			return error(_("could not read HEAD's commit message"));
> > +
> > +		body = strstr(head_message, "\n\n");
> > +		if (!body)
> > +			body = "";
> > +		else
> > +			body = skip_blank_lines(body + 2);
> 
> I think I saw you used a helper function find_commit_subject() to do
> the above in an earlier patch for "edit" in this series.  Would it
> make this part (and another one for "commit" we have after this
> if/else) shorter?

Right, and by using the helper function, I also fixed a bug handling funny
commit objects that had more than one empty line separating header from
the message.

Of course, there is a third location in sequencer.c (predating my patches)
that uses the very same idiom. Yet another patch added to this growing
patch series...

> >  static int do_pick_commit(enum todo_command command, struct commit *commit,
> > -		struct replay_opts *opts)
> > +		struct replay_opts *opts, int final_fixup)
> >  {
> > +	int edit = opts->edit, cleanup_commit_message = 0;
> > +	const char *msg_file = edit ? NULL : git_path_merge_msg();
> >  	unsigned char head[20];
> >  	struct commit *base, *next, *parent;
> >  	const char *base_label, *next_label;
> >  	struct commit_message msg = { NULL, NULL, NULL, NULL };
> >  	struct strbuf msgbuf = STRBUF_INIT;
> > -	int res, unborn = 0, allow;
> > +	int res, unborn = 0, amend = 0, allow;
> >  
> >  	if (opts->no_commit) {
> >  		/*
> > @@ -749,7 +885,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
> >  	else
> >  		parent = commit->parents->item;
> >  
> > -	if (opts->allow_ff &&
> > +	if (opts->allow_ff && !is_fixup(command) &&
> >  	    ((parent && !hashcmp(parent->object.oid.hash, head)) ||
> >  	     (!parent && unborn)))
> >  		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
> > @@ -813,6 +949,28 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
> >  		}
> >  	}
> >  
> > +	if (is_fixup(command)) {
> > +		if (update_squash_messages(command, commit, opts))
> > +			return -1;
> > +		amend = 1;
> > +		if (!final_fixup)
> > +			msg_file = rebase_path_squash_msg();
> > +		else if (file_exists(rebase_path_fixup_msg())) {
> > +			cleanup_commit_message = 1;
> > +			msg_file = rebase_path_fixup_msg();
> > +		}
> > +		else {
> > +			const char *dest = git_path("SQUASH_MSG");
> > +			unlink(dest);
> > +			if (copy_file(dest, rebase_path_squash_msg(), 0666))
> > +				return error(_("could not rename '%s' to '%s'"),
> > +					     rebase_path_squash_msg(), dest);
> 
> Perhaps an error from unlink(dest) before copy_file() should also
> result in an error return?

No, because the most likely cause for that `unlink()` to fail is that the
destination does not exist, and it is fine if it does not exist yet.

No worries, copy_file() will fail if we could not remove any existing file
and we still error out in that case.

> > +			unlink(git_path("MERGE_MSG"));
> 
> Errors from this and other unlink() that emulates "rm -f" were
> unchecked in the scripted original, so not checking for errors is
> not a regression.  I would check for an error if I were writing
> this, however, because I know I would forget updating these after I
> am done with the series.

The problem is that these files do not necessarily exist. We only unlink()
them to make sure that they do not exist afterwards.

In any case, I am still more interested in a faithful translation than
already starting to improve the code at this stage.

> > @@ -1475,6 +1660,21 @@ static int do_exec(const char *command_line)
> >  	return status;
> >  }
> >  
> > +static int is_final_fixup(struct todo_list *todo_list)
> > +{
> > +	int i = todo_list->current;
> > +
> > +	if (!is_fixup(todo_list->items[i].command))
> > +		return 0;
> > +
> > +	while (++i < todo_list->nr)
> > +		if (is_fixup(todo_list->items[i].command))
> > +			return 0;
> > +		else if (todo_list->items[i].command < TODO_NOOP)
> > +			break;
> 
> What follows NOOP are comment and "drop" which is another comment in
> disguise, so this one is excluding all the no-op commands in various
> shapes, which makes sense but is clear only to a reader who bothered
> to go back to "enum todo_command" and checked that fact.  If a check
> for "is it one of the no-op commands?" appears only here, a single
> liner comment may be sufficient (but necessary) to help readers.
> Otherwise a single-liner helper function (similar to is_fixup() you
> have) with a descriptive name would be better than a single liner
> comment.

True. I introduced is_noop().

Ciao,
Dscho
