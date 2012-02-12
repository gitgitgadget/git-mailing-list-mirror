From: =?UTF-8?B?IldlaS1ZaW4gQ2hlbiAo6Zmz5aiB5bC5KSI=?= 
	<chen.weiyin@gmail.com>
Subject: Re: [PATCH] git-svn: Fix time zone in --localtime
Date: Sun, 12 Feb 2012 21:49:19 +0800
Message-ID: <4F37C35F.9060307@gmail.com>
References: <4EEEF199.4000404@gmail.com> <20120212081553.GA10068@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pete Harlan <pgit@pcharlan.com>,
	gitster@pobox.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 12 15:27:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwaP3-0005A8-2U
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 15:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab2BLO1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 09:27:16 -0500
Received: from mailsqr.mstarsemi.com ([59.120.57.249]:15358 "EHLO
	mailsqr.mstarsemi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab2BLO1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 09:27:15 -0500
X-Greylist: delayed 2254 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Feb 2012 09:27:15 EST
Received: from mailsqr.mstarsemi.com (localhost [127.0.0.2] (may be forged))
	by mailsqr.mstarsemi.com with ESMTP id q1CDrOla094142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Sun, 12 Feb 2012 21:53:24 +0800 (GMT-8)
	(envelope-from chen.weiyin@gmail.com)
Received: from [IPv6:::1] ([172.17.8.86])
	(authenticated bits=0)
	by mailsqr.mstarsemi.com with ESMTP id q1CDnIXJ093459;
	Sun, 12 Feb 2012 21:49:19 +0800 (GMT-8)
	(envelope-from chen.weiyin@gmail.com)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20120212081553.GA10068@dcvr.yhbt.net>
X-MAIL: mailsqr.mstarsemi.com q1CDnIXJ093459
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190571>

On 2012-02-12 16:15, Eric Wong wrote:
> I needed the following additional change to get things working:
>
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -6111,7 +6111,7 @@ sub run_pager {
>
>   sub format_svn_date {
>   	my $t = shift || time;
> -	my $gmoff = get_tz($t);
> +	my $gmoff = Git::SVN::get_tz($t);
>   	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime($t));
>   }

Sorry, my bad. This bug of missing package reference can be triggered by 
"git svn log", but unfortunately I didn't test this part manually. I'll 
learn to use the git test suite next time.

>
> If there are no objections, I'll squash this and push for Junio
> tomorrow.

Excellent. Thank you for the testing and fixing effort!
