X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Subprojects tasks
Date: Sat, 16 Dec 2006 13:07:04 -0800
Message-ID: <7v64cbeeiv.fsf@assigned-by-dhcp.cox.net>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
	<20061216203553.GA25274MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 21:07:16 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061216203553.GA25274MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Sat, 16 Dec 2006 21:35:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34640>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvgkS-0005DQ-1v for gcvg-git@gmane.org; Sat, 16 Dec
 2006 22:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161477AbWLPVHH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 16:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161484AbWLPVHH
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 16:07:07 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52527 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161477AbWLPVHG (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 16:07:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216210705.QDYJ29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 16:07:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zZ7G1V01R1kojtg0000000; Sat, 16 Dec 2006
 16:07:17 -0500
To: skimo@liacs.nl
Sender: git-owner@vger.kernel.org

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Sat, Dec 16, 2006 at 10:32:36AM -0800, Junio C Hamano wrote:
>> I suspect the hardest part is "rev-list --objects" (now most of
>> it is found in revision.c).  [..]  But I think the updated
>> code needs to know that "link" needs to be unwrapped and
>> contained "commit" needs to be injected back to the ancestry
>> walking machinery.
>
> Do we want "link" to be unwrapped, though ?
>
>> Once you have "rev-list --objects", you should be able to drive
>> pack-objects with its output.
>
> Wouldn't we then run into the scalability problems Linus was
> concerned about ?

Hmph.

If the plumbing layer does not have to (although I haven't
thought it through, it does feel like it even shouldn't) unwrap
"link" and let the Porcelain layer to deal with it, that would
certainly make rev-list/revision.c part simpler.

I like it.

