Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68EFD2018D
	for <e@80x24.org>; Tue,  9 May 2017 22:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdEIWr3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 18:47:29 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33793 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdEIWr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 18:47:28 -0400
Received: by mail-pf0-f180.google.com with SMTP id e64so6690116pfd.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+8eKMP1FWCdziB5YYueEpFi3MVQIcX1+tqla1/tgrd4=;
        b=i2r3y0g5ffzzyFbJTwLKjvrw33QE1qOquawny4CkkAhtHXWVyX66ayOG1xSueHe1Eu
         qCulnNJIETJxuC0QXG+XAhveltTzf8lpHPE3iWW1B9vTk9Xd5Iv4v92MTSaOEv79vHTu
         IqYIEsP5sMD+6i18SsIxTmYssvUvNBhCY+3Xi1J1iUZgx5wblIqiiSLy+pxTXVnd4Ms1
         6zvWmBxmUPNJ9QCnqwv6/oS8zfZE4jvJUljMcbkEuEwnk+1lV6CQsCrBtqUCa28xdEXr
         cmfjyWkbZ/dRSftXSM02aMuwEwEphAbmXZSdmSA3BCdz344nNdFs/pPjIXBMaPE+o295
         h7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+8eKMP1FWCdziB5YYueEpFi3MVQIcX1+tqla1/tgrd4=;
        b=Gjf26qYCbjcbxn6YkPHDWlL9u9h0WTRkaWV/pgca3UodNdsfnIlsRftmSK4tupdl2S
         eJrw2BnDILOSVsuPvdKOy7Zh8Wnz/f1AAjHw52BN6/Jw1m/ZtfYk3nmY3v3wyXAmC0rL
         vsBi7BATmARbEB1we9rzYIMsE6IG153/z3+yMnp1WjEfX7Bha2+IuHfGKIeQnrJeyI8I
         Ge+BkD3YEg4LqG6b7HwQYnEo8MndPlznzdTN3AXGME/2Gm7M7u/Kn1QIm08heLA9jfaR
         quc3+qCUQd8bT5t6gFbhGSDSwKAPbYw3GvP8wsGO0FJLQUQblw7J/W7/SRBAIqEhl5sM
         i+6g==
X-Gm-Message-State: AODbwcBiba3104C7LhWbMpvEEHZmiWWs4/rg5mSNtzviy8tR77mdbMG1
        CKOfxyvJxL9HWQ==
X-Received: by 10.99.113.78 with SMTP id b14mr2785494pgn.223.1494370047486;
        Tue, 09 May 2017 15:47:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id t187sm1642323pfb.116.2017.05.09.15.47.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 15:47:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Script to rebase branches
References: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com>
        <20170509040943.j3n5li7fapiuvgbj@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1705091244420.146734@virtualbox>
        <20170509110249.eluxns2zz5jqh42k@sigill.intra.peff.net>
Date:   Wed, 10 May 2017 07:47:26 +0900
In-Reply-To: <20170509110249.eluxns2zz5jqh42k@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 9 May 2017 07:02:50 -0400")
Message-ID: <xmqq8tm51wch.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> That requires Meta/ to be checked out and up-to-date. I'd bet there are
>> exactly two people who fall into that category.
>
> Actually, it is not Junio's Meta that needs checked out, but rather the
> "meta" branch where you will find that "rebase" script. If other people
> find them useful, the set of scripts could perhaps be transitioned to a
> namespace that is appropriate to go into people's $PATH.
>
> I didn't really expect anybody to use it verbatim, though. I was
> providing it more for inspiration.
>
>> Also, I see that you do not use worktrees. Otherwise your script would
>> fail.
>
> Yes, the script predates the invention of worktrees by several years. I
> have occasionally played with worktrees, but don't use them extensively
> (I'd usually use them for a one-off change, and then remove the
> worktree).

I check out a different Meta/ at the top-level of my working tree
when working on Git, but I do use an equivalent of "worktree" to
have separate build areas for four integration branches.  It is
trivial to check out Meta/ just once to the primary working tree and
symlink it to others ;-)

One thing that struck me odd about your "rebase" script was that it
didn't seem to have a special provision to handle a topic that
builds on another topic. I saw toposort, but is that sufficient?
