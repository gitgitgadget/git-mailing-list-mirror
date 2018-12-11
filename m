Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090D320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 06:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLKG4V (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 01:56:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38702 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeLKG4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 01:56:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so983679wml.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 22:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sMRDg4JUg5tLWfec6JkaBxzoMD1ToRU8ygeZMjz+kD8=;
        b=HO5XkLwf21Hip0hjzGb1/J+FBEjgibi6lGet14gTqZBl6uDxrepbTODuNu+PDF+HiD
         KnwV/wfjDzEvElNPGVhUTSaovvNr9rUasvG7diFoFEb6q6Fx2uFZEJwyvmx+EhyaR65B
         oFFGhqOzy7s3QfgCAckvoupZH7DJT/4fwnk0ucX46i7ijp41XcPpGvHEMbWvQquPTDa8
         5W/N9bbpn2C4Mnl0xi51SSQiqdgMVWp7PL+Fx5P69iGN4QVEpFo1D0U9b9wOHvgr99bW
         BNwvOpPhW2fKFJFaQ6iOEADDHwbNfKpH1jKgEL+ShkLVzYrEandod5FORqmdWNvXUfpk
         NyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sMRDg4JUg5tLWfec6JkaBxzoMD1ToRU8ygeZMjz+kD8=;
        b=n4ah20AKz2FffOrsnw7FRe+dpr4kQANfXxk5KuAyLu/QaXJw7iQSFr6ql9wERUllPY
         UBsVzElPwpSckHOZjyp4mFFjBwqow4eb6TZasGKnr1IBr3MKNYnkqHx1IC1lXmVDyJrR
         liGHFWa6565zzKvDGVOWW8MZmgTIEVPuMhMR/yf5L1oivIBgy0uZF9VL1bwIFaXYU7Wf
         l4Mps7jO1Rjpm5E84G3wjyqHUgmit1Yw17MSSjYkhNynxDRwozSGKK/C2+kbEv9rZsZM
         4cR0oTr3/48SvlIKSHqE5cbqbDoLt021FwFqD1BRkL/KoVkgfhGxYf0u7JVnzwokFOqW
         b8Lg==
X-Gm-Message-State: AA+aEWZGesbMEhCcWhiTYG9brlKJAOX41AAiR6OAJAfK015tUB6G0ATb
        y3SUc/R3ctlCNLyoUWgNLc4jz+VG
X-Google-Smtp-Source: AFSGD/X7R2lAqMHfUP/Vu4g/EK3LLiSo4GEnxre6XmkShV5+F9VSUELZx8q2hS0H9DkP7bmjSZwenA==
X-Received: by 2002:a1c:11c1:: with SMTP id 184mr1063029wmr.59.1544511378765;
        Mon, 10 Dec 2018 22:56:18 -0800 (PST)
Received: from localhost ([2a02:8070:89b1:6700:82ee:73ff:fe95:bfa4])
        by smtp.gmail.com with ESMTPSA id c9sm1167233wmh.27.2018.12.10.22.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 22:56:18 -0800 (PST)
Date:   Tue, 11 Dec 2018 07:56:17 +0100
From:   "S. Fricke" <silvio.fricke@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] http: add http.version option to select http protocol
 version
Message-ID: <20181211065617.nuvpoxdhuqgwcbrv@sfserver>
References: <98295da2b5295795414eaf85a40b9ae62b1b2dca.1544482124.git.silvio.fricke@gmail.com>
 <CAPig+cQW5_9fH-P8X50Mx5kGJRwEOskw2L49Ajk+3D4xWpcOHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQW5_9fH-P8X50Mx5kGJRwEOskw2L49Ajk+3D4xWpcOHg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,


> On Mon, Dec 10, 2018 at 5:50 PM Silvio Fricke <silvio.fricke@gmail.com> wrote:
> > HTTP has several protocol versions. By default, libcurl is using HTTP/2

[...]

> This looks very similar to [1] which is already in Junio's "next"
> branch (although not yet in a released version of Git).
> 
> [1]: https://public-inbox.org/git/71f8b71b346f132d0dc9a23c9a7f2ca2cb91966f.1541735051.git.gitgitgadget@gmail.com/

Thanks for the pointer. Looks like I need todo more search than to develop
solutions. ^^

The 8th patch version from charlieio@outlook.com looks better than my
implementation.

Thanks and bye,
Silvio

