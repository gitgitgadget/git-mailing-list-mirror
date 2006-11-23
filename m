X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Thu, 23 Nov 2006 15:12:10 -0800
Message-ID: <7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
References: <20061123225835.30071.99265.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 23:12:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061123225835.30071.99265.stgit@machine.or.cz> (Petr Baudis's
	message of "Thu, 23 Nov 2006 23:58:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32168>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNk4-000115-Sh for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934244AbWKWXMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934246AbWKWXMQ
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:12:16 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32216 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S934244AbWKWXMO
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:12:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123231211.WUWN9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 18:12:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qPCK1V0071kojtg0000000; Thu, 23 Nov 2006
 18:12:19 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> and --use-immingled-remote can be used to get the original behaviour;
> it is also implied by --bare.

What's immingled?

> We get confused, frustrated and data-losing users *daily* on #git now
> because git-clone still produces the crippled repositories having the
> remote and local heads freely mixed together.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>

Being strongly opinionated, not giving enough credit for the
evolutionary process behind the history and venting frustration
in the proposed commit log message is never a good strategy to
get the patch applied.

Even though I fully agree that use-separate-remotes should be
the default, to the point that I do not think we do not even
need a backward compatibility option.  People who want to use
traditional layout for simple one-remote-branch-only project
would not suffer anyway because 'origin' still means origin in
the new layout (refs/remotes/origin/HEAD).

We would need to update the tutorials to match this,though.  I
think it talks about the traditional layout and say 'See, now
you can run "ls .git/refs/heads/{master,origin}"' or something
like that.
