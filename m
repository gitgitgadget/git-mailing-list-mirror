Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38F9C208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeHFTw0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:52:26 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:40201 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbeHFTwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:52:25 -0400
Received: by mail-it0-f42.google.com with SMTP id h23-v6so19292313ita.5
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ycCPf9Sa/Hgjb/LrDoKHtTDAPtfDLSrwd2UxM4/Kurk=;
        b=f2qgemkW5c+zZbLSjL8FglSsC7Tl3gT4a1U99AoEpz6nwrq1KaBq+0z0HhhOZUcds+
         TAd6eFrdIc30sscICQJ3HsmiJfyxEJSup6vurDePXqHzt4LvA5AHdJMdYimadr8brpav
         yDLvRWujQq6vv7vR8R4lLyUyBykKwwoIhf+JzQdHoUc9zLsMfhiRwRr10TEuc94RKUXR
         22z7BA9W5h6k1mlArp71ekovhMAVKHLsoP3fpNbFYtD6VHasqyM8AODAt4JJ51KFzaMQ
         L2GSYCmvjMP3KEwEKT/NlNkAt6JiZ3ROSInC324fgC5+7SvVOp+Vj2F3w6Xks3+DDq7d
         D29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ycCPf9Sa/Hgjb/LrDoKHtTDAPtfDLSrwd2UxM4/Kurk=;
        b=niZvkPrkMvMwGryArTXrtFTw40HlS8IZy3291MxLh2g35mbc8ra+eljD3BBwF+fvSz
         Tam9pQHLzla7pFxNkLaljFmhyvWxfzLhkpMADRVXFw7wBVRfRkHiXTVT16OQx4cdZzBK
         pLUzvYAINZZG/9yDNvKQQKUSoNRrqaMv+ZY56o+eqg77uwEwWxJ/6bLq0gHnTFtyVqOz
         B7yu3f8ODvViTnidabKWVLStaFy6vWq8X5M2dyqyMKK/eZSWTBkzUKB0CMzz3IdEFTTd
         7hOIB8IqeVwyzyzrKJRauOP4n+fIzm37+WKr+iEV5nWP9NTUvhV6XdmOXd7xqpdzkO1p
         61Rg==
X-Gm-Message-State: AOUpUlG+kyyqixLuFprgwJsVygE0LQYEuqvnUAi0uVgi0AOElS7gjn4w
        oOOAusb/SqCJuoCUnCUrlAwe7V9Qg0/hxnm+x8H2qg==
X-Google-Smtp-Source: AAOMgpdIBovEudoWpDjywzu5uhVVHsrTrWDpwoLW1pY9TaievQ1fkwwME+hqIHNSrrb3JFTwQFTOfo6cjJa8+PVb/OM=
X-Received: by 2002:a24:374d:: with SMTP id r74-v6mr15314304itr.57.1533577336518;
 Mon, 06 Aug 2018 10:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180806143313.104495-1-hanwen@google.com> <20180806143313.104495-3-hanwen@google.com>
 <xmqqbmafpg14.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbmafpg14.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 6 Aug 2018 19:42:05 +0200
Message-ID: <CAFQ2z_Nrj5WhzYsxr6P5qLJ3pDVFzB4UDb9g4P-5U99wrAuB0w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sideband: highlight keywords in remote sideband output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrn@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 7:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > The Git push process itself prints lots of non-actionable messages
> > (eg. bandwidth statistics, object counters for different phases of the
> > process), which obscures actionable error messages that servers may
>
> s/which obscures/which obscure/, as I think that "which" refers to
> "messages" above.
>
Done.

> > The highlighting is done on the client rather than server side, so
> > servers don't have to grow capabilities to understand terminal escape
> > codes and terminal state. It also consistent with the current state
> > where Git is control of the local display (eg. prefixing messages with
> > "remote: ").
>
> Yup.
>
> When we introduce "the receiving end asks messages to be sent with
> such and such decoration" protocol support, we would want a lot more
> than just painting messages in color, e.g. i18n, verbosity, and even
> "Hey, I am a script, send them in json".
>
> Until that happens, let's keep things simpler.  No i18n messages and
> no colored output over the wire.

Ack.

>
> > +color.remote::
> > +     If set, keywords at the start of the line are highlighted. The
> > +     keywords are "error", "warning", "hint" and "success", and are
> > +     matched case-insensitively. Maybe set to `always`, `false` (or
> > +     `never`) or `auto` (or `true`). If unset, then the value of
> > +     `color.ui` is used (`auto` by default).
>
> Reads much better.
>
> I am still trying to find a concise way to help readers who saw a
> line that begins with "Warnings: foo bar bla" and accept that it is
> OK the early 7 chars are not painted.  "... case-insensitively and
> honoring word boundary" is the best I came up so far, but  I am
> afraid that is adding more words without hinting what I want to convey
> strongly enough, so I am not going to suggest that (at least not yet).

I would suggest that the phrase "keyword" implies a tokenization, so
I'd leave as is.

> > +     for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {
> > +             strbuf_reset(&sb);
> > +             strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
>
> This design means future enhancement to allow more keywords will
> have to be done in the form of adding more "color.remote.<key>",
> which means a few restrictions on them are cast in stone at the
> end-user facing design level, which we need to be careful about.
>
>         Side note. I do not worry about the implementation level
>         limitation at all.  For example, the current code will not
>         allow end-users and projects to add new keywords to be
>         painted, as it relies on the keywords[] static array we can
>         see above.  But that implementation detail does not prevent
>         us from improving it later to support more code in this
>         codepath that notices "color.remote.failure" in config file
>         and paint a line that begins with "failure:".
>
> Because the third-level "variable" name is case insensive, matching
> of any future keyword MUST be also done case insensitively.
>
> Also, as you mentioned elsewhere in this patch, the string that can
> be in the keyword MUST begin with an alphabetic and consists only of
> alphanumeric or dash.
>
> I do not think these limitations imposed by the design decision this
> patch is making are particularly bad ones---we just need to be aware
> of and firm about them.  When somebody else comes in the future and
> wants to recognize "F A I L" as a custom keyword case sensitively,
> we must be able to comfortably say "no" to it.
>
>         Side note. We _could_ instead use "remotemsg.<key>.color"
>         namespace, as the subsection names at the second level is a
>         lot looser, but I do not think it is a good idea to use in
>         this application, as they are case sensitive.
>
> The above discussion may deserve to be in the log message as a
> record to tell future ourselves why we decided to use
> color.remote.<key>.

I added a note about case insensitivity.

> > +             if (git_config_get_string(sb.buf, &value))
> > +                     continue;
> > +             if (color_parse(value, keywords[i].color))
> > +                     die(_("config value %s is not a color: %s"), sb.b=
uf, value);
>
> That's a bit inconsistent, isn't it?  If the configuration is not
> even a string, we ignore it and continue, but if it is a string, we
> insist that it names a color and otherwise die?

Done; added test.

> > + * Optionally highlight one keyword in remote output if it appears at =
the start
> > + * of the line. This should be called for a single line only, which mu=
st be
> > + * passed as the first N characters of the SRC array.
> > + */
>
> Saying "MUST be" is cheap, but do we have anybody who polices that
> requirement?

rephrased.

> I think the code is OK without any assert() or BUG(), and that is
> because the design is "we just paint the keyword at the beginning of
> what the other side of the sideband wants us to show as a single
> unit".  If the other side sends a payload with an embedded LF in a
> single packet, that's their choice and we are free not to paint the
> beginning of the second line after that LF.  So from that point of
> view, perhaps we shouldn't even talk about "a single line only".

I don't understand this remark. Isn't the call to strpbrk() meant to
split the input on line endings?

> >  #define ANSI_SUFFIX "\033[K"
> > -#define DUMB_SUFFIX "        "
> > +#define DUMB_SUFFIX "             "
> >
>
> Was this change intended and if so for what purpose?  I can drop
> this hunk if this is a mere finger-slip without proofreading, but I
> do not want to do so without making sure I am not missing anything
> and not discarding a meaningful change.

This was my poor use of the tabify function. It would be nice if this
were more explicit though, maybe using a format string of

  sprintf(.. , "%*s", 8, "");

but we can leave that for another time.

> Noticing the dash in "<<-", I would have expected all of the above
> lines to be indented with a tab to align with 'w' in 'write_script'.

Done.

> > +     chmod +x .git/hooks/update &&
>
> No need for this "chmod +x"; that's one of the points in using
> write_script.

Done.

--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
