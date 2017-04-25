Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC55207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 23:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951459AbdDYXjX (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 19:39:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33351 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950934AbdDYXjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 19:39:17 -0400
Received: by mail-pf0-f195.google.com with SMTP id c198so12993802pfc.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ef/FFiTF4e5uQ92r2GNQhSeYPlK7NMKCRH0sMNiCJ3c=;
        b=GtnZG2+VhbODBGkoCjFRdUubpmeqmjZIVMM0Jja71rXEvXdEJQKmjiCrWLK+EXxw/f
         BecJINajK7Czf+WG2bRU9GtcrvXPH0LdMNetntS/SCaDU1pk7Opxk4eHv0A5eHdkMRm0
         vDa3E6Px9b+habQUxkxBSF9iG77Y66a6GBUWdMBAbuTnUe62H5g/ZG1dMT00/ZfDNi3Q
         ZAZHxTG4ZL70ZTzXtgRzIXmVSCl2O+Ejhtvc27xntAB88Prf6XMLe3XnsVrDkK4/7psw
         FGk/Mnv4tkCEW3bOGzdiv5BUxWcq4C5CJEA987caRgZXpwIqaXPBE+bSLmAZa3RTZ90Q
         KaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ef/FFiTF4e5uQ92r2GNQhSeYPlK7NMKCRH0sMNiCJ3c=;
        b=QcoD+q4E8YQS1gA+g8GgIEs6mCeiMU/WUCkOzVgji2j0WPA4Wz2qT9AcxEuP2y7SS7
         KdBCiCGk/B4Wydbk9Sg9YI4jTEVqIwVmW4vMpGCjtInFtkt4nSqWJAN/CjVfSExLNZd0
         ch18/p1cuQ/HMkjcQ0/9JP7iCHVKslWjfv59ij/jyHIBMpraPwYaG8mucUvF6tLcs/Sr
         d7x0hBm7yxFT3+Xr8RWeRfLI8FFwUY3POFrguKT43yqgdm/e3R9a2MaPLVmJE3Ggr0w4
         u9aKrib4iSqFeDrNKWr6OkXwn64cNKFX0Nigrcevb4qwjm2jxJ/HtUBd4nXgTMDszS5n
         KXnA==
X-Gm-Message-State: AN3rC/6XVNG4xuRDyfB+sIL49COxfH5ODbfd5xFLru2G25iMAgM9ZrFl
        IAjZ+e2Aq5Y87A==
X-Received: by 10.99.114.3 with SMTP id n3mr8687625pgc.130.1493163556898;
        Tue, 25 Apr 2017 16:39:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c0ea:3a03:d3a7:cb53])
        by smtp.gmail.com with ESMTPSA id f131sm38295600pfc.54.2017.04.25.16.39.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 16:39:16 -0700 (PDT)
Date:   Tue, 25 Apr 2017 16:39:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] sequencer: require trailing NL in footers
Message-ID: <20170425233914.GP28740@aiede.svl.corp.google.com>
References: <20170421220155.GA142345@google.com>
 <20170425190651.8910-1-jonathantanmy@google.com>
 <CAGZ79kapU5AL_iPJXCavCKAQ0Fw=pqWZS4F6Vri-Q1M1WMVs_w@mail.gmail.com>
 <f49a858b-26da-7e8c-e0f2-8d66158f016a@google.com>
 <CAGZ79kbhxjO-tFW4_kObTZiauetjsgY1NBSKvo1NV5nKNEy2xA@mail.gmail.com>
 <alpine.DEB.2.20.1704260003570.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704260003570.3480@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
>> On Tue, Apr 25, 2017 at 2:51 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>>> On 04/25/2017 02:04 PM, Stefan Beller wrote:

>>>> Do we want to test for this use case in the future?
[...]
>>> I'm not sure of the value of including a test for this specific use case,
>>> because Git normally does not create commit messages with no trailing
>>> newlines. (To test this, I suspect I would need to use hash-object with a
>>> specifically crafted commit object.)
[...]
> Just because Git usually does not create commit messages without trailing
> newlines does not mean that it is a rare thing. We got bug reports about
> this, so I think it is frequent enough that we could save time by adding
> that test and avoid future bug reports/bug hunts.

To put it another way: it wouldn't have been worth writing this patch
if it wasn't worth keeping the behavior.  So we do need a test.

Thanks,
Jonathan
