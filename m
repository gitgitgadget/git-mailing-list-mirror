From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Install man3 manpages to $PREFIX/share/man/man3 even for site installs
Date: Thu, 19 Jul 2007 17:42:52 -0700
Message-ID: <7vzm1r29df.fsf@assigned-by-dhcp.cox.net>
References: <11848491502417-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "martin f. krafft" <madduck@madduck.net>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Fri Jul 20 02:43:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBgaG-0000hM-MU
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbXGTAm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbXGTAm4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:42:56 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:59477 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765445AbXGTAmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 20:42:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720004254.DRLR1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 20:42:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rcis1X00V1kojtg0000000; Thu, 19 Jul 2007 20:42:53 -0400
In-Reply-To: <11848491502417-git-send-email-madduck@madduck.net> (martin
	f. krafft's message of "Thu, 19 Jul 2007 14:45:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53045>

Randal, I cannot decide if this is the right thing to do, or 
better than what we currently do.  Could you care to enlighten
us please?

"martin f. krafft" <madduck@madduck.net> writes:

> MakeMaker supports three installation modes: perl, site, and vendor. The first
> and third install manpages to $PREFIX/share/man, only site installs to
> $PREFIX/man. For consistency with the rest of git, which does not make the
> distinction and writes all manpages to $PREFIX/share/man, this change makes
> sure that perl does too, even when it's installed in site mode.
>
> Signed-off-by: martin f. krafft <madduck@madduck.net>
> ---
>  perl/Makefile.PL |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
> index 4375161..6aecd89 100644
> --- a/perl/Makefile.PL
> +++ b/perl/Makefile.PL
> @@ -29,5 +29,6 @@ WriteMakefile(
>  	VERSION_FROM    => 'Git.pm',
>  	PM		=> \%pm,
>  	MAKEFILE	=> 'perl.mak',
> +	INSTALLSITEMAN3DIR => '$(SITEPREFIX)/share/man/man3',
>  	%extra
>  );
> -- 
> 1.5.3.rc2.19.gc4fba-dirty
