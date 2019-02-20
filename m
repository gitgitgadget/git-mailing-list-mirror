Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1706D1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 02:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfBTCTf (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 21:19:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54472 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfBTCTf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 21:19:35 -0500
Received: by mail-it1-f193.google.com with SMTP id f10so11649878ita.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 18:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2kp3GQlL4w50wxqBFXH5G+zHstR8hj1UFPrA3KqJ7g=;
        b=CFk2a5brY+1j+HmdByFwOs0S2v40oU84I5dJkFNtELO91RmzkDWWDPn5G7YhRFe20b
         PAR1Feu63LRvzXr/Ka3o5ekqJjonLnBq0ZKjxVw67hBBKDri0nS5nAaAjoPJlLxfVjpH
         m/3c5pLoT9qCNyEkZLl77uvTZOqfnWcu3SZMycnPa7vPMlOniGpnlQF56Zf2EZjUWNuQ
         fbaWfVjuy8WOlZzHy6SKDpHdV4AeQkAFzyYWGUxTuGJsCyhCzXjLJA4EEpiu/Don0gPF
         96Ta7hRHbamRLNtwu5lzzprQqZTFhGZ8plde6ND/hNBeenl7GqJJZaR84ZgVdYYtNDhJ
         Lpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2kp3GQlL4w50wxqBFXH5G+zHstR8hj1UFPrA3KqJ7g=;
        b=QpeAOSyHeSbkyEJis68clvPhnWmAMl8DFAlUJwTwtAuyhbr7c+wlMps/NTKZIEBCyN
         bZJM6fqY/bB3MCB17oyQE6oPcmz1xKu8cfxsQkJP9qJKzS0P9Si3u+rjTCSetyefOglO
         /FO8Mlq6MBqJJxJOltMkcPOd15d5QhzY1683M2bvMuBjDoTBFhAJlMOqngA0rrMZHHuH
         JZ2P7Oa7cy8DoSFEc0ckKImbU3RvF/ViGZikfJvLkGHad47dBfr2JL5cYrJLDWBMYT+p
         5kSfjrJ9ktHS/jWp73wQAc3d8dAt0h6rh7U2gX6PbvbK9lTMrqQDTpJpErChwZQQIl5U
         loHg==
X-Gm-Message-State: AHQUAuauDIUvkC+kseqJdqf/PgG1jlZ++px3dX1CiKUDtKJkF/tJFNDM
        mYlDV2F2IIud7fpA55EmN/Jb6PzxPWjQ4SZ9yLU=
X-Google-Smtp-Source: AHgI3IZ+Nku63+S+XFmxOW8kzu+yuqNG8IkT5LDt91xb0DRXsRO1aAwPFQXVXDR4HnRHrEV3p6nMtN3n/04O5D7588U=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr4025151itf.123.1550629174026;
 Tue, 19 Feb 2019 18:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
 <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com> <xmqqo9771tnj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9771tnj.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 09:19:07 +0700
Message-ID: <CACsJy8AMXkkpJjR5hB2PH7ZyRyyjU2goQx7k7AsQogpzu95QKw@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 2:10 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I am getting the impression that to save typing, you would want to
> > make "--index --worktree" the default (i.e. among the above, only
> > --no-index and --no-worktree need to be spelled explicitly), but
> > there is one glitch.  Updating from the index must be spelled
> > explicitly with "--no-index --worktree".
>
> And after getting reminded by Elijah, the default pair is
> <--no-index, --worktree>.
>
> > So perhaps the defaulting rule for the "--index" option must become
> > a bit more tricky.  Perhaps the rules are:
> >
> >  * --worktree is the default; --no-worktree can be given from the
> >    command line to countermand it, and --worktree can be given from
> >    the command line to be more explicit.

I originally went with that (--no-worktree to negate default
settings), but after updating docs to use "git restore" it's just too
much to write. My current rules are

 - default is --worktree
 - as soon as any of --[no-]worktree or --[no-]index is specified, the
above line is void. There is no default, what you specify is what you
get.

While it's a bit more twisted than spelling out --no-worktree to
countermand the default, i think it's more natural to think and write
it: ok i'm going to need to restore this and that so I write --this
and --that. Going with --no-worktree you need to think "i need to
write this and that and counter the default which is that other
thing". We essentially have two modes, the default mode and explicit
mode. Too bad?

> >  * when --source <tree> is given from the command line, --index is
> >    the default, and --no-index can be given to countermand it.
>
> Correction.
>
>     * when --source <tree> is given, --no-index is the default, but
>       --index can be given to countermand it.
>
> >
> >  * when --source <tree> is not given from the command line,
> >    --no-index is the only sensible choice.  It can be given from the
> >    command line to be more explicit, but giving --index to
> >    countermand the --no-index default would be an error, as updating
> >    the index, whether the same update also goes to the working tree,
> >    must come from a --source <tree>.
>
> This is still correct.

So I guess I scratch the default source for "--index --no-worktree"
(or just --index in my rules above) then? It does make sense to
default restoring the index from HEAD. And it makes "git status"
suggestion to unstage a bit shorter ("git restore --index <paths>"
instead of "git restore --source=HEAD --index <paths>")
-- 
Duy
