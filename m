From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make tests independent of global config files
Date: Wed, 6 Feb 2008 04:04:53 -0500
Message-ID: <20080206090453.GA6762@coredump.intra.peff.net>
References: <20080206083817.GA19710@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgE0-0003XG-1G
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759514AbYBFJE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759513AbYBFJE6
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:04:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1405 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759468AbYBFJE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:04:56 -0500
Received: (qmail 27241 invoked by uid 111); 6 Feb 2008 09:04:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 06 Feb 2008 04:04:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 04:04:53 -0500
Content-Disposition: inline
In-Reply-To: <20080206083817.GA19710@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72774>

On Wed, Feb 06, 2008 at 03:38:17AM -0500, Jeff King wrote:

> So I think we are stuck adding in some environment magic to suppress the
> reading of ETC_GITCONFIG, and doing something like:
> 
> unset GIT_CONFIG
> GIT_ETC_CONFIG=$(pwd)/.git/nonexistant
> GIT_LOCAL_CONFIG=$(pwd)/.git/nonexistant

Actually, we don't need to suppress GIT_LOCAL_CONFIG in the same way; we
just need to make sure it isn't set. But we do need to set HOME to avoid
that lookup. Patch series will follow.

-Peff
