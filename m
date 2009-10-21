From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git push: say that --tag can't be used with --all or
 --mirror in help text
Date: Wed, 21 Oct 2009 10:42:03 -0400
Message-ID: <20091021144203.GA30485@coredump.intra.peff.net>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
 <4ADB4AE8.5070007@hartwork.org>
 <20091018235240.GU6115@genesis.frugalware.org>
 <20091019115412.6117@nanako3.lavabit.com>
 <7vpr8kcc00.fsf@alter.siamese.dyndns.org>
 <20091019125701.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Sebastian Pipping <webmaster@hartwork.org>,
	git@vger.kernel.org, Bjorn Gustavsson <bgustavsson@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 16:42:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0cOU-0003DR-Ev
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 16:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbZJUOmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 10:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbZJUOmF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 10:42:05 -0400
Received: from peff.net ([208.65.91.99]:48857 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523AbZJUOmE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 10:42:04 -0400
Received: (qmail 16315 invoked by uid 107); 21 Oct 2009 14:45:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Oct 2009 10:45:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Oct 2009 10:42:03 -0400
Content-Disposition: inline
In-Reply-To: <20091019125701.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130923>

On Mon, Oct 19, 2009 at 12:57:01PM +0900, Nanako Shiraishi wrote:

> -		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
> +		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all nor --mirror"),

Hmm. We apparently all managed to miss this typo. It's visually hard to
notice because of the ")" closing the macro.

-- >8 --
Subject: [PATCH] push: fix typo in usage

Missing ")".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 7d78711..019c986 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -181,7 +181,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
-		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all or --mirror"),
+		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all or --mirror)"),
 		OPT_BIT( 0 , "purge", &flags,
 			"remove locally deleted refs from remote",
 			TRANSPORT_PUSH_PURGE),
-- 
1.6.5.1.139.g6f544.dirty
