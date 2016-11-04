Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11F72022D
	for <e@80x24.org>; Fri,  4 Nov 2016 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761476AbcKDVgC (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 17:36:02 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33156 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760630AbcKDVf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 17:35:58 -0400
Received: by mail-qk0-f174.google.com with SMTP id x190so112394153qkb.0
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Aej56stMW4U/9QbcmF0nB5v9FDG/+8zvOb7Jm/7cLjA=;
        b=Hj6eot1MxGHqsu8WONfA99iW7TYcBrxhsUScDTfwLTOdVSnyLjELLv+3sMweLjP1ZB
         mDOIE313Qc/KPo3aFUXCejMv2tZ+RR6CHHcmjbxUVU1bZ4QkNDeGTqaJuyQQ4SOoXmqY
         fr1SFPf7o3/GTDCvpViH/Ck7Dl/JQ/3kPMTtMrKruPGsjFYXelWTNvR/1W5cvZCUFY7z
         2fvnycqF/qING0Md5ozzv+shUIOu0Vq0OoFZ2PzlB1XcTUdLggU08+lpbexxfGndIzeG
         FZdQBWsR3nPErTPoPA9ggxEgmvigkFxXMZQ6gyyAwkIc8FbQvcMP7S6uwgsH6avf5xTi
         xSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Aej56stMW4U/9QbcmF0nB5v9FDG/+8zvOb7Jm/7cLjA=;
        b=aFsWuUNJZdcrM2ROh9fnt1En3HIBBHCnC0dBDJhc6QlGSoXpX8dWPkodSMzYcx6YvY
         U+3S3rDmicQYmTreTbNbHkaMwDzW4MdUdWC+pCKvfP1+DfH0Xk52Ln3ILhccNAD7OL+0
         V0iBai4t7YNdgD/rtGapkC+e8h81GAAk7c4JMFb2Oei4dRKW0z7NczXNm3ChLxzTkthJ
         LMiS4lPYdMZdavLpwnjMlR6Bieqh/BaMzaHxldD5Meuks6aeykiALfX5pJEBPrgplDZ2
         kdXL/bk/3lhfTD95psPM/3zqH3UcHaaD318OnLBloeocZfYNSpS1drCxW9h1sAMbDo4N
         RUog==
X-Gm-Message-State: ABUngvfDCV8cBqrctuvw7Tobj365so2Fr804sQAVSgF0kDzNPHPTMCurVdws3ruEt9iOkuI15M5pR9WWan6ex+bv
X-Received: by 10.55.16.147 with SMTP id 19mr14876130qkq.255.1478295357911;
 Fri, 04 Nov 2016 14:35:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 4 Nov 2016 14:35:57 -0700 (PDT)
In-Reply-To: <20161104205815.GA127933@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <1478292933-7873-1-git-send-email-bmwill@google.com> <20161104205815.GA127933@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 4 Nov 2016 14:35:57 -0700
Message-ID: <CAGZ79kZB9wMgPDktMUpBfcvgJy16N8P74SvLP5740UNftZkbVg@mail.gmail.com>
Subject: Re: [PATCH v3] transport: add protocol policy config option
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 4, 2016 at 1:58 PM, Brandon Williams <bmwill@google.com> wrote:
> On 11/04, Brandon Williams wrote:
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>
> Is there an acceptable way to give credit to Jeff for helping with this patch?

What about:
Helped-by: Jeff King <peff@peff.net>


>
> --
> Brandon Williams
