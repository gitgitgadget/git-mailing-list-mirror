Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_05,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6B4211B3
	for <e@80x24.org>; Wed, 12 Dec 2018 21:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeLLVlu (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 16:41:50 -0500
Received: from mail1.iarc.nv.gov ([64.79.154.70]:21421 "EHLO mail1.iarc.nv.gov"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbeLLVlt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 16:41:49 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2018 16:41:49 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=iarc.nv.gov; i=@iarc.nv.gov; q=dns/txt; s=key1;
  t=1544650909; x=1576186909;
  h=from:to:subject:date:message-id:mime-version:
   content-type:content-transfer-encoding:x-mailer:
   thread-index:content-language:authentication-results:
   ironport-phdr:x-ironport-anti-spam-filtered:
   x-ironport-anti-spam-result:x-ipas-result:x-ironport-av;
  bh=bvkMcIv0bolNC1hLVfB6qVPHEpMLgiQqXsO7/39aOCs=;
  b=Cm9fZiRLuoXTBWpLv9o17xrGGpjDAlsYZnwXibqL0VE8zim1I9FyZBoz
   WjEUD6mbPzALK7T/5MStB9M6AhrEGraCPfe1uu3FTgNKPv2QU/ERYcXw4
   aOp36WNpCaIWBkJ/+s2zv9jXigvGif3RCtQFcsto60VTFN654wdd0w8dI
   ozxdS4+w2EpIgbkvojPkSi8tj9FQcUnBEG4iH22J4HJi+DDpJ/NIq+ULN
   5/jh4ku1rgg0tl9Oo861Ow+sFTI2fSVxtn+17QR8Wc/yTRaWyeJD38525
   Pk5UFy6R1/G1C+1w/fq/9cJnlDvAkldyACUj7E0yyhLcFuG56Qx6QgPoF
   Q==;
Authentication-Results: mail1.iarc.nv.gov; spf=None smtp.pra=john.lopez@iarc.nv.gov; spf=None smtp.mailfrom=john.lopez@iarc.nv.gov; spf=None smtp.helo=postmaster@las0013-01-0.iarc.nv.gov
Received-SPF: None (mail1.iarc.nv.gov: no sender authenticity
  information available from domain of john.lopez@iarc.nv.gov)
  identity=pra; client-ip=10.90.45.100;
  receiver=mail1.iarc.nv.gov;
  envelope-from="john.lopez@iarc.nv.gov";
  x-sender="john.lopez@iarc.nv.gov";
  x-conformance=sidf_compatible
Received-SPF: None (mail1.iarc.nv.gov: no sender authenticity
  information available from domain of john.lopez@iarc.nv.gov)
  identity=mailfrom; client-ip=10.90.45.100;
  receiver=mail1.iarc.nv.gov;
  envelope-from="john.lopez@iarc.nv.gov";
  x-sender="john.lopez@iarc.nv.gov";
  x-conformance=sidf_compatible
Received-SPF: None (mail1.iarc.nv.gov: no sender authenticity
  information available from domain of
  postmaster@las0013-01-0.iarc.nv.gov) identity=helo;
  client-ip=10.90.45.100; receiver=mail1.iarc.nv.gov;
  envelope-from="john.lopez@iarc.nv.gov";
  x-sender="postmaster@las0013-01-0.iarc.nv.gov";
  x-conformance=sidf_compatible
IronPort-PHdr: =?us-ascii?q?9a23=3A1SoSMxD8soGYDc17s981UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPv+pMbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs7Vy?=
 =?us-ascii?q?6i76N2QxH2jikJOSMy/GXOhsBukK5XpRSsrAF9zYHJeoGYLPpwcL3Ac90URm?=
 =?us-ascii?q?ROUdpeWSNGDIOgdIYPE+gMPelEo4Xju1cCsx2zDhSsCuP1zT9Ig2f70aM+3e?=
 =?us-ascii?q?QmEQHG2hErEdQJsHTMstr0NakeWv2ywanKyjXDb/VW1S356IjPahAuv/CNUK?=
 =?us-ascii?q?lxccXL00kgCxnJjlOOqYD/MDOV0foNvnGd4uF9Vuyvk3YqpxxtrjS1wsoglp?=
 =?us-ascii?q?PFi40Vx1ze6Cl13Jo5KNulQ0Bhe9GkCoFftySCOotzRcMtXn9ntT4hyr0DpZ?=
 =?us-ascii?q?67ZC8KyIk7xxLHa/yIbYyI4hX7WeaVOzh4n25pdK6iixu86ESs1vDwWtCo3F?=
 =?us-ascii?q?pQrypKiMPMuWwX2xzV9MiLUPR9/kC/2TqX1gDT7P9LIVwsmKbGN5It2Lo9mo?=
 =?us-ascii?q?YJvUnMHiL6glj6gLOKekk8/+in8eXnYrHopp+GMI90jxnzMqYpmsy/B+Q0KA?=
 =?us-ascii?q?wOX2+D+eui1bzu5kz5T69QjvIqiKXZto7aKd4Upq6+HQ9Zypwj5AqnDze6zN?=
 =?us-ascii?q?QYmmEKLF1EeBKblIXpJV7OL+7iDfulgFSjji1rx/bYMb3lGJnNKWLDkLiyNY?=
 =?us-ascii?q?p6vhpTyRYb099S/dRXB6sHLfa1XVX+4o/2FBg8ZkaWxObhQPF6zo4MEyrbAK?=
 =?us-ascii?q?iZNuXWtkeF9MouKvOHIokL/jn6Na52tLbVkXYllApFLuGS1pwNZSX9RKw8eR?=
 =?us-ascii?q?ewfGbsj9EdEGwDogs5SqnQhUafVSJIPijoDac15zViToOvF4yFQJ7rj7ufj2?=
 =?us-ascii?q?+gBpMDQGdABxiXFGvwMZ2eUqIObyKUZMtmijEWfbmoUYRn0w/ouwjkmPJ8Nu?=
 =?us-ascii?q?SB3CoeuNr40cRtoejalBU87ztxWsaa02fLS2Zsk3EgRjYs1+Z5vwpyzUnQmb?=
 =?us-ascii?q?Ngjal+Etper+hMTh98NZPYyLliDMvuXwvaYtqTYFKvWY3+WGp0Fot0m5kPal?=
 =?us-ascii?q?x2XdO8yB/EwXPwUYUYnLGKGpE4t5nk8SKgeJRbzHDLnOkkhlgiG41OPHetwK?=
 =?us-ascii?q?hhsQfUGdyBlULRjKuseakGlCfQ6GeOy3aPt0BEQWsSGe3EW34YfE7fsdX+4A?=
 =?us-ascii?q?vLUbavDb0tNgYJx9SFL+NGbdjgjFMOQ/mrOtPeZSS1nH+9Fz6Jz6mHKoz0PW?=
 =?us-ascii?q?oawmS4agBMkgwe+2qHKRlrHj2o8CrVCD1jE06qYlu5qLE4+Sv9EhJyllnSPC?=
 =?us-ascii?q?gDn/Kv9xUYhOKRUaYW17MA4WEgoi9/WlCjmd3RFYnlxUIpcaNCbNc6+FoC23?=
 =?us-ascii?q?jeslk3PJugKeZmgUYTYSx2tlnlkRNpTIpHj4J5yRFihBo3Mq+e3F5bInma2p?=
 =?us-ascii?q?D2fLnQMmTg1BGmcaWQ3E+Y39GIsPRqirxwuxDouwenEVAn+nNs3oxO0neS0Z?=
 =?us-ascii?q?7NCRIbTZP7VkturUpAqrrXYzcw68bv7VM3afPmlDjE1pppAeIkzk/mft5FO+?=
 =?us-ascii?q?WCCkn9FNNIT86pYPcnnVSkdFoNIfxS+agoPsina+rjuubjPeBumyijhHhG54?=
 =?us-ascii?q?Y121yF9i51QOrFl5gfxPTQ0gyCXjb6xFCv+sLwmYYCYTYKE3iXyCH+D8hXeO?=
 =?us-ascii?q?t9ephKbAXma8y7y9NihoL8DntR9VqtHVQDi4eifRufaUC43BUFjBxR8CThxX?=
 =?us-ascii?q?b+lmQswFRL5uKF0SfDwvrvbk8CM29PHS9jhE3nZ46qyd8dQhvNDUBhmR276E?=
 =?us-ascii?q?L936Ueqr54KjyZQ0BIeW7yKHlvQIOxv6CJJchRrpwvr28ENYb0KUDfUbP7rx?=
 =?us-ascii?q?YAhmnhGGtYgjQ8bzy4kpTwhRc8jnzbI3Ft5im8G4k41VLU49rSQuRU1zwNSX?=
 =?us-ascii?q?xjiDXZMVO7OsGg4dSek5qa6LKEWmmsV4NefWzQ9a3b7nfpw2psDFX/mvmyno?=
 =?us-ascii?q?ShEAEg2mn9yZ9lUjua5BD7KpLm0ai3K6puY1VoCVng6sF7BpAb8MN4hZce3m?=
 =?us-ascii?q?Ifj4mU+nxPmHn6MNFS06bzJHQXQjtDz9nQ6QnjkEptSxDBj5r+TWmYy9B9as?=
 =?us-ascii?q?OSZmoNgnpktIUSUeLMqr1NhyAzpET+ogXPILB8kjob1foy+SsajuUO629Phm?=
 =?us-ascii?q?2WBrEfG1UdPDS5zkzOvoj48PgRPT73IvCq2UFznM6sFuSHqwBYATD4c40pWy?=
 =?us-ascii?q?luqMp4LgGpsjW754f6dd3Xdd9WuAeTlkKKje9VLtQ1keIHlwJmMHj2+3s7je?=
 =?us-ascii?q?E8k1Y9uPPy9JjCMGhr8K+jV1RAMSbpYsoI5jz3paJXhZ7OhtvqRswkQnMKVY?=
 =?us-ascii?q?HjC/S2Vj0Vq760UmTGWC15oXCdF73FGAaZ40oztHPDHaegMHSPLWUYx9FvHU?=
 =?us-ascii?q?jPFAlkmAkRGQ4CsNs8HwGuytbmdR4itDEY/FW+rAUKxeV2ZUGmDjXv4TywYz?=
 =?us-ascii?q?Jxc6CxaQJM51gZtUbcK8fY6Pw1ECZGrMX48V69b1eDbgENNlknH0yJA1e5YO?=
 =?us-ascii?q?uq7MKYq7HDQ7LnaqOIYLyUoqpYSbGHwoz9ioY=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BnBACbfRFc/2QtWgpkHgEGBwaBZYF?=
 =?us-ascii?q?bJoFcBKARiGOLQA0TgWSCawEBgyAGBjQSAQMBAQEBAQEBAQGBFII2JIJxAjA?=
 =?us-ascii?q?kKAUWUj8BBB4FglKoGxGCUhoChSSEa4J+ixU/iXGFDgKQDDeQSQcCAoIlAY8?=
 =?us-ascii?q?vGIFNAYg/A4c2mT+BXYF3KwpBgzc+kD2OWAEB?=
X-IPAS-Result: =?us-ascii?q?A2BnBACbfRFc/2QtWgpkHgEGBwaBZYFbJoFcBKARiGOLQ?=
 =?us-ascii?q?A0TgWSCawEBgyAGBjQSAQMBAQEBAQEBAQGBFII2JIJxAjAkKAUWUj8BBB4Fg?=
 =?us-ascii?q?lKoGxGCUhoChSSEa4J+ixU/iXGFDgKQDDeQSQcCAoIlAY8vGIFNAYg/A4c2m?=
 =?us-ascii?q?T+BXYF3KwpBgzc+kD2OWAEB?=
X-IronPort-AV: E=Sophos;i="5.56,346,1539648000"; 
   d="scan'208";a="775888"
Received: from unknown (HELO las0013-01-0.iarc.nv.gov) ([10.90.45.100])
  by mail1.iarc.nv.gov with SMTP; 12 Dec 2018 21:32:17 +0000
Received: from LAS090191230 (unknown [10.34.5.134])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by las0013-01-0.iarc.nv.gov (Postfix) with ESMTPS id 6DE50DF51A
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 21:32:17 +0000 (UTC)
From:   "John Lopez" <john.lopez@iarc.nv.gov>
To:     <git@vger.kernel.org>
Subject: Git Repository
Date:   Wed, 12 Dec 2018 13:32:17 -0800
Message-ID: <3e8e01d49262$27e55be0$77b013a0$@iarc.nv.gov>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdSSYdWirzCAfXB6T8eijuuD0UVxSA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Afternoon,

I am inquiring to see if you have a repo for your software where we can
point our 3rd party software to automatically download your software? It
requires CAB's not sure  if you do this or not, if so can you send me the
link for future versions

Thank you for your time and support.
V/R
John Lopez
Systems Engineer


