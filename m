Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2B720954
	for <e@80x24.org>; Mon,  4 Dec 2017 19:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbdLDTZA (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 14:25:00 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:45041 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdLDTY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 14:24:59 -0500
Received: by mail-qt0-f174.google.com with SMTP id m59so6374924qte.11
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 11:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s49cN7Vz7NbgRhGL9wj7SsFzshHXWz7BaUT190vDoUM=;
        b=hIrj0lD39q46EkkNnuATRbr+661tDiSTcfQcl/nePeEDZ3Rg/ZseD3XoGx+15eoh8P
         oz887FAAcpDVyGklWC/WALCTie0UxwED9NWDpgLfmglXNkLBq9GnIn5h1zHHZOnP0KEI
         vn9ePzPVg/5DRd0uVveoLiuixJ5iSCU1sE1S7d5jbAavdpONrd4I/w2XeQulPqn0SX4l
         yu80jSarjvKB4Abvq99l0e8HeqLGbu986mXkZQ2WaV8tGENSnypEy1clirbN44CcsKXW
         3XS4jFVesYWJZmi64bV1L4knLIFfdT1NhAZBEMGhojOIvYlS5q1jeFqV7tJbo+v012yB
         +KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s49cN7Vz7NbgRhGL9wj7SsFzshHXWz7BaUT190vDoUM=;
        b=oN9mxVc30nm6BcopBWbcqt5ceS0oVKBLrMMvXlDuTdYcuCGRRi+jzdORxn4ESE97EY
         XFVc1IzN8ht2XTWN2gJZwXnaxuKZD1pKMu3U9lVaUCG2IxJe6ecH+Ce9NcVqnJZvcvBv
         NBY/adsR087TbtCQJ0RKhBRPvUdiLvqrgH7fryr694pFf3tJs3cqvIY6Kc3fTdszlwJc
         jydnnhSNNdIk+NpiD/B8FNNPcmNgm4BZz4E1fr8AMbz82wUgrIG42C9fxIw+msUH8YdO
         oVwBiwnU+pJNgDTWqSf3cMauSFQLIrikPW4UbxPyPDgZxdlGHJIFDI/ZPT50HNH2CiIF
         pnPQ==
X-Gm-Message-State: AKGB3mKuJWRoqrlwuz7bNIDhsi3u9QGXvsosQPv+yQphbygrL0r3YuMj
        lua95iU0HnqufWBEORxiRynB1CnXZqXfAfqmjDSw8k8wk0g=
X-Google-Smtp-Source: AGs4zMbtCi24Q5hty1L8oYRIOnDI3JduTsDGYYMeudd2V4avCc63ayK4A9oDR5Q/qU6u7ww3CGET9KSi5rtulv6+pVQ=
X-Received: by 10.200.6.130 with SMTP id f2mr53850qth.140.1512415498348; Mon,
 04 Dec 2017 11:24:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 4 Dec 2017 11:24:57 -0800 (PST)
In-Reply-To: <20171124110758.9406-10-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171124110758.9406-1-phillip.wood@talktalk.net> <20171124110758.9406-10-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 4 Dec 2017 11:24:57 -0800
Message-ID: <CAGZ79kY0YC+3kpYWDFi=bW0m-KFUpqexc3gxe-a5gS3YTn89bg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 3:07 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Now that the sequencer creates commits without forking 'git commit' it
> does not see an empty commit in these tests which fixes the known
> breakage. Note that logic for handling
> KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1 is not removed from
> lib-submodule-update.sh as it is still used by other tests.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Notes:
>     The output of the tests with after the previous patch looks like the
>     output of the merge tests (see below), so I'm hopeful that this is a
>     genuine fix, but someone who knows about submodules should check that
>     things are in fact working properly now.

Looking at the patch only (in combination with the history of the
submodule tests,
283f56a40b (cherry-pick: add t3512 for submodule updates, 2014-06-15))
this patch
looks good to me. I wonder though if this needs to be squashed in another commit
to keep the test suite working for each patch and have no intermittent
failure in the
series.

Thanks,
Stefan
