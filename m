From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT] Request for help
Date: Thu, 3 Sep 2009 12:49:55 -0700
Message-ID: <20090903194955.GL1033@spearce.org>
References: <4A9EFFB1.9090501@codeaurora.org> <20090903012315.GG1033@spearce.org> <4AA01D08.3060400@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 21:50:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjIJn-0002fO-6N
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 21:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208AbZICTtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 15:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbZICTtx
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 15:49:53 -0400
Received: from george.spearce.org ([209.20.77.23]:50903 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbZICTtx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 15:49:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8ED2C381FD; Thu,  3 Sep 2009 19:49:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AA01D08.3060400@codeaurora.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127665>

Nasser Grainawi <nasser@codeaurora.org> wrote:
> Shawn O. Pearce wrote:
>> Hmm, maybe a method on Patch is reasonable.
>
> Going down this route, I'd add a few things to Patch.
> patchId would be a private field (of type ObjectId?)
> getPatchId would be a public method that returns patchId
> and then likely a private method (computePatchId?) that actually  
> generates the patchId

Sure, but getPatchId can compute it on demand on the first call,
and anyone who modifies the Patch would just need to clear out
the cached patchId value so the next call (if it ever comes) to
getPatchId would force it to recompute.

Most users of Patch won't want the patchId, so there is no reason
to compute it.

-- 
Shawn.
