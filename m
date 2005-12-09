From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Fri, 09 Dec 2005 00:06:02 -0800
Message-ID: <7vlkyu7l05.fsf@assigned-by-dhcp.cox.net>
References: <20051208202555.GA3046@steel.home>
	<7vu0dje2oi.fsf@assigned-by-dhcp.cox.net>
	<20051208210251.GB19423@steel.home>
	<7v7jafcmev.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512082336i674932bapd631d559e80cad79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 09:06:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkdGa-0000Cw-8d
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 09:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVLIIGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 03:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVLIIGE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 03:06:04 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24454 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932487AbVLIIGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 03:06:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209080445.ISKE17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 03:04:45 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512082336i674932bapd631d559e80cad79@mail.gmail.com>
	(Alex Riesen's message of "Fri, 9 Dec 2005 08:36:33 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13418>

Alex Riesen <raa.lkml@gmail.com> writes:

> An accident? Like a filesystem not supporting executable permission?
> What is the reason to report success from the test run in that conditions?

Let's be reasonable.  I was hoping to hear from you a real-world
breakage case that I overlooked due to my lack of access to
platforms you may have access to.  I am not interested in a
theoretical failure case discussion very much.  If your
filesystem does not support executables, why do you expect
things to run from the freshly built directory to begin with?

Linkage error of git-init-db (or git wrapper) may leave the file
created but leave that in unexecutable form, which could be a
valid concern, but that would signal an error to the make during
the build stage, and "test" target depends on "all" target.

And please do not start arguing that you can cd to 't' directory
after such a build failure and manually say "make".  You can do
that without even running make at the top level and cause the
same failure.  I consider both of them pilot errors.
