From: Holger Freyther <zecke@selfish.org>
Subject: Re: Unable to clone via git protocol / early EOF / index-pack failed
Date: Sat, 26 Mar 2011 17:12:51 +0000 (UTC)
Message-ID: <loom.20110326T180713-801@post.gmane.org>
References: <20110324102703.GH4534@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 18:30:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3XJZ-0006Mn-9M
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 18:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab1CZRaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 13:30:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:37780 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab1CZRaI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 13:30:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q3XJP-0006HZ-2V
	for git@vger.kernel.org; Sat, 26 Mar 2011 18:30:07 +0100
Received: from 91-64-83-241-dynip.superkabel.de ([91.64.83.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 18:30:07 +0100
Received: from zecke by 91-64-83-241-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 18:30:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.64.83.241 (Mozilla/5.0 (X11; U; Linux i686; en-us) AppleWebKit/534.16+ (KHTML, like Gecko) Version/5.0 Safari/534.16+ Epiphany/2.30.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170059>

Harald Welte <laforge <at> gnumonks.org> writes:

> 
> Hi all,

Hi,

I was tracing this on the same server with these flags[1] and in the success
and failure case the commands send to and from the server are the same.
My current guess is that something is not getting flushed and the tcp socket
is closed too early.

It is a bit difficult to track all the processes that get started and what they
should do and to figure out at which point the fd for the tcp socket is really
closed.

anyone has an idea of what we could do?

cheers
   holger

[1] GIT_TRACE_PACKET=1 GIT_TRACE=2 GIT_DEBUG_SEND_PACK=2
