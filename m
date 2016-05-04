From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Wed, 4 May 2016 16:26:42 -0700
Message-ID: <20160504232642.GC395@google.com>
References: <1462401603-2067-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 05 01:26:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay6Bu-0008Gw-A0
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 01:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbcEDX0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 19:26:47 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33484 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbcEDX0q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 19:26:46 -0400
Received: by mail-pa0-f54.google.com with SMTP id xk12so29298034pac.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 16:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oyWZNBDYEA5LEB7DPMUVkbkHlO6NR6GhMQUYE+sJaGA=;
        b=uyl34VB4AB4XMlV8DIZkfMQSlZ0/Fbh0kya/SXvoBQqCOcAqTwcn7kO6SKTAR91pvI
         wWwrvsUXyjWNKunqcfV2bWeL1VKljFBJqRFhTEOrmfKg2wzvsJPMrQI/j+8bIw1TtnRK
         oqL6tbAE4GLlH86KrhxJPq1BD7O9K3kS2dTbCX3Twmw9ZHX/I3BE/1KIMhlODCpfRjsQ
         xy/90u8HhmGtdTs+zO3f4bRTz4hKNynlqex2KmWO9v/9oSkFvmlDGx/y7ITcOBYqq+oe
         vgbnuMQ31AoLVlIPtWXg1Eqn7QNRBjuyQLHSDZ/36YNVnj1vRGQeeI+hUJNX2Y2GPvlx
         e6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyWZNBDYEA5LEB7DPMUVkbkHlO6NR6GhMQUYE+sJaGA=;
        b=j9JG16qyWMatXUWFfWWwmowRWN4mNbPdkuOuPCMU2N4QUDooLwjND7wRb3+XW+AAiY
         BYsSoNJ+bQuVIUEGTmrUARxeovSxa75cEkCKRagWBexIisJoFllA9N4Vp7RQxuySp8fi
         FCR/G4lcsABzrHVpPHhri85KAwXgGjqUMKghwfB9eIo8PmxByksZoNW04FvHdie7QBkP
         j9FX6d56LdrxhQRif83jEIThdqFYLt3wZhzfZbL42Knrmbw/LdKl/N1GoQozSYFu/8eA
         HQanRDxzl/+YRtGeJFHLibAzimRgkZjJvIeCqY93NJ2VT5asK7kaKEq9t8gi7oBgAcvQ
         E1cg==
X-Gm-Message-State: AOPr4FVPzLS3hhzRfBX3oWxmFE2iodJtuMFm2DAMuAM2S9aQ8pyEahf5cDVVFGhECicN7Q==
X-Received: by 10.66.119.177 with SMTP id kv17mr15945677pab.57.1462404405045;
        Wed, 04 May 2016 16:26:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:2402:f378:bbc1:db8f])
        by smtp.gmail.com with ESMTPSA id d78sm8527136pfb.59.2016.05.04.16.26.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 16:26:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462401603-2067-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293623>

Hi,

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> * reworded commit message slightly (realize, pathspec)
> * reworded the documentation 

Yay, thanks for your work on this.

[...]
> +++ b/Documentation/git-submodule.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> -'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
> +'git submodule' [--quiet] deinit [-f|--force] (-a|--all|[--] <path>...)
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
>  	      [-f|--force] [--rebase|--merge] [--reference <repository>]
>  	      [--depth <depth>] [--recursive] [--] [<path>...]
> @@ -140,12 +140,20 @@ deinit::
>  	tree. Further calls to `git submodule update`, `git submodule foreach`
>  	and `git submodule sync` will skip any unregistered submodules until
>  	they are initialized again, so use this command if you don't want to
> -	have a local checkout of the submodule in your work tree anymore. If
> +	have a local checkout of the submodule in your working tree anymore. If
>  	you really want to remove a submodule from the repository and commit
>  	that use linkgit:git-rm[1] instead.
> ++
> +When the command is run without pathspec, it errors out,
> +instead of deinit-ing everything, to prevent mistakes. In
> +version 2.8 and before the command gave a suggestion to use
> +'.' to unregister all submodules when it was invoked without
> +any argument, but this suggestion did not work and gave a
> +wrong message if you followed it in pathological cases and is
> +no longer recommended.

Why tell the user what happened in 2.8 and earlier?  It's not clear what
the reader would do with that information.

I think this paragraph could be removed.  --all is explained lower
down and the error message points it out to users who need it.

>  +
> -If `--force` is specified, the submodule's work tree will be removed even if
> -it contains local modifications.
> +If `--force` is specified, the submodule's working tree will
> +be removed even if it contains local modifications.

(unnecessary rewrapping)

[...]
>  update::
>  +
> @@ -247,6 +255,11 @@ OPTIONS
>  --quiet::
>  	Only print error messages.
>  
> +-a::
> +--all::
> +	This option is only valid for the deinit command. Unregister all
> +	submodules in the working tree.

This could use an explanation of why I'd want to use it.  E.g.

	This option is only valid for the deinit command. Unregister all
	submodules. Scripts should use this option instead of passing '.'
	to deinit because it works even in an empty repository with no
	submodules present.

Not about this patch: the organization of options is a little strange.
A separate section with options for each subcommand would be easier to
read.

Do we want to claim the short-and-sweet option -a?  (I don't mind but it
doesn't seem necessary.)

[...]
> @@ -257,8 +270,8 @@ OPTIONS
>  --force::
>  	This option is only valid for add, deinit and update commands.
>  	When running add, allow adding an otherwise ignored submodule path.
> -	When running deinit the submodule work trees will be removed even if
> -	they contain local changes.
> +	When running deinit the submodule working trees will be removed even
> +	if they contain local changes.

Unrelated change?

[...]
> @@ -544,9 +548,13 @@ cmd_deinit()
>  		shift
>  	done
>  
> -	if test $# = 0
> +	if test -n "$deinit_all" && test "$#" -ne 0
> +	then
> +		die "$(eval_gettext "--all and pathspec are incompatible")"

This message still feels too low-level to me, but I might be swimming
uphill here.

Another option would be to call 'usage' and be done.

[...]
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh

Makes sense.

In the context of the original motivation: this patch improves the
advice printed by plain "git submodule deinit" but doesn't help with
existing callers that might have run "git submodule deinit .".  It might
make sense to handle '.' as a historical special case in a separate
patch.

Thanks and sorry for all the complication,
Jonathan
