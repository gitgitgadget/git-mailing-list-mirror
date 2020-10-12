Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFF6C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C41420878
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 18:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fyNsc5KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgJLS5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:57:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:43473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgJLS5y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 14:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602529068;
        bh=ZzNFWNCU+ZBs/05DYOtTtxiVP8/b9l1dP8wq3Ud6rok=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fyNsc5KOxbCwVKPMHkeQQus5vQoKN0XFw4mRQFFWBNKTBTIIT40D2IuU0lmiDpPdX
         TdVeMgV4bhvMBAMat2Fbcqe2d2yL+CPa7XvMAcRtwpJuIkWyX2GT7WLJFkruZS+zlX
         ULA9AQ052ict0h3PmwxA8Vxh+R7yit+jtw1APUBc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1kGRww1QZ4-00zHbX; Mon, 12
 Oct 2020 20:57:48 +0200
Date:   Mon, 12 Oct 2020 20:57:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ci: skip GitHub workflow runs for already-tested
 commits/trees
In-Reply-To: <xmqqy2kbqv7b.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010122044460.50@tvgsbejvaqbjf.bet>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com> <pull.619.v2.git.1602170976.gitgitgadget@gmail.com> <914868d558b1aa8ebec6e9196c5ae83a2bd566bf.1602170976.git.gitgitgadget@gmail.com> <20201009072922.GC24813@szeder.dev>
 <nycvar.QRO.7.76.6.2010091254180.50@tvgsbejvaqbjf.bet> <20201010072508.GD24813@szeder.dev> <nycvar.QRO.7.76.6.2010111221350.50@tvgsbejvaqbjf.bet> <xmqqy2kbqv7b.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QIPIiTn6pEHtJMhj9GmzupBucCMZGe+8L3NCpEU0c2mf1xPsgSM
 7+IjLvKM8mTInos0DobqN0axFxGXbdHmHM4lMckjPtp2k4nbgM/imUEXJ3Ml1+9gLBq2FNH
 Oe/JCDzPEjct6CgZeJGIJJEQBDig5a5pKzULlFnhPBWgsn45eMdsmbCHJxdnoCb/HPIwWg7
 bwTVVpaoh1FGjyxPBf/tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zl7M82m7l+I=:sMjowJXc2ULOtivvVFaQ5S
 hUpehnmICmYFUGTXGNpVZmmLZq5DoS3yH61qq4YxjjOYV8XzeV9xQME1QuRsNPNd6cv+omQ+T
 ii3w0cO32/zor/eiMExxoDXgyj9Vp+4K6IWiTl95dk23TG0fCNqvXzu8z1NPz6EQTkj/KMHLN
 iPXpt/09cmEtqmQG6yYIL2J/VAIz80B50TN8FTbjViFF/ilMwS/r+fQnhzs2L3lUbHB/9l32O
 OmjgEvbSckqupsBaxLLl0Ef305Syu1tPW3IpiFPNP4Q2qxpjv7A35uBWfP0Ceyhm51lXl9Stx
 JG37/OBTEEgkBwfB+75NQd2cX3LR/IvzgGA3bU187cBK8GcCQUL8it8nSzEJtZ35nuued9nl4
 Yfn72CBaaCj5kZtNYhQkYeVg4zAiihHZbnrafojdj5Ck58ByiI1ek/Xx0WS+6tdO2Qy/7VDLn
 s9WvDZZ9wxUAR5M53mT515pbNC8z9itypYrxghSwyvelGGXxbwVnUfXaaHy/brIEEWRrKNtts
 cC/5Lh8Wk/q1oM7238i01czxeti5yT7vmQxlfPmlVXzSx04zvEihMwyohc7vrTAe8Zuv2FbmH
 O9aiApq66UOXVRr5+wo1PaYCyE+IlntxIXQkIiLmtpgl2WxFIHGnjbXikUDHj6PwxvSGTfKSF
 l87Ep3IFAjpSKb919488D8RxNWf+myQ0m5PFNz9T9mVhjvy0ApISCQWlNf82afHpbtPldb9U9
 XMAPhxTBPBijhIjmj7/Mi3sDcMoe6lj0MppFc31nFgUFgU+HwL9/oYJI6n+WXWNhTJgyeTxk7
 3R40Bf9kCewS3WezeZRirG4LOrjzybEqh+QxyGL6zMGdnLo+mQkD/R7FCjYssRYOY3EgVdX0O
 AXswLwYXMmgaGqpXcVlPpY2aVOy7gGpbuEnHs1F77qi/V8rfKLYlbAitwP/TlrE5483BKetUu
 pcHCYmI0f73qKl1Q10pU6ZrUN2P8M/48PJEJbSHRyAi3tS0aWkNbL9VpOTM61JQ93an83P302
 DWTAmobKsXttzIKjcES9F80kdT+HipU0LTyROPt7hi+Lzz3YQfkJCTw2LAOn5NXS5/tvl3qBK
 9FTDXzbii/kTOcrfXcqS8CpJpYwWGaGvT87Oz9xZQPh71SGHvXnUPNoNiWy6hSj9eCvcEJkIf
 zrfWAqUMeWVmVtrBXWbeeKx4CR+ohWZ/CpGsubOBr2KfFBm53IDApUfhMuRCxh4n80HVz3Hue
 PAydPPHuE9Dfa0V0rNme+d80ZMLdS5DVKKzTimQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Also, the patch specifically adjusts the GitHub workflow itself.
> > Therefore, unlike the `skip_good_tree()` function, it does not pretend=
 to
> > be generic (which `skip_good_tree()` really is not, as pointed out abo=
ve).
>
> I think skip_good_tree aspired to be a generic one, by having the
> "if we are not in travis nor GitHub actions, return early" at its
> very beginning. [...] it would have made the intention more clear if the
> conditional at the beginning of skip_good_tree() were adjusted, perhaps?

Full disclosure: I am not even sure what to do with Travis support at this
stage (but then, I am not the one to decide over that).

In any case, it appears that no matter how generic the `skip_good_tree()`
function meant to be, by virtue of using that `cache: directories:`
feature (https://docs.travis-ci.com/user/caching) it is limited to Travis
CI nevertheless.

So if we were to adjust the conditional at the beginning of
`skip_good_tree()`, it would probably make sense to make it clear that
this not only does not work with GitHub Actions, but in fact it does not
work with anything but Travis.

Ciao,
Dscho
