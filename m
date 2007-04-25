From: Tim Ansell <mithro@mithis.com>
Subject: Re: Problem with git-daemon and mmap.
Date: Wed, 25 Apr 2007 17:31:13 +0930
Organization: MITHIS
Message-ID: <1177488073.12689.30.camel@localhost>
References: <1177483875.12689.22.camel@localhost>
	 <20070425074233.7494.qmail@076ec8c0ddad74.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 10:01:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgcRd-0003Ni-BD
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 10:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161670AbXDYIBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 04:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161840AbXDYIBm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 04:01:42 -0400
Received: from lester.mithis.com ([69.60.120.93]:34006 "EHLO lester.mithis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161670AbXDYIBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 04:01:41 -0400
Received: from [10.1.50.1] (ppp246-117.static.internode.on.net [203.122.246.117])
	by lester.mithis.com (Postfix) with ESMTP id 6844CB2BF;
	Wed, 25 Apr 2007 04:01:16 -0400 (EDT)
In-Reply-To: <20070425074233.7494.qmail@076ec8c0ddad74.315fe32.mid.smarden.org>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45505>

<snip>

> In the debian package version 1.4.4.4, git-daemon's memory by default is
> limited to 64MB.  I changed that with 1.5.0, but maybe you chose to not
> accept the changes to the run script when upgrading to 1.5.5.1-1.
> 
> Check /var/service/git-daemon/run, if it has 'exec chpst -m64000000
> git-daemon ...'.  If so, remove 'chpst -m64000000', and restart the
> git-daemon service through 'sv restart git-daemon'.

Doh!

It appears that after upgrading the git-daemon-run from 1.4.4 to 1.5.1,
I didn't do a "sv restart git-daemon".

After running the command I can now do a checkout form the web
repository, yay!

It appears to use 128m of virtual memory when checking out the
repository (which is why it would be hitting the 64Mb limit).

Would adding a "chpst -m256000000" be a good idea?

Thanks for your help.

Tim Ansell
