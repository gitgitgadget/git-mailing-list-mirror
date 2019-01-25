Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238981F453
	for <e@80x24.org>; Fri, 25 Jan 2019 19:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfAYTMl (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 14:12:41 -0500
Received: from mout.web.de ([212.227.17.12]:50103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfAYTMl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 14:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548443547;
        bh=QtRvAQxEZ4ks3p1GlrbOFEeAcwhpNPrrMbae1VF044k=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ao28keHuKinEFMbx0G1ojZR5bepKTET1TPybvlARQQRSL1BgKuj/hrqyMco6qH8nG
         UMcNE5xkw82jLEM497kOigi7DmCLw+87kbLVeVCRr1Settbz9U8bfY/V7PE/67b7Yq
         pQRmluTZCJjIQwCKtzgpncFrojg6QEBQW1XuKStY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlFLm-1hMzLp0OD0-00b64v; Fri, 25
 Jan 2019 20:12:27 +0100
Date:   Fri, 25 Jan 2019 19:12:24 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        zhiyou.jx@alibaba-inc.com,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH/RFC v2 1/1] test-lint: Only use only sed [-n] [-e
 command] [-f command_file]
Message-ID: <20190125191224.pgugeqskuhzi34hv@tb-raspi4>
References: <20190110115704.GL4673@szeder.dev>
 <20190120075350.5950-1-tboegi@web.de>
 <xmqqo988fpag.fsf@gitster-ct.c.googlers.com>
 <799c5063-b0a7-df6b-6f86-a92b8b6d679b@web.de>
 <CAPig+cSDnhvVCDE15koO9M1A8TBg+Mbn2OBsfXVvshmRyybApw@mail.gmail.com>
 <f7871d8b-a19b-5816-120b-ce583debc4ca@web.de>
 <xmqq8szbcl9q.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqq8szbcl9q.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:1MiweHzxC03uO7Gm7dLyXYm67B67CabnrqrAXaa0EpZhMkl8z3M
 JnPQXEbmWFl0AO/d1rxdcXJetECc5OWSRneOZ2J5BL+hKmUqNodf9y383o41gAwekBB1BTU
 9lWki4lEsxb27PqD/Q8SitKChfoTMLPRiNvYScrQ+DaU7tH+Q3ajpawy6/ZQbvO374PtUxY
 oLCjgLzFM3YTUcZVUo7Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kj7m+/l9ZVY=:dcUXLoDtjlcoa2KyYp2KzO
 VXTN0zGf5brM+SV+XGvIPOGhD34zwitiMsij2pNq62EHgDlvfOJfiRrLrt3HcgiVN0HvXDPnw
 Wy8I3KMZEd/BbXotpHK5MkLc1qvQPMxowaTcVTACfPk99pFaWZP+fRSvBE1N1ADyqX6Q7V1GB
 DxYBvTQ0XwkjpU7LgJxr2UkPi7YV1YL9f8TqOa1UUFAl4ECyzW/L1/t9hFjZ+sE9LPjbzMhcm
 ptSfXILAj7d1ho7o6NDXWEvEtSr1wtML9eQjRk9139uM86dT4gPTKlpyjhIzGOuJIX3AA5/I/
 GxnVm2hSOEkntBvMxjc8AioMorK/jTOvrCxSLc3svODrbWX8L+7369dNXud82ujAiFL2UQA4R
 Mv0ymWxQUt7NLqppGbyR0se2snaU9CEzg7iJb0NM1BBthyJfmwEmzuxFsW2Zb3OYw04iHWMHx
 PkIJYBMwTAsNHURInVuFzdKr4XBAT8niTztM2KRyy+R1GRj5HknIB9bpe7+bFwgnq9c/wDfxJ
 FsHmgmSnCO9KmdrQjStFxQWpUBeCj6ItKKg6ZglxLANewbcpfxZFzDLwqbFlbweLCnTCPB4yD
 Hi2K3fmQwrBznSrKyowgMrDv8l9qYWcgfdt6IL9K0ehP6LqiaOLCLflOVQWzUrZLL2mymx19e
 mEOvbnwIdH3qbqkjcknHtkb0YKRr64qoltw5sp5+zWmZcojuVK7u/H6Gv0MFqjgnZPVFRBu/k
 BkNaCMnoecO8hWbpXfqjaZgE4cNapyxg/KPJVx+VtuzlxTq6uTcOz4e/iaH6jhQNENOWH9u/S
 HU/WaSRm+uYouzNzp7vQPLlIg/FUtsYkFK0kdVLF4A4CDcDb9GboRFttojILr2KinybAAZ6t/
 9/3Bdcnyrplz/VJIH06NDbCDvIJKQlhsZLSVWGbrZR1tSmMDOxWOdv9PLW8KRe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 23, 2019 at 09:54:25AM -0800, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> >> I'd still prefer to see a more terse[1] (and not capitalized) message
> >> to be consistent with existing error messages and to keep the reporte=
d
> >> errors more compact overall to make them easier to digest[2,3]:
> >>
> >>     err 'sed option not portable (use only -n, -e, -f)'
> >
> > That's OK for me - lets see if there are more comments.
>
> Thanks, both.  Eric's proposed message looks good to me too.

Do you want to ammend the patch locally ?
Or should I send a new version ?
