Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023AD1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 18:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970333AbeCSSvB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 14:51:01 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53309 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970539AbeCSSur (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 14:50:47 -0400
Received: by mail-wm0-f45.google.com with SMTP id e194so17049048wmd.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lZe6GKm3aiCNrs+V+m7sZ9MAPuy2Ac10cMRINl0q2E=;
        b=FFH/naHCMW/nzLaPRjrk13efcUR9K5URHT3Seh5fy72yzOtWjdhKQ7hNjxmIQH0Sln
         MIe4EiIhuIg0/Q/cQkyuCKtpzZODtXR6XGU7y/k0tHgP5zalA7LEgMCg6c3zoWh5DQFq
         WFy2Gl4G//vHBr938LFcWEAV96Q5Ue3N4QEEZuO/PUkog+5pP+DOqp/E7hGRpvSODucw
         KPIBh4e+5948IGGXNWCYMkak9vX1Ip8jJpXay2g7vPOwWZJIz4UgpKSDweGFm0dsIznF
         QZRDCHxvzWXM5IEEYBUY6FzWv1ZlwZTUnHVBr4pGNQPMYZUFkqUXLwWMbH7sxZfRXPag
         yocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lZe6GKm3aiCNrs+V+m7sZ9MAPuy2Ac10cMRINl0q2E=;
        b=cchNNLV7a8tMkpFjOPMceMde7Vr/zf6OMVfCIddCE/ecHQiijGsTMhIj/wB3zJJn4L
         PcQ5st9fuSePJ4t2SIpkpAav/EVGRyqppEZaiOU7iayV5Mhip0ZWx73eXIeSMl1AXI8F
         Je1+RsbcQCuNHL5sIgJQ6fvUMAlucFLbk+vDNdTC6Od3sMISFM5m4SsqKMIBV4Kh22lk
         aDAsp7JakcJ7lN9uLbfPR4MLl0S/2NG3JsXKPDETIPFKSF/fYzR2zGaGoZCgwiBEdgXV
         SepxRi7rjDANjiPJNi64ZnCZpj8soqEtmZg6VzgOai8CZgo+8ZSsiBrpQaN5zIP2Y8et
         toiA==
X-Gm-Message-State: AElRT7EOuo+eoXxr3N+FAmnjyph0/yNHPPJLvEuzsYiSAxMmSJDhAAmF
        +XWnRjWp/sHmG42dznmTtWYeorMq
X-Google-Smtp-Source: AG47ELugammFQox+ewfUvwrHokXUxOJtpJ7OiFzZpcQPl5S9FrcgI5+Np/6+D1wvI+lQ4vfAMRBiSQ==
X-Received: by 10.28.138.6 with SMTP id m6mr10120419wmd.146.1521485445976;
        Mon, 19 Mar 2018 11:50:45 -0700 (PDT)
Received: from sebi-laptop ([91.250.255.11])
        by smtp.gmail.com with ESMTPSA id i66sm126980wmd.0.2018.03.19.11.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 11:50:45 -0700 (PDT)
Message-ID: <1521485443.5987.1.camel@gmail.com>
Subject: Re: [GSoC][PATCH v4] Make options that expect object ids less
 chatty if id is invalid
From:   ungureanupaulsebastian@gmail.com
To:     Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Date:   Mon, 19 Mar 2018 20:50:43 +0200
In-Reply-To: <CAN0heSrnERYggyJ8bL1nAV=X2JQYS8aOkc6nWZhnZu3oqhzAfA@mail.gmail.com>
References: <20180306193116.23876-1-ungureanupaulsebastian@gmail.com>
         <CAN0heSrnERYggyJ8bL1nAV=X2JQYS8aOkc6nWZhnZu3oqhzAfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thank you for your advice! Soon enough, I wil submit a new patch which
fixes the issues you mentioned.

Best regards,
Paul Ungureanu
