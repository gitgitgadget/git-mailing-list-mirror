Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C61C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiCRTUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 15:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCRTUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 15:20:30 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD32C57A4
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 12:19:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c11so5680926pgu.11
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qfDc3iSVSw9D4yAHQoeaNJnS60/znff5O4yQOfWlnLY=;
        b=FwxxYA8QG0/4ec6VtcpWy7puNScM5M2I5Pzj1/5gMsdPdekVf0ylXBtqJd6XmMf+D5
         cL7lQqnxaY+CtD+0QrBFA6OLFW7lCJoK6ii73TVnQ8MjooSYH+7vl8CMH7dFwqcL4ywU
         tOU100KM4A+GK6rpSgPVdZ26TO2F5NOFhCEeA3Pyb9R3h/7qjbk0qalduakxnDrt6RA7
         B0By77qgv8CxB0HLOdL6aySWTTLmt3S+2CecNhjbcYU6rAeW+lkc+45O64Q+1oipNyLw
         eRBl4fhXusyHie/2nqS3XVPsafkEu8nVrQ43rz0P4sTIrqhze0CjeKTNifqYNM/W330t
         RWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qfDc3iSVSw9D4yAHQoeaNJnS60/znff5O4yQOfWlnLY=;
        b=zjP2nRraiO16f6mHC0lacZAm08cmoCBk5ASAPHp844r2KX8QOSkC2yq61zYliBguyF
         QTAgidJFmrP+ROusU+QXFJsGjH4DfmNU7IBvxyyNvj+OLuKC8VS/VUCXpYVydRgTiQWO
         xHEQTejOIkKuT50YK1eTHdPrvjr89fNpfFsy5gN0dG6mmpaB2LpB1N/KI3Psq0IOZKmA
         d0ja5sdQlWFvHgV+YWvpIeiCWPp9tdoEb2VIVM5wuZLggS28FWalBG8Qo7We58+20doJ
         B+7XgywP0pE5LeLel4fQMdIXItqsFDWw661nI0Yca+WnlzFILlNuAHdqNAfWpcjaNgf5
         qOHg==
X-Gm-Message-State: AOAM533hfbob3R48TF+CiYDB4ZEJmo+hryQagcZyCs2crLCNNjhO3A3c
        zA32Jj9562NF6YenNVUo+tVn
X-Google-Smtp-Source: ABdhPJzEzPVWT+Pjtsw5zJyOg4R30BmUQdX4NPrY2iZ+C33bo3+cb/W2aWmEivbA91DaLS2wnZNj6Q==
X-Received: by 2002:a05:6a00:230b:b0:4fa:7ca6:b1d5 with SMTP id h11-20020a056a00230b00b004fa7ca6b1d5mr1135268pfh.11.1647631150045;
        Fri, 18 Mar 2022 12:19:10 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a00228a00b004f769b40bd6sm10835872pfe.103.2022.03.18.12.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 12:19:09 -0700 (PDT)
Message-ID: <80a2a5a2-256f-6c3b-2430-10bef99ce1e9@github.com>
Date:   Fri, 18 Mar 2022 12:19:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/5] reset: introduce --[no-]refresh option to --mixed
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
 <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
 <101cee42dd6d5a4e5f12da647eafab9334d69a2d.1647308982.git.gitgitgadget@gmail.com>
 <80a5f411-2ddb-177f-4139-1dfff436deda@gmail.com> <xmqqy2179o3c.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqy2179o3c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> This keeps the current behavior of not refreshing when --quiet is
>> given. I wonder how disruptive it would be to take the opportunity to
>> get rid of that hack and go back the the original behavior of
>> refreshing when --quiet is given. There are a couple of assumptions
>> that make me think it might be acceptable
>>
>> 1 - anyone using a sparse index wont notice as refreshing the index
>>     should be fast for them
>>
>> 2 - the large repositories that are affected exist in managed
>>     environments where an admin who reads the release notes could set
>>     reset.refresh in a central config so individual users are not
>>     inconvenienced.
> 
> I would very much prefer to see "--quiet" not making contribution to
> the decision to refresh or not in the longer term.  Many plumbing
> commands expect that the calling scripts refresh the index with an
> explicit use of "update-index --refresh" and leave the index not
> refreshed, but working on unrefreshed index is a trade-off between
> performance and correctness.
> 
>  * Turning "--quiet" not to refresh may incur performance regression
>    for shorter term.  It will not hurt correctness.
> 

I tend to agree with you and Phillip on this. I took a more conservative
approach with the intention of preserving as much backward compatibility as
possible, but having '--quiet' disable refresh (to me) actively hurts its
correctness. If backwards-compatibility isn't a huge concern, I'll gladly
make that change.

>  * Introducing "--no-refresh" to mark "reset --quiet" invocations,
>    where the freshness of the index does not matter for correctness,
>    would help regain performance without breaking scripts.  All
>    "reset --quiet" invocations in scripts written before this series
>    are supposed to be safe (as they lived with their "reset --quiet"
>    that does not refresh), but newly written scripts may start
>    expecting that "reset --quiet" would refresh for correctness.
> 
>  * If we allow reset.refresh to be set to "no", however, that would
>    affect _all_ uses of "reset --quiet", including the ones in newly
>    written scripts that expect "reset --quiet" to refresh.  They
>    would be forced to say "reset --quiet --refresh", just in case
>    the user has such a configuration; otherwise these scripts will
>    be declared "buggy" for not explicitly saying "--refresh".
> 

I added the option as a "replacement" for 'reset.quiet' (specifically, its
ability to summarily disable refresh), but I can definitely see how it would
lead to issues in the future. I'm happy to remove it, but should
'reset.quiet' be removed as well? No other commands have a config option for
'quiet', and it presents a similar issue of potentially suppressing a
helpful feature (in this case, informational printouts) across all
invocations unless otherwise specified.

> I do not think reset.refresh is a good idea, but I very much like
> the idea to making "reset" (regardless of "--quiet") to refresh by
> default.
> 

I was hesitant to go this far because it would force people that were
comfortably relying on 'reset.quiet' to need to always use '--no-refresh' to
get the same behavior. But, to Phillip's point earlier, there are other
options now (like sparse index) that could provide a just-as-substantial (if
not greater) performance boost without sacrificing the refresh.

> Thanks.
> 
> 

Since this is already in 'next' (and, in its current state, I don't think it
does any more damage than the pre-series state), I'll send a new series on
top of this that deprecates 'reset.refresh' and 'reset.quiet', and makes
'--refresh' the default for all of 'reset'.

Thanks, both!
