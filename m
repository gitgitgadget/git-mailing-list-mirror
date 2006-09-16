From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Skip t3403 selftests if stdin is not a terminal
Date: Fri, 15 Sep 2006 22:39:26 -0700
Message-ID: <7vk644e5f5.fsf@assigned-by-dhcp.cox.net>
References: <20060915125910.10514.qmail@26499ea44f2ee3.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 07:39:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOStp-0008Uf-5X
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 07:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWIPFj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 01:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWIPFj2
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 01:39:28 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61393 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932181AbWIPFj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 01:39:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916053926.XHSC18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 01:39:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NtfU1V00A1kojtg0000000
	Sat, 16 Sep 2006 01:39:28 -0400
To: Gerrit Pape <pape@smarden.org>
In-Reply-To: <20060915125910.10514.qmail@26499ea44f2ee3.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Fri, 15 Sep 2006 12:59:10 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27109>

Gerrit Pape <pape@smarden.org> writes:

> sh t3403-rebase-skip.sh </dev/null fails because stdin is not connected
> to a terminal, as in the Debian autobuild environment.  This disbales
> the test 3 and 7 in this case.

Disabling these tests somehow feels as if you are shooting the
messenger who reports breakage of the commands they try to test.

Is it expected that the git Porcelainish commands involved in
these particular tests not to work without terminal?  If not
maybe we should fix them, not the test.
