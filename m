Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7808A1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 01:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935854AbeFNBX3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 21:23:29 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:45718 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935532AbeFNBX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 21:23:28 -0400
Received: by mail-qt0-f171.google.com with SMTP id i18-v6so4315733qtp.12
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=HFPxYR9HNAF3SGD3JcWbZnE+qf/2tuDeHPtA+9ERICI=;
        b=K+UYTr15fwe7UPC38/Yau+WhtmheUfc/UNHvjzYVD8nBsSQ6WjrxU68uJAHDKpnE/d
         G8cFtXn5fz0vmGlwJtbaOAry++xF77GvTqGtvR+wja2mlvn3QmufQmmRdhMvgyPiKm5i
         o+oPdQm8plbW5KLr1yPEHD+fiHDVnBn+ZHtGDs0b1EkvFO2FvM8X8QP3yF0tQpYQbyr+
         v0C1i6/Wevs4Zue0ANPmUu+bGclgdI3sZo3MLxqkvIxQjSfAlT/IjWL0pxIKx7v6f7d4
         NCky+3RibPmfJlq7/932wADRimQlv1dkE8w+tGR49vRi/5sWrVc4JBLk2H1m/XRZSXZE
         7VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HFPxYR9HNAF3SGD3JcWbZnE+qf/2tuDeHPtA+9ERICI=;
        b=hmlxhaA6ggOuJt8iLqFvu7bg8FFsLUUsDlh5vHjBrGfjxbblYEEH8vYmDaOWGM1gI0
         7c6r6Ovilql/MdBmP1we9cbFx4sUpl/x30D0i2gJMfgt159bWMItLR0Vm7Zms+3OKg2C
         XjdoNhnBI2Cb85CanGx1qagIjDn60hp3pD3BkkLto7nCj+BO78C/TJrA9JlfIDS3b+G4
         vlWivUC8m180wbydG3Hckzyo/mOgz28HHhhGAHpHDXwz5eAaOXfKABwwJDjSQ4vnfR/l
         aylVa8BDiEnzhuKMhO8YIRAZPE8eeKi5WItJ8nWKyzCce4jfwMxe4z3w7OS1yvGQLZrq
         PBuw==
X-Gm-Message-State: APt69E0/+OEAkkavLA7Dn7u7mt4Pp0uHTYLkmsNNINk60megThbBylnU
        ePL8BYD4HT2O/G73zF6IQdac2nOw
X-Google-Smtp-Source: ADUXVKJauXY2p+1XnHhMi7jbeQW2NzkFr6yKVrtXkZILlC9az95HwHYT0gbqHHVXTkjOjhVcfCrNtw==
X-Received: by 2002:a0c:e4d3:: with SMTP id g19-v6mr460226qvm.242.1528939407679;
        Wed, 13 Jun 2018 18:23:27 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b3-v6sm2734930qtj.85.2018.06.13.18.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 18:23:27 -0700 (PDT)
Subject: Re: [PATCH v2 00/31] object-store: lookup_commit
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180530004810.30076-1-sbeller@google.com>
 <20180613230522.55335-1-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d5d95334-b0fc-bb8a-67ff-75b03ad7877a@gmail.com>
Date:   Wed, 13 Jun 2018 21:23:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2018 7:04 PM, Stefan Beller wrote
> * Once this is in good shape we can talk about converting parts of the revision
>    walking code,

This is another reason why I'll be waiting for this series of series. I 
plan to rework the revision walking code around 
sort_in_topological_order(), but I'll wait for your changes to land 
before submitting a patch. I'm itching to play with it, so I may start 
testing things out before then.

In the meantime, I'll do my part by reviewing the current series.

Thanks,

-Stolee

