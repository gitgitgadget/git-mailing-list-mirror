From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 2/4] Use the Git sort order.
Date: Tue, 24 Apr 2007 13:09:18 -0400
Message-ID: <20070424170918.GA5923@spearce.org>
References: <20070422212907.26396.12810.stgit@lathund.dewire.com> <20070422213602.26396.59463.stgit@lathund.dewire.com> <200704240039.48892.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgOW6-0001wH-WB
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbXDXRJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbXDXRJX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:09:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56520 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbXDXRJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:09:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgOVh-0001KA-Dr; Tue, 24 Apr 2007 13:09:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 070A920FBAE; Tue, 24 Apr 2007 13:09:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200704240039.48892.robin.rosenberg.lists@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45471>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> Oops, lost the decoration here.

Thanks, I applied all 6 patches.  Good stuff.

Unfortunately this particular patch was totally damaged beyond
repair.  What happened to it?  I redid the changes by hand, as even
after fixing the line wrapping on the `diff --git` header line
`git-am -3 --whitespace=strip` was unable to apply the patch to
0c4683e.  The patch doesn't apply, at all, to that blob.

> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit
> /core/project/GitProjectData.java
> index 0c4683e..5c250c0 100644
> --- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
> @@ -274,11 +274,11 @@ public class GitProjectData {
>                 return (RepositoryMapping) c2mapping.get(r);
>         }
> 
> -       public TreeEntry[] getActiveDiffTreeEntries(IResource r)
> +       public TreeEntry[] getActiveDiffTreeEntries(IResource res)
>                         throws CoreException {
>                 String s = null;
>                 RepositoryMapping m = null;
> -
> +               IResource r = res;
>                 while (r != null) {
>                         m = getRepositoryMapping(r);
>                         if (m != null) {
> @@ -296,7 +296,7 @@ public class GitProjectData {
> 
>                 if (s != null && m != null && m.getActiveDiff() != null) {
>                         try {
> -                               if (r.getType() == IResource.FILE)
> +                               if (res.getType() == IResource.FILE)
>                                         return m.getActiveDiff().findBlobMember(s);
>                                 else
>                                         return m.getActiveDiff().findTreeMember(s);

-- 
Shawn.
