Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2410B207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 16:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966476AbcIWQQV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 12:16:21 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36162 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965898AbcIWQQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 12:16:20 -0400
Received: by mail-wm0-f42.google.com with SMTP id w84so40839743wmg.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vr4j7sxW35U5KK4L3oWPASEV640KD3XlRlFPfZexz0A=;
        b=e5Jn/VcEecVultwhRJowuOjBF+yH/bnXWKvRrqogFktHmQw7gIDkZKNvaSb3pkIqKq
         fQ0gh1wEBB40n9YaAa71gPmpAZUxU8ohW0GNqS+kL12gNjSz+r4tpZBy+rh1P38MrspW
         u3WlTE6vg/E+tmNvJ48vwmA1zhhNslI0cjJbnBBP7c2N58I3mb3NJlPPZAwC96wjIwj4
         78IPGmS09kASP3Znhn7rWygxh+EgEFBMqHJgOk4/Tudzsjz91sZIAnDADcHtHDvn0Yc7
         E4Fu6JwG1df7CMmTvd/A6rPuo3tXPHKLBB2Z4cj3ICyUgEEaNJeon7d4Wr9N7HCOq268
         TRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vr4j7sxW35U5KK4L3oWPASEV640KD3XlRlFPfZexz0A=;
        b=VG4qbZoBiA068CPXwzFRUsL/113ydBD6uzd8IM6mMp1Y/4P3f7ycSL6CjebS/kJlVV
         du6ex7rrLrp+l6fLiwOtVAQx5/5hQGMZGLvFToEgNWorJ870P4tmgra6eIRkACSjMwTc
         9ClDf8dKMDsXKJvETJ0riXzuG9pNF/vzoQv0sv3bTjOoV3IJ333jwRlelZvi4xQFlFuK
         FAWdXqaIp6PaILKPLYZd/sbLRI3f3kj+oieBhI8rnsnJhps73aq39cCAvywcN4WvD8o3
         A01/J13z0DmR7Z5aQB3oGx+v3O+JDXKgFKReLsTi1JpAXZaCUKeTao6zFFoQBuDSvqUT
         NN5Q==
X-Gm-Message-State: AA6/9RntXQHiT3Iw0L35K7qp63uSzk1sXU5alTE+a+ZPVO+/KbVkcBaWF3lK438eqH5TCYZwV5443fTuoJEp5JnG
X-Received: by 10.194.149.102 with SMTP id tz6mr7494137wjb.154.1474647378575;
 Fri, 23 Sep 2016 09:16:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Fri, 23 Sep 2016 09:16:18 -0700 (PDT)
In-Reply-To: <20160923060643.3ubr5gn7qczzs2ut@sigill.intra.peff.net>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com> <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com> <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
 <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com> <20160923034113.4rnps3nogvzxkfjx@sigill.intra.peff.net>
 <CAGZ79kZ+LTd5PuT4+Z9K6d+GQ-33E=tLY1Fokbp22uNoygaEtg@mail.gmail.com> <20160923060643.3ubr5gn7qczzs2ut@sigill.intra.peff.net>
From:   Brandon Williams <bmwill@google.com>
Date:   Fri, 23 Sep 2016 09:16:18 -0700
Message-ID: <CAKoko1p+M3X_y+DH+65fUDRZjkiZrKE3Z-jjq=RSjqoi7He8pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yeah, a positive "I support this" flag would at least let us correctly
> flag errors, which is the best we can do. That won't work for
> non-builtins, but perhaps it is good enough in practice.
>
> -Peff


So it sounds like we agree that this prefix option should be pushed to
the top level.
The question is have we come to a consensus on what we should be
calling the option?
Leave it as submodule-prefix or do we need to come up with a different name?

-Brandon
