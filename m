From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: set TERM=dumb to prevent ANSI output
Date: Thu, 06 Mar 2008 15:16:36 -0800
Message-ID: <7vmypb8muj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803061752340.3941@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXPL5-0005as-Ns
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 00:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758529AbYCFXQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 18:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757116AbYCFXQt
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 18:16:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246AbYCFXQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 18:16:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FAB42E5B;
	Thu,  6 Mar 2008 18:16:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ADD072E59; Thu,  6 Mar 2008 18:16:39 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803061752340.3941@racer.site> (Johannes
 Schindelin's message of "Thu, 6 Mar 2008 17:53:28 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76435>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> At least on one of my machines, Term::ReadLine tries to be clever and
> sends \x1b\x5b1034h at the end of the script when TERM is set to 'xterm'.
>
> To prevent that, force TERM=dumb just for the test.

We try to set up a pretty vanilla environment for test repeatability in
t/test-lib.sh, and I suspect we would simply want to do this over there.

Wouldn't this make more sense?

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 87a5ea4..7f6331a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -7,8 +7,9 @@
 LANG=C
 LC_ALL=C
 PAGER=cat
+TERM=dumb
 TZ=UTC
-export LANG LC_ALL PAGER TZ
+export LANG LC_ALL PAGER TERM TZ
 EDITOR=:
 VISUAL=:
 unset GIT_EDITOR

