Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC3420133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbdCCPjI (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:39:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:62897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbdCCPgt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 10:36:49 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lrviw-1cIpg61DmY-013fUy; Fri, 03
 Mar 2017 16:35:28 +0100
Date:   Fri, 3 Mar 2017 16:35:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/9] setup_git_directory(): use is_dir_sep() helper
In-Reply-To: <20170303112610.x6mdh42nd4hmxz2h@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031632370.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <d1342d28fd402615f1f94d9190559070ed04b0d7.1488506615.git.johannes.schindelin@gmx.de> <20170303033714.5h7qrq57hdqwoi3y@sigill.intra.peff.net>
 <alpine.DEB.2.20.1703031212280.3767@virtualbox> <20170303112610.x6mdh42nd4hmxz2h@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l5V/gzu5xXVvIRaGC6vwDnYh+nfIFcnZihazjV4I6ZkHzhMIkWw
 JhXesvAGosLjbAHZQ+eh/xU7C7HGpDhR6eBvffAtXjKeG8XzkIl+Hml8ocgqE0x846Mv1uX
 yJ0UNpVEpX7lKiEYgV5tuv8iAfFdPLKZPnj3oWlprlWqJxbhhzSZdl63unQPffDKCrWZ+SN
 1tHyCfDdtJ5O2vg4mku0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IxC2qvJaobs=:HJroZZv2vW691a20qbCa9t
 rkNurzzlrL2ZIgztt9gkPR9hffZqonlj5QOX9I0bk8wpUR3+V70MCG6oV1UecOkf4jkU3EVbj
 Ub9VTkj0ZN3R5lKJA7QYZ7mjtlZGdfNSNCbH66fl7xNXQueWOgyY8VosUez4RCr6gZkK34Hqv
 MhkfRnPeOboEa2EGO7sxWPnCTFdTwVUegjUdYXJR7uiwGY6jTltFIR67wCGwcz1RCVKaWHYXP
 qnJ9YoOVDL/zmHXpypvXSa/DtWpdcOaqATnMX3OQuJrjhRN1PNoV9Zbm7RQTwZwoDr+lj5eFr
 vJX06OjEam/1B2FG0PAt7HnQ3m9Uiz6Ik+RNB5+KLs9SJOF87fLeQmSyy9+96AN4/YyhPc4a2
 YdZPeY3NSkeG8YjutL0s0EyhhQeuvG/NDPT0eZwhO3kNNexheqxkY2G7XLdfotAuOeomjxYIn
 A/dBISb/RJzGGd8DOQczCR5G7L0aJf3GuEz88tSvCahdL3d60VjxKbJOrQKCiJuRzeMFRSTQz
 eZBxlhxegMowuRpG1qgpKRacKtzicfqoEh49RcxcM6TEzpviqKH/TRf4hBiaUr/0W8HDb3wGB
 yxaEWJ2iTJtDscHxhsnpRX8ujhHo80kQhYJyQo0PfWHnY/nTU3Lt6X9JCfx44TH3L/dOeaWOz
 hg6ShQe7dBD8Cr861WGVVgFbaDvj70RTvflyIqTovbyQ9sfUDn1K14NF+jZmj5ts6aahYTFha
 gWuxsvNzCpAeujyU7eN7uOlLpZfs6eK4+S8ahsXJsOr4wabmcQfCH+PZ22rGkzy0YT6UeKm4Z
 R83xmyO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 3 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 12:16:31PM +0100, Johannes Schindelin wrote:
> 
> > > What is "dir"? I'm guessing this patch got reordered and it should
> > > stay as cwd.buf?
> > 
> > Oh drats. Usually I do a final `git rebase -x "make test"
> > upstream/master` run before submitting, but I was really, really tired
> > by the end of that stretch.
> 
> I usually do the same, and have done the "too tired" thing, too, only to
> have it bite me. That's why I so readily recognized the problem. :)

:-)

> I've recently switched to using Michael's "git test" program[1], which
> caches the test results for each tree in a git-note. That makes the
> final "rebase -x" a lot less painful if you've left the early commits
> alone.

Good point. I meant to have a look, but got really overwhelmed with other
things.

> The python dependency might be a blocker for you, but I suspect the
> caching parts would be easy to hack together with shell.

No, personally I have no problem with Python. If you asked me to include
it in Git for Windows' installer, increasing the size noticably, that
would be a totally different matter, of course.

Ciao,
Dscho
