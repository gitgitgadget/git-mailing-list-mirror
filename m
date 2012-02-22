From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 uses -h for host instead of -H
Date: Tue, 21 Feb 2012 20:23:26 -0500
Message-ID: <20120222012326.GA870@padd.com>
References: <CAA5tD2sYSqtGTwW1PmFMB_mP_xG24VS6hPXTLD33bJsMaj4MWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, luke@diamand.org, ggibbons@perforce.com
To: Russell Myers <mezner@russellmyers.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 02:23:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S00vh-0000eH-Kv
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 02:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab2BVBXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 20:23:32 -0500
Received: from honk.padd.com ([74.3.171.149]:42796 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab2BVBXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 20:23:32 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 8DBF6E8D;
	Tue, 21 Feb 2012 17:23:31 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id F252331481; Tue, 21 Feb 2012 20:23:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAA5tD2sYSqtGTwW1PmFMB_mP_xG24VS6hPXTLD33bJsMaj4MWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191209>

mezner@russellmyers.com wrote on Tue, 21 Feb 2012 19:35 -0500:
> In attempting to use the git-p4 plugin I ran into an issue when the host
> argument was specified using the -h argument instead of the -H argument for
> the host. As a result, I found that instead of git-p4 specifying a host, it
> gets help information. Correcting this issue allowed me to clone without
> issue. I've attached a patch of what I did to fix the issue if this is
> indeed believed to be an issue.

Ack to this.  Looks like the bug has been in there since the
feature of git-p4.host was introduced in abcaf07 (If the user has
configured various parameters, use them., 2008-08-10).

Thanks for the fix.

		-- Pete

> From 2f6c91282c98ca0a45269524ec74655f76921ec9 Mon Sep 17 00:00:00 2001
> From: Russell Myers <mezner@russellmyers.com>
> Date: Tue, 21 Feb 2012 19:18:54 -0500
> Subject: [PATCH] Changing host argument to -H from -h. Based on
>  http://www.perforce.com/perforce/doc.current/manuals/p4guide/03_using.html
>  '-H' is the apporpriate flag while '-h' is a flag passed
>  for help content.
> 
> ---
>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index a78d9c5..d2fd265 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -38,7 +38,7 @@ def p4_build_cmd(cmd):
>  
>      host = gitConfig("git-p4.host")
>      if len(host) > 0:
> -        real_cmd += ["-h", host]
> +        real_cmd += ["-H", host]
>  
>      client = gitConfig("git-p4.client")
>      if len(client) > 0:
> -- 
> 1.7.5.4
> 
