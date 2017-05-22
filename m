Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3601FF30
	for <e@80x24.org>; Mon, 22 May 2017 00:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756944AbdEVAia (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 20:38:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35751 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755163AbdEVAi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 20:38:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so16080751pfd.2
        for <git@vger.kernel.org>; Sun, 21 May 2017 17:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FyjdexYsOB6hoBt5eagjV+0gjohQTNNnQ1MDVp75SZ4=;
        b=VFgwgWLg6R9QrbkMlZLdSNKx/vEH+UcjWpsnKBv3D8zPvZvzOg19eTATVB9MsXIG8n
         eQwL6VMUfo+HQn2ocInqqrZaiuaRiKbnSOvhKYqVHQ8zt1SpGUHAG+hR+7r2pXIYoacS
         Vjl4TurJs6uN2WDxC71+1cDikE4GD8VvR1EJsu6C9fSSlIqWMM3Db9yJmgr/fadMAJwb
         96DoNeuY1i7i2xlZr7L0Rx1fOMx0CW5c8g09AEMEqaCr3gd/MmSoaa4+nRUMuh74anQO
         TIDTEDHXNCHragdubkPb98IYihTUeEaqG72wKmeIlwqmembNFUITVHUVgAYAwpHKMXV/
         xTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FyjdexYsOB6hoBt5eagjV+0gjohQTNNnQ1MDVp75SZ4=;
        b=KSx9JGUrvybzNYdZdY92Z21M1KkptQJS7s0COgLcIqN4HYUhee7wQiIRPIECXNo+by
         fgxdiWaCrv5338/dXwmehf8pkbi4QCdoee3R1/ULgh56MWDSVgNv5tkNcsiP4/GADUpI
         zz0b/aAHK9m3k5297VtEyvBRG8Wc1Z5wfU9PAF/qnLebhurYdeo6gr3hlHJVuFr60SxA
         TCvGL+uaSJkLsinOhxbW0zirOsWgKvIjWCAqVt50O5siNKAZTBgIdUFXI4WUP1qOqeFT
         A78nzKBPsjEHiIXrIwfrDJG6MJ7zpJvd0YVzcbPQBDwNshZ3zo6Lf1TxvbljQptlc+m6
         frvg==
X-Gm-Message-State: AODbwcC6gz9GxhYaxRHhcCfqxUdtPEgv/PwD2rP7fvjsUVQM+W65YCRv
        xTs40hcEHiKalg==
X-Received: by 10.98.36.198 with SMTP id k67mr23021646pfk.174.1495413508997;
        Sun, 21 May 2017 17:38:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id y78sm27669698pfd.32.2017.05.21.17.38.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 17:38:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 5/6] dir: expose cmp_name() and check_contains()
References: <20170518082154.28643-1-sxlijin@gmail.com>
        <20170516073423.25762-1-sxlijin@gmail.com>
        <20170518082154.28643-6-sxlijin@gmail.com>
Date:   Mon, 22 May 2017 09:38:27 +0900
In-Reply-To: <20170518082154.28643-6-sxlijin@gmail.com> (Samuel Lijin's
        message of "Thu, 18 May 2017 04:21:53 -0400")
Message-ID: <xmqq60gtraik.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> We want to use cmp_name() and check_contains() (which both compare
> `struct dir_entry`s, the former in terms of the sort order, the latter
> in terms of whether one lexically contains another) outside of dir.c,
> so we have to (1) change their linkage and (2) rename them as
> appropriate for the global namespace. The second is achieved by
> renaming cmp_name() to cmp_dir_entry() and check_contains() to
> check_dir_entry_contains().
>
> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
> ---
>  dir.c | 11 ++++++-----
>  dir.h |  3 +++
>  2 files changed, 9 insertions(+), 5 deletions(-)

Up to this point in the series all looked sensible.  I haven't
looked the last one carefully to form an opinion yet.

Thanks.
