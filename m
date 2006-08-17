From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use action dispatcher for non-project actions, too.
Date: Wed, 16 Aug 2006 19:06:02 -0700
Message-ID: <7vk65815h1.fsf@assigned-by-dhcp.cox.net>
References: <11557673213372-git-send-email-tali@admingilde.org>
	<11557673212235-git-send-email-tali@admingilde.org>
	<1155767325181-git-send-email-tali@admingilde.org>
	<11557673263081-git-send-email-tali@admingilde.org>
	<11557673262714-git-send-email-tali@admingilde.org>
	<11557673281583-git-send-email-tali@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 04:06:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDXGw-0006ms-LI
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 04:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWHQCGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 22:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWHQCGE
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 22:06:04 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:51643 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932359AbWHQCGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 22:06:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817020603.BTZB554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 22:06:03 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <11557673281583-git-send-email-tali@admingilde.org> (Martin
	Waitz's message of "Thu, 17 Aug 2006 00:28:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25545>

Martin Waitz <tali@admingilde.org> writes:

> Allow to use the global action dispatcher for all actions by introducing
> "/actions".  If no project directory is given then a / is prepended to the
> action and the normal dispatcher is called.
> Project list and OPML generation are now hooked into the list as "/summary"
> and "/opml".
>
> As "/" is not an allowed character in actions accepted through the CGI
> parameters, it is still ensured that no normal action can be called without
> giving a valid project directory.
>
> Signed-off-by: Martin Waitz <tali@admingilde.org>
> ---
>  gitweb/gitweb.perl |   17 ++++++++---------
>  1 files changed, 8 insertions(+), 9 deletions(-)

You completely lost me.  What are you trying to achieve here?

I suspect this kind of funkies (and PATH_INFO) might be easier
to do in mod_rewrite() outside gitweb, but that is probably just
me.
