Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C111F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeBVAVo (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:21:44 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52408 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBVAVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:21:43 -0500
Received: by mail-wm0-f66.google.com with SMTP id t3so661669wmc.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NHW5XZ2QujNJi+frrU7SGxjW06Vbz5yFa9ULM7yaqdw=;
        b=hcmr6OLsxqt4L1TpseJ+txEAOgjCyqhCxXn4mh5xhhbN8RtgaCBtRYJsXiF1HSBWlD
         3J86JLa6/jL1xe6SNfatoA81P+X+C5yLplzsIb7hFk+V5ssmGH3RwSQmYvdOUrtxzUGy
         TZ1nofv/GsoCKLfEw0fk9Nl/nSKHK+kkY6tTR8gSd+MueovXjOji2AKgbN61wXpJOAGR
         ngRXOkoxtJ1oaGSOn0l5NIHSP7nhSH1q4yTr7L7UnMcTcGDU7PHWSleusUmovuDsGxsA
         X479Wk3gIfhS5U7nTEaudvxtpp8q6ELjfDGF2lnGY2gLxCMI0EB3S52EbQyJP/HWWQf8
         O2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NHW5XZ2QujNJi+frrU7SGxjW06Vbz5yFa9ULM7yaqdw=;
        b=Ric3rpXx08JOjGSNluyNSuNEHYzgIraKqA7QJ4hMu5rRNa03kX686wT0+m2QngMvOg
         1wKD+quT5aoDW5Os19mscGi/xFSixdSx2nzJUej/0Yi0JC+aTCd7/56mjD/IX14+ieTj
         LfX2ht1V23F/jPLQSqIkOa4MgL56DZZR7Kvsx+HFe8mZGMHszWWDa0i45imtPh9TM/PR
         1sw4isF2LomtHN0wg6fQz475lfYZNQbkEZvXi2nJXZju6u6hPuJd49C/4yTsNTPnrok1
         6VWMSqcIEuikyJtIr73w4WIJ9X07GX/6SrVKGjrDGhKpv9bTLeq+7pqRgf8KiSksenNx
         SZSQ==
X-Gm-Message-State: APf1xPDDUqs+QceXw+j9DlF7ener1VSRclOX+I2xo1N0pLFJpN8HC1dM
        hJhM0sgOgTeFg4AidWrjDhw=
X-Google-Smtp-Source: AH8x225rZfhqWM8MX6mkkUVYgvyBZryILx7Nw1bHuiNKYTa4UtIcTP5mQF1bFR/5TvbaXySvb8OpkA==
X-Received: by 10.28.164.195 with SMTP id n186mr3531255wme.149.1519258902180;
        Wed, 21 Feb 2018 16:21:42 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a14sm11945818wra.27.2018.02.21.16.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:21:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>, tim@tim-landscheidt.de
Subject: Re: [PATCH v3 0/3] Add "git rebase --show-current-patch"
References: <20180131093051.15525-1-pclouds@gmail.com>
        <20180211094328.6157-1-pclouds@gmail.com>
Date:   Wed, 21 Feb 2018 16:21:40 -0800
In-Reply-To: <20180211094328.6157-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sun, 11 Feb 2018 16:43:25 +0700")
Message-ID: <xmqqa7w1yiuj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Compared to v2:
>
> - the potential loss of errno before it's printed out in builtin/am.c
>   is fixed.
> - keep update_ref() in sequencer.c non-fatal like this rest
> - rename ORIG_COMMIT to REBASE_HEAD
>
> Interdiff:

This round hasn't seen any comments.  Is everybody happy with it?

I personally do not have strong opinion for the feature but didn't
spot anything against the execution, either, so...
