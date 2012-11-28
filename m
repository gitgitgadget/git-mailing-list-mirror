From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/4] git-svn: Expand documentation for --follow-parent
Date: Wed, 28 Nov 2012 15:48:51 +0100
Message-ID: <50B62453.7080203@drmicha.warpmail.net>
References: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name> <a9748faec2a18231ad588c1a2dedb82e74685d74.1353691892.git.Sebastian.Leske@sleske.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Sebastian Leske <Sebastian.Leske@sleske.name>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:49:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdiwn-0001Xe-1B
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 15:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab2K1Osx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 09:48:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59293 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753964Ab2K1Osw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2012 09:48:52 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5556220B72;
	Wed, 28 Nov 2012 09:48:52 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 28 Nov 2012 09:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=rI1DrwXzUPk6RC+3CrtajH
	SckWQ=; b=HX9SY2yZIwJqvyXcpK6PTbtkFozruIFkMSopfPRAyJY/PCWoIjsMCb
	cxCoycrzTc7ksLT04a4gnfrLp+eQOIxT/ljWen5Tn07Qz9B8zWk6ngMtrmbbY3f3
	fFSBw2sY0bkot41xcGJuOs/teSGgGp6EaGBm+QwxCtcK4fiWtyfvA=
X-Sasl-enc: 65ptKpLCrL0VLeDTE0o9eKUifM+YkEt87cvSe0bJ5Its 1354114132
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id ACCA248263C;
	Wed, 28 Nov 2012 09:48:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <a9748faec2a18231ad588c1a2dedb82e74685d74.1353691892.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210735>

Sebastian Leske venit, vidit, dixit 23.11.2012 08:13:
> Describe what the option --follow-parent does, and what happens if it is
> set or unset.
> 
> Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
> ---
>  Documentation/git-svn.txt |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 928a961..92780ef 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -628,11 +628,19 @@ ADVANCED OPTIONS
>  	Default: "svn"
>  
>  --follow-parent::
> +	This option is only relevant if we are tracking branches (using
> +	one of the repository layout options --trunk, --tags,
> +	--branches, --stdlayout). For each tracked branch, try to find
> +	out where its revision was copied (i.e. branched) from, and set
> +	a suitable parent in the first git commit for the branch.
>  	This is especially helpful when we're tracking a directory
> -	that has been moved around within the repository, or if we
> -	started tracking a branch and never tracked the trunk it was
> -	descended from. This feature is enabled by default, use
> -	--no-follow-parent to disable it.
> +	that has been moved around within the repository (note that you
> +	must track both the old and the new name for the whole history
> +	to be imported).  If this feature is disabled, the branches
> +	created by 'git svn' will all be linaear and not share any

linear

> +	history, meaning that there will be no information on where
> +	branches where branched off or merged. This feature is enabled
> +	by default, use --no-follow-parent to disable it.
>  +
>  [verse]
>  config key: svn.followparent
> 
