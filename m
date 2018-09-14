Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324971F404
	for <e@80x24.org>; Fri, 14 Sep 2018 08:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeINNao (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 09:30:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34035 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeINNan (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 09:30:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so3865074plo.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 01:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUnPCpeBAi9eW//cCvg+wHng6ApQ+DZm5mrYIE9yMd8=;
        b=nbFR7k9/9/suvNtITxsfKh23Og8x3sSUbenSXJf8kdm0lqagPjJDOPfYlAhP4mL4B1
         moHylazxE5mIkcccvMX/RdGANDgCQ7Fy4j8x2ervMOb1aFLZkXrETFZY8aNwi+BmxdXs
         u6wf+GSbPHuJZEgVOzmqf9XrFGV3ixVAhJiMl8Ue6fuPyrwVMO49JNjB41NghZMvB2v9
         DZ1FeQzA0EuCKCCaz5ps3s9vf67Zam7nCmjHCrXbYaf3OcZbGDZ0oqwAdB+LrjA45B69
         1Q2xMnxWqR1ujlB821h4PZblrX4aghpQqFbZCJn8U5cf5eyAq3e8zP5ITaTqe5+w2hj3
         JUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUnPCpeBAi9eW//cCvg+wHng6ApQ+DZm5mrYIE9yMd8=;
        b=DjZK1T6h9kAieH9J3yhaS8/ZgYAEWyhCHLWjkOAhs1DtZXfeMbpypIPZD3wh9PMY4w
         T0Xk+qVf5NajBKUP7ScXe5uszfGe//zKPyZmUJWsEwFf94EfQOQkOpmDjgy2Gfxud3ov
         +DzX66fUVm9cYxDcs9HyqThTDluBcinWP1l2qDorFtIVIJURg1NTaNV6A9y3eOIVD3rT
         Yp7dLfcARA8m0ZAdE9G7hsWt9eIvmLRMzlFFbT9yzojKTUUbwce6aRaGdymVh8wR4Poc
         NSgh4h8tM2gDHIkfz9T8zC10LpMNX43+NkezUgoaMCho7GnTUexGRKHiRekZQcGuk8qK
         5iKA==
X-Gm-Message-State: APzg51Cb27WD05iQ9T47hlnEh1bko6YPlgqNzfwP1t2NUupQGoc4TNss
        PrvwlscKzE0Y1Qb+WazH/hb89D2Q
X-Google-Smtp-Source: ANB0Vdane4SpvZ4LxSwUOSRwiRK0SrwRJJQSTUkNtLsjWhDkOKhhfZDx/04f5qL7H9ujHytKRr7Yag==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3-v6mr10858420plr.242.1536913042822;
        Fri, 14 Sep 2018 01:17:22 -0700 (PDT)
Received: from xenom-bubu ([180.246.25.37])
        by smtp.gmail.com with ESMTPSA id p73-v6sm9949635pfk.186.2018.09.14.01.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 01:17:22 -0700 (PDT)
Date:   Fri, 14 Sep 2018 15:17:10 +0700
From:   Shulhan <m.shulhan@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/remote: quote remote name on error to
 display empty name
Message-ID: <20180914151710.3261463b@xenom-bubu>
In-Reply-To: <xmqqpnxhdq0z.fsf@gitster-ct.c.googlers.com>
References: <20180913131833.32722-1-m.shulhan@gmail.com>
        <xmqqpnxhdq0z.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.17.0git50 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 Sep 2018 14:51:56 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Shulhan <m.shulhan@gmail.com> writes:
> 
> > When adding new remote name with empty string, git will print the
> > following error message,
> >
> >   fatal: '' is not a valid remote name\n
> >
> > But when removing remote name with empty string as input, git shows
> > the empty string without quote,
> >
> >   fatal: No such remote: \n
> >
> > To make these error messages consistent, quote the name of the
> > remote that we tried and failed to find.
> >
> > Signed-off-by: Shulhan <m.shulhan@gmail.com>
> > Reviewed-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  builtin/remote.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)  
> 
> Have you run "make test" with this change?  
> 
> I expect at least 5505.10 to fail without adjustment.

I am really sorry about that.  I am pretty sure, I run "make" to check
if source is run successfully before I know the patch was correct, as
the "t/README" said,

  Running Tests
  -------------

  The easiest way to run tests is to say "make".  This runs all
  the tests.

I will look into it later, if there is an error on test, I will send
another version of patch.

-- 
{ "github":"github.com/shuLhan", "site":"kilabit.info" }
