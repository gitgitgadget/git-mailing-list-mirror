Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E2B202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 19:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbdKTTSt (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 14:18:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:34914 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752024AbdKTTSs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 14:18:48 -0500
Received: (qmail 1310 invoked by uid 109); 20 Nov 2017 19:18:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 19:18:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14909 invoked by uid 111); 20 Nov 2017 19:19:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 14:19:03 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 14:18:46 -0500
Date:   Mon, 20 Nov 2017 14:18:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH] contrib/git-jump: allow to configure the grep command
Message-ID: <20171120191846.pco4wfsu2ptci3uv@sigill.intra.peff.net>
References: <20171119230536.1628-1-dev+git@drbeat.li>
 <xmqqh8tpmypa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8tpmypa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 12:11:13PM +0900, Junio C Hamano wrote:

> Beat Bolli <dev+git@drbeat.li> writes:
> 
> > Add the configuration option "jump.grepCmd" that allows to configure the
> > command that is used to search in grep mode. This allows the users of
> > git-jump to use ag(1) or ack(1) as search engines.
> >
> > Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> > ---
> 
> Thanks.  The contrib/README file has this to say (also read the
> surrounding text):
> 
>     ... If
>     you have patches to things in contrib/ area, the patch should be
>     first sent to the primary author, and then the primary author
>     should ack and forward it to me (git pull request is nicer).

I'm not sure the "ack and forward" and "pull request" bits necessarily
make sense here, as I do not host git-jump as a separate repository.
I'd expect people to send to the list and cc me, and you'd pick it up as
long as I'd ack'd it.

But I'm happy to revisit that if you prefer to do it a different way. We
could even pull it out of contrib/ entirely and I could just host it as
a separate project entirely.

> Peff, I think we need a clear indication in contrib/git-jump/README
> to whom patches to the area should be sent.  I know how to run 
> 
>     $ git shortlog -n --no-merges contrib/git-jump
> 
> but not everybody does (or bothers).

How about this?

-- >8 --
Subject: [PATCH] git-jump: give contact instructions in the README

Let's make it clear how patches should flow into
contrib/git-jump. The normal Git maintainer does not
necessarily care about things in contrib/, and authors of
individual components should be the ones giving the final
review/ack for a patch. Ditto for bug reports, which are
likely to get more attention from the area expert.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/git-jump/README | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 225e3f0954..4257cef2e6 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -92,3 +92,10 @@ how to activate it.
 
 The shell snippets to generate the quickfix lines will almost certainly
 choke on filenames with exotic characters (like newlines).
+
+Contributing
+------------
+
+Bug fixes, bug reports, and feature requests should be discussed on the
+Git mailing list <git@vger.kernel.org>, and cc'd to the git-jump
+maintainer, Jeff King <peff@peff.net>.
-- 
2.15.0.494.g79a8547723
