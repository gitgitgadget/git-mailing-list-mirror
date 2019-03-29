Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6794520248
	for <e@80x24.org>; Fri, 29 Mar 2019 20:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfC2UPq (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 16:15:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfC2UPp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 16:15:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so4081070wrd.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kczIPAqDQjkSS/pFpmQ6yG0YMF3pWRt0NyO1DrxyEzU=;
        b=BZ7YCOINko9X0oS4VGmNnAwhI74Uz2g2Lo3a6NDMXm73xX3tQDg+iDXVL5CecZeJDq
         2b9DHPaGaDzxNC/rwdv14JF3obQXEtiTG+lpN5ZrgWT8ywx4xBIFpZileIrDJmqS/7pj
         VYS2YzpBDD9gI5d6i0rkskv7n6cpbTD7yit3tlE/5D9ecPIZqWXlmQrmba1D9nApYglA
         mC1EoCjn4sDrWflbZ85R8rmdkNR1S1jVuM3E4ULoLpn/r4crMLIGVoFFskDQ9OdIAHUz
         4OsitsXkiy6iSqXv9KWZizSinX60Y99alb2fdDFRfS2nadXh/tfQejF+B0vIUp9rBj8H
         2JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kczIPAqDQjkSS/pFpmQ6yG0YMF3pWRt0NyO1DrxyEzU=;
        b=Fz2DPn99FY2nOOiptRAttmKJsOpizvD6Syn5ilH+H/RVOsuhQAByio8yPELURttjvN
         fOs48aKRhn23WVHrP16EiK2jNzqji0T02i6WmP/eaRupD9xW8b0hUo82BrW0Bo5F6517
         DIR8XPiqIxEQdfssDC+dJqCGIEBX0+3yfyRz/e/G0iql00v29TPCv6E6CWgjzhRCG5Ax
         NhxuOJAoP+D4cR6dD8MEeROMSMxaFnEwI5eNYEOpBPnvxHwv1ZMWzj43He60okYyW8Ts
         773Twvkz/Mief6RtlQJOsKA0RfAWQApkqEymGRm/onL0l+UXi+jV7SeUKBJer3lAsu3C
         H1bg==
X-Gm-Message-State: APjAAAXEwYIqQNPd2qIDIdv+K/0b/P5aUwGHcCmVzC/2r0VPkiRGllqi
        kNNhs63bdjk7nb5H0lZgz2I=
X-Google-Smtp-Source: APXvYqzoOmXGZh0l920P+Wu4elAVEbTo1dqYspLnqKve3c/ZeIM5dFfCcF9dpusgH0oUVO5ppntVdg==
X-Received: by 2002:adf:b601:: with SMTP id f1mr16498185wre.158.1553890544005;
        Fri, 29 Mar 2019 13:15:44 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id j64sm4392643wmb.36.2019.03.29.13.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 13:15:42 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:15:41 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        kernel-usp@googlegroups.com,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at
 .git/objects/
Message-ID: <20190329201541.GP32487@hank.intra.tgummerer.com>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-3-matheus.bernardino@usp.br>
 <20190328221049.GK32487@hank.intra.tgummerer.com>
 <87sgv69itl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgv69itl.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 28 2019, Thomas Gummerer wrote:
> > I notice that we are currently not using 'linkat()' anywhere else in
> > our codebase.  It looks like it has been introduced in POSIX.1-2008,
> > which sounds fairly recent by git's standards.  So I wonder if this is
> > really supported on all platforms that git is being built on.
> >
> > I also wonder what would need to be done on Windows if we were to
> > introduce this.  I see we define the 'link()' function in
> > 'compat/mingw.c' for that currently, so I guess something similar
> > would be needed for 'linkat()'.  I added Dscho to Cc for Windows
> > expertise.
> 
> For better of worse this particular quest started because I pointed out
> (with some WIP patches) that for understanding this change we should
> test whatever we did now, to ensure that the refactoring didn't have
> unintended side-effects.
> 
> But that's a separate question from whether or not we want to keep the
> current behavior.
> 
> I think the current behavior is clearly insane, so I think we should
> change it with some follow-up patches. In particular options like
> --dissociate should clearly (in my mind at least) have behavior similar
> to "cp -L", and --local should hardlink to the *target* of the symlink,
> if anything, at least for objects/{??,pack,info}

Right, I definitely agree with all of that.  Adding tests for the
current behaviour is definitely a good thing if we can do it in a sane
way.  And I also agree that the current behaviour is insane, and
should be fixed, but that may not want to be part of this patch
series.

> I think that changes the portability story with linkat(), since it's not
> something we should be planning to keep, just an intermediate step so we
> don't have a gigantic patch that both adds tests, refactors and changes
> the behavior.

Fair enough, but that also means that this patch series necessarily
has to introduce the changes in behaviour as well as switching clone
to use dir-iterator.  Of course we could say that the switch-over to
using dir-iterator could be done as a separate patch series, but that
seems a bit too much of a change in scope of this series.

Now I think Matheus has actually found a nice solution to this issue
using 'strbuf_readlink()', which gives us the same behaviour as using
'linkat()' in this patch would give us, so this might not be that big
an issue in the end.
