From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.tcsh: fix redirect with noclobber
Date: Tue, 09 Jun 2015 11:20:19 -0700
Message-ID: <xmqqtwug7nh8.fsf@gitster.dls.corp.google.com>
References: <20150609172515.GA20638@yendor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Ariel Faigon <github.2009@yendor.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:51:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Ocf-00028j-BL
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbbFISvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:51:37 -0400
Received: from mail-ie0-f196.google.com ([209.85.223.196]:35989 "EHLO
	mail-ie0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbbFISvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:51:36 -0400
Received: by ierx19 with SMTP id x19so3290051ier.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i/2/fkU99Y3IJai18R7l4xkQXh3CgOvYKCh2UYygJjk=;
        b=lFk60J3/oV8Mg7Ev1hsLcE00k1h+rcUNSjTNwjaeTMxfyVDfyTBJxIPTWfQTzaSdrk
         RniooOyhZciGM/XYlCtlkpbsUC4cCeLp1L2b3urO35nPC+YPChOzPy6PZ6RftzOox8jF
         rN4O8JBnXkrvAgcQwU00Mmcim7ORsKf3QiEN0o++KvmpAGpHO4QqITENMWKGVUbuSih6
         f8wC/4t2mbMY3GsqEUWM/DTbxmcj41MHkLk+NerK06Ib2QYKi7x8XwPmdNFIDa4LfvK6
         46kPHH5dfwpPDas0aBZjwLmeg1H2FK7ppIBx/bxmQyz0g6Eqo1aLzuSqouqQVbRoacQV
         dLIw==
X-Received: by 10.50.79.167 with SMTP id k7mr162819igx.32.1433874021516;
        Tue, 09 Jun 2015 11:20:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id o9sm4388379ioe.35.2015.06.09.11.20.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 11:20:20 -0700 (PDT)
In-Reply-To: <20150609172515.GA20638@yendor.com> (Ariel Faigon's message of
	"Tue, 9 Jun 2015 10:25:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271228>

Ariel Faigon <github.2009@yendor.com> writes:

> tcsh users who happen to have 'set noclobber' elsewhere in their
> ~/.tcshrc or ~/.cshrc startup files get a 'File exist' error, and
> the tcsh completion file doesn't get generated/updated.
>
> Adding a `!` in the redirect works correctly for both clobber (default)
> and 'set noclobber' users.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Christian Couder <christian.couder@gmail.com>
> Signed-off-by: Ariel Faigon <github.2009@yendor.com>
> ---

Thanks for enduring three iterations for a single-liner.  This
versio will show nicely in "git log -p" output ;-)

In case anybody is wondering, that "Helped-by: notifications@github"
was merely because I said "this change makes sense, care to send it
over to us at git@vger?" from github UI on Ariel's commit.  I do not
deserve helped-by for merely encouraging participation.

Will queue.  Thanks again.

>
>  contrib/completion/git-completion.tcsh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
> index 6104a42..4a790d8 100644
> --- a/contrib/completion/git-completion.tcsh
> +++ b/contrib/completion/git-completion.tcsh
> @@ -41,7 +41,7 @@ if ( ! -e ${__git_tcsh_completion_original_script} ) then
>  	exit
>  endif
>  
> -cat << EOF > ${__git_tcsh_completion_script}
> +cat << EOF >! ${__git_tcsh_completion_script}
>  #!bash
>  #
>  # This script is GENERATED and will be overwritten automatically.
