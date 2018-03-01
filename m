Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68AC81F404
	for <e@80x24.org>; Thu,  1 Mar 2018 19:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161185AbeCATQe (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 14:16:34 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:40877 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161165AbeCATQd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 14:16:33 -0500
Received: by mail-pl0-f50.google.com with SMTP id i6-v6so4205919plt.7
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 11:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TMDWu/Ius/HGC3ZG9Ra65STi8pVWVa8UBWoGiD+7jUU=;
        b=tZbzqzwRx3Zbdu4BQepmviA1n8Fj95o036ovtBe+houZz6oKvUacB1b7miSSKtp/oY
         CMeXbo0hRo2aykz8xj7QpJa5Yp0G03LhfZFCwMgx22n9SEqUuUxfTMovHYMtZk/VJxd3
         x364NYzCx6ugxfrw1jMWsQt5nJ0E4lM72NQo2kuSS0HR0QkWX9pgb5ZDKx6poV7kyMol
         eYRAl2mQBJn4Eauwl5CS5SI4VNtRtZsBsMK56cn/Am9e3MPsRS0FhYr6Mi43UIZ0LFpO
         NJp/Zr+qCNPeiqjWb8uN4tYBXB3O8C+4QKYvh1fbtHW4Eb+e2uOMARjL2Os73UNpsNmN
         9kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMDWu/Ius/HGC3ZG9Ra65STi8pVWVa8UBWoGiD+7jUU=;
        b=L59e1IF9mP35UV4CeQ9FeniU1VucDsH6oF8EYIaou+KieLw0aCJHsefimy+GXAANyy
         PIoK02ejACR0drv1PeGmgpDzNc4qwws4T4cQ5UMlLLA+KEN6FjzQpZn2fWmI/84tffaz
         b4qIgAGYK8bgGygMNgTet/H174yye5BcgAYUSmbiHsUCQebkQsbRvpFW+YXzc9817y5e
         mAXyuJU+yp3Ub5iulchBeyRsOjldigyVmaNDMM96vmZBdz7xPd2chkZfUrwgA6vNCwLU
         D6VPuiwVU3Sy6Vv0ZhjG00luKtXTrofmlC+qY3adUfOcves4OEzCRitYkq1jRqYoEFMO
         wa8w==
X-Gm-Message-State: APf1xPDDvS7Khrnp5dO0VxZ8uBCxxgjiGii44yJZ/25WyhG5jemU0kLZ
        OmyeYqGCqB6Os0R4smA+qg57CRpcdCY=
X-Google-Smtp-Source: AG47ELuuSrzw5kU5cuVSzpKTPCgt34rdJWE3AIf5wUbEpe8jcHEZ08Zbyo4rKaEiyRf09PYGyDEv1A==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2-v6mr2806513plt.368.1519931792215;
        Thu, 01 Mar 2018 11:16:32 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id n10sm9545703pff.131.2018.03.01.11.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 11:16:31 -0800 (PST)
Date:   Thu, 1 Mar 2018 11:16:29 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 00/35] protocol version 2
Message-ID: <20180301191629.GA241240@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <xmqqlgfbhc4t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgfbhc4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Lots of changes since v3 (well more than between v2 and v3).  Thanks for
> > all of the reviews on the last round, the series is getting more
> > polished.
> >
> >  * Eliminated the "# service" line from the response from an HTTP
> >    server.  This means that the response to a v2 request is exactly the
> >    same regardless of which transport you use!  Docs for this have been
> >    added as well.
> >  * Changed how ref-patterns work with the `ls-refs` command.  Instead of
> >    using wildmatch all patterns must either match exactly or they can
> >    contain a single '*' character at the end to mean that the prefix
> >    must match.  Docs for this have also been added.
> >  * Lots of updates to the docs.  Including documenting the
> >    `stateless-connect` remote-helper command used by remote-curl to
> >    handle the http transport.
> >  * Fixed a number of bugs with the `fetch` command, one of which didn't
> >    use objects from configured alternates.
> 
> I noticed that this round is built on top of v2.16.0-rc0.  It
> certainly makes it easier to compare against the previous round
> which was built on top of that old commit and it is very much
> appreciated that a reroll does not involve pointless rebases.
> 
> For those who are helping from sidelines, it may be ehlpful to
> mention where in the history this was developed on, though, as
> applying these on the current 'master' has a handful of small
> conflicts.
> 
> Thanks, will replace and will comment on individual patches as
> needed.

I've tried to keep building on the same base that I started with when
sending out a new version of series, mostly because I thought it was
easier to see what was different between rounds.

I can, in the future, try to remember to put the commit its based on.
Do we have any sort of guidance about the best practice here?

-- 
Brandon Williams
