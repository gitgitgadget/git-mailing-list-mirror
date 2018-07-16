Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0B51F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeGPNsb (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:48:31 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34987 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728758AbeGPNsb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Jul 2018 09:48:31 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 09:48:30 EDT
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6D3A5133F;
        Mon, 16 Jul 2018 09:13:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 16 Jul 2018 09:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keith.so; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=mesmtp; bh=Cy4deSx4EoOQhoCbfAhQ/7dlcD
        vM5vg3l2j/EpjMwxc=; b=RfKAA6+gLtbQdypuPPrcghLVcQlBXySQMWbsZehok9
        vrJhgcpoUfQF3LeTix8Y+4lJME0WOQI7AGdMApkwmDJnlJK2VXlPb09lu+V9chVR
        blu9C6DuTLxoZU+hIngBL7YNU8opol71ttgsTXUhWJm5h6U9JTjVNzwHmyiYuzJ/
        s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Cy4deS
        x4EoOQhoCbfAhQ/7dlcDvM5vg3l2j/EpjMwxc=; b=BdcoKZ13ra5yEy80k8YVM4
        PrB6avh3oI8HdCu2e/R66knzsMR95a4ynzcPcE9hytiktE+OEhCKRmyYTAAy4++1
        BQkTj2/qmvLUxQqUSx3IzzBdvo0Q2p7NcQXmZ3RkWKghPtmnVyFKlVyZuKtYqE/R
        NPJnp+ncfyBJhtS+WEwUZ3/MML9+7PF6jEklRFTCYu9Zc4JsOOD0Oxk9+ANwo3ij
        j6LR066fj/eaN2I0X1Fm1BJCH/8BJBq4+6V+p82Oi4b+82tM040qz/gOxwx7to2O
        FJANRAqu82DkyX9xKC8D0QmIRr6jmUsc4ZaNaUSEvSz0svzCCeCkvO60N3Z1bioA
        ==
X-ME-Proxy: <xmx:3JlMW1xb4JlKFi56XTTzugGrO7NjN8QQsA6EWuuEoXcCuX85nPG2_g>
    <xmx:3JlMW8NIQBmIRaLlv9GJ1HvDFSSSuICd4jBCEtWWr8_r6NnHYUJpTw>
    <xmx:3JlMW4Ri9XkXvGKjDXeV7tIpwfjABDsAg-ekXswBNXhqFdF-xaaaYg>
    <xmx:3JlMW_WBewoZKMmtYfcLJrrxQC27Yb7JuBqlj_wWlKVmRnvqiIlnhw>
    <xmx:3JlMWxRWwY6z1T7WHSYdnxa34y2ByU567RKXzlPEcc8sj3SK04QJoA>
    <xmx:3JlMW0mHNq72EEwZZO0NlZ_ph0s2na1I1-AUo6C-1QH_Lq3XiwcXcQ>
X-ME-Sender: <xms:3JlMW33v8WZdOKzhPwUYe3KXizk6OphMnIJH_61G_o-fzC-CIDvR5Q>
Received: from [172.16.1.125] (unknown [136.24.23.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id AEAF7E49F9;
        Mon, 16 Jul 2018 09:12:59 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Add shell completion for git remote rm
From:   Keith Smiley <k@keith.so>
X-Mailer: iPhone Mail (16A5318d)
In-Reply-To: <CACsJy8C0f43cc5TuybEo5wmem9MSdTO+-0tF3c9k4siN1UgwwQ@mail.gmail.com>
Date:   Mon, 16 Jul 2018 06:12:58 -0700
Cc:     Kevin Daudt <me@ikke.info>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Todd Zullinger <tmz@pobox.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86CBC1AA-2AE2-4C58-A7BC-A6AD3A3B822D@keith.so>
References: <20171229135240.GQ3693@zaya.teonanacatl.net> <20171229224825.31062-1-szeder.dev@gmail.com> <87y3ll6s0e.fsf@evledraar.gmail.com> <20171230005222.GT3693@zaya.teonanacatl.net> <87vago76i8.fsf@evledraar.gmail.com> <xmqq373miw4r.fsf@gitster.mtv.corp.google.com> <1516052626.2870893.1236353440.65CA651A@webmail.messagingengine.com> <CACsJy8Dzv3qPc1dB1rdvYL+CvEp+hY8ddoBrbCiP5KnqikzyLw@mail.gmail.com> <xmqqh8rlvdgh.fsf@gitster.mtv.corp.google.com> <20180117004419.GA14263@duynguyen.dek-tpc.internal> <20180117061703.GB5618@alpha.vpn.ikke.info> <CACsJy8C0f43cc5TuybEo5wmem9MSdTO+-0tF3c9k4siN1UgwwQ@mail.gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since there hasn't been any movement on the alternative solutions mentioned h=
ere, would it be reasonable to accept this patch in the meantime?


--
Keith Smiley

> On Jan 17, 2018, at 01:48, Duy Nguyen <pclouds@gmail.com> wrote:
>=20
>> On Wed, Jan 17, 2018 at 1:17 PM, Kevin Daudt <me@ikke.info> wrote:
>>> On Wed, Jan 17, 2018 at 07:44:19AM +0700, Duy Nguyen wrote:
>>> PS. This also makes me thing about supporting subcommand aliases, so
>>> that people can add back 'git remote rm' if they like (or something
>>> like 'git r rm' when they alias 'remote' as well). Which is probably a
>>> good thing to do. Long command names are fine when you have completion
>>> support, they are a pain to type otherwise.
>>>=20
>>=20
>> Couldn't they just create an alias like git rrm then, if they use it so
>> often that it becomes an issue?
>=20
> They could. The only exception that may not work is if they want to
> insert some options between "r" and "rm". Sometimes option positions
> matter. Anyway this is just thinking out loud, maybe we don't really
> need it until people scream about it with a valid use case
>=20
>> Having another layer of aliases does create a lot of complexity.
>=20
> Yes. It's partly the reason I wanted this actually ;-) Many commands
> have gained subcommands nowadays but there's no shared infrastructure
> for managing these subcommands. By adding something that works across
> the board at subcommand level I'm forced to "fix" this (or probably
> never get to do the sub-aliasing because this "fix" takes forever).
> --=20
> Duy

