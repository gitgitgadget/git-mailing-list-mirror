X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull and merging.
Date: Thu, 07 Dec 2006 23:07:41 -0800
Message-ID: <7vvekmn9vm.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	<200612071227.46194.Josef.Weidendorfer@gmx.de>
	<7vhcw7ttj9.fsf@assigned-by-dhcp.cox.net>
	<200612072354.01830.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 07:07:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612072354.01830.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Thu, 7 Dec 2006 23:54:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33665>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsZpi-0005c9-EZ for gcvg-git@gmane.org; Fri, 08 Dec
 2006 08:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424886AbWLHHHn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 02:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424890AbWLHHHn
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 02:07:43 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60261 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424886AbWLHHHm (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 02:07:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208070742.GAIK20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Fri, 8
 Dec 2006 02:07:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id w77s1V00W1kojtg0000000; Fri, 08 Dec 2006
 02:07:52 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> But that means I would never be able to benefit from the
>> convenience of "branch.*.merge";
>
> Hmm... that's true; actually, I did not thought about people
> which do not want to have any tracking branches (again!). So
>
> [remote "repo"]
>   url = ...
>   fetch = branch1
>   fetch = branch2
>
> [branch "mybranch1"]
>   remote = repo
>   merge = branch1
>
> actually looks fine, and is the only possible way.

Yeah, when you lay it out that way, it absolutely makes sense to
have "branch1" which is the name of the remote branch, not the
local counterpart that tracks it, as the value of the "merge"
configuration.

> But still, this does not work. You have to specify
>
>   merge = refs/heads/branch1
>
> That's confusing (perhaps I can come up with a patch
> to allow "branch1" alone).

I think that might make things easier to read, but it might
introduce ambiguities, especially you do not control the set of
remote branches and tags.
