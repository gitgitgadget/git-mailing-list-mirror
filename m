Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646BEC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0EC2076E
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mattmccutchen.net header.i=@mattmccutchen.net header.b="QS8UI0Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHDAnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:43:40 -0400
Received: from lavender.maple.relay.mailchannels.net ([23.83.214.99]:47066
        "EHLO lavender.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgHDAnj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Aug 2020 20:43:39 -0400
X-Sender-Id: dreamhost|x-authsender|matt@mattmccutchen.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6782218161E;
        Tue,  4 Aug 2020 00:43:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a94.g.dreamhost.com (100-96-22-23.trex.outbound.svc.cluster.local [100.96.22.23])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C3298181456;
        Tue,  4 Aug 2020 00:43:37 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|matt@mattmccutchen.net
Received: from pdx1-sub0-mail-a94.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.8);
        Tue, 04 Aug 2020 00:43:38 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matt@mattmccutchen.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Society: 67b9564111c04d35_1596501818261_4206545087
X-MC-Loop-Signature: 1596501818261:1570177411
X-MC-Ingress-Time: 1596501818261
Received: from pdx1-sub0-mail-a94.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a94.g.dreamhost.com (Postfix) with ESMTP id 856A1B2B9F;
        Mon,  3 Aug 2020 17:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=+qfjgX3+g67En8cfIuGL2lh7Mds=; b=QS8UI0Lfge
        /WdEmsA4fjvlELV8Bnn6s1l7Ejbu5k/4/iE9+7+5rqQv+0soEy0BrWiQSwbcfJ0D
        3Hr3cfaa5X4Ec6nyOIstC6GP6tAi9Nfzqv23Y/gBvf5lumVkvePqjm3T1D42fCxB
        8Si5T3sA+0yF5ZQsKS9fjipPBLbyTc80A=
Received: from main (pool-100-15-89-198.washdc.fios.verizon.net [100.15.89.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by pdx1-sub0-mail-a94.g.dreamhost.com (Postfix) with ESMTPSA id E7247B2B91;
        Mon,  3 Aug 2020 17:43:36 -0700 (PDT)
Message-ID: <0f1c557657b46ec4124ca37816a3e0aa4bd83501.camel@mattmccutchen.net>
Subject: Re: Renaming the "master" branch without breaking existing clones
X-DH-BACKEND: pdx1-sub0-mail-a94
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Date:   Mon, 03 Aug 2020 20:43:34 -0400
In-Reply-To: <20200803160051.GA50799@syl.lan>
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
         <20200803160051.GA50799@syl.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeehgdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepofgrthhtucfotgevuhhttghhvghnuceomhgrthhtsehmrghtthhmtggtuhhttghhvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeeuudfhtddthfduteeghfdvheeuledtveehteeiuefgkeetkeffgfdvgeejvdeuudenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedutddtrdduhedrkeelrdduleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepmhgrihhnpdhinhgvthepuddttddrudehrdekledrudelkedprhgvthhurhhnqdhprghthhepofgrthhtucfotgevuhhttghhvghnuceomhgrthhtsehmrghtthhmtggtuhhttghhvghnrdhnvghtqedpmhgrihhlfhhrohhmpehmrghtthesmhgrthhtmhgttghuthgthhgvnhdrnhgvthdpnhhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-08-03 at 12:00 -0400, Taylor Blau wrote:
> On Mon, Aug 03, 2020 at 08:15:58AM -0400, Matt McCutchen wrote:
> > 3. Ensuring that tools detect the default branch of a given repository
> > in an appropriate way rather than assuming "master". [...]
> 
> I'm less qualified to talk about what's going on here, but my
> understanding is that providers and tool-makers are quite aware of this.

I'm not so sure about that.  Recently I've been the most active
contributor to Braid (https://github.com/cristibalan/braid/), and I
only learned about this today when I stumbled on news about a similar
change to the Linux kernel and immediately wondered if git was doing
the same thing.  I filed an issue (t
https://github.com/cristibalan/braid/issues/87) and will develop a fix
when I have time.

Matt

