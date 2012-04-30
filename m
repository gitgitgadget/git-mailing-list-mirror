From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] [PATCH] Handle empty patches and patches with only a
 header.
Date: Mon, 30 Apr 2012 12:48:42 -0400
Message-ID: <20120430164841.GG20761@poseidon.cudanet.local>
References: <87haw1342k.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 18:48:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOtmL-0004ev-BT
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 18:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab2D3Qsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 12:48:45 -0400
Received: from josefsipek.net ([64.9.206.49]:58790 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797Ab2D3Qso (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 12:48:44 -0400
Received: from poseidon.cudanet.local (unknown [12.200.95.45])
	by josefsipek.net (Postfix) with ESMTPSA id CAED6AF8BB;
	Mon, 30 Apr 2012 12:48:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87haw1342k.fsf@opera.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196577>

On Mon, Apr 30, 2012 at 12:29:55PM +0200, Per Cederqvist wrote:
> "git apply --numstat" in Git 1.7.10 gives an error message unless the
> patch contains a diff, so don't attempt to apply it unless we find a

Find a what?  Such a cliff-hanger! :)

I assume you mean find a '^diff'.

I'll fix up the commit message before applying.

Thanks,

Jeff.

> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/guilt b/guilt
> index 5d619c5..66a671a 100755
> --- a/guilt
> +++ b/guilt
> @@ -622,7 +622,7 @@ push_patch()
>  		cd_to_toplevel
>  
>  		# apply the patch if and only if there is something to apply
> -		if [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
> +		if grep -q '^diff ' "$p" && [ `git apply --numstat "$p" | wc -l` -gt 0 ]; then
>  			if [ "$bail_action" = abort ]; then
>  				reject=""
>  			fi
> -- 
> 1.7.10
> 

-- 
Keyboard not found!
Press F1 to enter Setup
