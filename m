Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71299208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeHFQP4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:15:56 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51771 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeHFQPz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:15:55 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so17576722itf.1
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NTRu6jqqTrcFzZWBl0P9J8wf1tRp5A0jGb6X4JmIBSA=;
        b=t58kkM8GHy4V7iv/uwZWOk5dJtRQIBwLG2suNOF+Ld/gPstbWJyFwHszwR4MmDO3RJ
         WMy6c4cGuKDwznCp+Nb6cIbojfckGExg2xrhD9ffCw8/YJQP26a4SgBAPMey0UoCT0ji
         cNjhlEioujrA9BfnvRuuL4Fs5HbTlMkOyR3bGEt7g67+kL4awjiGyic2zlMj4chEeAwB
         kMrGUZHZbxG9GGJiay56YKCHxBWowx76E4d3Ju4m0lJcZWE/BnHDzALiby7SibMGcsHx
         bqh5kAXeGnx3PWK0oOZEgT31q85tGhIfLbbYkJl1jjsYrFIsYqPIZnh4k0hcBuDBJvNu
         VoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NTRu6jqqTrcFzZWBl0P9J8wf1tRp5A0jGb6X4JmIBSA=;
        b=UZJdQNQe2MhC20j7QU9NVi8XKODJtjdWoD0pwMuFlGhUUFjIyQ9UqrkigH2CBClgCH
         ETgJXoORW6ntbqAD+4jaEVRHsUxVrZ+vTLWzmfAwuB6LOPyueu3IyoWWEdwSYeDaC0qz
         sII8p4bsQFoY7+7RC4tFOCdo7yAKUbkBrNLasAi9W06JpnceM7BydTWQV/9C087uLkWb
         n2VnxczcnanIto1WmfzCklXf0v7BO/zXo5nqvGdlZXAWuLa9EFqY7MMaGXpjsYHujcFB
         27x8DaDaZRr2hhF54C80d4vUfJmJJKtkgFPHrYUuNVOdItkM0O1hbkOmIkVhE4gbGYPO
         z+cg==
X-Gm-Message-State: AOUpUlFjJHsgEh0MrjIzpZZZd5sKORASWXBdTnF5ItKnHsDL1TMkoaKc
        fsgCE8IU3qlA7rSUUaTEItIw47SS7v3M7LJSKgfmAqWD4XYgPQ==
X-Google-Smtp-Source: AAOMgpcFMsP2aBgtW3jxgzfJJfY757bc36AxquQrLGs7GwblKgFx6F/QrOw3Nc+W24FNYnNvDYytOsQd/VLA+CntsQo=
X-Received: by 2002:a24:282:: with SMTP id 124-v6mr15283242itu.151.1533564384150;
 Mon, 06 Aug 2018 07:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180802114753.9715-1-hanwen@google.com> <20180802114753.9715-3-hanwen@google.com>
 <xmqqpnz01vdr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnz01vdr.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 6 Aug 2018 16:06:12 +0200
Message-ID: <CAFQ2z_OnUHcJSryq7vTdkvBuna64y0Q3+C+NX7o4_tFwSqjcDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sideband: highlight keywords in remote sideband output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 8:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Helped-by: Duy Nguyen <pclouds@gmail.com>
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  Documentation/config.txt            |   9 +++
> >  help.c                              |   1 +
> >  help.h                              |   1 +
> >  sideband.c                          | 119 +++++++++++++++++++++++++---
> >  t/t5409-colorize-remote-messages.sh |  47 +++++++++++
> >  5 files changed, 168 insertions(+), 9 deletions(-)
> >  create mode 100644 t/t5409-colorize-remote-messages.sh
>
> I'll "chmod +x" while queuing.
>
Done.

> If your "make test" did not catch this as an error, then we may need
> to fix t/Makefile, as it is supposed to run test-lint.

I've been running tests individually as

 sh t5409-colorize-remote-messages.sh  -v -d

> > +color.remote::
> > +     A boolean to enable/disable colored remote output. If unset,
> > +     then the value of `color.ui` is used (`auto` by default).
>
> Nobody tells the end-users what "colored remote output" does;
> arguably they can find it out themselves by enabling the feature and
> observing remote messages, but that is not user friendly.

expanded doc.

> > +color.remote.<slot>::
> > +     Use customized color for each remote keywords. `<slot>` may be
>
> Isn't 'each' a singular, i.e. "for each remote keyword"?  If so I do
> not mind dropping 's' myself while queuing.

Done.

>
> > +     `hint`, `warning`, `success` or `error` which match the
> > +     corresponding keyword.
>
> We need to say that keywords are painted case insensitively
> somewhere in the doc.  Either do that here, or in the updated
> description of `color.remote`---I am not sure which one results in
> more readable text offhand.

Done.

> > +void maybe_colorize_sideband(struct strbuf *dest, const char *src, int=
 n)
> > +{
> > +     int i;
>
> In a block with a dozen more more lines, it is easier to have a
> blank line between decls and the first statement, i.e. here.

Done.

> > +     if (!want_color_stderr(use_sideband_colors())) {
>
> The above line is indented with SP followed by HT; don't.

Fixed. It would be great if there were a pre-commit hook that I could
install to prevent this from ever getting committed.


> > +             struct kwtable* p =3D keywords + i;
>
>         struct kwtable *p =3D keywords + i;

Done.

> > +             int len =3D strlen(p->keyword);
> > +                /*
> > +                 * Match case insensitively, so we colorize output fro=
m existing
> > +                 * servers regardless of the case that they use for th=
eir
> > +                 * messages. We only highlight the word precisely, so
> > +                 * "successful" stays uncolored.
> > +                 */
>
> Indent with tabs, not a run of spaces, i.e.

Done.

> Use write_script, i.e. instead of all the above, say

Done.


> Our tests are not written to demonstrate that our code works as
> written.  It is to protect our code from getting broken by others
> who may not share vision of the original author.  Make sure that you
> cast what you care about in stone, e.g. include "echo ERROR: bad" or
> something in the above to ensure that future updates to the code
> will not turn the match into a case sensitive one without breaking
> the test suite.

Add some more cases.

> > +     echo 1 >file &&
> > +     git add file &&
> > +     git commit -m 1 &&
> > +     git clone . child &&
> > +     cd child &&
> > +     echo 2 > file &&
> > +     git commit -a -m 2
>
> Don't chdir the whole testing environment like this.  Depending on
> the success and failure in the middle of the above &&-chain, the
> next test will start at an unexpected place, which is bad.
>
> Instead, do something like
>
>         git clone . child &&
>         echo 2 >child/file &&
>         git -C child commit -a -m 2
>
> or
>
Done.

> > +test_expect_success 'push' '
> > +     git -c color.remote=3Dalways push -f origin HEAD:refs/heads/newbr=
anch 2>output &&
> > +     test_decode_color <output >decoded &&
> > +     grep "<BOLD;RED>error<RESET>:" decoded &&
> > +     grep "<YELLOW>hint<RESET>:" decoded &&
> > +     grep "<BOLD;GREEN>success<RESET>:" decoded &&
> > +     grep "<BOLD;YELLOW>warning<RESET>:" decoded &&
> > +     grep "prefixerror: error" decoded
>
> A comment before this test (which covers both of these two) that
> explains why many "grep" invocations are necessary, instead of a
> comparison with a single multi-line expected result file.  I am
> guessing that it is *not* because you cannot rely on the order of
> these lines coming out from the update hook, but because the remote
> output have lines other than what is given by the update hook and
> we cannot afford to write them in the expected result file.

Comparing exact outputs is IMO an antipattern in general. It makes the
test more fragile than they need to be. (what if we change the
"remote: " prefix to something else for example?).

If using a golden output, the second test would either require a
repetitive, too long golden file, or it would use loose greps anyway.

Added a comment.

--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
