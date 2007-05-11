From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Fri, 11 May 2007 11:09:16 +0200
Message-ID: <vpq7irfengj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 11 11:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmR8I-0003Ze-Jp
	for gcvg-git@gmane.org; Fri, 11 May 2007 11:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762484AbXEKJJd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 05:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762482AbXEKJJd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 05:09:33 -0400
Received: from imag.imag.fr ([129.88.30.1]:48412 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762434AbXEKJJa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 05:09:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4B99HJg001957
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2007 11:09:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HmR7k-0007IO-Ov; Fri, 11 May 2007 11:09:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HmR7k-00083A-J7; Fri, 11 May 2007 11:09:16 +0200
Mail-Followup-To: git <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 11 May 2007 11:09:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46947>

Hi,

I'm using git-svn, which usually works fine, but I occasionally get
this:

$ git-svn dcommit           
        A       file1
        A       file2
Network connection closed unexpectedly: Connection closed unexpectedly at /path/to/git-svn line 401
$

The failure seems to depend on the commit's I'm pushing, since this is
reproducible when running several times "dcommit" for the same commit,
but the same command also usually works fine on the same repositories
(same git repo, same svn target).

The svn repository is accessed with svn+ssh://user@machine/path/.

exporting the patch, applying it to an svn checkout, and "svn commit"
works fine.

Let me know if I can provide any other usefull information for
debugging.

Thanks,

Debian etch (stable)
Reproducible with both git 1.5.1.1 and the latest from git:

$ git-svn --version
git-svn version 1.5.2.rc3.3.ge347 (svn 1.4.2)

-- 
Matthieu
