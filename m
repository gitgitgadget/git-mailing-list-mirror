From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Weirdness with port-update hook and local push
Date: Mon, 5 Dec 2005 15:36:18 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512051530560.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 21:36:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjN3l-0002UW-OP
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 21:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVLEUfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 15:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVLEUfj
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 15:35:39 -0500
Received: from iabervon.org ([66.92.72.58]:2826 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751440AbVLEUfi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 15:35:38 -0500
Received: (qmail 30768 invoked by uid 1000); 5 Dec 2005 15:36:18 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Dec 2005 15:36:18 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13227>

I have the following post-update hook:

-----
#!/bin/sh

unset GIT_DIR
cd /home/barkalow/auto-working/web
if ! git pull /home/barkalow/git/web.git/
then
  exit 1  
fi
make
-----

>From that "git pull", I'm getting:

/home/barkalow/bin/git-pull: line 108: 30608 Broken pipe      git-merge $no_summary $no_commit $strategy_args "$merge_name" HEAD $merge_head

It works fine when pushing over ssh, and when I just run the hook 
directly. (It does a fast forward merge without any trouble.) Any ideas on 
what's confusing it?

	-Daniel
*This .sig left intentionally blank*
