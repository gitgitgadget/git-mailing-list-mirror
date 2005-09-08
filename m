From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 8 Sep 2005 17:27:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509081723360.23242@iabervon.org>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0509071409470.23242@iabervon.org> <20050908060651.GA22734@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0509081101471.23242@iabervon.org> <20050908200559.GA26088@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Sep 08 23:26:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDTs2-0002Pu-4W
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 23:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVIHVXU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 17:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbVIHVXU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 17:23:20 -0400
Received: from iabervon.org ([66.92.72.58]:52234 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965003AbVIHVXS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 17:23:18 -0400
Received: (qmail 31966 invoked by uid 1000); 8 Sep 2005 17:27:16 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Sep 2005 17:27:16 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050908200559.GA26088@c165.ib.student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8218>

On Thu, 8 Sep 2005, Fredrik Kuivinen wrote:

> The first one agrees with what was actually committed. For the second
> one the difference between the tree produced by the algorithm and what
> was committed is:
> 
> diff --git a/include/net/ieee80211.h b/include/net/ieee80211.h
> --- a/include/net/ieee80211.h
> +++ b/include/net/ieee80211.h
> @@ -425,9 +425,7 @@ struct ieee80211_stats {
>  
>  struct ieee80211_device;
>  
> -#if 0 /* for later */
>  #include "ieee80211_crypt.h"
> -#endif
>  
>  #define SEC_KEY_1         (1<<0)
>  #define SEC_KEY_2         (1<<1)
> 
> 
> I have looked at the files and common ancestors involved and I think
> that this change have been introduced manually. I may have missed
> something when I analysed it though...

Certainly possible that it was done manually.

> > > The merge cases reported by Tony Luck and Len Brown are both cleanly
> > > merged by my code.
> > 
> > Do they come out correctly? Both of those have cases which cannot be 
> > decided correctly with only the ancestor trees, due to one branch 
> > reverting a patch that was only in one ancestor. The correct result is to 
> > revert that patch, but figuring out that requires looking at more trees. I 
> > think your algorithm should work for this case, but it would be good to 
> > have verification. (IIRC, Len got the correct result while Tony got the 
> > wrong result and then corrected it later.)
> 
> Len's merge case come out identically to the tree he committed. I have
> described what I got for Tony's case in
> <20050826184731.GA13629@c165.ib.student.liu.se> (my merge algorithm
> produces the result Tony expected to get, but he didn't get that from
> git-resolve-script).

Good. It looks to me like this is a good algorithm in practice, then.

	-Daniel
*This .sig left intentionally blank*
