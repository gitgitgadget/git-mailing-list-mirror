Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ED661FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbdJ3Mik (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:38:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:55827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751988AbdJ3Mi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:38:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MO7Ca-1e3d143nUa-005ajX; Mon, 30
 Oct 2017 13:38:11 +0100
Date:   Mon, 30 Oct 2017 13:37:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
In-Reply-To: <xmqqo9op8o35.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710301337430.6482@virtualbox>
References: <20170926235627.79606-1-bmwill@google.com>        <20171003201507.3589-1-bmwill@google.com>        <20171003201507.3589-11-bmwill@google.com>        <20171003214206.GY19555@aiede.mtv.corp.google.com>        <20171016171812.GA4487@google.com>   
     <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>        <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>        <alpine.DEB.2.21.1.1710251437090.6482@virtualbox>        <CAGZ79kYTYg09A7UbhvyiT0QmRQG5ZJV6v1iaQBNCZY8RTj300A@mail.gmail.com>
        <20171025163243.xmm7szrkwgblpgcc@aiede.mtv.corp.google.com> <xmqqo9op8o35.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:px9EOxh9uTU+/lJL6DhoNWZEY3XLkzroCpOuqpw1sIm+CExB4kw
 Af0A1U1Mzcqp7JBW/285CtGU1VWOaMH2SbDK+nzFOBTzLc6cNlt8hk0XjT3SRIz+/uHZCDJ
 NTobOnZwuZ3OmlthmWmfBgr1knVEYRIVh0piJ4uKd3s5A7wjqMj85K5b69Pwirw/ZVAdz9s
 iBG3ydeoc5vgWgsja0DQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UJwDZ4EJY3o=:sXilg7B8iUdWjWQiQRO3dV
 3Crd0VJMBEDyzq5ZwnYeyfHe+ik+wm91cOFFc2Y2mNnp88aYSlGNwDHE/8nzaMs772uQ2RGz0
 Nt2SKiPw5ayo+QPfnZhamrA2hZezjPFHnyCRjLWASBiqNTIe7aXf9kz1AY/Rh/0KyVJz0aYKU
 eJnS9liPRH5/sQMJiitICYNTu8VMf6MJrfs6KP71RdghbccVKa+6yCcbtr08kOcNI43o4TWM9
 WY4mv5uEtBwdJ/tjT6oV2ObD7cyoo547oorkBniVHa3DwEl9JIx+P92UswKG22XrQM/HKsgLy
 XX2k0l42+sRJHW5x3zvo7ZRZSe/o5G6XepSzo7382AE35Ze401AQziV3fVTZ0Uj86/hrYORIU
 u3m2ulpPV0IHxaHu8+YU3Q1/0FVl0w/WSDcYuyBC5sg3ke8NT/6xXKF4QO0vU9nbgBBD3ysK0
 k4adywLaMKfJFMuzeEKXYdZSl4w28wakALlaTP+7pYK3MgKzL7AiXwjcx0Ga2J+1XwAryaTn+
 vH46Tojxdd6qQfdlJQO8VDbgvAMLUuTtWT804AfH727t6HCTq9kOh5Vt2N2OpaisGXdVHDk5V
 aTIJHN3deqSGFiDAXujBOH5yUG2l3WRN9YtgEJJxr91N17syTw0RwZXv0cCBpqo+rk8NhXsal
 phn9GY+3fMn4hc9i4ar0loh7B8IbI7GbvHkyHFvapwuxeaqQgDcTqSXCMmi86HcvjRgqdgFx2
 JBYZ5aZD8ThcuhArx/U789zC5/QJEbCUgCpWmvAIWqH40eo469USy8+r/HyYHqF1jH5LX3wmS
 IA8mOhsKrPg9q2eKau/qg6I8imgXkBk2QoXOlecZGDYQGmdKmdQuoYkKW9cmYMXSExmsMGP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 30 Oct 2017, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > I have other changes to make when rerolling anyway (from Junio's
> > review), so no need for a followup patch.  Will fix this in the
> > reroll today.
> >
> > Thanks for catching and diagnosing this, Dscho!
> 
> In the meantime, I've queued this from Dscho; please take it into
> consideration when you reroll.
> 
> Thanks.

Thanks for sending it out as an email.

Ciao,
Dscho
