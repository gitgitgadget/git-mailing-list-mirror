From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Wine + GIT
Date: Tue, 6 Dec 2005 15:08:44 -0800
Message-ID: <20051206230844.GA3876@reactrix.com>
References: <4394CD68.8020500@codeweavers.com> <4394F50E.7030803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 00:10:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjlwI-0001si-E1
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 00:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVLFXJc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 18:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVLFXJc
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 18:09:32 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:65320 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932652AbVLFXJb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 18:09:31 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jB6N8juh022974;
	Tue, 6 Dec 2005 15:08:45 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jB6N8iK6022971;
	Tue, 6 Dec 2005 15:08:44 -0800
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <4394F50E.7030803@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13302>

On Mon, Dec 05, 2005 at 09:18:54PM -0500, Jeff Garzik wrote:

> One other comment:  http:// is the slowest of all three transports. 
> git:// (git daemon) is preferred, followed by rsync.
> 
> http:// takes forever, comparatively.

Has that been the general git user experience?  While there are
certainly disadvantages to the http transport, I didn't think that
performance was one of them.

For comparison, I ran some clones this morning/afternoon with the
following results:


Clone of kernel.org/pub/scm/git/git.git

http
real    0m24.204s       real    0m25.750s       real    0m24.094s
user    0m5.870s        user    0m5.530s        user    0m5.350s
sys     0m0.660s        sys     0m0.710s        sys     0m0.600s

rsync
real    1m3.952s        real    1m3.417s        real    1m4.360s
user    0m0.090s        user    0m0.130s        user    0m0.120s
sys     0m0.210s        sys     0m0.230s        sys     0m0.210s

git
real    0m54.715s       real    0m55.928s       real    0m56.411s
user    0m0.980s        user    0m0.980s        user    0m1.040s
sys     0m0.220s        sys     0m0.140s        sys     0m0.160s


Clone of kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

http
real    4m59.959s       real    5m28.512s       real    6m9.109s
user    1m38.400s       user    1m34.350s       user    1m35.700s
sys     0m7.640s        sys     0m8.180s        sys     0m7.510s

rsync
real    19m47.218s      real    19m46.739s      real    21m41.875s
user    0m3.960s        user    0m4.260s        user    0m4.000s
sys     0m5.060s        sys     0m4.680s        sys     0m4.860s

git
real    19m43.014s      real    19m36.692s      real    20m43.277s
user    0m23.180s       user    0m23.070s       user    0m23.230s
sys     0m8.210s        sys     0m8.590s        sys     0m11.240s

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
