Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB461F424
	for <e@80x24.org>; Wed,  9 May 2018 17:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935274AbeEIRvJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:51:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44289 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935189AbeEIRvH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 May 2018 13:51:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E7D022B55;
        Wed,  9 May 2018 13:51:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 09 May 2018 13:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=mesmtp; bh=UILXmEHxqOJlAnz5JnQRjgKZkI
        GlEII30KQ6AOrfOLg=; b=lfDzyz8LLzuvNgJIeTx9J1SDPLMjlALMN7yP5pJLBx
        dM61jFkb6ePUixYFdxLxrtC7eo9kEVllSbyyYJ302T1DCw2u7v0y79Cmal+kbpPu
        r8J5tVTXBtxi6H1Et+vG5wZqb1anuI66CbG0oB8L3JX1JYgfJuSkob5HoLlke4N8
        k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UILXmE
        HxqOJlAnz5JnQRjgKZkIGlEII30KQ6AOrfOLg=; b=GlpHtjKTTu5t78z/1/gHj9
        MipBfoIM23yZ70syGkYBZ6BvmvlrZZZTKLgMJfa1zBaVmM/+6zfEhmL9fPYRngoK
        8n5pFdMVPRiYGI0xVlTC69bPU+xnerRcSKSjbNhmkoqNlU6rbmZRPgxWL6kIGw/V
        ncX5DBChBur2jbVfRKu257zyia1reHzWYQmGz5+U41dxKsg/QrXPJ66rnhu7CDAX
        wRvrAr0D3dm2+F/E5j8yXJzXC7ZitHmQsdooE1x0YsV3QwziAC6/CoeJtXb2BOlC
        FWT7z8mJKn1gtfDP/SvcJY0byQi3b4ilIk7AXFCKB3gDCI2yT0ePW3SCtcp72TIA
        ==
X-ME-Sender: <xms:CDXzWtlE189RC9DhTFbHBu15EjGUzS60ZpXsrPbOZC8HViusYgHmsg>
Received: from centaur.local (ip5f5bf44d.dynamic.kabel-deutschland.de [95.91.244.77])
        by mail.messagingengine.com (Postfix) with ESMTPA id 38828E463E;
        Wed,  9 May 2018 13:51:03 -0400 (EDT)
Message-ID: <67fd1816c4da0e54fb88dc29a44b897d41a36602.camel@dwim.me>
Subject: Re: Implementing reftable in Git
From:   Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        ethomson@edwardthomson.com, ps@pks.im
Date:   Wed, 09 May 2018 19:51:01 +0200
In-Reply-To: <20180509164807.GI10348@aiede.svl.corp.google.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
         <20180509164807.GI10348@aiede.svl.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Wed, 2018-05-09 at 09:48 -0700, Jonathan Nieder wrote:
> Hi,
> 
> Christian Couder wrote:
> 
> > I might start working on implementing reftable in Git soon.
> 
> Yay!
> 
> [...]
> > So I think the most straightforward and compatible way to do it would
> > be to port the JGit implementation.
> 
> I suspect following the spec[1] would be even more compatible, since it
> would force us to tighten the spec where it is unclear.
> 
> >                                        It looks like the
> > JGit repo and the reftable code there are licensed under the Eclipse
> > Distribution License - v 1.0 [7] which is very similar to the 3-Clause
> > BSD License also called Modified BSD License
> 
> If you would like the patches at https://git.eclipse.org/r/q/topic:reftable
> relicensed for Git's use so that you don't need to include that
> license header, let me know.  Separate from any legal concerns, if
> you're doing a straight port, a one-line comment crediting the JGit
> project would still be appreciated, of course.
> 
> That said, I would not be surprised if going straight from the spec is
> easier than porting the code.

Would you expect that this port would keep the Eclipse Distribution
License or would it get relicensed to GPLv2?

We would also want to have reftable functionality in the libgit2
project, but it has a slightly different license from git (GPLv2 with
linking exception) which requires explicit consent from the authors for
us to port over the code from git with its GPLv2 license.

The libgit2 project does have permission from Shawn to relicense his
git code, but this would presumably not cover this kind of porting. I
don't believe we would have issues if the code remained this BSD-like
license.

Sorry for being difficult, but fewer distinct reimplementations is
probably a good thing overall.

cc the core libgit2 team

Cheers,
   cmn

