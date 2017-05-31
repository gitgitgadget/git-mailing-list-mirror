Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59DA51FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbdEaWJO (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:09:14 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35031 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdEaWJN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:09:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id n23so19027227pfb.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9t/zFhwwY/VtJLzyBadbPb+7CrySA1kVbDYPWkv/EFw=;
        b=XEueylwSU8jF1Jx9/rpwDYzMHP5fc5+zMY8mRSoI9PzCWKWd7fMFQA5BCwnOofirZp
         oy9srMZuDlsGrbG3Sbu//p41VypJPIhvjODPzGYdsfGVH2xen4NF1ysI54usytD2gcmo
         kf6of/GnoRrDq8ptYnmUKDV5iSWcqym+szRwl7aSiVhJlaSaoPL2GaCSX/9eEMIu3tsZ
         tN+EqQNzvEP6yseblTg87zcOk0UowOqzuIvL843gyCGGxbg5p0tGRt+Yz008rygahNwO
         hZvUlFE1w2ZodrgOwZcVln2c15055TLC0ABDooFSMXhyTLqrIc7FWDeoCOgTAUbIrxAk
         mWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9t/zFhwwY/VtJLzyBadbPb+7CrySA1kVbDYPWkv/EFw=;
        b=e2J8Xz2HZfGGWVfzOAdcSyenIqhYvKfJvLkXPPcdZK1Tov+siShErBX5OSNe+/+SQT
         Da50GXUN9ek1CndtwBhR9VxDL81wHbg1pcqgVnKkd0DklZ7GIF6b3sHV46pXiiB2Hyxy
         XLea28x82bD2/qswpnPmK7LaJF9y4qlnIISjtokC59vug/jg9oq9g4vLIEvhHwZMZ5va
         5vKznJ3PAw74gJvsK3sRDEnQmopxscU+GyvyJg3bTE8eyhcTWaU6Ae/aeXSuayN+RTXa
         5GTj+Igk0cyXZkjVQZcNtWHe8+ElgtVRnQBPSEF45xjARKa00d2wfmUp0sXrc2QXd4qt
         dLJg==
X-Gm-Message-State: AODbwcDoCRLIB6coQfltpmCugxomcilL6w+fvIyCGpnel6IYCIzcHzcu
        j3FxhYD0RaIfR5weiWmZRnZc6oPXiEJX
X-Received: by 10.99.188.9 with SMTP id q9mr34870205pge.178.1496268552632;
 Wed, 31 May 2017 15:09:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 15:09:12 -0700 (PDT)
In-Reply-To: <CAGZ79kb52QDUG0RtTXNEEpMJR1CSMYMrRHTRRvGn0-cF=HnzWw@mail.gmail.com>
References: <20170501180058.8063-1-sbeller@google.com> <20170501182405.GG39135@google.com>
 <xmqqbmrcf3cn.fsf@gitster.mtv.corp.google.com> <CAGZ79kb52QDUG0RtTXNEEpMJR1CSMYMrRHTRRvGn0-cF=HnzWw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 15:09:12 -0700
Message-ID: <CAGZ79kYEGQit+7Dqs7ggzRMq9y=pHFhpn-Spk3zVw2ffsc2nXw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Some submodule bugfixes and "reattaching detached HEADs"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 9:04 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>>> I don't know why submodules were originally designed to be in a
>>> detached HEAD state but I much prefer working on branches (as I'm sure
>>> many other developers do) so the prospect of this becoming the norm is
>>> exciting! :D
>>
>
> I'll think about this more.

What the current model is missing is the possibility to have
a symbolic link not just to a ref within a repository, but to the outside
of a repository (such as the superproject in this case).

So we could have a HEAD with a content like:

    "super: <superprojects git dir> [LF <path inside superproject>]"

Then we would use the HEAD to determine if the superproject
would touch a submodule at all. Example workflow:

    git -C <sub> checkout --reattach-to-superproject

    # hack away in the submodule

    # This will make a commit in <sub> and add the
    # resulting object to the index of the superproject
    # because HEAD is tracking the superproject.
    # so in order to have HEAD containing the new
    # commit we have to change the superproject:
    git -C <sub> commit -a -m "message"

    # This has also interesting consequences for
    # submodule related commands:
    git checkout --recurse-submodules <tree-ish>
    # Any submodule whose HEAD is attached to the
    # superproject would be touched, the others would
    # not.

By being directly attached to the superproject, it would be
easy to find all submodules that are changed, via a

    git -C <super> status # no need to recurse, even!




















The whole "checkout --recurse-submodules" series is based on
assumptions of the current mental model of how branches and
detached HEADs work.


A submodule would have a symref
