X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 18 Dec 2006 00:09:05 -0800
Message-ID: <7vac1l1v8e.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<200612172341.27709.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 08:09:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34726>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwDYi-0002Yg-AQ for gcvg-git@gmane.org; Mon, 18 Dec
 2006 09:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753469AbWLRIJH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 03:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbWLRIJH
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 03:09:07 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54996 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753469AbWLRIJG (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 03:09:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218080906.BIVR16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Mon, 18
 Dec 2006 03:09:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 089J1W0031kojtg0000000; Mon, 18 Dec 2006
 03:09:18 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Saturday 2006, December 16 23:10, Junio C Hamano wrote:
>
>>    * revisions recorded in the reflog can be pruned out,
>>      rendering some entries in reflog useless.
>
> Can I suggest that it should be fine to prune reflog entries but that the act 
> of pruning be a log entry itself?

I do not understand.  What would that "pruning event" log entry
would say?

By definition each reflog entry says "it was pointing at this
object before, and it was changed by this user to point at that
object at this time and the reason for the change was this".

I personally do not think recording "at this point these things
were pruned" makes _any_ sense whatsoever --- if you care about
the pruned objects that simply means you pruned them before you
are ready to lose them.  But even if for whatever reason you
choose to log that anyway, I have a feeling that that record
does not belong to the reflog itself.

