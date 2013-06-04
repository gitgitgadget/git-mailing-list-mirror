From: Ian Kumlien <pomac@vapor.com>
Subject: git-daemon: needs /root/.config/git/config?
Date: Tue, 4 Jun 2013 16:13:14 +0200
Message-ID: <20130604141314.GD22308@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 04 16:27:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjsCO-0002Xg-B1
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 16:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272Ab3FDO0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 10:26:49 -0400
Received: from mail.vapor.com ([83.220.149.2]:36456 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756817Ab3FDO0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 10:26:45 -0400
Received: from twilight.demius.net (c-297271d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.114.41])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id CCCB540C46D
	for <git@vger.kernel.org>; Tue,  4 Jun 2013 16:26:37 +0200 (CEST)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 6ABEB8E36CB; Tue,  4 Jun 2013 16:13:14 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226367>

Hi again, 

Due to the earlier problem I upgraded git on all machines 
and eneded up with a ubunut machine running in to problems.

I started getting errors like:
"fatal: protocol error: bad line length character: fata"

Which after some head scratching caused me to tell xinetd to directly
launch git-daemon, eventually it worked fine, but i did get this error
message:

Jun  4 16:12:05 xyz git-daemon[10246]: unable to access
'/root/.config/git/config': Permission denied

It's not the first time i've seen it but i've been able to ignore it
before. This is running as a local user (as in not root) and this user
shouldn't have access to /root. But i eventually had to do chown o+x
/root to workaround this error.

Now, this must be wrong somehow? Or does --user work in inetd mode now?

So... comments, ideas?
