From: david@lang.hm
Subject: looking for suggestions for managing a tree of server configs
Date: Sat, 13 Oct 2012 14:20:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1210131413240.6253@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 23:41:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN9SS-0005pU-7J
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 23:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab2JMVeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 17:34:15 -0400
Received: from mail.lang.hm ([64.81.33.126]:33104 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754160Ab2JMVeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 17:34:15 -0400
X-Greylist: delayed 797 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Oct 2012 17:34:15 EDT
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id q9DLKwD1018752
	for <git@vger.kernel.org>; Sat, 13 Oct 2012 14:20:58 -0700
X-X-Sender: dlang@asgard.lang.hm
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207580>

I've got a directory tree that holds config data for all my servers. This 
consists of one directory per server (which is updated periodically from 
what is currently configured on that server), plus higher level summary 
reports and similar information.

today I have just a single git tree covering everything, and I make a 
commit each time one of the per-server directories is updated, and again 
when the top-level stuff is created. This works, but it's not really that 
good at letting me go back and see what happened when on a particular 
server because of all the other activity going on in git log.

Also, currently all updates to this repository is serialized, but going 
forward I'm going to be adding some update processes that could result in 
different per-server directories being updated at the same time (and so, 
one may be fully populated with new data, while another has just had all 
the old data deleted prior to the new data being written). I'm concerned 
about possible issues with having these independant and overlapping update 
processes all working in a single git tree

I do want to have everythng share one storage repository, because much of 
the config on the servers is very standard, so I gain quite a bit by 
letting them delta off each other.

Is what I'm currently doing the best way to do this? or should I do 
something like having a submodule per server, or is there some other, 
better way of doing this.? Are there any tools that I should be using 
instead of continuing to use the scripts that I threw together several 
years ago?

David Lang
