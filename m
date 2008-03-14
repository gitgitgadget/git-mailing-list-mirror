From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Thu, 13 Mar 2008 17:30:01 -0700
Message-ID: <1205454601.2758.10.camel@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
	 <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
	 <20080314002205.GL10335@machine.or.cz>
	 <76718490803131727p451967hee96ff26206c97b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:30:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZxox-0001fZ-D3
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 01:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbYCNAaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 20:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYCNAaK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 20:30:10 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:56208 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYCNAaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 20:30:09 -0400
Received: from [10.255.255.198] (65-115-68-195.dia.static.qwest.net [65.115.68.195])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.13.8) with ESMTP id m2E0TwGL001030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Mar 2008 17:29:58 -0700
In-Reply-To: <76718490803131727p451967hee96ff26206c97b7@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/6225/Thu Mar 13 07:52:37 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77158>

You would be better off using some of the logic I've got in the caching
version of gitweb to prevent the race condition.

- John 'Warthog9' Hawley

On Thu, 2008-03-13 at 20:27 -0400, Jay Soffian wrote:
> On Thu, Mar 13, 2008 at 8:22 PM, Petr Baudis <pasky@suse.cz> wrote:
> 
> >  There is a more conceptual problem though - in case of such big sites,
> >  it really makes more sense to explicitly regenerate the cache
> >  periodically instead of making random clients to have to wait it out.
> 
> Fork off a child to update the cache?
> 
> >  Unlikely. Currently the machine is mostly IO-bound and only small
> >  portion of CPU usage comes from gitweb itself.
> 
> Except that if it were FastCGI or mod_perl you could just keep the cache in
> memory.
> 
> j.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
