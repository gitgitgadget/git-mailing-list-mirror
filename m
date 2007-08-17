From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn: Finding the svn-URL of the current branch in git
Date: Fri, 17 Aug 2007 01:45:31 -0700
Message-ID: <7vir7eh7mc.fsf@gitster.siamese.dyndns.org>
References: <46B8BA03.1030809@gmx.de> <20070807205543.GB27703@xp.machine.xx>
	<20070816082110.GB16849@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Kleine <matthias_kleine@gmx.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 17 10:46:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILxT7-0005LX-SB
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 10:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763293AbXHQIpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 04:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764281AbXHQIpm
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 04:45:42 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764006AbXHQIph (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 04:45:37 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E7AB011BAC2;
	Fri, 17 Aug 2007 04:45:54 -0400 (EDT)
In-Reply-To: <20070816082110.GB16849@muzzle> (Eric Wong's message of "Thu, 16
	Aug 2007 01:21:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56053>

Eric Wong <normalperson@yhbt.net> writes:

> Junio:
> Would you object to having git-merge spew a big fat warning
> and/or outright refuse to let git-merge run on git-svn repositories?

Actually I do.  A major, if not primary, selling point of
git-svn has been that svn cannot do merges but if you import to
git you can, and I've had an impression that Sam's git-svn intro
alludes to this capability as well.

If I understand you correctly, your position is that the svn
side has the authoritative history when using git-svn, and we
should refuse to do anything on the git side that the resulting
history in svn cannot represent.  I know and respect that you
have thought about the issues involved long enough before that
declaration of defeat, but at the same time, I would really hope
that we can come up with a workable compromise to allow merge
tracking on the git side.

It probably does not even have to interoperate with people who
do their own merge tracking using svk.  Perhaps something as
simple and ugly as recording the parent commit object names on
the git side as a trailer to the commit log message we push back
to svn would allow people who interact with the same svn
repository from their own git-svn managed git repository to
interoperate with each other?
