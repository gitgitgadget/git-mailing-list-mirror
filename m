From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: teach git-svn to populate svn:mergeinfo
Date: Fri, 9 Sep 2011 15:21:59 -0700
Message-ID: <20110909222159.GA6530@dcvr.yhbt.net>
References: <20110907133605.07ecad1b@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 00:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R29Sc-0003lU-ND
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 00:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759903Ab1IIWWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 18:22:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41875 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759017Ab1IIWWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 18:22:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C2E210B1;
	Fri,  9 Sep 2011 22:21:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110907133605.07ecad1b@robyn.woti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181127>

Bryan Jacobs <bjacobs@woti.com> wrote:
> This is the second revision of a patch I posted earlier. I believe
> this patch is now suitable for inclusion.

Some comments inline, but I can clean them up myself and push out in a
bit.

> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -213,6 +213,14 @@ discouraged.
>  	store this information (as a property), and svn clients starting from
>  	version 1.5 can make use of it. 'git svn' currently does not use it
>  	and does not set it automatically.

I noticed this conflicts when applying due to the missing --mergeinfo=
documentation.  Did you intend to remove --mergeinfo entirely and
replace it with this?  I think some folks already depend on it (it's
been around since last year).

> +	if (not defined($push_merge_info)
> +			or $push_merge_info eq "false"
> +			or $push_merge_info eq "no"
> +			or $push_merge_info eq "never") {

I missed this the first time, but "||" and "!" are easier for
C programmers to understand and higher in precedence (ref: perlop manpage)

-- 
Eric Wong
