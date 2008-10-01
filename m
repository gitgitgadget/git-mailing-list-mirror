From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] git grep: Add "-z/--null" option as in GNU's grep.
Date: Wed, 1 Oct 2008 09:17:05 -0700
Message-ID: <20081001161705.GH21310@spearce.org>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de> <1222877475-2699-1-git-send-email-killekulla@rdrz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	madcoder@debian.org
To: Raphael Zimmerer <killekulla@rdrz.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 18:19:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl4P5-0005bq-Hk
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 18:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbYJAQRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 12:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYJAQRH
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 12:17:07 -0400
Received: from george.spearce.org ([209.20.77.23]:32937 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbYJAQRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 12:17:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DCA8F3835F; Wed,  1 Oct 2008 16:17:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222877475-2699-1-git-send-email-killekulla@rdrz.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97246>

Raphael Zimmerer <killekulla@rdrz.de> wrote:
> diff --git a/builtin-grep.c b/builtin-grep.c
> index 3a51662..2241324 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -295,6 +295,9 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
>  		push_arg("-l");
>  	if (opt->unmatch_name_only)
>  		push_arg("-L");
> +	if (opt->null_following_name)
> +		// in GNU grep git's "-z" translates to "-Z"
> +		push_arg("-Z");

We use /* */ style comments in Git.  I've amended the patch with
the simple // -> /* */ translation.

The rest of this change looks good to me.  Its queued for next.

-- 
Shawn.
