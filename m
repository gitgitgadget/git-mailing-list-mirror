From: Danil Semelenov <mail@danil.mobi>
Subject: Bug in git-sh-prompt: incorrectly determines the upstream for repos
 produced by recent git svn clone --stdlayout
Date: Thu, 4 Feb 2016 01:48:15 +0300
Message-ID: <20160203224814.GA11100@desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 23:55:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR6Kt-0003Wo-89
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 23:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbcBCWzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 17:55:35 -0500
Received: from g01sm02.soverin.net ([95.170.81.142]:48178 "EHLO
	g01sm02.soverin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662AbcBCWzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 17:55:33 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2016 17:55:32 EST
Received: from soverin.net by soverin.net
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.98.7 at g01sm02
X-Virus-Status: Clean
X-PGP-Key: http://danil.mobi/pubkey.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285376>

Let me copy-paste the original bug report from the Debain mail list by Paul Wise http://comments.gmane.org/gmane.linux.debian.devel.bugs.general/1321117. The bug is still reproducible with the latest version of git-prompt.sh.

>I recently did a git svn clone of the Planet Debian SVN and I noticed
>that the normal upstream indicator in the git part of my $PS1 was not
>working properly. The issue appears to be that the code decides that
>the upstream is trunk instead of origin/trunk. trunk gives an error
>from git rev-list but origin/trunk does not. It works for normal git
>svn clone because there the remote branch is just named git-svn with
>no origin/ prefix. I'm using the below settings for my bash git PS1.
>In case you need a small repo to reproduce this with, try neomis.
>It still works with some of my old repos because the remote branch is
>just trunk instead of origin/trunk, so I think git-svn changed this.
