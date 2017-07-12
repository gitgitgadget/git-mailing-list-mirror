Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5692620357
	for <e@80x24.org>; Wed, 12 Jul 2017 23:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdGLXCf (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 19:02:35 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34959 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdGLXCe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 19:02:34 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so4614638pgc.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 16:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w6NHB2Rohf8f0+YV5eXRw4BRmxT+7GiOzZY57hTsdVo=;
        b=S0028RfT+1kNH57yhMIQcXw/LR2kwl8BBYnIWePEqVztSmh+f8J9P2miRw4e3+qRuc
         CWpAgsN78NycJjM7iAbV/wDBbCKAFX0Xlo6jN119E9nm1l5cp7DQx7GGxuc9eVbj3yxN
         jI7arK4QGh6VfFDESLUatZEFiXTKf4GYunYTqCcvWmXAz+KZRkZ4BZ9jOXl/zkuyaTL7
         Qpoc83T0aoooQsZDLmhnP73I+jYoN53042BhM8sPbKgLpZCQz908PkJfj4EOtFeUGIIp
         DVB8lP/sdLV+/86XcsCBaC+3LFRtbci49xgTwgmsEeqgBegcJsU1sqMD9a+BSTR71fem
         QwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w6NHB2Rohf8f0+YV5eXRw4BRmxT+7GiOzZY57hTsdVo=;
        b=pR+ENuqi2650uZZ5lI8i7aY+aNYSbYz4djPA3sdRjK4k6YlTg9Z0Oz6dZMggaiMNxT
         /MbDXlfKb0aFIoBMwIW4+ftN3ROaqXoX/uMu46Bf6RpTLzCvNKWS26MTXT/rGu9qVjAl
         zlsSMr7wr0weEmjL7kuqiFFxPSAmPOfPOAg8wwLwFWwuvSmHl01vGtueIoFuCASC1TaI
         Amc/g0cK1mXt1aVcfeRNPJ+bEwBGKDWzslK62Pyxo9MxUBIPPnsAq1njUL6e1bdojdAy
         AaqxyWH4hgl3gtMbvkhM5Ky4LCQ7ZwHz+xm7xu1SC6IVNxhjIw2wgJuHAw482zyt5hsO
         kvYQ==
X-Gm-Message-State: AIVw113YR0A2tOXECZsv6e4Mx9gvaZfQpcLmLHfB8d9WtXMDl++/x8GN
        WM6V/tgEgcF3829/0eY=
X-Received: by 10.99.107.135 with SMTP id g129mr6255142pgc.179.1499900553438;
        Wed, 12 Jul 2017 16:02:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id 133sm6035214pgc.19.2017.07.12.16.02.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 16:02:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/3] interpret-trailers: add --where, --if-exists, --if-missing
References: <20170712222116.7095-1-bonzini@gnu.org>
Date:   Wed, 12 Jul 2017 16:02:29 -0700
In-Reply-To: <20170712222116.7095-1-bonzini@gnu.org> (Paolo Bonzini's message
        of "Thu, 13 Jul 2017 00:21:13 +0200")
Message-ID: <xmqqmv89z2be.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paolo Bonzini <bonzini@gnu.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> These options are useful to experiment with "git interpret-trailers"
> without having to tinker with .gitconfig.  It can also be useful in the
> oddball case where you want a different placement for the trailer.
>
> Compared to "git -c", they are more easily discoverable, and also have
> slightly different behavior because they override all trailer.*
> configuration keys.

I think this is a very good idea (we shouldn't have started the
command only with the configurations; we rather should have done
this first and then added configuration after that).

Looking forward to reviewing them, but I am cutting a maint release
now, so it may have to wait a bit.

Thanks.

>
> Paolo
>
> v1->v2: support --no-* options, minor code fixes
>
> Paolo Bonzini (3):
>   trailers: create struct trailer_opts
>   trailers: export action enums and corresponding lookup functions
>   interpret-trailers: add options for actions
>
>  Documentation/git-interpret-trailers.txt |  16 +++++
>  builtin/interpret-trailers.c             |  44 ++++++++++---
>  t/t7513-interpret-trailers.sh            |  66 ++++++++++++++++++++
>  trailer.c                                | 102 ++++++++++++++++++++-----------
>  trailer.h                                |  35 ++++++++++-
>  5 files changed, 218 insertions(+), 45 deletions(-)
