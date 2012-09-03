From: Mark Hills <Mark.Hills@framestore.com>
Subject: Re: Clone to an SSH destination
Date: Mon, 3 Sep 2012 14:15:27 +0100 (BST)
Message-ID: <alpine.LFD.2.01.1209031410450.5945@sys880.ldn.framestore.com>
References: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com> <20120903154732.5fb50b173fa51db8300624b3@domain007.com> <CAMK1S_iSbDNc39XjWZLgUJuBg71+A+CHbEq09QG+mntDQrdNxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 15:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8WVF-0007BH-2D
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 15:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372Ab2ICNPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 09:15:38 -0400
Received: from mx5.framestore.com ([193.203.83.15]:44988 "EHLO
	mx5.framestore.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab2ICNPi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 09:15:38 -0400
Received: from vm-zimbra.ldn.framestore.com ([172.16.73.68] helo=zimbra.framestore.com)
	by mx5.framestore.com with esmtp (Exim 4.72)
	(envelope-from <Mark.Hills@framestore.com>)
	id 1T8WV2-0004nj-56; Mon, 03 Sep 2012 14:15:36 +0100
Received: from sys880.ldn.framestore.com (sys880.ldn.framestore.com [172.16.84.100])
	by zimbra.framestore.com (Postfix) with ESMTPA id 968EC1FD85D6;
	Mon,  3 Sep 2012 14:15:06 +0100 (BST)
In-Reply-To: <CAMK1S_iSbDNc39XjWZLgUJuBg71+A+CHbEq09QG+mntDQrdNxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204691>

On Mon, 3 Sep 2012, Sitaram Chamarty wrote:

> On Mon, Sep 3, 2012 at 5:17 PM, Konstantin Khomoutov
> <flatworm@users.sourceforge.net> wrote:
> > On Mon, 3 Sep 2012 11:21:43 +0100 (BST)
> > Mark Hills <Mark.Hills@framestore.com> wrote:
> 
> [snip]
> 
> >> This is quite cumbersome; we have a large team of devs who use a
> >> simple 'git clone' to an NFS directory, but we wish to retire NFS
> >> access.
> 
> [snip]
> 
> > gitolite kind of implements this ("wild repos") [1], you could look if
> > it suits your needs.
> 
> The simplest conf to do what you want in gitolite is something like this:
> 
>     repo [a-zA-Z0-9]..*
>         C   =   @all
>         RW+ =   @all
> 
> But of course your *user* authentication will probably change quite a
> bit, since gitolite runs as one Unix user and merely simulates many
> "gitolite users", while in the NFS method each of your devs probably
> has a full login to the server.

I'll check out gitolite, thanks.

We use unix users extensively (groups, permissions etc.) with YP, and this 
works well; a separate permissions scheme is not very desireable.

The ssh method works very well right now, and nicely transparent. It's 
only the initial clone/creation that is harder than it was over NFS. And 
it prevents the use of git-shell too.

Thanks

-- 
Mark
