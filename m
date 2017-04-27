Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5592A207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 21:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423158AbdD0Vov (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 17:44:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:55229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423155AbdD0Vou (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 17:44:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZTP3-1dOy2D3wMf-00LIvJ; Thu, 27
 Apr 2017 23:44:37 +0200
Date:   Thu, 27 Apr 2017 23:44:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/9] rebase -i: also expand/collapse the SHA-1s via
 the rebase--helper
In-Reply-To: <xmqqr30eo36n.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704272331190.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <df5263cc0cad5cffbd1932d4b9b8e5c0507536e6.1493207864.git.johannes.schindelin@gmx.de> <xmqqr30eo36n.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:e/3lKyHiopuTy/ob1/pj4kvmHWDeX1i/aOYSz11kwitvlcNUsms
 KHI0BIPPWm9jb5KOmROIukD6Hzzj7NUnfIxbTub5XTwjomWhcIloecx8X+pvWrTQTDJdsJB
 5xTGlUbliVR1wyc2I62igSybk5oN+7UfEUL+hWx/a1G813l6GfS4T6AwJozBZQsgu/5B2DG
 DUgvxDH6XG0NfD+K0KxAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fybkeRe3pnY=:DMTbvzwBbZoh5c5jda/ZmO
 512VDBa7mFfi98ihVEv0Ogy1171WVPPd+miJKqK3VN3expCgcXGdNrJdpAX/TcMGiaGFO9CnM
 vAgWybmHedchByUtmjyVLv+EMyfAJIU8s2FdWmVxXDnAUQkuWqK+1cywTY0/0+bvyo234riHb
 X4VqQaXPBWQ3632eBFrmM0VU4lh5lVZ3oEX+JLP47CyEDSxH3XO72waAl4X0M2Y8yRgjhTMYE
 uvtjvlOSyEl+L68Zgs9k+PHBTAUX1MxSMSl1Bm7eL7xycMHreaHrlM20D9f9v9o1lOsLm0j0k
 nyN9ZPDOWuvjCMIITwl52++Q/SR+MLm+sLssGwluKh7FlZ6rm5HK1nEWp5K6lk3hjwLJ6H2NA
 bfgRO7Kka5LSoSEthYSjIIdbhEBHYhwdKrplcMEFGjmjqNOApRBt5asBiqul34aBIdWKSS4bI
 fy/mwH129ZW9BYZn90DXyJjb3MBpyzxuIvVaOOoqpJ4WgjhR/xD0lf4O18QvoKqV3TbqGUxtH
 ecB2Jj2Za5oSeu+JlYtN+hOJdnpc7iumFpam8IKknTvIGlyKBqt8xWKWtHcF2SQDQ0mX8xmxz
 9ycsPweYt9kzCBEFrM1NWNXBKF1mGSVB9PQeMcSCx3BEG4rbJ2z5ShasoNgwWptIpw9kO0Bx4
 oQIZcN7wnDv2KjUsl4CzKtLoyn0DaTLyTOnUFWe1S7VM9t4Mw7ZfB5fhVa17vaSL/KspHj//v
 w6bYCjInxSbC3PERs11j+rwDP4M54O+I/GjVGuayOgKpssuEFuZv80ypVu0GgG1/AWiuXecHq
 E80rjQC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> > index 214af0372ba..52a19e0bdb3 100644
> > --- a/git-rebase--interactive.sh
> > +++ b/git-rebase--interactive.sh
> > @@ -774,11 +774,11 @@ transform_todo_ids () {
> >  }
> >  
> >  expand_todo_ids() {
> > -	transform_todo_ids
> > +	git rebase--helper --expand-sha1s
> >  }
> >  
> >  collapse_todo_ids() {
> > -	transform_todo_ids --short
> > +	git rebase--helper --shorten-sha1s
> >  }
> 
> Obviously correct ;-)  But doesn't this make transform_todo_ids ()
> helper unused and removable?

But of course it is now unused! Will fix.

> > +int transform_todo_ids(int shorten_sha1s)
> > +{
> > +	const char *todo_file = rebase_path_todo();
> > +	struct todo_list todo_list = TODO_LIST_INIT;
> > +	int fd, res, i;
> > +	FILE *out;
> > +
> > +	strbuf_reset(&todo_list.buf);
> > +	fd = open(todo_file, O_RDONLY);
> > +	if (fd < 0)
> > +		return error_errno(_("could not open '%s'"), todo_file);
> > +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> > +		close(fd);
> > +		return error(_("could not read '%s'."), todo_file);
> > +	}
> > +	close(fd);
> > +
> > +	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
> > +	if (res) {
> > +		todo_list_release(&todo_list);
> > +		return error(_("unusable instruction sheet: '%s'"), todo_file);
> > +	}
> > +
> > +	out = fopen(todo_file, "w");
> 
> The usual "open lockfile, write to it and then rename" dance is not
> necessary for the purpose of preventing other people from reading
> this file while we are writing to it.  But if we fail inside this
> function before we fclose(3) "out", the user will lose the todo
> list.  It probably is not a big deal, though.

I guess you're right. It is bug-for-bug equivalent to the previous shell
function, though.

> > +	if (!out) {
> > +		todo_list_release(&todo_list);
> > +		return error(_("unable to open '%s' for writing"), todo_file);
> > +	}
> > +	for (i = 0; i < todo_list.nr; i++) {
> > +		struct todo_item *item = todo_list.items + i;
> > +		int bol = item->offset_in_buf;
> > +		const char *p = todo_list.buf.buf + bol;
> > +		int eol = i + 1 < todo_list.nr ?
> > +			todo_list.items[i + 1].offset_in_buf :
> > +			todo_list.buf.len;
> > +
> > +		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
> > +			fwrite(p, eol - bol, 1, out);
> > +		else {
> > +			int eoc = strcspn(p, " \t");
> > +			const char *sha1 = shorten_sha1s ?
> > +				short_commit_name(item->commit) :
> > +				oid_to_hex(&item->commit->object.oid);
> > +
> > +			if (!eoc) {
> > +				p += strspn(p, " \t");
> > +				eoc = strcspn(p, " \t");
> > +			}
> 
> It would be much easier to follow the logic if "int eoc" above were
> a mere declaration without initialization and "skip to the
> whitespaces" is done immediately before this if() statement.  It's
> not like the initialized value of eoc is needed there because it
> participates in the computation of sha1, and also having the
> assignment followed by "oops, the line begins with a whitespace"
> recovery that is done here.
> 
> Wouldn't it be simpler to do:
> 
> 	else {
> 		int eoc;
> 		const char *sha1 = ...
> 		p += strspn(p, " \t"); /* skip optional indent */
> 		eoc = strcspn(p, " \t"); /* grab the command word */
> 
> without conditional?

Sure, will fix.

Ciao,
Dscho

