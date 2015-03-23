From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 5/5] Update Bash completion script to include git log
 --merges option
Date: Mon, 23 Mar 2015 02:23:33 +0100
Message-ID: <20150323022333.Horde.P0Kh2JxuSiUs9IhG94BnsQ1@webmail.informatik.kit.edu>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
 <1427048921-28677-5-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 02:23:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZr5n-0006en-C6
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 02:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbbCWBXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 21:23:43 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58886 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751982AbbCWBXm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2015 21:23:42 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YZr5h-00034P-4S; Mon, 23 Mar 2015 02:23:41 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YZr5a-0003Mx-0p; Mon, 23 Mar 2015 02:23:34 +0100
Received: from x590d7fa5.dyn.telefonica.de (x590d7fa5.dyn.telefonica.de
 [89.13.127.165]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Mon, 23 Mar 2015 02:23:34 +0100
In-Reply-To: <1427048921-28677-5-git-send-email-koosha@posteo.de>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1427073821.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266112>

Hi,

I agree with Eric's comment about the subject line.

Quoting Koosha Khajehmoogahi <koosha@posteo.de>:

> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
>   contrib/completion/git-completion.bash | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 731c289..b63bb95 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1406,7 +1406,7 @@ _git_ls_tree ()
>   __git_log_common_options="
>   	--not --all
>   	--branches --tags --remotes
> -	--first-parent --merges --no-merges
> +	--first-parent --merges --merges= --no-merges
>   	--max-count=
>   	--max-age= --since= --after=
>   	--min-age= --until= --before=
> @@ -1451,6 +1451,10 @@ _git_log ()
>   		__gitcomp "long short" "" "${cur##--decorate=}"
>   		return
>   		;;
> +    --merges=*)
> +        __gitcomp "show hide only" "" "${cur##--merges=}"
> +        return
> +        ;;

Funny indentation, please use tabs instead of spaces.

Otherwise this patch looks good.

>   	--*)
>   		__gitcomp "
>   			$__git_log_common_options
> @@ -1861,6 +1865,10 @@ _git_config ()
>   		__gitcomp "$__git_log_date_formats"
>   		return
>   		;;
> +	log.merges)
> +		__gitcomp "show hide only"
> +		return
> +		;;
>   	sendemail.aliasesfiletype)
>   		__gitcomp "mutt mailrc pine elm gnus"
>   		return
> @@ -2150,6 +2158,7 @@ _git_config ()
>   		interactive.singlekey
>   		log.date
>   		log.decorate
> +		log.merges
>   		log.showroot
>   		mailmap.file
>   		man.
> --
> 2.3.3.263.g095251d.dirty
