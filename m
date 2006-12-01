X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Fri, 01 Dec 2006 03:00:41 -0800
Message-ID: <7vhcwfanja.fsf@assigned-by-dhcp.cox.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
	<Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7ixge8j2.fsf@assigned-by-dhcp.cox.net>
	<20061128131139.GA10874@coredump.intra.peff.net>
	<7v1wnnysrn.fsf@assigned-by-dhcp.cox.net>
	<20061201081117.GA20025@coredump.intra.peff.net>
	<7vlklranrt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 11:01:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vlklranrt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 01 Dec 2006 02:55:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32892>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq68N-0001Vs-9k for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936388AbWLALAo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936403AbWLALAo
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:00:44 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16888 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S936388AbWLALAm
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:00:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061201110042.IOHK5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Fri, 1
 Dec 2006 06:00:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tP0r1V00D1kojtg0000000; Fri, 01 Dec 2006
 06:00:51 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> What's wrong is that the ancestry graph around that commit
> roughly looks like this:
>
>          z---o---o---o
>         /             \
>   808239a--v1.4.3--o---*---o---v1.4.4
> ...
> While what blame outputs is technically correct, it is not very
> useful for this kind of application.  As you said, it probably
> makes sense to gray-out the lines that are blamed on boundary
> commits.
>
> Side note: one might be tempted to say "then blame v1.4.3 for
> lines that 808239a is blamed for", but that is a good

Gaah.  "that is NOT a good workaround".  Sorry about the wasted
bandwidth.

> workaround.  The original command line could have more than one
> bottom commits, and the final blame might go to a common
> ancestor of them, and we need to randomly choose between them,
> which is worse than telling the truth as we currently do.
