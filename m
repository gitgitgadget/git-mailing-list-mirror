Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AC9A1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 19:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeBPTVb (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 14:21:31 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33021 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753945AbeBPTVY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 14:21:24 -0500
Received: by mail-wr0-f196.google.com with SMTP id s5so3951820wra.0
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zEPrHEP2ZUAZ1lYEYAF+NU+kOPN5z6C2Xs/3OKr5D7w=;
        b=dv8hzGIcQQaplKuq7d86C0ZanXcWdGEf7FEG2L84pECepYHuiDuAWo6/2gMiZQR1jL
         0m8uDQ4iNntlPoWMeemXShbSv7YC1K7U9UUPxBf+js1n8//3e8Xvm7NirgzJzh/D3xrN
         6rbTXhLgWBPWQF3ixWsxzcLt33QJL2f8rktB8fcavgdNNwkX4Del28mNxB+HlfhqMuG/
         bfdu3cuv71Stxm9bC5bOUlY0G3OKX3vnMEtEa75LIgDOXTIta7nyrTBtUNIx+V/+FzHX
         HDcYRw4J8pGh7IhSMl1aWyu9ugbugHD+7IQt4WR2hRIVy6EWx2da9yqKsl6mqkv5YJmI
         qLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zEPrHEP2ZUAZ1lYEYAF+NU+kOPN5z6C2Xs/3OKr5D7w=;
        b=Z5aK+u9E58zuaKXMKQELQ1JLoTpUnrJDhLfcMITVcx1kQZ9Mqg2YRHK11TgfFOYJne
         bEYmcjTwgixgtVzhrzv97rHKIe2R+bi0xkc4EGQARZxiXTfv8zMe0om6tGbridWIKIR5
         uykAk4N7eKNYEwFuEyeG6SzdDLX9Hs3pJ8zflURG10t8sogdKcdrqzp6FEA2KSN45k1t
         LfzCiw5I58d1KqIu+PB9Pb65RUCF4VKsC0COoHntz0vBwgaYSYMaEzmXPs4W/ROOQQe8
         kr2l6odu7mCRGIlULeTFsESlej8GULnmbrMGJWQnCzoLM8eK5f8MEQUTF5LTBI8cBCuJ
         dCzA==
X-Gm-Message-State: APf1xPDhnqIxZCbuQclh3GJwEUtEcIOPTPVQPBl6uic39JpGAEZwKkEq
        qj3F+C2BLv5MnaR9mdIDYWY=
X-Google-Smtp-Source: AH8x2268RiZ1a+Vjw3Jl1+HhuiJrsTkxkNiZsjW9K8gkPANxeDQ9sNRV2XNehEdcjPLW/uqr9pg/cQ==
X-Received: by 10.223.179.69 with SMTP id k5mr6365630wrd.278.1518808882895;
        Fri, 16 Feb 2018 11:21:22 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q15sm20942537wra.54.2018.02.16.11.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 11:21:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Colorize some errors on stderr
References: <cover.1518783709.git.johannes.schindelin@gmx.de>
Date:   Fri, 16 Feb 2018 11:21:21 -0800
In-Reply-To: <cover.1518783709.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 16 Feb 2018 13:25:44 +0100 (STD)")
Message-ID: <xmqqwozc68r2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Now, what would be possible solutions for this?
>
> - introduce `int fd` in `want_color()` (and callees) so that we can make
>   a distinction whether we want to detect whether stdout or stderr is connected
>   to a tty
>
> - introduce a separate `want_color_stderr()` (we still would need to decide
>   whether we want a config setting for this)

Between the above two, there probably aren't so big a difference, but
in order to avoid disrupting existing callers of want_color() while
possibly sharing as much code between the old and new callers,
perhaps:

	extern int want_color_fd(int fd, int colorbool);
	#define want_color(colorbool) want_color_fd(1, (colorbool))
	#define want_color_stderr(colorbool) want_color_fd(2, (colorbool))

We should honor configuration at two levels, just like the colors on
stdout, i.e. color in which individual items are painted (e.g.
color.diff.filename, color.advice.hint) and whether we use colors in
UI at all (e.g. color.ui).  I do not think it is necessary or even
at the right granularity to allow settings like "do color stdout but
do not color errors".

> - not color stderr, ever

This is my personal preference, but that does not and should not
carry too much weight ;-)
