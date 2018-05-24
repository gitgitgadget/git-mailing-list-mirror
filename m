Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7EC1F51C
	for <e@80x24.org>; Thu, 24 May 2018 11:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967059AbeEXLwf (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 07:52:35 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35709 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966996AbeEXLwc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 07:52:32 -0400
Received: by mail-wr0-f177.google.com with SMTP id i14-v6so2583663wre.2
        for <git@vger.kernel.org>; Thu, 24 May 2018 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BBwzbjEbHTUDEd4+IFpCY7EKYLsLt3xKroxCgb8wJGU=;
        b=RtgeL17S7JjJu/A809mjI66oAWWRFTy13STVPUjzgXprkof0J+MECU9sYzIfDUldW2
         aheXCNdIzJkd76rXecLZ7OVtZHdFnBDqEBUc+AsgTEI281+zX0bBAOCDmYgAIhwM9odV
         HUNpIIGwqDDVMI6jqaLPIr95+jkwc/mvNM5oFFbky650ZC62vnnY6VzW30CNNmyVY2kY
         g2nxnay799EUmtxm/5cCdH6wYZLLKAlRWJgSEc7T6y1rgISLvtUwPe2CtswaSwQAZey7
         7cZTpRBiKEbb8pMj9B0kZZm/9iiAG2kvvJJFW9DU82lM0qFnfJ2SO650VIBYkSjBlLbR
         HvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BBwzbjEbHTUDEd4+IFpCY7EKYLsLt3xKroxCgb8wJGU=;
        b=ndzLkEn/cZclAdi0l+LtvwOzQ5Dlv5foneHJuFQhse4Ey4cXjzWvV0q6BaYN9TVTUt
         ouf7N7BnBe8wE879P4DEYHk7n/b9GXSwhytBLCT5s4xDPzt7KhpUbGcnaRaso4ffioqZ
         DPim/URvffcuYazKm4J7luSjJbH+jTWKd49YAvczXIgGzeEbJwfV/PHL7b+IrzE3WOxJ
         Xdjqh787Hd5kQleTFtS8/XTm/iWKkcFowZJX1HWMRQx7sLAA8A07aO9Ku0TkoCKzjWy2
         CpQExrHfUxn/cYEtahugAm9UWbx0+5WiQA+UzMX/nZmLqnavKSk2xJWOKumFXvD1tRzX
         O3cA==
X-Gm-Message-State: ALKqPwcm/+bXM2sHZo7Cbf6t1IBqMgSbGDdHYUK/JQx4ziP+lbcVK/zd
        iDpBrgzGOgxuuSKQFOJZjDY=
X-Google-Smtp-Source: AB8JxZqtBON7iDNEWv4mBvbwHk0ohaUukVUL8K3DfAHPS5HyIQ9+Mmqb+vXk1ypp94HeAhATZ1n6Rw==
X-Received: by 2002:adf:ac64:: with SMTP id v91-v6mr5458005wrc.80.1527162750806;
        Thu, 24 May 2018 04:52:30 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.gmail.com with ESMTPSA id m9-v6sm32967093wrf.72.2018.05.24.04.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 May 2018 04:52:29 -0700 (PDT)
Subject: Re: [GSoC][PATCH v3 0/4] rebase: split rebase -p from rebase -i
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>
References: <20180522211625.23893-1-alban.gruin@gmail.com>
 <20180524114958.26521-1-alban.gruin@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <06839a64-1790-4c1d-9666-e5388446bee4@gmail.com>
Date:   Thu, 24 May 2018 13:52:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524114958.26521-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 24/05/2018 à 13:49, Alban Gruin a écrit :
> Changes since v2:

 - Removing `mark_action_done()` from git-rebase--interactive.sh

 - Removing unused variables from git-rebase--interactive.sh


Cheers,
Alban

