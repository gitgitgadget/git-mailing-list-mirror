From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] update-hook: parse the tag header in preparation to use the tag type
Date: Tue, 20 Mar 2007 10:38:44 -0400
Message-ID: <20070320143844.GA1750@spearce.org>
References: <200703201058.42753.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 15:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTfUC-00034A-W7
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 15:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbXCTOit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 10:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbXCTOit
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 10:38:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53747 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbXCTOis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 10:38:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTfU1-0004uO-IR; Tue, 20 Mar 2007 10:38:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C93A120FBAE; Tue, 20 Mar 2007 10:38:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200703201058.42753.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42741>

Andy Parkins <andyparkins@gmail.com> wrote:
> The tag header is parsed with a while loop and read command.  I'm not
> entirely sure how portable it is, as it had to use the following unusual
> heredoc format:
> 
>   while read field value
>   do
>     # ..
>   done <<< "$(some command)"

To bad you can't use for-each-ref.  ;-)

The problem of course is the update hook is running before a ref
is created to point at the tag.  If you used post-receive hook
on the other hand...  Oh, right, that has its own problems too!

-- 
Shawn.
