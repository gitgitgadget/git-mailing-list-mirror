Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D04CE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjIYLxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjIYLxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:53:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DF6107
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695642773; x=1696247573; i=johannes.schindelin@gmx.de;
 bh=MZ/9cO7mq8gliB5mJT+P/O55eBNA8k1UWmB/C1oxw3A=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=kxroIdlbdVk5Y7Tby2qOHT4XrVtj+oUUjNBwwOPcUhLp8F4m7PjrkCmBm2MgJDE2+uSSNF4N010
 EANmCOF+SICTWCvCFbnRj5BtRZb1/LZlL8UdwWz9rX10sLqujWMAAEJcLNoWgDiYHyhdPsAKDpGny
 Hi/2gnJD3CEP48eloHIOPZ2v9dM7t0xNQPwZdiFyWjxzGkUiOVkVwbhbDImNN+DyAlGvQGPVQubOQ
 86ZxCppJYv+fC2VVNSVbJtxcYDbsYzOYvQ5RcHqxhYBknIHHDlJ7kGVbaMNQScu3PsEfXLFeQZbPp
 8Sx4dKtqvosv5xdQj/ZVzuynqwHxRLZrIYeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1rmJAK1H6v-012KSV; Mon, 25
 Sep 2023 13:52:53 +0200
Date:   Mon, 25 Sep 2023 13:52:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/6] coverity: allow running on macOS
In-Reply-To: <20230923070647.GB1471672@coredump.intra.peff.net>
Message-ID: <736713f0-ec71-0270-fab7-9300b09ad4ea@gmx.de>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com> <782cf2b440313fcad0492ee352fa66d1a3534ac4.1695379323.git.gitgitgadget@gmail.com> <20230923070647.GB1471672@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OCW5lXBshalRYgpRtSirOXhG25QXJBK8vWllZAxG9fLUhKCGLWc
 i5VCcBY+PgBIkBEmQBGo2wDT6A5B/tUSSzfjVnGPhO1+AwVrpfNq39Q9PFxI5PlwqTRJ7Bo
 054/CfbONTXR2SJDmF9SVDN1uhTP6uJ9hLHH33FyeTXivK2MyYozuRkjYTJ/HllKzfPQ2Hs
 JEH0YzKzsRRvK6BlLG7jg==
UI-OutboundReport: notjunk:1;M01:P0:Rznvchj51zM=;wOf4ybxJXNT52Hq14aGgCR0OKrC
 PSnUDBwetDnYcPZK+XZjXI0pVrsy+PzltwH85P3aHZAKDUabqKbTpgdilgVaNYWnNtPFqppTR
 vFMAqxl9CDH9vAmyaRqZ87+TBKwgvBNOmFbJRQt1b664ePTFbLeU+OXawVJKWQ4md8sNM9ELI
 y78pt8imS1Nl6/Z4QOyUh8CDtrCLb/lDnGSBBDZXfrQcndTYfmWpNcaihj42smvmBWgzh1S8J
 Tc3CcqeF23RfSVSBk6Gqxk+4SjTuEsAnyfsVt/05c9GUGetaHMQZjVTCCLT2xzcxazr9kfKgn
 6/gtGL1OIFoLFVLv+sKZVKYwZhQ9E32NosVp3kiL6eSekgaF+NsGSYzn97iTtCjNxBITO61ta
 tdXNl9swQxmt2CS0r+zka3BMEGedgHjI57Va8y3DNgToU+PU9aG29/AzcDX0bLAiqCFkAwPd6
 v4WNEpj2IPS3RD52svX2yMV2uQDjAY16pUlRXu+qFCdTYY7iYvBUSG/qG/w9Dmuzsq4YT5BGL
 w8/iRjlJs6LpNOvyyH9LJqdrq/wLQSekxCVJ+1cIUOmyjMOcF3LmR1Mu4Kw8VtEcN4Ate9082
 Xds5dHpiR1S3WVcJEHceLcJa8I2bqPCSHsZ2V0iMHDZMBuTQ6KzJ8o2TgPadwP3thTbjUzx61
 gbRdhwak3G5OTy+/vcVdRz23N6L2I8T1BWZlInwTzDc69JjbYYdO66k6xfQ+r4fAGYKHCyk8q
 T3JCKe8MOlKB4CMsXc2F2QIFBvaoVf2vA30UHWEYaULOfHwHHwdZVk+INBBy4U9wEvr+88xoP
 Ws7j3OhLkGw3N7TKXTgtDu0KxkKXeaqDPT2s31ReOQuIjVRWYx49I2p8FEWH09mDZHbMWzmGG
 xOAwAo56yjPIdZtu0BAHP2Z/8xongeGZqxMXQrmul+PNqbPgFsOdgT5Gk4F+RvxPJk5UhHd97
 szC/TA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 23 Sep 2023, Jeff King wrote:

> On Fri, Sep 22, 2023 at 10:42:02AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > For completeness' sake, let's add support for submitting macOS builds =
to
> > Coverity Scan.
>
> I don't have any real problem with this, and it will check a few extra
> bits of platform-specific code not covered elsewhere.

Just to make sure: The patch series, as presented here, will only build on
`ubuntu-latest` by default, unless that is specifically overridden in the
repository variables of `git/git`. It makes most sense to me that way.

> My big question would be: how much extra does this cost to run each
> time?

I linked the example runs in the cover letter, which record the runtimes
of the `build with cov-build` step as:

	ubuntu-latest	5m20s
	windows-latest	17m40s
	macos-latest	1m59s

But again, I don't see much sense building `git/git` for anything else
than `ubuntu-latest`, at least for now.

Ciao,
Johannes
