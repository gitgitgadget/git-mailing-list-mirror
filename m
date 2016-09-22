Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6AED207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 11:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbcIVLzW (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 07:55:22 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36236 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933098AbcIVLzT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 07:55:19 -0400
Received: by mail-lf0-f54.google.com with SMTP id g62so64781645lfe.3
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=pLX5Jd1YQ6zfQE7QBvoKAr+4oYjrEgmUfR3tko/HRig=;
        b=kCs/Nr2VqLiKNxsYAo6A6kRX/XAIyPfeBoYGR2avvbzso270C1Zqy/8YTuqDCbSC5Q
         Hw+jVXDzq2VtnWsIi4KSHc8abzf/HBCDXUwTrdJBp4SxDfW4t+IftKJLqRD8/U3LHhN7
         uDp+wIuwqf/C/v4b0oECiBe5XX476gn5Zq5+klCJuJsPFX3pSZuu7P8urb4iCegpVyS9
         fkhLtAn+2Vqih160wIalBaHxn2sSyFLtLSAyYHZvgeVmvg2bsX/FJHfKbOt4GKyEWjhT
         tQIU8yPehHIGlR2QoyzEy1aSR83/WYb78OBH0GrJmkoWrAYwJ6xAdGq6NDJgkovM5UOL
         0Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pLX5Jd1YQ6zfQE7QBvoKAr+4oYjrEgmUfR3tko/HRig=;
        b=f+qSY+PGRX/RDWR+rlnRJDabkwVyG52zXEFMBuBsjVN9TYt1e9cDVwYWk2jt72B8W+
         f8eIf+4febdcS5oLSMeTyIJ3THHg2S4OzJ4tOKOE9KyaUFEt/6EOUc/dinDH7q8PwzSg
         uP/qonr2RpHnz8lBoIECQuN2HWqmoPadsdV4BTuniuLb7Ywyc+1NOpCoG39Sc+MVLWVH
         XIdw6wKxInKS4D8Tn6KgyvroO4b21DcZF4hbj0HbqPbebqtgRDdoIphGHgZ4Pf0pzQh7
         n+2s7AF1M3f40AlYkrULpDhRDBW+XHW8INQKcC0m5uJBhQkQYiSqMZLQdqx3nP1YZ4EJ
         yI1w==
X-Gm-Message-State: AE9vXwMPPq1Zx1/04Zht2ZQX61GPwECx74nWwej2WDUbsm2jMKH4EDNviHz0e66/hQaIM3q6TwvgzJk0DhICnQ==
X-Received: by 10.25.218.6 with SMTP id r6mr735574lfg.111.1474545317549; Thu,
 22 Sep 2016 04:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.207.82 with HTTP; Thu, 22 Sep 2016 04:54:57 -0700 (PDT)
From:   Aaron Gray <aaronngray.lists@gmail.com>
Date:   Thu, 22 Sep 2016 12:54:57 +0100
Message-ID: <CANkmNDe7y8oYRDDz4uTUso0SaDn+jSGs=q3XTzKuavSWhnP4kg@mail.gmail.com>
Subject: Request for large repo clone on slow intermittent connections
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am having problems cloning a 2.1GB repo from googlesource

C:\Users\Aaron Gray\GitHub>git clone
https://chromium.googlesource.com/chromium/chromium
Cloning into 'chromium'...
remote: Sending approximately 2.11 GiB ...
error: fatal: The remote end hung up unexpectedly MiB | 2.74 MiB/s
fatal: RPC failed; curl 56 SSL read:
error:00000000:lib(0):func(0):reason(0), errno 10054
early EOF
fatal: index-pack failed

I am repeatedly getting the same result on a 36MBit connection

Hoping for a soulution.

Regards,

Aaron
