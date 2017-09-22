Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC95202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbdIVUJf (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:09:35 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:48940 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbdIVUJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:09:33 -0400
Received: by mail-qk0-f178.google.com with SMTP id a128so2110330qkc.5
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b5HZaMBh6SPpOQI9C4IJZk78oSJ8Okkv84dRTmG+wyw=;
        b=B24ZWdM+fbs0KLKLsNcFK8+0GvVOslAFXU3CNexYadEWnsD2qC7EY/xWLHhKq3ZnbB
         b5meC9dPHqmSFXW5t1Nb+Phj3IEfRm4Y3tCWTruaLqGK/RKjakkwLOelQ3rKSI0vAB16
         c/3YqjEbt/z5BdiutV+zpQL+bV9hrWlAHPWbsNQDeS2nh7Y2g395H+7YXZw6qxJJ8oDi
         2FUqfQqvcO+WR9mei+JkqQB1eqpwOIWicZInVm2LTD6MgZF3D7xdgCwHmQGM6CGCmGcI
         VfbN5wuXuslzpVYGEG+YG9QPYD9Q0Pf3eN6Pqn833x1CquOCRVl3jlGMJGTTvSx3NMc4
         fiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b5HZaMBh6SPpOQI9C4IJZk78oSJ8Okkv84dRTmG+wyw=;
        b=Q65oN6/tZrmLnUU0iamFHdrOXkowELUT581Qhn8SAjaarYKQWha2TKBm3Tr9QVDUvM
         vsPG2uQNIflGzilxA0oskMfIk6yQmFBwqvmacUJddSOyF68SBccrU2it99A5dmzVUsHo
         xfO+BSWzT9pAQpZZBslrcqO/q+gDB5CoTpIe+NO+nCNS/y8sib+00odfwHJlhM7L/WZk
         UwvBjJkUuJMHJBmSclzG/9ONtargl+iM/zEQ24A+Wx9xiNl2lYvzjwKm2Op+0JFwvTI8
         AEmJ/8mXRHj0LMVg2VLCR45KtO4TtY0I+mvk9S2GUdntxIdn04WL8LBo6NQGToAdyGRh
         qo3A==
X-Gm-Message-State: AHPjjUiWA4quXyVx8DwQcNEUIqjWV3GrUyR4Um9r53WiL1999WV5bksF
        YiBFzyMI6M8t6ZwNxIyy2twHQLltko9ipY2MHVYNxGGEyZo=
X-Google-Smtp-Source: AOwi7QBPXPOffCEv6vdw9Ws0Xk7zJWdlXBAx2IFfV2DcBeyVx3Uj6uuhGHkIrircYeqNNcW1Ew7vS0zqMC/qkQpIpfw=
X-Received: by 10.233.223.132 with SMTP id t126mr464561qkf.332.1506110972585;
 Fri, 22 Sep 2017 13:09:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Fri, 22 Sep 2017 13:09:32 -0700 (PDT)
In-Reply-To: <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org> <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 22 Sep 2017 13:09:32 -0700
Message-ID: <CAGZ79kaUTdFi5LkgR6zKeb+CH8vpfPQRZf6bFqRfYY-YXy_TNA@mail.gmail.com>
Subject: Re: [PATCH] git: add --no-optional-locks option
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 9:25 PM, Jeff King <peff@peff.net> wrote:

>
> But imagine that "git status" learns to recurse into submodules and run
> "git status" inside them. Surely we would want the submodule repos to
> also avoid taking any unnecessary locks?

You can teach Git to recurse into submodules already at home,
just 'git config status.submoduleSummary none'. ;)

It occurs to me that the config name is badly choosen, as it stores
an argument for git status --ignore-submodules[=mode]
