Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AF820229
	for <e@80x24.org>; Sat, 22 Oct 2016 00:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935782AbcJVAGF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 20:06:05 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33484 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935534AbcJVAGF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 20:06:05 -0400
Received: by mail-qk0-f176.google.com with SMTP id n189so174586230qke.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5jht9hBK9NwpkTQKqpwL1nmuxZ8Owu4PUlaozbf8LEU=;
        b=ZpmhXjqHxZHH87mWC0ZBY+enKqijpM3ONbpYtpR8jD5lMMZ9NohqB63dcOeTgg3DVU
         v66sUgnEYUoDOqzBJkUhlibWOS6hIkjExiaSMarYgDbbiTObDaG7TxN8fvLTTImlMYG9
         aMb2sbbKTOFGWt+liV6PJZ7sYr2U7JlKTYnoyUO/vkLwJqK9IkpJQMVL0OgsyitZCa5A
         k5q7yOmFThAF7pkJevl6Vhzn/hH9w91DfugJEGILGOonHTmPotzhcWEJmvLIKLF74arw
         HDTKaR+0Z87Ez+72xinnJBQAT7uEz3TtkSNek+Van1Kt/wbsjXzBBL3u0kRCfdt8hnpN
         Y+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5jht9hBK9NwpkTQKqpwL1nmuxZ8Owu4PUlaozbf8LEU=;
        b=N5tqUExhWN8+YKOTHLuWKbJNMPyqz96K4LexeCjBfjPSF3tHjDApp/rFljcQCkn8TC
         vE7j4pEGYIxV55q2pN8tLY/ZMM+p+sKLEgc0ePRN4AyEaXRt7lYmjgp8Sq5wx+9ENZXc
         cj/fBhRWUhWUZVLs68hNF0ActM6DhhwTvOV2R/QFzhcWgKMfvVdhPY+QZpbWwlOiiU3/
         qaV0X+zVyYHfHUzOntFEJlIr+O29nCdKZ49iXwvD7UT9Ceq14B3zZwgwr0BuYkaXILs/
         3Pr4umhTl7quUznHnr7H1J7OhXu4wYLusnd67VprNxzHJPAOiQS/6/Izcqazs7XbUkpW
         lgnQ==
X-Gm-Message-State: ABUngvdQxTwOazdWezfH6IaWvoPl8wrg7NPTtYRKRvcdfIv3JvvLG83KDGgxdaWr/RD5trzp3SSuoBwwuk/QEjs3
X-Received: by 10.55.64.80 with SMTP id n77mr4331600qka.173.1477094763954;
 Fri, 21 Oct 2016 17:06:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 21 Oct 2016 17:06:03 -0700 (PDT)
In-Reply-To: <CAPc5daX-bdSBAxy60zG2ZuGbrjGwRcsvHFktCqKw_o2QuuWTEg@mail.gmail.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1477072247.git.jonathantanmy@google.com> <CAPc5daX-bdSBAxy60zG2ZuGbrjGwRcsvHFktCqKw_o2QuuWTEg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 21 Oct 2016 17:06:03 -0700
Message-ID: <CAGZ79kbjoNTJUX=UBh4JCgBgA5qOiTz-OdxP3QFZndVZiPHaMw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] allow non-trailers and multiple-line trailers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 4:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Fri, Oct 21, 2016 at 10:54 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>> I've updated patch 5/8 to use strcspn and to pass in the list of
>> separators, meaning that we no longer accept '=' in file input (and also
>> updated its commit message accordingly).
>
> Thanks for a pleasant read. Queued.
>
> Hopefully this is ready for 'next' now.

I also just read through and was about to say the same.
