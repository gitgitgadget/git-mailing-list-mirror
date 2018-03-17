Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487B91F404
	for <e@80x24.org>; Sat, 17 Mar 2018 17:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbeCQR5d (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 13:57:33 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51290 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbeCQR5c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 13:57:32 -0400
Received: by mail-wm0-f48.google.com with SMTP id h21so8503869wmd.1
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=49H2phr3SkFQ8jbZ1KAYPa7qOeUrChF8d2Q1QWoFbpI=;
        b=FwITMkN5tUsg8SKBhw3+ky329kfB+OFA1zP3eo5nnpvIBrXh56S6kPXoK6OJgPIb5D
         ZZ78sDNxgQSkTTyCCl3XRXEASEJgTTc+HsPTYQvzqEvzvRi2KH0H3ZQGB9R51OCbKd1l
         CAISehvf/oquZjd8+eoIcE0hMYVYFLwBRPYi8YrmEL71mFcDVlII+oCDMRX2KlORL01G
         iFf/koXX50RBzl9Gm+v/Cyw1hXNNST8tWWwAB8rMeybvz96LoEIHU0O4DnNtCRc58Qbj
         xMv4J4ZxyJC8cOrEk+8YY1I88CxPPGlW+YzJupY3WmKxacaY5Qag5CKIPeFbGa+0l1Iw
         jVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=49H2phr3SkFQ8jbZ1KAYPa7qOeUrChF8d2Q1QWoFbpI=;
        b=RSybf7QwffczDQ7IMjSMTVxhDNUpC7m37cUyPnncyYxR7SwkgRFFLyMz7Jl/QV1vsE
         231KijU5wa1Hf5fErSsPRhgLMG+A+TkXCoeSycYaI2eSb9fHJ/m8axM4HyGyXE58yl/m
         Fu0JFTgjsp360gzu1q/fGUYOAmucJF8cnPNF73bKS09dFzmzBzSnXtmqwQDHeV3B5WBD
         FRLOzWqAwVl3JnHARtexh+zhx5tFRFQ0A/yFe1iz1mK4Oia3ZxwK3iGG338HN89F8Koz
         OjRyEa39nVzttAekd3m6AosBBW/LRcogsDIuIKP7hDxPg5uCWAOwyAQpcO3zrlpJdnbO
         e/4Q==
X-Gm-Message-State: AElRT7EO9aFAXrq7MYoTqotZUBS94OIRwZreEwtM7Kni/O8mU5s3jUHj
        zTnkMGHHt/dsuCp5BoJIltg=
X-Google-Smtp-Source: AG47ELv7G+ICugwx75dZLGeQT26mCg6732hqN53epnh2aw8R3B8yyqclMBSpSypro9u3rz08Lm90Ug==
X-Received: by 10.28.43.66 with SMTP id r63mr5066068wmr.93.1521309450260;
        Sat, 17 Mar 2018 10:57:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d48sm1316343wrd.12.2018.03.17.10.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 10:57:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        Michal Novotny <clime@redhat.com>, git@vger.kernel.org
Subject: Re: get commit ID from a tree object ID
References: <CANT8FXR3pMgbwVWmwssDYhgv6eMFw4+Uz5xARGwFVVU1cMVmWw@mail.gmail.com>
        <20180317130128.mr2sfsrncykkubwo@tigra>
        <20180317161819.GB25113@sigill.intra.peff.net>
Date:   Sat, 17 Mar 2018 10:57:28 -0700
In-Reply-To: <20180317161819.GB25113@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 17 Mar 2018 12:18:19 -0400")
Message-ID: <xmqqwoyay48n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you want to dig further, you can use the diff machinery to show which
> commit introduced a particular tree, like:
>
>   git rev-list --all |
>   git diff-tree --stdin --pretty=raw --raw -t -r |
>   less +/$desired_tree
>
> That "less" will find the mentioned tree, and then you'll have to
> manually read the commit. It would be possible to do it mechanically
> with a short perl script, but I'll leave that as an exercise for the
> reader.

Before Stefan jumps in ;-) I wonder if a recently materialized
"find-object" option to the diff family can be used here as a
sugar-coated way.
