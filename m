From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to resolve git-am conflict (possible bug)
Date: Fri, 11 Aug 2006 18:01:32 -0700
Message-ID: <7vzmearclv.fsf@assigned-by-dhcp.cox.net>
References: <ebj7er$64j$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 12 03:01:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBhsi-0004U2-Ov
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 03:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWHLBBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 21:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWHLBBg
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 21:01:36 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61883 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964813AbWHLBBf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 21:01:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812010135.KUUH6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Aug 2006 21:01:35 -0400
To: git@vger.kernel.org
In-Reply-To: <ebj7er$64j$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	12 Aug 2006 02:30:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25247>

Jakub Narebski <jnareb@gmail.com> writes:

> 1078:jnareb@roke:~/git> rm -rf .dotest/
> 1079:jnareb@roke:~/git> git reset --hard
> 1080:jnareb@roke:~/git> git am --3way --utf8 --keep --binary \
>   mdir.0/0001-gitweb-Refactor-git_history_body.txt
>
> Applying '[PATCH 1/1] gitweb: Refactor git_history_body'
>
> error: patch failed: gitweb/gitweb.perl:2295
> error: gitweb/gitweb.perl: patch does not apply
> error: patch failed: gitweb/gitweb.perl:2295
> error: gitweb/gitweb.perl: patch does not apply
> Patch failed at 0001.
> When you have resolved this problem run "git-am -3 --resolved".

This is not falling back to three-way.  One likely reason is you
do not have blobs identified on the "index " line of the patch
in your repostory.
