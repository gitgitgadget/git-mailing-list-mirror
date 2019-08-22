Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775491F461
	for <e@80x24.org>; Thu, 22 Aug 2019 13:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbfHVNlX (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 09:41:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35052 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387699AbfHVNlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 09:41:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so5155755qke.2
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RFnfliKMZN3aJAK01zp2LE9SE5KNkQ/nVf3LrKFd0Kg=;
        b=SOXIRPaLWJ56dBollprnfckahUEQ5m87xnC9xXcIFpgSbPpiNr79LL/EUdcr1iEedL
         GzeC7OPBjlJ3zleoXIx2SLw8ZirVvZeYnsfPI6Awiq16iKCHUg3oQGbaGnclLDsYLJd0
         KYYvdfiBD9r7dnLN67EO62rKxm/WFwAhCvZMvfnZarS0E2cZjkFlOM9aS8lWbnMknW4i
         UEl+gr3F/MsYAUGXly3KeTQ4WSSlzjkWZ6WT6UUJqAiZlo19G6jPLPaAOqvxydqm50uZ
         qV+inOy238hACmmdWJtnuLQhuvZtQplMP5KmUieecxPMq8DT1/WKuQ//yXhzT0Xc7Lhc
         4Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RFnfliKMZN3aJAK01zp2LE9SE5KNkQ/nVf3LrKFd0Kg=;
        b=jdWDkUK5rcO0F9MEE1ice+/aPtgKuXbMQKY+p4q1f8uOzMmVgU/2EH1Mw/gLlKttW+
         uGTl2GBMsuwEwqTqCRi7Rdcd03MW7MLD45+aBpF0t7E9fq25f/BpGKvmxii9BIINLvCx
         UNIL3/1yF3rHSNOT+cEXpnbWs2QPgNdxoRBMGfSkFYygKjgwebUXCGJudH5rSRDnVe22
         tlZl+A4hpbJTvy7NR/xW/loa9Z63M+Le8YqKDoLM10wbeuSWdrP5ZGR+AFyBSLq06bqb
         +J0tRNDHs0pmr9iypVyMajvA8uCRZ0VCHwgJRF5cOBoMBgsZOo+ITfMM6so6NlofAZLw
         yQdg==
X-Gm-Message-State: APjAAAUfGXJ7zAOTZffdPHAjeezoyDHykAJH5Jo/KAXYy90Fu15JOcJM
        234Sxp7YTFyTe6wAgFNZh+c=
X-Google-Smtp-Source: APXvYqxSdGNx1LVtabFVY/PQvnm9dcgUG6ZN9LYcJlYWAZEkqiuDuMGWs9z5e9a7amn21xQhaZ4S4Q==
X-Received: by 2002:a05:620a:696:: with SMTP id f22mr36490495qkh.232.1566481282150;
        Thu, 22 Aug 2019 06:41:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7dcd:416c:c779:cf77? ([2001:4898:a800:1012:2f01:416c:c779:cf77])
        by smtp.gmail.com with ESMTPSA id g25sm11714616qkk.87.2019.08.22.06.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:41:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] Revert "switch: no worktree status unless real branch
 switch happens"
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.317.git.gitgitgadget@gmail.com>
 <538420ffd575f1705e9fb764f9d86e5d4d7f25ad.1566415112.git.gitgitgadget@gmail.com>
 <20190821221504.GA20404@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f1490c64-a81f-3269-d2d4-207d0a23cc25@gmail.com>
Date:   Thu, 22 Aug 2019 09:41:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190821221504.GA20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2019 6:15 PM, SZEDER Gábor wrote:
> On Wed, Aug 21, 2019 at 12:18:33PM -0700, Derrick Stolee via GitGitGadget wrote:
>> This reverts commit 65f099b3988198f0fdf3ef7a21dc01c556d21fff, which
>> removed logic for avoiding extra cost in "git checkout -b" in favor
>> of the new "git switch -c". This will cause a performance issue for
>> users in large repos.
> 
> It always makes me sad when I see a pull request, where all the
> relevant information is only included in the PR, which will not be
> part of the history, but not in the commit messages...

An issue with the RFC quality at the moment. I'll do a better job
if we decide to move this direction.
 
>>  builtin/.checkout.c.swp           | Bin 0 -> 77824 bytes
> 
>> diff --git a/builtin/.checkout.c.swp b/builtin/.checkout.c.swp
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..f6dad4abb02c265ee66b3f6f76d00d59b9b524a4
>> GIT binary patch
>> literal 77824
>> zcmeIb37F(pRrf#a46<X03c_z1GgCe3>dYjdA(>2=r6*}KnI2}zLK2GV?&_Y(bXPT1
>> z)icux34uRC00rR{;pJ5jL_ico7FiV85d;D8CG1O3By6%HioE<k-*fK$ZB^AXi9sKq
> 
> Uh-oh.

Whoops! I thought I removed this in time to submit, but I guess I
did not.

-Stolee

