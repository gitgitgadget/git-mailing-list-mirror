From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Use the git binary in the search path by default
Date: Tue, 11 Jul 2006 12:56:24 -0700
Message-ID: <7vzmff3ogn.fsf@assigned-by-dhcp.cox.net>
References: <11526131782190-git-send-email-alp@atoker.com>
	<11526131781900-git-send-email-alp@atoker.com>
	<1152613179634-git-send-email-alp@atoker.com>
	<11526131791902-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 21:57:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0OLP-0007AI-BG
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 21:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWGKT42 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 15:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWGKT41
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 15:56:27 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:18424 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932121AbWGKT40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 15:56:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711195625.MZFV12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 15:56:25 -0400
To: Alp Toker <alp@atoker.com>
In-Reply-To: <11526131791902-git-send-email-alp@atoker.com> (Alp Toker's
	message of "Tue, 11 Jul 2006 11:19:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23732>

Alp Toker <alp@atoker.com> writes:

> Introduce a sensible default for the location of the git binary used by
> gitweb. This means one less option to configure when deploying gitweb if
> git is in the search path.

While I think the part of the change to make things go through
the single "git" wrapper is a good idea, the comment to "our
$GIT" that says "absolute path is optional" makes this change
more like "assume PATH your webserver process uses is sensible",
not "introduce a sensible default".

So I would prefer to do that part like this:

-# location of the git-core binaries
-our $gitbin = "/usr/bin";
+# core git wrapper -- if your webserver runs with a sensible PATH
+# you can just say "git" without using absolute pathname here.
+our $GIT = "/usr/bin/git";
