From: Adam Flott <adam@npjh.com>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sat, 22 Sep 2007 16:37:11 -0500 (CDT)
Message-ID: <20070922162750.Y1876@localhost>
References: <20070921214346.GF97288@void.codelabs.ru>
 <7vlkazh1ji.fsf@gitster.siamese.dyndns.org> <20070921214346.GF97288@void.codelabs.ru>
 <7v8x6zinjf.fsf@gitster.siamese.dyndns.org> <20070922035434.GA99140@void.codelabs.ru>
 <7vhclngpgd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 23:48:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZCq1-0001Iw-Tp
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 23:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbXIVVs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 17:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbXIVVs2
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 17:48:28 -0400
Received: from npjh.com ([200.46.208.52]:59286 "EHLO npjh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbXIVVs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 17:48:27 -0400
X-Greylist: delayed 672 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Sep 2007 17:48:27 EDT
Received: from localhost (unknown [200.46.204.191])
	by npjh.com (Postfix) with ESMTP id CF229A3E786;
	Sat, 22 Sep 2007 21:37:14 +0000 (UTC)
Received: from npjh.com ([200.46.208.52])
 by localhost (mx1.hub.org [200.46.204.191]) (amavisd-maia, port 10024)
 with ESMTP id 63338-04; Sat, 22 Sep 2007 18:37:14 -0300 (ADT)
Received: from an.sumeria (cpe-70-124-58-222.austin.res.rr.com [70.124.58.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by npjh.com (Postfix) with ESMTP id 0C957A3E08E;
	Sat, 22 Sep 2007 21:37:13 +0000 (UTC)
X-X-Sender: adam@localhost
In-Reply-To: <7vhclngpgd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58943>


On Fri, 21 Sep 2007, Junio C Hamano wrote:

> I vaguely recall somebody else had exactly this issue and he
> concluded that the shell was busted.  I do not recall the
> details of the story but interestingly, if he did something that
> accesses "$#" before the problematic "while case $# in ..." the
> shell behaved for him in his experiments.

That is what I did notice, just accessing $# fixed later uses of it.

> Also by my comment about "/bin/sh and bash not being the only
> shells available on FreeBSD", I did not mean that you should
> change your /bin/sh.  You can build git with SHELL_PATH make
> varilable pointing at a non-broken shell, which does not have to
> be installed as /bin/sh.

If one's installing from the ports tree, then the port should depend on a
non-broken shell and set SHELL_PATH. And as for installing by hand, just print
out a warning that SHELL_PATH points to a broken shell and be done with it.
This is a FreeBSD bug, not a git one.

I had been meaning to write up a bug about this using a small test case, but I
couldn't reproduce it.


Adam
