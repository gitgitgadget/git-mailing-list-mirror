X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Seeing added and removed files between two tree states
Date: Mon, 04 Dec 2006 13:18:23 -0800
Message-ID: <7vwt57nyw0.fsf@assigned-by-dhcp.cox.net>
References: <1165253146.32764.3.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 21:18:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <1165253146.32764.3.camel@okra.transitives.com> (Alex Bennee's
	message of "Mon, 04 Dec 2006 17:25:45 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33252>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLCn-0007k6-DT for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937394AbWLDVS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 16:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937396AbWLDVS0
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:18:26 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:59631 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937394AbWLDVSZ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 16:18:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204211824.HZOC18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 16:18:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ulJZ1V00q1kojtg0000000; Mon, 04 Dec 2006
 16:18:34 -0500
To: Alex Bennee <kernel-hacker@bennee.com>
Sender: git-owner@vger.kernel.org

Alex Bennee <kernel-hacker@bennee.com> writes:

> In there a way to see just what files where added between two points in
> the tree? I want something better than parsing the diffstat.
>
> I thought git-ls-files -ad comittish..comitishb would do the trick but
> it seems not.

$ git diff-tree --name-status --diff-filter=A HEAD~64 HEAD

Variants of the above are possible.  If you want to see addition
and deletion, use --diff-filter=AD.

