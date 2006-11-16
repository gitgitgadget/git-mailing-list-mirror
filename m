X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-checkout: allow pathspec to recover lost working tree directory
Date: Wed, 15 Nov 2006 18:00:35 -0800
Message-ID: <7vlkmcgngc.fsf@assigned-by-dhcp.cox.net>
References: <7vbqn8msuw.fsf@assigned-by-dhcp.cox.net>
	<ejge6q$bm7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 02:00:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ejge6q$bm7$1@sea.gmane.org> (Anand Kumria's message of "Thu, 16
	Nov 2006 01:17:15 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31542>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkWYS-0005og-Vn for gcvg-git@gmane.org; Thu, 16 Nov
 2006 03:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162158AbWKPCAh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 21:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162160AbWKPCAh
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 21:00:37 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51189 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1162158AbWKPCAg
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 21:00:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116020036.RBRI20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 21:00:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nE0i1V00C1kojtg0000000; Wed, 15 Nov 2006
 21:00:42 -0500
To: "Anand Kumria" <wildfire@progsoc.org>
Sender: git-owner@vger.kernel.org

"Anand Kumria" <wildfire@progsoc.org> writes:

> On Wed, 15 Nov 2006 11:07:19 -0800, Junio C Hamano wrote:
>
>> It is often wanted on the #git channel that this were to work to
>> recover removed directory:
>> 
>> 	rm -fr Documentation
>> 	git checkout -- Documentation
>> 	git checkout HEAD -- Documentation ;# alternatively
>> 
>> Now it does.
>
> One thing I often seem to do is make some changes, test them out and
> remove the file if it wa a dead end and get my original back with
> 'cg-restore <file>'. Does this mean that the git equivalent will be 'git
> checkout -- <file>' as well?

Naming individual files has been supported for a long time.
What this patch adds is an ability to name a whole directory to
restore to the index state or a named commit state).
