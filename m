From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Support for snapshot
Date: Sat, 19 Aug 2006 14:49:54 -0700
Message-ID: <7vwt941jlp.fsf@assigned-by-dhcp.cox.net>
References: <44E54AC6.9010600@gmail.com>
	<20060818195148.66411.qmail@web31807.mail.mud.yahoo.com>
	<7v64gp7prk.fsf@assigned-by-dhcp.cox.net>
	<cc723f590608190110t68e6de8etbf6b5b002fd83ca1@mail.gmail.com>
	<7virkp3snv.fsf@assigned-by-dhcp.cox.net> <44E71888.30104@gmail.com>
	<ec76rd$8qf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 23:50:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEYhe-0004aG-0O
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 23:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWHSVt5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 17:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWHSVt4
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 17:49:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50857 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751829AbWHSVt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 17:49:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060819214955.YUKQ6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Aug 2006 17:49:55 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ec76rd$8qf$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	19 Aug 2006 16:22:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25737>

Jakub Narebski <jnareb@gmail.com> writes:

> Below comments to the patch.
>...
> Wouldn't it make it easier to understand code to put %feature hash 
> and gitweb_check_feature subroutine _before_ subroutines for specific
> features?
>
> It would be enough to put:
> $feature{'snapshot'} =  [\&feature_snapshot, 0, undef];

Yes; although actually even 'undef' is not needed, I think it
makes sense to have at least one there ;-).

> By the way, wouldn't it be better to use _hash_ for mixed meaning
> than _array_? I.e.
>
> our %feature =
> (
>        # feature       => {'sub' => feature-sub, 'override' => allow-override, 'default' => default options...]
>
>        'blame'         => {'sub' => \&feature_blame, 'override' => 0, 'default' => 0},
>    #or 'blame'         => {'sub' => \&feature_blame, 'override' => 0, 'default' => [ 0 ]},
>        'snapshot'      => {'sub' => \&feature_snapshot, 'override' => 0, 'default => [ 'x-gzip', 'gz', 'gzip' ]},
> );

I like it better except that you made it wider than my terminal
again making it a lot harder to read.
