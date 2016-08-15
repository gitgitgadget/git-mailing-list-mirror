Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB6420193
	for <e@80x24.org>; Mon, 15 Aug 2016 12:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbcHOMZE (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:25:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:54120 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768AbcHOMZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:25:03 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lu2F0-1bAQ0o1Ygw-011WCs; Mon, 15 Aug 2016 14:25:00
 +0200
Date:	Mon, 15 Aug 2016 14:24:59 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	ryenus <ryenus@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] make rebase respect core.hooksPath if set
In-Reply-To: <CAKkAvaxWk6SK4EYPaWXHQoVBh9qLgHoEqAh9+dgOrjncsi5QyA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608151422210.4924@virtualbox>
References: <CAKkAvaxWk6SK4EYPaWXHQoVBh9qLgHoEqAh9+dgOrjncsi5QyA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AktbeywHtUDSFdtu8ZgRC5tMyEvpSnCUVm7MJftyzsoUzry6GjU
 GVPwa4hRgKdNVx8GFFcygDqIOSk67Y1pKDqTdpztj3/vd1eGx2mGp4SNXvMIOKLBorrb6tr
 7vPplINRPOCScndte1Q6GaRq0B+I829qvfUVz2tQ9ljxdJ3CEUO9surIsAnzFfQjM1SZiFj
 b8x+EE9/BqRary/WPNH7A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:jBEMbdtInLE=:bQosugZSjz/8jJAsmTZuQf
 6Lj7GVgnVKdGx15nD5ObE/oOX2tmIxQZZ7qLo4C/hmJcX9RTrzZUm5p6LTAswCw2XXBpAVZSs
 MOsEKuvVxmMKNAR3j6Oy0fQnSv5FxurTNEVMaXK/1HVkdjWvYxad8svEjty99IyjZp7UtH/Hy
 lb0lIrt4cd8X4U9tTf6tTMRARVBUC7Spq1jFTNyQXYuLEscfuhsr52sRkxyBEVzFREOqwl+5L
 QOBaSZNen4SkfwkxUL9cZ2YPWLGm+nv65xYORvx/QYT0mFNlTe/SiOWxcboZzkhXkm84V09p1
 bXm4XIx87WpLohthNkA99QJwm2nIgAuMVM4Fc+eXWDXzzLinOYVBcG4YZAbv6ojNYVLhbKdEk
 QqkGUXz1/jt9IbInHpfmZ52VKdcKWVmQV1U7qm8evFWuduT2QImXuuoNRTKVZuyF7278oaId/
 yZblvnoybIxgB+/wL7uhd32g9Xox2uhrTmMu+pyp3tRNoQt75sn4w1oo2QOdvCtItgdIjI1wz
 +bg68r2yq9DG3801dN3TsX05KpmFK6q2tRPzAUmv49vxEsgrTJDTK4IS7wfmiz2SY23a96Kkr
 RWBxKgqd7NkY+YNbjcrCyWCKXbmINMkrq3OAcMff5NRukqkQZY+GXA/hctYCRSJ+DPaiaxg2l
 QyX6TOYV62Gbzqxhr2+aWoZ3KuXborJ6LlNn4GI2y8efTckUQi0aBpQqvb6TkFR2ayEXzKjhE
 RDBmMb4W6mnlI1z9UPt2gGfCLgkKOND0uExq1KwprLBNLjWuc8rwawxliU0AINGCm5K86HnKf
 WkK8KnD
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi ryenus,

On Sun, 14 Aug 2016, ryenus wrote:

> when looking for pre-rebase and post-rewrite hooks, git-rebase
> only looks for hooks dir using `git rev-parse --git-path hooks`,
> which didn't consider the path overridden by core.hooksPath.

Would it not be more appropriate to teach --git-path hooks to respect the
core.hooksPath variable? This would be in line with --git-path objects
respecting the GIT_OBJECT_DIRECTORY environment variable.

> Signed-off-by: ryenus <ryenus@gmail.com>

From
https://github.com/git/git/blob/v2.9.3/Documentation/SubmittingPatches#L290-L291

> Also notice that a real name is used in the Signed-off-by: line. Please
> don't hide your real name.

Thanks,
Johannes
