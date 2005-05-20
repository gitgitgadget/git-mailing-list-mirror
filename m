From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 13:34:37 -0700
Message-ID: <428E49DD.406@zytor.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org> <1116615600.12975.33.camel@dhcp-188> <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 22:36:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZEDO-0002p1-Ub
	for gcvg-git@gmane.org; Fri, 20 May 2005 22:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVETUgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 16:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVETUgE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 16:36:04 -0400
Received: from terminus.zytor.com ([209.128.68.124]:941 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261579AbVETUfG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 16:35:06 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4KKYgHV014885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 May 2005 13:34:42 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.2 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 20 May 2005, Kay Sievers wrote:
> 
>>Somehting like this?:
>>  http://kernel.org/git/?p=git/git.git;a=commitdiff;h=de809dbbce497e0d107562615c1d85ff35b4e0c5
> 
> 
> Btw, at least for me, this looks much more interesting than the "commit" 
> thing, and maybe it would make sense to make the summary links be to the 
> "commitdiff" instead of the "commit"?
> 
> Or is it just so much more expensive to generate, that we want to not have
> people go there normally? (hpa cc'd, since he may have some insight into
> whether this is likely to be an issue or not? It's not like git-diff-tree
> is that expensive, but it _does_ end up doing a "diff" against each
> changed file, of course, modulo any caching of results).
> 

What I ended up doing for the diff viewer on kernel.org is that every 
page that's generated gets stuffed in a cache (locklessly indexed by a 
SHA-1 of a canonicalized form of the query); the pages people actually 
see are then simply pulled from the cache.  This caching was a just 
enormous win.  In the case of the diff viewer, the header is generated 
each time, since I allow the user to select a custom style sheet (and 
don't want to cache versions for each style sheet), but that's a trivial 
detail.

	-hpa

