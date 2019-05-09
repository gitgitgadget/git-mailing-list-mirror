Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD0F1F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEIOHA (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:07:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:47723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfEIOHA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557410799;
        bh=xB0bdVVMnCASNQKE5oIAcNxepyXKq3vKq98bDkpfPVM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LUyN2QHm+ooNXIzR7VFWD+Oho9JBV93NOaEqsVR813f0NhZT4U+rngC50Br6Emb+Y
         zwbls04XKZoy7VRyQWdOmhZYLE1hHsk7C7HdSlESbpFir2uozlgtTT8lAciO+SYgXp
         prklDAZBhROhZIz/ar6OA/k5VC4ibgWj+Fs4FrCM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1gUH9x1pru-00vtrM; Thu, 09
 May 2019 16:06:39 +0200
Date:   Thu, 9 May 2019 16:06:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] archive-tar: mark RECORDSIZE/BLOCKSIZE as
 unsigned
In-Reply-To: <20190508230420.GC19990@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905091605070.44@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <pull.145.v2.git.gitgitgadget@gmail.com> <ac2b2488a1b42b3caf8a84594c48eca796748e59.1556321244.git.gitgitgadget@gmail.com> <d960966d-a7d4-dc3e-ca0a-70e9e5d1abf3@web.de> <nycvar.QRO.7.76.6.1905081334260.44@tvgsbejvaqbjf.bet>
 <20190508230420.GC19990@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-658341196-1557410799=:44"
X-Provags-ID: V03:K1:Qq/PBYbblNGqzdOUohrcbuBUuWnh2SX5OyPYeP0h+pOgFm7M7gY
 Rc/UMgicFNeVWApdCoktgxdvaHWtve4F5dfr05S8L/Wqj+v4NsaqQ8GHx2CWKvOvi2PUMI3
 RQuCHuPz+lXpGyjSFmNeJXOApDwu2UTlbdsuRcupBtBb7kX7JgKi3wrR3WiZ8QgIqxiK07/
 hBKs4BzwU1wCGvvKSzGcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V1+Pwm2in/U=:zohms56s2WxwF5CIpurlKr
 QAFcBVx80x/BPWVOUYD2/nZdZqm5XnaEFT7JWvRDseAFEGNH+yg7yjBhtw+63G97vNsgczoQ4
 SDAjkYlY9ztP5N2iSdo974J7J1cu0D4mvRYkSByF4awsZOw7AF+dWr0kdETf+To9ePv9nceQ/
 5yBtVgEP23gioJWhIG8UlWVyYlYRPg6UpOnnEjja+1oDfz0eJ9++lgZ1i6a2OQCxdGND2l9D+
 xQJfUP+Uc/4gNfmyvg41nmkQd/rDgL/Ngx6n/eTG4gimtuANsR92MiZZhYGNIR3yxjD0fE0Ao
 g9kJ+1VVRZxtSktD0SVoL1QIF7uNqCOx/YBqbVYNlb5/vFIhgoaLqn8u/ZpihNzFLno/aBFZm
 InuJdQds7PNc0IfVk3YZABhZofW08AWvUB83hvwWJuWrgueSye+WAfnfqcoDsmhpHYYsBLs/T
 adPB8H31r8ahQXFExr08bYYqSGVWtUYjaIIASB3SzpVyzbOYB6e/nhNxH84x4aFbNCl+nTueZ
 /hfTeTDt1B7nBAON3dTGA9qGWVvx/jv2ve+vmdJ/emBFYNoKfXiqRI1ZKD/QEM14qSk2PkEjn
 ABln3r4+ZPLwqq4weJEYndbkTDLx5hUAtO+BGKroil3bRyqCBQEN9Y4eOi+pFSPG0kjgGCwhB
 lWghIGUc1FhdYdW3XTkhzR7X14THihXazc1Z2DMXTGLvEaNLJcV5XV4I4bYNFCOFG8WnvMES0
 IpYgvf+uMvZYH6602WdRC61FfX7R0pGADm7Bqvgz93/MOexK6gbpGds0YPDGnX2XdC9c8/77c
 xOyF6XYzb9Tq4K7n2U7lfcGA7rVxriJshees/79P03zNUG0gqWeJjbA0rifPKSOFl8jjO88NN
 gVF4sXwPUtX4bx04fXQ05Ul4g6DhcNRDzxk/3V9WQV86OJGB7a3aN7i2tdHK8kPSTbZL2dEiz
 OQ5d0JyI1tQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-658341196-1557410799=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Wed, 8 May 2019, Jeff King wrote:

> On Wed, May 08, 2019 at 01:45:25PM +0200, Johannes Schindelin wrote:
>
> > Hi Ren=C3=A9,
> >
> > On Thu, 2 May 2019, Ren=C3=A9 Scharfe wrote:
> >
> > > Am 27.04.19 um 01:27 schrieb Johannes Schindelin via GitGitGadget:
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >
> > > > They really are unsigned, and we are using e.g. BLOCKSIZE as `size=
_t`
> > > > parameter to pass to `write_or_die()`.
> > >
> > > True, but the compiler converts that value correctly to size_t witho=
ut
> > > complaint already, doesn't it?  What am I missing?
> >
> > Are you talking about a specific compiler? It sure sounds as if you di=
d.
> >
> > I really do not want to fall into the "you can build Git with *any*
> > compiler, as long as that compiler happens to be GCC, oh, and as long =
it
> > is version X" trap.
>
> I don't this this has anything to do with gcc. The point is that we
> already have this line:
>
>   write_or_die(fd, buf, BLOCKSIZE);
>
> which does not cast and nobody has complained,

I mistook this part of your reply in
https://public-inbox.org/git/20190413013451.GB2040@sigill.intra.peff.net/
as precisely such a complaint:

	BLOCKSIZE is a constant. Should we be defining it with a "U" in
	the first place?

Thanks,
Dscho

> even though the signed
> constant is implicitly converted to a size_t. So adding another line
> like:
>
>   gzwrite(gzip, block, BLOCKSIZE);
>
> would in theory be treated the same (gzwrite takes an "unsigned").
>
> The conversion from signed to unsigned is well defined in ANSI C, and
> I'd expect a compiler to either complain about neither or both (and the
> latter probably with warnings like -Wconversion cranked up).
>
> But of course if you have data otherwise, we can revise that. Was the
> cast added out of caution, or to squelch a compiler warning?
>
> -Peff
>

--8323328-658341196-1557410799=:44--
