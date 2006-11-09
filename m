X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Default to $hash_base or HEAD for $hash in "commit" and "commitdiff" views
Date: Wed, 08 Nov 2006 16:09:30 -0800
Message-ID: <7vejsdqy4l.fsf@assigned-by-dhcp.cox.net>
References: <200611082311.35161.jnareb@gmail.com>
	<7vvelpr34d.fsf@assigned-by-dhcp.cox.net>
	<200611082335.28296.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 00:09:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611082335.28296.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 8 Nov 2006 23:35:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31169>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhxU9-0005dK-Af for gcvg-git@gmane.org; Thu, 09 Nov
 2006 01:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422646AbWKIAJc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 19:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWKIAJc
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 19:09:32 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:2710 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1422646AbWKIAJb
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 19:09:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109000931.ZKRR9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 19:09:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kQ9c1V00N1kojtg0000000; Wed, 08 Nov 2006
 19:09:36 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

>> Probably the latter; the user might be hand-crafting a URL
>> (maybe learned a commit object name from mailing list and
>> cutting and pasting) and mispasted the long hexadecimal string.
>> Silently giving HEAD may leave the user confused than "oops, we
>> do not see that commit object".
>  
> No, if there is 'h' (hash) parameter provided, then gitweb tries
> to use this. HEAD is used _only_ if nether hash, nor hash_base
> are provided, i.e. for URL like below
>
>   URL?p=project.git;a=commit
>
> i.e. without neither 'h' nor 'hb'.

Ah, that one I agree it makes sense to use HEAD.  Also I am all
for giving a more readable error message.
