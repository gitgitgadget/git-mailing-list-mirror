From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 9/9] gitweb: Separate printing difftree in git_commit into git_difftree_body
Date: Mon, 14 Aug 2006 17:40:44 -0700
Message-ID: <7vfyfybzlf.fsf@assigned-by-dhcp.cox.net>
References: <200608140202.46160.jnareb@gmail.com>
	<200608140218.33872.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 02:40:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCmzC-0005E3-CA
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 02:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWHOAkr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 20:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWHOAkq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 20:40:46 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53209 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932762AbWHOAkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 20:40:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815004045.CQKG6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 20:40:45 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608140218.33872.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 14 Aug 2006 02:18:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25430>

Jakub Narebski <jnareb@gmail.com> writes:

> +		if ($status eq "A") { # created
>...
> +		} elsif ($status eq "D") { # deleted
>...
> +		} elsif ($status eq "M" || $status eq "T") { # modified, or type changed
>...
> +		} elsif ($status eq "R") { # renamed
>...
> +		} elsif ($status eq "C") { # copied
>...
> +		} # we should not encounter Unmerged (U) or Unknown (X) status

The body of these still seem to have quite a lot of
similarities.  Maybe further refactoring is in the works?
