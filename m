From: Junio C Hamano <junkio@cox.net>
Subject: Re: Improve "git grep" flags handling
Date: Mon, 12 Sep 2005 15:37:18 -0700
Message-ID: <7vd5nd7w0x.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
	<7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
	<Pine.LNX.4.58.0509121519310.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 00:38:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEwvT-0001fb-Ue
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 00:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVILWhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 18:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVILWhU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 18:37:20 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:19161 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750876AbVILWhT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 18:37:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912223717.GUWO8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 18:37:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509121519310.3266@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Sep 2005 15:22:44 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8445>

Linus Torvalds <torvalds@osdl.org> writes:

> +  # git-ls-file specific flags
> +  --others|--exclude=*|--exclude-from=*|--exclude-per-directory=*)
> +      git_flags="$git_flags $pattern"
> +      shift
> +      ;;

This would not fly well, I am afraid.  --exclude=* are usually
shell globs which would be expanded before you use them
unquoted.
