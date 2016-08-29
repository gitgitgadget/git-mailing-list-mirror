Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E32A1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 11:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757266AbcH2L1P (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 07:27:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:55038 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbcH2L1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 07:27:14 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M0QAP-1ap6y90UUH-00uVip; Mon, 29 Aug 2016 13:26:52
 +0200
Date:   Mon, 29 Aug 2016 13:26:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/20] streaming: make stream_blob_to_fd take struct
 object_id
In-Reply-To: <20160828232757.373278-9-sandals@crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1608291325140.129229@virtualbox>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net> <20160828232757.373278-9-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RT9MKTIChaRxHaP9VoSs9RBLEbq1MEdxxByIF56XCkpqLaIPTbM
 cLxMPCgS9vB8WsSiYkdqGfRL64FhH+0RkGF797HlNPX3Iph84Iwb/q5NieE6cwfdsY33jRT
 S/8RKOHPT/v6HpSeCshGlYDA5WAgubaTlGF+RfOqC8nV1IQcRWYT/vV35tBFRxsa654BeNS
 9LiGM/bAeHmYUQtORe6Cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mzD7fMxpuUg=:BjuQn41IP631336jpnlRPl
 XnwXKhJyq2lXYvKTbS96lLIdx9wO0f6UwowD0CsPW/msEiinELSs/6HrCv9Guaf6AT6W05l64
 44aeAZg87bxYYYvJOeZ4xIYChrEMzoaktCGsLAM1Ihi/3CmJSeY+s4OTuWW3TFi1DC/fMxTaF
 4zAHOfHXwC7NgpMbvDtYcbomfPUgHpgDsoVZR1Lli8FvVD/Z8zvQFLwp8F5fyWI/2uRXFMqkb
 Fv6kvFQgq7rQCthCBXJCSS5bm/7swHVPctXRokcGPlmERjA4sqUrv/Gvbax4uEl4YWvooEO9o
 ykDqfD3GuYDx1gBzSQ81zxMk49XllcxfX1W8MwqIwY/rwD1SxwAUWJuKv2PquZ6/iPN62+Va9
 PTHQ2zv7EM+8hKzMVZbLJjzh81YTB7wrzOc1gUk1HjLxc+n9ctuxv+x8huIxhA9Itckqn8/lB
 pmnSb/goHWhocso4nyCgfRhMdcA2XgOz6dtRZ3O3hyfBtZs6uJctvqCCv21KNZhQOGNWHrxww
 veKMxYALK3MwhbLTp9wtKEkyMAjqD0zlzHvwp0S+lRbWOAKlf8aEqoApGas2jvIyvmzCIdtSW
 d8mJv/bx3n1LmU2W7ggyQH8dHAq3N4FAp/MI+p8NubyLITcRERfknE7mxBo4G7REWnClokRLP
 tzKgx0HMH+xoBFKbWULFE/x9KPFDhSu/rTT5P0sL4tJdSG5bSM55PRdmZdt+G3Jj50qg+/SBp
 EV4mC+zrANCz+7Etq4hkr3xgHWBapWjFbGQtBb7QAtMwSY0XhqEO2DXW8hfhi/d5DRuz3TiP4
 mj+V3+m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sun, 28 Aug 2016, brian m. carlson wrote:

> Since all of its callers have been updated, modify stream_blob_to_fd to
> take a struct object_id.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

I reviewed the patches until here, and they all look very good to me.

Will continue to review after clearing out my brain with other things (it
is mesmerizing to sift through sha1->oid changes for too long).

Ciao,
Dscho
