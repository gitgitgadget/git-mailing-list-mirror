From: Petr Baudis <pasky@ucw.cz>
Subject: Re: fork optional branch point normazilation
Date: Sun, 17 Apr 2005 14:25:34 +0200
Message-ID: <20050417122534.GD1487@pasky.ji.cz>
References: <Pine.LNX.4.44.0504170451030.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 14:22:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN8mj-0006kK-W1
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 14:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVDQMZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 08:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVDQMZm
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 08:25:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39823 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261309AbVDQMZg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 08:25:36 -0400
Received: (qmail 15829 invoked by uid 2001); 17 Apr 2005 12:25:34 -0000
To: Brad Roberts <braddr@puremagic.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0504170451030.2625-100000@bellevue.puremagic.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 17, 2005 at 02:04:16PM CEST, I got a letter
where Brad Roberts <braddr@puremagic.com> told me that...
> This might not be how you intended git fork to behave, but without doing
> _something_ to protect the head parameter a bit, this is just asking for a
> corrutped .git/HEAD file.
> 
> commit 76faec069dfeae59c3ce5faaad10bdcded0cc908
> tree c291316b28eff4042c80850cd93445345a606835
> parent 1cdbc0a19b8d9b68f1f42735e2f14f1289823a63
> author Brad Roberts <braddr@puremagic.com> 1113738584 -0700
> committer Brad Roberts,,, <braddr@gameboy2> 1113738584 -0700
> 
> gitfork needs to normalize the optional third parameter before using it.
> 
> Index: gitfork.sh
> ===================================================================
> --- 51b1bddbbc05e50d5bbf1f9662e503c2e85d5e96/gitfork.sh  (mode:100755 sha1:e5692ea9bdbc39b028fe1e1205381da632541bab)
> +++ c291316b28eff4042c80850cd93445345a606835/gitfork.sh  (mode:100755 sha1:386148ae9a99739d06a09742ff4157d0f7e4e223)
> @@ -37,6 +37,7 @@
>  [ -e "$destdir" ] && die "$destdir already exists"
> 
>  [ "$head" ] || head=$(commit-id)
> +head=$(gitXnormid.sh -c $head)
> 
>  git lntree "$destdir"
>  echo $head >.git/heads/$name

commit-id always returns the normalized commit ID.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
