From: Eric Raible <raible+git@gmail.com>
Subject: Re: RFH: spawning pager takes long time when when unconnected from network
Date: Tue, 10 Feb 2009 09:20:18 +0000 (UTC)
Message-ID: <loom.20090210T085859-630@post.gmane.org>
References: <loom.20090210T015515-886@post.gmane.org> <4991337B.2010102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 10:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWooh-0003RB-Er
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 10:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZBJJUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 04:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZBJJUi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 04:20:38 -0500
Received: from main.gmane.org ([80.91.229.2]:46242 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbZBJJUh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 04:20:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LWonA-0004Py-Hl
	for git@vger.kernel.org; Tue, 10 Feb 2009 09:20:32 +0000
Received: from mail.nextest.com ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 09:20:32 +0000
Received: from raible+git by mail.nextest.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 09:20:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109190>

Johannes Sixt <j.sixt <at> viscovery.net> writes:

> Do you have a directory in your PATH that points to a disconnected network
> drive? Do you use the default pager settings, or did you customize the pager?

All components in my path are local.

Every time I toggle between core.pager=less and core.ager=less (to disable it)
it's slow the first time on either setting, then fast on subsequent runs.

It feels seems like something is trying to read something from the network,
timing out, and caching the result.  But as far as I know everything is
local on my machine.

There are two ways of avoiding the delay: explicitly piping to less
(so that stdout is not a tty), or setting core.pager="".

This started happening a few weeks ago (I update my git build often)
when pager wasn't specified.  I suppose I could bisect it, but I'm
kinda swamped with $dayjob at the moment.
