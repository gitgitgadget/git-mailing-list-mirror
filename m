Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3FFC6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 16:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCMQiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjCMQhx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 12:37:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537C8305E0
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 09:37:30 -0700 (PDT)
Received: (qmail 21627 invoked by uid 109); 13 Mar 2023 16:30:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Mar 2023 16:30:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8501 invoked by uid 111); 13 Mar 2023 16:30:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Mar 2023 12:30:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Mar 2023 12:30:39 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Tennant <sdt@sebyte.me>
Cc:     git@vger.kernel.org
Subject: Re: How to mirror and augment a git repository
Message-ID: <ZA9Pr90hFpSQaaU/@coredump.intra.peff.net>
References: <87ilfgemkb.fsf@sebyte.me>
 <ZAWfkkmrPUqNmrtu@coredump.intra.peff.net>
 <87fsaf9oa8.fsf@sebyte.me>
 <ZAlOnTovp0ncZopf@coredump.intra.peff.net>
 <87o7oz7eer.fsf@sebyte.me>
 <ZAyWUS27M+degQxj@coredump.intra.peff.net>
 <87pm9d6drp.fsf@sebyte.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pm9d6drp.fsf@sebyte.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 12, 2023 at 06:11:22PM +0000, Sebastian Tennant wrote:

> > You'd have refs under refs/heads at this point.  They were created
> > when you did the original bare clone (since bare clones fetch all
> > heads to start with, though they don't set up a refspec).
> 
> I see the refs under refs/heads at last!
> 
> My mistake was looking for them in the file system (instead of in file
> ‘packed-refs’).

The best way to check is "git for-each-ref", which handles the storage
details (including if we ever move to a new storage mechanism like
reftable).

> The problem was in my partial understanding of the consequences of
> passing option --bare to ‘git clone’ (and in my not thinking to look
> in file ‘packed-refs’).

To be fair, I usually have to double-check the rules for "--bare"
myself. :)

Glad everything is working now.

-Peff
