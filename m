Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BADDC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjB0U1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 15:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB0U1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 15:27:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CB723842
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 12:27:35 -0800 (PST)
Received: (qmail 15684 invoked by uid 109); 27 Feb 2023 20:27:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Feb 2023 20:27:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19793 invoked by uid 111); 27 Feb 2023 20:27:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Feb 2023 15:27:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Feb 2023 15:27:33 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v11 0/3] Enhance credential helper protocol to include
 auth headers
Message-ID: <Y/0SNW4p0oS9RCbE@coredump.intra.peff.net>
References: <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
 <pull.1352.v11.git.1677518420.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1352.v11.git.1677518420.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2023 at 05:20:17PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> Updates in v11
> ==============
> 
>  * Delete custom-auth.valid and .challenge explicitly in test cleanup.
> 
>  * Use tolower over strncasecmp in implementation of skip_iprefix_mem.
> 
>  * Use skip_iprefix_mem to match "HTTP/" header lines.

Thanks, I looked over all three changes and the whole thing looks good
to me. The first one isn't strictly necessary if we're not renaming the
script, but I agree that it is probably worth being a bit more strict
when deleting in $HTTPD_ROOT_PATH.

-Peff
