X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git push: add verbose flag and allow overriding of default target repository
Date: Mon, 30 Oct 2006 19:09:47 -0800
Message-ID: <7vbqntrxj8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org>
	<Pine.LNX.4.64.0610300825470.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 03:09:57 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610300825470.25218@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 30 Oct 2006 08:28:59 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30564>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gek0e-0005nB-Q8 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 04:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161520AbWJaDJt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 22:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161535AbWJaDJt
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 22:09:49 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15088 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1161520AbWJaDJt
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 22:09:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031030948.VMRY28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 22:09:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gr9U1V00P1kojtg0000000 Mon, 30 Oct 2006
 22:09:29 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> diff --git a/builtin-push.c b/builtin-push.c
> index f5150ed..3151fb7 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -10,7 +10,7 @@
>  
>  static const char push_usage[] = "git-push [--all] [--tags] [-f | --force] <repository> [<refspec>...]";
>  
> -static int all, tags, force, thin = 1;
> +static int all, tags, force, thin = 1, verbose;
>  static const char *execute;
>  
>  #define BUF_SIZE (2084)

By the way, has anybody noticed we use a funny value for the
buffer size?
