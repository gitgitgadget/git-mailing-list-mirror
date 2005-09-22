From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Different behaviour of git and cogito
Date: Thu, 22 Sep 2005 15:20:21 +0200
Message-ID: <200509221520.22088.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 22 15:22:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIR0E-0005H0-Jp
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 15:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVIVNUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 09:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVIVNUj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 09:20:39 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:19887 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030324AbVIVNUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 09:20:38 -0400
To: git <git@vger.kernel.org>
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9116>

Hi,

with git 0.99.7 and cogito 0.15 there is a difference in interpretation
of a URL for a remote repository:

The URL "machine:/path/to/rep" defaults to ssh protocol with GIT, but with
Cogito to rsync. Cogito uses "git+ssh:" for the ssh protocol, but GIT
does not recogize this protocol specifier.

So mixed use of GIT and Cogito in the same rep is not possible with these
protocols, as Cogito uses .git/branches to store the URL for a remote rep,
and GIT also checks in .git/branches.

Can we unify this behavior, i.e. (1) Cogito using ssh with a given URL 
"machine:/path/to/rep", and (2) GIT recognizing protocol "git+ssh:"?

For existing repos, change (1) could be cumbersome for Cogito users.
Perhaps Cogito could do this when changing to use .git/remotes.

Josef
