From: Thomas Hauk <tom@shaggyfrog.com>
Subject: Project- vs. Package-Level Branching in Git
Date: Thu, 27 Jan 2011 11:38:21 -0800
Message-ID: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 27 20:45:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiXmM-0001OE-6i
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 20:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab1A0TpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 14:45:04 -0500
Received: from p3plsmtpa01-02.prod.phx3.secureserver.net ([72.167.82.82]:46670
	"HELO p3plsmtpa01-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751648Ab1A0TpE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 14:45:04 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2011 14:45:04 EST
Received: (qmail 5380 invoked from network); 27 Jan 2011 19:38:23 -0000
Received: from unknown (216.19.178.88)
  by p3plsmtpa01-02.prod.phx3.secureserver.net (72.167.82.82) with ESMTP; 27 Jan 2011 19:38:23 -0000
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165586>

Back when I worked at a large games company, we used Perforce, and our repo structure looked a little something like this:

/branches
	/alpha
	/beta
/mainline
	/packages
		/external
			/foolib
				/1.0
				/1.1
				/2.0
		/internal
			/barlib
				/dev
				/1.0
				/2.0
			/bazlib
				/2.34
				/2.35
			/qux
				/dev

At the package level, we would split up packages/libraries into two groups based on if they were developed at the company or not (external/internal), and inside each one, we might have multiple versions. In the example above, the repo is for the "qux" game, which uses an internal "bazlib" library developed by another group, and the "barlib" library which was developed for use on "qux" and may be used simultaneously on other projects.

Project-level branches took mainline as a base and branched into the /branches directory. Package-level branches would usually take the "dev" version (which represented the current development version, akin to "master" in Git) as a base and branch into the same parent directory but with an actual version name.

I've successfully used this repo structure with several other projects over the years at other companies (who were mostly using Subversion). Now I'm trying to get into the Git swing of things, but it seems to be that Git only offers project-level branching, and doesn't allow for the kind of package-level branching I'm describing here.

Am I incorrect or is there a way to accomplish with Git what I was doing before with P4 and SVN?

--
Thomas Hauk
Shaggy Frog Software
www.shaggyfrog.com
