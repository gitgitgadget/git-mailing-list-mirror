From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make git-rev-list and git-rev-parse argument parsing stricter
Date: Wed, 25 Jan 2006 14:40:35 -0800
Message-ID: <7vhd7sorrw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0601251655580.2644@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 23:41:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1tJx-0003Gx-Cu
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 23:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWAYWkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 17:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWAYWkn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 17:40:43 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64157 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932197AbWAYWkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 17:40:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060125223912.BVG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 17:39:12 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601251655580.2644@evo.osdl.org> (Linus Torvalds's
	message of "Wed, 25 Jan 2006 17:00:37 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15140>

Linus Torvalds <torvalds@osdl.org> writes:

> If you pass it a filename without the "--" marker to separate it from
> revision information and flags, we now require that the file in question
> actually exists. This makes mis-typed revision information not be silently
> just considered a strange filename.
>...
> Comments?

I think it is a good safety measure.  People has to say "git
rev-list -- git-commit-script" if they are interested in
historical paths, but that is less common.  We could even go
stronger and always require '--', but that is probably too much
for normal use.  I like the balance you struck here.
