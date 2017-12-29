Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0421F404
	for <e@80x24.org>; Fri, 29 Dec 2017 22:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdL2Wsl (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 17:48:41 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:43742 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdL2Wsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 17:48:40 -0500
Received: by mail-wm0-f52.google.com with SMTP id n138so50159791wmg.2
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 14:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=EWkLu++MQ5PKcJ7Kp4WipctyIV4T0UFNHPm1Hv2iuhE=;
        b=KaeGrnmMj6IiPjJndyBXFHBkZLxYwF9XV75t46fKL4EhUCHnLVeqLAA/ApYPjSqgWo
         pE7m61co3e/173Lic7BS5V3fqNW97VNOc5e9HIAJhx+YIK1vmASi0thycifoahxrBdul
         Kq1nWp8jRs3C3EQYMiKY0iavYgweXl2yLOCGVMHioWQ9cJfS48AfbdhaImWDmWxsQzSj
         XT7KTy97W+T3K/DJrtHM4JzqlmT/idfnVT5lOFVP9FlJ1/ok07/rJV9u4GDg3Ngi/NVs
         C0YP3/xM6d5Pl3Q2SwfYp3wy54gVwJFZOO7oe8yMqJsXxOXR3ZVeqZsazErGT7TBV9ah
         69GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=EWkLu++MQ5PKcJ7Kp4WipctyIV4T0UFNHPm1Hv2iuhE=;
        b=NmnwItPKjcHqn8c9pAqVmzjv9UC9beCDZi5TIbsf9xWmR3NllXPONfu1+r2Vahaz9U
         oNVk73Z36lXmJJxbj6cLE9PkPiaJXa/RgMfBTDvCfhnGgv5wxrwAFsaApajQKs/91kIh
         jEwcO64M8tCCavzqL7/7VO4TJGjG22E08pPTyVeYwpkN9u7f8e0Y0aCpsvswafc0ZQnl
         hbxOrOIi8sTbdB4wR4QjbHXyvyHAvfe68LMnYs7CGiWv627uyAvHV2lc5BSlkcR6Njg5
         PO5XsE0QGq8XhHSZ3agQpk0/zTF4wBNHEpEX2pAVef9k3FZp6QpyJm9ic9HGcR9nTtz7
         Gu/g==
X-Gm-Message-State: AKGB3mJufFmj84e9GrzoNZhQtcnKXTJgOl9vF3yp1DrhNO2EgcU1OhT4
        977awa/hD8A0DDi7UUY0EMs=
X-Google-Smtp-Source: ACJfBotuKZSD6v+dyPqhnDMynCx890pGFhGkVWWLi6C4myZgBbtU0e4ML0CYRrKeBjKo0nw/zhj9Hg==
X-Received: by 10.28.131.73 with SMTP id f70mr30835833wmd.153.1514587719287;
        Fri, 29 Dec 2017 14:48:39 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id h27sm24491054wrb.35.2017.12.29.14.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Dec 2017 14:48:38 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Keith Smiley <k@keith.so>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
Date:   Fri, 29 Dec 2017 23:48:25 +0100
Message-Id: <20171229224825.31062-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20171229135240.GQ3693@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Keith Smiley wrote:
> > It looks like that was just about preferring remove in documentation
> > and the like, I think it would still make sense to have both for
> > completion since rm is still supported.
> 
> I read it as a first step in a long process to eventually
> remove 'remote rm', but if that's never intended, then sure,
> restoring completion for it seems reasonable.
> 
> It would be good to hear from those who know or recall the
> intention.
> 
> I think we should only complete the preferred subcommand.
> That encourages use of 'remote remove' even if 'remote rm'
> will stay forever to avoid breaking existing scripts.

Quoting from the commit message of e17dba8fe1 ("remote: prefer
subcommand name 'remove' to 'rm'", 2012-09-06):

  'rm' is still supported and used in the test suite. It's just not
  widely advertised.

I think adding 'rm' to completion definitely counts as advertisement.
It doesn't have much practical use, after all: typing 'rm' with
completion is actually one more keystroke than without (r<TAB>m vs. rm).


Gábor

