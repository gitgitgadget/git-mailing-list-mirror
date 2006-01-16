From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 08:48:12 +0100
Message-ID: <81b0412b0601152348x1a8e7dy19dce8fcdd9b812b@mail.gmail.com>
References: <43C52B1F.8020706@hogyros.de>
	 <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
	 <43C537C9.4090206@hogyros.de>
	 <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
	 <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	 <43C951B6.5030607@gmail.com>
	 <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 08:48:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyP69-0001dP-FK
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 08:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWAPHsP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 02:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWAPHsP
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 02:48:15 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:53092 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932244AbWAPHsO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 02:48:14 -0500
Received: by uproxy.gmail.com with SMTP id m3so550078uge
        for <git@vger.kernel.org>; Sun, 15 Jan 2006 23:48:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W/hPRMfXS/ZYvp4IL+W7R7GVVSzwuSEto95eqWNFwurh9+mTV4oOnwAhK/dHeYOjp4PStz/QgXeAimzpYdx/ZQ1QZZA35g84O2J9iYXq7FSmZ56ygYJBf15xJtHvLWtmAkg3uWY3kyn5fZvC+q0py5dqlmBFxcuiTrmuWygW4Hs=
Received: by 10.48.212.16 with SMTP id k16mr212188nfg;
        Sun, 15 Jan 2006 23:48:12 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Sun, 15 Jan 2006 23:48:12 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14727>

On 1/14/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > So far I've not seen any convincing arguments why the sub-projects can not be
> > managed by the Makefile, or equivalent, of the super-project. Particularly
> > when the sub-projects have a life of their own.
>
> Now, from a developer standpoint I actually agree with you. I find
> sub-projects totally useless - I'm much happier just having separate
> trees.
>
> The advantage (as far as I can tell) of sub-projects is not that they are
> easier to develop in, but that it's a total nightmare for the technical
> _user_ to download ten different projects from ten different sites, and
> configure them properly and install them in the right order, and keep them
> up-to-date.
>
> There are projects that I simply gave up even trying to track: I wasn't
> interested in being a developer per se, but I _was_ interested in trying
> to test and give feedback to the current development tree - but it was
> just too damn confusing to get it working.
>
> If I could have just done a "git clone <top-level>" to get it all, I'd
> have been a much more productive user.
>
> This is why I think sub-projects are more about "git checkout" and an
> automated "git fetch" than anything else. Doing actual development etc you
> can easily do one project at a time. "git diff" and "git commit" wouldn't
> need any real ability to recurse into subprojects and try to make it
> seamless. And if you do a "git pull" that needs to do anything but
> fast-forward, you might as well resolve the sub-projects one by one.

That is exactly how subprojects are used in Perforce- and ClearCase-like SCM:
the working tree is "configured" to contain the super-project (build
configuration)
and the actual work happens in the subproject and _only_ there. The mentioned
systems even have heavily used permission system just to prevent either
checkout or commit anywhere outside the area of responsibility of a developer.
(The "permissions" are somehow pointless in git context, just mentioned them
to underline the main point).
