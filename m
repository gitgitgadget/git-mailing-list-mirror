Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D56C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0C664DD6
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhA1Gf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:35:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:41696 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbhA1Gf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:35:58 -0500
Received: (qmail 9945 invoked by uid 109); 28 Jan 2021 06:35:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:35:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25650 invoked by uid 111); 28 Jan 2021 06:35:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:35:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:35:16 -0500
From:   Jeff King <peff@peff.net>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Taylor Blau <me@ttaylorr.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] ci: do not cancel all jobs of a matrix if one fails
Message-ID: <YBJbJOLyh+ksolVB@coredump.intra.peff.net>
References: <pull.851.git.1611806768911.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.851.git.1611806768911.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 04:06:08AM +0000, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> The CI/PR GitHub Actions workflow uses the 'matrix' strategy for the
> "windows-test", "vs-test", "regular" and "dockerized" jobs. The default
> behaviour of GitHub Actions is to cancel all in-progress jobs in a
> matrix if one of the job of the matrix fails [1].
> 
> This is not ideal as a failure early in a job, like during installation of
> the build/test dependencies on a specific platform, leads to the
> cancellation of all other jobs in the matrix.
> 
> Set the 'fail-fast' variable to 'false' for all four matrix jobs in the
> workflow.

I think this is worth doing. Thanks for rolling it up into a patch.

-Peff
