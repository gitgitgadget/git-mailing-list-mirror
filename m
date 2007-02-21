From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-remote: support remotes with a dot in the name
Date: Tue, 20 Feb 2007 23:32:06 -0800
Message-ID: <7vr6skrmo9.fsf@assigned-by-dhcp.cox.net>
References: <20070221050336.26431.46485.stgit@dv.roinet.com>
	<7vwt2ct79x.fsf@assigned-by-dhcp.cox.net>
	<20070221004631.q4npyww808k88s0o@webmail.spamcop.net>
	<7vfy90t4mo.fsf@assigned-by-dhcp.cox.net>
	<20070221021206.8onspw0840gcs8ck@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 08:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJlxW-00013z-I6
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 08:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbXBUHcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 02:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbXBUHcJ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 02:32:09 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49557 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161023AbXBUHcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 02:32:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221073207.YTRU1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 02:32:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id S7Y71W0011kojtg0000000; Wed, 21 Feb 2007 02:32:07 -0500
In-Reply-To: <20070221021206.8onspw0840gcs8ck@webmail.spamcop.net> (Pavel
	Roskin's message of "Wed, 21 Feb 2007 02:12:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40287>

Pavel Roskin <proski@gnu.org> writes:

> I was thinking of something like
>
> [remote "wireless-2.6"]
> url = http://foo/bar
> url.push = ssh://foo/bar

Ahh.

I was not taking the above use case into account when I wrote
that regexp, because I do not think we ever supported (nor were
planning to ever support) names with dot at the third level.

> But I think it's quite unlikely to be named like that.

The second level ("wireless-2.6") is designed to be more lenient
to accept wider "user level names" for branches, remotes, etc.,
but the third level is for variable names the programs use, and
it is not the question of likely/unlikely, but more about how we
(as the git system builders, not the end users) want to name our
variables.  So I do not think it is not such a big deal if we do
not support "url.push" variable.

>> But my Perl is rusty, so please double check it.
>
> The "(\S*?)" construct looks weird (you probably meant to use "(\S*)" for the
> remote name), but the rest is probably OK.  I'll send the "double-checked"
> patch tomorrow unless you beat me at that.

Actually I did mean to write "*?"; wasn't it how minimal match
is written?
