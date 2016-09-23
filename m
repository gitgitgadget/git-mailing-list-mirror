Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6B31F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 05:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755762AbcIWFrU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 01:47:20 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34837 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbcIWFrT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 01:47:19 -0400
Received: by mail-io0-f172.google.com with SMTP id m186so108159476ioa.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 22:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/mZVvro8LqkbBUiEfM+E76/Q6tL5hbKlo6y55LXNs68=;
        b=Lu6IgByzItTAyTsc9awr2cGVznFbV1ewtkYxfzbdPGg/b7Sa2/24Fy/sw0/dJXf9Bt
         TnDIg4drbB0OPuA0RIIbZsuo7ZND4YWTQHK7bdOeqlSduAZWgMXZEROdSulS4iPJEJyK
         fKuA5UZacprB5+pW5CmPGGB8soU8x56qoT8P+vmThq3JhEG6supVE50KjAFY1nZenFqD
         uITWvbbgdZbYDofUnimNZmNdAt5KZPcQ3ij9K+RNwt4UdXI77TrkydBzqXbKyjzkVdbA
         K0/lmo56AfUkCs3cuytyuSGigjRBuYMnw1pA6BrjpDaE33L5RdYy16QUUNCzRXMDAx6/
         /N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/mZVvro8LqkbBUiEfM+E76/Q6tL5hbKlo6y55LXNs68=;
        b=WVmbLu/soX4HT4vEvHsnKit4KTnLxD8PhUAF6VNNEUHMyFqiVPsHQrayvnAFB6YILd
         Rc5HsDBHr0DXHqfZA9zImN8Usdj0vZG1ToHALOZ4dj/0zbruNq2PQ554ncDRVNi+ywPe
         +gxXVmWpbDb+g/4JTU28TJF21c0s48Y0q0CqqXvXV2+BkdLGzDxBFL02AFP49Fvb4gy8
         14B8lWJwxd2tohW4Cpmc9SZG/GAcdx2IDHUHSYmU2SFuSjXjuZhettukbLsIVJI/tIW2
         d1f7EHv51DnSrijACTJyWfzN3plKbfQbDeXuB2g5FPn1XgZABgeYc+3s/AvRq9907e5u
         6mTQ==
X-Gm-Message-State: AE9vXwNZpHPgMAGFe7nG8YX9XrtU/U+FBq4AyEDVsCvLzSkzts8RTQjbzms0ujuSfCMabq+7Os185W9aNI3Gys3C
X-Received: by 10.107.59.199 with SMTP id i190mr6924500ioa.18.1474609638299;
 Thu, 22 Sep 2016 22:47:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 22 Sep 2016 22:47:17 -0700 (PDT)
In-Reply-To: <20160923034113.4rnps3nogvzxkfjx@sigill.intra.peff.net>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com> <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com> <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
 <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com> <20160923034113.4rnps3nogvzxkfjx@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Sep 2016 22:47:17 -0700
Message-ID: <CAGZ79kZ+LTd5PuT4+Z9K6d+GQ-33E=tLY1Fokbp22uNoygaEtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 8:41 PM, Jeff King <peff@peff.net> wrote:

>>  * As Stefan alluded to (much) earlier, it might be a better idea
>>    to have these 'prefix' as the global option to "git" potty, not
>>    to each subcommand that happens to support them;
>
> That seems like it would be nice, but there's going to be an interim
> period where some commands do not respect the global "--prefix" at all
> (in the worst case, consider a third party command).

My current line of thinking is to have a new flag in command struct in
git.c to enable the global --prefix, (c.f. RUN_SETUP | NEED_WORK_TREE)
so we'd have a ALLOW_OUTSIDE_PREFIX flag which can be used to enable
this feature. In case that flag is not set, but a user tries a
--prefix=<somewhere>
we can still

    die("nope, we don't do that");
