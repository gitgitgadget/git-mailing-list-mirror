From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Mon, 26 Sep 2005 22:28:16 -0700
Message-ID: <7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
	<7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<20050926222944.GG26340@pasky.or.cz>
	<7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
	<8764snyufn.fsf@ualberta.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 27 07:28:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK80t-000862-8D
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 07:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVI0F2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 01:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVI0F2U
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 01:28:20 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45037 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964816AbVI0F2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 01:28:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927052817.OMIN2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 01:28:17 -0400
To: Tom Prince <tom.prince@ualberta.net>
In-Reply-To: <8764snyufn.fsf@ualberta.net> (Tom Prince's message of "Mon, 26
	Sep 2005 23:02:36 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9369>

Tom Prince <tom.prince@ualberta.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Now you completely lost me.  I really do not understand what you
>> mean by tags caching and re-slurping.
>
> I think Petr is interested in the case where the user hasn't asked for a
> particular tag. He wants to automatically grab all the tags in a repository,
> or at least those that refer to a branch being downloaded.

Ah, _automatically_ was the key.

If all you had were tags and there were no branches (the "I
could have done without maint branch"), that kind of automatic
grabbing would not work well anyway.  I personally feel that is
a lost cause.  The user can run 'git ls-remote' himself to find
out if there are new tags on the remote side and ask for them if
needed.

Also, I feel names under refs/ is local to the repository, but
if the tags are automatically grabbed, I presume they are stored
directly under the same name in refs/tags as the remote side has
them?
