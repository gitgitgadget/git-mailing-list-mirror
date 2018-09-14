Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD7D1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 13:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeINTEq (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 15:04:46 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34982 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeINTEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 15:04:46 -0400
Received: by mail-qt0-f173.google.com with SMTP id j7-v6so8781539qtp.2
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tEnWK/OVc8YIS0h5DWUINPtFGt3LP0ANMpvNm5PkUKE=;
        b=UgO0FmaaVRKNLvlDYchKyw3j8w2s/JLGX0HSvxshaI36tZ6Hw9iSTY5TpfE8tOmYKF
         MiMuEtmAgQfGJ0MW66/9trQSG5rFlrZ9vsWs0eTXW4p72jSBd7hewmOPaEJnhGzSpiZd
         bCRdj9MjsVpzfj9QzynPYmPC3WblgHhG50VP2vCqcbLP/25ERma8CToDJbD08Fc5PqjE
         mHOzvFTjXD/wrtkHws4m0ixlZyMjc6zrSvfYpRH0rDxMTE1nJ57VWXu58xLUhQpwpYJJ
         +oSPJwPdc4Od3AENzKbIyANR6NY67Lr6xvY6jZ5uqvjuumqypGBmFN++/uY5vdQEK/oi
         lJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tEnWK/OVc8YIS0h5DWUINPtFGt3LP0ANMpvNm5PkUKE=;
        b=f5Pc6CBDu/cIxDpwCXnAnxRhy3OC3gmtLV17GciLT01tJDgivhwuARQgLl0qTM1i7C
         IncztM21WNZWY15cdz9ZQeL1/5T1j7vED/U+HWMR8lEqoK8d2J+uGRkA/wFcmxI6ids1
         7ayOVbxb8pq3f+Tt+tpLZEsqIwaYcRqBwZ7iXye0FYyxYHIxYWOJtLcEYJRCEyQw0q9G
         6YkrF3cHu768zosRAaVGU4v1tHIj1bplPnGkVN06c2ExdDCsrGXJBtpc2jcYbBG360h8
         5DYMEoHvV9lKYpGx1gHvg4ANY5/8J/A+ciZjA5slZrFD1j0iFJz/MOIl8UXmPFv2TQwQ
         JS4w==
X-Gm-Message-State: APzg51D/IIiQCmYhAO+VY8dPlN6chOFIc/AK8yf7bw1cX93wpVISd3GT
        4TyDyf2YbvY1BelcxA/tbZQ=
X-Google-Smtp-Source: ANB0VdZktFyY/d1KJLQT4RV34tBSnTeB3+rN/WklIn/0CP9hsa1e6F8BrONtpSh0Xo+X0Y1qbq+m7A==
X-Received: by 2002:a0c:9664:: with SMTP id 33-v6mr8983379qvy.137.1536933009321;
        Fri, 14 Sep 2018 06:50:09 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id w30-v6sm4305740qtc.51.2018.09.14.06.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:50:08 -0700 (PDT)
Subject: Re: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
To:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180912212544.33624-1-benpeart@microsoft.com>
 <20180912223101.GA1719@hank.intra.tgummerer.com>
 <4f8b4664-6108-db7f-cb40-2bc55d9edece@gmail.com>
 <20180913215616.GD1719@hank.intra.tgummerer.com>
 <xmqqh8itdp9n.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0a3baaf6-f71b-e8f9-7445-8bf2b5d3513e@gmail.com>
Date:   Fri, 14 Sep 2018 09:50:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqh8itdp9n.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/13/2018 6:08 PM, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
>> Thanks, I do think this is a good idea.  I do however share Ævar's
>> concern in https://public-inbox.org/git/87h8itkz2h.fsf@evledraar.gmail.com/.
>> I have TEST_GIT_INDEX_VERSION=4 set in my config.mak since quite a
>> long time, and had I missed this thread, I would all of a sudden not
>> run the test suite with index format 4 anymore without any notice.
>>
>> I think the suggestion of erroring out if TEST_GIT_INDEX_VERSION is
>> set would be useful in this case (and probably others in which you're
>> renaming these variables).
> 
> I am not enthused by "you are using an old variable---we fail your
> build/test".  The assumption is that people let config.mak laying
> around regardless of how new/old the vintage of Git they are
> building and testing.  I do not think you'd want to adjust your
> config.mak as you switch between 'maint' and 'next.
> 
> I think it is OK to make it error only if the old one is set without
> the new one.  Then people can have _both_ set to the same value
> during the period in which the topic sails through pu down to next
> down to master, after seeing an failure once while building and
> testing 'pu'.
> 

I'll make it a warning if they are both set so that people are reminded 
to remove the old variable and an error if only the old one is set so 
people know to update their environment.

>> Btw, I think it would be nice to have all these renaming/documenting
>> variables for the test suite patches in one series, so they are easier
>> to look at with more context.
> 
> Yeah, even though these three were posted as independent changes,
> their additions to t/README inevitably conflicted with each other.
> 
> 

I'll combine all these into a single patch series.  It grew as I
discovered more that needed to be updated.
