From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 21:20:45 +0100
Message-ID: <epo9at$94o$1@sea.gmane.org>
References: <200701292320.43888.johannes.sixt@telecom.at> <Pine.LNX.4.64.0701291944290.20138@iabervon.org> <45BF0098.8FF978CE@eudaptics.com> <Pine.LNX.4.64.0701301204400.20138@iabervon.org> <Pine.LNX.4.63.0701301835340.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0701301300490.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 21:21:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBzTP-0004RX-EE
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 21:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXA3UU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbXA3UU4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 15:20:56 -0500
Received: from main.gmane.org ([80.91.229.2]:58501 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbXA3UUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 15:20:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HBzTJ-0004Ir-6K
	for git@vger.kernel.org; Tue, 30 Jan 2007 21:20:53 +0100
Received: from at00d01-adsl-194-118-045-019.nextranet.at ([194.118.45.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 21:20:53 +0100
Received: from johannes.sixt by at00d01-adsl-194-118-045-019.nextranet.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 21:20:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: at00d01-adsl-194-118-045-019.nextranet.at
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38202>

Daniel Barkalow wrote:
> I was actually thinking of only using recv/send on mingw. So the rule
> could be: if git sets up the connection to a pkt_line-user itself, the
> connection is a socket; otherwise it might be a pair of pipes; if you're
> on mingw, pkt_line uses recv/send. Then everything should work except for
> inetd on mingw, and I don't think that's a plausible combination anyway.

Except that it won't work. Because in the same program, say git-fetch-pack,
the packet_*() functions, where you intend to replace read/write by
recv/send, are sometimes called with pipes, and sometimes with sockets,
even on MinGW.

Call it object oriented programming with polymorphic behavior if you like ;)

-- Hannes
