From: Mike Hommey <mh@glandium.org>
Subject: Re: Consistency question
Date: Sat, 18 Jan 2014 10:22:22 +0900
Message-ID: <20140118012222.GA4381@glandium.org>
References: <8761pl8raj.fsf@fencepost.gnu.org>
 <20140115111330.GH14335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 18 02:22:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4KcY-0003MF-5Z
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 02:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbaARBWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 20:22:43 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:58692 "EHLO
	jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752803AbaARBWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 20:22:41 -0500
Received: from mh by jigen.glandium.org with local (Exim 4.82)
	(envelope-from <mh@glandium.org>)
	id 1W4KcA-0001Ct-SH; Sat, 18 Jan 2014 10:22:22 +0900
Content-Disposition: inline
In-Reply-To: <20140115111330.GH14335@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240641>

On Wed, Jan 15, 2014 at 06:13:30AM -0500, Jeff King wrote:
> On Wed, Jan 15, 2014 at 11:37:08AM +0100, David Kastrup wrote:
> 
> > The question is what guarantees I have with regard to the commit date of
> > a commit in relation to that of its parent commits:
> > 
> > a) none
> > b) commitdate(child) >= commitdate(parent)
> > c) commitdate(child) > commitdate(parent)
> 
> a) none
> 
> > Obviously, I can rely on c) being true "almost always":
> 
> Actually, b) is quite often the case in automated processes (e.g., "git
> am" or "git rebase"). The author dates are different, but the committer
> dates may be in the same second.
> 
> And of course a) is the result of clock skew and software bugs.

... or importing non-git repositories that don't have commit info
separated from author info like git does. In such cases, it's usual to
duplicate the author info as commit info so that clones of the same
non-git repo end up with the same git sha1s. Mercurial easily allows
author dates to be in a non topological order.

Mike
