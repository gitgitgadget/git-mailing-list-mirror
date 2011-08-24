From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] git-reset.txt: Be clearer about the symbolic ref
	nature of HEAD
Date: Wed, 24 Aug 2011 07:34:58 -0400
Message-ID: <1314185698.13674.8.camel@drew-northup.unet.maine.edu>
References: <f903e0bb1c14cb083c263deb165dc9495ab4c60e.1314179720.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 13:35:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwBjl-0001KG-6D
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 13:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab1HXLfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 07:35:08 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:54973 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab1HXLfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 07:35:07 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p7OBZ2Yr027470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 24 Aug 2011 07:35:02 -0400
In-Reply-To: <f903e0bb1c14cb083c263deb165dc9495ab4c60e.1314179720.git.git@drmicha.warpmail.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p7OBZ2Yr027470
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1314790503.21432@eeyHCMCkJZaaB1ySVaTtSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179997>


On Wed, 2011-08-24 at 11:56 +0200, Michael J Gruber wrote:
> "git reset" updates the ref which HEAD points to (or HEAD itself, if
> detached), due to being a symbolic ref (unless detached). Therefore,
> "updating/resetting HEAD" is a possible source of confusion especially when
> compared with "git checkout", and the change in
> d537c74 (git-reset.txt: make modes description more consistent, 2010-09-15)
> did not quite help.
> 
> Clean up after d537c74 (myself) and try to be even clearer about which
> ref is changed by "git reset". Avoid the term "symbolic ref", because who can
> tell *HEAD from HEAD from &HEAD?
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

Looks reasonable to me.

>  Documentation/git-reset.txt |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index b2832fc..96c964d 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -15,7 +15,7 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  In the first and second form, copy entries from <commit> to the index.
> -In the third form, set the current branch head (HEAD) to <commit>, optionally
> +In the third form, set the current branch head (which HEAD points to) to <commit>, optionally
>  modifying index and working tree to match.  The <commit> defaults to HEAD
>  in all forms.
>  
> @@ -44,8 +44,9 @@ you can use it to selectively reset hunks. See the ``Interactive Mode''
>  section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.
>  
>  'git reset' [--<mode>] [<commit>]::
> -	This form resets the current branch head to <commit> and
> -	possibly updates the index (resetting it to the tree of <commit>) and
> +	This form resets the current branch head (which HEAD points to) to <commit>;
> +	if HEAD points to a commit (aka detached HEAD) then HEAD is reset to <commit>.
> +	This form also possibly updates the index (resetting it to the tree of <commit>) and
>  	the working tree depending on <mode>, which
>  	must be one of the following:
>  +
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
