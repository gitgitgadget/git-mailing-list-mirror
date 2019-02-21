Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E211F453
	for <e@80x24.org>; Thu, 21 Feb 2019 21:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfBUVlK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 16:41:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39535 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUVlK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 16:41:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so116039wrw.6
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d64EjQoW4MRYWDa4TRvA2PUMvbnV6no72KEsThEAne0=;
        b=JaJZTaSuRcsn7hYM7FxKcqLpEO9kQfMLIgpVrg0NKRp4P7/ZuaXAlEO1lVdcg3Z1ks
         702RJ0EsEMmuFn7+oaBZzxB4sj84DyMPouLUIm6nK93dw4hsuwiT4Odmfqp1McmF7D+A
         IS1/4OMIna0nOEg14DTVG8WbrIyqPWRlNX1/9O5NkSUp0KxxHbWXGL0ZJddPRR40bELr
         jIBAJ+s8Tx2f2bwsayPt9VDOsB853ToEgsXPakUZPNEYk07CnxlWOCyOoMC7mAOpNDlU
         5uG0pDamtpJA8dxqt5mCZSqGdZXUVUMm33nyDjSPUhWe6ak5um19GBTEk2jxneaP2P+Q
         xGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d64EjQoW4MRYWDa4TRvA2PUMvbnV6no72KEsThEAne0=;
        b=P5VbUxAJgIqiIqisTijBKDbOHXLM/XFbvPZQ/0lES+e495doVzxjCsjBQb9+RjZdiL
         fn1VQYxf4JbaN4MZbgHHhg7OL9uQo3z+NSYfb0bTq29aXltPTmVaEQX3/MbGrHmMNpPI
         FIyfSV5GqVaRoS1PrBmSiV2GCHO+vIHXhWyL6WaDgP7iWReNM4RNPElXQtFalK0+R8SN
         7bSBuFipvsuFML7SrrE9vArWeMIg02qkzvSKS6jBqoO/0S6Y+D+i/Si9FNNmCANu85Bx
         b9iSBk69lucl+u5KVfP3PjHY+/ZvFyLXKCbYZM4X8GQ/SZ18sy6DAxNdi0UPBE44yvcG
         qjTA==
X-Gm-Message-State: AHQUAuaMnlCmJ2nes5KMQmWXpyrOkjWzVx5hq1TXRtelYKzkNZ2XvBa5
        uAW/4dy61o200reLJbBfWbZTeQMwQnk=
X-Google-Smtp-Source: AHgI3IYPhHZTaxX6Bk+cmBnyK5fmzUKqKmvfc0axSbEGPUJrJkk3BxTosi6CxHHXiKYW2Ukz7huE7Q==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr404091wru.303.1550785267594;
        Thu, 21 Feb 2019 13:41:07 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k6sm17536972wrq.82.2019.02.21.13.41.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 13:41:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        John Keeping <john@keeping.me.uk>,
        Pratik Karki <predatoramigo@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] rebase: fix 2.11.0-era --fork-point regression
Date:   Thu, 21 Feb 2019 22:40:57 +0100
Message-Id: <20190221214059.9195-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190221151009.GA24309@sigill.intra.peff.net>
References: <20190221151009.GA24309@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21 2019, Jeff King wrote:

> On Thu, Feb 21, 2019 at 03:50:38PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> > Those aren't using "--fork-point", so they're going to behave
>> > differently. The default with no arguments is basically "--fork-point
>> > @{u}".
>> 
>> Yeah, that's what it *should* do, but it's not equivalent to using
>> --fork-point manually:
>> 
>>     # my series on top of origin/master
>>     $ git rev-parse HEAD
>>     2a67977d3f70fa7fc4bce89db24a1218dc9ab2aa
>>     
>>     # Junio's origin/master upstream
>>     $ git rev-parse @{u}
>>     35ee755a8c43bcb3c2786522d423f006c23d32df
>>     
>>     # Where my fork point is
>>     $ git merge-base --fork-point @{u}
>>     35ee755a8c43bcb3c2786522d423f006c23d32df
>>     
>>     # OK
>>     $ git rebase 35ee755a8c43bcb3c2786522d423f006c23d32df
>>     Current branch master is up to date.
>>     
>>     # OK
>>     $ git rebase $(git merge-base --fork-point @{u})
>>     Current branch master is up to date.
>>     
>>     # ???
>>     $ git rebase
>>     First, rewinding head to replay your work on top of it...
>>     [...]
>
> Have you tried with "git rebase --fork-point"? It does more than just
> pass --fork-point to merge-base. It seems to also skip some of the "is
> up to date", I think due to 1e0dacdbdb (rebase: omit patch-identical
> commits with --fork-point, 2014-07-16).
>
> I'm still not clear on whether my 4f21454b55 actually changed something
> menaingful here, or if it's simply that you're getting the fork-point
> behavior more consistently.

Yes it's a regression. Here's a fix for it. As seen in 2/2 how we got
to the point of regressing was an interesting combination of factors.

Ævar Arnfjörð Bjarmason (2):
  rebase tests: test linear branch topology
  rebase: don't rebase linear topology with --fork-point

 builtin/rebase.c                  |  6 +++--
 t/t3421-rebase-topology-linear.sh | 44 +++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.21.0.rc0.258.g878e2cd30e

