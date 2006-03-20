From: Petr Baudis <pasky@suse.cz>
Subject: Re: efficient cloning
Date: Tue, 21 Mar 2006 00:21:01 +0100
Message-ID: <20060320232101.GQ18185@pasky.or.cz>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us> <7vbqw1nakz.fsf@assigned-by-dhcp.cox.net> <7vu09tjy38.fsf@assigned-by-dhcp.cox.net> <200603201730.19373.Josef.Weidendorfer@gmx.de> <7voe00iupp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 00:21:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLTgC-0003Cv-Vh
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 00:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWCTXUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 18:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWCTXUu
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 18:20:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:17028 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964811AbWCTXUt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 18:20:49 -0500
Received: (qmail 17492 invoked by uid 2001); 21 Mar 2006 00:21:01 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe00iupp.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17771>

Dear diary, on Tue, Mar 21, 2006 at 12:04:34AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> I think what is reasonable is something like this:

<insert all of the arguments in my other mail here ;>

>  - If your repository was cloned with --use-separate-remote, the
>    upstream "master" is refs/remotes/master, so the same diff
>    can be had with "diff remotes/master master".

Which is ugly. There is no reason why you couldn't go on using 'origin'
which is shorter and we can usually still unambiguously decide what did
you mean (unless you have a local head/tag 'origin' _and_ a remote named
'origin' at the same time).

>  - Regardless of how you started your cloned repository, with an
>    $GIT_DIR/{remotes,refs/heads,refs/remotes} editor I hinted in
>    a separate message, you can rearrange things to organize the
>    refs/ hierarchy any way you want.

Yes, but that makes no sense to do when you usually need this only in
some very special cases (and then you ought to be able to set up the
weird thing yourself), while we can do the doubtlessly right thing in
the general case, WITHOUT confusing the user, WHILE keeping things tidy
and easy to use (and without excessive typing). In fact, you described
it yourself:

>    - You could for example arrange to track all my branches in
>      refs/remotes/junkio/, and if git-pasky were still alive,
>      Pasky's branches in refs/remotes/pasky.  If we had a "take
>      the unique tail-name anywhere under refs/" logic, the same
>      diff can be had with "diff junkio/master master".

Except that you can just name the refs/remotes/directory the same way
you name the remote repository identifier (be it a Git-style remote or
Cogito's remote branch).

I still don't get what's wrong on what I'm proposing. I'm not seeing the
disadvantages, if there are any.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
