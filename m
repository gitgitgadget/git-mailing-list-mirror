From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] svn: Add && to t9107-git-svn-migrarte.sh
Date: Thu, 6 Aug 2009 14:28:41 -0700
Message-ID: <20090806212841.GA13437@dcvr.yhbt.net>
References: <1249350039-7338-1-git-send-email-adambrewster@gmail.com> <1249350039-7338-2-git-send-email-adambrewster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 23:28:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZAW0-0007wb-Bx
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 23:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247AbZHFV2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 17:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756232AbZHFV2l
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 17:28:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34453 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801AbZHFV2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 17:28:40 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 95E561F4E8;
	Thu,  6 Aug 2009 21:28:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1249350039-7338-2-git-send-email-adambrewster@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125128>

Adam Brewster <adambrewster@gmail.com> wrote:
> It was probably intended for the test to fail unless all of the
> commands succeed.

I think you've uncovered some major breakage in this test that never got
noticed until now.  I'll try to take a harder look tonight or this
weekend.

Fortunately, this functionality is rarely needed these days :)
Thanks for the heads up!

> ---
>  t/t9107-git-svn-migrate.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
> index 3a9e077..145a367 100755
> --- a/t/t9107-git-svn-migrate.sh
> +++ b/t/t9107-git-svn-migrate.sh
> @@ -93,7 +93,7 @@ test_expect_success 'migrate --minimize on old inited layout' '
>  	grep "^branches/b:refs/remotes/b$" fetch.out &&
>  	grep "^tags/0\.1:refs/remotes/tags/0\.1$" fetch.out &&
>  	grep "^tags/0\.2:refs/remotes/tags/0\.2$" fetch.out &&
> -	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out
> +	grep "^tags/0\.3:refs/remotes/tags/0\.3$" fetch.out &&
>  	grep "^:refs/${remotes_git_svn}" fetch.out
