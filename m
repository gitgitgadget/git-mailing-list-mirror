From: Junio C Hamano <junkio@cox.net>
Subject: Re: git + ssh + key authentication feature-request
Date: Wed, 08 Feb 2006 15:55:34 -0800
Message-ID: <7vzml1mmmh.fsf@assigned-by-dhcp.cox.net>
References: <43EA73C3.2040309@iaglans.de>
	<7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>
	<43EA7D57.7040409@iaglans.de>
	<7v4q39o3xs.fsf@assigned-by-dhcp.cox.net>
	<43EA8DDA.3070906@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 00:55:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6zA1-0000mc-M6
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 00:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWBHXzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 18:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWBHXzh
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 18:55:37 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56249 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1422662AbWBHXzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 18:55:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208235428.PBFN15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 18:54:28 -0500
To: Nicolas Vilz 'niv' <niv@iaglans.de>
In-Reply-To: <43EA8DDA.3070906@iaglans.de> (Nicolas Vilz's message of "Thu, 09
	Feb 2006 01:33:30 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15766>

Nicolas Vilz 'niv' <niv@iaglans.de> writes:

> So, how do i tell git to send my identity-file to sshd? And could I
> set an alias like in .git/remotes for that location / identity?

That is not a git question but you are using me as an ssh
helpdesk.  See ssh_config(5).

The answers are:

	IdentityFile
        User

For example, I have this in my .ssh/config on my local machine:

    Host osiris.pyramid.com
      User junio
      IdentityFile ~/.ssh/osiris-pub
      ForwardAgent no
      ForwardX11 no

Without "User", it would send out "junkio", so I have that line
to override it (I could do it with -l command line, but there is
no point because that is I would use _always_ to go there).
Without "IdentityFile" it would use ~/.ssh/identity (same
rationale with -i), which is the identity file I usually use for
other sites.
