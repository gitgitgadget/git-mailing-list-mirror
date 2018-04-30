Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ED95215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 18:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754713AbeD3Snc (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 14:43:32 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:55086 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754243AbeD3Snc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 14:43:32 -0400
Received: by mail-it0-f54.google.com with SMTP id z6-v6so7161844iti.4
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mxHZMmRNV3gdYpTCEdweT4lXQhSq9j7I2rE+WUlWrL4=;
        b=PtufG5Q+34K7Sg9uEDJ3BEV8+1cH/m3dy3TdhcoYCm0OIcljt5UM8ojBCUGC3DNUJM
         0eoiC+6Fn5JktWCIbb8r4VEGYubfrksDyga9ePTb/NRECRRiKx68B2myYM5HuBZe0Muh
         aka9KFuk8JaEsW/x1yF5FYaDqd+ATpK8IR3Y4M4x8BtSxB732JnFxLnMrN63ZXzDw5u3
         SJugNrp862XP776FDh03abz//nd7fy1OFm+euHqtzWSCPUL+fLTAovMJ53uDSXphj9ez
         trN0iE1TQg31c2L+ZPepx0cpFBYmvE9WudJUXLPQtheqaOLnvM3TgPtOKX+BY3iMpmfS
         Pb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mxHZMmRNV3gdYpTCEdweT4lXQhSq9j7I2rE+WUlWrL4=;
        b=oYvpPg02I5FvfNF768GPqDUnth1XYc2d2CPFZ6QJsr0n29ajznqTlWTojCdYm8kbMi
         9XHlwvRAqK0Kj7y1cpP3l2lK41o6xZC2S/W5py+76ymDx+9lQkXVoeVwjMT0Dl8rkr44
         95Jp7SLBXDgjJ3daRT6HWB6bmDYIEvgZpFven0DbjSVBNftO7E99Ygx6g4fAlKQ8xRtC
         WUCyvGQLGy/+7te8+op6qIcp0NvO/3qqCfQ6y5yj6ygLlqxiY8pj3+9w/ZGU8QXqfZJQ
         6IkKvbzZuoGb0GLZdI+1p5YuUUImMYmVx1jP8HPCGLEOuyP+fkJz/r05SMziJ70YxmnT
         Inig==
X-Gm-Message-State: ALQs6tCqp2es+DJ4KdfSCJGrT2o4tMYvyTe4YCP6bdjTO6zvapV9jznF
        u9xdVkcy9a+rpOeO1QDP1z4BVEkc
X-Google-Smtp-Source: AB8JxZqJLmOEWBWXa99N+bgeo/vxGibZzaAvvaU3jcLHIzmPSy8vfMzhbXAsxEvZMRw/6CqIsFMM9g==
X-Received: by 2002:a24:4293:: with SMTP id i141-v6mr12376332itb.54.1525113811417;
        Mon, 30 Apr 2018 11:43:31 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d130-v6sm2746326iog.46.2018.04.30.11.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 11:43:30 -0700 (PDT)
Subject: Re: [PATCH v1] test-drop-caches: simplify delay loading of
 NtSetSystemInformation
To:     Stefan Beller <sbeller@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
References: <20180430142555.23260-1-benpeart@microsoft.com>
 <CAGZ79kZvyFTKadjY11Xu+KcV9OUe-4hbjgPzBDcD52X2nZKCzg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <92ff364a-b46c-2274-a3fd-0b68eaa4159e@gmail.com>
Date:   Mon, 30 Apr 2018 14:43:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZvyFTKadjY11Xu+KcV9OUe-4hbjgPzBDcD52X2nZKCzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/30/2018 2:12 PM, Stefan Beller wrote:
> On Mon, Apr 30, 2018 at 7:26 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> Take advantage of the recent addition of support for lazy loading functions
> 
> Care to specify "recent additions"? Are these in Git code or somewhere else?
> 
> I find this alias handy, as then I can describe commits
> in commit messages via "git gcs <commitish>
> 
>    alias.gcs=show --date=short -s --pretty='format:%h (%s, %ad)'
> 
> Thanks,
> Stefan
> 

I guess "recent" is relative. :)

db2f7c48cb (Win32: simplify loading of DLL functions, 2017-09-25)
