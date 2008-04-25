From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 01/11] Add tests for git cat-file
Date: Thu, 24 Apr 2008 23:56:29 -0700
Message-ID: <20080425065614.GA5758@untitled>
References: <1208978273-98146-1-git-send-email-aroben@apple.com> <1208978273-98146-2-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 08:57:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpHrz-0003Jl-GQ
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 08:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbYDYG4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 02:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbYDYG4b
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 02:56:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39614 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbYDYG4b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 02:56:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 71C942DC08B;
	Thu, 24 Apr 2008 23:56:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1208978273-98146-2-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80328>

Adam Roben <aroben@apple.com> wrote:
> 
> Signed-off-by: Adam Roben <aroben@apple.com>
> ---
>  t/t1006-cat-file.sh |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 101 insertions(+), 0 deletions(-)
>  create mode 100755 t/t1006-cat-file.sh
> 
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> new file mode 100755
> index 0000000..15741d9
> --- /dev/null
> +++ b/t/t1006-cat-file.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +
> +test_description='git cat-file'
> +
> +. ./test-lib.sh
> +
> +function echo_without_newline()

The "function " keyword is a bashism and not needed, this breaks
my test run with dash as /bin/sh (same thing in t1007).

> +{
> +    echo "$@\c"

I guess we have different bash versions/options, because this breaks for
me in bash (3.1dfsg-8 from Debian etch).  It would need -e to handle to
handle escape sequence, but that's a bashism, too.

Use printf "$@" here instead.

So yes, this test was broken in both dash and bash for me without the
above fixes.

-- 
Eric Wong
