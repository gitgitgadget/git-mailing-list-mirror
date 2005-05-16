From: Tristan Wibberley <maihem@maihem.org>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Mon, 16 May 2005 23:22:11 +0100
Message-ID: <1116282131.6141.8.camel__31554.9111379825$1116283578$gmane$org@localhost.localdomain>
References: <200505151122.j4FBMJa01073@adam.yggdrasil.com>
	 <20050515124042.GE13024@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 17 00:46:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXoLD-00088Q-CG
	for gcvg-git@gmane.org; Tue, 17 May 2005 00:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVEPWpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 18:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVEPWpd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 18:45:33 -0400
Received: from main.gmane.org ([80.91.229.2]:30139 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261977AbVEPWmI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 18:42:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DXoGJ-0007Yq-UZ
	for git@vger.kernel.org; Tue, 17 May 2005 00:40:36 +0200
Received: from host81-156-255-228.range81-156.btcentralplus.com ([81.156.255.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2005 00:40:35 +0200
Received: from maihem by host81-156-255-228.range81-156.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 May 2005 00:40:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host81-156-255-228.range81-156.btcentralplus.com
In-Reply-To: <20050515124042.GE13024@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-05-15 at 14:40 +0200, Petr Baudis wrote:
> Dear diary, on Sun, May 15, 2005 at 01:22:19PM CEST, I got a letter
> where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> > 
> > 	I don't understand what was wrong with Jeff Garzik's previous
> > suggestion of using http/1.1 pipelining to coalesce the round trips.
> > If you're worried about queuing too many http/1.1 requests, the client
> > could adopt a policy of not having more than a certain number of
> > requests outstanding or perhaps even making a new http connection
> > after a certain number of requests to avoid starving other clients
> > when the number of clients doing one of these transfers exceeds the
> > number of threads that the http server uses.
> 
> The problem is that to fetch a revision tree, you have to
> 
> 	send request for commit A
> 	receive commit A
> 	look at commit A for list of its parents
> 	send request for the parents
> 	receive the parents
> 	look inside for list of its parents
> 	...

What about IMAP? You could ask for just the parents for several messages
(via a message header), then start asking for message bodies (with the
juicy stuff in). You could also ask for a list of the new commits then
ask for each of the bodies (several at a time). Not as good as a "Just
give me all new data", but an *awful* lot more efficient than HTTP. And
very flexible. You just need to map changesets to IMAP messages (if such
a mapping can actually make sense :)

Prolly a bit more work though.

--
Tristan Wibberley

The opinions expressed in this message are my own opinions and not those
of my employer.


