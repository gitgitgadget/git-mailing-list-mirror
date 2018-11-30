Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40AF1211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 19:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLAGQ7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 01:16:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:49939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeLAGQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 01:16:59 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lg1QN-1hHaG91ffn-00pcHh; Fri, 30
 Nov 2018 20:06:34 +0100
Date:   Fri, 30 Nov 2018 20:06:33 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/16] sequencer: refactor sequencer_add_exec_commands()
 to work on a todo_list
In-Reply-To: <0e00acd9-5b09-b712-2e21-550e348ea0df@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1811302002340.41@tvgsbejvaqbjf.bet>
References: <20181027212930.9303-1-alban.gruin@gmail.com> <20181109080805.6350-1-alban.gruin@gmail.com> <20181109080805.6350-7-alban.gruin@gmail.com> <0e00acd9-5b09-b712-2e21-550e348ea0df@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:20qZ2fyrxHW9HLTgWxhaoI9lDcZGCXHsKbgthDdDgvnMhN/DNLj
 /4rjoTfqMGuFliDqcLM6v89UElqol7raTDj4JOjhsUShOlVEGX99lzaTujtYJEKI57RzpDK
 76wMkA3yUTrSWwbBb4nW6zJJ0+/4lQiyUwdfD4TFQM5YBxDexY2k4srBnyB+yvDIXEtKqhQ
 vpVh/aWYtzvIklOVNV6jA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fFfEjpzEBTQ=:UllgnJq3mlHsq01ZEceJpK
 7jyRAA9MCRYCogNbTHbXTRu2QngGPMlO/2cGN5sHfMFKW8meq3CD6s2xosKLpvNkPV/DpJE4F
 Vx+sBeJOF0x7cBOWb0GHZL6lcGRnfetfXUV0qSaQniQx4BSwHoStXwnSmFA9wFo/0MjnuOPFs
 4SVB+vAv4J1U+e63AWDyIOq/UE48Frb/X9+Piw9INtlr5topm8US0Mt2vWO9u2LcpsTg4Y8px
 /VOxOlNa126LVjc1SVrR6ZZ7ivdqXBkFPWLuxJi9XU5zBlYFCqLCVwnOYUxLpdjMj4TQKptUT
 IIsKN98YRdKlOA7RN89F4jWmZb8Ota5Qnn2isZXj7XuGe4vTqU1VgDJUjLzthRuqL1xBm1SVj
 3kZKxQYjYMiF7999r9ZPrzdFYK3rI8+NMG7YGL54JUTmf86xH3ChdDfVfkfr5j+L7KqY2mDh5
 sJTNUFmlPog0L3TTIDUlg/1L87slibkyXBnnhNKqngzYRTWGpw2b94D0mss4vwZGO/Gn+lTke
 1jrpeSXNztYzIz0I9zhjNX44o9YrFDnrhEloysZefIJpTUbZ10C9oxu/Z60/iZFK9BhhTXh4e
 YDuwu3QwdbQi2rFbaBh3VpkySZP/pBlrIgRn5jQrmMK1DV2AiO/4kBWcf3szLuyF2yt3P9J7x
 jHG2BazGZVrenVyZkOpSMI4rOqfeteT+o4qaY8ElnrTtrpCYEHYzt6NVE42o/Zzok5jO5xSfG
 q3y9GfpveKCOzEL/3AqweopMmniFQyc2Vl/l+kB8UMGc+g0G8hvYUtVSlhRkm4VEfEvyzgtWw
 6jN7KIOJY3uomiJeRuNWyx5kCR937ydWRWL1Xqbd9QsacTkF777xa3xhdTScGhPVG8SwlzUKg
 X3JRdyAnmSp2g+uVHGdAqJpcScMVUdGH190hVvhSJBM4cEo5AydrQb9xVQW+y2qcvuPZ/b4XL
 Upa6piX0qnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 30 Nov 2018, Phillip Wood wrote:

> > diff --git a/sequencer.c b/sequencer.c
> > index 900899ef20..11692d0b98 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -4394,24 +4394,29 @@ int sequencer_make_script(FILE *out, int argc, const
> > char **argv,
> >  	return 0;
> >  }
> >  
> > -/*
> > - * Add commands after pick and (series of) squash/fixup commands
> > - * in the todo list.
> > - */
> > -int sequencer_add_exec_commands(const char *commands)
> > +static void todo_list_add_exec_commands(struct todo_list *todo_list,
> > +					struct string_list *commands)
> > {
> > -	const char *todo_file = rebase_path_todo();
> > -	struct todo_list todo_list = TODO_LIST_INIT;
> > -	struct strbuf *buf = &todo_list.buf;
> > -	size_t offset = 0, commands_len = strlen(commands);
> > -	int i, insert;
> > +	struct strbuf *buf = &todo_list->buf;
> > +	const char *old_buf = buf->buf;
> > +	size_t base_length = buf->len;
> > +	int i, insert, nr = 0, alloc = 0;
> > +	struct todo_item *items = NULL, *base_items = NULL;
> > 
> > -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> > -		return error(_("could not read '%s'."), todo_file);
> > +	for (i = 0; i < commands->nr; ++i) {
> > +		strbuf_addstr(buf, commands->items[i].string);
> > +		strbuf_addch(buf, '\n');
> > +	}
> 
> This could cause buf->buf to be reallocated in which case all the
> todo_list_item.arg pointers will be invalidated.

I guess it is a good time for me to admit that the `arg` idea was not my
best. Maybe it would be good to convert that from a pointer to an offset,
e.g. `size_t arg_offset_in_buf;`? Or maybe we should just drop the
`_in_buf` suffix and clarify in a comment next to the declaration of the
fields that they are offsets in the strbuf?

Ciao,
Dscho
