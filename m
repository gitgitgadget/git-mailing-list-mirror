Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C371F42D
	for <e@80x24.org>; Wed, 30 May 2018 19:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbeE3TDS (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 15:03:18 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44244 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbeE3TDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 15:03:17 -0400
Received: by mail-yw0-f194.google.com with SMTP id p14-v6so6367540ywm.11
        for <git@vger.kernel.org>; Wed, 30 May 2018 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+h25JPmDKmNKmqfCQ+WQZ7cytnxMiAKoOHW9nj1RjeQ=;
        b=eOhC9V29aWDF9dQnSUAJ9DO2wa98ZrRSa0TdkNTzl2l3+bpcN+InYcVQoWaYzvj5dw
         mi4wIGgcV5ppFXAJnaM+FZ1vIdDAkuAFh0uSj/9J4bKOQGctFH13/tWyGpoFCvrcPaka
         /y152cKpLF45qSrRRdZ11/nvbOnUq724fzTrXgjeMOaVF3KC1jh6C5RnLZWXtbwPBPnl
         zLdjqEVQo3pUg/i906qZvPrgIsP7IXu9/QrMN602A8N2AjCdUNiIrzghrSm46PS31VSl
         JmzRQISyYhp/jWiy5raH/YAPEn1FtVL5VA+QtkSLj3+aJXF3ZgzRjaeAA3eey4ObKQeE
         xJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+h25JPmDKmNKmqfCQ+WQZ7cytnxMiAKoOHW9nj1RjeQ=;
        b=l2mydV3zV7Wcv6LELLs1QJsuxXenvk554QSIzMAerDqt1H4tvlkuu82zoi768ovkl1
         nDxr8iRn2BmFPNxfY/LCAIh2D0SQrhpRD3iO+NJU4JhXtRAoMuziNisvzYWVH1Bpto2A
         UJ3MyMbZ9ua1IJ8URNrmpLLm0EQyujowIjt5MCsQdKFteEeQQNooxAC5f/6aek9TVXDo
         V+qhYyzB/4Xbxu7igChR8XKwhpunCtXxwB8GKPJcSDAt1uIFD2se8fUoL+O5hSAbANVN
         oGH0aGCYJgmQFToQ6e8wgIiX1vVWavEtv2vZ2lEa2LQdQN1h0/dvxBvX1owanlyKfFnl
         +xqA==
X-Gm-Message-State: ALKqPwdztF94nY3BqPa4m6EQltsScdSkSfVaI31Pgv4FG8syN1Xutp/8
        varInX5kne4tDPzLg8Ew3anFgHQoSxCsle41G1xo7J3/
X-Google-Smtp-Source: ADUXVKKE3ONRzwjT995SYKC8clQyTu/1R9H7OTUt2KQSpGw846PWW7n05m0HSQlIlDbJncH6KE5WgO1Q3HQa3Z/aAo8=
X-Received: by 2002:a0d:fd84:: with SMTP id n126-v6mr2147220ywf.33.1527706996895;
 Wed, 30 May 2018 12:03:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 12:03:16 -0700 (PDT)
In-Reply-To: <20180530080325.37520-5-sunshine@sunshineco.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <20180530080325.37520-5-sunshine@sunshineco.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 12:03:16 -0700
Message-ID: <CAGZ79kZ2MKpjwwx0+ZsPZ9bFu_ersPJ=kKPYWRmWYjJ8yoVhuA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] format-patch: teach --range-diff to respect -v/--reroll-count
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 1:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The --range-diff option introduces the embedded range-diff generically
> as "Changes since previous version:", however, we can do better when
> --reroll-count is specified by emitting "Changes since v{n}:" instead.

A very similar option that I used before finding reroll count is
--subject-prefix
I still use that for RFC/WIP tags, but I sometimes used it with "PATCHv2"
as an argument, too.

Would we want to extend the niceties of this patch to that workflow?

Unrelated to this patch: how does this series cope with range diffs
that are not in commit-ish but patches on the file system?
