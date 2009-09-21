From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Trivial fix: Make all the builtin usage strings to use
 the same pattern.
Date: Mon, 21 Sep 2009 10:28:36 -0500
Message-ID: <pN7ragma8Ra75P8lN7iHuXE6FyUXHXFlnHUVFZqJV4WM7w5mCkVHcQ@cipher.nrlssc.navy.mil>
References: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 17:28:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpkoo-0001xB-Ht
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 17:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbZIUP2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 11:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756597AbZIUP2g
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 11:28:36 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45821 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbZIUP2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 11:28:36 -0400
Received: by mail.nrlssc.navy.mil id n8LFSbTi025380; Mon, 21 Sep 2009 10:28:37 -0500
In-Reply-To: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
X-OriginalArrivalTime: 21 Sep 2009 15:28:36.0898 (UTC) FILETIME=[30277020:01CA3AD0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128891>

Thiago Farina wrote:
> They follow the pattern of file name:
> File name pattern: builtin-command-name.c
> Usage string pattern: builtin_command_name_usage
> 
> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
> ---

> diff --git a/builtin-blame.c b/builtin-blame.c
> index 7512773..4adae84 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -21,10 +21,11 @@
>  #include "parse-options.h"
>  #include "utf8.h"
>  
> -static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
> +static char builtin_blame_usage[] =

Should this one also use 'const'?

> +"git blame [options] [rev-opts] [rev] [--] file";
>  
>  static const char *blame_opt_usage[] = {
> -	blame_usage,
> +	builtin_blame_usage,
>  	"",
>  	"[rev-opts] are documented in git-rev-list(1)",
>  	NULL

> diff --git a/builtin-count-objects.c b/builtin-count-objects.c
> index 1b0b6c8..fbe0972 100644
> --- a/builtin-count-objects.c
> +++ b/builtin-count-objects.c
> @@ -65,7 +65,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
>  	}
>  }
>  
> -static char const * const count_objects_usage[] = {
> +static char const * const builtin_count_objects_usage[] = {

This one is different from the others.  I assume 'char const *' is
the same as 'const char *', though I'm used to seeing the latter
form.  If we're going for consistency, maybe this should be changed
too.  Ultra minor nit-pick.  I noticed it, so I mentioned it, but
its your choice.

>  	"git count-objects [-v]",
>  	NULL
>  };

> diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> index a5a83f1..715d378 100644
> --- a/builtin-for-each-ref.c
> +++ b/builtin-for-each-ref.c
> @@ -881,7 +881,7 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> -static char const * const for_each_ref_usage[] = {
> +static char const * const builtin_for_each_ref_usage[] = {

ditto

>  	"git for-each-ref [options] [<pattern>]",
>  	NULL
>  };

> diff --git a/builtin-fsck.c b/builtin-fsck.c
> index c58b0e3..0857357 100644
> --- a/builtin-fsck.c
> +++ b/builtin-fsck.c
> @@ -564,7 +564,7 @@ static int fsck_cache_tree(struct cache_tree *it)
>  	return err;
>  }
>  
> -static char const * const fsck_usage[] = {
> +static char const * const builtin_fsck_usage[] = {

ditto

>  	"git fsck [options] [<object>...]",
>  	NULL
>  };
