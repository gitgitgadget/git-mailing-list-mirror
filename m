Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31425201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 12:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbdKNMAg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 07:00:36 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:35324 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdKNMAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 07:00:34 -0500
Received: by mail-it0-f42.google.com with SMTP id u132so13311915ita.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 04:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E/Xp1wu3uiNuFADPjDivrIp4MoRIDbXwKH27maxBp04=;
        b=shxOjcdDS9JSyGLGplwh9mex5ynHs9lEf+gDpvD5sm2kx1Ksb/nH6U9zb89tPgH0M4
         zWiqqjtZzo9ruY/7Uo3m+vaO0SQXqHdCk7cVzvnP/QaIjiQ7d/f9lIMPmDb2bEuN5WEf
         tvzFhN/ffOBl3JuhA7hF5zpRW+eNWwl5Pleap76g2JiQqaxYbxDSnbefipdmdOqbMBYU
         XLx4IkeMFs52s/Q7ezX6mymHv8yKFyWLnYiJ+7K1GUItiuruMfXJRMUHVpl8BPHk+T+s
         ILC8zHM+PgwzdKgIIZmT5oaKOyfQWm5dzt9TxslQGPjtr+giPdXDfpJXhwZj5mdrw+55
         jeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E/Xp1wu3uiNuFADPjDivrIp4MoRIDbXwKH27maxBp04=;
        b=Q3ZKyXqGdzO55blzlx4cNIfAbH2wJ83P6YjKdZnfsW2OfjoLEALt53nX9EPo8SR7AL
         yT5iimKpkenuux0UncAVSTO/a204wEcKpRabTZq+5y+XwFACRG+OD5ahwRRBM7JwuQsN
         qU+K/Dfm81eXkC5d3vGwzK5ihQG8sunIaDaqi/iODBVda3o3ET+i/Y/yd/zR1Pg1QxTf
         kva57qOe0WaU8w3mfXvCpn8u7UNTj+A9cUwP2t35IfzyGu3i1AD0/JiqwMRiwLGnJSj0
         pC9yG2iPx6b+MGzkUecKxIzfn+GJp00CVlAkZL/01Zkdvd/x8roIwjjvsM9U1i/69NQJ
         lPHg==
X-Gm-Message-State: AJaThX4q5R5QOuea49JeSe5VKwmpru6eJek3rQt4r2c3GhTRSwGCd3cG
        mP+prNileNc4I7xt4EJQkd4=
X-Google-Smtp-Source: AGs4zMYSHEE8XXDjdbRr//4MLkVIa7dCxtE+bRBGDlJmEKUXC0ZN/f2bOGdRfJrp5nsCRGukVEf+XQ==
X-Received: by 10.36.148.6 with SMTP id j6mr13505745ite.104.1510660834025;
        Tue, 14 Nov 2017 04:00:34 -0800 (PST)
Received: from [192.168.43.71] ([157.50.9.118])
        by smtp.gmail.com with ESMTPSA id 14sm3506059itj.34.2017.11.14.04.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 04:00:33 -0800 (PST)
Subject: Re: [PATCH v2 1/2] branch: forbid refs/heads/HEAD
To:     gitster@pobox.com
References: <20171013051132.3973-1-gitster@pobox.com>
 <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <0f8166ab-7955-aa78-7d32-0ec80944f007@gmail.com>
Date:   Tue, 14 Nov 2017 17:30:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I should have been a little more clear with the numbering, sorry. The 
correct prefix should have been as follows,

    * [PATCH v2 1/2] --> [PATCH v2 3/3]

    * [PATCH v2 1/2] --> [PATCH v2 4/3]

Sorry for the inconvenience.


---
Kaartic
