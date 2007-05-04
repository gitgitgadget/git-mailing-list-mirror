From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Initial support for cloning submodules
Date: Fri,  4 May 2007 12:56:38 +0200
Message-ID: <11782762032207-git-send-email-skimo@liacs.nl>
Cc: Sven Verdoolaege <skimo@liacs.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 13:00:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjvWB-000617-Qu
	for gcvg-git@gmane.org; Fri, 04 May 2007 13:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767893AbXEDLAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 07:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767892AbXEDLAA
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 07:00:00 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:41534 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767893AbXEDK77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 06:59:59 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l44Auh9t026576;
	Fri, 4 May 2007 12:56:48 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 32B6F3C009; Fri,  4 May 2007 12:56:43 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46163>

From: Sven Verdoolaege <skimo@kotnet.org>

This patch series implements a mechanism for cloning submodules.
Each submodule is specified by a 'submodule.<submodule>.url'
configuration option, e.g.,

bash-3.00$ ./git-config --remote=http://www.liacs.nl/~sverdool/isa.git --get-regexp 'submodule\..*\.url' 
submodule.cloog.url /home/sverdool/public_html/cloog.git
submodule.cloog.url http://www.liacs.nl/~sverdool/cloog.git

git-clone will use the first url that works.
E.g., a

git clone --submodules ssh://liacs/~/public_html/isa.git

(which only works for me), will use the first url, while a

git clone --submodules http://www.liacs.nl/~sverdool/isa.git

will use the second.

The submodules are currently not checked out.

skimo
