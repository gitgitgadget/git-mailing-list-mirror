From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Add test for filter-branch on a subdirectory that's been added and deleted and re-added
Date: Sat, 8 Mar 2008 06:52:05 -0500
Message-ID: <A766C00E-2A8B-4DAF-A8F4-9B99D6D18F3A@sb.org>
References: <1204977007-7267-3-git-send-email-kevin@sb.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 12:52:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXxba-0002rK-Pn
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 12:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbYCHLwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 06:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbYCHLwI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 06:52:08 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:45754 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752712AbYCHLwI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 06:52:08 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id E8E7D109EB5;
	Sat,  8 Mar 2008 03:52:06 -0800 (PST)
In-Reply-To: <1204977007-7267-3-git-send-email-kevin@sb.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76558>

Damnit, I just send those patches without the Signed-Off line. Should  
I re-send, or is it acceptable to just say I'm signing off on these  
and anyone is free to add my Signed-Off line when committing?

-Kevin Ballard

On Mar 8, 2008, at 6:50 AM, Kevin Ballard wrote:

> Add a currently-failing test for the case when git-filter-branch
> is run with the --subdirectory-filter referencing a folder that
> has been added, deleted, and re-added. Such an action should work,
> but as this test shows it ends up blowing up.
> ---
> t/t7003-filter-branch.sh |   13 +++++++++++++
> 1 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> index 868babc..933157b 100755
> --- a/t/t7003-filter-branch.sh
> +++ b/t/t7003-filter-branch.sh
> @@ -179,4 +179,17 @@ test_expect_success 'Name needing quotes' '
>
> '
>
> +test_expect_success 'Subdirectory filter on folder with non- 
> contiguous history' '
> +	mkdir foo &&
> +	touch foo/bar &&
> +	git add foo &&
> +	git commit -m "Adding foo" &&
> +	git rm -r foo &&
> +	git commit -m "Removing foo" &&
> +	mkdir foo &&
> +	touch foo/bar &&
> +	git commit -m "Re-adding foo" &&
> +	git filter-branch --subdirectory-filter foo
> +'
> +
> test_done
> -- 
> 1.5.4.3.487.g5a92
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com


