From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 5/8] git-format-patch.txt: general rewordings and cleanups
Date: Thu, 23 Apr 2009 14:14:08 +0200
Message-ID: <49F05B90.8050208@drmicha.warpmail.net>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com> <1240479482-31366-2-git-send-email-bebarino@gmail.com> <1240479482-31366-3-git-send-email-bebarino@gmail.com> <1240479482-31366-4-git-send-email-bebarino@gmail.com> <1240479482-31366-5-git-send-email-bebarino@gmail.com> <1240479482-31366-6-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:16:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwxqZ-0003GX-En
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 14:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbZDWMOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 08:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbZDWMOS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 08:14:18 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45044 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755100AbZDWMOR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 08:14:17 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 6975931FD5E;
	Thu, 23 Apr 2009 08:14:16 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 23 Apr 2009 08:14:16 -0400
X-Sasl-enc: nCUox9OX3A449eEl0vDa/iwIsDE3n7eXOF6DERKRxMi5 1240488855
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 637813E952;
	Thu, 23 Apr 2009 08:14:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1240479482-31366-6-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117335>

Stephen Boyd venit, vidit, dixit 23.04.2009 11:37:
> Clarify --no-binary description using some words from the original
> commit 37c22a4b (add --no-binary, 2008-05-9). Cleanup --suffix
> description. Add --thread style option to synopsis and reorganize it a
> bit. Clarify renaming patches example and the configuration paragraph.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>  Documentation/git-format-patch.txt |   38 ++++++++++++++++++------------------
>  1 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 4a43c64..5ac9e33 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -9,10 +9,10 @@ git-format-patch - Prepare patches for e-mail submission
>  SYNOPSIS
>  --------
>  [verse]
> -'git format-patch' [-k] [-o <dir> | --stdout] [--thread]
> -		   [--attach[=<boundary>] | --inline[=<boundary>] |
> -		     [--no-attach]]
> -		   [-s | --signoff] [<common diff options>]
> +'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout]
> +		   [--thread[=<style>]]
> +		   [(--attach|--inline)[=<boundary>] | --no-attach]
> +		   [-s | --signoff]
>  		   [-n | --numbered | -N | --no-numbered]
>  		   [--start-number <n>] [--numbered-files]
>  		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
> @@ -20,6 +20,7 @@ SYNOPSIS
>  		   [--subject-prefix=Subject-Prefix]
>  		   [--cc=<email>]
>  		   [--cover-letter]
> +		   [<common diff options>]
>  		   [ <since> | <revision range> ]
>  
>  DESCRIPTION
> @@ -170,18 +171,17 @@ if that is not set.
>  --suffix=.<sfx>::
>  	Instead of using `.patch` as the suffix for generated
>  	filenames, use specified suffix.  A common alternative is
> -	`--suffix=.txt`.
> +	`--suffix=.txt`.  Leaving this empty will remove the `.patch`
> +	suffix.
>  +

Those asciidoc constructs in diff make me always wonder "Huh? A merge
diff -cc?"... It's fine, of course.

> -Note that you would need to include the leading dot `.` if you
> -want a filename like `0001-description-of-my-change.patch`, and
> -the first letter does not have to be a dot.  Leaving it empty would
> -not add any suffix.
> +Note the leading character does not have to be a dot; for example, you

Maybe "Note that the" sounds and reads better.

> +can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  
>  --no-binary::
> -	Don't output contents of changes in binary files, just take note
> -	that they differ.  Note that this disable the patch to be properly
> -	applied.  By default the contents of changes in those files are
> -	encoded in the patch.
> +	Do not output contents of changes in binary files, instead
> +	display a notice that those files changed.  Patches generated
> +	using this option cannot be applied properly, but they are
> +	still useful for code review.
>  
>  --root::
>  	Treat the revision argument as a <revision range>, even if it
> @@ -192,10 +192,10 @@ not add any suffix.
>  
>  CONFIGURATION
>  -------------
> -You can specify extra mail header lines to be added to each message
> -in the repository configuration, new defaults for the subject prefix
> -and file suffix, control attachments, and number patches when outputting
> -more than one.
> +You can specify extra mail header lines to be added to each message,
> +defaults for the subject prefix and file suffix, number patches when
> +outputting more than one patch, add "Cc:" headers, configure attachments,
> +and signoff patches with configuration variables.

"sign off"

>  
>  ------------
>  [format]
> @@ -243,8 +243,8 @@ $ git format-patch -M -B origin
>  +
>  Additionally, it detects and handles renames and complete rewrites
>  intelligently to produce a renaming patch.  A renaming patch reduces
> -the amount of text output, and generally makes it easier to review it.
> -Note that the "patch" program does not understand renaming patches, so
> +the amount of text output, and generally makes it easier to review.
> +Note that non-git "patch" programs won't understand renaming patches, so
>  use it only when you know the recipient uses git to apply your patch.
>  
>  * Extract three topmost commits from the current branch and format them

Looks nice overall, especially the ones I'm not replying to ;)

Michael
