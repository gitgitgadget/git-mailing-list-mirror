From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] t3404: slight improvements
Date: Fri, 20 Jun 2008 14:05:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806201404020.6439@racer>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net> <1213929935-15093-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:08:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gLS-0004rz-6i
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbYFTNHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbYFTNHG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:07:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:56894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753189AbYFTNHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:07:05 -0400
Received: (qmail invoked by alias); 20 Jun 2008 13:07:03 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp063) with SMTP; 20 Jun 2008 15:07:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/apgclAsfaWhC7X4FNw/94EF/EYp/zM9bHscCZfu
	YKU6hYv45p57Pi
X-X-Sender: gene099@racer
In-Reply-To: <1213929935-15093-2-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85640>

Hi,

On Fri, 20 Jun 2008, Stephan Beyer wrote:

> This patch adds some extra checks into some
> test cases and changes "! git ..." into
> "test_must_fail git".

I think your oneline should read "t3404: be more anal".

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index e6f3fad..daba5fd 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -107,7 +107,8 @@ chmod a+x fake-editor.sh
>  
>  test_expect_success 'no changes are a nop' '
>  	git rebase -i F &&
> -	test $(git rev-parse I) = $(git rev-parse HEAD)
> +	test $(git rev-parse I) = $(git rev-parse HEAD) &&
> +	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2"
>  '

You could have saved some diff-screen-estate by putting the extra check 
_before_ the original one.

Other than that, I think this patch is fine.

Ciao,
Dscho
