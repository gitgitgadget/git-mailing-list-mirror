Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECAEB1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 21:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfBGVNy (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 16:13:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43042 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfBGVNy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 16:13:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id r2so1365215wrv.10
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 13:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kbkJe8toe/fRJAc97q20UgQP8FN8/EwIHoYHdQHM2WQ=;
        b=SwtrOpLKN93cemwUp4iaF07hQlqAo4eXZ9wW6C3/us+FPvisRH0M37ajkyL/UR2CEO
         pfosbM0ZOpy3urbYjLnFTZ7q4gHntjlP6SciupSqKZmnTV6/G1Lp/E7L83xPupK7zdE7
         HePcTQxVeMFCPx7m/QQ82ZTv0qIhGcd2CGvcPkecMupMnkhMVKQpODGupbhSG5OaKSm4
         rvKioKqRJ96tQqb7M30vKWDSXhxM3em8zyz/58O6qio+MF/l8wrHPyUWti2w1fTUuB8i
         wshfTrQ+S+meP4xKNuhYNOy5oArBg4ZWcjGXbve0yGTo66xdKqegwVW8gOm7xW0i4vUf
         6X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kbkJe8toe/fRJAc97q20UgQP8FN8/EwIHoYHdQHM2WQ=;
        b=oWrW8v+pqtwVC6Dm2sjMBOKAfzzfgmjHhZpQ921ozhMWXA8Z8J7B6TkUe5vLtLczKM
         LL0IfJHP11/OSac4YAkWYBnE2vVUIbrLYPVxkO+BFNiDSIu5n7QYJRxyiY1C440Sg0fO
         4XvViD+mQWXNW3nkuuPMgqjYoD/1KgjW0ZHKN1L5RGBs59FUXeYBLPsOtBv/EMTlPrL5
         j7RwHvCcBOLGtZ11+/zmMrdFV9rswqS3PTkrNSWdLDYuUa7F1aUhyg0XE66DjcP4BvgG
         tegaN5MRve0OAhdtZJOfRWfWWpUQKHFHNy7k+XFKama3RBYjBWjeckDPg/HSGHBYN2fD
         fWfw==
X-Gm-Message-State: AHQUAuaV2PAozidVPtHSQbvqgAzvfYU6bz+1TZ7069sQde/jHvTH6UNb
        YnUb017DFw8RkoVg5jYRP7pxU0BF
X-Google-Smtp-Source: AHgI3IZ9anXZem8KitZe7g2/ORzDthBsDFksNoFfXV1xfIWFAkGc6v1OoPpn8bmjRetjdGr2UZU3bQ==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr14270817wrn.276.1549574032455;
        Thu, 07 Feb 2019 13:13:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g3sm278837wmh.20.2019.02.07.13.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 13:13:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix incorrectly reported CPU in 32-bit Windows
References: <pull.121.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Feb 2019 13:13:51 -0800
In-Reply-To: <pull.121.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Thu, 07 Feb 2019 02:46:05 -0800 (PST)")
Message-ID: <xmqq36oznvxs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This is yet another patch I forgot to upstream, and I hope that it will make
> it into v2.21.0-rc1.

I guess this affects nobody other than you and perhaps J6t, the
point not being "there are only just two" but being "all of them
know how to deal with possible breakages if any in this change".

I am tempted to bypass the usual "from pu down to next down to
master" dance on this one, because of that.

;-)

