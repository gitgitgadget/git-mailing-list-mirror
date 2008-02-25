From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Teach git-describe --long to output always the long format
Date: Sun, 24 Feb 2008 21:36:34 -0500
Message-ID: <20080225023634.GK8410@spearce.org>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 03:37:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTTDT-0005Xp-Tq
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 03:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbYBYCgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 21:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbYBYCgi
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 21:36:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49995 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbYBYCgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 21:36:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTTCb-0002L3-9j; Sun, 24 Feb 2008 21:36:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D35EC20FBAE; Sun, 24 Feb 2008 21:36:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74983>

Santi Bjar <sbejar@gmail.com> wrote:
> @@ -155,7 +156,11 @@ static void describe(const char *arg, int last_one)
>  
>  	n = cmit->util;
>  	if (n) {
> -		printf("%s\n", n->path);
> +		if (!longformat)
> +			printf("%s\n", n->path );

Extra whitespace after the "path".

> +		else
> +			printf("%s-0-g%s\n", n->path,
> +				find_unique_abbrev(cmit->object.sha1, abbrev));

Is this really that useful?  Where is having the tag and the commit
SHA-1 both useful?

>  		return;
>  	}
>  
> @@ -254,6 +259,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  		OPT_BOOLEAN(0, "debug",      &debug, "debug search strategy on stderr"),
>  		OPT_BOOLEAN(0, "all",        &all, "use any ref in .git/refs"),
>  		OPT_BOOLEAN(0, "tags",       &tags, "use any tag in .git/refs/tags"),
> +		OPT_BOOLEAN(0, "long",       &longformat, "always use long format"),

Documentation?

-- 
Shawn.
