From: Junio C Hamano <junkio@cox.net>
Subject: Re: There you have it. Git.pm breaks pull.
Date: Sun, 02 Jul 2006 21:42:00 -0700
Message-ID: <7v64ifuwo7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607030633120.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 06:42:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxGGJ-0005tQ-Gh
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 06:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWGCEmD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 00:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWGCEmD
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 00:42:03 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:31639 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751298AbWGCEmB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 00:42:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703044201.JAIT6385.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 00:42:01 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607030633120.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 3 Jul 2006 06:35:22 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23154>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Can't locate Git.pm in @INC (@INC contains: 
> /home/gene099/lib/perl5/site_perl/5.8.0/i586-linux-thread-multi 
> /usr/lib/perl5/5.8.0/i586-linux-thread-multi /usr/lib/perl5/5.8.0 
> /usr/lib/perl5/site_perl/5.8.0/i586-linux-thread-multi 
> /usr/lib/perl5/site_perl/5.8.0 /usr/lib/perl5/site_perl .) at 
> ./git-fmt-merge-msg line 14.
> BEGIN failed--compilation aborted at ./git-fmt-merge-msg line 14.

You need to set up your PERL5LIB appropriately, in addition to
what you used to set: PATH and GIT_EXEC_PATH.  Something like
this, perhaps:

        PERL5LIB=`pwd`/perl/blib/lib:`pwd`/perl/blib/arch/auto/Git
        GIT_EXEC_PATH=`pwd`
        PATH=`pwd`:/usr/bin:/bin

        export GIT_EXEC_PATH PATH PERL5LIB
