Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E7E20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 17:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeLKRrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 12:47:07 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35232 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKRrE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 12:47:04 -0500
Received: by mail-wm1-f49.google.com with SMTP id c126so3211992wmh.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 09:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WRrTVEAwgWEbkcstxUyGEv2Ko4zrLNKnS3UJOjYiBsE=;
        b=lQSNmAWhMrGkH0XuMc8N9qMof2a7ES5dFS1JnfHOb7MN5SC0oB7WUNppqK4C5WYfCX
         RTdd0KxFBs8GN2tWJZf8uSgKd22RHYrXwEidvZ1hIazNVbCaixVBHdwDd8BAgJZiOvX7
         bzAwDc9PFNA03y/FlpaFhe+tsMxCa7meibv0nVDb2E0sqrFxCvmbzN0Iug8uYtX9rtv7
         Zyw9wyuG/VjgDyXbuIVNwYvEW41puNlwJISqGoeIwEkp7h1qMZ/OQFMbTA/Z0pWN4mzJ
         Qssg+OhpeMWemlKEsVCn9oZjMmPDvZsVyQhW3vajo8lLms38yrzEEXzB+dh0sMwiopEr
         947A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WRrTVEAwgWEbkcstxUyGEv2Ko4zrLNKnS3UJOjYiBsE=;
        b=JaAcHHKAjG7DTvCBZ65cV8nTrMGe5jg7MVWvfAZfFJ8m+VNWJkBifWy/J+gPKFxuXR
         nQcl5vYljC9r246ylEHXNPvOBFn4VzIUATLAZygCKRcj3Aju2fPi290usMPX/z9feVYU
         0xArwMg3/F3ogT4Iat9/Qk8cKzUUHvJOdE1FsAAjM+hV3ojRsgXs5z+1N2kgXB9wgcLi
         dCppQtLTptQjQTAQ928yxF6cmtkdrJBGCSycmV/8/IG64sgpKOIj+oze4W7ez774D1IB
         N6DagLewW2IEs4SClU0piNrgZOQ10Dit2Wv34V0H0FJCoZK1i+GjoEeBw3aDFqSvMi1Z
         LSyw==
X-Gm-Message-State: AA+aEWbM3lMC8IFi4hCCPKf0aLoTp1zRmI0oxUeYEYZvn8ColfgK3MKK
        BLK+G5PhAIO/QJ4H8JbWrGY=
X-Google-Smtp-Source: AFSGD/U+nRXx0r3WJcu2x7F5vA1MdoSI5eqNZmGysyQTJYphaw851eaVcvGsn/EVXTifo7rK7g9rlw==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr3235028wmj.142.1544550422841;
        Tue, 11 Dec 2018 09:47:02 -0800 (PST)
Received: from szeder.dev (x4db2a4b1.dyn.telefonica.de. [77.178.164.177])
        by smtp.gmail.com with ESMTPSA id g201sm567957wme.43.2018.12.11.09.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 09:47:02 -0800 (PST)
Date:   Tue, 11 Dec 2018 18:46:59 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Sebastian Gniazdowski <sgniazdowski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Git 2.20: `git help -a' hangs if specific git alias occurs
Message-ID: <20181211174659.GU30222@szeder.dev>
References: <CAKc7PVAzSOknfmy7p09zF4LOi4t66CBmd27ZuQ39_wKYWSiiUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKc7PVAzSOknfmy7p09zF4LOi4t66CBmd27ZuQ39_wKYWSiiUA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 06:30:26PM +0100, Sebastian Gniazdowski wrote:
> Hello,
> I've attached a screenshot for running `git help -a' that ends in a
> hang and ~100% cpu usage, for the following ~/.gitconfig (it's also
> attached):
> 
> https://raw.githubusercontent.com/agostonbarna/dotfiles-base/master/.gitconfig
> 
> So it's hangs on the alias `remote-origin-https-to-ssh'. One user in
> following thread discovered, that it's about lenght of the alias:
> "abcdefghijklmnopqr = ... is ok, but with abcdefghijklmnopqrs = ..."
> it will crash, "the problem occurs if the name of a git alias consists
> of more than 18 characters" (see the thread:
> https://github.com/zdharma/fast-syntax-highlighting/issues/95).
> 
> Is there a workaround? Of course a fix is needed, but I'm interested
> specifically in a workaround so my Zsh plugin
> `fast-syntax-highlighting' can work without hang also with Git 2.20,
> without exceptions in code.

Have a look at these patches:

  https://public-inbox.org/git/pull.97.git.gitgitgadget@gmail.com/T/

It sounds like you hit the same issue.

