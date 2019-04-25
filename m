Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2795D1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 12:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfDYMIE (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 08:08:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51371 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDYMIE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 08:08:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so8958041wmf.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qIghhvzvTSxKv0OQmUzyu4X3td5H+IKraOR5H5DhZaQ=;
        b=busZIBQUxOaRFjXaYgpCAwnFcAe69JVnFM7ZzBI9lB1eYOGCGlfyhCRYISlAXtQfIo
         LBoe1B86e3BVfCkHflrR7VqD4zMTuLfxNzl0/gfYIIxNeJ20dBW5c04i3OIzaof0dMFY
         QMDbO+ffehT9Vyl0z7LoB7FONpVrgsmhaKbaMB7Mxnwxxcf/fyj8+s9GATZVuWQrhYoY
         hDeTTj1CRip8Ma7kVu4/Xov4Hr9BrfobNgEU6jSaDus1uFnVXW99Dh5NpckRJbtUjb/Z
         EnFwsfW+B0J6m5oyRThWJXWzO7e/dG2n9W53IfF3CYc3mtt4KcrCjSbpYVLfOhLgO99H
         pCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qIghhvzvTSxKv0OQmUzyu4X3td5H+IKraOR5H5DhZaQ=;
        b=aZUlmLHhLcfFJeZheN4nxEkzfjX7wN9GR1mT2rgfgzGZfmpd8zWhS/zzZlOHRqRIBo
         Gq4EyVHIu2sZvdp3DidFeNG5WL8n8ZY/WuoGQqVxel2ZcCW6yJuF1nr7XujTnkEi0Acc
         aQ/2EOq4WhWPrWZMOlUPXv8BQTjiD5nVN4SlV42Gij1FzMRBpyzUmhvoh4358CWcZujk
         VlUxzWrXufuPLgSdYxBQmrONGQ0RTdFHGb70QPf/7gtY6ihcav01eFSw4HdHtahYY8XJ
         QylEygIkUrHkTUDQQOAAQySNiWG5pnoholtV5km1p2zqKMTiM/+jzoHmYsV4n81ubOKz
         hWlA==
X-Gm-Message-State: APjAAAUizYwUbOHkD9L20maB7IQxWNveEbC+ey5JnoNeyZ88eC4tEFB/
        tjA6n0/vQHouaJy+JmWW9YU=
X-Google-Smtp-Source: APXvYqw6E3fPpWyRp7rn93S4j7LdFqM066h1LrVQnYYXea8Q/fiKHHsnmG4MnVLRspclTVN/LGIzcA==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr3156395wmf.56.1556194082183;
        Thu, 25 Apr 2019 05:08:02 -0700 (PDT)
Received: from szeder.dev (x4d0c3a97.dyn.telefonica.de. [77.12.58.151])
        by smtp.gmail.com with ESMTPSA id 13sm21234267wmf.23.2019.04.25.05.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 05:08:01 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:07:58 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190425120758.GD8695@szeder.dev>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422214901.GA14528@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 05:49:01PM -0400, Jeff King wrote:
> On Wed, Apr 17, 2019 at 12:58:31AM -0700, Denton Liu wrote:
 
> >  compat/mingw.c                    |   2 +-
> >  compat/mingw.h                    |   6 +-
> >  compat/nedmalloc/malloc.c.h       |   6 +-
> >  compat/obstack.h                  |  14 +-
> >  compat/poll/poll.h                |   2 +-
> >  compat/regex/regex.h              |  66 ++---
> >  compat/win32/pthread.h            |   8 +-
> 
> We sometimes avoid touching compat/ code for style issues because it's
> copied from elsewhere. And diverging from upstream is more evil than a
> pure style issue. So potentially we could drop these hunks (though I
> think maybe mingw is our own thing?).
> 
> >  contrib/coccinelle/noextern.cocci |   6 +
> 
> I have mixed feelings on this cocci script.

I have actual bad experience with this :)

v4 of this patch series excluded 'compat/' from the conversion, but
the semantic patch is applied to 'compat/' all the same, resulting in
failed CI builds because of the four 'extern's in 'compat/obstack.h',
and will continue to do so.

(Coccinelle has no issues with those other header files; I guess those
are not included in the '.c' source files we analyze with Coccinelle
in a stock Linux build environment).


> I'm happy to _see_ it, as
> it's important to show how the transformation was done. But for most of
> the other scripts, we expect programmers to introduce new cases that
> need converting, and we'd like to catch those automatically. Here I find
> it reasonably unlikely for a lot of "extern" to slip in, with the
> exception of some topics in flight.
> 
> And these coccinelle scripts are kind of expensive to run. So I wonder
> if the tradeoff is worth it here (perhaps it is now, as we catch those
> topics in flight, it might be worth dropping this one in a few months).
> 
> At any rate, thanks for doing all of this tedious work. :)
> 
> -Peff
