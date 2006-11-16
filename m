X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git can't merge two identical move file operation
Date: Thu, 16 Nov 2006 03:32:50 -0800
Message-ID: <7v1wo3bp99.fsf@assigned-by-dhcp.cox.net>
References: <6e1787fe0611160226r2d51d980t6899f1a1018b5fe5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 11:33:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <6e1787fe0611160226r2d51d980t6899f1a1018b5fe5@mail.gmail.com>
	(Alexander Litvinov's message of "Thu, 16 Nov 2006 16:26:37 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31571>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkfUH-0008E8-Ep for gcvg-git@gmane.org; Thu, 16 Nov
 2006 12:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161994AbWKPLcw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 06:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031165AbWKPLcw
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 06:32:52 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20976 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1031163AbWKPLcv
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 06:32:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116113251.JZZG9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 06:32:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nPYx1V00L1kojtg0000000; Thu, 16 Nov 2006
 06:32:57 -0500
To: "Alexander Litvinov" <litvinov2004@gmail.com>
Sender: git-owner@vger.kernel.org

"Alexander Litvinov" <litvinov2004@gmail.com> writes:

> Here is the example script:
>>git version
> git version 1.4.4
>> mkdir 1 && cd 1 && git init-db
> defaulting to local storage area
>> echo 1 > a && git add a && git commit -a -m '1'
> Committing initial tree 2ce1eef76631e82282e0f7f0cf9e6f3e9a4a0b1e

Could you try an exactly the same sequence except to make the
initial contents of the file 'a' a bit more meaningful (I
typically use COPYING file in git.git repository for something
like this), by replacing the above "echo 1 > a ..." line with:

	$ cat COPYING >a && git add a && git commit -a -m '1'

and see if it still breaks?  You do not need to change the later
modification to the file (i.e. "echo 2 >>a"), but only the above
single line change.
