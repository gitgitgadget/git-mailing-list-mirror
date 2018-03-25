Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47DA51F404
	for <e@80x24.org>; Sun, 25 Mar 2018 17:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeCYRc5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 13:32:57 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36177 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753739AbeCYRc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 13:32:57 -0400
Received: by mail-lf0-f42.google.com with SMTP id z143-v6so24871761lff.3
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6qayMx5HXMBWApuM6MT3Ic7nId5/l7CIDNxrCe1cz/Q=;
        b=HIhv3CWo0KNM2V/SF77KmbkCju0xEYBswXpmRkCvNoeXvVtHCvc2uGRIPvbmFCN/+r
         nr51XmQJpP1A3XL3am7CMap233xYmIat1BhTEb59HprtnO51yFQ6ZGdj2/wVVcbc4gsF
         lbfN1TD/KyyB0mqNA7hLYix9btmP9frrjdy5SWSNmD7VcbbWUCzgteTgi8Flll8A81Z9
         96kmgKr0YznJ8H4OcWJEZHTaEopIX0wJuN5Mb0lRRfXC5HXXaJFobs/lxBMsW0KFI9wY
         xs2KPMpN6o0cex2fOorczn5bKtceOeGejlbGn7//K7V23Di+qlPrV5+VDqW/3V7OzDVf
         AZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6qayMx5HXMBWApuM6MT3Ic7nId5/l7CIDNxrCe1cz/Q=;
        b=BZzmlrLCYqCGiR+bN0MDEKJcxNIxlfGpeZtCVDHyGs4xHxOlDszZZrzwMCoRvyLPX+
         BQcVg5IpI+nCBw9Itd16XoN1VQOo6uR3+wH0Wolr9biqvah7kBNgcGD5p0uAbTjfNzCG
         rlx6gARz3dFXTVXqMLuU5I1Qkik0/HbaCDW8MnfsjolBjnC5tRUemUUGXASD77gLEE5D
         wLogtdYCcpuIPbefxvw2VUAvrAeBJsL3YjO7+1xhqbnAdFVD3as2/XuDbrY6NYPsUUva
         ISeV14PITQxTuVlgByBji2yJ5QZafcQarb8PIKXtHeTTfDfWpth2WjL5hMMc4Ht1Tbo3
         s1ZA==
X-Gm-Message-State: AElRT7FuzL5lPL2NUrHV6koaZdbn65apOr9S1SRuJDIb3JGs8mXL2ji1
        UY8sfbc4piFzEjrl4RuGcAX1eVLepgVy2y/7ow1E2fcyOG0=
X-Google-Smtp-Source: AIpwx4+om/OonGPPKklFcHQB1I9kNWy03m5l5giHJR7xXl+0f72iDdlx2XCMXaV6Dz9bHTeWt3RvvJePAxGb13o0y5w=
X-Received: by 10.46.49.10 with SMTP id x10mr1972921ljx.5.1521999175131; Sun,
 25 Mar 2018 10:32:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Sun, 25 Mar 2018 10:32:34
 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
Date:   Sun, 25 Mar 2018 10:32:34 -0700
Message-ID: <CAKk8isqvfhiMPCdNBW5WNN4BfN1sLszekQscpy5M2Okh2YmbZg@mail.gmail.com>
Subject: Should I try to fix rebase interactive preserve-merges bug
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a "TODO known breakage" in t3404-rebase-interactve.sh:

   not ok 24 - exchange two commits with -p # TODO known breakage

I'm contemplating trying to fix it. But with --recreate-merges coming
maybe it's not worth the effort. Should I proceed with attempting a
fix or is --preserve-merges going to be a synonym for
--recreate-merges?

-- Wink
