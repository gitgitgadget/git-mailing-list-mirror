Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F41C4332D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 15:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660B564F5E
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 15:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhCQPwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 11:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhCQPwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 11:52:06 -0400
X-Greylist: delayed 167151 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Mar 2021 07:53:09 PDT
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09E0C06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 07:53:09 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1615992788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jeZhZOXaylUZG9VAou0fyoHsRkHj8epnymdXQH95tfU=;
        b=WhE8Vtzq4NPMDHLYRHxWrJDuFUq9ixRfwqWrxCMeos0iA02SiNoZtH/D+4A++i0Waad8Ys
        fZ5SRic4/c0RdnjWPclV6REui5HYqJB3YU49/2rllNSOXOj6ZUIzAUUK9nltEUis3kuUl5
        Iankcq8t0eIw9EtTdniRW+ZVj5G7y9vhCllIBHAxFlrlDRBkMjpQFzu0ans3PGtupbH2aU
        FQ4G0l7rgmS2BGE4mbnr3UKxa1wbJ4WCFlttQdWz/bcLC42YuqUzF77227X6PyZTK4gcgQ
        KOpyaKdu2s42aSFv6UFxmc7aU2cvgAfSKGZkg+mUegf47nPe0ewwXfHRG8Htyw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 17 Mar 2021 10:53:07 -0400
Message-Id: <C9ZPMTQD2PJE.3N2S1VX9NVK2T@taiga>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     =?utf-8?q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eli Schwartz" <eschwartz@archlinux.org>,
        "Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
 <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga> <85r1kewqui.fsf@gmail.com>
In-Reply-To: <85r1kewqui.fsf@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Mar 16, 2021 at 8:45 PM EDT, Jakub Nar=C4=99bski wrote:
> Well, thara is a total of one protocol (CoAP) that uses '+' based
> schemas, namely: coap+tcp, coap+ws, coaps+tcp, coaps+ws (well at least
> out of those protocols that made it into IANA).

One is greater than zero! It is blessed, even if only a little. We can
just go ask the IANA about it if we want to further entertain the idea
that this approach is non-kosher, but, like you said: if the RFC states
it, then it is a standard construct.

> Though it in this case neither of those parts of schema joined by the
> '+' sign is an application name...

git is both an application name and a protocol name. =C2=AF\_(=E3=83=84)_/=
=C2=AF

> > Aye, people do expect it to work. The problem is not going to go away.
>
> To reiterate, the idea of "prefixed URLs", that is using git+https://
> and git+ssh:// is to denote that said URL is only usable by Git, without
> any additional out-of-band information (like other attributes on <a>
> element or its encompassing element)?

Correct.
