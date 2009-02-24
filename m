From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] bash completion: add --format= and --oneline options for "git log"
Date: Tue, 24 Feb 2009 13:02:16 +0200
Message-ID: <871vtonlmv.fsf_-_@iki.fi>
References: <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
	<7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
	<94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
	<7vljrxveqa.fsf@gitster.siamese.dyndns.org>
	<94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
	<94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
	<7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
	<20090224130626.6117@nanako3.lavabit.com>
	<20090224045041.GA4615@coredump.intra.peff.net>
	<7vprh8mm9k.fsf@gitster.siamese.dyndns.org>
	<20090224054524.GE4615@coredump.intra.peff.net>
	<20090224185913.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	felipe.contreras@gmail.com, "Shawn O. Pearce" <spearce@spearce.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 12:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbv4r-0007V4-Na
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 12:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbZBXLC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 06:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZBXLC0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 06:02:26 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:37313 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbZBXLCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 06:02:25 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B890575A46E; Tue, 24 Feb 2009 13:02:20 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Lbv3I-00020v-Gc; Tue, 24 Feb 2009 13:02:16 +0200
In-Reply-To: <20090224185913.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Tue\, 24 Feb 2009 18\:59\:13 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111283>

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

I like this change and would immediately switch to using --format= and
--oneline instead of --pretty=. I think we should add these bash
completions too.


 contrib/completion/git-completion.bash |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a3092f..34396c2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1012,10 +1012,15 @@ _git_log ()
 	--pretty=*)
 		__gitcomp "$__git_log_pretty_formats
 			" "" "${cur##--pretty=}"
 		return
 		;;
+	--format=*)
+		__gitcomp "$__git_log_pretty_formats
+			" "" "${cur##--format=}"
+		return
+		;;
 	--date=*)
 		__gitcomp "
 			relative iso8601 rfc2822 short local default
 		" "" "${cur##--date=}"
 		return
@@ -1028,10 +1033,12 @@ _git_log ()
 			--root --topo-order --date-order --reverse
 			--follow
 			--abbrev-commit --abbrev=
 			--relative-date --date=
 			--pretty=
+			--format=
+			--oneline
 			--cherry-pick
 			--graph
 			--decorate
 			--walk-reflogs
 			--parents --children
-- 
1.6.2.rc1.29.g79ccf
