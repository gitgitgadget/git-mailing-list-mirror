Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31F31F404
	for <e@80x24.org>; Sat, 21 Apr 2018 04:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750793AbeDUEX1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 00:23:27 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36818 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeDUEX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 00:23:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18-v6so348034wrg.3
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 21:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LhxIJ7eGfzIOcGLjer8GsWK4qLZEMnqLwkFQiRl7yEU=;
        b=Zm6gFJpC/UvjwuAM/i15+X93xb9FDSsOaIinY9+F5lP4sN3QwVH5+aBbPRp96hHG5b
         UtD0pzzb2KZAn8r6kTC7ga+GsGeUc7ObvQOm2wMbfqhIVN+17kQDx/RKexP8GxWCZa9q
         VBDODOcEidjblWy9NfjhiqfUxe0dqhgRT/z0CUw+KlUg7RiFK/vdmjJ+t+rDzDVgeUYp
         xcIX8NRTefmuzslpzL2Ci9NF+bmuDQ0ioGTAyvaFQ1Cb8I9+CqZANrP9MIpkPt0tyA8y
         /2UoqDyVr5c/KPncZrZ820CNANCX/Iq5AZHdSwBeYEEoNsbfTtwes8hGooLGurowTe6J
         y+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LhxIJ7eGfzIOcGLjer8GsWK4qLZEMnqLwkFQiRl7yEU=;
        b=SjrnwN97nuVeQiiaruYu2iUsAkUQ0XZZjr3eyJeL/DlXxKLrYw+o/V0NF3a/8aS8S4
         gNA3chlVelpYBTHGmOt06yt+5zvIjaA/jVJ7JLcIlojx8eqsVD2P2ydEeZEv20pFIZyp
         d16DA0/gBHix/eF2vPja7FLC9opLMJnSPL9rDcvO1F/yyP5dKp8vY+mZ4zHentiXrIzM
         E22ztDvSO5g+WKKkVArvof8AdUGSnBjSHmp0xq9N5Im2ywrJouotijSuBOJFyAKU24SW
         NoSPy33IVCusa+mksk5ZGiav7G6fTpeuTSm6R7NSPTe+0BF4/KHccoWKnAtWkCklOp91
         1sMg==
X-Gm-Message-State: ALQs6tA1RDGD5TTu6Nf7r/Yhep+H8o4uYnjdnzh+jf93Xd9AsUtUWooz
        AA2L6UMH2jENEkUeYFRGmtI=
X-Google-Smtp-Source: AIpwx49O0r3RgZBNqnWzj8T/gDSUuWjSnW8f89XW1HIz+ySE5qoTcHyR3BYg4nl7qf4upiBeeEsWQQ==
X-Received: by 10.28.5.10 with SMTP id 10mr3511325wmf.47.1524284604886;
        Fri, 20 Apr 2018 21:23:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 58-v6sm14242487wrv.41.2018.04.20.21.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 21:23:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "vmiklos\@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin\@gmx.de" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
References: <20180420133632.17580-1-benpeart@microsoft.com>
        <20180420133632.17580-2-benpeart@microsoft.com>
        <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
        <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
        <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
Date:   Sat, 21 Apr 2018 13:23:23 +0900
In-Reply-To: <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Apr 2018 11:34:25 -0700")
Message-ID: <xmqqwox19ohw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>>> +merge.renames::
>>>> +       Whether and how Git detects renames.  If set to "false",
>>>> +       rename detection is disabled. If set to "true", basic rename
>>>> +       detection is enabled. This is the default.
>>>
>>>
>>> One can already control o->detect_rename via the -Xno-renames and
>>> -Xfind-renames options.
> ...
> Sorry, I think I wasn't being clear.  The documentation for the config
> options for e.g. diff.renameLimit, fetch.prune, log.abbrevCommit, and
> merge.ff all mention the equivalent command line parameters.  Your
> patch doesn't do that for merge.renames, but I think it would be
> helpful if it did.

Yes, and if we are adding a new configuration, we should do so in
such a way that we do not have to come back and extend it when we
know what the command line option does and the configuration being
proposed is less capable already.  I wonder if we can just add a
single configuration whose value can be "never" to pretend as if
"--Xno-renames" were given, and some similarity score like "50" to
pretend as if "--Xfind-renames=50" were given.  

That is, merge.renames does not have to a simple "yes-no to control
the --Xno-renames option".  And it would of course be better to
document it.

I also had to wonder how "merge -s resolve" faired, if the project
is not interested in renamed paths at all.

Thanks.
