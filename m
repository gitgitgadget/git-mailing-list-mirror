From: Larry Streepy <larry@lightspeed.com>
Subject: Re: git pull fails to exit with non-zero status after fatal error
Date: Sat, 03 Mar 2007 13:27:33 -0600
Message-ID: <45E9CC25.3030305@lightspeed.com>
References: <45E9A641.8020002@lightspeed.com> <Pine.LNX.4.63.0703031913100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 03 20:25:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNZqt-0006j5-LC
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 20:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbXCCTZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 14:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbXCCTZE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 14:25:04 -0500
Received: from mailhost.lightspeed.com ([12.44.179.187]:39689 "EHLO
	lightspeed.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030387AbXCCTZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 14:25:01 -0500
Received: from [72.177.124.81] (account larry HELO [127.0.0.1])
  by lightspeed.com (CommuniGate Pro SMTP 5.0.9)
  with ESMTPA id 3618167; Sat, 03 Mar 2007 11:23:12 -0800
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0703031913100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41317>

I'll give it a try and let you know.

Thanks for the quick feedback.

Larry.

Johannes Schindelin wrote:
> Does this fix it?
>
> diff --git a/git-merge.sh b/git-merge.sh
> index 498c938..6b23bf5 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -295,8 +295,9 @@ f,*)
>  	new_head=$(git-rev-parse --verify "$1^0") &&
>  	git-read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
>  	finish "$new_head" "Fast forward"
> +	ret=$?
>  	dropsave
> -	exit 0
> +	exit $ret
>  	;;
>  ?,1,?*"$LF"?*,*)
>  	# We are not doing octopus and not fast forward.  Need a
>   
