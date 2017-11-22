Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3E02036D
	for <e@80x24.org>; Wed, 22 Nov 2017 00:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdKVAAm (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 19:00:42 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33652 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdKVAAl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 19:00:41 -0500
Received: by mail-qt0-f176.google.com with SMTP id r58so21649143qtc.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 16:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VTFwA9FD4Jk4YK3YIF1R75m3ALi11JdbKcSN/sQFdaY=;
        b=VLFHn5p3Ezp8AqORh5xQCBrWExoLb+uR/MWzLFG8xrmZkSpxthb7AEH4Oo/OKzvx1H
         9+MHLALxBo+bwJc/QVcpdN5aL1ILNK1WVdcVPLR6bBTlzRt499TNQmYCLOS8iVquHmHy
         vuQISbbKspdI7Jf7J5k2ReZoQTkrFgJeNPouGi8SivLEaCAG1k+Gv7JxfQ1azqYTCAY3
         GdA5Q/F2OaUxuxXIAye07Pz7+aD40ZKMxDUEYuXcktoINQ3w4I6UM714cvQbAcOTPPYn
         xSgT0nbagH0UUKm3OPaEvhh41OcHVmyfjMWGrpBMdaEp2fglnfWENpCesuTPDoN8Bb7h
         dK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VTFwA9FD4Jk4YK3YIF1R75m3ALi11JdbKcSN/sQFdaY=;
        b=tPkkh4GwzewUJy4+Kzer60sKL/GQCVJ70kECMpgeoYitCpm913YL5LQU7EnWJA/3gT
         e8qMB/tOlNtCWhbgrm5AnpwY+wZ5Um31mTo/Ur0z4XRSmBLuxLO/o+Q54LKw1AlMxJl1
         KHo5ROosBudq1BxEk8iqXH4SigBotZaNUpRYPGlbQ46+T5Uy5/tsemdy9eih2a/79fd3
         awMMYLDHnw5DXCxZn2ZgpRZdU7ppGYuggzrY4OFLyJ9zafzKxcFGThUbqQ149vWGgHvW
         OIwuGaFdB5Ev9CvwXf1n2GEoon5vmH5lYhHMkvkY0qRhhPW6iok1B/jqAKlXdBonbuLT
         Yfng==
X-Gm-Message-State: AJaThX47RMnzGe3S+oXpkBOc+fckwYZtr702lyY0rGR7WaFh3IfqaUPN
        ObMXycoPCM/iyiGRYG1JniaFJApnYzfxX1w+DOdyrA==
X-Google-Smtp-Source: AGs4zMZ8V6CHVcLM9VfM6iKnwFfnyqekaJ/ZZ72O8VZxItzM/LcgV1QXkSVZgn5MkHh3oPuzQvxV+oiFXlu5a7ofj3k=
X-Received: by 10.200.44.251 with SMTP id 56mr29900968qtx.87.1511308841081;
 Tue, 21 Nov 2017 16:00:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 21 Nov 2017 16:00:40 -0800 (PST)
In-Reply-To: <20171120223232.GG92506@google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com> <20171120223232.GG92506@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Nov 2017 16:00:40 -0800
Message-ID: <CAGZ79kaR3Jk++mQKhJVk9dK8_usLGWTAgEdkF1K061TKwiFv5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Coping with unrecognized ssh wrapper scripts in GIT_SSH
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 2:32 PM, Brandon Williams <bmwill@google.com> wrote:
> On 11/20, Jonathan Nieder wrote:
>> Previously: [1].
>>
>> This version should be essentially identical to v2.  Changes:
>> - patch 1 is new and should fix the test failure on Windows
>> - patch 2 is new, discussed at [2]
>> - patch 5 split off from patch 6 as suggested at [3]
>> - patch 6 commit message got two new notes to address the worries
>>   from [3]
>>
>> Thanks for the helpful reviews, and sorry to take so long to get this
>> out.  Thoughts of all kinds welcome, as always.
>
> Just finished looking through the series.  Looks good overall!
>
> Thanks again for getting this out!

Same here,

Thanks,
Stefan
