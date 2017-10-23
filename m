Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC883202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 19:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbdJWToD (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 15:44:03 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:48410 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdJWToD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 15:44:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id f8so27674775qta.5
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KbbWSTJ9NV1JkeEDPOJXfdyYkMdIea51CJvA7cMYA4Q=;
        b=qfqc+927OgV4wv0Ts+uzwV1/4kC7Mie+9LXAF9XxGZc40821mAsiC0ZUUehcHmf89K
         /e3sAY17riQyr69yFRAjPygz5O4euUeuEfbcbOZ5W1ceUwuCU156j+blWPDhj6/qMCCf
         92gVhoTeTW4SkYKauFOilQYljWJBVZo680b1rocwuxiPhGW6V42eDswDMn4YA8j/Rjpf
         4W4b6cmBPmsLSpCu81gMpPtriD9U9pHSVT9xtHFUnCyZtcfgtml0niJDdWGFR8u21EwT
         m6wSOU1bharRwACqEXFwMTrUiAEE7cFZ0Kzl9yIUwCpi9ZBJdxsIb6Jz8XaTOlnI+73F
         mXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KbbWSTJ9NV1JkeEDPOJXfdyYkMdIea51CJvA7cMYA4Q=;
        b=nMTeeVERSNawJPFBDSrJR1WG1Cp1HpgjJRoe7eO5hh1ZjArrOyJrbqMeNsak6Ac0QO
         HL4EM5lJ9vJ4cfcSt7zbw9upo/EVBAddxe77j1ZsGV+c17xzh8Ix+OIKjNPkzDcZB1xs
         STe2PsgJBWvhhJWQ4Ds0ENmOduOrH0HtVnSJPp9XJ85t38evao43BLoThQOni4UzY5mr
         abqLnINn9JJUQOk1fi6Bzxj7Ln5/h2p9SFpJcG3Rrz1GqESt3OxpKjbnDxcbIeEbjDYQ
         KkCfIXcLOu8qZLPFVoPpf18g9EMwJJyBUubVtjk+0h3LSEf7smB+rGuyC/km4xYy093W
         HdBA==
X-Gm-Message-State: AMCzsaVyvXvigeQEjf+2xp3202mClzHlhgitZAjce8PRiMllcZeh7/xh
        RVkpSjaTi4eq3Ywhzz6qCCq6cRoKKnxOpmK90KYUMA==
X-Google-Smtp-Source: ABhQp+QMe0Pnn7P4UrXbT1oEPycqXYcwIlIl+6fbqJrCYePPFA9X5aeSdtoqlErhJUrCnPmQi1pALzHdA9YyLD+NcxU=
X-Received: by 10.200.8.53 with SMTP id u50mr22546645qth.260.1508787842317;
 Mon, 23 Oct 2017 12:44:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 12:44:01 -0700 (PDT)
In-Reply-To: <20170925082024.2691-6-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com> <20170925082024.2691-6-kaarticsivaraam91196@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 12:44:01 -0700
Message-ID: <CAGZ79kZJAYabHArHkPPyqUy7LKQXyk7kqqmrqRcirGXZ4FYHJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] builtin/branch: give more useful error
 messages when renaming
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 1:20 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>  builtin/branch.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)

The code of 4 and 5 looks good to me, though a small nit below.

Thanks,
Stefan


> +static void get_error_msg(struct strbuf* error_msg, const char* oldname, unsigned old_branch_exists,
> +                         const char* newname, int new_branch_validation_result)

nit here and in the return of validate_branch_creation:
It would be clearer if this is not just 'int', but actually spelling
out that it is the enum.
