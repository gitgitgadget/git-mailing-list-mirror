X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added description for reversing git-update-index using --index-info
Date: Thu, 02 Nov 2006 18:40:28 -0800
Message-ID: <7vfyd1mew3.fsf@assigned-by-dhcp.cox.net>
References: <200611021113.01812.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 02:55:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30771>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfoyw-0003wO-4b for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752964AbWKCCka (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbWKCCka
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:40:30 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39376 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1752256AbWKCCk3
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:40:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103024029.NRJE18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:40:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2g71V00d1kojtg0000000 Thu, 02 Nov 2006
 21:40:08 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> +One particular use of --index-info is to reverse the effect of
> +"git-update-index frotz":
> +
> +------------
> +git ls-tree HEAD frotz | git update-index --index-info
> +------------
> +
> +This makes the index hold the file frotz from HEAD rather than from the
> +working copy.

Up to this point is good, but I am unhappy about the next example.

> +------------
> +git ls-tree -r HEAD | git update-index --index-info
> +------------
> +
> +Will undo everything except "git add" from the index, as
> +"git-ls-tree -r" lists everything in the last commit.

While this is correct in the mechanical sense, it _sucks_ as an
example, especially since you do not mention that the user would
most likely need to do 'git update-index --refresh' afterwards
to make the result useful.
