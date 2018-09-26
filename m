Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F081F453
	for <e@80x24.org>; Wed, 26 Sep 2018 17:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeIZXmc (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 19:42:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36991 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIZXmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 19:42:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so27814227wrr.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lsfetDWweOAtbJk75py+Z6x6Ni5+lC+4TdtR+3vW/KI=;
        b=gulU0cva62j4VU6j7BVYjHxdcqg4euHV0Pux0DvIfsJVjFgkGO2wbgRCbvK499RQcF
         gTMS5DYmgSi8tls2SDsNDChTPU+e+zBr1du0f35iY33q1EM2qhOXkRBHRpeHgTzGD5I7
         zvBZ/O7II7yq0LmDGzyMwE22RVNvxl937t3vRAFvCRNlwQ1H1xLo/JEusaM3jQj4y/vH
         2zgDR6d7bYMRvxPI8gNHHS85tyFeqYhYTEH+13RCzU9YUldeN0/fYAUqgLtQDTZpztpp
         yb8mqVztI30cE+ArT97uYGuZX9skk3VQbTXHJDiH588ixnSLkWta8fGv2pxo51XHgDMK
         xKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lsfetDWweOAtbJk75py+Z6x6Ni5+lC+4TdtR+3vW/KI=;
        b=Y/UsRZk9HTYNumtJ/3izBHoxm1YS2iXsB7aJsukFPgxqD7Qm898LD6j8oVfmU62TkW
         E4mfHBIcXJEKgdfVYNSJSHid6i79BIJMu8Ozknlf1XdxgKG6p3AYfBlk7CJ9BYYS88o+
         KztL2q+49r29bQfb8n1qyo7+9+MzQnwFGIBlfhPeGVG70svd35bLiuS44lCUkaJ5RNvU
         H7NawwCnFKjxt4xzaStnXWsiH559tof63V/9XzR6Nqk9Aqgrv249EnRV3JkeOHIOE/s4
         /Nj4Qloewl0px29SdF1i7bXWZ+ilm4dqtb6S+zns+DN8VtVtkFmQ6F5GM6BE3NeDR3cc
         as4w==
X-Gm-Message-State: ABuFfohEdJZ1iS383wxBxLeVucm5wrMzipvgVqOEcX5Rfq4iVb5ohcOn
        Ix93Y6Qf2bzESuAz35eqtFkzRuLL
X-Google-Smtp-Source: ACcGV62KQPmDy8JqrLM1YAKGvxKklRMKtP+ZzGMdjBYprmwjuA9u6GxyumifXYqmjNs07uOixTF4GQ==
X-Received: by 2002:a5d:5391:: with SMTP id d17-v6mr5970165wrv.191.1537982912301;
        Wed, 26 Sep 2018 10:28:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w26-v6sm1121564wmi.27.2018.09.26.10.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:28:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git help: promote 'git help -av'
References: <20180922174707.16498-1-pclouds@gmail.com>
        <20180924181927.GB25341@sigill.intra.peff.net>
        <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
        <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
        <20180925174451.GA29454@duynguyen.home>
Date:   Wed, 26 Sep 2018 10:28:31 -0700
In-Reply-To: <20180925174451.GA29454@duynguyen.home> (Duy Nguyen's message of
        "Tue, 25 Sep 2018 19:44:51 +0200")
Message-ID: <xmqq8t3omam8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Here's the patch that adds that external commands and aliases
> sections. I feel that external commands section is definitely good to
> have even if we don't replace "help -a". Aliases are more
> subjective...

I didn't apply this (so I didn't try running it), but a quick
eyeballing tells me that the listing of external commands in -av
output done in this patch seems reasonable.

I do not think removing "-v" and making the current "help -a" output
unavailable is a wise idea, though.
