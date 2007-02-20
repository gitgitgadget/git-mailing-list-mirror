From: Junio C Hamano <junkio@cox.net>
Subject: Re: git installation (as private user) should NEVER write site_perl
Date: Tue, 20 Feb 2007 10:21:59 -0800
Message-ID: <7vvehwvge0.fsf@assigned-by-dhcp.cox.net>
References: <86sld0sq7c.fsf@blue.stonehenge.com>
	<20070220175536.GC26444@gateway.home>
	<86abz8sodh.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Mouw <mouw@nl.linux.org>, git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue Feb 20 19:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJZct-0000uN-1o
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 19:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbXBTSWD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 13:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbXBTSWD
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 13:22:03 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37276 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbXBTSWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 13:22:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220182159.PZLF21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 13:21:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RuMz1W00d1kojtg0000000; Tue, 20 Feb 2007 13:22:00 -0500
In-Reply-To: <86abz8sodh.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Tue, 20 Feb 2007 09:57:46 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40250>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Erik" == Erik Mouw <mouw@nl.linux.org> writes:
>
> Erik> On Tue, Feb 20, 2007 at 09:18:15AM -0800, Randal L. Schwartz wrote:
>>> I tried to install git on a system where I was a normal user.  Of course,
>>> this step fails:
>>> 
>>> Installing /usr/perl5/site_perl/5.6.1/Error.pm
>>> Installing /usr/perl5/site_perl/5.6.1/Git.pm
>
> Erik> It gets installed in ~/share/perl/5.8.4/ when I compile as a normal
> Erik> user (git-1.5.0.1):
>
> Erik> Installing /home/erik/share/perl/5.8.4/Error.pm
> Erik> Installing /home/erik/share/perl/5.8.4/Git.pm
> Erik> Installing /home/erik/man/man3/private-Error.3pm
> Erik> Installing /home/erik/man/man3/Git.3pm
>
> Is that a personally-installed Perl though?  Those paths look suspicious.

Actually that is what I get on my Debian box (Perl is from
distribution).  I build with prefix=$HOME/git-next and get

        $ ls -lR ~/git-next/*/perl
        /home/junio/git-next/lib/perl:
        total 12
        drwxrwsr-x 3 junio junio 4096 2007-02-20 10:17 ./
        drwxrwsr-x 3 junio junio 4096 2007-02-20 10:17 ../
        drwxrwsr-x 3 junio junio 4096 2007-02-20 10:17 5.8.8/

        /home/junio/git-next/lib/perl/5.8.8:
        total 16
        drwxrwsr-x 3 junio junio 4096 2007-02-20 10:17 ./
        drwxrwsr-x 3 junio junio 4096 2007-02-20 10:17 ../
        drwxr-sr-x 3 junio junio 4096 2007-02-20 10:17 auto/
        -rw-rw-r-- 1 junio junio  221 2007-02-20 10:17 perllocal.pod

        /home/junio/git-next/lib/perl/5.8.8/auto:
        total 12
        drwxr-sr-x 3 junio junio 4096 2007-02-20 10:17 ./
        drwxrwsr-x 3 junio junio 4096 2007-02-20 10:17 ../
        drwxr-sr-x 2 junio junio 4096 2007-02-20 10:17 Git/

        /home/junio/git-next/lib/perl/5.8.8/auto/Git:
        total 12
        drwxr-sr-x 2 junio junio 4096 2007-02-20 10:17 ./
        drwxr-sr-x 3 junio junio 4096 2007-02-20 10:17 ../
        -rw-rw-r-- 1 junio junio   83 2007-02-20 10:17 .packlist

        /home/junio/git-next/share/perl:
        total 12
        drwxrwsr-x 3 junio junio 4096 2006-11-08 23:25 ./
        drwxr-sr-x 4 junio junio 4096 2006-11-08 23:25 ../
        drwxrwsr-x 2 junio junio 4096 2007-02-03 22:18 5.8.8/

        /home/junio/git-next/share/perl/5.8.8:
        total 32
        drwxrwsr-x 2 junio junio  4096 2007-02-03 22:18 ./
        drwxrwsr-x 3 junio junio  4096 2006-11-08 23:25 ../
        -r--r--r-- 1 junio junio 22332 2007-02-03 22:15 Git.pm

I have /usr/share/perl5/Error.pm that is packaged liberror-perl
from the distro.
