Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643F81F453
	for <e@80x24.org>; Thu, 25 Apr 2019 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfDYTBB (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 15:01:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45677 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfDYTBB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 15:01:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so353137pfi.12
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/iTjalCDVcfTCV+qHCxcvaU9vakOnRvwEc3Ekf8uCew=;
        b=h2wml5XCVZov2WC3MuVWrFb0oaAuCFCNrcx07RVrOCc/CEGtGHYW7Jiu5qNiNXyc4q
         JdCCo/Hay+DXg/ZWTcYpMxiIZ4Vmq005YjNO7LS+WtXAfyAwKtHdBxq0Gt+rsRKXAyn4
         NizoX7YhOwSo7veX4DGBfqkAcC94qScLuzBbwrPepr+Gpe9/Z6II00DOEs6Nca1QJHon
         onsVaXMX51WrzVEtmg8L90F6Xy3NX/GC0DP5iNYvSrcvvSVQQWNQuC8lRPBvM9ZNWkrX
         hZCy5kPO6squC1F6rRCoFJFXdKTo4f8Wz0Q/UMFzJGYLy7l+bqg0iMiTSN78WTLyjjj+
         6swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/iTjalCDVcfTCV+qHCxcvaU9vakOnRvwEc3Ekf8uCew=;
        b=BVDPSjqDpcASYeN9QmtSVuxsnI9adldnQ2B02+jcxaVXmqpFhpxjGy4riWnlvjhGKx
         WbwbrPMVT30sIEw3l01e4DFN1Mpqp4Gqfxl1VgenesaWPDyObeoknSrfj6Bb58GSVL3D
         drgyOqSm5eB9vWeuyTT/+HcWmeZdZt3LCiUXN8lSo6ip57GLVftHxmkVJY8cMEDA/QhW
         nmdkLvBl4Ax2C7c7eTVUSQO5FFJKRDe/5mxjVl8Wfc2n4o3voGT4S3lYM15Q7yPSLpBI
         Y7g1hBloOgnhsSjgqdbnkylP0fqt5W+8NiNhXuYOclt2swp3Re4PU86+LNHI6crjNCVe
         /PfA==
X-Gm-Message-State: APjAAAWGo2/YwoD4Q6PwHnu8O9cWgO5uqMCtNGkEKar7ae1cqqGi5+Kw
        HwWiX5WLqlnea5mEFJNC2+k=
X-Google-Smtp-Source: APXvYqxuO3lnUcMb1h9KDWkFc0XBEuC3Q5F1f1ONFlSY/+Ivrz0BmC9briojEeMbbo95RUxHDLXghA==
X-Received: by 2002:a62:4d44:: with SMTP id a65mr3351525pfb.150.1556218860055;
        Thu, 25 Apr 2019 12:01:00 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id i3sm33510490pfa.90.2019.04.25.12.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:00:58 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:00:56 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 2/4] *.[ch]: remove extern from function declarations
 using sed
Message-ID: <20190425190056.GA19384@dev-l>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1556062365.git.liu.denton@gmail.com>
 <0ebda4725297df64661bc6749b1a1c4c93cb76e0.1556062365.git.liu.denton@gmail.com>
 <xmqq8sw02e7y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sw02e7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 24, 2019 at 01:56:33PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > There has been a push to remove extern from function declarations.
> > Finish the job by removing all instances of "extern" for function
> > declarations in headers using sed.
> >
> > This was done by running the following on my system with sed 4.2.2:
> >
> >     $ git ls-files \*.{c,h} | \
> >         grep -v ^compat/ | \
> 
> Lose the backslash.  Your shell knows its own syntax sufficiently
> well, and when you end a line with a pipe, it knows that you haven't
> finished speaking to it and waits for you to give the command
> downstream of the pipe, without being told that you haven't finished
> with a backslash.

Thanks. Could you please make this change for me in 1/4 and 2/4 in case
this patchset doesn't get another reroll?
