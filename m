Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58FC91F461
	for <e@80x24.org>; Fri, 17 May 2019 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfEQSyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 14:54:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:43533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfEQSyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 14:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558119234;
        bh=cnvKINUsFxEgx18x3w1XO/iPXGj7FUJ+020LscPwJNA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ffR4DgEg5lq8+DrF3YH0dE2OPTsi65msTydg1g62a0ovPIOSMW4ukja7AXS1PhPkA
         x38hPHJvUPv0OuywtQIGTpYnFvlzfxK9ALyzU0ON8J1dECtUI/cg1G2+XUxRGUK3MN
         V2RvfrHbCTZobiqxO8WjVvDMLaLyLjIUt0UyZ6NQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ldspr-1h0ee11XH9-00j607; Fri, 17
 May 2019 20:53:54 +0200
Date:   Fri, 17 May 2019 20:54:02 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
In-Reply-To: <xmqq36lf5e7a.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905172051560.46@tvgsbejvaqbjf.bet>
References: <pull.192.git.gitgitgadget@gmail.com> <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com> <xmqqo9469buw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905141454510.44@tvgsbejvaqbjf.bet> <20190514144305.GA28530@sigill.intra.peff.net>
 <xmqqa7fo8pdg.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905151234370.44@tvgsbejvaqbjf.bet> <xmqq36lf5e7a.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Y0csuBzbhXE8gLARf4Z9ckDr66kSqQ5eaWCN1bpMXahA/xeqZUV
 ypS2NF8iH0Ym+wVBCVhd2TYrpcInGIjmoAMhzAdzP//c1t6tHDGXEA93MqWFyMJ2ogsVNZb
 ooBvNK7yIvI358Lf3Qa2DeHSXVF+doHOL1WzREGodzle8qCDw2dls7YT9/XqhJPe6txlW3l
 cmGM7cwamxEpJ8JQb5tOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4WcZ5pe24CY=:aeUL4NLHpTOcx8FTI4AQVL
 zU99xKa4iKA0JioOfbMH5KbTWqjkVHv2KdUH9zkRVBQAtrTBadbKE+eJ5ONuYOAUjSyakHs4Y
 Wyo2SIwrBOnrCaTzBWaqiP1he0G5KJDUIIGMa6XBphiJvdjyB5DUZO7pAiVrobgV61CQDcQV9
 b9XMyPX+RGEYp3/yjZQwDlT2BluMTNFoZf90x0y4c2KqSdqJIYU3aH8vhC4CHL5ZOStfdrBEX
 GNjTh/w8AKRWh0OrglIOLgxTe9InSqnz7y19PllfoY7vCDHh+jbIg2Us0Ga5R2iBJyexe9p+k
 0zHBMsE6pq0L7J0Hts1Jo+Nk30LVEiXpOUhctLdGNz8fJhjWiaj9fBUrNsu3s5rjF2ityHmpm
 EpCLF9jrf5Nm/tK7xxD5Kfu4AvjYdY8Pl4O0hkH0m/bfc4TzVzTdLWSNkLyezdkaTMdfUQ791
 GhITXDtTkyiTmMAkv2bFWk/MuSNB2W8Tvwy1SB+aS8ZViBo4K7crayAJWtzHWoiWJHLYpmA6N
 oGeo9KcPb/ranaVZIhGzgUf3i7eX8Kzm5d5XYNvX+8Cf26E0ghYfAm+OV487K37UkL8/we8xU
 sxV5DoMBNpDEzviEzci6jm3Z5eAR94wQuH/Qtl0cRxz6kwTP9rzxeTTYxYkZKFY3wZ7JDmJf7
 woF1JP7hFq+Ef+JGtuhWVCWkju1IM1LIm43W7Aan/NaldYZ0APAJ8AlAGMqwSu5F6jG0JIyAM
 u1wERQQNV/OGHE2UK5NjeD4lT1HvhoxXSZRCEmxxKbL63y9vyqRTgTUGpzlfghZhkwt/YBTsD
 SdYIwmpmuHGr48Uk3IWlBM4c/tI9ZBYxQ02R3h8oLERx/lImX50+KPKmc6sehN1hPe7IJrqI/
 ibqPtZegpuuNLjDH1I9HMsCzZHRDTVW2/oavAHwYO7mwjwNjf41mov89Dw9sMiLDFiXu7Rkdv
 vzmVebACqpKMvTTraYE/jISRjyYvjddov6+DIAB+EP3Q45nnbwq71
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 16 May 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> lacked the "const" for that reason, but apparently some compilers
> >> complain about the parameter type mismatch.
> >
> > We could be more explicit, as we know exactly that it is MS Visual C 2=
017
> > that is complaining.
>
> We could be, but I do not see a point of shaming one particular
> compiler vendor.

I agree that there is no point in shaming (in fact, there is a lot of harm
in shaming, everybody who intentionally shames other people needs to have
a look at https://psycnet.apa.org/doiLanding?doi=3D10.1037%2Femo0000542 to
find out what harm they are doing).

That is why I suggested to be more explicit, not to shame.

Of course, that illustrates that I apparently think a lot differently
about this issue: in contrast to you, I do not think that MSVC does a
particularly bad thing here, even if it dares disagree with GCC. :-)

Ciao,
Dscho
