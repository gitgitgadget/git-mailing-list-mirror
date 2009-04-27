From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Computation of average could overflow
Date: Mon, 27 Apr 2009 16:17:57 -0700
Message-ID: <20090427231757.GM23604@spearce.org>
References: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Sohn, Matthias" <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:18:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lya5N-0007Wj-M0
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022AbZD0XR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 19:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbZD0XR5
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:17:57 -0400
Received: from george.spearce.org ([209.20.77.23]:57581 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbZD0XR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 19:17:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 17B7C38215; Mon, 27 Apr 2009 23:17:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117735>

"Sohn, Matthias" <matthias.sohn@sap.com> wrote:
> The code computes the average of two integers using either division or
> signed right shift, and then uses the result as the
> index of an array. If the values being averaged are very large, this can
> overflow (resulting in the computation of a negative
> average). Assuming that the result is intended to be nonnegative, you
> can use an unsigned right shift instead. In other
> words, rather that using (low+high)/2, use (low+high) >>> 1

Thanks, applied.  But your patch was line wrapped.  I had to unwrap
it by hand.  Please try to configure your MUA not to line wrap
patches when it sends them.  :-|
 
>  .../src/org/spearce/jgit/dircache/DirCache.java    |    2 +-
>  .../src/org/spearce/jgit/lib/Tree.java             |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Shawn.
