Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A2E20248
	for <e@80x24.org>; Mon, 15 Apr 2019 19:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfDOTZS (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 15:25:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42888 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfDOTZO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 15:25:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so23403613wrx.9
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dRBIggO33FOeKjymuo8Coa8fWFnkndYIMnk1aG50c2E=;
        b=nrVtI7+z5yIgU6f7NBQ965UULGmabmU1ePE9E7rodoZWyBzqGWR+qPgWNr+pnnnO1S
         B5ESAFiIYX1cziZnvK5iASN+BejDG2mbVuhsqMlklZBTNn34+6Esa4mvtg3thcw5ieyX
         2KyXPJn7tj6PZqwKU3QN8h30K0rV7I1zzjesCpMDX4IsrXbQdzpxH+YcX0FD2NnannKq
         XiPxtF2wyIBZcxCm35nP9cgBfb0atQU82O4llJDRSVDTcYrInX0krMUOugaJNsjctyRE
         /X5m4Mxchqni+1gEVo3w/flJp/5ndMFy2bCohH5O+pGZutRIHrQ9PQZc/Hy9JVF4UtuN
         l5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dRBIggO33FOeKjymuo8Coa8fWFnkndYIMnk1aG50c2E=;
        b=ZQbOa+JHGksqB84GObi1SPBIPuMlBTrD0cz+TXbGRKoX/P1aNxzURXS0GngblZmYAV
         073yKH4W970jh3G4tPZT0jMPn/eJT1xnhEoDqxkhEbRbLy2nX2l86podU6uJmBKq5Lmc
         5lPvPDG1giMYr/WGzK7iOWazvCdojy7ZzCDyAHauTtRSDljYBa4u128je5SwOgcmuFgz
         E1CTwnVxj0jVGgSwaeU3bTtLzwm8LMhRuUlP3OP1zkiHvFJaJ2uRFFfX/u/wFm23X6mw
         EVxv57o6DRtOfrKfl2xJ5czFOlBx5e2MzA9dSHzTykCyuI2fXodiXqi+j7PfrsEjlGdn
         ZXOw==
X-Gm-Message-State: APjAAAWDQd9tjWSkKWscA6+hitiwDa1Y33z9OB84I2NKWxLBgx5CUDLd
        IQvUnz4qv1Pc6VyLO/2or6M=
X-Google-Smtp-Source: APXvYqxU90b86HCu/UKvymQv7+QH82K7TNm2GUAe7iD9Sq7+MotvIRhPDamhJbt5w+Mb1C91h04/GQ==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr40702709wrq.176.1555356312569;
        Mon, 15 Apr 2019 12:25:12 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id o4sm28192638wmo.20.2019.04.15.12.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 12:25:10 -0700 (PDT)
Date:   Mon, 15 Apr 2019 20:25:10 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] output improvements for git range-diff
Message-ID: <20190415192510.GF1704@hank.intra.tgummerer.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
 <nycvar.QRO.7.76.6.1904151445250.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904151445250.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/15, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Sun, 14 Apr 2019, Thomas Gummerer wrote:
> 
> >     @@ -99,10 +90,10 @@ modified file Documentation/git-revert.txt
> 
> A better example might be a .c file, as the function name is often a
> pretty useful piece of information.

Yeah, maybe with your suggestions, we could fit the function name or
some of the function name into the outer hunk header.  I'll give it a
try and see how it looks.

> Read: I think it should be part of the outer hunk header.
> 
> Also, the text "modified file" takes up an awful lot of space. Maybe we do
> not really need that information?
> 
> While at it, we could strip the line numbers, as this is not intended for
> machine consumption, but for human consumption instead.

Yeah, that makes sense, the line numbers are really kind of pointless
in a range-diff.

> > [...]
> > Note that this patch series doesn't modify or add any tests, and was
> > just manually tested locally, thus it is still marked as RFC.
> 
> Oh, okay then ;-)
> 
> Thanks for working on this,
> Dscho
