Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148381F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbdHPSMV (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:12:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35379 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdHPSMU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:12:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id j68so1964869pfc.2
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UcNnWv2MzhVy7mxqeQq1a+speSBJ/wFMkA3sTAllLXU=;
        b=mZFlr1oS6BJfL7jf8118xtuTNSNzmKlXpwICojPbkYcX/3hbCqsqnJaEIdipwNUgA1
         DUMNXJRsMeL6nyvYC0n6SnPsQuNTDIARQXvJaPYbQa+LvU8TIfR9c0X2Oym4795z9/WG
         tr50MvFaKDCpnwLAVhdjDr/731JUAvRMABRSMlVR1Mak7Fg5zyIOFIdYYIYUiSKFJCJQ
         Tp02c7YQWVbIy6DurNCnSUL+loJqRzv3pVSfcqhwuvpB1SxH171T13n0cjpjmnzI/KQd
         inUn5bUFblDWAQljjYB6DIg96nTSTf64c1hg6GB8Q2p4+FPyRBKImw+wsGwaEKkSsH7Q
         jb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UcNnWv2MzhVy7mxqeQq1a+speSBJ/wFMkA3sTAllLXU=;
        b=ep3dNJ15KPdRSzOwm1Rj8ye5rusIc6Mu8qbkTK3wAQT6NhVZdXvkIG+oAEip/hbwlW
         DtNU4+HHFYG0LvATc/owHhL0mtBMXBbDUTmz0+xhh0xdASFiV3LPHr+u8m6FqAKQTwi9
         PnUDwn7R4tInx2AmCfTOvY/nxZrNssvxfKB2yUttQhS9bz7JrJ7zOrUkNC64pKiesCOR
         S5etSXq2VDMVgqlFOr9F4TLknY4K03RktlQUDwDFKmTSvYRxlvkWTQZ5pBhYQH0u4qGM
         ODq/RZwCGBLM4bpgeGUb8zbAZVjrYVVG2I8k+gvRxstVNrpZnxKQ3qrLm/KrUICLs0hO
         3dwQ==
X-Gm-Message-State: AHYfb5hK5ns5uxKm429fNTN9IAgMincRBiPY9JjRkxJ29bnwLIPKpYXP
        0uywS+NizXm35Q==
X-Received: by 10.99.107.72 with SMTP id g69mr2433596pgc.85.1502907140055;
        Wed, 16 Aug 2017 11:12:20 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id r5sm3474804pgn.45.2017.08.16.11.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 11:12:19 -0700 (PDT)
Subject: Re: [PATCH v3 1/2 / RFC] builtin/branch: stop supporting the use of
 --set-upstream option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
References: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
 <20170814085442.31174-1-kaarticsivaraam91196@gmail.com>
 <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
 <772aaebf-81ea-ac22-9d2f-35d0778f502f@gmail.com>
 <xmqqfucsr73w.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <09ce545a-31ff-aa9f-d03c-3cb68ed26230@gmail.com>
Date:   Wed, 16 Aug 2017 23:43:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqfucsr73w.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 16 August 2017 12:28 AM, Junio C Hamano wrote:
> Some refactoring to make it easier to reuse it from the new caller 
> would be necessary. 
Sorry but I think I don't get that correctly. What's the "new caller" 
being referred to here?
What should be refactored?

---
Kaartic

