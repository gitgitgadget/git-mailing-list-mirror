Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D508A1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 16:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935930AbdCXQgs (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 12:36:48 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33385 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935200AbdCXQgq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 12:36:46 -0400
Received: by mail-pg0-f43.google.com with SMTP id w20so3603958pgc.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l0QLXcoFgsfp3DKnkc4UcuZk04JuI3tXsh4MrV5gSp4=;
        b=poEHyG1nK60jSEtNq+pKeBLagdM57cEsj7wfZ6fjYjEWue794zq6gbAF4o05dTvp8w
         6Dd8as2zmj349QORuUNMiSAo/87xr7Odex9tLb6NwJUc+zQ45QHoxLWj70iuS2NlUxQI
         qgWSw/Negakwl7GOILg/CEEfYxsZeN+cw7h2+U2ycx9GUruF/Di/FE+ssex9KPTGgj/s
         20wN2mwKysiNC3/RtHp6SJ1g3+fxevkCme7A/ntKDmnGEn5Oa56iC9Z/Kt9Urbq5r9CO
         Ylp1RfUUgiqbnpSYMgzYJUpgBM+xU76KnuYG/CkcxtG8BIe8nsCuTdlOXpoL0w+utCsn
         mDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l0QLXcoFgsfp3DKnkc4UcuZk04JuI3tXsh4MrV5gSp4=;
        b=eTUD3OnbcIjkxPJcTq64apE8WjnAYK8oRv4ZDrGM8w5qm/sayUU641jPUhUUNau2/Z
         AwosALNXG4hOtI4sTjcKj/IAi69jVp0//uRWwAcdIMEv48STILz4YeOgkGjgAd3PBUkD
         hkZgaTx55/d/nThhUtgxhQITdR2u/z5sk+EZwbAX3Ci3rM/XJbnimL+HQuf4vTtVePc5
         AvPAGZEGrS3pJ/5+/NRtfnKIkzNyeHLn98jOt4/z15c/y5NBZ3BkLGIO2g6/yGMA6vn/
         eU3EWpcJ+ktzpf8KAWw1J0rtfXsIIoFKVfjxkaPOpAckeL/KdqZCG6HmC61N3pVyzExh
         Heqg==
X-Gm-Message-State: AFeK/H1/EYw3/xFXhlRfMoqAoT24O5hN2GtiU/l+2Sl3rTpXnaCsJ4E+Tei8PpJki+BNpQoTcg6SbNQQQ/EZniFy
X-Received: by 10.98.97.7 with SMTP id v7mr2912845pfb.161.1490373405399; Fri,
 24 Mar 2017 09:36:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Fri, 24 Mar 2017 09:36:44 -0700 (PDT)
In-Reply-To: <5f29c3d9-0de5-385e-fda1-fb4380c7bc17@jeffhostetler.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
 <xmqqh92jev8d.fsf@gitster.mtv.corp.google.com> <5f29c3d9-0de5-385e-fda1-fb4380c7bc17@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Mar 2017 09:36:44 -0700
Message-ID: <CAGZ79kZU2Gzq7Qv7+UJSeu9gMai6A3vZB+cg8Lcu-7FUZ1-w1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] thread lazy_init_name_hash
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 5:39 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> WRT the assert() in name-hash.c, Stefan suggested converting it
> to an if-!-die form in an earlier message in this thread.  I'm OK
> with that or with removing the assert completely.

I think removing them completely sounds even better.

Thanks,
Stefan
