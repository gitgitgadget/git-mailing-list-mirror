Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2D720188
	for <e@80x24.org>; Thu, 11 May 2017 00:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754400AbdEKAd2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 20:33:28 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36824 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdEKAd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 20:33:27 -0400
Received: by mail-pg0-f41.google.com with SMTP id 64so5679675pgb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 17:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=emMVjp7nKgHqM1OZH1bsyYtEMAMbRMmitt0pK6jaJi4=;
        b=inFI679alse86qZH+3pijkjMWGAczlMCMt/yKTq/DExzWxSZGSR4RtJ2/xM1NKEO4N
         yeXJgwBSwP/VjF345mMTx9h6SL+i2gkOCKeHfR+cOgL+SbDfDNZUW91gyyLWOcajt1f5
         6FcQqHk3FKE9hcoE6zngh580sLHbFzc5Kk+fP+wJ2UYudrEx6Adeuk/2vix9o102goRi
         wC7oeAa8Jn6V8mOpl3wKApzdHe1VyFQi+pHmt5juUPSaKP7dondBQ5mpfoC8sk3xwShG
         kleTSkZCuwoQA9/XRHfJS3KViLjWVHwXcgeBGAFxISKNH0TZvoqWssT1ieZ3fiU6NG9T
         oDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=emMVjp7nKgHqM1OZH1bsyYtEMAMbRMmitt0pK6jaJi4=;
        b=Q8V5T8Wpzoy3rMiFCvaEq/s9JwgWaQeNgWPTZaNg0rGc9tqBO/2t+2P5yodE7PnRU1
         kl5iDLNUgWn3dz7zvNXU3c5vRSV29bNNIPoGaeHfYMQQOcnQc31FKGI4Kker8cOpNBzc
         f7/smDBaaFOpr8nIvKse8Hvg4U/fRUdkS/Yg6LZXXM112M1LlbTeYvygdBZWWGyMb7Xm
         RbATGgm6MPIXqQ8ybLfgThbPXZjAGI2Ul7SCEGROVGTtLppvl/+xVZlFanszeZDmBphc
         p3+rwni1q0/GCz1MF1ta9OZqoGAGkOAM4NWcHqwLdsNc2YsMgsGxWrfviAUlmOW6lIMB
         1X6Q==
X-Gm-Message-State: AODbwcABfz2uFPgyi6BjRWWVC6a/fKBBuJgX044n5UAWLEt/pIdQxUAM
        IkdyZ4NDkooDwLayrwI=
X-Received: by 10.98.89.5 with SMTP id n5mr9225927pfb.2.1494462807142;
        Wed, 10 May 2017 17:33:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id q27sm127897pfk.4.2017.05.10.17.33.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 17:33:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] perf: add function to setup a fresh test repo
References: <20170510225316.31680-1-avarab@gmail.com>
        <20170510225316.31680-2-avarab@gmail.com>
        <20170510233032.GD28740@aiede.svl.corp.google.com>
        <CACBZZX50-0uzMyYJo5Z92nRH0m-Q70=P4Wr-LwBqH71nXdsmcA@mail.gmail.com>
Date:   Thu, 11 May 2017 09:33:25 +0900
In-Reply-To: <CACBZZX50-0uzMyYJo5Z92nRH0m-Q70=P4Wr-LwBqH71nXdsmcA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 11 May
 2017 02:00:12
        +0200")
Message-ID: <xmqqshkcw7u2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, May 11, 2017 at 1:30 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi,
>>
>> Ęvar Arnfjörš Bjarmason wrote:
>>
>> [...]
>>>  # call at least one of these to establish an appropriately-sized repository
>>> +test_perf_fresh_repo () {
>>> +     repo="${1:-$TRASH_DIRECTORY}"
>>> +     "$MODERN_GIT" init -q "$repo" &&
>>> +     cd "$repo" &&
>>> +     test_perf_do_repo_symlink_config_
>>> +}
>>
>> Unlike the other two variants, wouldn't this leave the cwd inside the
>> new repo?
>>
>> In other words, I wonder if the commands starting with the 'cd' should
>> be in a subshell.
>>
>> Thanks and hope that helps,
>
> Yup, I'll fix that. Thanks for the review & also on the other patch.
> Will send a v3 with these issues fixed.

Thanks.  FWIW, I didn't see anything questionable other than
Jonathan spotted.
