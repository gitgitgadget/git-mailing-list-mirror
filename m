From: Junio C Hamano <gitster@pobox.com>
Subject: Re: problem pushing repository
Date: Thu, 21 Jun 2007 19:00:18 -0700
Message-ID: <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Adam Mercer" <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 04:00:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1YRi-0000Ql-Kp
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 04:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbXFVCAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 22:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbXFVCAV
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 22:00:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62869 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbXFVCAU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 22:00:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070622020019.MEER2558.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Jun 2007 22:00:19 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ES0K1X00A1kojtg0000000; Thu, 21 Jun 2007 22:00:19 -0400
In-Reply-To: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
	(Adam Mercer's message of "Thu, 21 Jun 2007 21:49:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50665>

"Adam Mercer" <ramercer@gmail.com> writes:

> [ram@skymoo glue]$ git push
> ssh://ram@newberry.ihepa.ufl.edu/~ram/public_html/git/glue.git
> bash: line 1: git-receive-pack: command not found
> fatal: The remote end hung up unexpectedly
> error: failed to push to
> 'ssh://ram@newberry.ihepa.ufl.edu/~ram/public_html/git/glue.git'
> [ram@skymoo glue]$ which git-receive-pack
> /Users/ram/opt/git/bin/git-receive-pack
> [ram@skymoo glue]$
>
> git-receive-pack is in my $PATH so why can't it be found when trying to push?

Check your ssh and ssh server settings.  Often the process
invoked from non-interactive ssh connection (such as the attempt
to invoke receive-pack) would not get the PATH you set up in ~/.login
or ~/.bash_profile.

	$ ssh newberry.ihepa.ufl.edu sh -c 'echo $PATH'

may be a good starting point to test this, and the first step
to fix it would be

	$ man ssh
	$ man sshd
