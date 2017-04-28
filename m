Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C281FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 10:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035736AbdD1KlQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 06:41:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:54386 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033907AbdD1KlO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 06:41:14 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfTVx-1dsWQQ2GMr-00p15c; Fri, 28
 Apr 2017 12:41:03 +0200
Date:   Fri, 28 Apr 2017 12:41:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
In-Reply-To: <6cc5670f-2de3-33f2-3c85-5a6d99fcca12@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704281206500.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de> <6cc5670f-2de3-33f2-3c85-5a6d99fcca12@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TZzFDaXdlLTB50uW0mbphxX6kJiLNwH23fi99uytfPZg7N6wW0P
 LIts1vvdogs0NJavgqMsQm3/HFY02re+HZOeLmuJwMM27LDDszQS9+zV8zushjsueXd4C6U
 1Ww4rR39erw8SOnsTOW1TqzwNFI7qiJYwW+S6IqzwoeP5cMSlzM5HTzAYj9quKz3qYdg8jH
 5jU2QCWqF42D53rmM8HEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NbvrWW+HUb8=:tp/v9pa8pGKTGUar54jJQf
 rFvQYUYUrur3MtLbdbnypnUpmoSTFDqaq5hF4AAzTciAHbm5AY2i+DYKiMMt81x3kZGL8lPYS
 KRRPV3kGDQkKhNkwiE62diUykqQPgwuWZxXtUAugOYpccv98Jq72DDKMzWoMxgPTh21g9wUbm
 YqU28CFzD9bT/wkIox//rx5+S+oAr/YW9axr03Bd83Ohkc0NdeLptNhkV2L6zduwBHQggNBj5
 zmCRCXMddnY7+FiXGxXV6FCCjA5j2LrlNUNI6NDEkqWWMKj1SGTYZdWL0hIfX0QwBnw9Qs/aG
 8K0X6K47/E1mDl09IxhxH0UMDZa2jZ4XkC2jIVoigpJBmC9GgDm83VfHITt/7awRHmablrDdR
 AWa+BOYtsqrlhZ6WFBtdV3PYhOxUByVnE6rfYYLcFzi7CB3lWsDzju7nQBunUFO4+ISOe++xq
 dnDsgkIvOmF+K58lHY2FV/A7FGFFxDpk8YIrA2+8BZ+Hm9rqUt6y0NTlrRT+E3GZQaWvzFcWK
 By0KRjuqHB6erv3TEKo3I+dshC78ecoZXKG/bySMxHOXqExqa+4/rzQmSLfGoSEb22E2zq9bf
 Fe0tagzLJwbZrgX4QRzKyVCWThlnU066FmHGnJksS2wH1JnQANtyE0DCFx3lR1CrIM+agkB/I
 rvCpmrwjtDd3HQdY1ZpkNbojUd6GvDwsRZ4eF/eAySj9B7zzb3gLz8m0GS2SJ243XDvKOGSGl
 xaipmuK++uZ3f5vPklhWRhCk6p0Q/kSDoiwmk4RwZrA22N2JneIFin+OSs30dihviTBnbcZjD
 RHYCfwd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 27 Apr 2017, Johannes Sixt wrote:

> Am 26.04.2017 um 22:20 schrieb Johannes Schindelin:
>
> > diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> > index 30681681c13..c0d88f97512 100644
> > --- a/builtin/mailsplit.c
> > +++ b/builtin/mailsplit.c
> > @@ -232,7 +232,7 @@ static int split_mbox(const char *file, const char *dir,
> > int allow_bare,
> >
> >   do {
> > 		peek = fgetc(f);
> > -	} while (isspace(peek));
> > +	} while (peek >= 0 && isspace(peek));
> >   ungetc(peek, f);
> >
> > 	if (strbuf_getwholeline(&buf, f, '\n')) {
> > diff --git a/mailinfo.c b/mailinfo.c
> > index 68037758f2f..60dcad7b714 100644
> > --- a/mailinfo.c
> > +++ b/mailinfo.c
> > @@ -1099,7 +1099,7 @@ int mailinfo(struct mailinfo *mi, const char *msg,
> > const char *patch)
> >
> >   do {
> > 		peek = fgetc(mi->input);
> > -	} while (isspace(peek));
> > +	} while (peek >= 0 && isspace(peek));
> >   ungetc(peek, mi->input);
> >
> >   /* process the email header */
> >
> 
> Why? isspace(EOF) is well-defined.

So let's look at the man page on Linux:

	These functions check whether c,  which  must  have  the  value  of  an
	unsigned char or EOF, [...]

That is the only mention of it. I find it highly unobvious whether EOF
should be treated as a space or not. So let's look at the MSDN page
(https://msdn.microsoft.com/en-us/library/y13z34da.aspx) whether they talk
more about EOF:

	The behavior of isspace and _isspace_l is undefined if c is not
	EOF or in the range 0 through 0xFF, inclusive.

That's it. So I kind of *guess* that EOF is treated as not being a
whitespace character (why does this make me think of politics now? Focus,
Johannes, focus...). But the mathematician in me protests: why would we
be able to decide the character class of a character that does not exist?

Technically, you are correct, of course. The specs of fgetc() specify
quite clearly that either an unsigned char cast to an int is returned, or
EOF on end-of-file *or error*. And a quick test verifies that isspace(EOF)
returns 0.

But then, I guess I misunderstood what Coverity complained about: maybe
the problem was not so much the isspace() call but that EOF is not being
handled correctly. We pass it, unchecked, to ungetc().

It appears that I (or Coverity, if you will), missed another instance
where we simply passed EOF unchecked to ungetc().

The next iteration will have it completely reworked: I no longer guard the
isspace() behind an `!= EOF` check, but rather handle an early EOF as I
think it should be handled. Extra eyes very welcome (this is the fixup!
patch):

-- snip --
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index c0d88f97512..9b3efc8e987 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -232,8 +232,9 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 
 	do {
 		peek = fgetc(f);
-	} while (peek >= 0 && isspace(peek));
-	ungetc(peek, f);
+	} while (isspace(peek));
+	if (peek != EOF)
+		ungetc(peek, f);
 
 	if (strbuf_getwholeline(&buf, f, '\n')) {
 		/* empty stdin is OK */
diff --git a/mailinfo.c b/mailinfo.c
index 60dcad7b714..a319911b510 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -882,7 +882,10 @@ static int read_one_header_line(struct strbuf *line, FILE *in)
 	for (;;) {
 		int peek;
 
-		peek = fgetc(in); ungetc(peek, in);
+		peek = fgetc(in);
+		if (peek == EOF)
+			break;
+		ungetc(peek, in);
 		if (peek != ' ' && peek != '\t')
 			break;
 		if (strbuf_getline_lf(&continuation, in))
@@ -1094,14 +1097,18 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		return -1;
 	}
 
-	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
-	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
-
 	do {
 		peek = fgetc(mi->input);
-	} while (peek >= 0 && isspace(peek));
+		if (peek == EOF) {
+			fclose(cmitmsg);
+			return error("empty patch: '%s'", patch);
+		}
+	} while (isspace(peek));
 	ungetc(peek, mi->input);
 
+	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
+	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
+
 	/* process the email header */
 	while (read_one_header_line(&line, mi->input))
 		check_header(mi, &line, mi->p_hdr_data, 1);
-- snap --

In the first hunk, I simply rely on the code after ungetc() to figure out
that there are no headers and to handle that case as before.

The second hunk handles the case where looking for a continuation line in
the header section hits EOF; it is still a valid header, but we should
avoid ungetc(EOF) to allow the next read to report EOF correctly.

The third hunk moves the malloc()s around so that we can complain about an
empty patch, close the file and return an error value without leaking
memory.

Ciao,
Dscho
