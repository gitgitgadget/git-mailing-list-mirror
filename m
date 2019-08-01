Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258D81F731
	for <e@80x24.org>; Thu,  1 Aug 2019 19:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbfHATt7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 15:49:59 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:46652 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388609AbfHATt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 15:49:59 -0400
Received: by mail-ed1-f52.google.com with SMTP id d4so70323839edr.13
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=fRJijRmXkPQgi6JtM63PDXdLLpMMG+DT7qi07+Q9wUw=;
        b=uhfXtlBtqVJcOTI89lCVW2c52JL0fCepytpFiNh2nL7W0P1eujZI+ox0a03mIiUSau
         w6+Iw4VjinzPbYBcpj0/YM//kkKGqWuIAo8EFNYSHlk4wm2DDe4VUcDXkzT3CRLURf1p
         nbjAALuI14r3BEGIknL/bHXto467aEsdAazGyxpYfiarVG7IpjBuY5IaNGh/4g7wtiyk
         Rq1vT5wiTpHdU74Rqdv+PrM/Nkv4zg/zxKHTu4jZcStJ8T+aaVyEIIMQjL36sTWE8yrs
         mcLFk0Q1hTlpL4rqFek+nY/b58U5yGoG101aZesMMVR+FIU4nM4KgxbDoO1v/936uoQr
         vDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fRJijRmXkPQgi6JtM63PDXdLLpMMG+DT7qi07+Q9wUw=;
        b=HNh0D8G8vJR8x2qXtka2WxEnLmYyy77qty3+JwCRGz30+odq3Bckuy+04fgRrarFV6
         NgypfHGB2hY5B/PvN59Wszg6O97+mB/jtfjc2nGm3Bh0E8V+FT3o9dP/+QryY1SAlaHL
         RQtxQxUWTaw6pJiXQ+rcPc6+Ezb32Nh3sYeF6nApPqKx8EcCHp0LKvhzS9QV/NSBRBja
         PQep9HsqnjobYrGaorfn0v8EdqX989wm7twhpu52QxZJuwUPSWfugH972Sz8rXclf8/w
         B7FEKyHbBTb8iiYv9KVh6+MqbMYWZjAP6CmVMasS1xsvd/pmYjK3yAPpWWeELLSdPg0g
         SgTA==
X-Gm-Message-State: APjAAAWuL5CkjgpvVdrLuInWpi+Tr1Chbf4LEHUG/dRTfhqe1KyYgmhj
        hEjLu8unA2z4XdrGYvk4jhAdQoXS8Xiivwno2YmACsVj/3M=
X-Google-Smtp-Source: APXvYqz3pk6sbnKqqr0mk9QNhR6H8G+x3QNS31ZqfkCMf9VfPbMF9xCpzV6TMKblozmD43cpsgwWj3zw5p4lgyxHkAQ=
X-Received: by 2002:a17:907:2114:: with SMTP id qn20mr101927483ejb.138.1564688996900;
 Thu, 01 Aug 2019 12:49:56 -0700 (PDT)
MIME-Version: 1.0
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Thu, 1 Aug 2019 21:49:30 +0200
Message-ID: <CABUeae8EBzPSM1KrZTMiGj=6F3iyxeXXbqUNMf2p_LfPkqcfnA@mail.gmail.com>
Subject: cherry-pick merge commit with log message populated
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When cherry-picking a merge with `cherry-pick -x -m 1 <SHA>`,
is it possible to populate the log message with (short) log of all
commits that have been merged by the merge commit <SHA>?

The only workaround to copy the log messages along with
cherry-picked changes is to always merge copying all log
messages of intermediate commits into merge commit message
using `git merge --log feature1`.

Is there any other way, without remembering to `git merge` with `--log`?

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
