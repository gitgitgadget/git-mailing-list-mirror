Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9611F461
	for <e@80x24.org>; Thu, 22 Aug 2019 21:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbfHVVMz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 17:12:55 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:43477 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfHVVMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 17:12:55 -0400
Received: by mail-vs1-f52.google.com with SMTP id s5so4830650vsi.10
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jyCD//F3r9KwIVSl6tL4LotUhOR41kReu9Z5XD3em0=;
        b=lP9DBZkpb7BrzGye0a9Z9pCDDyEaPmNa1m839ohwY3uWSScyVDJEAP0jlcgZs2r8FN
         AbBkCj6mLkbmKakw5weNayTcXcgUVCNquHngilu8yRL9vbumwSbSn4yuOCiOBQcKXqlS
         LAz8HGRkFDPz9RpUNPMfTIGGSknhXn4rF/UfJWIR3OrR9bCaIIRARmnEgZ5HN/D1AHp6
         Xnq/DDY6NZd9FeR4AxGeMAvTOsagk9oZ/AYA/3x00nGhZXp51MJX5+vxqpyuDgU835of
         F8mTMsVeNg4rrCSC3RAMg47ElS8dd68J7rvBS5hH/6V8CfudE84VXzW4COHvyfqtxXgA
         ZWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jyCD//F3r9KwIVSl6tL4LotUhOR41kReu9Z5XD3em0=;
        b=E2LC4zGsWVhZqVHCgH94lDvbMUFpOswfAzQPfWNKbd/Dpqk06ohRnFGaMR82LxCvsg
         8pK/yZdua+dBxtG96bJ1K6YlByLeXDgj9ul67B3VaWty/lL2qWpRpCNQ5BkGA0gkfXDu
         tu2TLc/VV3mBY8YKR72/6uCv72URf2GkANuNffgajAHuWQpW63YKl6lpl3ExmK0jKwnj
         MgB4FxjggWdROpDTHOCeubr4DW4ti+8VMgqWupYp/tGCgUG6CrBJ+8POa5vEBN6SrPCG
         WpcZVw+SNyzE7zrkGLnBOcWBc+AQIUgX+Q2y8ww5vh0tT7jRflz2+P1yYRDUqRF5Tp5K
         IApQ==
X-Gm-Message-State: APjAAAUAzBL4+cPHtUNRx6F1e7Cew+pz8yZzCJUS2WHSAGas1G3kHQk/
        5s7jZWOPCq7/j/Hz7lDNzuxbUK/RSnVLz8zM2lQ=
X-Google-Smtp-Source: APXvYqyabbKAFC5zloEbM6LSCDFtUKIAkf7c2dLBxadcWdtnBKPkecSzAPfOGTCGAjFkdc+LMCO0IwgV5RJwRGaUctw=
X-Received: by 2002:a67:d099:: with SMTP id s25mr779710vsi.175.1566508374332;
 Thu, 22 Aug 2019 14:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com>
 <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 22 Aug 2019 14:12:42 -0700
Message-ID: <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com>
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 1:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Questions, comments, or concerns with this proposal?  Alternative
> > proposals?  If inclusion is acceptable, are there any other tasks that
> > need to be completed first?
>
> I do not want a discussion to begin with a Devil's Advocate
> response, but anyway...
>
> Are we planning to go to all batteries included approach?  I have a
> feeling that there are other tools (hello, "git imerge") that
> equally deserve attention by Git users; are we in the business of
> absorbing them all?  How big a project will our tree become, and how
> much more activity would have to be haneld by the readership of the
> Git mailing list?
>
> I'd rather see us shed non-core tools we already have (e.g. git-svn,
> cvs import/export) out of git.git and have them as independent
> projects.  But that may be just me.

Ooh, if you're going to open this door, then a proposal I assumed
would be shot down but which I'd be just about as happy with is:

  * Remove git-filter-branch from git.git.  Mention in the release
notes where people can go to get it.[1]

filter-branch is not merely a slow or difficult-to-use tool, it's one
that *fosters* mistakes by making it hard to get things right in
several different ways.  Granted, people exercise extra caution using
filter-branch because they know they need to, but there are so many
gotchas that they're likely to accidentally mess something up.  Those
mess-ups are not always discovered immediately, and by then it's
nearly cast into stone (rewriting being something you want to do very
rarely).

For as long as git-filter-branch is part of git.git and other tools
are outside, people will take that as a strong endorsement from us for
filter-branch and use it regardless of how much other education
exists...and that causes problems.


Thoughts?

Elijah


[1] We'd still have to decide where to put it.  If no one else wants
to do it, I could include it in git-filter-repo with the promise that
it's there for backward compatibility for those that still need the
tool, even if I recommend folks use filter-repo instead.
