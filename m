Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D544C1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 22:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIFCpI (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 22:45:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41277 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeIFCpH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 22:45:07 -0400
Received: by mail-qt0-f196.google.com with SMTP id t39-v6so10038359qtc.8
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=beSmQgQflkinhEc+xbugAdADCXlgNUZe+BpTAv9Su14=;
        b=h9h1+d03JmbzNbHYx/QBk1zPzviKta+GtT1TDuHUD64DDkDxOmvr786BU47lgPBcLn
         l3+QmoCTea0ZcgifBsjbeuuawZRxmV84HboVE/Cem1vkEpzubamnfMQKGDaWfHMtw/ps
         wQEYmI24nSwYXpKqyZc/Hc7txvospSqcygyR/vYILk3BJ2eIvEDCGNjuvdPDiZXMqf8g
         F7PUlLBCFgCN2z8Q1GXOABWDlXHRq/8qP6b+ZXMMYq3oP7B7PkX2bbdZg829LjpX8fv4
         /pAxW2xdpvqUzcCykiYEA4U49ijktpHakIqYX2BIZnkbhcAcuBIQCbA+O98IvnjOwIO5
         PNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=beSmQgQflkinhEc+xbugAdADCXlgNUZe+BpTAv9Su14=;
        b=Lv3YmjO47efKs/1sYeshDFWKPtlNLjh3FJRydssG+XXxZCBvbXD8p0lm06oext1E3o
         WKxa3ZftCrcTlrBtO4Oif9becA3PwJ6qo14DTnlfJD21POZByIeCGViyrWXnNKwik0zD
         Y5014+tOctNqcVxgs5gbHXgA9+3fYtUZ+qGxaX+eS+as3p/2IzdYb7a6Gaup7GStPENf
         05HlYqw970svRevMzqL+/jYFgOnK3ijAVFNSFloZtRhTaWP3shBMgudiPFvZv8bPs5Yl
         7fA+a/9JIWQBgxHnhFlwWZDyyFFK1HsOww2l2tAvvxdrrNuYccIUWOR9oxLR3dqsR1b6
         de2A==
X-Gm-Message-State: APzg51DRRH7jpi9xHTGP7moc5InmEpilml/p7FCzimyuoedLIfzW6y5P
        FtrekqzfbUozy+45vQSd8eheOBRO
X-Google-Smtp-Source: ANB0VdbcnA5LKOuAc3c7oMVLY9ysduibDLbhNx28sGI1VFMan5NmeXumqoz2YtWKKCM4f3j9NFNQlQ==
X-Received: by 2002:ac8:70c5:: with SMTP id g5-v6mr35401576qtp.271.1536185574104;
        Wed, 05 Sep 2018 15:12:54 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id f6-v6sm1862176qke.77.2018.09.05.15.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 15:12:53 -0700 (PDT)
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20180904202729.13900-1-avarab@gmail.com>
 <20180904202729.13900-2-avarab@gmail.com>
 <xmqqin3k7w8b.fsf@gitster-ct.c.googlers.com>
 <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com>
 <xmqqtvn339dp.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8ea40192-ea3a-33e6-c561-ee7b4ab7f040@gmail.com>
Date:   Wed, 5 Sep 2018 18:12:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvn339dp.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/5/2018 5:46 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>>>>    	for (i = 0; i < commits->nr; i++) {
>>>> +		display_progress(progress, i);
>>>>    		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
>>>>    		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
>>>>    			continue;
>>> I am wondering if the progress call should be moved after this
>>> conditional continue; would we want to count the entry whose
>>> generation is already known here?  Of course, as we give commits->nr
>>> as the 100% ceiling, we cannot avoid doing so, but it somehow smells
>>> wrong.
>> If we wanted to be completely right, we would count the commits in the
>> list that do not have a generation number and report that as the 100%
>> ceiling.
> Yeah, but I realize that the definition of "right" really depends on
> what we consider a task being accomplished is in this loop.  If we
> define the task to "we have some number of commits that lack
> generation numbers and our task is to assign numbers to them.", then
> yes counting the ones without generation number and culling the ones
> that already have generation number is outside the work and we need
> another loop to count them.  But the position the posted patch takes
> is also a valid one: we have some commits and we are making sure
> each and every one of them has assigned a generation number.
>
> So I do not think it is necessary to introduce another loop just for
> counting.
>
> Thanks.
Makes sense to me. Thanks!
