Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376751F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeI1FQy (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 01:16:54 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42609 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeI1FQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 01:16:54 -0400
Received: by mail-wr1-f45.google.com with SMTP id b11-v6so4311112wru.9
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qlNkfvdZ8GaOaAcF/eyn6TkSUoOD6zAyy1XQ76vdkbI=;
        b=bprjT1LJtda5TQldJvcqzo73hHkSsG5LKDxhtavkArtm/qCnJ/JvapKBaQwIfDKeWD
         JJXV6QcNuqm9akXN1L3pYwZNW1d/J09k7WEUnQyx5gYGwNCDyT9+MW+QaBM8hh4i5wMF
         fK+FdBWOF+P04UfBVSrP/SGZQjxpiTc0eq6zpwbvZGSquA2wZM/6MNPZq/xOHpmuC8lC
         wJRSyhnAYZV8UG6mLH9XCu3USnHKNbwSJ/3xHDJM7OtUdxHJ/lm31y2nGM5OWy4Ndcaf
         XekQ1NiGuCt89Brpgcg1GrmYFmYXBCn80W88ffGWAVPfwc+hyLoL0528t2fmuYKSCNmO
         5eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qlNkfvdZ8GaOaAcF/eyn6TkSUoOD6zAyy1XQ76vdkbI=;
        b=Y/Q3b1dwYtczfEB9Lm0xvZ3hl7QXOQTUN7G/wJxkxVq69A2lHmGo7bsap4TNUvgk0P
         dceaJw3rJfwxTDoJ7BWPPN5oIU6rLrUzn8p7amDB0yDBrBFG7TNiBruSRYhXgCp9FeWS
         kHkRFEXfYuKaaZ+O21QF/eufQdxsFTmnPGZVVQCzV57cIOc80WgJquE8rqWEDy5egmmY
         fgTb06CfzfNl+Xuq3m2o1JuyDENEYoVjXtkfzQ9AZvoTHiBaMhr2HNj9nxFqO7UbKb0j
         RVGfSLVkItZLxD87cbe1cPKiw8xxXym70P+y3xc+wOj2Jy/TMddF8fLqxWEfD70lUjMS
         TqVg==
X-Gm-Message-State: ABuFfogv5BUy9GNGl8KSSPwRD+PWWa+BSvUFs1tdPozISfYfwB1nMjpL
        hfUuyxBk0xL3LrZ9psuCp3jW2V+o
X-Google-Smtp-Source: ACcGV6307KLzcYHhsXjIiB57ejANjkaZmnVB7AIcNFokvRifKPGWwDRqD/+GTJj9IyJb8g3N/Bki6g==
X-Received: by 2002:adf:d149:: with SMTP id b9-v6mr10721315wri.17.1538088974879;
        Thu, 27 Sep 2018 15:56:14 -0700 (PDT)
Received: from localhost (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id i4-v6sm5418326wrs.87.2018.09.27.15.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:56:14 -0700 (PDT)
Date:   Fri, 28 Sep 2018 00:56:11 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] travis-ci: work around quarantine error during
 Perforce install on macOS
Message-ID: <20180927225611.GM27036@localhost>
References: <20180907032002.23366-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907032002.23366-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 07, 2018 at 05:20:02AM +0200, SZEDER Gábor wrote:
> Homebrew recently enabled the quarantine feature, which breaks a lot
> of things [1], including installing Perforce in our macOS build jobs
> on Travis CI [2], breaking all those builds in the last couple of
> days.
 
> Note that one option homebrew/cask devs are considering is to roll
> back quarantine altogether [3].

> Finally, if we wait long enough, then this whole issue might just
> solve itself, if the homebrew devs revert this quarantine stuff, and
> our current 'brew install' command might suddenly work again.

Good, we waited long enough, and this issue apparently did indeed just
solve itself :)

