From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-merge: exclude unnecessary options from OPTIONS_SPEC
Date: Mon, 12 May 2008 19:22:56 +0200
Message-ID: <1210612976-13534-1-git-send-email-vmiklos@frugalware.org>
References: <20080512160309.GB4821@artemis.madism.org>
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 19:24:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvbkt-0002ES-5W
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 19:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbYELRXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 13:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbYELRXH
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:23:07 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:38142 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYELRXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 13:23:06 -0400
Received: from vmobile.example.net (dsl5401CA14.pool.t-online.hu [84.1.202.20])
	by yugo.frugalware.org (Postfix) with ESMTP id 540A21DDC5B;
	Mon, 12 May 2008 19:23:04 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 16FB2185E19; Mon, 12 May 2008 19:22:56 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <20080512160309.GB4821@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81884>

gitcli(5) already documents them, and there are no options named
--no-no-stat, --no-no-summary and --no-no-log.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, May 12, 2008 at 06:03:09PM +0200, Pierre Habouzit <madcoder@debian.org> wrote:
> > I am wondering if our move should be to remove these negatives
> > instead
> > of adding more like the quoted patch does.
>
> We should removing the no-log and no-commit indeed as there are log
> and
> commit. the fact that --no-foo exists when --foo exists is documented
> in
> gitcli manpage. We can make it even better adding a flag if needed,
> but
> I feel it's not.

Ok, here is an updated version that does this.

 git-merge.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 69b35d8..5fc5f52 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -9,11 +9,9 @@ git-merge [options] <remote>...
 git-merge [options] <msg> HEAD <remote>
 --
 stat                 show a diffstat at the end of the merge
-n,no-stat            don't show a diffstat at the end of the merge
+n                    don't show a diffstat at the end of the merge
 summary              (synonym to --stat)
-no-summary           (synonym to --no-stat)
 log                  add list of one-line log to merge commit message
-no-log               don't add list of one-line log to merge commit message
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge sucesses (default)
 ff                   allow fast forward (default)
-- 
1.5.5.1.211.g65ea3.dirty
