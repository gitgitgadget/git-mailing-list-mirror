Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8418D1FD4F
	for <e@80x24.org>; Fri,  1 Jun 2018 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeFAQS2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 12:18:28 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:47031 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeFAQS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 12:18:27 -0400
Received: by mail-oi0-f51.google.com with SMTP id h79-v6so16457071oig.13
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=e5W9CsJGSZMqbxEfuDl9uUNXlCNpRiaEj4C9ZKvT4FI=;
        b=OHIgaBHG0Q3vEadyTp/JDVVGmJ/88XeE39skduSjwTNRphCsjySf9JyKtk1W0Yzwqr
         vLQf1cE5+ZfcrKBG1y9sa2hIocfWVPpzKLuC2ja9B2fRDgUOZbh+sCvXftvZDrUlQG24
         7vt743ArsmnaT1nGAHapV+JxQQyaccou0oZQcu3aZRa6lrpfe/WVAIWAcEGnW+nlRAi9
         MxqeDllekGtXpzg34j3YYEWP4hLYr7ErBLdnFaCR6GTlwe1/9j2GM0byFInoQcBBCgbq
         COYrO+9CFmMH7zeOYUpAvUR6biAIOAT7lsoyi8AQN1tyyA+rqJUYgZQOg9jI0ILRBUGT
         IxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=e5W9CsJGSZMqbxEfuDl9uUNXlCNpRiaEj4C9ZKvT4FI=;
        b=FmxIpHbxWGbKGl+ySjVfpKoE8aCXwoYKYxv/SQHhfZp/5/ZHdzu1S916Ib860WyQ32
         oiW4QWW/m9XPbgIhFhHAVpSvbdhw4RZoVLFBT+6sWl1yTu1lMZxnGOQEcCACwAkhhqQn
         DE2bQBGmyTUfMwWS6LVJugstgHVktJCjkiqg7Ff4bqBLQG14a+HYlAwrAW4sXMLqTFL7
         etmbx88BMygSA7dHQ9NYmq3J8R6Wb74oAO9b6xpbjz754y9O9fZpMt7i19ucRQQvirDX
         5kAaFbzWjFKzyDo6ntISDQUw8M30kw3naBH0R/75wVJPTrCFdOhiP7XORPToEChNBWaQ
         hfGg==
X-Gm-Message-State: APt69E1jFpXL9ySmkgQljKLOAaS+Dv7FvFcWToowF/9eUSfW7CVQjBCV
        DkGJBhbia8PTlAPXx9o1x9fVGSm0/kZ3qR486Q11Jw==
X-Google-Smtp-Source: ADUXVKKp4Qegicf9Q4vWv76lyc4ppibRCyM/OSqFN1ZQfrDviv9upVIbt4cMxedrlE3WViqNAuhXF7mbb1X1jHIZ4fc=
X-Received: by 2002:aca:5144:: with SMTP id f65-v6mr6527369oib.32.1527869907088;
 Fri, 01 Jun 2018 09:18:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 09:17:56 -0700 (PDT)
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 1 Jun 2018 18:17:56 +0200
Message-ID: <CACsJy8CRgkyjcpK3FPaF7mrAuEFjGOShNjBZgjgrshg365T3Rw@mail.gmail.com>
Subject: t5318-commit-graph.sh breaks travis gettext poison job
To:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case you're not checking travis, [1] reports

Test Summary Report
-------------------
t5318-commit-graph.sh                            (Wstat: 256 Tests: 62
Failed: 2)
  Failed tests:  61-62
  Non-zero exit status: 1

This usually means you're grepping an i18n string

[1] https://travis-ci.org/git/git/jobs/386532326

-- 
Duy
