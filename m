From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 1/6] Refuse to push corrupt patches
Date: Fri, 30 Sep 2011 13:15:02 -0400
Message-ID: <20110930171502.GE18364@poseidon.cudanet.local>
References: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 19:24:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9gor-0006L1-Dw
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 19:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932Ab1I3RYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 13:24:12 -0400
Received: from josefsipek.net ([64.9.206.49]:55304 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab1I3RYL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 13:24:11 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Sep 2011 13:24:11 EDT
Received: from poseidon.cudanet.local (unknown [12.200.95.45])
	by josefsipek.net (Postfix) with ESMTPSA id 6662358521;
	Fri, 30 Sep 2011 13:17:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1317219324-10319-1-git-send-email-alan.christopher.jenkins@googlemail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182494>

Thanks for the patches.  I looked them over and they look good.  I'll give
them another thorough reading once I have a bit of time to apply them.

Jeff.

On Wed, Sep 28, 2011 at 03:15:19PM +0100, Alan Jenkins wrote:
> "guilt push" would treat corrupt patches as empty,
> because "git apply --numstat" prints nothing on stdout.
> 
> (You do get an error message on stderr,
>  but then guilt says "Patch applied" etc,
>  and I didn't notice the earlier error message
>  for quite some time.)
> 
> Signed-off-by: Alan Jenkins <alan.christopher.jenkins@googlemail.com>
> ---
>  guilt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/guilt b/guilt
> index d1e17d4..51532f9 100755
> --- a/guilt
> +++ b/guilt
> @@ -611,7 +611,7 @@ push_patch()
>  		cd_to_toplevel
>  
>  		# apply the patch if and only if there is something to apply
> -		if [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
> +		if [ `do_get_patch "$p" | wc -l` -gt 0 ]; then
>  			if [ "$bail_action" = abort ]; then
>  				reject=""
>  			fi
> -- 
> 1.7.4.1
> 

-- 
Hegh QaQ law'
quvHa'ghach QaQ puS
