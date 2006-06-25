From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add msg_sep to diff_options
Date: Sun, 25 Jun 2006 04:40:42 -0700
Message-ID: <7v8xnlv4xx.fsf@assigned-by-dhcp.cox.net>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
	<20060624202153.1001a66c.tihirvon@gmail.com>
	<20060625135414.425580d1.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 13:40:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuSyt-0007md-21
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 13:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWFYLko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 07:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWFYLko
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 07:40:44 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:33734 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932383AbWFYLkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 07:40:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625114043.WLOK6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 07:40:43 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060625135414.425580d1.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Sun, 25 Jun 2006 13:54:14 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22616>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Add msg_sep variable to struct diff_options.  msg_sep is printed after
> commit message.  Default is "\n", format-patch sets it to "---\n".
>
> This also removes the second argument from show_log() because all
> callers derived it from the first argument:
>
>     show_log(rev, rev->loginfo, ...

Good catch.  Thanks.

> Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
> ---

I often wonder if the separator should be "\n---\n" instead when
I see something like the above, but do not change it yet please.

>   I'm not 100% sure if format-patch is the only one wanting "---\n".

git log --patch-with-stat should also show "---\n".

>   But I think "\n" should be used for every command that doesn't create
>   patches.

This sounds good.

We probably would want to have an output format testsuite to
catch regression.
