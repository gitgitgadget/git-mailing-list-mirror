From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: git-diff on touched files: bug or feature?
Date: Wed, 01 Aug 2007 18:17:13 +0200
Message-ID: <vpqwswf8c1i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 18:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGGtC-0006gl-KB
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 18:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbXHAQRa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 12:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753433AbXHAQRa
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 12:17:30 -0400
Received: from imag.imag.fr ([129.88.30.1]:61044 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbXHAQR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 12:17:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l71GHDfM001526
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Aug 2007 18:17:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IGGsr-0000if-CO; Wed, 01 Aug 2007 18:17:13 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IGGsr-0001q0-9x; Wed, 01 Aug 2007 18:17:13 +0200
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 01 Aug 2007 18:17:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54446>

Hi,

When a file is "touched" (ie. stat information not matching the index,
but the content still matching), git-status doesn't report the file as
modified (as expected), but git-diff does (with an empty diff):

$ git st
# On branch master
nothing to commit (working directory clean)
$ ls       
bar
$ touch bar
$ git diff
diff --git a/bar b/bar         <--- here ---<
$ git status
# On branch master
nothing to commit (working directory clean)
$ git diff                     <--- status updated
                                    the stat in the index.

Is this intended, or just that the code that reconciles the file and
the index has been written for status, but not used in diff?

Thanks,

-- 
Matthieu
