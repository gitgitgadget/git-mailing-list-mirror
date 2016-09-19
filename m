Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B242070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbcISSaG (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:30:06 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36967 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbcISSaF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:30:05 -0400
Received: by mail-wm0-f54.google.com with SMTP id b130so77361258wmc.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uSfZDC8k05uL9BX8INRi/cvsT9NJJ6aE7+A9+kdotGE=;
        b=FTcKzkoniLGablzYv1ufs7qogBwsXs2VVLk6/4x2wkTsXZUNKIpmLuMCOGvdIXimqE
         O8qgydEDDtCEwMg85YG/S2OQyErORdszLHSf7L+lBJUnQ/9ymqxaclYWgy/J/FxjLkW3
         Z9tgSGwwZ4xX93WBzMobEIMNsj/uEtIpIxgwc94R6a5CMuYRtacSf0c4TjGVi/WeYQ0g
         HSU89IuY1NKzO+Ea3a8A4NMtV5vBqgsGfnCDNgy9K2YqzswmI6Glurn9Tuwu0z4GgREh
         Aw0ChoPPHVfROC0N6kfBx+BmkaZNLSZ4vPXdkaY1QK4+DW1w1GhkeVwyWkCl/kxJHWU6
         VKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uSfZDC8k05uL9BX8INRi/cvsT9NJJ6aE7+A9+kdotGE=;
        b=P8C4j14SHafZ6OpWqby+WW6rXoT7HwZcIqyP0QRcD/0SKobz7dcsjClBelMywBjxiF
         SYbrrg2lHarSYjw+Y8pDeUN/wyihuFdAQ7G5zcXhoHgBLZkWizEShW8MCJGLa1k5yQd9
         gEycNuaeBOh1TnZonQQlWmtzR4fIT6nZlWBFIIpyZbRoZQdPHceqfTqKtjLtR8dloR/p
         64pGnVB1mmhruM6q7U+Oy2h7cQhHlrNh46mS+I1QpOllTirH+JWofgh8PHVauyRtS2au
         QJ50vrdVUF+ZNbe3phbCbgm6txQ90F2iVTWG3Kv6k20jAqwj/nlSBhCOg4POu5egTanO
         Zh/Q==
X-Gm-Message-State: AE9vXwMpLBtbJpKJaA9yUdDdvY3tbZWWyz75VIIhGFq66G77kJhapZ0kWfo++0SSnhoNf5l5xFWCijhqPNu70nYo
X-Received: by 10.28.183.135 with SMTP id h129mr10020578wmf.2.1474309804074;
 Mon, 19 Sep 2016 11:30:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Mon, 19 Sep 2016 11:30:03 -0700 (PDT)
In-Reply-To: <xmqqshsveomv.fsf@gitster.mtv.corp.google.com>
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
 <1474073981-96620-1-git-send-email-bmwill@google.com> <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
 <CAKoko1r6cfv-2HVCJPgGbXyCVe-wdUBS+2nXtaTHO3jshVg8MA@mail.gmail.com>
 <xmqqvaxrg6zt.fsf@gitster.mtv.corp.google.com> <CAKoko1r_WATxJzxQrQW2VBkhuKquv=yQv6sB_eCMgH6qavS__Q@mail.gmail.com>
 <xmqq1t0fg417.fsf@gitster.mtv.corp.google.com> <CAKoko1oSvBF3=-hvSGVMQYpZkUvnwAEYg=U-g8927F6dt4Q8mA@mail.gmail.com>
 <xmqqshsveomv.fsf@gitster.mtv.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Mon, 19 Sep 2016 11:30:03 -0700
Message-ID: <CAKoko1rULusRdcw7_u0QRfn590uTAZyOTk4JS6b8oopaSDLNDQ@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

side question if the answer is short:  Any reason as to why all of the
pathspec matching code lives inside of dir.c and not pathspec.c?

On Mon, Sep 19, 2016 at 11:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> Yes in that case it wouldn't have passed ps_strncmp()...but we should have never
>> made it there in the first place due to a piece of logic in match_pathspec_item:
>
> Ah, OK.
>
> Thanks for clarifying.
