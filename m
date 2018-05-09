Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3A91F424
	for <e@80x24.org>; Wed,  9 May 2018 18:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935146AbeEISFp (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 14:05:45 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43043 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934783AbeEISFo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 May 2018 14:05:44 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 63DE022A96;
        Wed,  9 May 2018 14:05:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 09 May 2018 14:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=mesmtp; bh=Ey+VHHXa0DZJzRKZF3xxT9o2Pw
        JIZyS6X++7+aZXgQA=; b=eXRXdReVdT9ZeyRhjF9fMRyf52R2H3AFcNcy39ueen
        5JeJwUSwbUr3DtyUIYh+EJLKpvwooTwfCZzX8qlr+0Wu7K3O9q4vJqeJSsk6k4l5
        qlPtlV3lPC8k1me4ZtiMCE+UZXO0Qi4O8k7N7mPVqXrvIinZlTsOl1N7QyFz/yCz
        0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Ey+VHH
        Xa0DZJzRKZF3xxT9o2PwJIZyS6X++7+aZXgQA=; b=nkGDu1a9JS0ujKteiSYdmQ
        eLtESm941LEAmkQg7vHQBSV3vwo3ojvWdJPVGBzrI0Ql8AyJdoXh/n2JYSH3K3mh
        OP+ZTtkW/WnB0eS1iNZg3Yy/4vvUOFMDFTzyKJ29GrBeDpqpYiarxmZVrsGb9W/W
        e+NqKiXGg745zo97Ij2eqTPQrcVa1lWm6jMtvdASZZ4C9TQ6NMw6thrKrzW1948P
        qbxQl4XRTR1HX9BxuOQdpOmJ9xMKm1r9lxlfE5atkFbtSO2W6RMcRDWaLtEU2AZx
        ZEeEet2RkUL1pIvit3vomMlGVris9BSBcugY+zVyWwReYzkxsPF67Z/TXRMIog+g
        ==
X-ME-Sender: <xms:eDjzWnPlrswW4PphfJUb9Doicpw3Y2TeAzWdPSD9_09UZE0sfgi48Q>
Received: from centaur.local (ip5f5bf44d.dynamic.kabel-deutschland.de [95.91.244.77])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED598E5086;
        Wed,  9 May 2018 14:05:42 -0400 (EDT)
Message-ID: <e6f23463b1bd577d1c70848b11a0fd217b78f8a8.camel@dwim.me>
Subject: Re: Implementing reftable in Git
From:   Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        ethomson@edwardthomson.com, ps@pks.im
Date:   Wed, 09 May 2018 20:05:41 +0200
In-Reply-To: <20180509175445.GK10348@aiede.svl.corp.google.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
         <20180509164807.GI10348@aiede.svl.corp.google.com>
         <67fd1816c4da0e54fb88dc29a44b897d41a36602.camel@dwim.me>
         <20180509175445.GK10348@aiede.svl.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2018-05-09 at 10:54 -0700, Jonathan Nieder wrote:
> Carlos Martín Nieto wrote:
> > On Wed, 2018-05-09 at 09:48 -0700, Jonathan Nieder wrote:
> > > If you would like the patches at https://git.eclipse.org/r/q/topi
> > > c:reftable
> > > relicensed for Git's use so that you don't need to include that
> > > license header, let me know.  Separate from any legal concerns,
> > > if
> > > you're doing a straight port, a one-line comment crediting the
> > > JGit
> > > project would still be appreciated, of course.
> 
> [...]
> > Would you expect that this port would keep the Eclipse Distribution
> > License or would it get relicensed to GPLv2?
> 
> I think you're way overcomplicating things.
> 
> The patches are copyright Google.  We can handle issues as they come.

Fair enough. I just wanted to avoid coming back to this in a few months
and realising we can't use it at all.

Cheers,
   cmn

