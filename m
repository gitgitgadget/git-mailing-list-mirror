From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix errno usage in connect.c
Date: Sat, 01 Jul 2006 17:09:48 -0700
Message-ID: <7vd5codfzn.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0606280956s4081029ci5b3cd1fdf4b10c97@mail.gmail.com>
	<20060701215626.GB29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 02:09:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwpX7-0003aW-6e
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 02:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWGBAJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 20:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWGBAJu
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 20:09:50 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46472 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750937AbWGBAJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 20:09:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702000949.FOM12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Jul 2006 20:09:49 -0400
To: Petr Baudis <pasky@suse.cz>, Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <20060701215626.GB29115@pasky.or.cz> (Petr Baudis's message of
	"Sat, 1 Jul 2006 23:56:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23090>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Wed, Jun 28, 2006 at 06:56:12PM CEST, I got a letter
> where Morten Welinder <mwelinder@gmail.com> said that...
>> It looks like connect.c waits too long before it uses errno in both copies
>> of git_tcp_connect_sock.  Both close and freeaddrinfo can poke any
>> non-zero value in there.
>
> Nice catch.
>
> ->8-
>
> errno was used after it could've been modified by a subsequent library call.
> Spotted by Morten Welinder.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>

Thanks.
