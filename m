Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E731F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbdG1Skt (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 14:40:49 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32876 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdG1Skp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 14:40:45 -0400
Received: by mail-io0-f176.google.com with SMTP id j32so72288656iod.0
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=idUcsBoJXzei3io87Kxiz/GBFMUIzWoe4jxs4A63x0k=;
        b=I9iJq8oY3cBQ/pVgRAgrCJis0wOBoeZEBTNQe/t01dgL8WQCIeSt39A1JCht7M8QHf
         EREEXetGQqLiCZT+gJ7LHo4/ZSQQEkZKWhsMXLb3/7vQhpsu8q2Bo8xs5crRbFFJVFYo
         bwVYADLqDypNu222PJ3wZQBtMPNX4jmDUQv3uswpv36h6k+wLkBHb/MU6NL6My2OM6OZ
         qN2k8Jap1dxAObD7n7F2ZPBnHLQJLrKxNMnyrCHOWdy8stwYJ+rTiN+L+0D9JSXiJA0X
         /Gaxz4H+0UQsg2Q+a1ite7hBVff5HvfF41fCd0ZmfoAm18mrebHF2htNe/yr1KHlLSQF
         RDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=idUcsBoJXzei3io87Kxiz/GBFMUIzWoe4jxs4A63x0k=;
        b=Nc82XtN1pwQh6mPMMK6j/w4FzeCbKl2/v0gwcOcGCcs+d9vwhomM1MzIo+rvlQA0YM
         rPgdwc1zOvUwB+FKiKYzNT06v0ttJ0W7bAfeKIXn6/8aoTRFnZvsiJyBiktWNw14FrWr
         R8kG1dn4c1lWQL1mNNBaVtPS/MGICp8QmNvvh+4fu5q64vejDFsVTJ0WeIVMSvRcpDzf
         3XAT3TLgDRTibEwZyCqwL4j8RdTCiJ1eNJtLPoPwDloRzMnLUeyHpv56Uezio/YMXFim
         MIOwIzGWe7Ev7HR1FIaqc8KZsCqJYhNat7GigQ5cNZrRlSZY5Mn47e5w4dbmQLhzmEbH
         8zaw==
X-Gm-Message-State: AIVw112x0cHeD2OGz7QuhLTtgcfSpb0/G3EecFrdJRteZVNxbfRA8qhM
        sQwhXcuY45lDTJcOvLs=
X-Received: by 10.107.59.200 with SMTP id i191mr11097192ioa.171.1501267244851;
        Fri, 28 Jul 2017 11:40:44 -0700 (PDT)
Received: from [192.168.1.6] (d24-150-81-207.home.cgocable.net. [24.150.81.207])
        by smtp.googlemail.com with ESMTPSA id c37sm1441181itf.2.2017.07.28.11.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 11:40:44 -0700 (PDT)
Subject: Re: [PATCH v2] contrib/rerere-train: optionally overwrite existing
 resolutions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <1caa9bb1-9184-7335-a041-6abd2c8f616c@gmail.com>
 <xmqqwp6wtdu0.fsf@gitster.mtv.corp.google.com>
 <ae4d9b77-c47e-199b-d40f-ad5b49c5dd60@gmail.com>
 <xmqqmv7rrs45.fsf@gitster.mtv.corp.google.com>
 <32b61c4b-5e58-30d9-4345-8036bc805019@gmail.com>
 <xmqq60efq6bo.fsf@gitster.mtv.corp.google.com>
From:   Raman Gupta <rocketraman@gmail.com>
Message-ID: <c522f452-0b30-3408-1673-8b62ffb7f039@gmail.com>
Date:   Fri, 28 Jul 2017 14:40:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq60efq6bo.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/17 04:41 PM, Junio C Hamano wrote:
> Raman Gupta <rocketraman@gmail.com> writes:
> 
>> On 26/07/17 02:05 PM, Junio C Hamano wrote:
>>> I haven't tried this patch, but would this work well with options
>>> meant for the 'git rev-list --parents "$@"' that grabs the list of
>>> merge commits to learn from?  e.g.
>>>
>>> 	$ contrib/rerere-train.sh -n 4 --merges master
>>> 	$ contrib/rerere-train.sh --overwrite -n 4 --merges master
>>> 	$ contrib/rerere-train.sh -n 4 --overwrite --merges master
>>>
>>> I do not think it is necessary to make the last one work; as long as
>>> the first two work as expected, we are good even if the last one
>>> dies with a sensible message e.g. "options X, Y and Z must be given
>>> before other options" (currently "X, Y and Z" consists only of
>>> "--overwrite", but I think you get what I mean).
>>
>> You're right -- I didn't try all the cases. I wasn't able to figure
>> out how to get `rev-parse --parseopt` to deal with this situation, so
>> I did it manually. I'm not super-happy with the result, but it does
>> work. Look for PATCH v3.
> 
> Yes, I think you could squash the two case arms in the later loop
> into one i.e.
> 
> 	-h|--help|-o|--overwrite)
> 		die "please don't." ;;

I considered that but decided the non-collapsed version better
supports this list growing in the future.

> but still the repetition does look ugly.

Agreed.

> As a contrib/ material, I do not care too deeply about it, though.
> 
> Will queue.

Thanks.

Regards,
Raman

