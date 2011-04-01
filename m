From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] Documentation: Document diff.<tool>.* and filter.<driver>.*
 in config
Date: Fri, 01 Apr 2011 15:56:32 +0200
Message-ID: <4D95D990.1050306@drmicha.warpmail.net>
References: <m3ipuy49fg.fsf@localhost.localdomain> <1301654600-8901-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git list <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 16:00:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5eta-0000PD-NK
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 16:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566Ab1DAOAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 10:00:04 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42337 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754340Ab1DAOAD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 10:00:03 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AF92120AAC;
	Fri,  1 Apr 2011 10:00:02 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 01 Apr 2011 10:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=qAItbicMl6RBSQlkteoSciUyEIU=; b=nHlzUXGlhNDe7pQGnQCu/sGYvi6DkGCgvsI4+wxn02cgnDqFM9cDeJYP3pSknmmX0xNWrOeXSpJQqgBM6eerpFLY4gbRYylcCoyh49tEAxXnkEhkCLkHK9SuBgFEh8zBuPRXknzZ4q0sw9mWyecP1ZixQ+bGZn/Q5RgzXbxYa6I=
X-Sasl-enc: nMW5/EADZdLQKaIwmLkIEbTFkXndLYuo96ZAuq7rj9Vy 1301666402
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D0928442F78;
	Fri,  1 Apr 2011 10:00:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170586>

Ramkumar Ramachandra venit, vidit, dixit 01.04.2011 12:43:
> Although the gitattributes page contains comprehensive information
> about these configuration options, they should be included in the
> config documentation for completeness.
> 
> Helped-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> The first iteration of this patch contained completely wrong
> descriptions for diff.<tool>.* options. Thanks to Jakub for pointing
> them out, and for pointing out that I left out a a few options
> undocumented (found in userdiff.c).
> 
>  Documentation/config.txt |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 46 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 8ea55d4..b2ec4e1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -875,6 +875,42 @@ diff.tool::
>  	the same valid values as `merge.tool` minus "tortoisemerge"
>  	and plus "kompare".
>  
> +diff.<tool>.command::
> +	Defines command to be called to generate diff for files with
> +	`diff=<tool>` gitattribute.  See linkgit:gitattributes[5] for
> +	details.
> +
> +diff.<tool>.funcname::
> +	Specifies a regular expression that matches a line to use as
> +	the hunk header for files with `diff=<tool>` gitattribute. A
> +	built-in pattern may also be used.  See
> +	linkgit:gitattributes[5] for details.
> +
> +diff.<tool>.xfuncname::
> +	Same as 'diff.<tool>.funcname', except that an extended
> +	regular expression can be specified in this case.
> +
> +diff.<tool>.binary::
> +	Set to true to treat files files with `diff=<tool>`
> +	gitattribute as binary for the purposes of diff.  See
> +	linkgit:gitattributes[5] for details.
> +
> +diff.<tool>.textconv::
> +	Defines command to be called to generate text-converted version
> +	of a binary file with `diff=<tool>` gitattribute.  The result of
> +	the conversion is used to generate human-readable diff.  See
> +	linkgit:gitattributes[5] for details.
> +
> +diff.<tool>.wordregex::
> +	Specifies the regular expression to use to customize the rules
> +	that `git diff --word-diff` uses to split words in a line.
> +	See linkgit:gitattributes[5] for details.
> +
> +diff.<tool>.cachetextconv::
> +	Set to true to enable caching of text conversion outputs for
> +	files with `diff=<tool>` gitattribute.  See
> +	linkgit:gitattributes[5] for details.
> +

I am sorry, but I dislike this for several reasons. First, the wording:
"to use to customize" and the like are no fun to read, and there are
several articles missing.

More importantly: Those config options are not about difftools! Having
diff.<tool>.* before difftool.* is grossly misleading. The options above
are all about external diff drivers. So, diff.<driver>.* would be
appropriate here, esp. when looking at merge.*

>  difftool.<tool>.path::
>  	Override the path for the given tool.  This is useful in case
>  	your tool is not in the PATH.
> @@ -973,6 +1009,16 @@ format.signoff::
>      the rights to submit this work under the same open source license.
>      Please see the 'SubmittingPatches' document for further discussion.
>  
> +filter.<driver>.clean::
> +	Defines the command to be used to convert the contents of
> +	worktree file upon checkin.  See linkgit:gitattributes[5] for
> +	details.
> +
> +filter.<driver>.smudge::
> +	Defines the command to be used to convert the blob object to
> +	worktree file upon checkout.  See linkgit:gitattributes[5] for
> +	details.
> +
>  gc.aggressiveWindow::
>  	The window size parameter used in the delta compression
>  	algorithm used by 'git gc --aggressive'.  This defaults
