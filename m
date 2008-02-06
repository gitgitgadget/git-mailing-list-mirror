From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Wed, 6 Feb 2008 06:01:32 -0500
Message-ID: <20080206110131.GA4167@coredump.intra.peff.net>
References: <20080206102608.GA1007@coredump.intra.peff.net> <47A98F07.4000402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 12:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMi2Z-00075O-D4
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 12:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761297AbYBFLBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 06:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761072AbYBFLBf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 06:01:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2861 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760666AbYBFLBf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 06:01:35 -0500
Received: (qmail 28203 invoked by uid 111); 6 Feb 2008 11:01:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 06 Feb 2008 06:01:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 06:01:32 -0500
Content-Disposition: inline
In-Reply-To: <47A98F07.4000402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72798>

On Wed, Feb 06, 2008 at 11:42:15AM +0100, Johannes Sixt wrote:

> > The special value is a blank GIT_WORK_TREE; it could be any
> > value, but this should not conflict with any user values
> > (and as a bonus, you can now tell git "I don't have a work
> > tree" with "GIT_WORK_TREE= git", though I suspect the use
> > case for that is limited).
> 
> Hrm. Unfortunately, on Windows there is no such thing as an empty
> environment string. setenv(x, "") *removes* the environment variable.

Bleh. Maybe "GIT_WORK_TREE=:"? It doesn't make sense by itself since we
don't try to execute the contents of GIT_WORK_TREE, but it's unlikely to
be used by a user, and I believe there was recent talk of making
"GIT_EDITOR=:" work.

The other option is setting

  GIT_MAGICALLY_SET_GIT_DIR_SO_DONT_ACT_LIKE_THE_USER_DID=1

but I was hoping to avoid that.

-Peff
