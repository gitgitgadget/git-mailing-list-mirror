Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3AFF2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 20:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdISUod (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 16:44:33 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36436 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdISUoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 16:44:32 -0400
Received: by mail-qk0-f195.google.com with SMTP id i14so502286qke.3
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0y2JWgyqX6whlSoweZvMK8Ab/611whtJ2+1cPlwxnlA=;
        b=Hv1/P7dBTQ+enlGJxghcrp4C363Y05JnQoCdSA5fR9Ohgz86kK20w49T6mxfkBd05b
         jHwxWRTgHRp58VyrGFCOEqnTikGHfC7ZsTX9z9Kkyw2gYkx4ILXFqBgDtMNFrDg42FWr
         yhxk3NKXNnChD3Q1gowWu86CoZO0Sh2MDV+69IA7xePvTELx1jiKeeOPthmCTWyUTrgu
         agLQuLYotUTxKWX2QvmmTWeYYsYVCvidZ4ovAnAsw/gX1hs/pGgt2TnHpGxEvEwE0A1n
         g0qvsaetJycI928ZxICZZZHPExyxYru7Ccdg+gLfJI7GCwnRB95tj+Ab0ZTTxE3LE2oz
         k7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0y2JWgyqX6whlSoweZvMK8Ab/611whtJ2+1cPlwxnlA=;
        b=fZkgoXfEj/kyk9odPnw4vCC9cLSuHgGrdskBC/J1jmKFAdIxbbMVtWUp7+j8d3qovz
         /qRj6dousSS5n1A/xdUfCwCh7KTswMHov8gihVPycKM/BILs7m+sf8pK9N04UPjUdFH3
         L+NKRdhomx47//KFI5O8vyrPHBsnNBTz6MOEUh1vsT5P8CLQMlnFLAy92puBqtGzGcKM
         r7liK086Kd/+KVX2CTE6aw8zXAIn3I9Hfqe/Y01ez31ZboHjuJedwnNfRK+1LsGO2VIE
         j7pRcr5J6dci1MJaHKoTxaFRxoP4m/LYc80nMbnuB5Ky34ntGVh72B5fGX0INTdCVys/
         k8hQ==
X-Gm-Message-State: AHPjjUiw5fsQc1QhQbl780rUqxbJPOG2QhDspyWxUAVL6pJU7JB+lh6g
        BB4piPiz3cPnS2NP8K0DVng=
X-Google-Smtp-Source: AOwi7QAV/DW6l7nye1pCY70fI66g7oEDVh/LBC1/k6uq2aJM2GWCYaYPS+14482ITj+mvZYAhbNzUw==
X-Received: by 10.55.79.65 with SMTP id d62mr3840403qkb.224.1505853872091;
        Tue, 19 Sep 2017 13:44:32 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id c38sm172985qtc.18.2017.09.19.13.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Sep 2017 13:44:31 -0700 (PDT)
Subject: Re: [PATCH v7 06/12] ls-files: Add support in ls-files to display the
 fsmonitor valid bit
To:     David Turner <David.Turner@twosigma.com>,
        'Ben Peart' <benpeart@microsoft.com>
Cc:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-7-benpeart@microsoft.com>
 <37b2e5b4ca1d490b9f50d430b3b420f0@exmbdft7.ad.twosigma.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f1213833-be5e-4850-0ffa-d063e2d1deb8@gmail.com>
Date:   Tue, 19 Sep 2017 16:44:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <37b2e5b4ca1d490b9f50d430b3b420f0@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/19/2017 3:46 PM, David Turner wrote:
>> -----Original Message-----
>> From: Ben Peart [mailto:benpeart@microsoft.com]
>> Sent: Tuesday, September 19, 2017 3:28 PM
>> To: benpeart@microsoft.com
>> Cc: David Turner <David.Turner@twosigma.com>; avarab@gmail.com;
>> christian.couder@gmail.com; git@vger.kernel.org; gitster@pobox.com;
>> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
>> Subject: [PATCH v7 06/12] ls-files: Add support in ls-files to display the
>> fsmonitor valid bit
>>
>> Add a new command line option (-f) to ls-files to have it use lowercase
>> letters for 'fsmonitor valid' files
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>   builtin/ls-files.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> This is still missing the corresponding documentation patch.

Sorry for the confusion.

The documentation is all in a patch together as they all have links to 
each other.  You can find it here:

https://public-inbox.org/git/20170919192744.19224-6-benpeart@microsoft.com/T/#u

> 
> I can see from replies that at least some of my messages got through.  In total, I sent messages about:
> 04/12 (I see replies)
> 05/12 (I see replies)
> 06/12 (no reply, issue not fixed)

The documentation is all in a patch together as they all have links to 
each other.  You can find it here:

https://public-inbox.org/git/20170919192744.19224-6-benpeart@microsoft.com/T/#u

> 10/12 (no reply, haven't checked whether same issue but I assume same issue since the new case I mentioned isn't added)

It wasn't a bug so I didn't "fix" it.  I just sent an explanation and 
patch demonstrating why. You can find it here:

https://public-inbox.org/git/84981984-02c1-f322-a617-57dfe1d87ad2@gmail.com/T/#u

> 12/12 (no reply, typo fixed -- no reply required)
> 

Hope this helps.
