X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 4/3] gitweb: SHA-1 in commit log message links to "object" view
Date: Sun, 10 Dec 2006 13:29:34 -0800
Message-ID: <7vhcw34eyp.fsf@assigned-by-dhcp.cox.net>
References: <7vk616ezu5.fsf@assigned-by-dhcp.cox.net>
	<11657536473295-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 21:29:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11657536473295-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Sun, 10 Dec 2006 13:25:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33931>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWEx-0004l3-W4 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 22:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933336AbWLJV3f (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 16:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933385AbWLJV3f
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 16:29:35 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:65134 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S933336AbWLJV3f (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 16:29:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210212934.HZSP15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Sun, 10
 Dec 2006 16:29:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id x9Uw1V00R1kojtg0000000; Sun, 10 Dec 2006
 16:28:57 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Instead of checking if explicit SHA-1 in commit log message is sha1 of
> commit and making link to "commit" view, make [fragment of] explicit
> SHA-1 in commit log message link to "object" view.  While at it allow
> to hyperlink also shortened SHA-1, from 8 characters up to full SHA-1,
> instead of requiring full 40 characters of SHA-1.
>
> This makes the following changes:
>
>  * SHA-1 of objects which no longer exists, for example in commit
>    cherry-picked from no longer existing temporary branch, or revert
>    of commit in rebased branch, are no longer marked as such by not
>    being made into hyperlink (and not having default hyperlink view:
>    being underlined among others).  On the other hand it makes gitweb
>    to not write error messages when object is not found to web serwer
>    log; it also moves cost of getting type and SHA-1 validation to
>    when link is clicked, and not only viewed.
>
>  * SHA-1 of other objects: blobs, trees, tags are also hyperlinked
>    and lead to appropriate view (although in the case of tags it is
>    more natural to just use tag name).
>
>  * You can put shortened SHA-1 of commit in the commit message, and it
>    would be hyperlinked; it would be checked on clicking if abbrev is
>    unique.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This follows the "lazy hyperlink" idea of symbolic link support in the
> "tree" view.
>
> It is an RFC (Requests For Comments) because I'm not sure if it
> wouldn't be better to make dead SHA-1 marked in commit log message,
> instead of finfing it out after clicking...

I am certainly in favor of the approach.  Will look at the code
later.  Thanks.
