Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2BE1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 12:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfKBMU1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 08:20:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45997 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfKBMU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 08:20:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id y24so5500169plr.12
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nB7+sFNtMxsTxmRknuKTVyqXUiQxSo6Qu+cLXsjvC6U=;
        b=kZ6ArYtsOYKbQ20D3H0y/4djxZuhoW+XNVV8jtb+r8BiqoAdDnsNd7JkWEIwi/+oA1
         AKblbkPXMorblzB524MVXnQkM9axUv1sXXYP2S/5FXXDcJV067/TtGaqKXgPIICOnTVJ
         iwaeIfmsezTyWgfHmSJ77xCX7XD6vXxh5FNxfxMLj9lL4jQPuPscU5ATdNlhsYnGe873
         xii7MRJtW4RlfZWj64tIYSgJyRSP1MOBB21JqtWnOKDY6w566G96t1ACWY/M3wHvlKdy
         YCBqGE9pSDhLsfnCu6aYovh4zgywXomoeSKyFMdPZl+xYxYBx6OAE7liN+Ny/GOfbkna
         5GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nB7+sFNtMxsTxmRknuKTVyqXUiQxSo6Qu+cLXsjvC6U=;
        b=kD3S7Y1cjrTivZouxWJa3d/X9jNZYtmudbiHs7ghKGl5FcZPlXek9fa/dN+g71ffgu
         NHU66dI3pB6UEllWn6bgwmHUkHL8ske3y4QrVH64O3bJjhurwVKoeG4lmCW4oJj9B5M/
         wtMzg1RrqO+6mtCtyKZywCu3BcWo69+ye/1mOnCq4ynKlXBfbs8W2SPPZklKtWKsg/sX
         8r+uTCHftVySZDB6/YlaASolO4y8n+WmrreCq4qDc4fGLGIXqaui4WCzThksILmEStVa
         BHhQiHrwIdnlNuTZEgbPxEdwuNLKtMf+t5MtU3D5UtrMH/kplkoGrZozcGatc398RFgX
         50gA==
X-Gm-Message-State: APjAAAUjgMTzewTbbKeiwrqYOLVQhm1Wxn5D6dKst4QcEDhJpPnaNUnw
        L8JtlvTJo2ApL+RWs/7CRno=
X-Google-Smtp-Source: APXvYqxwzcUThZfAWt4aAJEpI28bJw4eEMRbDv9iSssEdnZkj8lxwcfoO+cPEOehqr1JadTMbOmwrA==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr18248723plo.134.1572697226205;
        Sat, 02 Nov 2019 05:20:26 -0700 (PDT)
Received: from localhost ([2402:800:6374:e1c2:8c5a:c959:6fca:fa1a])
        by smtp.gmail.com with ESMTPSA id e17sm8573599pgg.5.2019.11.02.05.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 05:20:25 -0700 (PDT)
Date:   Sat, 2 Nov 2019 19:20:23 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sequencer: reencode to utf-8 before arrange
 rebase's todo list
Message-ID: <20191102122023.GA7468@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1572596278.git.congdanhqx@gmail.com>
 <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
 <20191101165921.GD26219@sigill.intra.peff.net>
 <20191102010215.GB17624@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102010215.GB17624@danh.dev>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-02 08:02:15 +0700, Danh Doan wrote:
> Anyway, if we're going to working with a single encoding internally,
> can we take other extreme approach: reencode the commit message to
> utf-8 before writing the commit object? (Is there any codepoint in
> other encoding that can't be reencoded to utf-8?)

With this test (added into t3900):

    git checkout -b fixup-ISO-2022-JP-ISO-8859-1 C0 &&
    git config i18n.commitencoding ISO-2022-JP &&
    echo ISO-2022-JP >>F &&
    git commit -a -F "$TEST_DIRECTORY"/t3900/ISO-2022-JP.txt &&
    test_tick &&
    echo intermediate stuff >>G &&
    git add G &&
    git commit -a -m "intermediate commit" &&
    test_tick &&
    git config i18n.commitencoding ISO-8859-1 &&
    echo ISO-8859-1-fixup >>F &&
    git commit -a --fixup HEAD^ &&
    git config --unset-all i18n.commitencoding &&
    git rebase --autosquash -i HEAD^^^ &&
    git rev-list HEAD >actual &&
    test_line_count = 3 actual

reencode the commit message to utf-8 before writing the commit object
is (likely) the most simple option to fix it.

At the very least, the commit message for fixup/squash-ing commit must
be encoded in either utf-8 or the target-commit's encode.

-- 
Danh
