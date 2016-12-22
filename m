Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D821F206A2
	for <e@80x24.org>; Thu, 22 Dec 2016 21:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758496AbcLVVeK (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:34:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:60328 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754159AbcLVVeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:34:09 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaJWs-1czb6C1hfS-00m30z; Thu, 22
 Dec 2016 22:33:54 +0100
Date:   Thu, 22 Dec 2016 22:33:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 0/2] Really fix the isatty() problem on Windows
In-Reply-To: <ecc920bc-5323-a85c-c29f-9a3a7e4450e8@kdbg.org>
Message-ID: <alpine.DEB.2.20.1612222233400.155951@virtualbox>
References: <cover.1482342791.git.johannes.schindelin@gmx.de> <b0541907-ee79-207b-dc0f-1e3e7d761950@kdbg.org> <ecc920bc-5323-a85c-c29f-9a3a7e4450e8@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RdlvjlkttuGIUq0uA1gSXgPi356kMZCs+Iem+yCwyoDSKXsCpVD
 qI2gCmuFZ6h2NgRU2FoVhWWpLsCHdTT4iUi9Dj5HWDNy3fU5S5wwbi7uWbLKcnIvmEaMG4i
 kCO/088O572ULA2Z5+inXL1QJRxMztusoZ83glNNENYps1yfbby19ANWXdpYMJVpF7yqXYn
 5vvQ4InrYgfQd5MjEmNXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i7M1XjvDBsY=:aJAhfjLEZG/5PCVQc7C3P/
 Zt8wbltvOEzjNIE4YMF8PXpjW9ROUQubWVCI3MIMWxO2+s8yhGIW7VlMxuDFrkkM47l6T1Qpq
 4Kkb+TAL48oaUrtnOrU38/EgpNU4XgyvA5y2WmQLbtTpnUbqtcPYp1ZWLrCz5cnJ1aAdrhMq0
 Ps/kAi3x78IPtRznkOVnF/BGT/dBEqn/SHf4t03fmo1+0V31PuqxI4zu/NmCEHozHgqytqUEW
 jKx2rtZDcVuCjdK4kyPKNXeHXbEnhAmZRWSf3i3QQpZcVYyZrZ2uLVwHb+wNEAAAvmwLW/CTe
 huvaMo1cDOAvw9u5jawVaAwqEc4lBAvkJ8XMuo9CKNVihtwn61CFFbTnKkASMgM3H9cKVQGjG
 AzVLBRi12cUYp2BzIUhjFwr5QlLi1FTJVjJltcTsEMYkBkoz4BBb6YNPeeixDnA7JD6sLbzqL
 OpBt0K8cNKdCHvtTyJAjUMCyZbcwC2Xyt2PrmRk38rmG5RgVGhaQIDW3+vzuZKvnQVuvWhEdO
 k3G8ygkgHadeQXdWnVWplLVnzuiD8XoOt73cvoozTxPvMcCHAQo80JMJRZhSHQ06aLCVBIQ5s
 RB0DlHvEn02rfAB58pwKtp5HWHt4gqxGTnupqtN8kCmoAhALC7XWLDe42aHu2Atn54OlqKtNJ
 Yu84rhTsEtBiQIzFyDzBWtgRiE2UgGrK7l3IGbYapaf8bs8x1Aq9qaGnANK6y8z27FRtn2Eb+
 r4DI/Bu1g6LVWB/2oLb9wcX05jaL9hQXKXoergQ8wbn+E+dcjLew75daFLH46cM6dcw7+onU1
 bPzT+OqB093iRzOqbVH+ifCaIEh+oE1RZS987qR3zwdwsYXnlUSoy5lG8IBi7qvvgXAP5qN0d
 6FNB9o5oK9Sd2eBKQ38iyn/RCdmNEb9f249kiIiYUEc6wKIsGM4cuYy0KfEIWeeUcuZDJtKlV
 HDLT0PrqSwPVPoT9atxAdVcDhgIEyAPVJJzd8GsKdV3kJLRupKdRLxmvVf1va36IK8FQ7TFIl
 mL2ABRM5rlmNDf5tIVSybi8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 22 Dec 2016, Johannes Sixt wrote:

> Am 21.12.2016 um 22:15 schrieb Johannes Sixt:
> > Am 21.12.2016 um 18:53 schrieb Johannes Schindelin:
> > > The current patch series is based on `pu`, as that already has the
> > > winansi_get_osfhandle() fix. For ease of testing, I also have a branch
> > > based on master which you can pull via
> > >
> > >     git pull https://github.com/dscho/git mingw-isatty-fixup-master
> >
> > Will test and report back tomorrow.
> 
> This version 1 of the series passes the test suite (next + a handful other
> topics) for me. It has also undergone a bit of field testing, and things look
> fine.
> 
> I haven't looked at the resulting code, yet, but I don't expect to find
> anything fishy.

Thanks for confirming!
Dscho
