From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [RFC] Introduce Git.pm
Date: Thu, 22 Jun 2006 02:01:46 -0700
Message-ID: <7vfyhxtvgl.fsf@assigned-by-dhcp.cox.net>
References: <20060622003546.17760.23089.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 11:01:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtL4R-0005EZ-2O
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 11:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWFVJBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 05:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWFVJBs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 05:01:48 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25264 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932511AbWFVJBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 05:01:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622090147.XCER11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 05:01:47 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060622003546.17760.23089.stgit@machine.or.cz> (Petr Baudis's
	message of "Thu, 22 Jun 2006 02:35:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22314>

Petr Baudis <pasky@suse.cz> writes:

> This patch introduces a very basic and barebone Git.pm module
> with a sketch of how the generic interface would look like;

In addition to my previous comments...

> +  my $version = Git::generic_oneval('version');
> +  my $lastrev = $repo->generic_oneval('rev-list', '--all');
> +...
> +=item generic_oneline ( COMMAND [, ARGUMENTS... ] )
> +...
> +sub generic_oneline {
> +	my $fh = generic(@_);
> +	my $line = <$fh>;
> +	close $fh;
> +	chomp $line;
> +	return $line;
> +}

Let's have a cleaned up version of Git.pm, Makefile changes and
changes to git-fmt-merge-msg.perl that shows how to use the
module.  Being in-tree would help people to view, use and
comment on it.
