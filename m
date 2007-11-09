From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-am: -i does not take a string parameter.
Date: Thu, 08 Nov 2007 23:12:04 -0800
Message-ID: <7vode3x58b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 08:12:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqO2Z-00013F-9m
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 08:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbXKIHMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 02:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbXKIHMO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 02:12:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36854 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXKIHMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 02:12:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8C7AC2F0;
	Fri,  9 Nov 2007 02:12:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2608290960;
	Fri,  9 Nov 2007 02:12:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64132>

    $ git am -3 -s -i file

spewed the usage strings back at the user while

    $ git am -3 -i -s file

didn't.  This fixes it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e5af955..4126f0e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -9,7 +9,7 @@ git-am [options] --resolved
 git-am [options] --skip
 --
 d,dotest=       use <dir> and not .dotest
-i,interactive=  run interactively
+i,interactive   run interactively
 b,binary        pass --allo-binary-replacement to git-apply
 3,3way          allow fall back on 3way merging if needed
 s,signoff       add a Signed-off-by line to the commit message
-- 
1.5.3.5.1624.gc2f3b4
