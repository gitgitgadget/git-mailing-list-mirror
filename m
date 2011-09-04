From: Tobias Ulmer <tobiasu@tmux.org>
Subject: Re: [BUG] git push --quiet fails with older versions
Date: Sun, 4 Sep 2011 14:08:53 +0200
Message-ID: <20110904120853.GB16587@tin.tmux.org>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Sep 04 14:11:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0BXh-0007tB-7T
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 14:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab1IDMIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 08:08:55 -0400
Received: from tin.tmux.org ([64.85.165.147]:18994 "EHLO tin.tmux.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087Ab1IDMIy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 08:08:54 -0400
Received: by tin.tmux.org (Postfix, from userid 1000)
	id 7EEB01FCBD; Sun,  4 Sep 2011 12:08:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1315067656-2846-1-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180679>

On Sat, Sep 03, 2011 at 06:34:13PM +0200, Clemens Buchacher wrote:
> Hello Tobias,
> 
> On Sat, Sep 03, 2011 at 12:57:23PM +0200, Tobias Ulmer wrote:
> > 
> > my distro updated git to 1.7.6.1. Now git push --quiet, used in various
> > scripts, blows up against 1.7.6. I don't know how backwards compatible
> > git tries to be, but in my opinion that seems like a regression for a
> > patchlevel release.
> 
> Yes, that's a good point. I did not consider that.
> 
> > The problem seems to be that the remote git receive-pack does not
> > understand --quiet. Maybe it is possible to check for the remote version
> > before sending incompatible commandline parameters?
> 
> Indeed, that's what we must do. I am sending three patches in reply
> to this email:
> 
> [PATCH 1/3] tests for push --quiet
> [PATCH 2/3] fix push --quiet via http
> [PATCH 3/3] push: old receive-pack does not understand --quiet
> 
> The third one fixes this issue on the client side.  It does not
> depend on the first two. It applies to v1.7.6.1, maint, and master.
> Would be great if you could test.

Hi Clemens,

I've just gotten round to test patch 3/3 and it works perfectly against
1.7.6 as well as 1.7.6.1. It suppresses the output if the remote git
version is 1.7.6.1, like it should.

Thanks for your quick response,
Tobias

> 
> Thanks,
> Clemens
