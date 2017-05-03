Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE131F829
	for <e@80x24.org>; Wed,  3 May 2017 17:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbdECRCo (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 13:02:44 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34303 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753824AbdECRCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 13:02:37 -0400
Received: by mail-pf0-f182.google.com with SMTP id e64so15458202pfd.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 10:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IhD/+aZeVILbRh71hpIFzd+Ojtu5ASBSUkE9sQKCudE=;
        b=CDGrzArYlfySe2WzhaJ7xGsfWEw5LfUE1LrLeuX85RFlwldsCLsN1I8EqS9GVBErVv
         LxUIvomUIwxkjQkd4juteytQcGKI0TYkfOeaQnS4ohJ4XsgMbG0/xLBfN/47NGdrAwVP
         GT16eHGhmIfc/lGxrBGEoi7lo1gFLfs+iqjVLlutiPTQO/ORqx18MhCpjySyz3vnumg2
         lU+MK/Bz+0ZkVTl1NNoMgAmPlYcpl2Jwg2EpYW1wqFDW8iFJ9M7M1C/hV1ujiW2v256x
         9MsT0Q/XcVz7BvSPSGjc/OkMWGFDM2rR3dHG5CeK70aKUoOWdJiEL+8pWztA7EVUW0/X
         BLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IhD/+aZeVILbRh71hpIFzd+Ojtu5ASBSUkE9sQKCudE=;
        b=It1omf6KCCotSF1QSAvc5D3OjheDrpDOWbIce2nxk1OFB39q5hszITn097uQpI7T48
         jZBCRTqg9GJJh/lMxHTk9y/m3BSoWIVxGvhD9FrNoTwkot5G8M4ERdSD6ZJdmyYB2/us
         6ESZis9WTAjtbmf0ZH2AGxQGOuxkOe5a2Av3agZiu3F13PAPedZv0SDJibQ0USO0GHmz
         pyGUMA3PRd1NLKgT8uqx7xtnXEeCXer2sMgwGm5qHk6MHbSgkouC8qHIqYDQ08pneXEJ
         iMHn+KSGWCgO3dTkYrzn/0OeLHN+1+aJasu6jQrX/3HkQGXUWc7Yr9GvbCFSSXbQNatQ
         NCJw==
X-Gm-Message-State: AN3rC/7BJxb1fCuGCg1ZnOSkL3BdGcV0vW6SFWRzNq1Nh8TAGskl1Y6R
        w+Tswl67pecefU1NC2RLbz3OtRBkmcEn
X-Received: by 10.99.56.66 with SMTP id h2mr41018727pgn.40.1493830956443; Wed,
 03 May 2017 10:02:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 3 May 2017 10:02:36 -0700 (PDT)
In-Reply-To: <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com>
References: <20170501190719.10669-1-sbeller@google.com> <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 May 2017 10:02:36 -0700
Message-ID: <CAGZ79kZk_p0-oVrNbqPSyWq7ZGdpQNYNjpCpqxtvU_-=n5EqOw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 3:27 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 2, 2017 at 8:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> This applies to origin/master.
>>>
>>> For better readability and understandability for newcomers it is a good idea
>>> to not offer 2 APIs doing the same thing with on being the #define of the other.
>>>
>>> In the long run we may want to drop the macros guarded by
>>> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.
>>
>> Why?
>
> Well.. why did you add NO_THE_INDEX_COMP... in the first place? ;-) j/k
>
>> Why should we keep typing &the_index, when most of the time we are given _the_ index and working on it?
>
> I attempted the same thing once or twice in the past, had the same
> impression and dropped it. But I think it's good to get rid of cache_*
> macros, at least outside builtin/ directory. It makes it clearer about
> the index dependency. Maybe one day we could libify sha1_file.c and
> finally introduce "struct repository", where the_index, object db and
> ref-store belong (hmm.. the index may belong to "struct worktree", not
> the repo one...).

+cc Brandon, who attempts to come up with a struct repository as we speak.

> So yeah it may look a bit more verbose (and probably causes a lot more
> conflicts on 'pu') but in my opinion it's a good direction. I wish
> Stefan good luck. Brave soul :D

Thanks for the encouragement! As you seem to be interested in this topic,
you may want to help out by reviewing, starting at:
https://public-inbox.org/git/20170502222322.21055-1-sbeller@google.com/

Thanks,
Stefan
