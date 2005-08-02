From: barkalow@iabervon.org
Subject: Parallel pull for ssh-pull
Date: Tue, 2 Aug 2005 16:02:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0508021544430.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 02 22:00:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E02vz-00076b-SI
	for gcvg-git@gmane.org; Tue, 02 Aug 2005 22:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVHBUAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 16:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVHBUAF
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 16:00:05 -0400
Received: from iabervon.org ([66.92.72.58]:10508 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261758AbVHBUAD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 16:00:03 -0400
Received: (qmail 4298 invoked by uid 1000); 2 Aug 2005 16:02:59 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Aug 2005 16:02:59 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think I've now got the parallel pull use in ssh-pull to the point where 
it could be useful to post. Similar stuff should work for http-pull (where 
it will probably be more interesting), but I have to read more libcurl 
documentation.

Initial results on ssh-pull are encouraging: on my local ethernet, I moved 
the current git repository in 16 seconds, unpacked and with the push 
side acting dumb. I think it was requesting objects about 6 ahead of where 
it was reading them. I didn't test how much time the pipe spent empty in 
the final version; when I was printing debugging messages, the pipe was 
often empty, but it also took 3 times as long, and was therefore probably 
blocking on debugging output, not the network.

This work is based on some now in -pu; what should I base my patches on? I 
would ideally like to add a function to one of the patches in -pu and fix 
a subtle bug in the other, in addition to further patches to actually use 
the feature in ssh-pull.

	-Daniel
*This .sig left intentionally blank*
