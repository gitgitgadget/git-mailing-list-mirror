Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA46E20958
	for <e@80x24.org>; Sat,  1 Apr 2017 12:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdDAMNO (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 08:13:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:64434 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbdDAMNN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 08:13:13 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1FAK-1c1DMt3zWi-00tDC8; Sat, 01
 Apr 2017 14:12:48 +0200
Date:   Sat, 1 Apr 2017 14:12:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kevin Willford <kewillf@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] name-hash: fix buffer overrun
In-Reply-To: <xmqqh928wyu7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704011411460.3742@virtualbox>
References: <20170331173214.47514-1-git@jeffhostetler.com>        <20170331173214.47514-2-git@jeffhostetler.com>        <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com>        <xmqqy3vlw3f9.fsf@gitster.mtv.corp.google.com>       
 <CAPc5daWU5XDVNiYk_pTFk_qziuDr6W2XDHXXH-0oR49_KiCUYA@mail.gmail.com> <xmqqh928wyu7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g+RL1h+Qv222f6QYRJChS2ILMC4dll8adjtIPUqTQC+kQbbiJF/
 BSUstR09HJBg6IJlE0ck4azqeQP7/AxyNrpQF7QOfMDkzkFKVrAuopw00VZKdZGEzXOmtws
 pp6VX3a+/PoEl48N4zYI6UI6edOmZ5KFZ0j1FH70qrtVS0MDmpgjDTf6H+Y9vF+Sx9n2ZJH
 XWsA5OapcCuPjR0/+b4sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dk5I+GCOZ4c=:J1vF0E2S9scRZ+sWr+caNV
 yMVLKzzUD/4niXIVL+jdRuVO58nE8xn7+75JR2jW+rqPdkNV0GcyFBxrm7OpwFZMy7nxTcUH+
 aFsOawQHKczGjHr1nSG92mUS0+wn48QC4BNS6MYgutgwTt9Bii6RzK6PUdm0EHqBOhS6FBqIc
 utH7qUqbRa+aQ9qnouR2t6Sm+G9qKviTvqc87+6B2ac3Zkfh7b0g/8UG2oxwfMLOIRgh7LFGR
 QdfMvrkwIbls4ViENST7FzNuJzIyBMRdlXp3Vu9737Eck9x+Bqn2YFYedB39nJrLrXk/rdbZw
 o86WwoF1R+sRojnz/WlA3MH13LqgNr/CSoIa3ng9tGGOovwp6U4X/8ET1N6qWGxfAT1WLwmPI
 vy//Qx/XYZui6tAJbgAxGr3CXDGuGqjMST8lldnDXOquW9w8QG184aqmoGoYbuLO4lkaMEMAb
 QAsDDk9hxMYR6jDtwzLdutmk60q8/e9WVnAGYEh5SGALdxadjDV9Cp8EoTWnpIQo2/9uM6yZR
 +YIqxagyjHylclXUo4S80My0q4G3NWgt6xFpVV4yD5THswKd/jZ2t+My6Fj9CrvXRuofK4Yu5
 59qTH9mvoJ1ME4NutBDeN/PF2QA85JApurylKgu9lyP9awM7KDojNahCdo0+Po1G/oeCvoe7Z
 j3w1qxtbfFNzLVLy09Y5M4s2pnIx7+IiA+WRYxWyJGBKEIjhuATK0+dwmE2g5eozNuTwrVVF5
 jt7WMzitV4WsKhfZ3GDe4PBioYqcCVyZnGHGXuUXUFwFUer5gGo1hpVAY/FpI0/eZiyKSIi4P
 ZDFykVi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 31 Mar 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Ah, of course. Avoid GNUism to spell HT as "\t" in a sed script.

Sorry about that, I suggested this snippet to Kevin, it is my fault for
not remembering BSD sed's idiosynchracies.

Ciao,
Johannes

P.S.: enjoy your time off!
