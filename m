From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Equals method should not assume anything about
	the type of its argument
Date: Wed, 29 Apr 2009 08:02:40 -0700
Message-ID: <20090429150240.GB23604@spearce.org>
References: <366BBB1215D0AB4B8A153AF047A287800302A6F9@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Sohn, Matthias" <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzBJA-00043F-SJ
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 17:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbZD2PCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 11:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZD2PCl
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 11:02:41 -0400
Received: from george.spearce.org ([209.20.77.23]:38071 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbZD2PCl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 11:02:41 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8F2573806A; Wed, 29 Apr 2009 15:02:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <366BBB1215D0AB4B8A153AF047A287800302A6F9@dewdfe18.wdf.sap.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117894>

"Sohn, Matthias" <matthias.sohn@sap.com> wrote:
> The equals(Object o) method shouldn't make any assumptions about the type of o. It should simply return false if o is not the same type as this.

True.

Please line wrap your commit message at ~70 columns wide.
 
> Signed-off-by: Matthias Sohn <matthias.sohn@sap.com>

FWIW, your From header in the emails comes out "Sohn, Matthias"
while your Signed-off-By is as above.  This means that when I slam
your patch through git-am I get an author name of "Sohn, Matthias",
which looks damn funny.  I have to remember to edit the patch after
the fact to make it come out correct.

Any change you can get your MUA to behave better?  Or is this
Exchange enforcing a nice uniform standard... *sigh*

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
> index 2e3a43e..0bd2288 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
> @@ -253,7 +253,11 @@ public boolean equals(final AnyObjectId other) {
>  	}
>  
>  	public boolean equals(final Object o) {
> -		return equals((AnyObjectId) o);
> +		if (o instanceof AnyObjectId) {
> +			return equals((AnyObjectId) o);
> +		} else {
> +			return false;
> +		}
>  	}

Style nit: We avoid unnecessary braces around clauses.

-- 
Shawn.
