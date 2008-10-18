From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH] Documentation: diff-filter=T only tests for symlink changes
Date: Sat, 18 Oct 2008 10:49:55 +0200
Message-ID: <87vdvq5lu4.fsf_-_@cup.kalibalik.dk>
References: <871vyhbsys.fsf@cup.kalibalik.dk>
	<20081016102201.GB20762@sigill.intra.peff.net>
	<7vhc7cq8uq.fsf@gitster.siamese.dyndns.org>
	<87ej2fvgv9.fsf@kalibalik.dk>
	<7v1vyfoca2.fsf@gitster.siamese.dyndns.org>
	<87wsg7m2xp.fsf@kalibalik.dk>
	<7vzll2epuh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 10:51:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr7Wj-0002wg-Dh
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 10:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYJRIt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 04:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYJRIt6
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 04:49:58 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:50844 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbYJRIt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 04:49:57 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 518AD14062;
	Sat, 18 Oct 2008 10:49:56 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 2C0C01405A;
	Sat, 18 Oct 2008 10:49:56 +0200 (CEST)
In-Reply-To: <7vzll2epuh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 17 Oct 2008 16\:58\:30 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98531>

With the previous text, one could get the understanding that
diff-filter=T also tested for changes in the executable bit.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---

Junio C Hamano <gitster@pobox.com> writes:

> There are other "commit pickers" such as -S<strting> and
> --diff-filter that do not absolutely have to exist (iow, they could
> also be scripted), but what they pick earned easy shortcuts because
> the need is very common. Once you can demonstrate that the need to
> pick executable-bit changes is also very common, _and_ if you can
> come up with a clean solution, we might add a commit picker that
> looks for changes in executable-ness in the future. I dunno.

You are right that this should be a rare need.

I didn't mean to push for this feature. I just offered to implement
it, as I needed it myself and din't see other ways. A script will work
fine for me, I should have thought of that.

The documentation patch that I promised is here.


Thanks,
Anders.


 Documentation/diff-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7788d4f..7604a13 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -137,7 +137,7 @@ endif::git-format-patch[]
 --diff-filter=[ACDMRTUXB*]::
 	Select only files that are Added (`A`), Copied (`C`),
 	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
-	type (mode) changed (`T`), are Unmerged (`U`), are
+	type (symlink/regular file) changed (`T`), are Unmerged (`U`), are
 	Unknown (`X`), or have had their pairing Broken (`B`).
 	Any combination of the filter characters may be used.
 	When `*` (All-or-none) is added to the combination, all
-- 
1.6.0.2.514.g23abd3
