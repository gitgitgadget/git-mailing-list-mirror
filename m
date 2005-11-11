From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] C implementation of the 'git' program.
Date: Thu, 10 Nov 2005 23:40:07 -0800
Message-ID: <7vveyzskdk.fsf@assigned-by-dhcp.cox.net>
References: <20051110182631.3C5615BF90@nox.op5.se>
	<m3lkzv4qnz.fsf@harinath.blr.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 08:40:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaTWA-0004Ax-Nq
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 08:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVKKHkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 02:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVKKHkK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 02:40:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34739 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932186AbVKKHkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 02:40:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111073935.JCUV4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 02:39:35 -0500
To: Raja R Harinath <rharinath@novell.com>,
	exon@op5.se (Andreas Ericsson)
In-Reply-To: <m3lkzv4qnz.fsf@harinath.blr.novell.com> (Raja R. Harinath's
	message of "Fri, 11 Nov 2005 12:28:08 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11568>

Raja R Harinath <rharinath@novell.com> writes:

> This is bad, since it does the wrong thing for the correct way:
>
>   make prefix=/usr
>   sudo make prefix=/usr install
>
> With your patch 'git' will be compiled as root.

You are correct.

We should allow building as user and installing as root, with
the installation step _not_ touching the build directory at all.
A good litmus test is that you should be able to build and
install from a root-squashed NFS mounted working tree, without
giving write permissions to NFS-nobody user (obviously you need
to give read and search permissions).

Andreas?
