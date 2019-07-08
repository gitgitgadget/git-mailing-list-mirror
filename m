Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415C11F461
	for <e@80x24.org>; Mon,  8 Jul 2019 11:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfGHLYb (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 07:24:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfGHLYb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 07:24:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so8038501wrm.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 04:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yFS+gsK4c55cOP9sYVa0lPjWyLgOyiJLKBco20fisSU=;
        b=orlLnR46FEeV05cPEEaxt772pf+FFhPCBnO8NBgxvbzCoB+6uWfTsi/G1826U955fk
         Y1VJ48UIn5CpgChvKE2z6/mtIqAirsemx7srquf4YWuCmHjaLoueAkn/c8QC2/vhmbPL
         PnWYqdoQspETZZfSYDRRCMcQAXL1UyUvwI958Vm/hX+0SIhU4z2h+WZURkoWiA9Qe+Up
         XuUyCTMiSZDINhCYNFh6QmW0gdIkPsYhCye0iJt3n+u5BXCXRkv4Zu6/i11WKaKWUS2F
         zruK+eKbnnrD6Un0z3Ms+8UNhqUrsQLk3G9Y3SUZjopGXTiykC3tCkyb7qlhXmB+nqL4
         udmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yFS+gsK4c55cOP9sYVa0lPjWyLgOyiJLKBco20fisSU=;
        b=dsz728ybfimevYHx4WfnJ3YsVCaBAzuTb275TAeU8SJZXN7yH3ZWBxMUpiMPgfE9cB
         6f723b4UwGM5QFYVSD+3niWlC7bes4l0pbKabZU7mYMoLUTUK6H7myQEjwqVMXZ52gAk
         kRf2UQstGVbG/f1cWLQSGISaCMGujN06tL6ZkDOBoVQ576Mc43gNN3mIQMAavCbogaxs
         ipOwzOI927t8aTPOqqFT+e6rO+3On33AF0crYZO5jRrvn0dLxb71JpKGpyIFJU7Z4aA6
         PArkW49DdXvqHZVp4iO5Orc+C0/dLB8fhxnVr8NdPuvMg8zjtfdOtLdXZdcV7LIGcfbX
         S6bw==
X-Gm-Message-State: APjAAAUy/Mesb+8VQ8DlfCwZp1xNPCwdMNns4TTf//anFs+n2zgUGTvs
        wBxXQotKudyYj5sWH/vr9hA=
X-Google-Smtp-Source: APXvYqyx7k74tMGRqcdosX0m3cHc4Xd9wIRX8TcYP0XCr4ts96lt1DzITdb5U6ir6Lw5X7PUWwpekw==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr18148435wrv.347.1562585068126;
        Mon, 08 Jul 2019 04:24:28 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id h133sm21131719wme.28.2019.07.08.04.24.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 04:24:27 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:24:15 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 09/14] range-diff: split lines manually
Message-ID: <20190708112415.GB16825@hank.intra.tgummerer.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190705170630.27500-10-t.gummerer@gmail.com>
 <nycvar.QRO.7.76.6.1907052052060.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907052052060.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05, Johannes Schindelin wrote:
> Hi Thomas,
> 
> 
> On Fri, 5 Jul 2019, Thomas Gummerer wrote:
> 
> > Currently range-diff uses the 'strbuf_getline()' function for doing
> > its line by line processing.  In a future patch we want to do parts of
> > that parsing using the 'parse_git_header()' function, which does
> 
> If you like my suggestion in patch 7/14, this commit message needs to talk
> about the new name, too.

Thanks for the reminder here!  I do indeed like the new name, but
would probably have forgotten to change it in the commit message here.

> > requires reading parts of the input from that function, which doesn't
> 
> s/requires/require/
> 
> > use strbufs.
> >
> > Switch range-diff to do our own line by line parsing, so we can re-use
> > the parse_git_header function later.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >
> > Longer term it might be better to have both range-diff and apply code
> > use strbufs.  However I didn't feel it's worth making that change for
> > this patch series.
> 
> Makes sense.
> 
> >  range-diff.c | 69 +++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 39 insertions(+), 30 deletions(-)
> >
> > diff --git a/range-diff.c b/range-diff.c
> > index 9242b8975f..916afa44c0 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -24,6 +24,17 @@ struct patch_util {
> >  	struct object_id oid;
> >  };
> >
> > +static unsigned long linelen(const char *buffer, unsigned long size)
> 
> Shouldn't this be `size_t`?
> 
> > +{
> > +	unsigned long len = 0;
> 
> Likewise.
> 
> > +	while (size--) {
> > +		len++;
> > +		if (*buffer++ == '\n')
> > +			break;
> > +	}
> > +	return len;
> 
> How about
> 
> 	const char *eol = memchr(buffer, '\n', size);
> 
> 	return !eol ? size : eol + 1 - buffer;
> 
> instead?
> 
> For an extra brownie point, you could even rename this function to
> `find_end_of_line()` and replace the LF by a NUL:
> 
> 	if (!eol)
> 		return size;
> 
> 	*eol = '\0';
> 	return eol + 1 - buffer;

I like this, thank you!

> > +}
> > +
> >  /*
> >   * Reads the patches into a string list, with the `util` field being populated
> >   * as struct object_id (will need to be free()d).
> > @@ -31,10 +42,12 @@ struct patch_util {
> >  static int read_patches(const char *range, struct string_list *list)
> >  {
> >  	struct child_process cp = CHILD_PROCESS_INIT;
> > -	FILE *in;
> > -	struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
> > +	struct strbuf buf = STRBUF_INIT, file = STRBUF_INIT;
> 
> This puzzled me. I'd like to suggest s/file/contents/

Thanks, will change.

> >  	struct patch_util *util = NULL;
> >  	int in_header = 1;
> > +	char *line;
> > +	int offset, len;
> > +	size_t size;
> >
> >  	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
> >  			"--reverse", "--date-order", "--decorate=no",
> > @@ -54,17 +67,15 @@ static int read_patches(const char *range, struct string_list *list)
> >
> >  	if (start_command(&cp))
> >  		return error_errno(_("could not start `log`"));
> > -	in = fdopen(cp.out, "r");
> > -	if (!in) {
> > -		error_errno(_("could not read `log` output"));
> > -		finish_command(&cp);
> > -		return -1;
> > -	}
> > +	strbuf_read(&file, cp.out, 0);
> 
> Shouldn't we handle a negative return value here, erroring out with "could
> not read `log` output" as before?

Yeah, that was an oversight, we should definitely still handle errors
here.

> >
> > -	while (strbuf_getline(&line, in) != EOF) {
> > +	line = strbuf_detach(&file, &size);
> 
> I strongly suspect this to leak, given that `line` is subsequently
> advanced, and there is no backup copy.
> 
> Maybe
> 
> 	line = file.buf;
> 	size = file.len;
> 
> would make more sense here?

Hmm good point, that makes more sense indeed.

> > +	for (offset = 0; size > 0; offset += len, size -= len, line += len) {
> >  		const char *p;
> >
> > -		if (skip_prefix(line.buf, "commit ", &p)) {
> > +		len = linelen(line, size);
> > +		line[len - 1] = '\0';
> > +		if (skip_prefix(line, "commit ", &p)) {
> >  			if (util) {
> >  				string_list_append(list, buf.buf)->util = util;
> >  				strbuf_reset(&buf);
> > @@ -75,8 +86,6 @@ static int read_patches(const char *range, struct string_list *list)
> >  				free(util);
> >  				string_list_clear(list, 1);
> >  				strbuf_release(&buf);
> > -				strbuf_release(&line);
> > -				fclose(in);
> 
> We should release the file contents in `file` (or `contents`, if you like
> my suggestions) here.

Yeah, I thought it was no longer necessary because of the
'strbuf_detach()' earlier, but that obviously leaks in a different way
as you pointed out.  Will release 'contents' here and below. 

> >  				finish_command(&cp);
> >  				return -1;
> >  			}
> > @@ -85,26 +94,28 @@ static int read_patches(const char *range, struct string_list *list)
> >  			continue;
> >  		}
> >
> > -		if (starts_with(line.buf, "diff --git")) {
> > +		if (starts_with(line, "diff --git")) {
> >  			in_header = 0;
> >  			strbuf_addch(&buf, '\n');
> >  			if (!util->diff_offset)
> >  				util->diff_offset = buf.len;
> >  			strbuf_addch(&buf, ' ');
> > -			strbuf_addbuf(&buf, &line);
> > +			strbuf_addstr(&buf, line);
> >  		} else if (in_header) {
> > -			if (starts_with(line.buf, "Author: ")) {
> > -				strbuf_addbuf(&buf, &line);
> > +			if (starts_with(line, "Author: ")) {
> > +				strbuf_addstr(&buf, line);
> >  				strbuf_addstr(&buf, "\n\n");
> > -			} else if (starts_with(line.buf, "    ")) {
> > -				strbuf_rtrim(&line);
> > -				strbuf_addbuf(&buf, &line);
> > +			} else if (starts_with(line, "    ")) {
> > +				p = line + len - 2;
> > +				while (isspace(*p) && p >= line)
> > +					p--;
> > +				strbuf_add(&buf, line, p - line + 1);
> >  				strbuf_addch(&buf, '\n');
> >  			}
> >  			continue;
> > -		} else if (starts_with(line.buf, "@@ "))
> > +		} else if (starts_with(line, "@@ "))
> >  			strbuf_addstr(&buf, "@@");
> > -		else if (!line.buf[0] || starts_with(line.buf, "index "))
> > +		else if (!line[0] || starts_with(line, "index "))
> >  			/*
> >  			 * A completely blank (not ' \n', which is context)
> >  			 * line is not valid in a diff.  We skip it
> > @@ -117,25 +128,23 @@ static int read_patches(const char *range, struct string_list *list)
> >  			 * we are not interested.
> >  			 */
> >  			continue;
> > -		else if (line.buf[0] == '>') {
> > +		else if (line[0] == '>') {
> >  			strbuf_addch(&buf, '+');
> > -			strbuf_add(&buf, line.buf + 1, line.len - 1);
> > -		} else if (line.buf[0] == '<') {
> > +			strbuf_addstr(&buf, line + 1);
> > +		} else if (line[0] == '<') {
> >  			strbuf_addch(&buf, '-');
> > -			strbuf_add(&buf, line.buf + 1, line.len - 1);
> > -		} else if (line.buf[0] == '#') {
> > +			strbuf_addstr(&buf, line + 1);
> > +		} else if (line[0] == '#') {
> >  			strbuf_addch(&buf, ' ');
> > -			strbuf_add(&buf, line.buf + 1, line.len - 1);
> > +			strbuf_addstr(&buf, line + 1);
> >  		} else {
> >  			strbuf_addch(&buf, ' ');
> > -			strbuf_addbuf(&buf, &line);
> > +			strbuf_addstr(&buf, line);
> >  		}
> >
> >  		strbuf_addch(&buf, '\n');
> >  		util->diffsize++;
> >  	}
> > -	fclose(in);
> > -	strbuf_release(&line);
> 
> We should release the file contents we previously read via `strbuf_read()` here.
> 
> Ciao,
> Dscho
> 
> >
> >  	if (util)
> >  		string_list_append(list, buf.buf)->util = util;
> > --
> > 2.22.0.510.g264f2c817a
> >
> >
