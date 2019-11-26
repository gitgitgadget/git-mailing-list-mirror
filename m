Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8AC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C3820678
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Z2rcjt9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfKZWXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:23:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:53629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfKZWXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 17:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574806982;
        bh=YLrt2yuxE8ZHspvqchzCSXq+JwqduskC7AwVPpEMg/s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z2rcjt9xfrKTwIXZ7yvCOip+YyMVIKQiXWpQ9uZniSo/A3fJbov7fiJhmg0wrpMOb
         n2jmx5wPGYyDDzXhMQrXcQEEm2A3m0U4qA2IJah3+HexJOmpuvGqxLXwN8MTN8YDk2
         So9+CA8dDjF2Qk56oxppcbAur1a1Jd/+9T5ZU0KI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1i4m981S9Q-00mct4; Tue, 26
 Nov 2019 23:23:02 +0100
Date:   Tue, 26 Nov 2019 23:22:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
In-Reply-To: <20191126215648.GA18872@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1911262322130.31080@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet> <20191113011020.GB20431@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet> <20191114074117.GB17186@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet> <20191121105414.GA16238@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet> <20191125143023.GF494@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911262151590.31080@tvgsbejvaqbjf.bet>
 <20191126215648.GA18872@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4j5ZZJ2yZiZkXwJftMMBhQ2FsN8oPAcaiC+E6RqQuEQnL3Uvcq7
 r5IDTvo7KFzBUhe9ZZU8L1u9n/2lEHS/ZNnqniIHrktxx3FEmMrm/xnNiQtd5OySDLd2R0j
 h9qMuT3MUQe2NvFkhCoWjMbaV2emPo4ubrdU55RgI1L4FKF8qQ/GkVQec+snnoYkC7HUUie
 a9JEUy4ZlFUoD92t5tm/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WGGvRKj1scs=:zOFxYQZ2OzR6ALLioEinIS
 6ZIaJq9hxZzkFQquQlW11RmNe6RQMEj3KhJ32BiE9MOmSV6sNjdzUi8Dtavxph+BAenvTsLmS
 55PClWIvfugO4rNccjwhyvgQSBhH4csRex0kEkRCaI0EDVbSb2anTYLxaZXh2bCTd1IQ1GFmS
 wYGl2yWLVu3V1ohnWOCys0bbFb1Ssg+Z9hLJEKlrnylyZrpl4K772nxAclWwdaMmPL6BZebO3
 KsJv7/SbwObhC9EC1gYbKiYJsA0cHnSKQpk/SsTEc7n/DT2RkkuWpgGc91A8J8fWOL9vv5qtS
 Y1/z+bICO/A8tyziKe5hy4A+DWVB9jQB0ARwtGsAQQ672u540pTOj6FM5QnAhgnQ2p+/cH2TH
 g38/4FUy31t0YhTu9nFa2SvNLlbtJpVbPp+2xikCClVaZ3rqbYI7tRwz6BPVRB+beS2a7MryV
 EN7+LMlUanwJndcM71Bg8Olc6148UJ/erVMTS+VbT3b1gDdQfyqqSQYBTFw9jEoFSVJxQdvLD
 XogXb2OFqItRYVQD7Oaa369sYj6Mwd3yFC9mG1ktuWKqDoBggikOd7/ki6izhlmz4wApHQCmK
 4OzOtw+LbQs++oOXVSjjbdyJe6TZBbh9/rOWTXVvxWacShpfdSS1g6Vms1SfWedt6OPuYXXvx
 Rl1+DeDUlN0exeQQI3tF/xqRHETZEkzjRMEIHI3QR5bmCQb0CYZNE71z792fP81eR5cgiXgNn
 3QJ+uz5BItvZDtbPCE6Hjr9gE56zGeqTnhkRJbMrnYsJ1CBr/n+kv24zqnAgfEPMbo4j72Izd
 LNKAbBTyE13S+XiEMfwWARpdC8DnqpZ+J6ipv7XZk4+DNdT8EMxiU/TmJ50c2zU2uVYTlYHoN
 fiNnZmm2FXfEiio3eetF5Mk1X+WMVbn0SGwEHf1i6zu7LK7GZHg1eLmM2U8bky4rpFXMInt+T
 Xr7g7xGfNwjGYeGfvk8Rw0Q4wzPKyXuqhujfttCNmH405vgHzzQ6iGvDpdRnt5hQajnQo4/r8
 O9AUO+yKzY2H9jHqF8awEq+zdP3wSPwSHJfBIj3vnwMlPXLm33FSKn7EHaX7foY/hYu2GTFgD
 kkd6gkVvV+meLuuxgSMJX5+OY2lYCfZIuepUAzwly9Meqfd0wR0OOxW3NbGo8tcFLg8IoBPd/
 9tMhFyspGYuXIHKS1scJ+HMpVSPZUW/pThcln/5oPgxMytO54Btj5FxjOTqo5cIhQiXlfNEcU
 0RG4e0jrE2CSmzRdxVQllq6ZpeShwtSO4MIGz90qDvYe9jQLLcSbYBJmYz1A=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 26 Nov 2019, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > The biggest obstacle is that at least one of those Pipelines requires
> > access to a clone of public-inbox.org/git, and cloning that is rather
> > expensive. Even a shallow fetch would be super expensive, by virtue of
> > _all_ the mails being blobs reachable from the tip commit's tree.
>
> Fwiw, lore.kernel.org/git/$EPOCH.git ought to be somewhat cheaper,
> but it's a different (more scalable) format which requires SQLite:
>
> 	https://public-inbox.org/public-inbox-v2-format.html

Is this incremental? GitGitGadget needs this to be incremental ;-)

Ciao,
Dscho
