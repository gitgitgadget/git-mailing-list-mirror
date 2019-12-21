Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0255DC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFD7206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AVyPAKhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfLUWGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:06:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:42637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfLUWGW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576965973;
        bh=Val5ALkVbikRrvMUphxfoOpu7cXbAHMd+lughA356DI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AVyPAKhTL9Vz7RgsR5vlLyW6Kzq4J1PWFicTTjfStiugui7md/Uv7aLjmznFEMvUv
         WkaXvel0l4VYPlgLy6NzQqHeg/r1paqlPUW7se6hlbVMVJNqZVHvFgVg1gIQYZ4B2r
         F7p+mUhKYH+E8lVb7or15BhrAW5uy97r5iu+rqeM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1hoLgQ1dHT-00v4qO; Sat, 21
 Dec 2019 23:06:13 +0100
Date:   Sat, 21 Dec 2019 23:05:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, blees@dcon.de, kyle@kyleam.com,
        sxlijin@gmail.com
Subject: Re: [PATCH v3 0/3] Directory traversal bugs
In-Reply-To: <xmqq1rt2ized.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912212305260.46@tvgsbejvaqbjf.bet>
References: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1912171217000.46@tvgsbejvaqbjf.bet> <xmqq1rt2ized.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EDTv9utE2gxRe2ogWxq63ojpbpyLWiF4mGDjmSCVNwVjpHYSwdR
 LJmh0X0RYxoWYcwFVIR10byP12dTvMky1+BDbf5EYesZFmJxKAwuSoqpsTLCkgf0gBtS9dr
 aRAUVoOqdRs2A5PpuzvNTHy7mHBcSU7Pss7mKFR0HqOlU9bh1tm74Rib42TkkgwA0ikB4zP
 +J6MGiwtv0jq+tvVsduWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p5K4ESAaJa0=:4JQcIxu/k5exLAwcMCHC9W
 LjTptw5UdckWqgasm0+LDjUi62Ca/TigSmzunnpH6+rgWtzayBqwzMfodANxwKaJ5VRbZEF3A
 w0D5upV11B1Rsvsg+oq2d1BfCmjpSb0IpoA2l9Gg8DuBhyoSpNh5o7gXA3NE1dMug3JM6cni+
 UH5hDy4k3t3VuNfo+x6dqrk5fFGHJPSVEYGnIMZ8G+Qb3xemQylaPw/ssw9xNnVdEfLavf9yv
 F1LaHllZF+dfYcRIoFk6ZBexRq9Y1tggT+wuZrAmSlAh+QD1TmAuHKPGTFUKwRfIYDlk8O897
 BQPqd5r7ye0YYwEe+d6lnlxwsp1JcfijvpL/H7CPWNuynGrxM8ROEeEqrc2pmTXkSa+jMP/gK
 EmoJB32NtgOaeKnHM/XSdWjrh+s4BmJg7/RBwZUh51M3NblS9XW25awLrbnFkOrZR7z4IdNW4
 Cq2Y7yOoZMrsTFCVC9iyI9zuxY++4o/OxAA8VZ+t683LFb5VnkLkEJIIPo+At0VZIQi6+pm8k
 l/K5Btmvkre8Zc2XhIBk6eEaVzTm8RZaidjxQBMzGpTkQV+SVkGRPwmaviPvLwuYgCnTNTl/U
 5ZmYoJ9o1t3E+I5U7BdJqYn2eN2bp6VXaLrPdjCvUjizSVSiCDXvoWrMRlJUjD8f3pC2upO45
 /bpCiFKXFNgJKmOuKqHp1oEOeoCTE/5NoIzH11D47Nud2HOZpPocISO0w5S4J0b0D2/VZRw69
 ncrMkzpKOweq0SDhMw7O8a4sjvIrHq22faVPkk/jc7gfMi64ybGgQc2F6KJjvSt4C3s5paWl+
 7U+ygGCviawpQ2/vfYrmBCH+DvfRUVN6wiFAweCnEXeb3QH4auZGllXcG0goq848H/s8MZzG+
 2wHNXWLeFtxb/bY+UAlpFTllYVorDl8M+Z3CriDPMp0Z78tFO0BLbp9sdGg8uECZ5TwcdECyG
 6UziBm0Q6WBeltzfYABhBXfR14kOWQsEIEODSDz1UUL/m75GNuwBT2EdIOHdBE1znYtcopeZA
 pq+hTqCPw043C7JL23zDWgInx6wRf3o/6DvIOzmB3ibvktdDNuk4aduKSb5eNdOnuQ9rSEbom
 ADzoxLHv9RXMN+tUCDSh1pFq15bJGmR+d+EkEQtylvq7PtrHJ73mjZ6Cs1idCEEfQzL/6AoCF
 hyAKICbSaboQUSQa0rcPY22JySheptfQBGqRKLxpsYmmWIqqO5SeIPv7YGci9GUtwCbLpPLFh
 lamJdrB72J1HbsEGkfcWoli49axmfwrAitPWbTIXil9x2u1AF+XG36TBmMfo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Dec 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > As I said elsewhere, if Git for Windows' FSCache hack is the only thin=
g
> > that is broken by this patch series, in light of the bugs that it _doe=
s_
> > fix I would rather adjust the FSCache patches to accommodate v2.
>
> With "FSCache hack", do you refer to the "d_name is a pointer to
> elsewhere" thing?

Yes.

> If so, I too very much appreciate the direction you are suggesting.
> Seeing that these three patches essentially are the same as three (1/8,
> 3/8 and 4/8) from the v2, I'd keep all the 8 patches from v2 in my tree
> for now.
>
> Thanks, both.

Thank you,
Dscho
