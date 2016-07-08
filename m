Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7071A2023C
	for <e@80x24.org>; Fri,  8 Jul 2016 06:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbcGHG3h (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 02:29:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:49647 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbcGHG3f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 02:29:35 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MGSgq-1b8G9I3wci-00DElN; Fri, 08 Jul 2016 08:29:21
 +0200
Date:	Fri, 8 Jul 2016 08:29:18 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff Hostetler <jeffhost@microsoft.com>
cc:	git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
	gitster@pobox.com
Subject: Re: [PATCH] Add very verbose porcelain output to status
In-Reply-To: <1467919588-11930-1-git-send-email-jeffhost@microsoft.com>
Message-ID: <alpine.DEB.2.20.1607080827200.6426@virtualbox>
References: <1467919588-11930-1-git-send-email-jeffhost@microsoft.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j0QnnbPlzaYW5nSNIk78iZtAHzJcpQe9zIMMqP5mDUt8sxmiadD
 6M5PFYLDHrMODjPSoGe8O2OU/SLdgek5q6d5Jffu6FuBgtFKG2XC3KGHum1Tedvwwmo5RdE
 yjpEdBZ0osU25IQ65VdmXqJ4XDhVZda2yhQ7BgoMkv+dPMW0URj/LjI/q54iKveyIXfZbjr
 eXDCtuH8bErQXfMu4Mj2Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:g4iolUWK9aE=:BS1vCxAB8VUQzb7/B4a1pB
 gZFyo1B08J7fNrb/4doeZ5GFUWsKgBQzxOiEfkwvnoxAVRExg6t94a+F56yUwCI5KfBn6pgU5
 ++9acD6BtbRqkgJ6/S6UwjXOrPHPQlleST+SygidvyUYrLJYrbtly3in0sTizdbsbz7CsEDNW
 z2a4bKZqUTc9JreWBVfolYkVBOfh91z2JPsAvPoc3uv/p01SKWfglEWozRsKidcwiWMO63m/p
 ddE8IJlhc09+K8ujtZYExnUbrTg0FmCbrSQoXOjhzZLtg0wlA1h7pAXb/fwL4YyMwP2nGBmad
 cbE6OM6NZszW1/KM/7zwkcnFUFjFrAaqqADRoSIohnhZTJXhP12KAucW5IJSmoeqxGeUK2dOb
 jLp5dwdi2Mi8tL+CwQ8jf45aJt4KMTw6HY5dwssRRbxJUP6YOER4idLYXC7jxs1XZIrn68j0/
 X/aso2xqxlqCcY/JgtktMLOZmBrv+eE756kY/Q+VfiGkZGLxhY3vRhoujMHQhhspnngxvUYWk
 zjP0ufvM5Go51mqjtI1Xx8VU60h+niigfVV6t+hncDiyKIJUOymBOTywaSgX/Bp9ooLwJ35qm
 ZWvt8WFDMzArNPn/+v6DGHNjrOk4fi82l3jUpFfiCX1fM2lUi5bE5qEIs4p9TWxAYJj0nwQv6
 eyVInQsS++JUtuWxNjdXue1mnnNRgGbv2BisxvfCrU7Fj5hlsvNMDItRwtSQDO8+XyVJ7Ngxh
 zeHu4CcDGGH1jrq+OMTjw19CoP/e5bqiZDHsEH8MtkVDdD1u/j6tBtOTg9XPkEHE0f9UzFOVL
 3hGMVvL
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Thu, 7 Jul 2016, Jeff Hostetler wrote:

> Tools interacting with Git repositories may need to know the complete
> state of the working directory. For efficiency, it would be good to have
> a single command to obtain this information.
> 
> We already have a `--porcelain` mode intended for tools' consumption,
> and it only makes sense to enhance this mode to offer more information.
> 
> Just like we do elsewhere in Git's source code, we now interpret
> multiple `--verbose` flags accumulatively, and show substantially more
> information in porcelain mode at verbosity level 2.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---

For the record: I reviewed this patch (and an earlier revision) at
https://github.com/git-for-windows/git/pull/812

I think it is in a good shape, and it is definitely an improvement for
third-party tools that want to interact with a Git worktree.

Ciao,
Dscho
