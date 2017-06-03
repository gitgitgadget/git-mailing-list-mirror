Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7930209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 18:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdFCSI7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 14:08:59 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37111 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdFCSI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 14:08:59 -0400
Received: by mail-it0-f41.google.com with SMTP id m47so44660667iti.0
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YWwNRgQQ3aHfr2Ns2RSx1lcU8KmmMR/5jKX0CJP96Fc=;
        b=cPhgvtstIVrs+RCbT4WpzeP/7fIJROO4nwmJDJJY/WWFth6Fd2jiahkUm5MupTF0sI
         /G6ZSUNlczZKLqp3s65pvOAXWSQlbLc9zh4MB9wosZdzt7WXMjZo0vAvTon2ywSmgyX7
         YfHunnyJLmlPZScicUG0w5nLFNsCS0WZVlrf0X2uvxeB/0ex5N/2VnOHmj846HC238MW
         kz7L1m7iRJ3jMiMBKNJX1k+weN7DaYjfcFchs36ovFiu5zBOj1hisStR25js6UP1Ix1w
         K2RoDeaC7HWFyzBKCJ8QCNcGDd1MN5qkA8AJvbf6/GQ3bBXoya31+GhPINveCzOQAj+x
         9/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YWwNRgQQ3aHfr2Ns2RSx1lcU8KmmMR/5jKX0CJP96Fc=;
        b=HV2PnlLQ6ohMB62hwqaVMHYdf0cKfR35GHX0WHi3xA2KQvl8OfgCZClClBkTkFsSQE
         eDIv1Un3DrP9IobVcI0nrsXVHp0Qacb8bvE+wmtvTlFmVFlDuy1tt89pv4doLclOEKaj
         I8TXe1KssL2nQz+bPWqHCiWbCz7/F0Q87Twfn4JCx7b08USq8eRdSqtUvbZi/deNjWxi
         hp/FbptIUMuYbLrpMjQLj5O+4mzzgQ5GnTNk9q7rddBVIDexZZT7xEcE6pxwhVXCuHm1
         lC93s5FevEQabgjmWI0Ou3LayNY6fZdXHEtLLaR1LB8U+hP3smegBMxq0TiikJE8T9Z9
         2qqw==
X-Gm-Message-State: AODbwcAk4Bp0hbxHQfaWL8llSZ5JrZFQ/OntLIh5vamVm82OYurt+vJX
        QNxjb7ZdIFDoH+9TGx+Pzk/v4H8HNg==
X-Received: by 10.107.201.131 with SMTP id z125mr12491914iof.160.1496513338173;
 Sat, 03 Jun 2017 11:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Sat, 3 Jun 2017 11:08:37 -0700 (PDT)
In-Reply-To: <75ecd288047648178ed93105ee1f7a9e@exmbdft7.ad.twosigma.com>
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
 <20170602102853.23073-1-avarab@gmail.com> <75ecd288047648178ed93105ee1f7a9e@exmbdft7.ad.twosigma.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 3 Jun 2017 20:08:37 +0200
Message-ID: <CACBZZX7Xttqk9pbhtARHef_hy=WnbokTLnfe7W-sGN18611MYQ@mail.gmail.com>
Subject: Re: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 11:44 PM, David Turner <David.Turner@twosigma.com> wrote:
> BTW, a medium-sized (~250k files across 40k dirs) synthetic repo is available over bittorrent at:
> http://bitmover.com/2015-04-03-1M-git-bare.tar.bz2.torrent

Can you seed this please? I've been trying to download that since
yesterday, still at 0%.
