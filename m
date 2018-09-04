Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42EC1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeIEC5k (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:57:40 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36976 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeIEC5k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:57:40 -0400
Received: by mail-wm0-f54.google.com with SMTP id n11-v6so5741929wmc.2
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KsdwkExbANLFeGAltgZvQ6Z7hbWHi6EuIgJ0G+1W15Y=;
        b=h3tVbiNmiN6Jz5+Qvb+OQpEGEcFJLvWPFVSOp4uBbQBU0TqwknS+gLTFZ/DbAc706a
         Ky8P6bQZVhYErmhPUVj4d9NnDCLlwl5QAAW8U977jzUbUZtyaKSUB1r2VG7YytvFUDbv
         tporS0T6Mj60tjBr56uf1mRniXKlPSugW6/lyP+Fbq912wZKdFOAQ6+nL/Mt7408CGcT
         HjIt56Qg13EWiO2eh/nfcxeBMimBxb9DJqQPA+xGuZsCxUfklqc805Y++fT3cuDcWQv2
         Y47li2JLGnwbXyG/dXYEU+2ZRIYT8+zTTaeVlvR5xXnQNzDI/iqZQUeBwLcS+px8zNo7
         nxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KsdwkExbANLFeGAltgZvQ6Z7hbWHi6EuIgJ0G+1W15Y=;
        b=fm50yIIsoPPHwJuo9MxRHcAjYN31/rp2R7dlagZXKNkB72uu/al0bcaLJcEXPMmwPd
         zAMrZhRWtzDO90tp7PPt8bGjTFt+RSIOJH8xyTTf1zH3iLPLMY8TEEfAetVit+HXPG8f
         YDC0SPa1Fs6E+FUMh23NklZ1voPEWPnauNmih6pTcDc/Xo9bIuTstYeVye2j1We5T2ZQ
         eebpZDozJbQXWiVInXYfaGbmK8MWkPMja9Fv3Kf1P7r/+CgHc5fo/Kqgki3fcb/a6m5Y
         r9PwtZGW24dhnstnvycZg396MSFlu/sPhoBHVdtXhQDavJkBtOYgDz/ZrCeq6Pfdnqys
         uoig==
X-Gm-Message-State: APzg51BFkgoYbCNuORT5pNmSn0tN2uUzBqL6wCeXIGhwbuRoI2qTmXhe
        nQJqbWX5fa5onZwK0uIdeEw=
X-Google-Smtp-Source: ANB0VdZ2TYk8eZlrc/gZLoU7OhZ8ecJqR8rfSi7FpnfpUqU+Pb4BbnricxVs2AsP9zWzotGygGHBfA==
X-Received: by 2002:a1c:b49:: with SMTP id 70-v6mr9479344wml.149.1536100228797;
        Tue, 04 Sep 2018 15:30:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b124-v6sm368405wmh.17.2018.09.04.15.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 15:30:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/8] trace2: create new combined trace facility
References: <pull.29.git.gitgitgadget@gmail.com>
        <82885700379efe6d6a83629cac4d943b99b393bf.1535734192.git.gitgitgadget@gmail.com>
        <CAGZ79kbUYDAKi-K2uHpkffPjMxGYtH=QUMhvfq4HTc5+a7-eBA@mail.gmail.com>
Date:   Tue, 04 Sep 2018 15:30:27 -0700
In-Reply-To: <CAGZ79kbUYDAKi-K2uHpkffPjMxGYtH=QUMhvfq4HTc5+a7-eBA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 4 Sep 2018 15:12:53 -0700")
Message-ID: <xmqqzhww6gl8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> The API defines both fixed-field and printf-style functions.
>>
>> The trace2 performance tracing includes thread-specific function
>> nesting and timings.
>
> So this only adds the new API, and we need to merge the TRACE
> into the TRACE2 later?

If this is a rhetorical question implying that it would be best if
the existing trace() were rewritten to be built on top of trace2()
while building this series, especially before adding new callsites
that directly use trace2(), I may share that feeling.  I haven't
studied this new round deeply enough to see how realistic it would
be, though.


