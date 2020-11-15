Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419A2C8302A
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39D222265
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SJb7MKxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgKPMEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 07:04:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:46033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgKPMEU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 07:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605528232;
        bh=loU7wgM2XpBdudw6f95+LNxqEuu6XCZQ4xC/09oBDpI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SJb7MKxeDzoN7s2q3KMSGJYWyX/eusbQ0+Sm0MuvMWQuFscFnFBbYZv8HcGiahelU
         H6GtVyxKbTnyQ2FNCbez6ndmGyV2Cf6vSQLivJSFF9YmAJccP0zWe3N/3l61Lvuxr2
         6Kti+8cuQhmhrTTdRPbvmcadJl+tLv7RM1zp3VGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmUHj-1jx0sT0aCf-00iWUB; Mon, 16
 Nov 2020 13:03:52 +0100
Date:   Mon, 16 Nov 2020 00:47:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 04/11] add -i: use `reset_color` consistently
In-Reply-To: <820a19d2-2acb-3ee1-8927-8981de62bc7e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011160042290.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <c857c4493213bd7cc4d057487db2d1a74fa0bbd6.1605097704.git.gitgitgadget@gmail.com> <6405f7c9-b084-ed48-e33e-009f388933bf@gmail.com>
 <nycvar.QRO.7.76.6.2011131452120.18437@tvgsbejvaqbjf.bet> <820a19d2-2acb-3ee1-8927-8981de62bc7e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IgbvPvjYOZHG5HJAl1LfHtwQtCNcWPHNfNoW/Im61YeAZu5Pgkz
 lkMZlgGuaLgM9dRq4bcByJO+lk+E5Xd6GNfiGbXlm91q7bpEfQbiK/9OBxddtabBXXWWBNB
 WCrqp4TZNFQ+6mmVkr8YF9aKrEw9AOqlaIKA+K9Rh7OAc+GsDbaphlm0SZu5t3zzTpmpgsg
 9R8Cx9Qa7IQYc8WFWOFwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/FEPBdIPArk=:wVHtf4+qW2JGPaf/WbY5Vs
 +5YXQS/vbHIyq7//THQgbUYiG105NWZZXy+zrSGpR1YlHK6fTMN1yqhHPXv17ExNrJk1Ab4KV
 obUlk8FYcStDTVjIFr8zNvQ0nJKOB5oE69qyOgT2TqCZMqZi7F+q3rcpWiW5Vkv4IcQZa8wpx
 xpaFwBWa14kHQjloNmg94Ijeo+dq8Wp5l0H59AfX0UYJrawJYdGVU8+Rd+2kyeRQbn+9K3HjT
 dhp0yY2P7zMkzoE1FswrpbIQGVNwMuQHRT5nZC5K6lzMbyU4L6qUQzG2MoEClw2sD+IfXt5bh
 0Pmxpf8pdGX4blMlUxdkVCHIMLly7xSwE7+jDjrffD1iVp8fNlAJgXNEmNWCEI8vnFtif7ewb
 CcAd57nNS+b1GqQ7pSgTojSuHpiRbNRF6bDNHgYL/lZ8QxLRiDA8Uhhpa7YLWCusNF6CySntA
 KJSIYCsiftY57gcOyZYeMgo6xHTrwPnpISu+GBH4uyg0xcrO8VGRYyL+RzAJubSnY6pT2DQ/0
 GpIcUZYfIppmxSUq91Z7EVTnCXySDoiYk2uqjJxVp51AI4LJallYFtzetFctyEtV9pzUaof2z
 TFPlYC2kUDLxyLhMaWMZwSyTu9VoV5wPy0yZt7gyNs2JA57LXnMoZ3PLf5b9pBDMUeVCiy5N+
 3Ag0sR9CF5SNML+CuqTnVbIpjMNePjw2maL/i7MvOZfJFx9NkPW0pdJ06zHtzRm+3pqPg+yS6
 xL3GzDOnOpHXYTsTC7qDzfvhhX/CPdS0o72XvlGh6DXIO38bYnmug2cVETf6vn+0TSzRZwZxR
 H9a+v3fqzPaW+6xKVQj4G7Rl7Mvy/4y2U7WiXD93j99fYSiPIN1uC4Eff8oSK+iM+J5aDnHwY
 dvoz+mRs/njjmZu9QURjqAauTt68BJWBU4No1XBxM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 13 Nov 2020, Phillip Wood wrote:

> On 13/11/2020 13:53, Johannes Schindelin wrote:
> >
> > On Fri, 13 Nov 2020, Phillip Wood wrote:
> >
> > > On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >
> > > > We already maintain a list of colors in the `add_i_state`, therefo=
re we
> > > > should use them.
> > >
> > > Playing devil's advocate for a moment - why do we have a reset entry
> > > in that list? The next patch makes sure it cannot be customized
> > > which is a good thing so why not drop the `reset` member from
> > > `add_i_state` entirely? The perl version needed to get the reset
> > > string from `git config` and store it somewhere but in the C version
> > > we have a perfectly good constant we can use instead.
> >
> > Right.
> >
> > On the other hand, does it hurt to keep that field for consistency wit=
h
> > the rest of the coloring stuff?
>
> It creates the illusion that `reset` is similar to the others but it isn=
't as
> we don't want it to be customizable.

In a certain sense, however, it *is* customizable. Namely when the color
is turned _off_. Then `reset_color` is set to the empty string, and
`GIT_RESET_COLOR` still isn't.

> > It would probably cost more to make the change you suggested than it
> > would benefit us.
>
> At the moment there is one use of `s->s.color_reset` and two of
> `GIT_COLOR_RESET` in add-patch.c

I did spend the time to look at those call sites, and they seem to be
guarded by "if colored" conditions.

But as I said, I don't think that it will buy us a ton to treat resetting
color different from setting color.

I mean, who is to say that we won't add some sort of low-level mode of
`git add -p` at some stage that can be used by 3rd-party applications? We
would then have to switch back to the current code. And even if not, I
think that there is a benefit to the current code, where no caller has to
wonder whether the reset sequence has been overridden (e.g. by the empty
string) or not, it just says semantically that this is where we switch
back to regular color. And that's that.

Ciao,
Dscho
