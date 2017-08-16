Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C649A1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 12:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbdHPMVt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 08:21:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33859 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdHPMVt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:21:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id x43so2770306wrb.1
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=/jTUBvbCQUsM3/8xZ1fIMAahWgBhQ568fSGW8tRJs/s=;
        b=B6DKOY0N05CyKL9r7LxDiGxqAhOViIbbypsmj47VnIsQuZU/95wiCHDfjEzjYnpe4l
         ZtiPSjEkjxugnQilXsXFIXJz/Mg2+nTjYcRmRhBqXj4DMcKuZCXN5tBH3z02Ksx/Rera
         WZTpooAAi2A4Xp+7JTTh05v2aDhjAqA1/tgriOBA3sT7BmVEdg2t6UER5vkyLjy+2qqe
         eTkweiXltAhqJwCAHolTerX7GN9WKF2Pg1SscGs0/dA+DLkl1TA3F8zWcNBE9jSGmhI1
         N2rEdK9ezq6SKHVgY30yFwNTDAHoksD3gHRlSwo7ACftUPIf8oTD6Y1xz6b3fgjXVP3k
         VXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=/jTUBvbCQUsM3/8xZ1fIMAahWgBhQ568fSGW8tRJs/s=;
        b=KzLQUAv9BkxsYuX+dAI4oyHULI2Y3jKNlLVrafeyF4uw12C050SiF7JK+qIUDhChRj
         RtOy9EBpNeOC3fpdKf43HpF2TlGr2v3cK1LDhSQziHc+xzndXKplOmWgyg1zW1tg7k8/
         4cuRYmzYO7lpDATWcZfgaJc76kuLOjU9muyM7qn7WuGVI+l63MF5FQ9tTe5OGSYWC2T8
         WgcoyeoX2mcl9kr5QUJ0lpegghyOHea1jBNWDPMg3wBPVp2e3pz7bab8hAP/1LwuueHv
         55QkaJXZDVFKOsHPdt05NPc4AccCQyTWEzTz74OMaAAUvdKSLVdeVOC6T+FK8wR+GDax
         PSuw==
X-Gm-Message-State: AHYfb5gFeJVjMLqNOnSYfcUnonOaQCaBcUKGYat1pOrtZDbsdd5ztT12
        Mp2hv9yt8CJ6ORBURTI=
X-Received: by 10.28.208.78 with SMTP id h75mr1127454wmg.119.1502886107680;
        Wed, 16 Aug 2017 05:21:47 -0700 (PDT)
Received: from [10.2.1.129] ([82.208.55.145])
        by smtp.gmail.com with ESMTPSA id k134sm1194915wmg.12.2017.08.16.05.21.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 05:21:46 -0700 (PDT)
From:   Efim Goncharuk <efimster@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: git reset
Message-Id: <34910856-7DE9-41A0-A7A6-B572B1C88C1F@gmail.com>
Date:   Wed, 16 Aug 2017 14:21:46 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Starting from git v.2.13.0 onwards (v 2.12.2 works fine)

git reset --hard with --work-tree and --git-dir options does not move =
HEAD to hash/tag specified. HEAD remains on same position.

Example:

> git --work-tree=3Dlib/core --git-dir=3Dlib/core/.git/ reset --hard =
0.1.0


Note:
on another hand
> git -C lib/core reset --hard 0.1.0


Regards,
Efim Goncharuk

