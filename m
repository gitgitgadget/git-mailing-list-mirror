From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 12:34:30 -0800
Message-ID: <7v63wf2yzt.fsf@gitster.siamese.dyndns.org>
References: <20080220235944.GA6278@coredump.intra.peff.net>
 <20080221000044.GB6429@coredump.intra.peff.net>
 <200802232113.40100.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Feb 23 21:35:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT15p-00055f-Fq
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 21:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757687AbYBWUe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 15:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761348AbYBWUe4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 15:34:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbYBWUez (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 15:34:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AE8C11100;
	Sat, 23 Feb 2008 15:34:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CF8C92000; Sat, 23 Feb 2008 15:34:42 -0500 (EST)
In-Reply-To: <200802232113.40100.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Sat, 23 Feb 2008 21:13:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74848>

SHELL can be just "bash" or "dash" or whatever.  Makefile sets
and exports SHELL_PATH so use it when telling which shell to use
to fake-editor.sh

 t/t3404-rebase-interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 62e65d7..049aa37 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -61,7 +61,7 @@ test_expect_success 'setup' '
 	git tag I
 '
 
-echo "#!$SHELL" >fake-editor
+echo "#!$SHELL_PATH" >fake-editor.sh
 cat >> fake-editor.sh <<\EOF
 case "$1" in
 */COMMIT_EDITMSG)
