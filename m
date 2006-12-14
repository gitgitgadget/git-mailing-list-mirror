X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 19:35:49 +0100
Organization: Dewire
Message-ID: <200612141935.49776.robin.rosenberg.lists@dewire.com>
References: <200612141519.44294.andyparkins@gmail.com> <20061214174251.GA16819@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 18:33:53 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061214174251.GA16819@tuxdriver.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34382>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuvOn-0002Jq-J3 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 19:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932884AbWLNSdi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 13:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932886AbWLNSdi
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 13:33:38 -0500
Received: from [83.140.172.130] ([83.140.172.130]:20960 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S932884AbWLNSdh (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 13:33:37 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 7A0008027F4; Thu, 14 Dec 2006 19:29:39 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 28572-05; Thu, 14 Dec
 2006 19:29:39 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id CCE75800782; Thu, 14 Dec 2006 19:29:36 +0100 (CET)
To: "John W. Linville" <linville@tuxdriver.com>
Sender: git-owner@vger.kernel.org

torsdag 14 december 2006 18:42 skrev John W. Linville:
> On Thu, Dec 14, 2006 at 03:19:44PM +0000, Andy Parkins wrote:
> > This patch makes all merge log messages of the form:
> >
> >   Merge branch XXXX into YYYY
> >
> > Regardless of whether YYYY is master or not.
> >
> > "master" shouldn't get special treatment; making different log messages
> > based on the name of the branch is bad form.  What if a user likes
> > "my/master" or "my/head" as their master branch?
>
> Why not drop the "into YYYY" part for everyone else?  I don't find
> it useful at all, and is just confusing if I merge to a temporary
> branch and then pull that into master later.

Or just drop both the from, into and repo names.. A commit may come from a 
certain repo, buy you would never know since it may have been pulled there 
rather than committed, so the merge message is misleading and if the merge 
was a fast forward you wouldn't see a merge message at all.

To make everybody happy, the .git/config could contain a template that states 
the project policy on merge commits.

Obviously the person executing the merge is free to amend the merge message, 
insertering synthetic commits or whatever he/she sees fit.

