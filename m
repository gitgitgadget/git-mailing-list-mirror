From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: complete *_HEAD refs if present
Date: Wed, 17 Mar 2010 08:40:20 -0700
Message-ID: <20100317154020.GD1871@spearce.org>
References: <1268817635-7946-1-git-send-email-icomfort@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ian Ward Comfort <icomfort@stanford.edu>
X-From: git-owner@vger.kernel.org Wed Mar 17 16:40:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrvMP-0001F9-0z
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 16:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024Ab0CQPkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 11:40:31 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:9560 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab0CQPk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 11:40:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so216463qwh.37
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 08:40:27 -0700 (PDT)
Received: by 10.224.107.84 with SMTP id a20mr316352qap.356.1268840427583;
        Wed, 17 Mar 2010 08:40:27 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 6sm6312873qwk.32.2010.03.17.08.40.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 08:40:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1268817635-7946-1-git-send-email-icomfort@stanford.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142402>

Ian Ward Comfort <icomfort@stanford.edu> wrote:
> We already complete HEAD, of course, and might as well complete the other
> common refs mentioned in the rev-parse man page: FETCH_HEAD, ORIG_HEAD, and
> MERGE_HEAD.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

 
> Signed-off-by: Ian Ward Comfort <icomfort@stanford.edu>
> ---
>  contrib/completion/git-completion.bash |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index fe93747..733ac39 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -250,7 +250,9 @@ __git_refs ()
>  			refs="${cur%/*}"
>  			;;
>  		*)
> -			if [ -e "$dir/HEAD" ]; then echo HEAD; fi
> +			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
> +				if [ -e "$dir/$i" ]; then echo $i; fi
> +			done
>  			format="refname:short"
>  			refs="refs/tags refs/heads refs/remotes"
>  			;;

-- 
Shawn.
