From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: Add a "Copy commit summary" command
Date: Fri, 17 Jul 2015 19:22:51 +1000
Message-ID: <20150717092251.GB5916@iris.ozlabs.ibm.com>
References: <1437060565-4716-1-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Beat Bolli <dev+git@drbeat.li>
X-From: git-owner@vger.kernel.org Fri Jul 17 11:23:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG1rD-00036O-Qa
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 11:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757008AbbGQJW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 05:22:58 -0400
Received: from ozlabs.org ([103.22.144.67]:54627 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbbGQJW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 05:22:57 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 216E2140B04; Fri, 17 Jul 2015 19:22:56 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1437060565-4716-1-git-send-email-dev+git@drbeat.li>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274064>

On Thu, Jul 16, 2015 at 05:29:25PM +0200, Beat Bolli wrote:
> When referring to earlier commits in commit messages or other text, one
> of the established formats is
> 
>     <abbrev-sha> ("<summary>", <author-date>)
> 
> Add a "Copy commit summary" command to the context menu that puts this
> text for the currently selected commit on the clipboard. This makes it
> easy for our users to create well-formatted commit references.

I really like this idea, but as others have noted, 8 characters may
not be the right choice for the SHA1 length in all cases.

We have an item in the preferences menu to control the SHA1 length
that is automatically selected when going to a new commit.  It's
stored in the variable $autosellen.  That seems like it would be a
reasonable choice for the SHA1 length to use here.  The only possible
problem is that it defaults to 40 and so might give an overly long
result for some users.  Maybe you could use $autosellen but limit it
to at most 12 or 16 or something like that.

Paul.
