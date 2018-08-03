Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1CB1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 00:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeHCCYA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 22:24:00 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33240 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHCCYA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 22:24:00 -0400
Received: by mail-yw1-f65.google.com with SMTP id c135-v6so342873ywa.0
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKsXNF/4fIWnPnAgE7Lh7sRpVqjyYYKcMIAy7N1RnuU=;
        b=DkzXLxNKGejej58kVpH7WmCKbAHHOhNrZusjgH7slzLuzl6RG8/yJt4fGBAfrzzhsg
         34UO4y6xw2LxmDnGpCeAdXHmJJIQ9hh7PLiR/6XMD5DhtAxutdowoAogdQOEePNcrJnt
         9UCJXmip7msv5mGbosHowBHRsA30bYxSYXKvqdlA4vVw21G76u0ETjJI/I4VIT/Jikn7
         hDEN3ye4+Imp7ookysG1nFjnFKFG7DGwPfGciatoWOTNHIHTfG7piVBGcFtR0+ZUFzu4
         yYTlOjZuko+mHomE8K59jQ3pmUjiHeRUVWnJ/cu3j3vWeN4mdkYvf3YJSSKIJnnv8nGA
         dIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKsXNF/4fIWnPnAgE7Lh7sRpVqjyYYKcMIAy7N1RnuU=;
        b=IA5kahFzu22lZoJVnttMtXypMRPtdNXzRyFxA2+Mucu//AfQGW4AA8LQghJB78bTXF
         7RUW80zAPqP9/sKWh3FlTG3I8W5/zYo7HuzIQ12uBpf0DQLSRpz0VGdprqREFs8263dI
         +NLG0gE/70by0djZt9aWH16iYo3OWE+RweKeXL52PJf195ghm7H/f8IIlFeO2jqTcKqV
         isxTT1jheUch/gDYStNYvOskeR76Ff5KB86nc5yk+7jOJ/Eid1PECUVtXsKOlPTItOMy
         3W2WWtytzCPdXCvhrf/2dXMApw0dm7u7JuK2161ORY2rtofI9NAR1tuzeYaN6UZYTbj2
         /AVg==
X-Gm-Message-State: AOUpUlGBWX+EsG8BbgSGq4bf100WsYrT2Tz2pmRsYo3YmJvUt4MGOZg3
        BbRsqjypF3a42hPRuzPmQZwB3YQjPr1zzK2TvryOww==
X-Google-Smtp-Source: AAOMgpfiOOGoAqnccPHuBmUDeSmw3E5NvdgaWN9VFAnFbWz8qlvyTVaHy06zPplJFrnRPZjG3AL8DaOKl4bh/3OGPFQ=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr952949ywk.345.1533256221834;
 Thu, 02 Aug 2018 17:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com> <20180801193413.146994-1-sbeller@google.com>
 <20180801193413.146994-3-sbeller@google.com> <xmqqva8t4s63.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva8t4s63.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 17:30:10 -0700
Message-ID: <CAGZ79kbeUHVQmfTFkoGEM617iVa_3mCsLjpYGoEebqxNKAM_xA@mail.gmail.com>
Subject: Re: [PATCH 2/3] config: fix case sensitive subsection names on writing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        peff <peff@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 3:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > A use reported a submodule issue regarding strange case indentation
> > issues, but it could be boiled down to the following test case:
>
> Perhaps
>
> s/use/user/
> s/case indentation issues/section mix-up/

will be fixed in a reroll

>
> > ... However we do not have a test for writing out config correctly with
> > case sensitive subsection names, which is why this went unnoticed in
> > 6ae996f2acf (git_config_set: make use of the config parser's event
> > stream, 2018-04-09)
>
> s/unnoticed in \(.*04-09)\)/unnoticed when \1 broke it./
>
> This is why I asked if the patch is a "FIX" for an issue introduced
> by the cited commit.

I did not check further down the history if it was a recent brakage.

> >  static int get_base_var(struct strbuf *name)
> >  {
> > +     cf->section_name_old_dot_style = 1;
> >       for (;;) {
> >               int c = get_next_char();
> >               if (cf->eof)
>
> OK, let me rephrase.  The basic parse structure is that
>
>  * upon seeing '[', we call get_base_var(), which stuffs the
>    "section" (including subsection, if exists) in the strbuf.
>
>  * get_base_var() upon seeing a space after "[section ", calls
>    get_extended_base_var().  This space can never exist in an
>    old-style three-level names, where it is spelled as
>    "[section.subsection]".  This space cannot exist in two-level
>    names, either.  The closing ']' is eaten by this function before
>    it returns.
>
>  * get_extended_base_var() grabs the "double quoted" subsection name
>    and eats the closing ']' before it returns.
>
> So you set the new bit (section_name_old_dot_style) at the beginning
> of get_base_var(), i.e. declare that you assume we are reading old
> style, but upon entering get_extended_base_var(), unset it, because
> now you know we are parsing a modern style three-level name(s).
>
> Feels quite sensible way to keep track of old/new styles.
>
> When parsing two-level names, old-style bit is set, which we may
> need to be careful, thoguh.

I considered setting it only when seeing the dot, but then we'd have
to make sure it is properly initialized.

And *technically* the two level is old style, so I figured it's ok.

> > -                     !strncasecmp(cf->var.buf, store->key, store->baselen);
> > +                     !cmpfn(cf->var.buf, store->key, store->baselen);
>
> OK.  Section names should still be case insensitive (only the case
> sensitivity of subsection names is special), but presumably that's
> already normalized by the caller so we do not have to worry when we
> use strncmp()?  Can we add a test to demonstrate that it works
> correctly?

That was already demonstrated (but not tested) in
https://public-inbox.org/git/20180730230443.74416-4-sbeller@google.com/
