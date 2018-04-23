Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5062B1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 13:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754897AbeDWNPM (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 09:15:12 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34425 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754825AbeDWNPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 09:15:10 -0400
Received: by mail-qk0-f176.google.com with SMTP id p186so13354978qkd.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4iM1SXPT6obfl015rX6PGSbY6x5pUQm40e4ZQZ0Inxk=;
        b=bf8Ujax9ijxTG9Hef3+8VKWm5NR56ixZ1JoWYIysnECAj7tyO8kJpnSawzFQOEnWoJ
         fi9mJ5nzMBpc6Cxd27a8fATev6NWsS1w2aFybCNrSJpFXBNoGO+wm9ds/poYWEZ//rRN
         eYnOp6JbuPvjHVepK2h8EHEXZTqRe7fmZkzhFrJUhwWJ3U4kYczxIaZvnDjz0FGJgS3o
         9kjo4h2RDyX11zMrGN7yPteGC+oHeiQuC1KZ7eqts1LElr+/XE9dxBsQeS5S6d/uGgjy
         Y8wka8t1MCdfjE1D6ioyXyxRnbolM7WN9phr6spT28iPlbPW+YESsic52988vGNlDu4n
         Cgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4iM1SXPT6obfl015rX6PGSbY6x5pUQm40e4ZQZ0Inxk=;
        b=H6TtwSX0cK1oFZ+z7ydSlcFrItZxehuZJeR4fCriAxsPrV0WkJ5yrPhpl72UYHThtQ
         GimM/3nKX9IHBnU6a6YGbFTuU9bV4l8fflJX+zNYRZUy5Z2xQ9Trw4fMAtHU4i+0AyiO
         to15Nk4y9t7aRgGt08F59RfJ1iWPntZmCbM7o5QpPZhoVvx/gsWCvOP1DENtiu+ivn4T
         HWLNVrhfOrahzeTJTWzQELOA/4zMbCbAlFMMdu6ypUkGSpVBz/Jc2/PxrOdHdp/yKMgi
         ARIYip0He91h8dyRYOZo+4HyRMdG7lNl0oOw+JR0nensHYY2Yt3iuWEaEnKBs4IKsWKu
         N+yg==
X-Gm-Message-State: ALQs6tCT6UDF1+wvUfIK/6MnURB1jEofadisySpUZ2GW0LFJOMC4+YWU
        sfuK3If6iaF6AaI+72dwfyY=
X-Google-Smtp-Source: AB8JxZoD+c83cV2W1UTrCzlt6U6XOg61UrnL/K1NNPmaoemAnkjQ6dX7MJCPzVHJ9EAnCxNJTUWmVg==
X-Received: by 10.55.92.198 with SMTP id q189mr22361903qkb.63.1524489309860;
        Mon, 23 Apr 2018 06:15:09 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id w51-v6sm4448717qtc.97.2018.04.23.06.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 06:15:09 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     =?UTF-8?Q?Eckhard_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com>
 <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
 <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
 <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
 <20180422120718.GA29956@esm>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0eea1726-d511-6818-aa29-add6c13900da@gmail.com>
Date:   Mon, 23 Apr 2018 09:15:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422120718.GA29956@esm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/22/2018 8:07 AM, Eckhard Maaß wrote:
> On Fri, Apr 20, 2018 at 11:34:25AM -0700, Elijah Newren wrote:
>> Sorry, I think I wasn't being clear.  The documentation for the config
>> options for e.g. diff.renameLimit, fetch.prune, log.abbrevCommit, and
>> merge.ff all mention the equivalent command line parameters.  Your
>> patch doesn't do that for merge.renames, but I think it would be
>> helpful if it did.
> 
> I wonder here what the relation to the diff.* options should be in this
> regard anyway. There is already diff.renames. Naively, I would assume
> that these options are in sync, that is you control the behavior of both
> the normal diff family like git show and git merge. The reasoning, at
> least for me, is to keep consistency between the outcome of rename
> detection while merging and a later simple "git show MERGE_BASE..HEAD".
> I would expect those to give me the same style of rename detection.
> 
> Hence, I would like to use diff.renames and maybe enhance this option to
> also carry the score in backward compatible way (or introduce a second
> configuration option?). Is this idea going in a good direction? If yes,
> I will try to submit a patch for this.

It's a fair question.  If you look at all the options in 
Documentation/merge-config.txt, you will see many merge specific 
settings.  I think the ability to control these settings separately is 
pretty well established.

In commit 2a2ac926547 when merge.renamelimit was added, it was decided 
to have separate settings for merge and diff to give users the ability 
to control that behavior.  In this particular case, it will default to 
the value of diff.renamelimit when it isn't set.  That isn't consistent 
with the other merge settings.

Changing that behavior across the rest of the merge settings is outside 
the scope of this patch.  I don't have a strong opinion as to whether 
that is a good or bad thing.

> 
> Ah, by the way: for people that have not touched diff.renames there will
> be no visible change in how Git behaves - the default for diff.renames
> is a rename with 50% score with is the same for merge. So it will only
> change if one has tweaked diff.renames already. But I wonder if one does
> that and expect the merge to use a different rename detection anyway.
> 
> Greetings,
> Eckhard
> 
