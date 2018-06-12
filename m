Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8801F517
	for <e@80x24.org>; Tue, 12 Jun 2018 16:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934454AbeFLQ3R (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 12:29:17 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33025 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbeFLQ3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 12:29:16 -0400
Received: by mail-wm0-f48.google.com with SMTP id z6-v6so20309709wma.0
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6avfgDhRWpg0Ga4OwQq/FEbVFH4Di4Ib2f5JlMxlic0=;
        b=fl0XzgBtbUq727fyhG6sP9nJQXQ9sk4w1P121KQ2kUzPGnRZPoP7dHAtiM1XVVaKhN
         VlqFw3bEuLVRZRDQ4lReVjH3wg2FDucUt8fwXBdOXjOaPtzdwI1idwIBgY17LYkQbVxX
         CxpnbF/6yDnZ8NTxcOvTceFJ26Ve1+Kqu0A3kMiZ2+Biff1pbnJ8ZBFCrTuzaB01MiPC
         d300iGK/FsQ4J0gWtOiGw/yPKklIrM0T0gXYhod4+m8CQlXWYIRXppHqpvChK/GsZaNu
         ak8qNNv7YDZlrV8Ln3neuZmrgWnYoDlg83hhvBTAYyga+1cIz+HUNX8Yb5DRL7m06GXe
         xgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6avfgDhRWpg0Ga4OwQq/FEbVFH4Di4Ib2f5JlMxlic0=;
        b=CUUbqv0qDVKXgNtXfUII0dyfP53u6UmVyMLgS3CFN4T8/zPc3rE5JD7scxX9UBUIwF
         4UbZQzospcOmdR/GiOov9WHTpXZ+BC6EwVSUqRQA7AnzAppWWsJabaipPNo5kZD660hG
         u+t7bdayQUi9zjwMYVrww8QFUEh8vftIW4xQqh3kzR41Qpt5t+4YqfOUwC9EEf39cVdl
         mCXEBrHsB784keS2juB8Bx4r9Mfa9otKMP633Bze/GeuyX3CPacO8oSuIUxXub7+GJo1
         hcGxhb6PmHwp2d7hRqtQtenqdgybxAfLG8/uT+CQqDNsaI5BZQ1ivKuIhyR1HLhXijdB
         OxCw==
X-Gm-Message-State: APt69E23Iat0e64FufhvoBxbabouudcF+A7JkWuS1RvLirnfGZBMd9qF
        X4l/xK08yZfw8FGecJqHC7k=
X-Google-Smtp-Source: ADUXVKIihwWR0bfy96HEOkvBOrZUu/NNy6MmVwldpWLkZHs8PI28i4eVSFrupLqJaQ1YEdoQZOryvQ==
X-Received: by 2002:a1c:3e04:: with SMTP id l4-v6mr746746wma.85.1528820954700;
        Tue, 12 Jun 2018 09:29:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 12-v6sm1307492wmt.19.2018.06.12.09.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 09:29:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
        <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
        <20180103053516.GB87855@aiede.mtv.corp.google.com>
        <20180608045028.GA17528@sigill.intra.peff.net>
Date:   Tue, 12 Jun 2018 09:29:13 -0700
In-Reply-To: <20180608045028.GA17528@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 8 Jun 2018 00:50:28 -0400")
Message-ID: <xmqqzi009deu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> To be honest, I could easily see an argument that I _should_ be setting
> GIT_SSH_VARIANT to explain what my wrapper is expecting, even though it
> happened to work before.

The way I read that message is that the patch proposed in

  https://public-inbox.org/git/20180103050730.GA87855@aiede.mtv.corp.google.com

is "lesser of two evils" in that it is still evil because somebody
still has to be asked to explicitly set "variant" anyway but the
changing what 'simple' means in the middle would mean those who did
not have to set it now have to.  So, you should be setting it, even
if we adopt the patch, right? ;-)

> But it seems like this discussion ended in
> favor of calling this a regression that should be fixed, and AFAICT
> nothing happened after. So I thought I'd ping and mention one more data
> point.

My impression is that regression "fix" does not exist---rather, it
was a proposal (and it may make a better tradeoff than the status
quo) to help users of older OpenSSH by inconveniencing users of
different implementations that do -4/6/p differently from OpenSSH.

In any case, from where I sit, I am still waiting for this offer
by Jonathan

> It's good you caught this flaw in the detection.  Would something like
> the following make sense?  If so, I can resend with a commit message
> and tests tomorrow or the day after.

to be followed up ;-)

