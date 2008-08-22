From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Added forward slash to head/remote/tag prefix
	Constants
Date: Fri, 22 Aug 2008 09:53:27 -0700
Message-ID: <20080822165327.GL3483@spearce.org>
References: <1219352122-5865-1-git-send-email-charleso@charleso.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Charles O'Farrell <charleso@charleso.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:55:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWZuq-0001eX-0I
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 18:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbYHVQx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 12:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755510AbYHVQx2
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 12:53:28 -0400
Received: from george.spearce.org ([209.20.77.23]:51959 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494AbYHVQx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 12:53:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 561E438375; Fri, 22 Aug 2008 16:53:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219352122-5865-1-git-send-email-charleso@charleso.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93327>

Charles O'Farrell <charleso@charleso.org> wrote:
> eg. Constants.HEADS_PREFIX + "/" ==> Constants.R_HEADS
> 
> This was always done by every instance anyway and so this will ensure
> it isn't forgotten again.

Thanks, applied.  I had to hand-merge a few sections due to Marek's
push UI going in before your patch, but your patch not having the
necessary changes.  Using a different constant name helped make
that resolution less painful.
 
> --- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
> +++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
> @@ -184,12 +181,12 @@ protected static String abbreviateObject(final ObjectId id) {
>  	}
>  
>  	protected String abbreviateRef(String dst, boolean abbreviateRemote) {
> -		if (dst.startsWith(REFS_HEADS))
> -			dst = dst.substring(REFS_HEADS.length());
> -		else if (dst.startsWith(REFS_TAGS))
> -			dst = dst.substring(REFS_TAGS.length());
> -		else if (abbreviateRemote && dst.startsWith(REFS_REMOTES))
> -			dst = dst.substring(REFS_REMOTES.length());
> +		if (dst.startsWith(R_HEADS))
> +			dst = dst.substring(R_HEADS.length());
> +		else if (dst.startsWith(R_TAGS))
> +			dst = dst.substring(R_HEADS.length());

This should be R_TAGS. I fixed it when I applied the patch.

-- 
Shawn.
