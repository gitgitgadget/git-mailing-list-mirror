Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D422C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 02:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5412076D
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 02:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRCIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 22:08:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:33882 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgHRCIk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 22:08:40 -0400
Received: (qmail 9201 invoked by uid 109); 18 Aug 2020 02:08:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Aug 2020 02:08:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25307 invoked by uid 111); 18 Aug 2020 02:08:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 22:08:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 22:08:38 -0400
From:   Jeff King <peff@peff.net>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
Message-ID: <20200818020838.GA1872632@coredump.intra.peff.net>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
 <20200812194404.17028-1-shouryashukla.oo@gmail.com>
 <20200812194404.17028-5-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812194404.17028-5-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 01:14:04AM +0530, Shourya Shukla wrote:

> +static void print_submodule_summary(struct summary_cb *info, char* errmsg,
> +				    int total_commits, const char *displaypath,
> +				    const char *src_abbrev, const char *dst_abbrev,
> +				    int missing_src, int missing_dst,
> +				    struct module_cb *p)

The "missing_src" and "missing_dst" parameters in this function are
unused.

I _think_ they can be safely removed, and are not a sign of a bug. We
seem to fully handle them in the calling function. But this is the first
time I looked at the code, and I didn't dig too deeply.

-Peff
