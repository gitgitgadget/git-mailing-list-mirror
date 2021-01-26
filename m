Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8839CC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F5222228
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbhAZFEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:04:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58707 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732067AbhAZCDg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 21:03:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D95FA4EAA;
        Mon, 25 Jan 2021 20:58:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ZHLqIhjQ8fyIJKS/WsIyh6+xPzw=; b=Xrq5lr1322xe3EGN0s7H
        hMwwd2qNNFaeq7u981QZ+t1D1q7oLIiFcZOjBCG3Nq5yKoValmZEkhAHq1jKS/rm
        QH2UhFjvqZ3LQ8pfqFeDigOQSfn3yrQpKuOSnxTahm499o1F2TVr696uZXGLbDQN
        n/eokCsSBWfoVMJCktalbdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=PAB/TH3uY+zEaNJcHNyoaGDypVKKU1J2t41Hq3dIYVoTMV
        ooqL72g1btmUVSB4bZab4DHjm7U+b7FU54ZNtcSgM9kPbq+JLMDO1eik8+FPAQHB
        z7KoTup9gtbI61+89sXnSGAAy14HFhUqDutZQIWRr996BVO5eHOk9vJsbF7m0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03821A4EA9;
        Mon, 25 Jan 2021 20:58:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E0BDA4EA8;
        Mon, 25 Jan 2021 20:58:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Patricia B. C." <pati.camsky@gmail.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: RES: Can git change?
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
        <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com>
        <xmqqpn1w95dj.fsf@gitster.c.googlers.com>
        <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
        <xmqqh7n85qwd.fsf@gitster.c.googlers.com>
        <CAK8LAYUsebOau+XJ66fEesLm4MfMuxJjse0YL408-2jih1d1eg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2101251650150.57@tvgsbejvaqbjf.bet>
Date:   Mon, 25 Jan 2021 17:58:18 -0800
Message-ID: <xmqqft2owjb9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F669611E-5F79-11EB-939E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And I have to admit that I am somewhat concerned about your students if
> one of their instructors thinks that their education shouldn't prepare
> them for more than working locally on their computers. Aren't they at all
> interested in preparing the students for life after university? If so,
> they will most certainly be affected by GitHub's decision.

GitHub's decision will most affect projects that haven't started
yet, simply because they won't have to incur any "transition" cost
the existing projects may have to consider.  And given enough time,
old projects die out and there will be more new projects than the
projects we currently have, hopefully.

Until that happens, they would be affected more by decision by the
projects they interact with, as it is most convenient if your local
name matches the name the upstream uses.  And the versions of Git
way before people started talking about 'master' and 'main' have
long been prepared for that, and we've been closing possible gaps in
the recent versions.  "git clone" would notice what name the upstream
uses and uses the same name locally.

Even when they work locally, they'll start getting 'main' from their
Git soon, and that would become consistent with the name that their
"upstream" projects are likely to choose due to this "industry wide"
push.


> Any repository created on GitHub will have that branch name by default.
> Likewise on Azure DevOps. I fully expect the other hosters to follow at
> some stage, and also for `git init` to change the default in a future
> version (I am working toward that goal).
> ...
> Maybe Git itself is not a good example for that. Bigger projects face
> dramatically bigger challenges replacing the default branch name because
> of the short term disruption caused by it. Nevertheless, a growing number
> of projects have already renamed their default branch, such as Snowpack
> (https://github.com/snowpackjs/snowpack) and the react-refresh webpack
> plugin (https://github.com/pmmmwh/react-refresh-webpack-plugin) but also
> bigger ones such as LLVM (https://github.com/llvm/llvm-project).

Yes, thanks for giving Patricia and likeminded souls more usable
ammunition than just us ;-)
