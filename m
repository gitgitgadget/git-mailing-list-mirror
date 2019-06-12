Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA26F1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 12:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439141AbfFLMrN (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 08:47:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35915 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439095AbfFLMrN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Jun 2019 08:47:13 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CBAF21FE0;
        Wed, 12 Jun 2019 08:47:12 -0400 (EDT)
Received: from imap36 ([10.202.2.86])
  by compute1.internal (MEProxy); Wed, 12 Jun 2019 08:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inspired.no; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=mesmtp; bh=+O
        oeM3w3pZG4RoQl7sZlsCW96dlYZQ8GpR8UJJ+cjKc=; b=WQPMnCiun9w+5rl2np
        LudJ5EwU1YBzJM4Ag/RpgKlNVUpnMaDOfhczb3GdSEhngoxCbtcPzLMrJ3gvuM7V
        rXymNSInQTkg3WQvppX+2dcd26hTIMdxwMDMSN0Ay+wMSo4htzfMR9Ra4msBWVAL
        uRokVLJTHfGSWkK4yFIx2QoD0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=+OoeM3w3pZG4RoQl7sZlsCW96dlYZQ8GpR8UJJ+cj
        Kc=; b=pVJMhcVP49hJbCsFd8KymvzRLLtD6hKnVhlx20QdDuDNAwdcD6gRTQGJ3
        wudNO01NJJ4nyff4sUQmAG/mxlbLbnIRt1NffbWWr2IKHdeDvzixROeKoVmJUtBx
        cIiHS6A1d56IVQYKnGIechMULEQgP4pafz5OCFzglYdKjIfm1ikoi8e6XcrgpnPH
        8Axo+9WRtL2nch6edDJCBz5Do8tuMGed4YR9SYFd8Y8+c1J2aVE2nqAaDggQsipm
        u1bcItt9I+PZGdVq1iXGWnQ2CeOQUVCK5iwNDNxXsTzScjKG9TJgznLVYJIEvIOu
        U+hCGK1/B5bZG33BU3mq3TBbfTznA==
X-ME-Sender: <xms:UPQAXZKVMjAYpFv90mqUgjXtPXiLAASc7JlEOhsSlpAaJXft693olw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehjedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfgfhs
    phgvnhcutehnthhonhhsvghnfdcuoegvshhpvghnsehinhhsphhirhgvugdrnhhoqeenuc
    frrghrrghmpehmrghilhhfrhhomhepvghsphgvnhesihhnshhpihhrvggurdhnohenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:UPQAXU2wCq0FhW3quirilMIkyBhEBGwl8C-H2Y7x11W9nIsHX8zOig>
    <xmx:UPQAXciEyOeI1_GPU6HAQiIYd4_wxulM7CKptLLly40ldS3KW1Cccg>
    <xmx:UPQAXc30XM5iSfbAZ_phvmSv9wUWe-H-s-OEFAZnDjRv1Cb9YnJceA>
    <xmx:UPQAXeun1XmzwmPMV2JThjN9Z8umDUQJ5Rysr9qS4MLXmHV61pnbgg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DB40912200A2; Wed, 12 Jun 2019 08:47:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-663-gf46ad30-fmstable-20190607v1
Mime-Version: 1.0
Message-Id: <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
Date:   Wed, 12 Jun 2019 14:47:11 +0200
From:   "Espen Antonsen" <espen@inspired.no>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Git status parse error after v.2.22.0 upgrade
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't have any hooks, just the default sample scripts. GIT_TRACE doesn=
't show anything else.

On Tue, 11 Jun 2019, at 21:28, Johannes Schindelin wrote:
> Hi Espen,
>=20
> On Tue, 11 Jun 2019, Espen Antonsen wrote:
>=20
> > Seeing an error after upgrading to git v2.22.0.
> >
> > git status shows =E2=80=9Cerror: could not parse =E2=80=98*a commit =
message from 2012*=E2=80=99=E2=80=9D
> >
> > Downgrading to v.2.21.0 does not yield this message for git status.
> >
> > I can only replicate this in a private repo I have so far. Unable to=

> > share the repo but can debug if you need more info.
>=20
> Sounds like a hook gone haywire. Find out more by setting `GIT_TRACE=3D=
1`
> before repeating the command.
>=20
> Ciao,
> Johannes
>
