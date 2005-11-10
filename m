From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: Check for differents trees
Date: Wed, 9 Nov 2005 22:35:02 -0800 (PST)
Message-ID: <20051110063502.44633.qmail@web26302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 07:35:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea61k-0003Ld-7k
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 07:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVKJGfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 01:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVKJGfF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 01:35:05 -0500
Received: from web26302.mail.ukl.yahoo.com ([217.146.176.13]:2452 "HELO
	web26302.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751131AbVKJGfE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 01:35:04 -0500
Received: (qmail 44635 invoked by uid 60001); 10 Nov 2005 06:35:02 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dQ7w22RJGPUqwGeEWo+7AgjDgLtJDKshNWpzodfz+tW9Whqj65aduXoUBy8/lsv7CYS6pHr/Uv2cy/IsX02get2ggdbU+yXBJ1jzVHmOabPsWVu6lm9I6wZe2OBwqZyWLRw7L8GYRect5DfA2XHvkmiR+bMQqgmrAjub1tTB0r4=  ;
Received: from [151.44.24.184] by web26302.mail.ukl.yahoo.com via HTTP; Wed, 09 Nov 2005 22:35:02 PST
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11465>

Junio C Hamano wrote:

>Marco Costalba <mcostalba@yahoo.it> writes:
>
>>   as you said, the speed is almost the same but your way is clearly better.
>
>
>How often do you do this --diff-filter=AD and why?
>
>If it is a common enough operation, we could add a specific hack
>to stop feeding the diff machinery with unwanted kind of changes
>when diff-filter is set and none of -B/-C/-M are used.  That
>_might_ speed things up for you.
>

Sorry for late answer byt I was off line a few days.

Thanks, It will be great.

I have impemented a tree viewer for qgit. Tree view is updated when user browses through
revisions. Loading the file names of a given tree, altough only for the open directories, is an
expensive operation. So I check for different files anytime the user select a new revision and
the tree viewer is open, I use this test to skip tree reloading if trees have the same files.

I have made some speed test with 
git-diff-tree -r --name-status --diff-filter=AD sha1 sha2



  Marco



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
