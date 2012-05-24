From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn.perl: consider all ranges for a given merge,
 instead of only tip-by-tip
Date: Wed, 23 May 2012 20:02:55 -0700
Message-ID: <20120524030255.GA23382@dcvr.yhbt.net>
References: <1337820046-4791-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: avarab@gmail.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 05:03:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXOKN-0000CJ-0q
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 05:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352Ab2EXDC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 23:02:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56564 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932116Ab2EXDC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 23:02:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924311F531;
	Thu, 24 May 2012 03:02:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1337820046-4791-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198343>

Steven Walter <stevenrwalter@gmail.com> wrote:

I'll wait for input on others who understand mergeinfo better than
I do to chime in on the actual changes.  Some nits on the tests:

> +# Copyright (c) 2010 Steven Walter

2010?

> +test_expect_success 'verify merge commit' 'x=$(git rev-parse HEAD^2) &&
> +	y=$(git rev-parse branch2) &&
> +	[ $x == $y ]

== is a bash-ism, and we prefer 'test'.  A single '=' works fine here,
but it's probably better to prefix and quote if you're paranoid:

	test "x$x" = "x$y"
