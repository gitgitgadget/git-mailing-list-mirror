Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802EAC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6168820B1F
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 15:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgCSPZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:25:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34773 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgCSPZq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 11:25:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id 26so822257wmk.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 08:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZWVHFMH6vhNAOd5aH798oO5nhOw8rJgLruet5/vm+E=;
        b=XF58/GpQcPUbFURhqidxFX0rxa/LfHqufaqJA6RnW2ODEywAthb0BUHsYm0xu0xgM8
         oMyVqWZ/69PXmoZEauz+LBf+DN51YYfFOECYOVDxYVphW5aZ5M2e6BjeiSDSm/ASY1ir
         LMGQl33T9QnVxEYjSvGQFWLYwmzVTd19lxUwmLmB2GUgfyeUNpwZIZS7OfMmb0sVFPRG
         0naPBdRdTUI2sVHRnMvt+TRpgM6ykPGsCrot1fOT0K7lKft9vbaECW4OHPfy1x16uO9A
         mjv5473VcqKU/Cdf6ysQzExZUulZ2zH+1BxSgW2Gn1aOUkfndvP8aUpkj624Pbq2iAK7
         68cw==
X-Gm-Message-State: ANhLgQ0go7kV6eFmZq6tff6j5djhX0d+jS/ohOAJ5DO5olLlvb4Z++hg
        BxL7saO4HF/stlsqCoMvIyLz2m6z12JtBh438jaRlQ==
X-Google-Smtp-Source: ADFU+vuMgJIukrdwDm4+RQObg4vrFuEuKHJuJoZ1Sgq0CL4mI3NdCwQMSnGHtjBCLwsSPs3MrpmUq0+MHJTfCEkxbLI=
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr4301021wmc.53.1584631545343;
 Thu, 19 Mar 2020 08:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200314224159.14174-1-me@yadavpratyush.com> <CAPig+cRXD_bjUL6=daEAx7VnAy_nw9bao6rLK9xwTCYJSk48Qw@mail.gmail.com>
 <xmqqwo7k8fnk.fsf@gitster.c.googlers.com> <20200317124902.fitwgrrm6jtv24ec@yadavpratyush.com>
In-Reply-To: <20200317124902.fitwgrrm6jtv24ec@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Mar 2020 11:25:34 -0400
Message-ID: <CAPig+cRQRD1njsGenUWg-73NF6=krPcDUtZsHNf+jT+0j5JJWQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] git-gui: reduce Tcl version requirement from 8.6
 to 8.5
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 8:49 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
> On 16/03/20 08:48AM, Junio C Hamano wrote:
> > I'll pull git-gui updates when Pratyush tells me to, which would
> > happen before the final (scheduled on 22nd).  I'll trust git-gui
> > maintainer's decision to include these changes in it, or to cook
> > longer to wait for the 2.27 cycle. [...]
>
> Honestly, I'd like to cook it a bit longer but the reality is that very
> few people, if any, actually track and test my tree. Most people
> actually discover bugs when the changes hit a new Git release.

Yep, that's the big issue. I track Junio's "next" branch pretty
closely but don't track the git-gui repository at all, so it wasn't
until Junio pulled from you, and after I pulled from Junio, that I
noticed the problem. So, in the longer run, asking Junio to pull more
often -- and earlier -- may be a good way forward.
