From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 18:07:14 -0700
Message-ID: <7vzmg35pkt.fsf@assigned-by-dhcp.cox.net>
References: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<m1k678yt6m.fsf@ebiederm.dsl.xmission.com>
	<20060622220201.19132.67536.stgit@machine.or.cz>
	<7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	<20060622235017.GH21864@pasky.or.cz>
	<7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<20060623123904.GL21864@pasky.or.cz>
	<7vejxf74e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 24 03:07:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtwcM-0005Oh-H2
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 03:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWFXBHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 21:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933172AbWFXBHS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 21:07:18 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:22739 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932346AbWFXBHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 21:07:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624010715.JDBN12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 21:07:15 -0400
To: git@vger.kernel.org
In-Reply-To: <7vejxf74e3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 23 Jun 2006 18:01:56 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22464>

Junio C Hamano <junkio@cox.net> writes:

>> It should be enough to -I../perl/blib/lib -I../perl/blib/arch/auto/Git.
>
> -- >8 --
> [PATCH] Perl interface: add build-time configuration to allow building with -fPIC
>
> On x86-64 it seems that Git.xs does not link without compiling
> the main git objects with -fPIC.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Eh, sorry this was in response to this part of Pasky's message:

>> Well, for the .xs you do need an .so and for that you apparently need
>> -fPIC on most architectures, so there's no way around it.
>> 
>> There's a patch to build libgit.so, would you take it as an excuse to
>> always compile with -fPIC? ;-)

By the way, I noticed NO_ACCURATE_DIFF is a compile time option
to cause git-apply to accept diff output from implementations
that botch "\No newline at the end of file", and I think it is
wrong -- it should be a run time option to git-apply if we would
want to support it, because the version of diff you have does
not have much to do with which implementations of diff were used
to generate patches you would receive and apply.

Thoughts?
