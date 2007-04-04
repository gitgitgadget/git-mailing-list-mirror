From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui blame dividing by zero
Date: Wed, 4 Apr 2007 11:27:48 -0400
Message-ID: <20070404152748.GE4628@spearce.org>
References: <200704041621.51390.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 17:28:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ7Pm-00064x-Fw
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 17:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992961AbXDDP22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 11:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992960AbXDDP15
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 11:27:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46614 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992958AbXDDP1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 11:27:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZ7Oi-0005ke-DV; Wed, 04 Apr 2007 11:27:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DBA7520FBAE; Wed,  4 Apr 2007 11:27:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200704041621.51390.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43747>

Andy Parkins <andyparkins@gmail.com> wrote:
>  $ git-gui blame HEAD somefile.cc
> 
> I just get a window that contains:
> 
> divide by zero
> divide by zero
>     while executing
> "expr {100 * $blame_data($w,blame_lines)
> 			/ $blame_data($w,total_lines)}"
>     (procedure "blame_incremental_status" line 4)
>     invoked from within
> "blame_incremental_status $w"
>     (procedure "read_blame_catfile" line 27)
>     invoked from within
> "read_blame_catfile file6 {} HEAD 
> somefile.cc .cm.t .out.loaded_t .out.linenumber_t .out.file_t"

Heh.  So we came up with no lines in the file.  Weird.  What does
git-blame produce on the same arguments?  What about with the
--incremental flag?

I'll dig into git-gui and see what I can do to more gracefully
handle this condition, but right now I'm thinking we didn't get
any data from git...

-- 
Shawn.
