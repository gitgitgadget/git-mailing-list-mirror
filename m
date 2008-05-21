From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Understanding git filter-branch --subdirectory-filter behaviour
Date: Wed, 21 May 2008 08:26:03 +0200
Message-ID: <4833C07B.3060004@viscovery.net>
References: <e1dab3980805201311m3cbde4f2id8c3493a25745238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 08:27:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyhmv-0004pm-0h
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 08:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759566AbYEUG0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 02:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759513AbYEUG0I
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 02:26:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:27516 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbYEUG0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 02:26:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jyhlz-0001qp-GI; Wed, 21 May 2008 08:26:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2D3F2546; Wed, 21 May 2008 08:26:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e1dab3980805201311m3cbde4f2id8c3493a25745238@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82529>

David Tweed schrieb:
> $ git filter-branch --subdirectory-filter WRITING/ HEAD
> Rewrite 42f24be8d8198738134a19471697b39359199fa3 (351/351)
> Ref 'refs/heads/master' was rewritten
> 
> $ git rev-list HEAD | wc
>      55      55    2255
> 
...
> 
> Digging a little into the shell-script I find the list of commits is
> generated with
> 
> git rev-list --reverse --topo-order --default HEAD --parents HEAD
> --full-history -- WRITING
> 
> and (adding --pretty so I can easily read it) running this manually
> gives 351 entries and looks to contain the expected commits. So I'm
> confused what's happening?

That's difficult to tell without a peek at the repository.

Did you compare 'gitk HEAD' to 'gitk HEAD -- WRITING'? I'd expect the
latter to be a subset of the former. Note that with a path specified
"history simplification" happens, which means that you won't see as many
merges as when no path is specified.

-- Hannes
