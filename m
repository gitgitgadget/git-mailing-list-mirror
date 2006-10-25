X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix bad usage of mkpath in builtin-branch.sh
Date: Wed, 25 Oct 2006 15:51:32 -0700
Message-ID: <7v3b9cko0b.fsf@assigned-by-dhcp.cox.net>
References: <1161655176461-git-send-email-hjemli@gmail.com>
	<7vlkn6qkh2.fsf@assigned-by-dhcp.cox.net>
	<20061024113806.GB20017@pasky.or.cz>
	<7vac3lf3jl.fsf@assigned-by-dhcp.cox.net>
	<7vslhddmtu.fsf@assigned-by-dhcp.cox.net>
	<20061025224313.GM20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 22:51:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061025224313.GM20017@pasky.or.cz> (Petr Baudis's message of
	"Thu, 26 Oct 2006 00:43:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30121>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcrb1-0003PD-3Y for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422627AbWJYWvf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWJYWvf
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:51:35 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:60889 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1422627AbWJYWve
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:51:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025225133.LSUM6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 18:51:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id emrG1V0041kojtg0000000 Wed, 25 Oct 2006
 18:51:16 -0400
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

>> +
>> +test "$ret" = 0 && git-diff-tree --summary --root --no-commit-id HEAD
>> +
>>  exit "$ret"
>
> Yes, this might be a good idea, although after the commit is perhaps too
> late.

Before the commit I thought we have git-status output in the
commit log buffer.

Ah,...

We had that old issue of "'M foo' cannot tell content or mode
changes (or both)", and people suggested "M+" and such which
were rejected because Porcelains and people's scripts depended
deeply on "diff --name-status" output being stable.
