Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467891F404
	for <e@80x24.org>; Mon,  5 Feb 2018 21:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeBEVMm (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 16:12:42 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:40019 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeBEVMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 16:12:41 -0500
Received: by mail-ua0-f179.google.com with SMTP id t6so19641328ual.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 13:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5GE6JutsniRJwoueCsFuYDWa0ccFc5JtahxK8l2Rsqs=;
        b=SZZdxsTO7ZIsrqMYoDhfBw1A+fygpAX1O6fQCVZkJ8EITEGLx/rSygpu62gQCe2fIG
         RCX9f4UlgPzGsprE1x3eEWXhj7+oLm+GLiX/pTFTm7+oVgcCwjH/Vj8BbZP2LN5MpMh9
         oG2wGmseP83OWo6OOXB5v2DQyvclAM+4XfuwoitIZyNS+14yU/Kcj32xLWGHO+o/O6UB
         j5VjmChnoTszKm61az8l27ClCV9+yf7X4LqOBBzhbvCopIEFP7BrGW0kTSkMAi3c6vDU
         RBVubmzXWB93Eto2/xgQzBG4I0o2jF8ex8eEsP5iwq3OqX/ioFU/HcU0Z+gJ/xZdulG1
         fZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5GE6JutsniRJwoueCsFuYDWa0ccFc5JtahxK8l2Rsqs=;
        b=DQADoZ4+V/PNLHh/JLWvgKY158fwWIM5MeZzYx4wTO0nJXAxlgmAo5mmHwT4OpisRA
         SMptl8ot1PdA3XSS/SzZnANRS5rQ7kwYHUn98qsfgdAY6S6Z7SIpoNZtKDmr+XUqCyh5
         PuV8ix5+c4gCJyOV2APXzSE0AE9j979RI6f60mlTtJRusihj6PwYCdUOc25bQVbXzBvm
         +VFx8BabR34Zo+940FxP4p7PxfsKWczE8drV+rZniEIiRPdQ7SWfgNhM5t3Sa5w6z2EG
         3brPRfF1rRWw3PTw3OA0oCvli/dTpOYqWdTS+FdbiOpFOHjxIUji60xzIpl37ll1kLXf
         uRAw==
X-Gm-Message-State: APf1xPDV49KbDE/jP363byYoIHA2junPKcmB4GHDuSZgZBmJUeuVL+Op
        YDKlr2DFHp08bbz25DGJF914XaR+FCyDgtHY9KU=
X-Google-Smtp-Source: AH8x227/tHC1bCDcGGVMa4frJ58nN9vljYHBMW+4oG2m7j7oSA2qzM8RjQwSktqW4Q4AofY44OLPQBZdNRfsiY8Dhag=
X-Received: by 10.159.40.35 with SMTP id c32mr215032uac.40.1517865159959; Mon,
 05 Feb 2018 13:12:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Mon, 5 Feb 2018 13:12:39 -0800 (PST)
In-Reply-To: <CAGZ79ka+Dd8Hr_CZwnkpYLnc38CiHPLe18OAbzjHBGUFv+Da5g@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-21-newren@gmail.com>
 <CAGZ79ka+Dd8Hr_CZwnkpYLnc38CiHPLe18OAbzjHBGUFv+Da5g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 5 Feb 2018 13:12:39 -0800
Message-ID: <CABPp-BEYomu+RsGzLvTUtFYM8ZjUSod8BXfLFUebxGSiT8m49A@mail.gmail.com>
Subject: Re: [PATCH v7 20/31] merge-recursive: check for directory level conflicts
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 12:00 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
>> Before trying to apply directory renames to paths within the given
>> directories, we want to make sure that there aren't conflicts at the
>> directory level.  There will be additional checks at the individual
>> file level too, which will be added later.
>
>
>> +static int tree_has_path(struct tree *tree, const char *path)
>> +{
>> +       unsigned char hashy[20];
>
> What is 20? ;)
> I think you want to use GIT_MAX_RAWSZ instead.

Indeed, thanks!
