Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA3C120754
	for <e@80x24.org>; Wed,  4 Jan 2017 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936745AbdADRxw (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 12:53:52 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33316 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935793AbdADRxu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 12:53:50 -0500
Received: by mail-pg0-f48.google.com with SMTP id g1so190571581pgn.0
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 09:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cVd9RZaRv4R/H2zFaAlrArFA9WqwTHWdcr8GCzmvc8o=;
        b=KvifcU9yCo9R4HwzeomgZuu5Hhp+yEo2B4oxlq9mQa4rDTQGZxlQx5/JcmbECw6K7D
         4NPh59bIxZgL5dqpHdjaZN8YecbkFI0k2+SLPDscdj/QXx00IUY7TpgvvSR8zXoiwzCh
         4scPnNJIsjk9eFwxvFf5gGHNKg3ieYXGEHEzIKYHPkL6qWnN87ykkk8zQ08GeIzWGMhN
         lNgwv4zhsG9q0BJf9JUkLzoGZpdLPpmppwZ1qwub1FVJ6lcym47AhK7E4O2Kqn9DKgbK
         Mkh1GXTinZSmqCgN4iuQHyPtTzAOXaCsiRW9vC8QBzk0szTwMXkINqVs77tKWUXx/B5B
         spdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVd9RZaRv4R/H2zFaAlrArFA9WqwTHWdcr8GCzmvc8o=;
        b=Gy64ACHW6PLRd0IUsf5yqMVCvp2CUTBeB4s8sLZw854ttgFgN7zkbKdW9iD1X2oGQS
         OF5opPHkU9LURd4DH6c3lzkPD1OUVUH9f2UoYw9xjN+I5h1fo9KDJHa/pKW7FN3RgQp1
         Y36Fka38u1jV8SnOTojL1EWUpiCMlW9ApLvt+ZrOokNkxtyxU7KY9v+Nym+3yq8gFD4A
         GP3Q1x/URT0jcr6J9TYkQyZ5OkKNY0taBI+UE7prUB+XZ0zwGwWXCDjDEtUhymKvBv2T
         hMrS/VOvDUlgWDKirm87VnZxVEl/WKqfSrGFAv//x183CyiUCQ4hjfSHbP36nvgVWKWl
         uIlA==
X-Gm-Message-State: AIkVDXIFdsGdvzoBw+CrTXHlAkmFz3L8RZZhAB9IWDa/Ys7YVSKn6q8uYgvOPDi/g0iPjJVu
X-Received: by 10.84.194.129 with SMTP id h1mr109683009pld.169.1483552430004;
        Wed, 04 Jan 2017 09:53:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1930:3cb0:6c91:e070])
        by smtp.gmail.com with ESMTPSA id i124sm150029085pgd.15.2017.01.04.09.53.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 09:53:48 -0800 (PST)
Date:   Wed, 4 Jan 2017 09:53:47 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/16] pathspec cleanup
Message-ID: <20170104175347.GA69227@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
 <CACsJy8C=SC+gE1HQeGdE5z3+S8RHwiM-4ZXBzuwvN=+COUGNzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8C=SC+gE1HQeGdE5z3+S8RHwiM-4ZXBzuwvN=+COUGNzg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04, Duy Nguyen wrote:
> On Wed, Jan 4, 2017 at 1:42 AM, Brandon Williams <bmwill@google.com> wrote:
> > diff --git a/dir.c b/dir.c
> > index 15f7c9993..e8ddd7f8a 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1353,6 +1353,15 @@ static int simplify_away(const char *path, int pathlen,
> >  {
> >         int i;
> >
> > +       if (pathspec)
> > +               guard_pathspec(pathspec,
> > +                              pathspec_fromtop |
> > +                              pathspec_maxdepth |
> > +                              pathspec_literal |
> > +                              pathspec_glob |
> > +                              pathspec_icase |
> > +                              pathspec_exclude);
> 
> You have done some magic (or your MTA/editor did) to lower case
> GUARD_PATHSPEC and all the flags. The real patch looks good though, so
> no problem.

That's really odd, I was sure I just did a cut and paste.  I'll fix that
:)

> 
> > +
> >         if (!pathspec || !pathspec->nr)
> >                 return 0;
> 
> 
> Super tiny nit, if GUARD_PATHSPEC is placed after this line, then we
> don't have to check if pathspec is non-NULL. Probably not worth a
> re-roll unless somebody else finds something else.

I saw this after I sent out the series again, and I agree.  I'll move
the guard to be after this check.

> 
> >                 if (m->mnemonic)
> > -                       strbuf_addf(&sb, "'(%c)%s'", m->mnemonic, m->name);
> > +                       strbuf_addf(&sb, "'%s' (mnemonic: '%c')",
> > +                                   m->name, m->mnemonic);
> 
> .. and that somebody might be me :) we need to mark "mnemonic" for
> translation. Putting _() around the string would do.
> 
> Ideally I would give the translators the whole sentence so they can
> have good context (and good translation as a result). But since we
> potentially concatenate multiple unsupported magic in the string,
> there's no way to provide one (or a few) fixed string(s) at compile
> time. So let's just _() it and leave it at that.

Will do!

-- 
Brandon Williams
