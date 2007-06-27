From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t9400-git-cvsserver-server failures
Date: Wed, 27 Jun 2007 09:08:16 -0400
Message-ID: <DA4A2395-33EA-4209-A1DE-E6CAB55C94AD@silverinsanity.com>
References: <3E98C380-541B-479F-9E8F-6BBE82EE2930@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 15:08:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3XFu-0002aP-Ht
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 15:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758638AbXF0NIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 09:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758025AbXF0NIU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 09:08:20 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:47251 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916AbXF0NIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 09:08:20 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 886F21FFC1DF
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 13:08:19 +0000 (UTC)
In-Reply-To: <3E98C380-541B-479F-9E8F-6BBE82EE2930@silverinsanity.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51038>


On Jun 26, 2007, at 11:07 PM, Brian Gernhardt wrote:

> I'm getting several failures in the git-cvsserver tests.  I don't  
> even know where to start with that code, so here's as detailed an  
> error report as I can give.
>
> The first category appears to be that several of the tests use  
> test_expect_failure, which expects the error codes to be less than  
> 127 and the error it gets is 255 (-1).
>
> * FAIL 9: req_Root failure (strict-paths)
>         cat request-anonymous | git-cvsserver --strict-paths  
> pserver $WORKDIR >log 2>&1
> * FAIL 11: req_Root failure (w/o strict-paths)
>         cat request-anonymous | git-cvsserver pserver $WORKDIR/ 
> gitcvs >log 2>&1
> * FAIL 13: req_Root failure (base-path)
>         cat request-anonymous | git-cvsserver --strict-paths --base- 
> path $WORKDIR pserver $SERVERDIR >log 2>&1

Running the tests again this morning after a fresh pull results in  
only the above failures occurring.  I looked through git- 
cvsserver.perl and couldn't find any exit(-1) or similar.  Anyone  
have any idea where to start to fix these?

~~ Brian
