Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0D720951
	for <e@80x24.org>; Fri, 17 Mar 2017 19:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdCQTcL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 15:32:11 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35350 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdCQTcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 15:32:09 -0400
Received: by mail-qt0-f196.google.com with SMTP id r5so10704661qtb.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=owh4qYwaCioIRaCaKmQcX85OhYrEAQKLXi9oXELYhuY=;
        b=uevbotTDsomgWO8L7Dc/lw62F/3YgsxrQnsn/b8/LqurA6s+upXNl72E3K8QJxNwi5
         GcQddY2nnLoK3CcsJOZ01FEOBOGxV5zyfDcUvNGclfmKzni4I1R5J8DxeAm6maA30iHD
         SYAaUYalX6NJ/KbvGjfbXuoeJ68ahkxzUDYk/IRkCn51hneOjFL1aE8ke3sdiuTQnl20
         RUgRjHe+RpLPgYIhckfIbudBhnfblLa7DXwAqxM3hgsst3v3PbU+w+9nyt83iK5BPt4v
         thfbadFLXkjFBSx56e24ZYXbW8pmp9mPSTdgbsiH4J/h1jZly5Mn60bHHr4S2v51SP58
         l/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=owh4qYwaCioIRaCaKmQcX85OhYrEAQKLXi9oXELYhuY=;
        b=Ern/u0fP3Skd+JD8dCQRCgHfp3S/KwJHJOV2cB6J4Y4AenQQ0YaOWxvgM23VI710fa
         gGxgUbAZ8LPzaA2rhZ7nKkIJ06njjWjFnNUkYQsGMpbzPfxiYCadtUcTcxc3SP7jyNRW
         YuyPDkVy/KvM0K9OBlZBJl9xomHFkFGpVsVZy2TP12vdZP2qCpL1M0qi+jK3X68DE/Zx
         4TWwNh0R7IRU1709siePM6O031R2iIBLMkXV7A7ds+R0Uziboc1sTgs+aVpX3zAcPlvu
         d7t2pkd22nu2xtywg558uAnCmt9XsoVmuqt64zY1AEfzL53pOGTuFxDy4xESllt8sv/D
         hmQw==
X-Gm-Message-State: AFeK/H2v0bPP+uuxt8KbFFILzZJX38tw/IXNgCrq42EGGuIlLSx8K3pfAkqNwv1vXyagzw==
X-Received: by 10.237.44.66 with SMTP id f60mr12827662qtd.182.1489779086981;
        Fri, 17 Mar 2017 12:31:26 -0700 (PDT)
Received: from dhcp-rhodes-689.eduroam.cornell.edu (nat-128-84-124-0-689.cit.cornell.edu. [128.84.126.177])
        by smtp.gmail.com with ESMTPSA id c15sm4671223qkb.24.2017.03.17.12.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 12:31:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [GSoC][PATCH v5 2/3] credential-cache: use XDG_CACHE_HOME for
 socket
From:   Devin Lehmacher <lehmacdj@gmail.com>
In-Reply-To: <2952fc80-a313-4193-64b6-072b7ccdef4f@ramsayjones.plus.com>
Date:   Fri, 17 Mar 2017 15:31:25 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2E94DDE8-FC43-4243-9E61-1498E1993467@gmail.com>
References: <20170316051827.97198-5-lehmacdj@gmail.com>
 <20170317025315.84548-1-lehmacdj@gmail.com>
 <20170317025315.84548-2-lehmacdj@gmail.com>
 <2952fc80-a313-4193-64b6-072b7ccdef4f@ramsayjones.plus.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> or $HOME/.cache/git/credential/socket if $XDG_CACHE_HOME is not set.
> I don't have a good suggestion to re-word this paragraph. (I just
> spent ten minutes trying!).

I think it would not be too bad to not include this though because
`$HOME/.cache/` is what XDG specifies as the default if
`$XDG_CACHE_HOME` is unset.

Devin
