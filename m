From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 13:43:26 -0800
Message-ID: <7vfy90v729.fsf@assigned-by-dhcp.cox.net>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 22:43:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJclm-000170-Or
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 22:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbXBTVn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 16:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbXBTVn2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 16:43:28 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54953 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030434AbXBTVn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 16:43:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220214326.SHHD21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 16:43:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RxjS1W0071kojtg0000000; Tue, 20 Feb 2007 16:43:26 -0500
In-Reply-To: <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 20 Feb 2007 09:41:44 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40263>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (In fact, it might be perfectly fine to have just a *single* cache, which 
> is keyed on the dirname of the pathname: if the dirname changes, just 
> throw the cache away, and read it in from all the subdirectories leading 
> to that directory - you'd still re-read stuff, but all the common cases 
> will walk the directory structure in a nice pattern, so you'd have a very 
> simple cache that actually gets good cache hit behaviour)

I'd agree that we can start with just a single one at the
toplevel and if somebody wants to extend it we can do so later.

>>   One thing that might be tricky is what should be done while making a
>>   merge or checking out from a tree.  Ideally, the information should be
>>   read from the tree that is being extracted, but that would make the
>>   code structure a little bit, eh, "interesting".
>
> No, that would be pretty horrid. So just tell everybody that it's based on 
> the working tree. I don't think it's likely to be a problem in practice.

Except for the initial checkout...
