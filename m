Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64AEF1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 12:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeC2Mwc (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 08:52:32 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45686 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeC2Mwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 08:52:31 -0400
Received: by mail-wr0-f172.google.com with SMTP id u11so5284988wri.12
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PNbJjqOoVUo4AmW/V5dn8kVmJk+yi1h3LwwKBhsiD3Q=;
        b=ZYtVyBk9GfqKyv9S/+h2Kg2MJ1Cr5vpYEcpGYWg6Y1LaPP5az5vxcaflTdK/wFN45b
         3JQVoK646rvs16Vis7lmxTmn18e4IvTp70Db7xyeRjwT7D4kWIsk83T8qjP1IoOQRQNt
         yTskfQuvWYJa11Xji0mQq4UqSzmHjY4CoHrvEj0vof3urcQVJkUATto7daIxc4PaQc4f
         w266+O3szlzrkqYBGWZlJkufTyzlXI8/oKxOh6ZCzgr7xv3srX7jlY07ijvdUcohgq69
         FIui2rTCd6YneXCGMtdWo26SKBuROTnhAyuctOz4uJDN2KH6owbRbvEq/T5I+sCDDaXx
         K2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PNbJjqOoVUo4AmW/V5dn8kVmJk+yi1h3LwwKBhsiD3Q=;
        b=Hz9I2yxpL0EbJDjSDBrVJLVgxXaaGRjYMckEmLJQkBCSp3T/0sOP9ncmAMnGBRzAgm
         l6Yccl6YbeCMkghq6fFn+irtzEy1KACis5BrlHSYjLZZMPmueCralnmgMOR20s2u+kbG
         teDTzF2kDhupI7pjuI292i2eHFPkMcpivRwMvneub+XT5qf1ARjS9E4v4SOqADO7Z9RA
         ZwAk+jJW/M2LRK5DXnrrDsFb+hGifb3YHKM8GQSuVY5b2XL5aTyFexAhLIPNgKX8ooXf
         bFPvesJQIASjMRq1phAitwWZHjcCXY7eE49z+ds8iH3b121kQwDgyI5kSSCbj8BZkP59
         XH9Q==
X-Gm-Message-State: AElRT7EAPo+MtZXwzEZc2KMpQdP3YYoW6qmVrRGG6c1mTSUd5y73FZZ0
        XGBCSqOBpljd6EZQ7qtBd0RHI9jHTWV3fe1wRhE=
X-Google-Smtp-Source: AIpwx4/bPB/Dxh6QyI41fqM4HC9veM1ifa826UoVS9EBFC2WbC1QTgKX1TulhX3Uwzrm2uTba9dIU2B7xeKXy/+9qOw=
X-Received: by 10.223.133.182 with SMTP id 51mr5936621wrt.226.1522327949387;
 Thu, 29 Mar 2018 05:52:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.156.140 with HTTP; Thu, 29 Mar 2018 05:52:28 -0700 (PDT)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 29 Mar 2018 15:52:28 +0300
Message-ID: <CAL21Bm=U=p+tw5FSXXBU01Bm=YCS6oQQSseB-Xv758onmxszwA@mail.gmail.com>
Subject: [PATCH v6 0/6] ref-filter: remove die() calls from formatting logic
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move helper function from strbuf to ref-filter.
Get rid of some memory leaks.

Thanks to everyone!
Olga
