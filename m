From: Junio C Hamano <junkio@cox.net>
Subject: Re: non-monotonic index when using http://?
Date: Mon, 21 Aug 2006 02:20:38 -0700
Message-ID: <7v64gmwil5.fsf@assigned-by-dhcp.cox.net>
References: <20060821084606.GI30022@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 11:21:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF5xn-0006Zq-IZ
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 11:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWHUJUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 05:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWHUJUk
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 05:20:40 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43199 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750897AbWHUJUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 05:20:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060821092039.CGUC21457.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Aug 2006 05:20:39 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060821084606.GI30022@admingilde.org> (Martin Waitz's message
	of "Mon, 21 Aug 2006 10:46:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25789>

Martin Waitz <tali@admingilde.org> writes:

> hoi :)
>
> At work I'm getting the following error message, any ideas?
>
>> git --version
> git version 1.4.2.rc4.g242a
>> git pull upstream
> Fetching refs/heads/master from http://git.kernel.org/pub/scm/git/git.git using http
> error: non-monotonic index
> walk 43134fcb350fb70d26634be163db1f71c14db19f
> walk 55c3eb434ab6d489c632263239be15a1054df7f2
> Getting alternates list for http://git.kernel.org/pub/scm/git/git.git/
> Getting pack list for http://git.kernel.org/pub/scm/git/git.git/
> error: non-monotonic index

The "non monotonic index" check is to make sure pack .idx file
is sane, and it appears that you are getting the error before
you fetch new pack from the server, which means one of your
local packs is bad.

I just cloned from the kernel.org archive over http (I usually
don't, but your report was alarming enough) and the packfile I
have there do not seem to have the problem.
