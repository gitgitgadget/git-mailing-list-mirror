From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 11:38:01 -0400
Message-ID: <4325A0D9.2000806@gmail.com>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 17:41:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEqOF-00063U-4m
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 17:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVILPiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 11:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVILPiW
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 11:38:22 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:20649 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750712AbVILPiV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 11:38:21 -0400
Received: by wproxy.gmail.com with SMTP id i2so1849980wra
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 08:38:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Kpu0HbI0Zwd+LkYM7dPXTSkzo7QK8EfaywB0cpIvjENh6DMFIVhaAieLmbCD0enM95qiMWQzDdEBCYUI+KQFjIbuPVuJBpxYgsObuKA5q/S9sBHjWxLBR2eP6L3N5ELbkvTxjzpL/qaPYxW8e5Y/sCaRHHRNWKa20Swsr0w+BXY=
Received: by 10.54.14.59 with SMTP id 59mr2722197wrn;
        Mon, 12 Sep 2005 08:38:19 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id g9sm120272wra.2005.09.12.08.38.12;
        Mon, 12 Sep 2005 08:38:18 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8405>

Chuck Lever wrote:
> [ This series is posted for review and comments. ]
> 
> The following patch series introduces an abstraction called a "cache
> cursor" that will eventually allow us to replace the current
> active_cache array with something else.
> 
> A cache cursor represents a position inside the cache.  This position
> has a cache_entry associated with it, of course, but since the cache
> is ordered, a cache cursor also has the concept of next, previous,
> and end-of-cache.
> 
> With a cache cursor we can build a simple iterator mechanism that
> calls a particular function for every entry in the cache, in order.
> This allows us to hide further the specifics of the active cache
> implementation -- the function gets to see the cache cursor and
> an element, but does not have direct access to the cache and cannot
> assume it has a particular structure.
> 
> Currently the cache cursor type is just a structure with an integer
> in it, so it largely mimics the existing implementation.
> 
> This patch series is against the "proposed updates" branch, as of
> a couple of days ago.  It has been tested via "make test" and I'm
> currently using it for my own work without issue.

I'll let others comment on the need for this type of facility and it's 
proposed implementation.

Since you are proposing an API, some basic documentation about how to 
use the API would be nice. Comments in cache.h seems the best place, for 
now.

The sentence "This patch series is against the "proposed updates" 
branch, as of a couple of days ago." should have also included a commit 
ID. That way we would know where/when the patches would apply cleanly 
for testing and dissection.
