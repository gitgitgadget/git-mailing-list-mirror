X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Date: Fri, 08 Dec 2006 18:29:02 -0800
Message-ID: <7v64clg5u9.fsf@assigned-by-dhcp.cox.net>
References: <20061130115913.EA36C5BA19@nox.op5.se>
	<7vac1xg61s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 02:29:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vac1xg61s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 08 Dec 2006 18:24:31 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33791>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsrxe-0004ve-Rk for gcvg-git@gmane.org; Sat, 09 Dec
 2006 03:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760364AbWLIC3G (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 21:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760440AbWLIC3F
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 21:29:05 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37199 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760364AbWLIC3E (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 21:29:04 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209022903.IVLM4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 21:29:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wSUS1V00U1kojtg0000000; Fri, 08 Dec 2006
 21:28:27 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Although I've applied this long time ago (in git timescale
> anyway), this patch and the above rationale is wrong.
>
> 'diff --cached' is more in line with how 'apply --cached' works,
> not how 'apply --index' works.

Side note.  I do not think --index and --cached are a good pair
of words to express the different semantics (the former works on
the working tree through the index, the latter works only on the
cached data and not on the working tree).  I was only pointing
out that making 'diff --index' a synonym to 'diff --cached'
closes the door for the possibility to have these two semantics
that are consistently spelled (well, maybe "confusingly
spelled", but still consistently) between diff and apply.
