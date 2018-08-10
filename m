Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB54F1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeHJWGF (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:06:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:32961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbeHJWGF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:06:05 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDV5t-1fgDVS1aiD-00GsfD; Fri, 10
 Aug 2018 21:34:39 +0200
Date:   Fri, 10 Aug 2018 21:34:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
In-Reply-To: <20180810171546.GA32713@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1808102129570.71@tvgsbejvaqbjf.bet>
References: <pull.17.git.gitgitgadget@gmail.com> <20180809194712.GC32376@sigill.intra.peff.net> <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com> <20180810140908.GA23507@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1808101833330.71@tvgsbejvaqbjf.bet>
 <20180810171546.GA32713@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ygDda6u3oA9LfLpdip0qzoGfZldDIGrQaVdIyc5f213YEt6ohCp
 OPZL30tZCSkBRHOllfZFlHr3/i82kWwc53HyI4eclBZh4SAEsXbYlexCAvrK58YKFPpe2UT
 nzloAKJdanjpPR+ck5knOF1NPIeY8eK0x9hAmLatmkaLVnP/FTWjiAm11rb5MftzMz1+ZOw
 WiLI9+UTm78ebZh/vJBuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rfoNUdMfpj0=:aC3eYaeikHM0gvwE7lf97l
 4L+gI8uWNbQFdgkyk1ouwcDnbpaiZ/19LsI+4mq9pA9HOtze6Mcy2gE1aEd5aX+rTDR/iALy3
 ctArVLvI/Ap/Vz7sMkfeyAXSN81dm5JsXkyg9skcQE+3otiGhsfSgU3Pi0dfrmk6mtLjxs7On
 yjlf+7zJYq7yUAS1mRcz5X9DURP+TdaTRW3tt8eVSjcJGEXSsO6PSs/XonxgyAOSZ6Ow+pOYc
 +AXdwgceTQOeus2RebfLT057nQOSzCpzcX2GL8L25NFOstFc8uzQ21hvkGJs0Zw1XM4HYE7XO
 2chSjvFG/MO7ngtkVJ68WBhe83THT2AeKYdbwmizS8C9s//UN9dwqh6eGi28854QmKPnv92Uu
 Gg94E9QHmLN5X1n+vr4Rpbvd/umuQIpotN/xoy91vGbEX6PhcbSW1loWPWLtNYmhMS/jZII8S
 UCPnltBR6A2UxjUyqKqSCMHdNGQheJsGD8SToWKE34ygvN1JGUr3pKVKrjsrOIgTuOVV/Zzni
 BhJ6+BhB0NuL9totq79+Am9HCFRDHa1HelRt0EnnqoPMspwxl2t8mJyuAE/E7ZQXMWkdmloJg
 tPxOYPpvYJB4rYtjYKlfOlJZtGQorsAw1QpMKyDDqF+BkhRkcBDc8wSEvzWfQ6ROXAv4gNpru
 j2F94hteOEMJV9CEQt78GqtgYn6J+ubFk8iYKYPgKG69+1RnGWxQ+SyKLsNV8Zg2tKv4oKVlm
 wC8sM5aF+YSUdcPJ77IMc975Vo8wcY2PnyKmzUAMXjBTE3/FbdnDLChzTNmCSwEAjcmW5LnvE
 yRkJJ6q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 10 Aug 2018, Jeff King wrote:

> On Fri, Aug 10, 2018 at 06:43:07PM +0200, Johannes Schindelin wrote:
> 
> > So unless you are willing to ignore, to willfully keep this breakage,
> > I would suggest not to introduce the ugliness of an overridden
> > upload-pack for the sole purpose of disabling the tracing on one side,
> > but instead to get this here bug fixed, by helping me with this here
> > patch series.
> 
> I'm OK if you want to live with the broken test in the interim.

I realize that I failed to tell you that I basically spent 2.5 days worth
of worktime to figure this out and come up with three iterations of the
patch series (you only saw the latest).

I want this patch series in git.git, maybe not in the current form, but in
one form or another. I don't want to spend any more minute on trying to
figure out the same problem with any other regression test (which might
not even be as easily worked around as with a semi-simple --upload-pack
option).

Thank you for wanting to help. Please accept my apologies for expressing
in a poor way that I appreciate your eagerness to provide a patch, but
that I think nevertheless that it would be better to work on the GIT_TRACE
concurrency problem and its resolution via file locks. It would solve that
class of problems, instead of that single regression test being flakey.

Sorry,
Dscho
