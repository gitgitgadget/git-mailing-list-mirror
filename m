From: Junio C Hamano <junkio@cox.net>
Subject: Re: [patch] munmap-before-rename, cygwin need
Date: Mon, 08 May 2006 13:51:10 -0700
Message-ID: <7vmzdsfdfl.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0605071258s7a0cb085r3f08e9981234255a@mail.gmail.com>
	<7vslnlk04v.fsf@assigned-by-dhcp.cox.net>
	<f36b08ee0605080747r24668152t20cc406e017454a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 22:51:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdChH-0000Gi-At
	for gcvg-git@gmane.org; Mon, 08 May 2006 22:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWEHUvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 16:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWEHUvM
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 16:51:12 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:22660 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750748AbWEHUvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 16:51:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508205111.WCUS27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 16:51:11 -0400
To: "Yakov Lerner" <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0605080747r24668152t20cc406e017454a9@mail.gmail.com>
	(Yakov Lerner's message of "Mon, 8 May 2006 14:47:01 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19776>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> You are right. Apply did not work when I gave it more than one
> patchfile on commandline (and --index option). I fixed this by
> zeroing active_nr and freeing active_cache in
> unmap_cache().

I suspect that essentially means you are forcing the cache to be
read again after writing it out, in which case I think you are
better off using NO_MMAP as Alex suggests.
