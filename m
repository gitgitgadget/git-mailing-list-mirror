Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61354208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbeHFQ1L (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:27:11 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33094 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbeHFQ1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:27:10 -0400
Received: by mail-io0-f180.google.com with SMTP id z20-v6so11185031iol.0
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3BrD8bmJrHsnuMgYST5qoAec0yYPeufT8SOLdHFtUYk=;
        b=YRFJywyjkg3KBFZHHd4SFXTl5eSxDusX9P2fSeCjW76wJBtmmlYB+pg8ZjTxljEZMf
         m19F0kXiAQq++POILNr1OCf9Xagrpyn3S4wpnCKovaJKmIALkWFYC5HcCExucxfuQWHk
         6tUDCafjdYQ/jW0C1yfFB56m6mtSqVXb10u4BaQlMmKK+mw+RuY/pA6KSvKr4z374k+n
         vHFfh4h+cfKkFZk96NAykRFPp9dMQYAiDh3SbkP6gh4BE5aCsQst7a3UsQTgSxSpRid2
         k9epBFPhg9J35Bn3A4IE5PE/vsxFna8I9Rr6q1x1UcMEWFUMSzcHvDR4S5PLuNax5ihQ
         IMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3BrD8bmJrHsnuMgYST5qoAec0yYPeufT8SOLdHFtUYk=;
        b=p7RCg8Q0ccjeklO/uMB0ryszCECw6TXoTMMd0PGue1cK8RuA/vs26ZkjRdheO0X5TV
         Lday8CwzSrrImXihYO0aHW97ssSCSmUDv/YOln/Gdpme0odsfCdYMJLVev47F0GnH0Fd
         xr/muX4sQ3r0kB2bP+BaddE2Odqyb7v8hArx0UgAvEcaiatSRIHLsQF5Fy5TTz6XrlY8
         qjpc0G6Kz0Yv0mTx7vLdCunjCCIVRGY4mCybbHHPEmwZa2Oxz6G4xL+ckNkm6hVNRNhs
         F5Gr6qR9WPxE2p0fPGmlOYKmFbX21RkKtwQ3OZky1idZE/C+j9MXllZ1Yy9gpkjDaGim
         ZKiA==
X-Gm-Message-State: AOUpUlFc6rNNs6dETD2C/t1VLM4FRco9GngVLrcT1wB6WcvZ3s8RPUgE
        kWQWkKk4vksjQzsWBcjh369lAZUrwsw9OzI+57I7Aw==
X-Google-Smtp-Source: AA+uWPzZ7qUXtPwp1WnrPa5Gctjp0btoPYlokl8vNvcGezJSqsxI2rTKKO5k+B1jU1ZJEt0qBfkP222il/RAlmHs53E=
X-Received: by 2002:a6b:7e0a:: with SMTP id i10-v6mr14961616iom.16.1533565070845;
 Mon, 06 Aug 2018 07:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180802121308.17371-1-hanwen@google.com> <20180802121308.17371-3-hanwen@google.com>
 <20180803035243.GH197924@aiede.svl.corp.google.com>
In-Reply-To: <20180803035243.GH197924@aiede.svl.corp.google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 6 Aug 2018 16:17:39 +0200
Message-ID: <CAFQ2z_PfvGgiwWeDbhiBt77s+z7qWzqCMXXZT0EjFNZKx+WUMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sideband: highlight keywords in remote sideband output
To:     jrnieder@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 5:52 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Han-Wen Nienhuys wrote:
>
> > The colorization is controlled with the config setting "color.remote".
> >
> > Supported keywords are "error", "warning", "hint" and "success". They
> > are highlighted if they appear at the start of the line, which is
> > common in error messages, eg.
> >
> >    ERROR: commit is missing Change-Id
>
> A few questions:
>
> - should this be documented somewhere in Documentation/technical/*protoco=
l*?
>   That way, server implementors can know to take advantage of it.

The protocol docs seem to work on a much different level. Maybe there
should be a "best practices" document or similar?

> - how does this interact with (future) internationalization of server
>   messages?  If my server knows that the client speaks French, should
>   they send "ERROR:" anyway and rely on the client to translate it?
>   Or are we deferring that question to a later day?

It doesn't, and we are deferring that question.

> [...]
> > The Git push process itself prints lots of non-actionable messages
> > (eg. bandwidth statistics, object counters for different phases of the
> > process), and my hypothesis is that these obscure the actionable error
> > messages that our server sends back. Highlighting keywords in the
> > draws more attention to actionable messages.
>
> I'd be interested in ways to minimize Git's contribution to this as
> well.  E.g. can we make more use of \r to make client-produced progress
> messages take less screen real estate?  Should some of the servers
> involved (e.g., Gerrit) do so as well?

Yes, I'm interested in this too, but I fear it would veer into a
territory that is prone to bikeshedding.

Gerrit should definitely also send less noise.

> > Finally, this solution is backwards compatible: many servers already
> > prefix their messages with "error", and they will benefit from this
> > change without requiring a server update.
>
> Yes, this seems like a compelling reason to follow this approach.
>
> [...]
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -1229,6 +1229,15 @@ color.push::
> >  color.push.error::
> >       Use customized color for push errors.
> >
> > +color.remote::
> > +     A boolean to enable/disable colored remote output. If unset,
> > +     then the value of `color.ui` is used (`auto` by default).
> > +
> > +color.remote.<slot>::
> > +     Use customized color for each remote keywords. `<slot>` may be
> > +     `hint`, `warning`, `success` or `error` which match the
> > +     corresponding keyword.
>
> What positions in a remote message are matched?  If a server prints a
> message about something being discouraged because it is error-prone,
> would the "error" in error-prone turn red?

yes, if it happened to occur after a line-break.

We could decide that we will only highlight

  <sp*><keyword>':' rest of line

or

  <sp*><keyword>'\n'

that would work for the Gerrit case, and would be useful forcing
function to uniformize remote error messages.

> > +struct kwtable {
>
> nit: perhaps kwtable_entry?

done.

> > +/*
> > + * Optionally highlight some keywords in remote output if they appear =
at the
> > + * start of the line. This should be called for a single line only.
> > + */
> > +void maybe_colorize_sideband(struct strbuf *dest, const char *src, int=
 n)
>
> Can this be static?

Done.

> What does 'n' represent?  Can the comment say?  (Or if it's the length
> of src, can it be renamed to srclen?)

Added comment.

> Super-pedantic nit: even if there are multiple special words at the
> start, this will only highlight one. :)  So it could say something
> like "Optionally check if the first word on the line is a keyword and
> highlight it if so."

Super pedantic answer: if people care about it that much, they can
read the 20 lines of code below :-)

> > +{
> > +     int i;
> > +     if (!want_color_stderr(use_sideband_colors())) {
>
> nit: whitespace damage (you can check for this with "git show --check").
> There's a bit more elsewhere.

ran tabify on whole file.

> > +     for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {
> > +             struct kwtable* p =3D keywords + i;
>
> nit: * should attach to the variable, C-style.

Done.

> You can use "make style" to do some automatic formatting (though this
> is a bit experimental, so do double-check the results).

sad panda:

hanwen@han-wen:~/vc/git$ make style
git clang-format --style file --diff --extensions c,h
Traceback (most recent call last):
  File "/usr/bin/git-clang-format", line 580, in <module>
    main()
  File "/usr/bin/git-clang-format", line 62, in main
    config =3D load_git_config()
  File "/usr/bin/git-clang-format", line 195, in load_git_config
    name, value =3D entry.split('\n', 1)
ValueError: need more than 1 value to unpack
Makefile:2663: recipe for target 'style' failed
make: *** [style] Error 1

> [...]
> > @@ -48,8 +145,10 @@ int recv_sideband(const char *me, int in_stream, in=
t out)
> >               len--;
> >               switch (band) {
> >               case 3:
> > -                     strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" =
: "",
> > -                                 DISPLAY_PREFIX, buf + 1);
> > +                     strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : =
"",
> > +                                 DISPLAY_PREFIX);
> > +                     maybe_colorize_sideband(&outbuf, buf + 1, len);
> > +
> >                       retval =3D SIDEBAND_REMOTE_ERROR;
> >                       break;
> >               case 2:
> > @@ -69,20 +168,22 @@ int recv_sideband(const char *me, int in_stream, i=
nt out)
> >                               if (!outbuf.len)
> >                                       strbuf_addstr(&outbuf, DISPLAY_PR=
EFIX);
> >                               if (linelen > 0) {
> > -                                     strbuf_addf(&outbuf, "%.*s%s%c",
> > -                                                 linelen, b, suffix, *=
brk);
> > -                             } else {
> > -                                     strbuf_addch(&outbuf, *brk);
> > +                                     maybe_colorize_sideband(&outbuf, =
b, linelen);
> > +                                     strbuf_addstr(&outbuf, suffix);
> >                               }
> > +
> > +                             strbuf_addch(&outbuf, *brk);
> >                               xwrite(2, outbuf.buf, outbuf.len);
>
> Nice.  This looks cleaner than what was there before, which is always
> a good sign.
>
> [...]
> > --- /dev/null
> > +++ b/t/t5409-colorize-remote-messages.sh
>
> Thanks for these.  It may make sense to have a test with some leading
> whitespace as well.

Done.

> > +     chmod +x .git/hooks/update &&
>
> Please use write_script for this, since on esoteric platforms it picks
> an appropriate shell.

> If you use <<-\EOF instead of <<EOF, that has two advantages:
> - it lets you indent the script
> - it saves the reviewer from having to look for $ escapes inside the
>   script body

Done (#TIL).

> > +     echo 1 >file &&
> > +     git add file &&
> > +     git commit -m 1 &&
>
> This can use test_commit.  See t/README for details.

Done.

--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
