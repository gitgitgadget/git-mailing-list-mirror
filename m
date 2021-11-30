Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5BC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 23:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbhK3Xzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 18:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhK3Xzp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 18:55:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA19C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:52:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x15so93602460edv.1
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 15:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xfqr2XYNDAqDHQYRnSecjxuvw+HReHhknA8xa5dg/I=;
        b=nBYrYKBFk6RA0LfUEE2GXcqthMyQ04OgM9UpgIuK7Ltf2xC3ogGRET+csYDHsVLtDp
         gRZ+kUEjfQ6PjyHVMZ2Gaft3n1BQAbvhoCBep3SBDmrXZLccSoqct4tcsui67zndxlsS
         4jWx6LHBTwI/w0L4IANCaXyzjgnfHYm6pP2hTTGgSJjVeXMAWZRkaa3FYQ3YI12DXUCc
         mlKwRye2zFdxYf4SH4PdvTk62lXKilufy3AmVowqYv8sQ+7HTf3Jfn4546ldaPmmJSqA
         x0Prxd6RVFBYLAkDQGzTTdlhlUXmuy3nf7eymfvE0ybveXbsq+gtoCHHpPosJP+Ndscl
         3V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xfqr2XYNDAqDHQYRnSecjxuvw+HReHhknA8xa5dg/I=;
        b=jCDYoTypQMedIHfPw4TlL8ot77JMQYCsqROdwT5c5ebvdDsldS5Zi/DzKQAQ8OvInP
         Hj+/bd2jksZxfboh1j4Zhne4/k8LAHlE7AHfSkymyD1Gx0wdynA5MqyEI776ogQzxdoK
         Rd2F/8tpQoCjl7Z1jFJudRv7VVSMTeDNXwflXuwDRjNtE17teAmWzVX8qPSAwRpFdmCZ
         M1eRW8U/AxnL06/amRZ6vNgnxlt8P0eSXwLfBIYEH30FmQgUr59u4mg3Fnd/OF+Y8GhG
         nxzcNyFf/zqrfQ+pSHBghtY+hYhknwB2nm9Ve3kZdpSl/90rlVHhmS0aV29J6rvWaCzN
         EMCQ==
X-Gm-Message-State: AOAM53116bSOMekiQlZgdF6dyKEeFK7WY2lCtmsAumY0+niGSbNPN90a
        xTgy33IvLwNP5h1y+Mp1bYPZHLBa/8ouoDjVurl2rsJK
X-Google-Smtp-Source: ABdhPJwJdgKELdVllHSWq043lAvdTZ7p5ojsTShmkVWui7jYxei+HTJwfDP8gFgGZHAQTsBFSY1wBE3k1+SBrXWfyuE=
X-Received: by 2002:a05:6402:291:: with SMTP id l17mr3297323edv.242.1638316344273;
 Tue, 30 Nov 2021 15:52:24 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzgpm2xrd.fsf@gitster.g>
In-Reply-To: <xmqqzgpm2xrd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Nov 2021 15:52:13 -0800
Message-ID: <CABPp-BERnA+tyP0RTQ-iXcm5wwO5GbjasP3O-MjqSHGauyibFQ@mail.gmail.com>
Subject: en/zdiff3 (was: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 6:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/zdiff3 (2021-09-20) 2 commits
>  - update documentation for new zdiff3 conflictStyle
>  - xdiff: implement a zealous diff3, or "zdiff3"
>
>  "Zealous diff3" style of merge conflict presentation has been added.
>
>  What's the status of this thing?

I resubmitted it before you added this question, and have pointed out
the resubmission in response to the past "What's cooking" emails, but
perhaps it'll be easier for me to just resubmit with no changes.  I'll
do that.
