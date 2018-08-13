Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80ED41F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbeHNAIe (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:08:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45461 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHNAId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:08:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so15417077wrv.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WgBWMsj/KM9GyoNQi1Vm8RP9tOxA3/zEr/frP+0ynZE=;
        b=NFZu20ui0kacRwDWvDdWADuLsgfYn+ZWfI+dvrcm81vIXrvkF3YJ5SjREMJ1MWTZG+
         waPZa07YTXu5CEb3RiZsODIN6Vc2deTDmRRbCUhUH1ttxOx1Go7NayLr9QlNjR32cFDO
         SJ2JOamL8COiF9ZxexQgkL4EWQcRgv8lCmxuVUAgREYKwfEmH2mNEp6tz7y9iCC/EIIn
         sFMt5nCuMTgqN7VxA04WzolcwG8lJZKwjbIaAX0SuI/mCEt9yOfzFrN2+hpyyhgGDPCR
         KSQmNdcYzgH9Lf5lQXFxDx8ifD+8MpxhT3oI7xHDmp97264iTUvM8F9RPIvbbd4RdFeO
         7NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WgBWMsj/KM9GyoNQi1Vm8RP9tOxA3/zEr/frP+0ynZE=;
        b=XdRLuTeEiGoQ2KGNmCT3S+VXDg8Yuyptiq97/RL26s1eZYfE9EtgdbeMJQWECEVg+N
         VgHdM2nO1jqgoS3FF8+q656bXZ0kt+/azMYJpkHFWsRHcVRd+TL/KmvwmyFkSBBazU7w
         lBRkoOCLYZxdKVe/lIFSiyBq/VUTj8e9FKSukeaMGTZdse3xtNpAv66Ztb5O7b0hcyB+
         ookZKgaSwqtcL8iOTZcRT/LgwF8ZP98PGr3BQBc+rUh+k4StInxbPAmK8rZA4td5Vq1r
         7DARdzU2fS3ttdXCSzyIfa+zHt110ox9XoWpnbcPmjctWP5wfLq2NwU58ZrcwSbgZEdF
         ZCSQ==
X-Gm-Message-State: AOUpUlEL9rTxcXA8qtzlLr07DPpLlOqVTlcKas10h2nZiWR3Lg/Pu98F
        N6yGLrzzH3IJh/GpIaznS7o=
X-Google-Smtp-Source: AA+uWPyz/Xjbk7CoxmmdO4uZjAY4xoGSWVDsdACOX2wx0NW/FolRL66h04txSCSYMIdgie5yCdob/A==
X-Received: by 2002:adf:c891:: with SMTP id k17-v6mr11968597wrh.6.1534195473705;
        Mon, 13 Aug 2018 14:24:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j8-v6sm12279951wrn.50.2018.08.13.14.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:24:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/24] Kill the_index part3
References: <20180813161441.16824-1-pclouds@gmail.com>
        <20180813172857.GD240194@google.com>
Date:   Mon, 13 Aug 2018 14:24:32 -0700
In-Reply-To: <20180813172857.GD240194@google.com> (Brandon Williams's message
        of "Mon, 13 Aug 2018 10:28:57 -0700")
Message-ID: <xmqqzhxq2c4v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 08/13, Nguyễn Thái Ngọc Duy wrote:
>> This is the third part of killing the_index (at least outside
>> builtin/). Part 1 [1] is dropped. Part 2 is nd/no-extern on 'pu'. This
>> part is built on top of nd/no-extern.
>> 
>> This series would actually break 'pu' because builtin/stash.c uses
>> three functions that are updated here. So we would need something like
>> the following patch to make it build again.
>> 
>> I don't know if that adds too much work on Junio. If it does, I guess
>> I'll hold this off for a while until builtin/stash.c gets merged
>> because reordering these patches, pushing the patches that break
>> stash.c away, really takes a lot of work.
>> 
>> [1] https://public-inbox.org/git/20180616054157.32433-1-pclouds@gmail.com/
>
> I went through and found this to be a pleasant read and hopefully others
> agree with the approach this series took vs what your part 1 did so that
> we can get this change in.

Yeah, I've only finished my first pass (read: I didn't go through
the patches with fine toothed comb, nor thought about interactions
with other topics), but this round was quite a pleasnt read so far.



