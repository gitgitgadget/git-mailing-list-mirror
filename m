Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD58EC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 12:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiKDMzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiKDMzY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 08:55:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF2ACFE
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 05:55:23 -0700 (PDT)
Received: (qmail 18714 invoked by uid 109); 4 Nov 2022 12:55:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 12:55:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29715 invoked by uid 111); 4 Nov 2022 12:55:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Nov 2022 08:55:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Nov 2022 08:55:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] bisect--helper: move all subcommands into their own
 functions
Message-ID: <Y2ULud3Cladlz2rZ@coredump.intra.peff.net>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover.1667561761.git.congdanhqx@gmail.com>
 <081f3f7f9501012404fb9e59ab6d94f632180b53.1667561761.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <081f3f7f9501012404fb9e59ab6d94f632180b53.1667561761.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 06:40:11PM +0700, Đoàn Trần Công Danh wrote:

> In a later change, we will use OPT_SUBCOMMAND to parse sub-commands to
> avoid consuming non-option opts.
> 
> Since OPT_SUBCOMMAND needs a function pointer to operate,
> let's move it now.

Makes sense, and splitting this into its own step makes it easier to
verify.

> +static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)

Thank you very much for putting the UNUSED markers here. It will save me
the trouble of handling it on my topic. :)

-Peff
