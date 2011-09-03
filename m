From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [BUG] git push --quiet fails with older versions
Date: Sat,  3 Sep 2011 18:34:13 +0200
Message-ID: <1315067656-2846-1-git-send-email-drizzd@aon.at>
References: <20110903105723.GA16304@tin.tmux.org>
Cc: Junio C Hamano <gitster@pobox.com>, tobiasu@tmux.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 18:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QztDZ-0007K4-3r
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 18:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab1ICQhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 12:37:12 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:23401 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752134Ab1ICQhL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 12:37:11 -0400
Received: from localhost (p5B22F905.dip.t-dialin.net [91.34.249.5])
	by bsmtp.bon.at (Postfix) with ESMTP id 9DBD6A7EB7;
	Sat,  3 Sep 2011 18:37:07 +0200 (CEST)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <20110903105723.GA16304@tin.tmux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180658>

Hello Tobias,

On Sat, Sep 03, 2011 at 12:57:23PM +0200, Tobias Ulmer wrote:
> 
> my distro updated git to 1.7.6.1. Now git push --quiet, used in various
> scripts, blows up against 1.7.6. I don't know how backwards compatible
> git tries to be, but in my opinion that seems like a regression for a
> patchlevel release.

Yes, that's a good point. I did not consider that.

> The problem seems to be that the remote git receive-pack does not
> understand --quiet. Maybe it is possible to check for the remote version
> before sending incompatible commandline parameters?

Indeed, that's what we must do. I am sending three patches in reply
to this email:

[PATCH 1/3] tests for push --quiet
[PATCH 2/3] fix push --quiet via http
[PATCH 3/3] push: old receive-pack does not understand --quiet

The third one fixes this issue on the client side.  It does not
depend on the first two. It applies to v1.7.6.1, maint, and master.
Would be great if you could test.

Thanks,
Clemens
