Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27B920A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 20:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeLJUk7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 15:40:59 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:36300 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeLJUk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 15:40:59 -0500
Received: by mail-ed1-f54.google.com with SMTP id f23so10685048edb.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZVd4mWb0GcyYMuq5bNmcHZ4g69OPAm0Pah95cyusHE=;
        b=cyaNh42R15kupYfm3tFDyMmp+z9pS4NMneLiolyeDvdt+dNZtPIRUe1nOhnk+lsAr4
         FHlEWiYRM1Zm/Kex5KwlURf5hC9pyGQEwW0/AAEv+WWbD4KAsF8IJz+B8fjxatvtDC+6
         kGvquzTfGOcQeuZLrDR+U6FEypbXIuwBaaf5+xdLP4CKdQxRO9sJo7gd1gwL7BbpefEM
         aXjlq8bPNhswndZivl0BWU5TalXfheqT2k6JFt/ybtYCguYnG7zsgfqAwy59LzsZJKBd
         TwPFXnWMdkIhX/S96byYGRw2XeHrsg/P0JTlqJveDLqGCuEf+OS5+jUydBhT/D+KoYIs
         p6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZVd4mWb0GcyYMuq5bNmcHZ4g69OPAm0Pah95cyusHE=;
        b=HCJSGzhzO3+opWbQmlFvU0BO8XnTnXy5F9V2OudEmBDH/+WqoJoYZZeyRBS8EYy9ze
         dppZtDyljqfjoDUnVwqOim1GeV+r6qJVAF6u4lofNJdWajGd18gKF6Tn+oJDpT2Cb6mH
         PS83TZTOyqRKaqPh4Mcuho4luWWRTmWgE7nFZKHHJQGZE67TjqKALnB56Ahn+E8fcwbU
         qHNN5nCumrfz/3G3q7hSCtYZNDBkuA5buBNh3jG9vu8NOJTO9+u2qq7tukYNWz8rVv8O
         MP4TeAo49RV6FzmGjJhxzFADAGCYFPFkB98bTfptuGN8p3tkhoyd8OMxRz2Wk5yydsM7
         0SYw==
X-Gm-Message-State: AA+aEWbg4B2Jt41rWuTfbzj1o1uA/rXzVUWZ3f/aV6mIprT2SOWb5VLZ
        Uypi5o9NCGl7xpG76HWKLcbwhCJOaTWdGURotVVSoOoH5aQ=
X-Google-Smtp-Source: AFSGD/X66CrMb2c2LAmji56C3/jLgtN89hP1k3Xu3zr8sPEjMc159WMEm0qAQO1xQikgNB63m2dM8JJsKhuU+qWGO2o=
X-Received: by 2002:a17:906:e287:: with SMTP id gg7-v6mr10807050ejb.128.1544474457341;
 Mon, 10 Dec 2018 12:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20181208154539.GH4633@hopa.kiewit.dartmouth.edu>
In-Reply-To: <20181208154539.GH4633@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 12:40:46 -0800
Message-ID: <CAGZ79kY+F776YfNBrx3wk3ffv4sqqabM5iJxbQDiPE6xoio69w@mail.gmail.com>
Subject: Re: [wishlist] submodule.update config
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 8, 2018 at 7:45 AM Yaroslav Halchenko <yoh@onerussian.com> wrote:

> I wondered, if you think it would be sensible to also add of
> submodule.update which would be considered before submodule.SUBMODULE.update
> variable possibly defined per submodule.  That would be more inline with desire
> to use any of the --merge, --rebase (and hopefully soon --reset-hard)
> strategies specified as an option for submodule update, where no per-submodule
> handling  is happening.
>
> Thanks in advance for the consideration!

So you are proposing a variable like submodule.update
without the .<name>. that would apply to any submodule?

The precedence in descending order of these
configs that modify the behavior of "git submodule update"
would be:

* the command line flag (--merge/--rebase/--checkout)
* submodule specific instructions (submodule.<name>.update)
* generic submodule config (the new submodule.update)
* default as --checkout

I first hesitated in thinking this would be a good addition,
as there is no plumbing command for submodules,
to easily modify submodules irrespective of the user
config. But that is out already with the submodule
specific update configs.
So I think it may be a good addition.

I wonder if we'd be better off to re-invent the UX instead
of hiding your intentions in a config setting for a command
that is already long to type. What about

  git submodule merge
  git submodule rebase
  git submodule checkout
  git submodule reset (--hard)

as aliases for
  git submodule update (...)
