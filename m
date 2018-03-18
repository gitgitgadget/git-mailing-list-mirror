Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF5B1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 14:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeCROtL (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 10:49:11 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50929 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754176AbeCROtK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 10:49:10 -0400
Received: by mail-wm0-f48.google.com with SMTP id w128so10965864wmw.0
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=D5mj/peRTNgZMw/jAqz2Gdqp31wuH/DWc4FhiQyrU5o=;
        b=aqe4eJly1uKFjWPQ1l+y/d1NBw56XyfE7YXPY0rod/shOwspilwOEKIUpmfslVsJge
         kADiCYfMht5bws3P4XV9MPob6Pcv+NM62aQfL0cixB9wol2wm1anN8SHawa0/j3acxcN
         rkpq456H/2kCUqrnveYWITpF3h6tsUNXvPHBHjL9NZWlmgsUEVFzv6qQeHQ51K9e9hM2
         mTLUlzk8zeF4oy8rgnPYKBhMIROY4DDk4cJwc9w9syJoymFnmHFY9dbTMasGGoerQJKE
         BsYRK1wVpWorqgffaXtzhPICHTySN5zFkw5AL6NiCCttW0XXFX8eeUGsBF14kjan0RUp
         NUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=D5mj/peRTNgZMw/jAqz2Gdqp31wuH/DWc4FhiQyrU5o=;
        b=neGKDVyeq53H5E0KNgQvCxNhOPYjS41EMSmGVCQlI44KxgoZPVJ4qG4HQPRcmKxYR9
         GJaAwftKPl6r2zTX3DiAFP5QAI/2FlhNge3s1W4qTr3jqJAyUpmi4Mb9kdmTU2RGitLJ
         jYa69n4yzIbOC0dCyRuflZlvXWocFTZJZ1GOHPOyYwaS4DrHnW7QnK/tQg2xbMslAT25
         qgeFO5mjVuSupioDROxYFPmrI25KnqjBSJl0eKaomVjT2HmFe48FpMY4De0RN96zcWNq
         SmB3m7kbF/Z2YYA8KJvHklCrG+GdZHbGrfhqRq4DcIWG0lwuMXN/n4wY68jTSk9JWyT9
         zJLQ==
X-Gm-Message-State: AElRT7FSNPAzmvLDqYwA9ibOS2rbZ/sAM9yyXbshjjof3E5cYeSgd9sw
        k8dx+kWU3HCyng9tLESRBc3gyOJU
X-Google-Smtp-Source: AG47ELsvuFfuvDgYND3/lqullGDfrtc/SP3V01iz4/pEdmvjbDgmnycfN6WHypfcoKSDmUmkqR/RvQ==
X-Received: by 10.80.172.229 with SMTP id x92mr10258774edc.252.1521384549541;
        Sun, 18 Mar 2018 07:49:09 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 58sm2568318edt.12.2018.03.18.07.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Mar 2018 07:49:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com> <20180318142526.9378-10-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180318142526.9378-10-pclouds@gmail.com>
Date:   Sun, 18 Mar 2018 15:49:07 +0100
Message-ID: <878tapcucc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 18 2018, Nguyễn Thái Ngọc Duy jotted:

> It's very very rare that an uncompressedd object is larger than 4GB

So this went from a typo of "uncompressd" in v5 to "uncompressedd",
needs one less "d": "uncompressed".
