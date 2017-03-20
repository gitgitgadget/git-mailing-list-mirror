Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D11C2090A
	for <e@80x24.org>; Mon, 20 Mar 2017 20:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbdCTUpf (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 16:45:35 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:32985 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbdCTUpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 16:45:32 -0400
Received: by mail-pg0-f52.google.com with SMTP id n190so82961518pga.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1HAy0XKTm0vGQ2AwrRL3NQlUbedasWumtanNjfa/D88=;
        b=ZvoFP+dUEaVzJ3d7dcxQEwXjuRDhy7aAIFtmvXX3JD1DChSGEBu46qcDJuvt9tR9dB
         b3KQ4bS7mW7XM2r35uRklkj1WTctPH6n6Dtl+uX9dTFo8UKXtRxsOS1BK6MYnaH1bcHO
         wCRSCjgWl373vhskbAIOOmndAQbW/5HJkUSVPo1Ics+gUw1gOSzixzjqYDVgmGXCA8N8
         iPMRjvM/yKsLDdHhSyfaSL/cXCxmcxCuVyYoT2v+tfUriO4x3F7rLcFn54PoNc4DLJhS
         ajJNsHstka5xO9uBc3vbiLvO68hl4ClCxdJSv59GSYwme99mHXj4ctkMCySJVvB3psQ7
         EjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1HAy0XKTm0vGQ2AwrRL3NQlUbedasWumtanNjfa/D88=;
        b=hgw4zEK+kaAzGbx/egSqQ/FF9Kplv5ONp741J7kPjzpr8/7u5hQrKNOAs/lyHuEz43
         SJG1QVGlnId9wd571b8nWlZ9lFY2wVFVbgKkEcmHHA9sjpehWIjjJ4uDHWzP5voHQLJQ
         oG76P0ds1rDen5PmcTIviTBSIRPy3C+b5/HkFd9Oll9djoDHYiJO94nwCRhl8Ghyt4hl
         9dRKrSZSR6/lFGQCUstgfxaQpLJtiBXbzMT/zJo/yKMF/lmY5mG4bb+v3iQwbq0M93zl
         e/stUqLbXXCHZRgv1KXzHUtQw3FKSk6tm5ugOndLaPQk5tgxTwzrp/Fh+qbzSVtJx7rK
         B6ww==
X-Gm-Message-State: AFeK/H0+84A11aS+377bAZJRL73ggAQtVCZOaiBhLZs514wvxtGo3PxwEVVm387jDuNYVE4mI4XtaJ4k87Tdu1qr
X-Received: by 10.99.247.83 with SMTP id f19mr24159pgk.158.1490042120856; Mon,
 20 Mar 2017 13:35:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Mon, 20 Mar 2017 13:35:20 -0700 (PDT)
In-Reply-To: <xmqqpohbvih5.fsf@gitster.mtv.corp.google.com>
References: <cover.1490026594.git.mhagger@alum.mit.edu> <f16c123354404088f9ffef0b0e31d4a9817cb804.1490026594.git.mhagger@alum.mit.edu>
 <20170320174937.xkozsdruyrj44qg2@sigill.intra.peff.net> <xmqqpohbvih5.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Mar 2017 13:35:20 -0700
Message-ID: <CAGZ79kZL3MgVVErox-YoksZuoMY1mmV_D7Bq0d-h_mp9w6kg_A@mail.gmail.com>
Subject: Re: [PATCH 09/20] refs: split `ref_cache` code into separate files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> It might have been a bit easier to review as separate steps for that
>> reason, but I doubt it's worth going back and re-doing. I'll take your
>> word that nothing substantive changed.
>
> In such a case when I do not want to "take your word", I often do
> "blame -C" on the result, setting the bottom of the range close-by.
> I should mostly see the ^bottom lines (or with "blame -b", lines
> intended with blanks without any commit object name).

FYI:
I still want to revive the series that colors moved text differently.
