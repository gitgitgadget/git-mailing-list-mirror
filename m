Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703111F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbdHPSxz (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:53:55 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34272 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdHPSxy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:53:54 -0400
Received: by mail-yw0-f172.google.com with SMTP id s143so28203595ywg.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d8+WZ5LHR3QeYuIumYVi+2nP3++mizmE2TN0Zn7o1mA=;
        b=YbaXXYfv4JCgcs702izST+cc4zR1fZGfJg/CsHIevXutY1wjJOZoJ0xeFhKPefscR9
         DQI+VYiddPwYv9bc/w7XcZzY4SpDOAdTqAJhJ8mxjYRL+6Fn8gbqCb4VJD9SYs3fFrJo
         WJJ3GfZiclL4JhMzSh96LuwkPfI5O1Q2psLHxIcp92CLJBQoDRj/RA/8NecMHYrhD+EE
         8p8aHtHMci3TW1hmlUPmP+G9tj4zzBWrzIZ8TDgTtAcQy8r/zX5djwsVDpD4jIIGOESv
         w7xFEtRDtr2vIIL8a9QHL/aUW5jYTqSU0vg5zETC7vOjASTVcCHhNNMZTxYPIP8liBJi
         RXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d8+WZ5LHR3QeYuIumYVi+2nP3++mizmE2TN0Zn7o1mA=;
        b=Kx0GyZNciurxG0oCp4mBjM4tFrARyrPDUqrUW+4GYrLjqFrW0LYi93S13YaVUW5WOl
         ggBS06aINf5ajcz5RuMqw25hj9vtcgB97wSC+hBS5ntt9KEfc/mh7Dw35zKBEBtps0+G
         Vns9DRwsKe7Or2zRLkUrF7zYQWVfe4D+a7uL8mRRCK9umjO3Zz1eqwrEv2RLtvKQqaHm
         Dxvli3cm5Hyw8YCKBgA5YoWUI9CIkdWin7B4dYHNZUmTCPl84i4xS7zhDEW7ZsBm4I1M
         wJtLw6l0eOsM98TJIrp6HBKDSZHLhv3rdTLVJheQh234QA2De5qr/cunu/3WWCCwuLou
         41kA==
X-Gm-Message-State: AHYfb5j+po/sKbQXqoCn0yLK6GM8R3zvAaymZfBmWeFRDXdZHhKiv90k
        bM+5Jfp1cJ9RttVTygkM9KwEgV54i/n6
X-Received: by 10.37.55.79 with SMTP id e76mr2224621yba.215.1502909631553;
 Wed, 16 Aug 2017 11:53:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Wed, 16 Aug 2017 11:53:51 -0700 (PDT)
In-Reply-To: <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com> <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 Aug 2017 11:53:51 -0700
Message-ID: <CAGZ79kadSk46v_a1JBr5Rr=Gikfbp95rPXSWaj=gk6_ZKF_HFw@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 11:51 AM, Stefan Beller <sbeller@google.com> wrote:

> Any chance the "did not happen with 2.13" was not
> freshly cloned but tested on an existing repo? If so a hot
> candidate for suspicion is a93dcb0a56 (Merge branch
> 'bw/submodule-is-active', 2017-03-30), IMHO, just
> gut feeling, though.

which makes it a feature, I should add.
