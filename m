Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5971F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161939AbeBNS1r (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:27:47 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:39976 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161778AbeBNS1p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:27:45 -0500
Received: by mail-yw0-f182.google.com with SMTP id y186so7504918ywf.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0rou5eWurpzZkbVe4s2LihbPDq0Rb3EirzCoBJJTl6Y=;
        b=uVPmeZzvexzPv8wNSuK79La3pc5y8etD+ggt8GbhVTe+jezsRz6yrEmpUI4Y6cxkHJ
         IocE5sftoPmmYAfiBhkY8Iduvle4IS91l9FXJakJ/7ntEKdVu5YolHn1ZjHIIO00xf6A
         NAiisNiWejaXCy4Ly5KiRqx971wElDC053AQXZx/ow3SaKTpOyt2DBLMc6y4CoDHXXy2
         MlzYOSycbJQ5eFvOV9f8YpInffQ0j3pa2VVo0HDOu4KnbdsGjmYJYT8qoIJ/co55idXe
         3HHKpuPNZo5P5XnEMPYW2JBC5eV0BIPW/sAgYmpYC3MpNKZO4OOyj8zvyAF34flL5hOK
         4uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0rou5eWurpzZkbVe4s2LihbPDq0Rb3EirzCoBJJTl6Y=;
        b=HXtSnIRFVVJx+sG9ybGAwb5x89TmpqbOfVKeXqtJnVGHF3JWtalLyYvMc6KkwJ99Pp
         3pe07vb3rNAxpHIjKmp9vywfQjuAMyPmLBuTwN4fB2/Cdk5yI1anY4fqzMTDRzRVz5Ac
         jhJCk9X5WWb9lK3crky0GZZ+aGfWsXnTGJRq0P5UvN9fcv8dVha3bvEsPupjrkMtpGFr
         /5MJMbxE30nIrpsxSw/GVmsUF8XWVAhxrfkWg6v1E9pTL8oA2sY4bmuhbu91yd29m787
         iLoE2LMVXxfNEM08yLcqX+M1A8Lhriowb87tBmgCS714R//i6Rm+j7PkOe1Wq/h7sMr7
         gLGg==
X-Gm-Message-State: APf1xPCb77jdpu/ecpyEzBdxyFKrfagTNKyBH84nzXXfQEg2/FTmxViu
        2vePPpO0ipObuGxsDrHMddSyCzLo9bnzkYiAz3c0kw==
X-Google-Smtp-Source: AH8x225NGdcynQGbMYQpWLdvSu7rLEdbDJjPuOw+mwPbkWjovAk+MQqrTJi+s9Q0RgzdoEYTtePwj2F/cHWIYY5A4Is=
X-Received: by 10.129.156.134 with SMTP id t128mr128873ywg.108.1518632864406;
 Wed, 14 Feb 2018 10:27:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 10:27:43
 -0800 (PST)
In-Reply-To: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com> <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 10:27:43 -0800
Message-ID: <CAGZ79kbMURmVhnaP4rdho9TpzZ=K+ySkQGgW8TD0x+KgJkqirA@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Serialized Git Commit Graph
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:15 AM, Derrick Stolee <stolee@gmail.com> wrote:
> There has been a lot of interesting discussion on this topic. Some of that
> involves some decently significant changes from v3, so I wanted to summarize
> my understanding of the feedback and seek out more feedback from reviewers
> before rolling v4.
>
> If we have consensus on these topics, then I'll re-roll on Friday, Feb 16th.
> Please let me know if you are planning on reviewing v3 and need more time
> than that.
>
>
> * Graph Storage:
>
>     - Move the graph files to a different directory than the "pack"
> directory. Currently considering ".git/objects/info"

In my copy of git there is already a file

  $ cat .git/objects/info/packs
  P pack-8fdfd126aa8c2a868baf1f89788b07b79a4d365b.pack

which seems to be in line with the information provided in
'man gitrepository-layout':
    objects/info
           Additional information about the object store is
           recorded in this directory.

The commit graph files are not exactly "additional info about the
object store" but rather "about the objects". Close enough IMO.

Stefan
