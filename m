From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 3/5] stash: Use new %g/%G formats instead of sed
Date: Wed, 14 Oct 2009 01:00:38 -0400
Message-ID: <20091014050038.GB31810@coredump.intra.peff.net>
References: <cover.1255380039.git.trast@student.ethz.ch>
 <77e591b80021efc265fea1a101ce6b7124ea832e.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:04:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxw2Q-0003iP-Kp
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbZJNFBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbZJNFBP
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:01:15 -0400
Received: from peff.net ([208.65.91.99]:56517 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169AbZJNFBO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:01:14 -0400
Received: (qmail 24495 invoked by uid 107); 14 Oct 2009 05:04:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 01:04:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 01:00:38 -0400
Content-Disposition: inline
In-Reply-To: <77e591b80021efc265fea1a101ce6b7124ea832e.1255380039.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130245>

On Mon, Oct 12, 2009 at 11:06:05PM +0200, Thomas Rast wrote:

>  list_stash () {
>  	have_stash || return 0
> -	git log --no-color --pretty=oneline -g "$@" $ref_stash -- |
> -	sed -n -e 's/^[.0-9a-f]* refs\///p'
> +	git log --format="%g: %G" -g "$@" $ref_stash

You dropped the trailing "--" which is needed for disambiguation.

-Peff
