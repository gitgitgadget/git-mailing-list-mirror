From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 1/3] clone: add `--shallow-submodules` flag
Date: Mon, 25 Apr 2016 13:50:25 +0200
Message-ID: <DC38BBF1-9837-45C6-B744-F95FAA645FE3@gmail.com>
References: <1458090737-14030-1-git-send-email-sbeller@google.com> <1458090737-14030-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de, pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 13:50:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auf2B-0006sq-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 13:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbcDYLu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 07:50:27 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36015 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbcDYLu0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 07:50:26 -0400
Received: by mail-wm0-f51.google.com with SMTP id v188so94707882wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 04:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gdJGtAKOTULZQvAqBjYNCmld/HT6A6qGbW4CsXiVBRs=;
        b=lq8EXuf7kr9Cmp+bwh0Gf6RdiQBUK4aUrR08oBNiVpO6N1EL2hA2qyktnXdJXBpc+3
         3XgS5uSULI2ZxV0Lqw4zI276K/FgUUwAuvDu506roL+ZkgzQ4xxQER8G+U+qhXA/SVyl
         ag5G6To/7CwxpPZZuVgX6xFVm2eKOpgOU4bCpqrpmyQyomKAvD5A4uV5oaL4aVhvgeHK
         QTP2hEaG2rnSd2ZB29KEuPXMfrv7NE/CXuDNtdt4I3WNTYEQ+mZdBz2zYRaXxY2M38lp
         TU7b64AAhyY7FVv2Y9KrjaT41v02whJnG0bYToZX0uSAgOpi7At3ihU+VmUTj0tLLI5M
         hD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gdJGtAKOTULZQvAqBjYNCmld/HT6A6qGbW4CsXiVBRs=;
        b=Pqa5UJFoCxN3iJqHy084tN82bm5E9TC7rNIAKyjRotESUCO7JrxZ/gsqCQTTfkMxyW
         G8P+JOEMjhVGcZBpZpnhemY64ogwjopGCag/4qhNJZ6LjAVLcaCELqdLScD4pdiz62ID
         kV0FWTvDQOJ58U0xX++zOtGTEoDNKGNAa1l0JLygRj40WpEizNYdUzuhXJTR/uVKaJum
         g88RF5CeDcpUJwx9r1qnqvcXniUtHz9s9otijfSON+SnrltyOK3/r62TE5PovRy156q3
         CNshniI2rQMGnJIEUDjaHjVXGZDLs4XEDGNTAh79TkmGxHGzIiGgwtmYCx7jGPby3lt4
         1PFA==
X-Gm-Message-State: AOPr4FVNvz9JwxPnZAaCWH3LyxQTBEGpdVK1/Eszp/z9A1jL0F3vXtOQ06nqE9v9keZ16w==
X-Received: by 10.28.142.5 with SMTP id q5mr11371085wmd.21.1461585025150;
        Mon, 25 Apr 2016 04:50:25 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id jr8sm23249241wjb.15.2016.04.25.04.50.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 04:50:24 -0700 (PDT)
In-Reply-To: <1458090737-14030-2-git-send-email-sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292468>


> On 16 Mar 2016, at 02:12, Stefan Beller <sbeller@google.com> wrote:
> 
> When creating a shallow clone of a repository with submodules, the depth
> argument does not influence the submodules, i.e. the submodules are done
> as non-shallow clones. It is unclear what the best default is for the
> depth of submodules of a shallow clone, so we need to have the possibility
> to do all kinds of combinations:
> 
> * shallow super project with shallow submodules
>  e.g. build bots starting always from scratch. They want to transmit
>  the least amount of network data as well as using the least amount
>  of space on their hard drive.
> * shallow super project with unshallow submodules
>  e.g. The superproject is just there to track a collection of repositories
>  and it is not important to have the relationship between the repositories
>  intact. However the history of the individual submodules matter.
> * unshallow super project with shallow submodules
>  e.g. The superproject is the actual project and the submodule is a
>  library which is rarely touched.
> 
> The new switch to select submodules to be shallow or unshallow supports
> all of these three cases.
> 
> It is easy to transition from the first to the second case by just
> unshallowing the submodules (`git submodule foreach git fetch
> --unshallow`), but it is not possible to transition from the second to the
> first case (as we wouldd have already transmitted the non shallow over
s/wouldd/would/


> the network). That is why we want to make the first case the default in
> case of a shallow super project. This leads to the inconvenience in the
> second case with the shallow super project and unshallow submodules,
> as you need to pass `--no-shallow-submodules`.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> Documentation/git-clone.txt | 13 ++++++++++---
> builtin/clone.c             |  7 +++++++
> 2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 6db7b6d..20a4577 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -14,8 +14,8 @@ SYNOPSIS
> 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
> 	  [--dissociate] [--separate-git-dir <git dir>]
> 	  [--depth <depth>] [--[no-]single-branch]
> -	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
> -	  [<directory>]
> +	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
> +	  [--jobs <n>] [--] <repository> [<directory>]
> 
> DESCRIPTION
> -----------
> @@ -190,7 +190,11 @@ objects from the source repository into a pack in the cloned repository.
> 
> --depth <depth>::
> 	Create a 'shallow' clone with a history truncated to the
> -	specified number of revisions.
> +	specified number of revisions. Implies `--single-branch` unless
> +	`--no-single-branch` is given to fetch the histories near the
> +	tips of all branches. This implies `--shallow-submodules`. If
> +	you want to have a shallow clone, but full submodules, also pass
Can we make this more explicit. Attention, bikeshedding:
If you want to have a shallow parent clone, but full submodules...


> +	`--no-shallow-submodules`.
> 
> --[no-]single-branch::
> 	Clone only the history leading to the tip of a single branch,
> @@ -214,6 +218,9 @@ objects from the source repository into a pack in the cloned repository.
> 	repository does not have a worktree/checkout (i.e. if any of
> 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
> 
> +--shallow-submodules::
Should that be "--[no-]shallow-submodules" ?


> +	All submodules which are cloned, will be shallow.
Maybe you could extend it with "... will be shallow with a depth of 1." ?


> +
> --separate-git-dir=<git dir>::
> 	Instead of placing the cloned repository where it is supposed
> 	to be, place the cloned repository at the specified directory,
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b004fb4..ecdf308 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -40,6 +40,7 @@ static const char * const builtin_clone_usage[] = {
> 
> static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
> static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
> +static int option_shallow_submodules = -1;
> static char *option_template, *option_depth;
> static char *option_origin = NULL;
> static char *option_branch = NULL;
> @@ -91,6 +92,8 @@ static struct option builtin_clone_options[] = {
> 		    N_("create a shallow clone of that depth")),
> 	OPT_BOOL(0, "single-branch", &option_single_branch,
> 		    N_("clone only one branch, HEAD or --branch")),
> +	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
> +		    N_("any cloned submodules will be shallow")),
I am not familiar with this code but I assume the "no-" prefix flips the bool?

  
> 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
> 		   N_("separate git dir from working tree")),
> 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
> @@ -727,6 +730,10 @@ static int checkout(void)
> 		struct argv_array args = ARGV_ARRAY_INIT;
> 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
> 
> +		if (option_shallow_submodules == 1
> +		    || (option_shallow_submodules == -1 && option_depth))
> +			argv_array_push(&args, "--depth=1");
> +
> 		if (max_jobs != -1)
> 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
> 
> -- 
> 2.7.0.rc0.42.g8e9204f.dirty
> 
