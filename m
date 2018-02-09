Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 000821F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeBINrk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:47:40 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:47085 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbeBINrh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:47:37 -0500
Received: by mail-io0-f177.google.com with SMTP id f34so9664907ioi.13
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LH39K0H2PYnqmIFSVg3ugD6B1IhXsGI2/TAESVdtBeU=;
        b=qyAyzAityjpLR8DM7VapB+kKbX1Ck3B24ujFM/8AC+7wviLI5G8CyemRH52LLZqopi
         Modgk3DQiXKDjERQD8qcCWtsl48A58SAnZUYJi0wqwpCLrw1DchWBEwcb+OPvR6UUHrE
         ghElNsdriNcGOYIUkxm4F+bp0YyIG0UfeOFuprJKbaiRS1gzbC2mwuNnhZyOgqyWcYFq
         Di/Mjb7uHCmb59GCC8yXTtlxo/QzS6XaCrjo400mAKChdQl5/pKj2G7A4wIXkpWq4Hf6
         yAIwhrknjjI6z+vX7vpFY7INrVlXpOLIOxGMUUY63+3VMdhyAKlz8tIq/30OFLGasdmw
         VH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LH39K0H2PYnqmIFSVg3ugD6B1IhXsGI2/TAESVdtBeU=;
        b=TxdsAaaoQgC9ZLfiZzDlfoe1eVjYr9NOMEgVXti+iWx+BooCOWVYEIVtjQ75EwEQie
         UxDf+MWwo91gwuDHOb8tWNHrawXX+fOeL4ekB8ofy/sv2sZNAbyxM6DbObBwypzUKry6
         X7gUDK72EZfSUlY4oqsohAdZ+OUuUgb0WzO8PtKCVUjplIJDYc7/GgjcLKN4RZy+cH3N
         6SlcKrxIyX1bfBFf5hdpIqiMFsvRVWNSsTsQVW+QtUj3X5b5nnmf60QDLMbhzU/2S3g1
         f3uNaiZkaKIsCC5HFExrtkj08FBaP5g0bblNj/b+rJIP/aHc1A4SX74FkTm0MMnMEqQz
         FE+A==
X-Gm-Message-State: APf1xPC6gJY6VCGRJW/YnvZbcJhlHo0arq1a9wNbbkjP801LMUl1ZtZZ
        LB9+QMKYLjSI0/u2o104etZiKWS4QKSplRDVbZVAWQ==
X-Google-Smtp-Source: AH8x227dPzfaxHKzsH2ll0R5v4rg9UQ861WApwRvyCAoQqGVvp4uoT8ywQTo2S7ffjCNE4me7TAIf9ql6gk+IKwN/O0=
X-Received: by 10.107.59.77 with SMTP id i74mr2932303ioa.180.1518184056929;
 Fri, 09 Feb 2018 05:47:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.150.155 with HTTP; Fri, 9 Feb 2018 05:47:36 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802090817550.6248@android-a172fe96dd584b41>
References: <alpine.LFD.2.21.1802090817550.6248@android-a172fe96dd584b41>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 9 Feb 2018 14:47:36 +0100
Message-ID: <CAP8UFD2HGVQSnMrG4-eABv104Og1JBbUfTd7TvpP8sT30AXbEA@mail.gmail.com>
Subject: Re: "git bisect run make" adequate to locate first unbuildable commit?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 2:20 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   writing a short tutorial on "git bisect" and, all the details of
> special exit code 125 aside, if one wanted to locate the first
> unbuildable commit, would it be sufficient to just run?
>
>   $ git bisect run make
>
>   as i read it, make returns either 0, 1 or 2 so there doesn't appear
> to be any possibility of weirdness with clashing with a 125 exit code.
> am i overlooking some subtle detail here i should be aware of? thanks.

I think you are not overlooking anything.
