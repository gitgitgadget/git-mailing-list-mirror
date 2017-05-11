Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47EB31FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbdEKHqq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:46:46 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34068 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbdEKHqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:46:45 -0400
Received: by mail-pf0-f171.google.com with SMTP id e64so9912683pfd.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=jEkqu4WQ+/9zCK0E5LWpHwayG/QxBlQ/HwVT2gs8uvc=;
        b=g9wqqBplLIqWFCD6g26yD/Buc2I8aAzg1Ba3mRaOrnxfHlETUIyHr7FOzXRRU6IXSP
         c/R3aTHgoxzxjJQ5Jz9oJYzLJFejaIHV+pbrzmNPBqR9CRfxLG9SbPjSSL8MDIH1jpQO
         m8Qak1p6INXmbiXEhZETb8JUk1En5MJ2ipO7IOrCMVNIxkX+juRxGnzahmjsG0WVqEin
         GaDAo9MmvWaPmPOS5KtdMRUloujx1u+/MSaw71HrTjOMoy8XARzCLHm5+LcVSSTkPNAo
         lEZ7gn/q4CU7CoHOb6XXDyhSUsWaKJlmlYyviLFfRRK8epPnjEmLwQDXYWo3NkLIGjvc
         ybaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=jEkqu4WQ+/9zCK0E5LWpHwayG/QxBlQ/HwVT2gs8uvc=;
        b=YVaEpJ8nIcmalAT2WJA1ml5QlpymTXwWjoI5Tg7HfPckF37FED2RrFs25IZSyx4Cm+
         y/YwNOxJWaGbbp+gRpa3RT/6R5GyINiDXL75ASVeeIiL8aECOWvHT6+JqkQlxmNVrYVw
         jZRMDJgw4LHWswESWwmiRMmXz+Iy3ftIfZc+2pibSZjTPptlDaSrLUIKoXYNReg5Wnhv
         CjLCBbNnSP7yQzAzloP9kbxeP7LjkzR6z7qSQBZVeIyWmm0DJ0xMMXVSGiDeVtckKPzF
         gaCo7C6W8YRAiUzFzZqN5ig+vGsVoeP3KNomZ4ASOArLRpnG7r072fKMI2jLzQWydnfl
         vjUA==
X-Gm-Message-State: AODbwcBjXnu5tgoxdHYD7uu4qzToigAIBju8wp9WPoqAnfGZXFDaRfay
        SJvSQyQ3cX8CgA==
X-Received: by 10.99.125.13 with SMTP id y13mr11080325pgc.234.1494488804604;
        Thu, 11 May 2017 00:46:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id b90sm1980204pfj.19.2017.05.11.00.46.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 00:46:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: https://travis-ci.org/git/git/builds/
Date:   Thu, 11 May 2017 00:46:43 -0700
Message-ID: <xmqqfugbbzto.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was hoping that by ejecting a few topics out of 'pu', we could
finally see all the build jobs pass their tests under Travis CI.
Unfortunately, no such luck.  It seems that we have some new issues
with Gettext-Poison build/test after updates to t0027.  Also the
updated compatibility regexp thing taken from gawk is not liked by
the Windows compiler.

Not all of these may not be new issues, but nevertheless, it would
be nice if we can see all build jobs succeed every once in a while,
not just for the three stable integration branches but also for 'pu'
;-)

Thanks.




