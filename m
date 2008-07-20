From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Teach 'git merge' that 'recur' merge strategy no longer exists
Date: Sun, 20 Jul 2008 14:12:48 +0200
Message-ID: <1216555968-31406-1-git-send-email-vmiklos@frugalware.org>
References: <20080720192125.6117@nanako3.lavabit.com>
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:13:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKXmz-0003wX-Kp
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbYGTMMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbYGTMMX
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:12:23 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45348 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbYGTMMW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:12:22 -0400
Received: from vmobile.example.net (dsl5401CD37.pool.t-online.hu [84.1.205.55])
	by yugo.frugalware.org (Postfix) with ESMTP id AFA611DDC5B;
	Sun, 20 Jul 2008 14:12:20 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id A58271AB590; Sun, 20 Jul 2008 14:12:48 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <20080720192125.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89191>

It co-existed with 'recursive' when rewriting it in C, but it no longer
available.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Jul 20, 2008 at 07:21:25PM +0900, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> -     { "stupid",     0 },

If we are at it, recur is also something unnecessary here.

 builtin-merge.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 129b4e6..beba635 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -50,7 +50,6 @@ static size_t use_strategies_nr, use_strategies_alloc;
 static const char *branch;
 
 static struct strategy all_strategy[] = {
-	{ "recur",      NO_TRIVIAL },
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
 	{ "octopus",    DEFAULT_OCTOPUS },
 	{ "resolve",    0 },
-- 
1.5.6.2.450.g8d367.dirty
