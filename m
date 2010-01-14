From: Jeff King <peff@peff.net>
Subject: Re: Removal of post-upload-hook
Date: Thu, 14 Jan 2010 14:36:07 -0500
Message-ID: <20100114193607.GB25863@coredump.intra.peff.net>
References: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Arun Raghavan <ford_prefect@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:36:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVVUP-0007jz-DJ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 20:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329Ab0ANTgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 14:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331Ab0ANTgL
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 14:36:11 -0500
Received: from peff.net ([208.65.91.99]:41929 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932337Ab0ANTgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 14:36:11 -0500
Received: (qmail 13056 invoked by uid 107); 14 Jan 2010 19:41:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 Jan 2010 14:41:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2010 14:36:07 -0500
Content-Disposition: inline
In-Reply-To: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137013>

On Thu, Jan 14, 2010 at 11:31:57PM +0530, Arun Raghavan wrote:

> [I'm not on the list, so please CC me on replies]
> 
> Hello,
> I noticed that the post-upload hook had been removed in commit
> 1456b043fc0f0a395c35d6b5e55b0dad1b6e7acc. The commit message states:
> 
>     This hook runs after "git fetch" in the repository the objects are
>     fetched from as the user who fetched, and has security implications.
> 
> I was wondering if someone could shed some light (or links) on what
> security implications this hook has?

Because receive-pack runs as the user who is pushing, not as the
repository owner. So by convincing you to push to my repository in a
multi-user environment, I convince you to run some arbitrary code of
mine.

-Peff
