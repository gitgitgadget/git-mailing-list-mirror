X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-add fails after file type change
Date: Sat, 16 Dec 2006 16:19:04 -0800
Message-ID: <45848CF8.4000704@midwinter.com>
References: <458437E0.1050501@midwinter.com> <45843C5A.8020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 00:19:05 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <45843C5A.8020501@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34667>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvjk5-0005fl-Kj for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751362AbWLQAS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWLQAS6
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:18:58 -0500
Received: from tater.midwinter.com ([216.32.86.90]:39661 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751362AbWLQAS5
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 19:18:57 -0500
Received: (qmail 10086 invoked from network); 17 Dec 2006 00:18:53 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.128?)
 (koreth@76.21.17.123) by tater.midwinter.com with SMTP; 17 Dec 2006 00:18:51
 -0000
To: A Large Angry SCM <gitzilla@gmail.com>
Sender: git-owner@vger.kernel.org

A Large Angry SCM wrote:
> Did you try "git-update-index --replace dir"?

Turns out that doesn't work. It gives me the same error I get without 
the --replace option:

error: dir: cannot add to the index - missing --add option?
fatal: Unable to process file dir

However, "git rm" followed by "git add" does seem to work. So for now it 
looks like that'll be the best bet when I run into this problem (should 
be possible to automate it, even.) The better error message from Junio's 
patch will at least make the failure less mysterious.

IMO it'd still be nice if the porcelain could provide a "make the index 
look like the working directory" operation that worked even in the face 
of changes like this, adding and/or removing files as needed. But it's 
possible that my crazy git-as-backup-device setup is the only place 
where this is even an issue; typical git users can use "git mv" and 
never run into the problem.

-Steve
