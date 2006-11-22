X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Struggling with tangled
Date: Wed, 22 Nov 2006 03:57:07 -0800
Message-ID: <7vu00rsnho.fsf@assigned-by-dhcp.cox.net>
References: <E1GmpTj-000235-2n@home.chandlerfamily.org.uk>
	<Pine.LNX.4.63.0611221233370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 11:57:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611221233370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 22 Nov 2006 12:35:52 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32082>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmqj4-0007Zu-9i for gcvg-git@gmane.org; Wed, 22 Nov
 2006 12:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753367AbWKVL5L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 06:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbWKVL5K
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 06:57:10 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60340 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1753367AbWKVL5J
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 06:57:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122115707.LOYK18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 22
 Nov 2006 06:57:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pnxF1V00H1kojtg0000000; Wed, 22 Nov 2006
 06:57:15 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 22 Nov 2006, Alan Chandler wrote:
>
>> 2) Some files get completely munged with conflict resolution markers 
>> every few lines.  Is there a simple way to say "don't use this file, but 
>> use the [stage2/stage3] sources of the merge". (ie one of the original 
>> inputs to the merge - and if so, which one is which)
>
> I find myself using
>
> 	git diff --ours <file>
>
> and
>
> 	git diff --theirs <file>
>
> in such a case sometimes. If I _know_ my version is good, I do
>
> 	git diff --ours <file> | git apply -R
>
> This also updates the index.

Good suggestion, but apply does not update the index without
being told to do so with --index, so I think the commandline
should be:

	git diff --ours <path> | git apply -R --index
