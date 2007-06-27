From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Failure in t5516, tests 15 and 16
Date: Tue, 26 Jun 2007 21:59:42 -0400
Message-ID: <0EE674FF-3749-43CB-B1CB-7FCF5860D025@silverinsanity.com>
References: <4FAE3A62-A0D1-4C88-8413-88F1D75A2730@silverinsanity.com> <CFDE3792-403B-4582-B7FB-BC142B79AE63@silverinsanity.com> <7v4pkuuq5u.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:00:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3MpY-0007Rm-Gv
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbXF0B7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXF0B7p
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:59:45 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:52542 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbXF0B7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:59:44 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id D7C7B1FFC1CF;
	Wed, 27 Jun 2007 01:59:43 +0000 (UTC)
In-Reply-To: <7v4pkuuq5u.fsf@assigned-by-dhcp.pobox.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51004>


On Jun 26, 2007, at 9:44 PM, Junio C Hamano wrote:

> Can you check "cd t && sh -x t5516-fetch-push.sh -i -v"?
>
> I am suspecting that
>
>                 test "$( cd testrepo && git show-ref | wc -l )" = 1
>
> may have an interesting effect when "wc -l" emits extra
> whitespaces.  Does this fix it for you?

Exactly right.  This bit me a while back on some other test as well.   
Should have thought of it this time.  Removing the quotes (done  
manually, as it was faster than extracting your patch from the mail)  
fixed it and that test works properly now.  I'm now getting errors in  
some CVS test...  I'll figure that out later, but it appears  
completely unrelated.

I'm beginning to despise several of the OS X utilities.  I wonder if  
this is inherited from some BSD, or if it's all new.  Doesn't matter  
though, if you'd be so kind as to remove those quotes from git.git.  :-)

~~ Brian
