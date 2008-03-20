From: Jeff King <peff@peff.net>
Subject: Re: Two bugs with renaming
Date: Wed, 19 Mar 2008 20:56:33 -0400
Message-ID: <20080320005633.GA22736@coredump.intra.peff.net>
References: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:57:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc95x-00057G-56
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760035AbYCTA4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 20:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbYCTA4i
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:56:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1362 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760035AbYCTA4g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:56:36 -0400
Received: (qmail 8693 invoked by uid 111); 20 Mar 2008 00:56:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 19 Mar 2008 20:56:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Mar 2008 20:56:33 -0400
Content-Disposition: inline
In-Reply-To: <slrnfu37vn.d2i.jgoerzen@katherina.lan.complete.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77608>

On Wed, Mar 19, 2008 at 06:21:27PM -0500, John Goerzen wrote:

> Bug #1 causes git to refuse to change to a different branch, claiming
> that uncommitted changes exist, even when git status says there are none.
> [...]
> Tested with Git 1.5.4.4.

I tried to reproduce this with current 'master', and it seems to be
magically fixed. There has been some work on unpack-trees lately, so it
might be a fallout from that.

> Bug #2 causes git to refuse to merge unrelated changes.
> [...]
> lrwxrwxrwx 1 jgoerzen jgoerzen 16 Mar 19 18:14 files -> /tmp/nonexistant
> drwxr-xr-x 2 jgoerzen jgoerzen 22 Mar 19 18:14 files.upstream
> jgoerzen@katherina:/tmp/testrepo$ git merge master
> fatal: Entry 'files/delete.me' would be overwritten by merge. Cannot merge.
> Merge with strategy recursive failed.

Hrm, that should work, I think. I haven't kept up with the recent
changes, so I'll have to take some time to investigate.

-Peff
