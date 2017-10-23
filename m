Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5EB202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 22:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbdJWWhH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 18:37:07 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:51760 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdJWWhG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 18:37:06 -0400
Received: by mail-qt0-f180.google.com with SMTP id h4so28189982qtk.8
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cidr4WWUcI33gEGyCH+FZcYEtgpC9R9BUl0IFd7qLo0=;
        b=NQ5d/NlQBc4gkRl3dkjVSliLDuKMplTYGDq0JVXKFoc6Vcg9kwZ0Lq3yuQUhdKSDjV
         vSjyKVRPPyagC7s4+ZdlubkaFunoSbJMPXoEVAHMX+Mjlju4pUfNiVaobsCshaIuUR/8
         bD9kS1BgN61XKSbpMj30zUpy421wU1R1aSj3k0+SyjoalTmQqSHoT9+oRW8ymGzwdlNp
         +eTPxzEaSh1rrUfbP6AubYa0FPpH7PopVFsw8dRtr8NUTVr5slrTBHnHtm7BXqJsU+uR
         D8RUOqOmfn1fOqM+bwW3CcR/Cu3h+bhni/JUvNVxLp0i+oRMbisHOMhkh6c6cpHWMS+x
         CIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cidr4WWUcI33gEGyCH+FZcYEtgpC9R9BUl0IFd7qLo0=;
        b=MRrXZrxmfWBe0az1D2smYp382e50mWdOptngYCkshFmhD+s8OmY5vlyN8lNrELVBV6
         BUY2AhnivKl80jd7Rhh1bU0hq8piv43yb2qIn+19ZMOBv+CytuRP1xS2TVQgyKXpQu1i
         0mLtXkYAHylRKNIVoxDD7wBqpIvtD/Xk/iKY7Ctvt4S7At9xmbUPBQvvOdfp0JpaGhIG
         0Sf8tD5O3JYDhKRqr27nBpAJF39c57T0a/fwBlt0r2OXqt776e4SC87VqgkZ8wBKNDjV
         Ze6QCLWRFf5biSnwa8diYV4Pjz1q62PGz7rCRmjQSnqkmKuna1a4idas6DsuKt8t32u0
         E90Q==
X-Gm-Message-State: AMCzsaXvS6AdX9/0joFKgqXQ8WR+LDtcOpCvK8kN6KvEzTxwtQ1yZSXI
        6P/1LxpQ8j9NngVVyioWzRWs8qfFhzBggV1bWhiyBw==
X-Google-Smtp-Source: ABhQp+QzPA6XILQ1ZLwbAUSNZkaw9Uz52up0gTjSzfp4L7vC6ahIC0dvzRWDnhQOrgAe+1tKtIK3EDtHPmFyVyRt/sc=
X-Received: by 10.237.53.137 with SMTP id c9mr23707311qte.125.1508798226023;
 Mon, 23 Oct 2017 15:37:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 15:37:05 -0700 (PDT)
In-Reply-To: <20171023213324.v3tm5eiir4gmkqbz@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com> <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com> <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213324.v3tm5eiir4gmkqbz@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 15:37:05 -0700
Message-ID: <CAGZ79kYzaTDaLszx0pGK+dOG3ni7NpeWOf7sbo37X+pE59F41Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] ssh: 'simple' variant does not support --port
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 2:33 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> When trying to connect to an ssh:// URL with port explicitly specified
> and the ssh command configured with GIT_SSH does not support such a
> setting, it is less confusing to error out than to silently suppress
> the port setting and continue.
>
> This requires updating the GIT_SSH setting in t5603-clone-dirname.sh.
> That test is about the directory name produced when cloning various
> URLs.  It uses an ssh wrapper that ignores all its arguments but does
> not declare that it supports a port argument; update it to set
> GIT_SSH_VARIANT=ssh to do so.  (Real-life ssh wrappers that pass a
> port argument to OpenSSH would also support -G and would not require
> such an update.)
>
> Reported-by: William Yan <wyan@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> That's the end of the series.  Thanks for reading.

Patches 4 & 5 look good to me,

Thanks,
Stefan
