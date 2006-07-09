From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sun, 09 Jul 2006 13:33:04 -0700
Message-ID: <7v4pxqfri7.fsf@assigned-by-dhcp.cox.net>
References: <200607081732.04273.michal.rokos@nextsoft.cz>
	<20060709095114.GQ22573@lug-owl.de>
	<7vd5cfnkz4.fsf@assigned-by-dhcp.cox.net>
	<200607091441.16161.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 22:33:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzfxv-0005UV-Fj
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 22:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWGIUdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 16:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWGIUdP
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 16:33:15 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:25010 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1161127AbWGIUdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 16:33:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060709203314.EEUN12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 16:33:14 -0400
To: Michal Rokos <michal.rokos@nextsoft.cz>
In-Reply-To: <200607091441.16161.michal.rokos@nextsoft.cz> (Michal Rokos's
	message of "Sun, 9 Jul 2006 14:41:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23562>

Michal Rokos <michal.rokos@nextsoft.cz> writes:

> Hello,
>
> On Sunday 09 July 2006 12:14, Junio C Hamano wrote:
>> Michal, is there a reason you do not want to have the version of
>> perl you teach git tools via #! lines with PERL_PATH on your $PATH?
>
> I have no problem with that. I can set $PATH.
> But then I'd suggest to change magic #!
> from #!/usr/bin/perl
> to #!/usr/bin/env perl
> for *.perl
>
> It that what you meant?

No, that is not what I meant.

Invocation of perl _in_ scripts can be controlled by user's
PATH, but #! cannot be.  As Merlyn says 'env' is a nice hack,
but we configure the scripts we install to have #!  pointing at
the right interpreter as a more cleaner (than using 'env', that
is) workaround anyway, so #! pointing at PERL_PATH and scripts
relying on user's $PATH would be the right thing to do.
