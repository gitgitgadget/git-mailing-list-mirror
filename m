From: Greg KH <greg@kroah.com>
Subject: renaming a file into a directory causes a pull error on older repos
Date: Sat, 15 Mar 2008 21:31:38 -0700
Message-ID: <20080316043138.GA7942@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 05:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JakSj-0005ZI-3r
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 05:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbYCPE03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 00:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbYCPE03
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 00:26:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51611 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbYCPE03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 00:26:29 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JakS3-0003j7-QF
	for git@vger.kernel.org; Sun, 16 Mar 2008 04:26:28 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77352>

So I had heard from someone else that this was a problem with git, but
brushed it off as something that no one "normal" would ever run into.
Well, I did tonight.

The problem:
  If you turn a file in a repository into a directory, and place files
  in that dir and commit it, any other person who had that repo cloned
  somewhere else will get an error when they try to pull and update
  their version.

The error for me is:
	fatal: Entry 'stats/results-18-22.txt' would be overwritten by merge. Cannot merge.
	Merge with strategy recursive failed.

I had turned the file "stats" into a directory.

So, any thoughts as to how to solve this for real?  It's trivial to just
blow away this repo and clone it again, which will solve the issue for
now, but it seems like this might be good to get fixed...

thanks,

greg k-h
