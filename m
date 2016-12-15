Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004E61FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 17:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbcLORua (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 12:50:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:57105 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbcLORu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 12:50:29 -0500
Received: (qmail 9625 invoked by uid 109); 15 Dec 2016 17:43:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 17:43:48 +0000
Received: (qmail 3857 invoked by uid 111); 15 Dec 2016 17:44:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 12:44:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 12:43:46 -0500
Date:   Thu, 15 Dec 2016 12:43:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>,
        Markus Hitter <mah@jump-ing.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv3 1/3] merge: Add '--continue' option as a synonym for
 'git commit'
Message-ID: <20161215174345.tekbcthjqqcpohaf@sigill.intra.peff.net>
References: <20161213084859.13426-1-judge.packham@gmail.com>
 <20161214083757.26412-1-judge.packham@gmail.com>
 <xmqqk2b2xu81.fsf@gitster.mtv.corp.google.com>
 <CAFOYHZD_mFMvggq4pedjGCz332i1-VcRKxu30iMzURfB3Mu8Vg@mail.gmail.com>
 <xmqqd1gtw0vi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1gtw0vi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 09:36:17AM -0800, Junio C Hamano wrote:

> > Did you want me to send a v4 to mark the strings for translation or
> > will you apply a fixup your end?
> 
> I didn't follow the _() discussion (was there any?)

I think the discussion was just "we should do that".

> I do not think lack of _() is a show-stopper and my preference is to
> keep what I queued that does not have _(), and receive a separate
> follow-up patch that changes "msg" to _("msg") and does nothing
> else.

Here's a patch.

-- >8 --
Subject: merge: mark usage error strings for translation

The nearby error messages are already marked for
translation, but these new ones aren't.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 668aaffb8..599d25c4c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1164,7 +1164,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		const char *nargv[] = {"reset", "--merge", NULL};
 
 		if (orig_argc != 2)
-			usage_msg_opt("--abort expects no arguments",
+			usage_msg_opt(_("--abort expects no arguments"),
 			      builtin_merge_usage, builtin_merge_options);
 
 		if (!file_exists(git_path_merge_head()))
@@ -1180,7 +1180,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		const char *nargv[] = {"commit", NULL};
 
 		if (orig_argc != 2)
-			usage_msg_opt("--continue expects no arguments",
+			usage_msg_opt(_("--continue expects no arguments"),
 			      builtin_merge_usage, builtin_merge_options);
 
 		if (!file_exists(git_path_merge_head()))
-- 
2.11.0.348.g960a0b554

