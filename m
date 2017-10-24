Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046E120437
	for <e@80x24.org>; Tue, 24 Oct 2017 17:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdJXRsr (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 13:48:47 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:49716 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdJXRsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 13:48:46 -0400
Received: by mail-wm0-f41.google.com with SMTP id b189so17150686wmd.4
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=c7qQSjiYFszPHmVrT0ZbPP3QqivEzfspVdAIfJomaAs=;
        b=NcjgCst61mDg33ZRUgx4wLs2UmDNEBMI6AuBubxuzxRZanby3mtEb95xLisgD8fL6U
         Ro9LRi4uYkXM13/h7e81tC/HM/9QLOakGzqAp6Svwpa6xZtYrFqCiz8FQU9t9alFetQD
         cDQtAdzLneXyT8Kh9tF4Qp/swdsa0D3DeSCmqQmSEjcJ7CdePEUc4RQcTyjmT3XhDwnK
         LX3FycZf9prOjQX9Ph1pKO4NFDTWbikK2UCQk+bq5H6/6oH/sp+0IBMjSMxST4Xk5Xaj
         vCTu1K/tqDroj/AqXm3rBOzzY4al90Tv2zW04SnTfhlyk8rFt5GL49gZ6I6Poq6SICEJ
         qmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=c7qQSjiYFszPHmVrT0ZbPP3QqivEzfspVdAIfJomaAs=;
        b=Wip4j4PoYrsHS7oKgjCvco72pLh4zfNS0Q5KGxGDHA8s23BnDlv1irtp1Z1DUB2tfy
         PbqMOYcSxoiL0r6cmhutMnYSdf0ZlF0XcIqbMhyvxqMqz4/LoeO4ExgahpAzTKgs4Va9
         Dwnk/JO8R0zIYsArtDln1I9HoRyvZgnKqeWnV+De4xq/EXB/vPMOiHtBEG99EZV9SeLI
         umiEPXIDxrmIykLXYrQtZyGH3mxI4KCBKCqqn//k+swjLzCebgti52PZDrFRErC7RkU3
         NaiU2gH+blRCI/hFiLFNvxr1wwIHUQM9g9zg9zhfbsxsC60ng7/ii8nyu226K8NH4JOd
         x0/Q==
X-Gm-Message-State: AMCzsaWHaa/NZuV6T5ZypeR4FyOyjTz1SuDa5mTZo5gFNa/gfe30/OIb
        PmmeUYWFnu6RS0KTsg2WuceN+g0o
X-Google-Smtp-Source: ABhQp+RG6dnVlXz/NzRO2YKH8YPdB/PYPjv3FDHGvkEhwcmgMBHzm2s+lSi6blvUjgm6XJjqL43WCw==
X-Received: by 10.28.41.70 with SMTP id p67mr9146761wmp.110.1508867324985;
        Tue, 24 Oct 2017 10:48:44 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h4sm748684wre.13.2017.10.24.10.48.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 10:48:44 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Consequences of CRLF in index?
Date:   Tue, 24 Oct 2017 19:48:42 +0200
Message-Id: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've migrated a large repo (110k+ files) with a lot of history (177k =
commits)=20
and a lot of users (200+) to Git. Unfortunately, all text files in the =
index
of the repo have CRLF line endings. In general this seems not to be a =
problem=20
as the project is developed exclusively on Windows.

However, I wonder if there are any "hidden consequences" of this setup?
If there are consequences, then I see two options. Either I rebase the =
repo=20
and fix the line endings for all commits or I add a single commit that =
fixes=20
the line endings for all files. Both actions require coordination with =
the=20
users to avoid repo trouble/merge conflicts. The "single fixup commit" =
options=20
would also make diffs into the past look bad. Would a single large =
commit have
any impact on the performance of standard Git operations?

Thanks,
Lars


