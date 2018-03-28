Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4432B1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 23:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeC1XRb (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 19:17:31 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35764 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeC1XRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 19:17:30 -0400
Received: by mail-pg0-f42.google.com with SMTP id j3so1811466pgf.2
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5L84iWgkUzUq1y9Anirt5yptqN6EeKdBY1IJzhppf5Y=;
        b=kseZcdKbf8jS/U+BzB/XeO7duDdTOsQQPIUjjStZlUiRkmcsuyM6lzLibIEeCWEO8c
         7YEF/8ZMheX6vT0DYeQnXH1T9mNxEqyqBrJ7TRw9+IH6QeMPo36Gk2ZmtWCWLCijIG+Z
         dLRL+GpL7B2UnSYuuY5+MPo5TU4OYDmVBQW0HWFZuXg0kZO7rhxx4hsyPabU3LfqyzxL
         up0eC0Wb9nGpQGw4keITc2SHxpaBj6mKb20s4/H5PYrMDJtAR0JB3MbqQN18i7SQP9ii
         QeCIOQ+6VHclPJgn5iFL/EWI0SrMfFp4Z2kmMYs3rMdaA5CZKQU6sMkdVej7hjCjlUEf
         xx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5L84iWgkUzUq1y9Anirt5yptqN6EeKdBY1IJzhppf5Y=;
        b=e1eOYiJmuhI3Z+Dkrjkwm6piaB+sSGEclLt341LOslym0Sik/6XQse3+oQgGsSneyT
         0XUN7Pv2s8onXj6WhOEcgjLHEsx1X1RJGL/DqXkqvrIiZRaECIpVZcsEDuYbRyyUORpl
         qR/dIxk9is3XEBTQ6gCIF7msHfJ5Cs6HfAiK65npd3EzIRDFZobn/gmI0cdAFzGKo8uF
         Vd2tT+dB4xmh6FsK/bWTFNpm/ykJrtYW+tZIkT/1Ajk+Rs1dod/z35Hgfonx9Uh2hsze
         UgLGzjajjx26l5YqC0EhHMzIWmNRvs0pA0X2Eoi9pfvfGALr9++t8mmisO7qRNgP3G3n
         ly8g==
X-Gm-Message-State: AElRT7Gvyi0KlUeV/PAXdKQXAOgFf0F4j09gM7+TNJ3UQFnEB5kW9KT4
        iSB+vwdR77e6F3KXY1RraxDafS9+gw8=
X-Google-Smtp-Source: AIpwx49Rdv617SYsDwSMzswrzkcKirBEXaz6PdB44xGt/Ugfj6zxFXKz3Jkn/JKKohxkmwUoTMwZbw==
X-Received: by 2002:a17:902:51ce:: with SMTP id y72-v6mr5597994plh.157.1522279049867;
        Wed, 28 Mar 2018 16:17:29 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id i186sm6245179pfg.53.2018.03.28.16.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 16:17:28 -0700 (PDT)
Date:   Wed, 28 Mar 2018 16:17:27 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        hvoigt@hvoigt.net, seanwbehan@riseup.net
Subject: Re: [PATCHv3 0/6] Moving submodules with nested submodules
Message-Id: <20180328161727.af10f596dffc8e01205c41dd@google.com>
In-Reply-To: <20180328223531.241920-1-sbeller@google.com>
References: <20180328105416.3add54858bac92573d7d1130@google.com>
        <20180328223531.241920-1-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Mar 2018 15:35:25 -0700
Stefan Beller <sbeller@google.com> wrote:

> v3:
> * reordered patches to have Jonathans patch before submodule_free
> * addressed Jonathans comments on patch 5.
> * rebased on origin/sb/object-store to resolve a visibility conflict
>   about repo_init being exposed outside of repository.c

All 6 patches look good to me, thanks.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
