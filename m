Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 512BD1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeBIVkJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:40:09 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33842 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIVkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:40:08 -0500
Received: by mail-wm0-f54.google.com with SMTP id j21so405749wmh.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 13:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=137Lo4Z1kZy4Rqj0RYaOErwbBqUzzf0qU0eIkpF4z+Q=;
        b=DQezFBXXQN1fzf9wBW6NG0e3NvzuR+PkAAsIJpn0p1KP5w9qzZaf6GWI26yf2RU45s
         AvwHyXJFphYJkNsKWvDSuVr6oVL0Pc//KywkLs6VUuvpEtro8aKyzHXIha1hIQGOyndH
         OFjUOpD3O6+nJCYI3QrXySWYdGCR2eACqZbYjpyQiDtLubzgsXSji5LAdtyIkJmjRH6X
         N57P6bHkmVHooqgrXZgg2LU4/7pYdAtQvNE+6Iksb+lBE8ltARTO/CQzeWx4pD445tlf
         SRWt8U+cbTT7zv0fa/wn51CNU986T+G01xelb04+4Xx5mkItsbHBaLKYI7QKYeywV5B6
         3XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=137Lo4Z1kZy4Rqj0RYaOErwbBqUzzf0qU0eIkpF4z+Q=;
        b=uWyCMcNTh9xMuYZz5Vi/7VPGkPrlTkAOdulRAPBiLApcmBDmyRplMI7NLPCUnN2sfw
         bvIgA4vQtMlIGiwq+nJ7qErr960+wV2ckCTya9GZV7YTzwmZxCimQ9C/Fox3jKo7ymZv
         W+hFvM4dGZlgluDilOaF7s7jdZgKom6XBxcQfCU8+4V2WAWt6UwxwZoCTV/2C73E3Or3
         25qNMRLkvVfnHvmmTlUTYihti4ch7BFPQp6l4grPluNmDq/1T6Zm9dJapMb+F1AVZge+
         aprUUkng+X16F5VvW6PDZzOt0KfGOZYbkMIWdrx1CWn9m2ieEnZ1POxEqPzinUqbfwVL
         YKsg==
X-Gm-Message-State: APf1xPA1Z/xrrL1vtl4fze1gNQXEYPYIlbva/W9a0oYgeGvJtC13jHIU
        QXxI3B9AaipAzkks9GPHMSeUM8RO
X-Google-Smtp-Source: AH8x225FSkOQQqyiOcMowDKpsnLB+guKEJR82g1/fFjP/4EAdV+22ecan00kZMNUrNO9bMGOV+HIfA==
X-Received: by 10.28.85.194 with SMTP id j185mr2926631wmb.31.1518212406702;
        Fri, 09 Feb 2018 13:40:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 5sm3559520wre.35.2018.02.09.13.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 13:40:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] update-index doc: note new caveats in 2.17
References: <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
        <20180209210431.409-1-avarab@gmail.com>
Date:   Fri, 09 Feb 2018 13:40:05 -0800
In-Reply-To: <20180209210431.409-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 9 Feb 2018 21:04:29 +0000")
Message-ID: <xmqq4lmpx2oa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> When users upgrade to 2.17 they're going to have git yelling at them
> (as my users did) on existing checkouts, with no indication whatsoever
> that it's due to the UC or how to fix it.

Wait.  Are you saying that the new warning is "warning" against a
condition that is not an error?

> ... doesn't it only warn under that mode? I.e.:
>
>     -"could not open directory '%s'")
>     +"core.untrackedCache: could not open directory '%s'")

For example, if it attempts to open a directory which does *not*
have to exist, and sees an error from opendir() due to ENOENT, then
I do not think it should be giving a warning.  If we positively know
that a directory should exist there and we cannot open it, of course
we should warn.  Also, if we know a directory should be readable
when it exists, then we should be warning when we see an error other
than ENOENT.

So...
