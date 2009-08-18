From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/3] short syntaxes for 'git stash'
Date: Tue, 18 Aug 2009 23:38:40 +0200
Message-ID: <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 18 23:42:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWRY-0003C1-4P
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbZHRVmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbZHRVmD
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:42:03 -0400
Received: from imag.imag.fr ([129.88.30.1]:62987 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbZHRVmC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:42:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7ILdMrt007622
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 23:39:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdWOo-0005Ld-7H; Tue, 18 Aug 2009 23:39:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdWOo-0002mB-5n; Tue, 18 Aug 2009 23:39:22 +0200
X-Mailer: git-send-email 1.6.4.rc2.31.g2d7d7
In-Reply-To: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 18 Aug 2009 23:39:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126465>

This small patch serie is based on the following commit in pu:

dda1f2a Implement 'git stash save --patch'

It is meant to replace two commits already there:

ea41cfc Make 'git stash -k' a short form for 'git stash save --keep-index'
f300fab DWIM 'git stash save -p' for 'git stash -p'

The first (git stash -k) has the drawback of forcing one to use one
and only one option when the 'save' command is ommited. My approach is
mostly based on the simple hack:

+case "$1" in
+    -*)
+       set "save" "$@"
+       ;;
+esac
+

and accepts an arbitrary number of options.

The second (DWIM git stash save -p) becomes unnecessary afterwards.
