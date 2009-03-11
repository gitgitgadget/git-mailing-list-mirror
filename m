From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] fix for 'negative position' error
Date: Wed, 11 Mar 2009 08:24:42 -0700
Message-ID: <20090311152442.GS11989@spearce.org>
References: <49B7D683.1070805@diasoft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Ruth Alkema <ruth@diasoft.nl>
X-From: git-owner@vger.kernel.org Wed Mar 11 16:26:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQJx-0005Kv-Dy
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbZCKPYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZCKPYo
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:24:44 -0400
Received: from george.spearce.org ([209.20.77.23]:42846 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbZCKPYo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 11:24:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 685ED38211; Wed, 11 Mar 2009 15:24:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49B7D683.1070805@diasoft.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112939>

Ruth Alkema <ruth@diasoft.nl> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
> index 4b7e10d..5340da9 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/WindowCache.java
> @@ -253,7 +253,7 @@ private static synchronized final void getImpl(final WindowCursor curs,
>  		releaseMemory();
>  		runClearedWindowQueue();
>  
> -		wp.allocWindow(curs, id, id << windowSizeShift, wsz);
> +		wp.allocWindow(curs, id, ((long) id) << windowSizeShift, wsz);

Ouch.

Thanks for the fix!

-- 
Shawn.
