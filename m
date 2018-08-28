Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9AFA1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeH1Xw4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:52:56 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:39979 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH1Xw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:52:56 -0400
Received: by mail-qk0-f180.google.com with SMTP id c126-v6so1859843qkd.7
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UHkSfHBVAtSLxOLU4Y7SUL06DC+nXOzQkvGAGwBscJA=;
        b=cKq5DF9KWmeczkSNT1zEjEyLgjf8Mgzc0xEbl1dts2hARvCieK3VI/oSlgUpsYgtap
         476QwUC+L4QASinyv7mb1pscAv+/RhMzuxhMlaarh85YBb/ipU3hIzIdygPMZv4qqcTy
         HVmI2G6NNbHuuILBtyZWz/U/FRxLJrWG0kIMgFHVrQM1U28CB5MkpDLoyyy4nmTq09RE
         +nqnJPDCQ1mDBmdi/Au6UVn9xYd+f7p58C9WS/AMj8bnRGBbv7ORukA3RSTpHpAxrkln
         RJxG6sh2MDpwMn3eTFe9vMQIClOJDyV31x0gsRgLvfIO9efr4PMQ2OhuazQiXCOwf8bQ
         N1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UHkSfHBVAtSLxOLU4Y7SUL06DC+nXOzQkvGAGwBscJA=;
        b=UQUVQ6jsKJCn+uXwZkhnz75+Uq3SIQqSi9FjdJrWmLMmBZSVfkX8yeULzamji1R3fT
         sqlP8l5UEkWsj46NlZX9i5O4MLk9fhvzYJB4uI+t/QHHg8jVa+6kMBuwlWes8TrC39sJ
         +FVZTVArhAxLI8+4BRtp92Tl7VraoDpSsRWWSmlnUaKiS9PW8YMG4zP1Mzphel53YgQL
         0LPkmXT3KoqBief2L1dmRX6dfIyNm4QWqR0GCqnAq1660uyVjNfK962/tNFYWDD9DZ50
         z+GDUGMkGCdZPd2TgUCBKXR755eUkWEunwRLHpMx374Foc1v1U0cnCS6ky5B7gzSuSZV
         wZpg==
X-Gm-Message-State: APzg51DF89jzJwuot/uQ3dSqMR6RABkmyT8Uu2Y2fSnJPL0LiRR2netA
        8yFqFMQKQe7iM8UHJ7EGdTHy+BKx
X-Google-Smtp-Source: ANB0VdaFByuBfFIk4ZXyqJyU734hgbm/uKIMYn2hPuFhxzDv1LYbXv39frEHJRDhplxmNqZ38/ANuA==
X-Received: by 2002:a37:af42:: with SMTP id y63-v6mr3263927qke.87.1535486384054;
        Tue, 28 Aug 2018 12:59:44 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f86b:1660:ae35:a1de? ([2001:4898:8010:0:e1a1:1660:ae35:a1de])
        by smtp.gmail.com with ESMTPSA id x76-v6sm1180323qkx.25.2018.08.28.12.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 12:59:43 -0700 (PDT)
Subject: Re: Git clean removing tracked files semi-regularly
To:     Brennan Conroy <brecon@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <MWHPR21MB0701CD1D9653E82116E482ECD60B0@MWHPR21MB0701.namprd21.prod.outlook.com>
 <20180828005803.GB432229@genre.crustytoothpaste.net>
 <MWHPR21MB0701E9B53BC72CC33497AF45D60A0@MWHPR21MB0701.namprd21.prod.outlook.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8ed02573-3356-9d38-c1ae-f5a2c82693c6@gmail.com>
Date:   Tue, 28 Aug 2018 15:59:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB0701E9B53BC72CC33497AF45D60A0@MWHPR21MB0701.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 2:29 PM, Brennan Conroy wrote:
> I'm using windows. Have had it happen on 8.1 and 10.
>
> "git status" shows "nothing to commit, working tree clean". I am using git version 2.17.1.windows.2

I tested on my machine and could not reproduce this issue. Could you 
find a full repro (first command 'git clone 
https://github.com/aspnet/SignalR') and create an Issue at 
https://github.com/git-for-windows/git/issues ?

Thanks,

-Stolee

