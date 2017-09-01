Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB52A1F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 23:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbdIAXUQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 19:20:16 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:38055 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdIAXUP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 19:20:15 -0400
Received: by mail-pg0-f42.google.com with SMTP id b8so4237110pgn.5
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e+r6cCqgjEcDdQk6nQ7sTzMop7miejC1NbLfTgPDgEs=;
        b=m/1NVL2yqGT4FwQ1wpNNENQgwoVrNOVCmqItxmXcOXRk1pu02SI3va54KwCkHcItDZ
         U+xTSMmPOPgf0H0UwtUEJ4lwTZs0LIeedD7Svxws76+jIF4Tl1gF8QMdMxyw+NMjXvki
         WjxDBJCL027dCb1wTsXUAstBpUitwWHttqArbQEd3SjPdGWWub510tU6cRSqt8sjF5Y7
         Kwm63xhC0XZhRX0XZsCtuPboyXYnB7jZ1w4Ki6A3Yb/DcWe7kaZHa5rPzs/Fc7NeLwHt
         rjQYJnSSnahPNZ77zRKWwSUaI7UAPLJUOtqijIav4NE0i8SYBsM272fdU+CwoQrBFO3m
         NkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e+r6cCqgjEcDdQk6nQ7sTzMop7miejC1NbLfTgPDgEs=;
        b=lgF36Bt78Qp3/As8JxTUrAqf4gtYgBUsCCWFhHhHvPaJ8pvyhcosjkESrscMcnk/20
         yA8FFJvjdjL03v5Bn90HdfKk03ubXMJ9jLxDnewhI+1p9izuDxIBA26/yaHUTbapmNCN
         v4YU0f3UVMu43kez1OUM4Eppaajgn7TuJ4g0MEep1dkcya0JNX9y/CIrLZf9i9iVAWyt
         +fA2FIR/v9vG32jpHtzqYt1ipDUZlPJwhViaHysQYF2bsXqHqn3+vyVn1yJrF/mEkDtz
         gw4VxsCPdLfXz5v9p5xxX2EXlon4iF427DH+tM+UdGE6IFksor2aMZlWY4vGNeJ7AwFI
         Me1w==
X-Gm-Message-State: AHPjjUhPbqhkxNyX0xP5CnumJ4gwK++tEB1KCF622Opv5Y0Mg0ixabeN
        8Pu5H74S4wrM/JHC
X-Google-Smtp-Source: ADKCNb6S43mihoXZzehcBl3Xw4lKdBU6tjUpZS9n6MS4CwdhKRnL07jJiqafJjXBBtPjsQWQV2QIRQ==
X-Received: by 10.84.224.199 with SMTP id k7mr4304146pln.180.1504308015122;
        Fri, 01 Sep 2017 16:20:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:906c:439c:72f6:eceb])
        by smtp.gmail.com with ESMTPSA id s76sm1500948pfs.112.2017.09.01.16.20.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Sep 2017 16:20:14 -0700 (PDT)
Date:   Fri, 1 Sep 2017 16:20:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>, jonathantanmy@google.com
Subject: Re: [RFC 7/7] upload-pack: ack version 2
Message-ID: <20170901232012.GA16739@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170824225328.8174-8-bmwill@google.com>
 <CAGyf7-GKAW3Dn_rPKxtidKoXh7a6NmDFYzGrb9tGOszhsMignA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-GKAW3Dn_rPKxtidKoXh7a6NmDFYzGrb9tGOszhsMignA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/01, Bryan Turner wrote:
> On Thu, Aug 24, 2017 at 3:53 PM, Brandon Williams <bmwill@google.com> wrote:
> > +
> > +       version = getenv("GIT_PROTOCOL");
> > +       if (!strcmp(version, "2"))
> > +               upload_pack_v2();
> > +
> 
> I think the "if" check here needs some type of NULL check for
> "version" before calling "strcmp". Without that, if the "GIT_PROTOCOL"
> environment variable isn't set, git-upload-pack SEGVs.
> 
> This came up when I was testing the "protocol-v2" branch with
> Bitbucket Server. For performance reasons, we sometimes run ref
> advertisements as a separate process, when serving fetches, to allow
> throttling the ref advertisement separately from actually generating
> and sending a packfile. Since CI servers continuously poll for
> changes, but usually don't find any, we want to be able to serve ref
> advertisements, which have minimal overhead, with much higher
> parallelism than serving packs. To do that, we run "git-upload-pack
> --advertize-refs" directly, and that command has never *required*
> "GIT_PROTOCOL" before this change.

Thanks for pointing this out.  Since this was an RFC I wasn't being
careful with doing these sorts of checks :).  I'm currently working on
the non-RFC version of this series and it is getting close to being in a
state where I can send it out for more careful review.

-- 
Brandon Williams
