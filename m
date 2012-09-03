From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Clone to an SSH destination
Date: Mon, 3 Sep 2012 18:08:32 +0400
Message-ID: <20120903180832.f6e9fc03a450011ea2b22737@domain007.com>
References: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com>
	<CACBZZX7Pe5gsfpFTihE33a1Exia_4dbMQ9p_Xc_z4Ry=Et9KLA@mail.gmail.com>
	<alpine.LFD.2.01.1209031351200.5945@sys880.ldn.framestore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
	<avarab@gmail.com>, git@vger.kernel.org
To: Mark Hills <Mark.Hills@framestore.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 16:09:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8XKp-0004gf-BZ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 16:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab2ICOI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 10:08:56 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:39260 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab2ICOI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 10:08:56 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q83E8XPh005146;
	Mon, 3 Sep 2012 18:08:35 +0400
In-Reply-To: <alpine.LFD.2.01.1209031351200.5945@sys880.ldn.framestore.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204696>

On Mon, 3 Sep 2012 14:07:48 +0100 (BST)
Mark Hills <Mark.Hills@framestore.com> wrote:

[...]
> > But I'm actually more curious about why you need this in the first
> > place, there's a bunch of devs where I work as well, but they never
> > have the need to create new repos on some NFS drive in this manner.
> 
> Without a command-line onto the filesystem (either local or NFS), how
> do you create a new repository for a new project?
> 
> We have a fairly large team on a diverse set of projects. Projects
> come and go, so it's a burden if the administrator is needed just to
> create repos.
> 
> Likewise, it's a step backwards for the developer to need to login 
> themselves over SSH -- whereas 'git clone' is so easy to NFS.
> 
> > What are your devs doing when they do clone their current working 
> > directory to some NFS location, maybe there's a better way to do it.
> 
> Most projects start as a small test at some point; eg.
> 
>   mkdir xx
>   cd xx
>   git init
>   <write some code>
>   git commit
>   ...
> 
> When a project becomes more official, the developer clones to a
> central location; eg.
> 
>   git clone --bare . /net/git/xx.git
> 
> This is the step that is inconvenient if only SSH access is available.

Well, then it looks you want something like github.
In this case look at some more integrated solution such as Gitlab [1]
-- I did not try it, but it looks like you import your users there and
then they can log in, add their SSH keys and create their projects.

I also think gitolite has some way to actually use regular SSH users
(or even users coming from a web server which is a front-end for Smart
HTTP Git transport, doing its own authentication).  This is explained
in [2], and I hope Sitaram could provide more insight on setting things
up this way, if needed  (I did not use this feature).

1. http://gitlabhq.com/
2. http://sitaramc.github.com/gitolite/g2/auth.html
