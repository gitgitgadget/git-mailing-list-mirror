From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: [PATCH] stash: Don't paginate by default with list command
Date: Tue, 30 Aug 2011 19:21:18 +0200
Message-ID: <4e5d1e5c.438d9c87.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 19:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QySAX-0003ZZ-2k
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 19:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab1H3RcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 13:32:08 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:45812 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755800Ab1H3RcG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 13:32:06 -0400
Received: from point.localnet (mue-88-130-110-172.dsl.tropolys.de [88.130.110.172])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 40C7C11E3C23
	for <git@vger.kernel.org>; Tue, 30 Aug 2011 19:32:04 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1QySAQ-2Qi-00 for <git@vger.kernel.org>; Tue, 30 Aug 2011 19:32:06 +0200
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180421>

The output of "stash list" is such that piping into a pager
normally isn't necessary but annoying, so disable it by default.

Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 31dec0a..b92d986 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -264,7 +264,7 @@ have_stash () {

 list_stash () {
 	have_stash || return 0
-	git log --format=3D"%gd: %gs" -g "$@" $ref_stash --
+	git --no-pager log --format=3D"%gd: %gs" -g "$@" $ref_stash --
 }

 show_stash () {
--
1.7.6
