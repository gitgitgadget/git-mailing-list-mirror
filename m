From: carbonated beverage <ramune@net-ronin.org>
Subject: Test suite failures due to Error.pm issues.
Date: Tue, 8 Apr 2008 15:18:53 -0700
Message-ID: <20080408221853.GA3819@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 00:53:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjMgi-0002AK-74
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 00:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbYDHWw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 18:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbYDHWw2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 18:52:28 -0400
Received: from brak.cowlabs.com ([208.96.51.45]:59450 "EHLO brak.cowlabs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbYDHWw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 18:52:27 -0400
X-Greylist: delayed 2010 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Apr 2008 18:52:27 EDT
Received: from prophet.net-ronin.org (S0106000ea6c7835e.no.shawcable.net [70.67.106.241])
	by brak.cowlabs.com (8.14.1/8.14.1) with ESMTP id m38MIrQK458783
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 8 Apr 2008 22:18:56 GMT
Received: from ramune by prophet.net-ronin.org with local (Exim 4.63)
	(envelope-from <ramune@net-ronin.org>)
	id 1JjM9V-000107-Ig
	for git@vger.kernel.org; Tue, 08 Apr 2008 15:18:53 -0700
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79044>

Hi all,

I was trying to track down the cause of massive test failures in make
test, and running the failing entries via -v showed the following popping
up over and over again:

Can't locate Error.pm in @INC (@INC contains: /home/ramune/src/git/git/t/../perl/blib/lib /home/ramune/src/git/git/t/../perl/blib/arch/auto/Git /etc/perl /usr/local/lib/perl/5.8.8 /usr/local/share/perl/5.8.8
 /usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.8 /usr/share/perl/5.8 /usr/local/lib/site_perl .) at /home/ramune/src/git/git/t/../perl/blib/lib/Git.pm line 93.^
BEGIN failed--compilation aborted at /home/ramune/src/git/git/t/../perl/blib/lib/Git.pm line 93.^
Compilation failed in require at /home/ramune/src/git/git/t/../git-add--interactive line 5.^
BEGIN failed--compilation aborted at /home/ramune/src/git/git/t/../git-add--interactive line 5.^

Since git has private-Error.pm file, shouldn't that be picked up by the
make test invocation?

-- DN
Daniel
