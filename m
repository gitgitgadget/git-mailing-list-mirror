Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1D72035F
	for <e@80x24.org>; Wed, 31 Aug 2016 08:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759526AbcHaIVy (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:21:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:64538 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759522AbcHaIVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:21:51 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Me8RK-1bSQMh2BkU-00PsUb; Wed, 31 Aug 2016 10:20:57
 +0200
Date:   Wed, 31 Aug 2016 10:20:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 05/22] sequencer: allow the sequencer to take custody of
 malloc()ed data
In-Reply-To: <xmqqk2ey3yha.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608311019290.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <e4e7eab3d0610faa9d3173a585902e50128d8e15.1472457609.git.johannes.schindelin@gmx.de> <733a899a-470b-79b3-b059-b38313a7057d@gmail.com> <alpine.DEB.2.20.1608300915470.129229@virtualbox>
 <e1cebf74-1592-5ddc-9979-eeffcbf4d788@gmail.com> <xmqqk2ey3yha.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-698130740-1472631657=:129229"
X-Provags-ID: V03:K0:827XkEN9jeE+APLI6XiTCWRWr1/eMFLrtIMMLG3pGaiNc7z43VA
 l8L+dqM87khcYxxcLXY0HNdWvlVKf+MASOv3eCfzYyM+bzrluhJ5G/k1iqsHpV8TrjbeUh0
 1gCJMRjkdqGpA+oMcrxPf0SxjqLoXqPfkN3ETzYJU3QsrD3XiJ9srxBKUqrrdHdMV1ZzzzL
 p0IyEpGXE99H2MiZG2PNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yuxdr1DxRTY=:yNyzuklA9TMmNhf4uuwWRx
 0IZSDMHtQR/Kt8vd6Z52MM6MQTNqySp/+IG5bLkm0rGx57BYoKt27L7/TdDG1rXGSdI2nOveA
 8XgcFWDUH4+LQUj+U+PmSU1BXn7dVhUHVShbMLb06OIw2xL2bET/pPkS1hIssSpmcn+A+kxv3
 08y7NlpiWJCuIQnk1trFmN6LcIy8o1xZprJj06c35xSPmwS/J38MNTRvaKHYwwKQCcoy7OhKQ
 1TgFvc1L8Z9ou/bRULUvnhPoFhpH+oNFo/rxPfY5eKkzEY5iHcFUdTznCmNlX9XrTqBpnM5oF
 gKIqc8u0Wpi0hnv3A4MervQyXe1aWLrh7BDEX2pv3TXXeHeqZhZUEYJu9jxty4Y2q/abt0o/e
 yxdlWzGXy2TdCejJbxZFlDJjuleQN/Hf6kbLy6KxCRKrooPQGvZwzFmeva0T2iVm8FDsZoa46
 D/XhOOhzpMBdp3NoClp1FkKk/DNnwSXplfWS5XrHIbtM7TGlX4Xl3gjZJ1pBSrIGTuhYdifnM
 aYAgS1D5iInuYmhNwAlMPLHg/0Wo1+tIyYjxCQGtcz6W4Tipyhqe3w3R6Lu96NyEDdiQKSZ+w
 PnICnhpjhHmtmQ4V/xt1sqTnYZBpKw5qakhU7YqFrY5CUmpzdl7SvdTOKZFehUkjtAV5iJhhg
 yvlPOoDBMTOpRbVXpU+idsEUpZecSP8OeIhZqDB1bZvboGxQmNxw1rh/3GUtPFReje8HniLh3
 9CMyqBFqIj4QAc55fVpcfC7alsCOG6YTKGau73f4lWelk2/qtUwboK9fR/0SKTFKQEBZGlbAH
 z0dvaUj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-698130740-1472631657=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Tue, 30 Aug 2016, Junio C Hamano wrote:

> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
> > In my personal opinion 'set_me_free_after_use' is not the best name,
> > but I unfortunately do not have a better proposal.  Maybe 'entrust_ptr'=
,
> > or 'entrusted_data' / 'entrusted_ptr' / 'entrusted'?
>=20
> Is this to accumulate to-be-freed pointers?

Yes.

> I think we often call a local variable that points at a piece of
> memory to be freed "to_free", and that is an appropriate name for
> what this function is trying to do.

I changed it to that.

> It is a bit surprising that the careless memory management in this
> codepath leaks only the dumb pieces of memory (as opposed to
> pointers to structures like string list that needs _clear()
> functions, in which case we cannot get away with list of
> to-be-freed).  I guess we were somewhat lucky ;-)

Yeah, the carelessness is more like a convenience where the config
machinery is reused to parse the values.

Ciao,
Dscho
--8323329-698130740-1472631657=:129229--
