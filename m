Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF6320248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCCRJg (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:09:36 -0500
Received: from mout.gmx.net ([212.227.17.21]:37025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfCCRJg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:09:36 -0500
Received: from [10.49.202.116] ([95.208.58.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZU7V-1gfvzZ04wn-00LDva; Sun, 03
 Mar 2019 18:09:28 +0100
Date:   Sun, 3 Mar 2019 18:09:26 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH 1/4] built-in rebase: no need to check out `onto` twice
In-Reply-To: <xmqqef7o3fl8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903031808380.45@tvgsbejvaqbjf.bet>
References: <pull.153.git.gitgitgadget@gmail.com> <2d99429387ba63526efe233bbefe851c5d556fdc.1551367664.git.gitgitgadget@gmail.com> <7b1282bf-4b94-5725-00df-2dc63eaa93f0@gmail.com> <nycvar.QRO.7.76.6.1903011415220.41@tvgsbejvaqbjf.bet>
 <22878dbe-d9f0-4737-3a49-ece695c2d0c2@gmail.com> <xmqqef7o3fl8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GwBFiOYV6HvLtezYbeuSidyfpCvrZYLwXlzYnDTzlNeJCwnLTes
 3F1aPm+3+oirKXC1aBTqI0sROaPzs4+OkeKsldMBuYvreGWHngL1m6UiifIyiPZzaP+8JC1
 LONOqlV/i0o2LdTMLR0ijj0YHCa0Y6VfmyhjlhvgsTLX1WsnhdQWtKQplZimrpleU2qD8/Q
 aYH6khnoV+/Tzf8TBSrhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tiXO0hp/szM=:cnSGiLjV5apHZPLGA03lgq
 eyCUF2DkLnGiopY1hrc2XZdWxx7pkkdvGO3wggZ2RFykOPMQt0w1f6UYxbtDYT/Qp/GnXaBra
 D9U9Xp+wXPkLb1QQ5mrzLr/ixnATNrQOY0Sa5Di/E7MVGByQJuY9vrRqqjBUT9k2mA91iyQbE
 e6F2vPG1d5vTJ8jRXRL+98/a6gj3+s/aftTjIpC4NKQnxEACEVxTVmhEVrTMEsjOoGY9Acw7j
 SoJtnAHqUlq6+fFjVdtxxu6l/yg6vVL5Ki+sQZN6mDBPAAZXMLa6RFbIPTX3zhUqt+ye+gZjr
 8zNOvL1ZBk57j3MDqjv11OnZiGTvtmAavWK8Kr+RXl70/3HTaa93EfKutz2uVz8sYaTFyUfhA
 IHW/Q3+R9uKG7w0ILNR2Xc6DTd3y6M8w2vebzC0V+h4U5eI9nnUFhNvzV+2Tf2kxQCm8+DGWv
 rHssY0W39oIviDWWy9G3YFR2AeufnGp64N5w9KMuJS7lYpe18r9tLT2FwOQ2LWFA6/by7YNBl
 SgETZiPWz/Cg+Ox9WSEETUZSyzFvDd0iwkQYa8wGh3Te9NdXmNjP4Ia1RbsttFYoHLjZF8Oft
 xgcxK3Ti/vhEgQH3XlZnDNooq7wzGVts3ZIUo4KycAv5Y4GllbHoouI3wBTUEQR1jpgQuMLr9
 iLOscOgByfQL918CA45eUhHmF2VE+H10fRbAgyuNBX1dhc6lMNDqJTHx0f4fZlkMPFAHlO+dF
 wB/Yf/0FJ3/k4Z1DkF/QWqrwRAx7tnbUPulpgbI4A+Zo6feOePulSYLv7XuUSV2V+JaOXsdu/
 wnlG9kMo4YSanwuHR4eZKITUYvZERACbkzjXh7wPW475zhbTCO1RJgPZZPUnwRx8e3zLNE9At
 JuHMtVYP3Etv9sQX2DLRY3nnaQlN05l7vutOO7T/7yyPEDSGDhJs2vuiXURgCO0Tkn/3hTs33
 pmLPs2n/Q9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 3 Mar 2019, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > Thanks for explaining, it all makes sense to me now
> 
> It would be necessary to make sure that it all makes sense to all
> future readers.  Are they patches good enough as-is for that, or do
> they need some updates before I take a look at them to pick up?

As you frequently say: if a reviewer gets puzzled, it is often a good
indicator that the commit message needs to be improved. I did exactly that
and will send out the next iteration in a minute.

Ciao,
Dscho
