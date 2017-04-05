Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9961F20966
	for <e@80x24.org>; Wed,  5 Apr 2017 22:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbdDEWsO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 18:48:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34731 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932168AbdDEWsM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 18:48:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id w43so6505206wrb.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=mS4kbZ6ADiz/bBZcjTb0VsHfbvu/4WHBVAaM1iizm+U=;
        b=ZSSX/OEbhDOwNPHbkrd2hvwk+J3IYaV+5ToE201lOrnEi2qXeX76oiJzau76KS9ylW
         JrQHvIX7KdJl9pelDWmhPUFeXLzcIWIkqx6AEhiWtqKJ86rps/G0VpvNaz38Ry509jjj
         bu6k5DSRo254nNaEESBVZ3Ruhz+2raWaexM7wX+b+kxQQ6KIV5PPAAvUI3/3thg9Hjd2
         rOUXMF2WrB8W7SGc8K7yOk8qkM8MOKVByVXknhb0GJaS934go4+Vh97o83yTtAHtF9IF
         PCi3aLWFIVob95/o1LJ1nLaCdpVFzzzZ6CvvZgqz+sk5V/iEaJ8/Efqkjd8H0x7kdSoh
         Y6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=mS4kbZ6ADiz/bBZcjTb0VsHfbvu/4WHBVAaM1iizm+U=;
        b=ubeOOkD1MFCeHniLlFdHNV5zgUXjqxoRS82W1NlsUVqhpBj1gqut2q+doBlH0cjrXZ
         XtEXon43zQTi6P2qLl2wGSZ7UX3UGCT3Pn43h+4RK3qWTE0i5IB4sL8DUkpoTOFCpqFi
         WQSkXxz5pRd+pSf/HdUTpOlOYEMGSGxumzHvCEQCrSU1+pwa56rnF24XZNel46cfvBdS
         Bh/EDIqVXsVqcEtUWcdqZYRR3p0BQs6YBWm6Xrnvoci7txWC92+LxWNUeTyGus46UhAg
         qn9PBoVtQJ60WpclfX7SlFwuRQOJhXkTbnLZMWtF9/V5yFjbDn9DicRSOq1E5WL1lOux
         jgvw==
X-Gm-Message-State: AFeK/H20/jk6KOd884tiplQUNk5QyUvBFgwukFt9LdeJ88ubjcW7U1pqY3e8RiujzEwO+Q==
X-Received: by 10.28.88.129 with SMTP id m123mr21960424wmb.28.1491432490863;
        Wed, 05 Apr 2017 15:48:10 -0700 (PDT)
Received: from localhost.localdomain (x590d7ced.dyn.telefonica.de. [89.13.124.237])
        by smtp.gmail.com with ESMTPSA id 36sm27819494wrk.15.2017.04.05.15.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 15:48:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@jeffhostetler.com
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 3/4] test-strcmp-offset: created test for strcmp_offset
Date:   Thu,  6 Apr 2017 00:47:52 +0200
Message-Id: <20170405224752.2242-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <20170405173809.3098-4-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this patch should be squashed into the previous commit;  I
don't see any reason why the tests should be added in a different
commit than the function they are testing.  However...

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Makefile                      |  1 +
>  t/helper/.gitignore           |  1 +
>  t/helper/test-strcmp-offset.c | 64 +++++++++++++++++++++++++++++++++++++++++++
>  t/t0065-strcmp-offset.sh      | 11 ++++++++
>  4 files changed, 77 insertions(+)
>  create mode 100644 t/helper/test-strcmp-offset.c
>  create mode 100755 t/t0065-strcmp-offset.sh

Sure, tests are good, but I have to wonder how this would scale in the
long term, when even such simple functions would get their own
t/helper/test-func executable and t/tNNNN-func.sh script.

