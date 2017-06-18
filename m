Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA241FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 07:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751011AbdFRHqJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 03:46:09 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33378 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdFRHqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 03:46:08 -0400
Received: by mail-pf0-f182.google.com with SMTP id 83so40508133pfr.0
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N4+b6uycUeKAImXrUhh9/wvAYi77Ln6lxhaKG/hv4Ls=;
        b=ir0jAxmYAz5UN+xott8i90uCcPaQnDtwHwaElf8QYY/KSqGQxk6fTs0ILB1ttDSiD4
         VMSdFJRr3uPYezaE9bjWPy4Ud8dYAtV23mVzYiTVI+U9DWajCPjGWaCcUUuZh3UZiZkb
         3gEa6MJaO1mIyUhoDxQDGJ/YxTKUEy64bWIh7QRA/wf0kn55bYsERDFtfg1aKBBGwaDt
         2MK4EWRkwjx1OvkLaMQ26Rj36D7YFEmS1KDPYp/mExyDp62A7A+69q6o3XKzoe6OXVXr
         9k8enl2M/t5paSCg+YRMd/9Uz2YK508INiu9IYfqyXccqJnuOZWfR8WOe4jwe0IY9lKw
         2K4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N4+b6uycUeKAImXrUhh9/wvAYi77Ln6lxhaKG/hv4Ls=;
        b=OP3EIgU4ipFVX6EiH2jjRvt0Dn6azas6FgxQCV0DC1cJGWC2Gb1YFno8KUeEXGRZxP
         ueH8sULcuCchM7rempzWvzAS8QORJ8VD6BNGwIG/SA1mraLnTNoa6TcP34XanYRSavTF
         XDSCpvpqQ5/+mqMGcN/4yJuhg+siwjG7D9+3FOPR5PJq/OHs6Ke6nxFIkhxmW5H+1Cl4
         GRmN4uyCD6aoc4jFytElm3u0dM8wHLVi1Ep8M6E2F/MTL7LzAguY0hIF0FFsbDwyPC2T
         ZTzF2a8A6BRiJEdxFph5AB/CvqUWs8ObI+dZJI6Q5cGq5ny51T5aoRn6+13uQ18p8ROG
         cM4A==
X-Gm-Message-State: AKS2vOyG2iN2/YHXvw6/XOEmH+//PMxzbK+CfT/gh9IzwJWeJq31cXgj
        o381kcOESLCy6Q==
X-Received: by 10.99.185.28 with SMTP id z28mr9371222pge.123.1497771967477;
        Sun, 18 Jun 2017 00:46:07 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id q135sm14239898pgq.41.2017.06.18.00.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Jun 2017 00:46:06 -0700 (PDT)
Date:   Sun, 18 Jun 2017 00:46:03 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matthew Groth <mgroth49@gmail.com>
Subject: Re: [PATCH] mergetools/meld: improve backwards-compatibiilty when
 using "--output"
Message-ID: <20170618074603.epf3vhsi4pevg6jn@gmail.com>
References: <20170617102454.2040-1-davvid@gmail.com>
 <CAJZjrdX=8DbRTsdJ+bH5BABJG0m=y2QpT8C4kFviUsxVqVLVLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdX=8DbRTsdJ+bH5BABJG0m=y2QpT8C4kFviUsxVqVLVLg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2017 at 10:11:36AM -0400, Samuel Lijin wrote:
> On Sat, Jun 17, 2017 at 6:24 AM, David Aguilar <davvid@gmail.com> wrote:
> > Meld 3.16.0 requires a "=" in the --output argument, as it uses
> > a simple hand-rolled command-line parser.
> >
> > Newer versions of Meld (3.16.4, and possibly earlier) use
> > optpaarse, which accepts either "--output <file>" or
> > "--output=<file>".

Junio, there's an optpaarse -> optparse typo in the commit message
here in case you want to fix that up.

> 
> Do older versions also support both?

No.  When the "--output" option was first added (3.16.0, or possibly
earlier) it used the simpler parser that does not undertand the
"--output <filename>" form.

Much older versions didn't support "--output" at all, so we don't have
to worry about them since we already use the "--output" flag
selectively based on whether or not it's supported.
-- 
David
