From: Aaron Schrab <aaron@schrab.com>
Subject: Merge without marking conflicts in working tree
Date: Mon, 17 Nov 2014 17:38:36 -0500
Message-ID: <20141117223836.GH615@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 23:38:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqUwT-0001Um-GK
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 23:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbaKQWih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 17:38:37 -0500
Received: from pug.qqx.org ([50.116.43.67]:43715 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbaKQWih (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 17:38:37 -0500
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 82CAC57779; Mon, 17 Nov 2014 17:38:36 -0500 (EST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.22+86 (g0ed1b9d) (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a way to do a merge but only record conflicts in the index, not 
update the working versions of files with conflict markers?

Like many people, I use git to manage configuration files for my shell, 
editor, git itself, and a number of other things.  The vast majority of 
times that I update things no conflicts are occur and everything just 
works, so I'd like to avoid extra work in this case.  But occasionally a 
conflict will occur, and if it's in a file that will be read while 
trying to resolve the conflict this can make things more difficult.

I'd like to find a way to have the conflict recorded in just the index 
without touching the working tree.  I could then use my usual tools to 
resolve the conflict without the errors caused by the conflict markers.  
I generally use vim+fugitive to resolve conflicts anyway, and typically 
the first step I take is to replace the working-tree version with the 
merge-base version, completely ignoring any conflict markers.

If there isn't currently a way to do this, I was thinking of 
implementing something like an "ours" value for merge.conflictstyle 
configuration.
