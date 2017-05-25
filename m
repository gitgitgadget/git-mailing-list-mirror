Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8A0209FD
	for <e@80x24.org>; Thu, 25 May 2017 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969601AbdEYNzj (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 09:55:39 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33716 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965991AbdEYNzi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 09:55:38 -0400
Received: by mail-qk0-f194.google.com with SMTP id o85so30220701qkh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HD+XlH1LcB6nNU/papIinhuz97Je4wUqvcDWGEiX0pE=;
        b=lQM9TenR9eCRi45tBCDu1yl4pB9QYIq5NjbOfh/+n4lKUg28YQoWr7+6aJexixXrOF
         YIp6n84ARXsMADGY40NJjprRX5AbEPLTyOePS6BhZYyr+/k97tFDkB+YZRtMiwkJ2dMu
         sffXCTTppVVA0yH2q5oYUSAT2QXYv89hnhyEFX+zHtkBOR1VsDpY3GbFexCNYsiJnzsB
         JdDy1BiCsvTjYVT/DupBb6DP/m2j9+tAao90rwM0dKDC5U+qJSh43nCJOqdkgacB4Iiy
         6nnN1dQWUvSr8YiFZ/Aa71I/nHZIuGMRqnxk2A0UKdLpTgIFhIcuPa1Ve5e1B3oIXs8o
         SCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HD+XlH1LcB6nNU/papIinhuz97Je4wUqvcDWGEiX0pE=;
        b=E0VsqXivsya5HHB5zT+8xECZqsEXgTp9/YPCDmpHOOx/9bAMDBoJ7hoamvff2VR210
         YmeTBk/+09qJvvQudhppegDwt4Ws/o06tBkC6GK+6gf0ylE3j906ZvGpPuRZNCjMg1nO
         oo+6ETU8d0P1XaMZcWL5d9LDFGBjxBb+xIf0YwtKuLrWLPugUkepUMaj4DLPlpmjnM2Z
         StfDsDD2gzJ+V4fRxQWpbLedmP6MCzSahUgxlLgF32RB0DaaHVS/cJqLNR70xckwuTtk
         jmwB+Rj8KVXSObUfExbqwNxWkBEN935K1nDQFRTQVgVWBrPstkSBwy8AkHMfuL5ZMEfc
         sLiQ==
X-Gm-Message-State: AODbwcBOkniJDMo1l+rsYPZHKoLDck6Bk881KfWVUQj0Y/SXHZFb91Eb
        d/DkvjMO+1owYA==
X-Received: by 10.55.76.69 with SMTP id z66mr39067573qka.1.1495720537858;
        Thu, 25 May 2017 06:55:37 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t20sm4734523qtb.22.2017.05.25.06.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 06:55:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] Fast git status via a file system watcher
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com>
Date:   Thu, 25 May 2017 09:55:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/24/2017 6:54 AM, Christian Couder wrote:
>> Design
>> ~~~~~~
>>
>> A new git hook (query-fsmonitor) must exist and be enabled
>> (core.fsmonitor=true) that takes a time_t formatted as a string and
>> outputs to stdout all files that have been modified since the requested
>> time.
> 
> Is there a reason why there is a new hook, instead of a
> "core.fsmonitorquery" config option to which you could pass whatever
> command line with options?

A hook is a simple and well defined way to integrate git with another 
process.  If there is some fixed set of arguments that need to be passed 
to a file system monitor (beyond the timestamp stored in the index 
extension), they can be encoded in the integration script like I've done 
in the Watchman integration sample hook.

> 
>> A new 'fsmonitor' index extension has been added to store the time the
>> fsmonitor hook was last queried and a ewah bitmap of the current
>> 'fsmonitor-dirty' files. Unmarked entries are 'fsmonitor-clean', marked
>> entries are 'fsmonitor-dirty.'
>>
>> As needed, git will call the query-fsmonitor hook proc for the set of
>> changes since the index was last updated. Git then uses this set of
>> files along with the list saved in the fsmonitor index extension to flag
>> the potentially dirty index and untracked cache entries.
> 
> So this can work only if "core.untrackedCache" is set to true?
> 

This works with core.untrackedCache set to true or false.  If it is set 
to false, you get valid results, you just don't get the speed up when 
checking for untracked files.

> Thanks for working on this,
> Christian.
> 
