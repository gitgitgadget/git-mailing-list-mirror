Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD20C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 18:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCWSCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 14:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWSCD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 14:02:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A75AE1AA
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 11:02:01 -0700 (PDT)
Received: (qmail 24008 invoked by uid 109); 23 Mar 2023 18:02:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Mar 2023 18:02:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26510 invoked by uid 111); 23 Mar 2023 18:02:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Mar 2023 14:02:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Mar 2023 14:01:59 -0400
From:   Jeff King <peff@peff.net>
To:     Stanislav M <stanislav.malishevskiy@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stanislav Malishevskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey
 types.
Message-ID: <20230323180159.GA1015351@coredump.intra.peff.net>
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
 <xmqqlejrmj4y.fsf@gitster.g>
 <20230321172223.GA3119834@coredump.intra.peff.net>
 <xmqqjzzahufj.fsf@gitster.g>
 <CAEpdKf=pMcMn6q0wGGcrFN1yi1duguSNLDkqhDmvMBeKQ--yuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEpdKf=pMcMn6q0wGGcrFN1yi1duguSNLDkqhDmvMBeKQ--yuA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 12:33:59PM +0300, Stanislav M wrote:

> I want to do some clarification there. Those changes are not related
> to http or https directly.
> That only configures curl to know how to access the certificate and
> key locally on the client box, so if the way is wrong there is a
> simple error: Certificate or key not found.

Yes, but I'm not sure if there is a way for Git to trigger curl to look
at the certificate that does not involve feeding it an https URL (and we
want a valid one, because we want to see that it correctly speaks to the
server).

-Peff
