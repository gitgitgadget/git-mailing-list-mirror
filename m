From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Mon, 23 Oct 2006 01:41:54 +0200
Message-ID: <200610230141.54413.jnareb@gmail.com>
References: <200610230037.57183.jnareb@gmail.com> <7vd58k0wmx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 01:41:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbmwo-0006oA-9L
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 01:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWJVXlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 19:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWJVXlj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 19:41:39 -0400
Received: from hu-out-0506.google.com ([72.14.214.236]:32449 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750849AbWJVXli (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 19:41:38 -0400
Received: by hu-out-0506.google.com with SMTP id 28so916154hub
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 16:41:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PtZnrgKT3iLXG7e6T40HZ8vO+8IDBEudm61oUD7f/29HG3qcFCHq534WpT9eeykWlVEMx4DD9dpqWoO+G/XLznk3PpaOzZmPCR0eFjAIzNMPQYqXN8LA/HIUtQQbpJvb9jURgwgjbXqvnGhMCWD1fa3L/ZhBjuxzGVTqSLsQPyQ=
Received: by 10.66.244.10 with SMTP id r10mr6328465ugh;
        Sun, 22 Oct 2006 16:41:36 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id p32sm1489350ugc.2006.10.22.16.41.36;
        Sun, 22 Oct 2006 16:41:36 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vd58k0wmx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29808>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Add a kind of "next" view in the bottom part of navigation bar for
>> "commitdiff" view.
>>
>> For commitdiff between two commits:
>>   (from: _commit_)
Perhaps we should use "(from: _commit_ to: _commit_)" here...

>> For commitdiff for one single parent commit:
>>   (parent: _commit_)
>> For commitdiff for one merge commit
>>   (merge: _commit_ _commit_ ...)
>> For commitdiff for root (parentless) commit
>>   (initial)
>> where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
>> display, everything is perhaps unnecessary esc_html on display.
>>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> Would it even be necessary to use any SHA-1 name in these cases,
> I wonder.  Would it make the page less useful if we replace all
> of the above _commit_ with a fixed string, say, "parent"?

I decided on using _shortened_ SHA1 because I didn't like neither 
"(parent parent ...) " nor "(parent1 parent2 ...)" for merges. Perhaps 
I should have used 8-characters abbreviation, like in git_blame2.
And I was inspired by git-show output for merges:

 commit ff49fae6a547e5c70117970e01c53b64d983cd10
 Merge: 7ad4ee7... 75f9007... 14eab2b... 0b35995... eee4609...

> I always hated gitweb diffs that prefix each filepair with their
> full 40-byte SHA-1 blob object names.  It just adds noise to the
> output without adding any meaningful information.

I always thought about this only as a (somewhat sophisticated) separator 
marking where individual patch (patch for given files) begin. And
a place to click (non-hidden link) for blob before and after. Please 
remember that this gitweb diff header was from the times where we 
didn't have difftree in commitdiff view.

-- 
Jakub Narebski
Poland
