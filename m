From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] cherry: read default config
Date: Thu, 4 Aug 2011 16:49:19 -0600
Message-ID: <20110804224918.GA28215@sigill.intra.peff.net>
References: <20110804224848.GA27545@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:49:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6jG-0008Sv-J1
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab1HDWtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:49:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48158
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756071Ab1HDWtW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:49:22 -0400
Received: (qmail 23533 invoked by uid 107); 4 Aug 2011 22:49:56 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 18:49:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 16:49:19 -0600
Content-Disposition: inline
In-Reply-To: <20110804224848.GA27545@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178774>

We don't currently read the config at all for git-cherry.
This doesn't seem to cause any issues so far, because what
it does is so simple that none of the configuration matters.

However, the next patch will add a relevant config option.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5c2af59..f385fb8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1438,6 +1438,8 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	git_config(git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, options, cherry_usage, 0);
 
 	switch (argc) {
-- 
1.7.6.34.g86521e
