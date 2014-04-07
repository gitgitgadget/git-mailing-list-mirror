From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: explicitly specify that HEAD is a revision
Date: Mon, 7 Apr 2014 18:09:16 -0400
Message-ID: <20140407220916.GA3635@padd.com>
References: <20140407131911.GB17654@ixro-vdogaru.ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Vlad Dogaru <vdogaru@ixiacom.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 00:21:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXHuo-0007in-2s
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 00:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbaDGWVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 18:21:14 -0400
Received: from honk.padd.com ([74.3.171.149]:55270 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755433AbaDGWVN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 18:21:13 -0400
X-Greylist: delayed 713 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Apr 2014 18:21:13 EDT
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id 4C5ED5B54;
	Mon,  7 Apr 2014 15:09:19 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8DA4720269; Mon,  7 Apr 2014 18:09:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140407131911.GB17654@ixro-vdogaru.ixiacom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245911>

vdogaru@ixiacom.com wrote on Mon, 07 Apr 2014 16:19 +0300:
> 'git p4 rebase' fails with the following message if there is a file
> named HEAD in the current directory:
> 
> 	fatal: ambiguous argument 'HEAD': both revision and filename
> 	Use '--' to separate paths from revisions, like this:
> 	'git <command> [<revision>...] -- [<file>...]'
> 
> Take the suggestion above and explicitly state that HEAD should be
> treated as a revision.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@ixiacom.com>

This looks obviously good to me, thanks!

Junio, could you carry it into the next release?  As a trivial
fixup.

Acked-by: Pete Wyckoff <pw@padd.com>

> ---
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index cdfa2df..8d11b25 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3086,7 +3086,7 @@ class P4Rebase(Command):
>          print "Rebasing the current branch onto %s" % upstream
>          oldHead = read_pipe("git rev-parse HEAD").strip()
>          system("git rebase %s" % upstream)
> -        system("git diff-tree --stat --summary -M %s HEAD" % oldHead)
> +        system("git diff-tree --stat --summary -M %s HEAD --" % oldHead)
>          return True
>  
>  class P4Clone(P4Sync):
> -- 
> 1.8.5.2
> 
> 
