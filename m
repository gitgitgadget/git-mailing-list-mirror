From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem upgrading to 1.4.0
Date: Sat, 10 Jun 2006 19:12:25 -0700
Message-ID: <7v1wtwh246.fsf@assigned-by-dhcp.cox.net>
References: <93c3eada0606101707t5eb35a4du3ebd0fd17737943f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 11 04:12:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpFRF-00037J-V3
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 04:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWFKCM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 22:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWFKCM1
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 22:12:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46027 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751555AbWFKCM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 22:12:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060611021226.VNYZ11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Jun 2006 22:12:26 -0400
To: git@vger.kernel.org
In-Reply-To: <93c3eada0606101707t5eb35a4du3ebd0fd17737943f@mail.gmail.com>
	(Geoff Russell's message of "Sun, 11 Jun 2006 09:37:16 +0930")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21631>

"Geoff Russell" <geoffrey.russell@gmail.com> writes:

> Hi,
>
> When I do a "git pull origin" I get messages:
>
>             error: no such remote ref refs/heads/gb/diffdelta
>             error: no such remote ref refs/heads/jc/bind
>             error: no such remote ref refs/heads/jc/bind-2
>             ...
>             Fetch failure: git://git.kernel.org/pub/scm/git/git.git
>...
> So I went into .git/remotes/origin and
> removed the lines pointing at these branches and removed the gb and jc
> directories
> and did another git pull and it seems to have worked.

This is the second time this same gotcha caused trouble here.  I
agree it would be sensible to make git-fetch (which is called by
git-pull) to detect stale entries in the remotes/origin file and
remote.origin.fetch configuration items.
