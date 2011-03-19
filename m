From: Larry D'Anna <larry@elder-gods.org>
Subject: brtfs COW links and git
Date: Sat, 19 Mar 2011 16:15:32 -0400
Message-ID: <20110319201532.GA6862@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 21:21:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q12eU-0003Wy-P1
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 21:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475Ab1CSUVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 16:21:30 -0400
Received: from static-72-66-21-34.washdc.fios.verizon.net ([72.66.21.34]:38628
	"EHLO cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757286Ab1CSUV3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 16:21:29 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Mar 2011 16:21:28 EDT
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 66D1F8220FC; Sat, 19 Mar 2011 16:15:32 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169460>


I wish git could use COW links.  I wish I could put a large binary into git and
have the only underlying filesystem operation be to cp --reflink and to save the
metadata.  There are a few complications:

How does it know which files to reflink?  attributes?  a size limit?

What does git gc do with reflinks?

Should diff-delta be reflink-aware?  Perhaps it could query the fs for
blocklists.

Before I dive into implementing this, I'd like to get your comments and advice,
to maximize the chances of success.  

Thanks!
