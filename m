Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46A6B1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 05:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeILKiU (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 06:38:20 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:44632 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeILKiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 06:38:19 -0400
Received: by mail-ua1-f73.google.com with SMTP id d22-v6so348447uaq.11
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HZGkvazUVObA206mn+gPlGTQ4+S2IM8AeR0qA1Bdl/U=;
        b=XqgONGps8zKMpKZG6f4dg7icxXGO9Bzdpv1LNz8O32z1kMNlYal+OO8BNDnRCr8N+/
         opnDsyjoWckhGeyfx8nnS0mbt7e4hYuFZq4QUvsFxXXQHtVXfJLLFPtwPH21T4vjt2gS
         //QwWuAZfb2R1vQVDXCjMmYSaV2F18TMf4Pp+dRSfHIRSwM4aBH9FtkvRL+GGVl/MbeY
         NKImEcAX1/1IZtU4Wg04Y02BBQh1D2ZFL1/JEd+drb3ldMl08nXopBnpmAjHE8hy+6mw
         6u1J0yYS47yupOt8ZnsO41BNFq1kQqNlBHMGz82hf9+Um/xnf8Xtzg9fWtCXj3yz0Qzc
         mO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HZGkvazUVObA206mn+gPlGTQ4+S2IM8AeR0qA1Bdl/U=;
        b=WVLhxhShGG9SHPxINwejXzqO+HzMaAIE81xGivFxt9GMsGkLWtcalqo7Izqxr6waeE
         jButfkZZippEWSips29Zxk8fBIz/hxzU7iA8rhWWMVviT44/By+ZU3BINHz0wD8+6Q3h
         zDBajZijiVZkOBhpWeCDJqhAMBVNMTP9gBlQjEao3JmdUW8oUbh6C0hQ6u2xTAbISkCh
         O5NMZ2BXcm697I7Cko0yOXHRHHoWV9iLqduoIlDCi1Mf41z9OozmbDOu20h6wPS3QIL6
         80jYFgmM7xhmSMdx+rIh/5CvvX3tBecEVNyfR0Fn9rYhSGlnYZBrLp1TtoiaH0yL7Kj5
         Xbhg==
X-Gm-Message-State: APzg51APCCGhBzHWfXZA+4G3waYjYZEIMY6qwKFI4LLpEVEeAH1b0u6d
        egYRSX2suh71XnLNzsm2N9x5+6fD/zldSCeMhKD+w5adymQrFO8rOKS/+Y1nH0WKic+MJ6koFda
        KjhikXY43j0+EyPpwwzb0Wvmq3pECI74GN2HF6/B0hsX9NxrZbVRkUn6S1efJYZc=
X-Google-Smtp-Source: ANB0VdaU4eI7XKDsFi4k7QcHOSPfae45OXDjYjmwzPwWWomaCuDbnWdXV7d31AnVlTzn6pE9r+qmpdp3CM7lpg==
X-Received: by 2002:a67:78cb:: with SMTP id t194-v6mr38464vsc.60.1536730529789;
 Tue, 11 Sep 2018 22:35:29 -0700 (PDT)
Date:   Tue, 11 Sep 2018 22:35:16 -0700
Message-Id: <20180912053519.31085-1-steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: Add proto v2 archive command with HTTP support
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a new protocol v2 command for archiving, and allows
this command to work over HTTP(S). This was previously discussed in [1].
I've CCed everyone who participated in that discussion.

[1]: https://public-inbox.org/git/CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com/


