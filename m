From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing a single tag (ref + object)?
Date: Wed, 19 Oct 2005 09:58:12 -0700
Message-ID: <7vvezt8mvv.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510131929m3dac4cc5y6071550e9e9c71ad@mail.gmail.com>
	<46a038f90510182305j1fa2c4bh6d2b36c2fdd058ce@mail.gmail.com>
	<Pine.LNX.4.64.0510190702360.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 18:58:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESHGb-0008Dt-Ah
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 18:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVJSQ6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 12:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVJSQ6O
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 12:58:14 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:26243 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750799AbVJSQ6N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 12:58:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019165756.HLSK4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 12:57:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510190702360.3369@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 19 Oct 2005 07:13:49 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10296>

Linus Torvalds <torvalds@osdl.org> writes:

> It does all this magic to set "x", but then it never uses it, and uses 
> "$@" instead after all. Which it has shifted all away. 

Your /bin/sh scripting is rotting ;-) That is not a variable.
If you saw the script actually used the value 'x' then you have
spotted a bug.

That 'x' is not a magic but an old idiom to protect 'set' from
getting confused by "$1" that happens to begin with a '-'.
Setting random things is done by "set x random things"
immediately followed by shifting that x away.
