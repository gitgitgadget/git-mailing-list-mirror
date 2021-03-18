Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82587C43381
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 12:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B1464F65
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 12:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhCRMyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 08:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhCRMxg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 08:53:36 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9FDC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 05:53:30 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1616072009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HipdoQqUmV0p5fvdeg4LH8i2KaoFdpaFigG2yG/IcEA=;
        b=uT9VUrVV24dDpbJKGnKrghcRkbgoqFzPcOAkNfIBc5Ics5Rk0zL7Z93J6X5KBIwXjbPAXt
        2P4CXPDmRmmEncM+1LiX8ban9WhoFPPuCTLWqaXmfkKMqbp6dSSUOebe3aKfsmwrMjhpRV
        7F+pLeHDPR4l+x0y9XKU8Hu4/iBiMRQZ7PG5145V0BVdr3/FLlRZdLZ9Gqat+QTBGek9Po
        n9VPbemaXmdqMMowzbO4VTf3tVDQ5WeV9LmK/auF7xtzSLugYInZHMcIKUW0MCDjf2OSIb
        hhFDqteQSfbeLADKUUrK1zsp5h7fJAt+XQvPvf9lGccmBoxwxzoj4O21oiwDeQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 18 Mar 2021 08:53:26 -0400
Message-Id: <CA0HPQR98MZ8.HAL8GQYQ7QLD@taiga>
Cc:     "Eli Schwartz" <eschwartz@archlinux.org>,
        "Jonathan Nieder" <jrnieder@gmail.com>, <git@vger.kernel.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
 <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga>
 <YFJ9dI96TO5IdGRZ@camp.crustytoothpaste.net>
In-Reply-To: <YFJ9dI96TO5IdGRZ@camp.crustytoothpaste.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I feel like the tone here is getting a bit hostile. Let's try to keep
things friendly.

On Wed Mar 17, 2021 at 6:06 PM EDT, brian m. carlson wrote:
> I assume that you're volunteering to write the RFC to register these
> with IANA? If not, then they are indeed non-standard and will remain
> so.
>
> I should point out that I don't believe the IANA will accept such a
> registration, because they will believe it to be duplicative of the
> existing scheme. But if you want to go this route, we should only
> proceed if we register them with IANA.

This is a needlessly high bar to set, and saying we can only proceed
with the IANA's involvement seems like a convenient excuse to shut the
conversation down entirely. Registering with IANA is nice, but there are
thousands of protocols which don't bother.

In any case, this is not quite as high of a bar as you may believe (or
hope?). The process is pretty straightforward, and a scheme with "+" in
it meets the criteria laid forth in the RFC, and the argument is even
stronger given that WHATWG standards make use of the convention these
days. If this is truly desirable, we can do it after the feature lands,
but given that the git:// protocol was registered as an apparent
after-thought by a third-party from Microsoft with zero commits in the
git tree, it just seems like a requirement put forth in bad faith.

> > > Lest you think that only Git has to handle parsing these
> >=20
> > I don't, given that my argument stems from making it easier for
> > third-party applications to deal with git URIs :)
>
> This does not make my life as a maintainer of said third-party
> application easier. It complicates it significantly, because people
> often upgrade Git without upgrading Git LFS and then are unhappy when
> the five-year old version they use from their distro doesn't support
> every new feature.

What third-party software do you represent? Can we make an objective
estimation of the complexity of the change for your project in practice?

> Adding this feature which duplicates existing functionality

What existing method is there to identify a URL as being a git remote?

> It also will inevitably confuse users who will want to know the relevant
> difference between the URLs and which they should use. They will then
> see the new type of URL and wonder why it does not work with the version
> they are using. And many users already don't understand the difference
> between HTTPS and SSH URLs, which is compounded by the fact that many
> Windows users have never before and will never otherwise use SSH.

As you explained, this confusion is already happening. If users don't
know what a URI is, then they're already confused, and this is unlikely
to make it worse. If anything, this could make it easier, as a URL which
explicitly represents its relationship with git could hint at its
intended usage.

And again, I don't expect users to actually be handing these URLs around
to each other for regular use. This is specifically necessary in cases
where software needs to handle multiple kinds of version control.
