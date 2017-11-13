Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6E01F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 18:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbdKMSJD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 13:09:03 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:54191 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbdKMSJC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 13:09:02 -0500
Received: by mail-ua0-f170.google.com with SMTP id e10so9309531uah.10
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 10:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ax9rYsM2FgSO9E1a966pflwUnjMhS2mENxLqMsd662Q=;
        b=KnARFj3bw545b++fciI+n7tHq+mVW9x636Plie53iWlrWG3FHwXkoRfYkbWQpjsVWg
         Y9wWKE3LwQdZ5/0DiXN//dPWE2D776JgM9ooMLmJ74DxV2C+NRx14gRFOOXys/2ZBVr7
         xMTXdkhxaqAAPDkLQokDxMjfzvpja+T7cLTbTNYxeR5Wzh6u/FZ4tXT/JopKq//o7JrP
         2nIhFtZJuy9kVhyMbEP+gk3POfButL2WJ1gJMIlyM+qmq3f4KmGLseSaXJ2M36Cold+c
         /J4vkWCLhfdDghZwl56EIpHawowbvYS3EjsFKk4P1Z3Y3pGJvprfFnN7njw4UGMWlZa2
         DPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ax9rYsM2FgSO9E1a966pflwUnjMhS2mENxLqMsd662Q=;
        b=T8BYqZKiDjhCXIFnkCor242kuqzpiHOfKZIlN3g3dbjWwlHhesbe5bTfs79SB+RzB8
         9x2XpL9U/yzk6NKIt257tiqHKWZNkl76NPelMBmeM/nfICuftUAsjpPD5N4LlnOPn4Bj
         MAJMzc2fl181EigWn2dySA86B2MjDA1LU0Brod3SKqPjwC4107uNdu7vOrlL4nxj+pJ8
         GHEoezpIUt7+M74BIiUv9NDKmGrNbxC32YFRkOQbWSzPPw2IxHeUuZB1BqwGRWVAckga
         KdEnVKuxE1S6Ge0PfIdjo8p2h5BIrV1U9BLz5j+14VBEbdfEuCZ5UAy4C7dBCNLIxh/T
         wtRA==
X-Gm-Message-State: AJaThX7OTKyQLXlqr5YymKb3n11/VEBxhq7SiYPeKLjyF/Hvs948/Fm1
        0MGGmlanDGJM40Utttug2wH8JK6glO+b7kJUOUs=
X-Google-Smtp-Source: AGs4zMamIbjH5/8KcHPjAeNEI3K5HTKyhj3QY/rusGi5yRbN2SRGXWnnWYmxQrQ+GewhHsRCagZrrLOodHOR+caJ05k=
X-Received: by 10.176.95.138 with SMTP id b10mr8776589uaj.55.1510596541573;
 Mon, 13 Nov 2017 10:09:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 10:09:01 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1711131221150.22867@ds9.cixit.se>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se>
 <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net> <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se>
 <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com> <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
 <CABPp-BEu_DOg5t0qHnyLYSok+J+onGFPoFBbgp9P-S5JfhcRjw@mail.gmail.com> <alpine.DEB.2.00.1711131221150.22867@ds9.cixit.se>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 10:09:01 -0800
Message-ID: <CABPp-BE-bJnLTf7Y-6_uy=+QA2pi=6EAmGy8S2n7B5Ry8ckHuA@mail.gmail.com>
Subject: Re: cherry-pick very slow on big repository
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 3:22 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Elijah Newren:
>
>> I would be very interested to hear how my rename detection performance
>> patches work for you; this kind of usecase was the exact one it was designed
>> to help the most.  See
>> https://public-inbox.org/git/20171110222156.23221-1-newren@gmail.com/
>
> I'd be happy to try them out. Is there a public repo where I can pull these
> patches from instead of trying to apply them manually, as there are several
> patch series involved here?

Sure, take a look at the big-repo-small-cherry-pick branch of
https://github.com/newren/git
