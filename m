Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B011FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 03:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbdJLDyd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 23:54:33 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:56727 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbdJLDyd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 23:54:33 -0400
Received: by mail-qt0-f179.google.com with SMTP id z28so8902100qtz.13
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 20:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O1zOCOhDpGVUE3a6Cl/vS8eqI918K1pRkRTmHD1M6G0=;
        b=BwuVdExEvmDDB1t2ZlwRZGbldOUWhvdqoME6/ZmOlff7HwLB1EV/6W710bbIrTbqbK
         NKc0Wg9djcV01imf6htTYx/SRC/yeeR/MLPDteo5HmmlgqQD5fRJdabgc/lsHjYCVYSl
         FuNNYgke7twI1OBFDFObxzWRZcQDFwrExZbY+iKZ1nlPc37PuHDH8U02ECmz+zkVScD8
         v9xbynf+UVqVDqgnZsPuIhTfek+S0Umj0GUyTXDCYF82cM6DGJ9FNTMp3vgxyjuFrT0W
         OnUP52zJBEqFPMnsRECJHEXeUkUUZ+6XzmQvOj4mkUYlXjACDn/2cIaQnD20MEjZp5aY
         6jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O1zOCOhDpGVUE3a6Cl/vS8eqI918K1pRkRTmHD1M6G0=;
        b=mY4SzOXnFt9Ig5WTeLhUp7mEixAs9tlnm/AB594AE8l2Izosg3ioEEb+yu/6EK9M22
         ar8jBGFC2VxknjxXjN0EfWWzzftr7TPv1Zqv0TWTK7KNpBPtVoyiSbjgEhi1y3Dvnoz4
         8vxh11QI4pIifE3VDyNDL7nzAOJH1YOknqgw0y5ybj2S1+6cf3litNDDrxLBlrcCUlWn
         9rpzfkAkCy2E0eO8MCUCgo9B9HA1wLsHueT77m2A0CNSUbKILOZNzTn1cz7b+aUb3kGa
         +C8OdVBkzLsSyYgfZiUz79oNpgw7H7H3iLktBsAKC0mF+9f9f9oNjhly34a79oC1nt4C
         5kVg==
X-Gm-Message-State: AMCzsaXiFohATmT/LwcGtTWbAAHtFyTdgZE30D3kbxrTed87TtCxdL7d
        8gI0Nu458DR20zcxn9SWEckWkfhZ17WHl44XzwY=
X-Google-Smtp-Source: AOwi7QBYtlup8liLDZWDd9a+QQs515O0844JB6EPxwh8Eaf0ksTJdmZEEH4vCGMFK0zXTRpZ20iq77MP0NmGnQdN+3c=
X-Received: by 10.200.41.105 with SMTP id z38mr1758941qtz.106.1507780472435;
 Wed, 11 Oct 2017 20:54:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.32.226 with HTTP; Wed, 11 Oct 2017 20:54:32 -0700 (PDT)
In-Reply-To: <CAC2Jkr+zFy9q4Xnzxcqj6rq9+TOs2sO9J5Wx9ccd3oiY4N20uA@mail.gmail.com>
References: <20171011180350.99888-1-takahito.ogawa@datagrid.co.jp>
 <xmqqr2u92nkr.fsf@gitster.mtv.corp.google.com> <CAC2Jkr+ZDUxd9JcKvVwZqCHVW+Bpp2CbdyehwgKV_Ru-Uqxo8A@mail.gmail.com>
 <CAC2Jkr+zFy9q4Xnzxcqj6rq9+TOs2sO9J5Wx9ccd3oiY4N20uA@mail.gmail.com>
From:   =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Date:   Thu, 12 Oct 2017 12:54:32 +0900
Message-ID: <CAC2JkrL01G-j+Dxbog9Lq95OKsLpVv6OjV=qg4h0-nwneZ+Oog@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As you point,

    git stash

without any argument is equivalent to both of

    git stash save
    git stash push

. The original sentence is correct.
