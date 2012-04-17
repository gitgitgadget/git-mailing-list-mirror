From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v6 4/4] git-rebase: add keep_empty flag
Date: Tue, 17 Apr 2012 23:47:01 +0200
Message-ID: <20120417214659.GC19908@ecki>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-5-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGY1-00024m-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab2DQWGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:06:49 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:50289 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab2DQWGt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:06:49 -0400
Received: from [127.0.0.1] (p5B22CC82.dip.t-dialin.net [91.34.204.130])
	by bsmtp.bon.at (Postfix) with ESMTP id EED8713004C;
	Wed, 18 Apr 2012 00:06:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1334686809-17634-5-git-send-email-nhorman@tuxdriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195814>

On Tue, Apr 17, 2012 at 02:20:09PM -0400, Neil Horman wrote:
>
> @@ -780,9 +793,17 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
>  	sed -n "s/^>//p" |
>  while read -r shortsha1 rest
>  do
> +
> +	if test -z "$keep_empty" && is_empty_commit $shortsha1
> +	then
> +		comment_out="# pick"
> +	else
> +		comment_out="pick"
> +	fi

You forgot to change this to comment_out="# " and comment_out="".
