Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618DFC432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3208660FE6
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 18:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhHKSIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:08:12 -0400
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:54905 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhHKSIL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Aug 2021 14:08:11 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9DDA9702247;
        Wed, 11 Aug 2021 17:49:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (100-96-16-111.trex-nlb.outbound.svc.cluster.local [100.96.16.111])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EA5AF7022F6;
        Wed, 11 Aug 2021 17:49:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.16.111 (trex/6.3.3);
        Wed, 11 Aug 2021 17:49:13 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Trail-Plucky: 22579d9e1b1e409e_1628704153455_641425303
X-MC-Loop-Signature: 1628704153455:3477088622
X-MC-Ingress-Time: 1628704153455
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTP id 7EAFE80694;
        Wed, 11 Aug 2021 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=date:from
        :to:subject:in-reply-to:references:message-id:mime-version
        :content-type:content-transfer-encoding; s=novalis.org; bh=MDRDI
        3WPL8rDOBCwEmeq3/NrtDQ=; b=bQgyvms1huqUkcxe3rspM8HHC0FOZC63wSA4Y
        P9p3CXqvHi4EZJlWFt8KlTeJg2ihDbY+z4wWwfvyscxVelsPM0o2qephINV62Wc0
        ry8qgrJ26H2vFOVrXSrHZJLYK8Jq/K8uMkP4bsacZhkRPczzemClqYhDUqVQ0wmu
        oAMWiA=
Received: from [127.0.0.1] (unknown [98.113.183.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTPSA id F00E080475;
        Wed, 11 Aug 2021 10:49:10 -0700 (PDT)
Date:   Wed, 11 Aug 2021 13:49:08 -0400
X-DH-BACKEND: pdx1-sub0-mail-a13
From:   David Turner <novalis@novalis.org>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqh7fwbx86.fsf@gitster.g>
References: <xmqqh7fwbx86.fsf@gitster.g>
Message-ID: <0C7D8DD1-C26A-4E04-BAAA-A63BF1017142@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On August 10, 2021 9:12:41 PM EDT, Junio C Hamano <gitster@pobox=2Ecom> wr=
ote:
>Here are the topics that have been cooking in my tree=2E =20
>=2E=2E=2E
>* dt/submodule-diff-fixes (2021-08-02) 3 commits
> - diff --submodule=3Ddiff: Don't print failure message twice
> - diff --submodule=3Ddiff: do not fail on ever-initialied deleted submod=
ules
> - t4060: remove unused variable
>
> "git diff --submodule=3Ddiff" showed failure from run_command() when
> trying to run diff inside a submodule, when the user manually
> removes the submodule directory=2E
>
> Seems to break CI when merged to 'seen'
> cf=2E https://github=2Ecom/git/git/runs/3259477809?check_suite_focus=3Dt=
rue#step:4:2618

That link says "Merge branch 'fs/ssh-signing' into seen" -- that's not my =
branch=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
