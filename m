From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: add angle brackets to usage string
Date: Fri, 16 Oct 2015 09:36:47 -0700
Message-ID: <xmqqwpumg480.fsf@gitster.mtv.corp.google.com>
References: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pyokagan@gmail.com, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 18:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn7zz-0003oX-9V
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 18:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbbJPQgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 12:36:50 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35108 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbbJPQgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 12:36:49 -0400
Received: by padcn9 with SMTP id cn9so10203250pad.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fErCbLdZgZDpLfdN+/T8iGRUtE4CJkRm6woDj/sMplY=;
        b=oOITOgELN7INdKxqh8a7phyI3vkvsUm/Di4pDLCwweUlybZEJNWIxBOE7qPfMsrLCy
         w4MVAkkhzvVUgcAJHx3cxFyk17W+m5/o+kwyu2F10tipmUy1/DNHhoDcjb7wWrrueu6A
         k6zZTa6O3I1uiew6W/9HXi996XFsIPHEp/fY01Npyg9O3zEjj52JRNpN3ec+GF7zy7Mp
         46jgpkGC/OAPq7U2HaK5A1AYMz6fqhtKype7cHdbCycPrsdL2tvEct3yd630uR9q85cb
         g0atGCVfpmuFmOGnnctNJmkNUAoFG2c3Ltgu5Ms+8Uz6eP5gHlNAFtZlhibNKT/hwwdb
         LcQQ==
X-Received: by 10.68.92.194 with SMTP id co2mr17714137pbb.147.1445013409161;
        Fri, 16 Oct 2015 09:36:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id ey17sm22252916pac.26.2015.10.16.09.36.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 09:36:48 -0700 (PDT)
In-Reply-To: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Thu, 15 Oct 2015 20:22:13 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279749>

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---

Makes sense, as all the other <placeholders> in the usage string are
bracketted.

Does it make sense to do this for contrib/examples, which is the
historical record, though?  The first one I found with

    $ less contrib/examples/*

was this:

    #!/bin/sh

    OPTIONS_KEEPDASHDASH=t
    OPTIONS_SPEC="\
    git-checkout [options] [<branch>] [<paths>...]

and the next one (clean) follows the same pattern.

I'd discard the part of the patch for contrib/ and queue.

Thanks.

>  builtin/pull.c               | 2 +-
>  contrib/examples/git-pull.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index a39bb0a..bf3fd3f 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -66,7 +66,7 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
>  }
>  
>  static const char * const pull_usage[] = {
> -	N_("git pull [options] [<repository> [<refspec>...]]"),
> +	N_("git pull [<options>] [<repository> [<refspec>...]]"),
>  	NULL
>  };
>  
> diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
> index 6b3a03f..bcf362e 100755
> --- a/contrib/examples/git-pull.sh
> +++ b/contrib/examples/git-pull.sh
> @@ -8,7 +8,7 @@ SUBDIRECTORY_OK=Yes
>  OPTIONS_KEEPDASHDASH=
>  OPTIONS_STUCKLONG=Yes
>  OPTIONS_SPEC="\
> -git pull [options] [<repository> [<refspec>...]]
> +git pull [<options>] [<repository> [<refspec>...]]
>  
>  Fetch one or more remote refs and integrate it/them with the current HEAD.
>  --
