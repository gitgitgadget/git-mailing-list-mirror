X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Fri, 24 Nov 2006 03:37:23 -0800
Message-ID: <7vodqxaxe4.fsf@assigned-by-dhcp.cox.net>
References: <20061123225835.30071.99265.stgit@machine.or.cz>
	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
	<20061123234203.GN7201@pasky.or.cz>
	<7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>
	<7vzmahe6qe.fsf@assigned-by-dhcp.cox.net>
	<7vpsbde4fy.fsf@assigned-by-dhcp.cox.net> <ek6glc$pn$1@sea.gmane.org>
	<20061124143200.52aa1901.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 11:37:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061124143200.52aa1901.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Fri, 24 Nov 2006 14:32:00 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32211>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnZN8-0001gD-9W for gcvg-git@gmane.org; Fri, 24 Nov
 2006 12:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933059AbWKXLhb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 06:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933874AbWKXLhb
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 06:37:31 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11451 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S933059AbWKXLha
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 06:37:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124113729.NCNC7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 06:37:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qbdc1V00Y1kojtg0000000; Fri, 24 Nov 2006
 06:37:37 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org

Sergey Vlasov <vsu@altlinux.ru> writes:

> BTW, this is broken (and was broken even in 1.4.3.x):
>
> $ mkdir ~/tmp/test_repo
> $ ( cd ~/tmp/test_repo; git-init-db )
> defaulting to local storage area
> $ git push ~/tmp/test_repo tag v1.4.4.1
> error: src refspec tag does not match any.
> error: dst refspec tag does not match any existing ref on the remote and does not start with refs/.
> fatal: unexpected EOF
>
> Omitting the "tag" word works:

I think this was broken when git-push was made a built-in, and
the documentation was not updated.

I use only tags in vN.M.L.. format and Linus does so too, so
probably that was one of the reasons why this was not noticed
for quite some time.

Fixes welcome, preferably to the builtin-push.c not to the
documentation.
