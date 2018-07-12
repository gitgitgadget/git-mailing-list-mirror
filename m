Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9EC1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 21:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbeGLVWa (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 17:22:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35919 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732341AbeGLVWa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 17:22:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so23060932wro.3
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vknpAefg1omgHLmg6SCEqgzMnVPxmhZq/MuQYYn6xEM=;
        b=nFThCeUOlEIM2Wv9iVMh1yVx1x5/scktwK68d4YUczweiK+pp9vNWF8CFJTXWlrQcM
         peIhjGKRhNwOFNmtxsCw6lfpPY4z3Og6pauKaYGUQNrvGeA9B3AIzJjGLbNhGz806rcj
         MNSlLdiIQP8liumB7C+lTGEZEF4UYOaPdh+ID00a+0Vx6InM0aFTl49yDcdYlsgEqWRS
         1N0Ng+x4UKiWRzMC2YgPmNQHmWm57jL9bmZFIuHwx+nBq+P96REh2446oIpVaIql9AFK
         zNhhmj1FEptD9+xV4UaUQEnHdt9MGsNSZ4muCNtzU06rTI0dY8Nab7/EhNQtVgwyu9Eu
         9tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vknpAefg1omgHLmg6SCEqgzMnVPxmhZq/MuQYYn6xEM=;
        b=IxO1wZaEMzMjHzaZtwTuFq9nTgzcDOlGivHJHDPMGaSinnT8wGsJwJJaNGJY8p6Qx0
         QeKTjOyUWz86yV+JsVAUg+3mp6ETF5pldWftiWN50psJmntqOyxEuKCTmCCCRikFcA7b
         jJo/p9f95fi5IN67MRqQk8NxL/Jc6Gx7/tlxcL6lszBftbl7FVtO0K/0ScbgtXhCdW5F
         78eFUR42UY5YhmbI9Es93RmWyMlO0Fn5LAWfmOJX5YfVHAKkqNKXYHyrqPT2eR9JQ+n4
         BStRKaWfL+G4KMpVsY25m6VaTI/nloQnwrwaMSKVd5Bh7tMs37YyP0ov1KrOPLQOzMT8
         k7pA==
X-Gm-Message-State: AOUpUlEHnTIaqKNvmH05JTZfjM1jRtBo9szOny9+t8WeYZgpKdhOfttz
        8dxshhiitLWYTq5agO1ggQg=
X-Google-Smtp-Source: AAOMgpd/guUWmI4SyyFPA5jvsaxkxjru9O2I0Hmlagb1HobceI/kwTlfiPgDbdsVl+wjZqVxrWeVsg==
X-Received: by 2002:a5d:45c1:: with SMTP id b1-v6mr2893832wrs.106.1531429868398;
        Thu, 12 Jul 2018 14:11:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q1-v6sm8191870wrw.42.2018.07.12.14.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 14:11:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, sbeller@google.com,
        pclouds@gmail.com, avarab@gmail.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 00/23] Multi-pack-index (MIDX)
References: <20180706005321.124643-1-dstolee@microsoft.com>
        <20180712193940.21065-1-dstolee@microsoft.com>
Date:   Thu, 12 Jul 2018 14:11:07 -0700
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 12 Jul 2018 15:39:17 -0400")
Message-ID: <xmqqefg8uplg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> * The global 'core_multi_pack_index' is replaced with a one-time call to
>   git_config_bool() per repository that loads a multi-pack-index.

OK.  I guess that is more consistent, as the configuration would be
per-repo and multi-pack-index is per object-store.

After a quick look at the diff between the application of these
patches and what has been queued in 'pu', I found most (perhaps all)
of the changes are strict improvements.  I may have more comments
later after reading the patches in full.

Thanks.
