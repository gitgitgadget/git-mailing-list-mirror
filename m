From: Jeff King <peff@peff.net>
Subject: Re: Git GSoC 2014
Date: Fri, 14 Feb 2014 05:41:39 -0500
Message-ID: <20140214104139.GA28570@sigill.intra.peff.net>
References: <20140213091037.GA28927@sigill.intra.peff.net>
 <CALkWK0mR=9ZD256bHx9d=W9ayqn5bOETWBQLW_kvRSy-GeQK4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>,
	Thomas Rast <tr@thomasrast.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 11:42:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEGDV-0002jH-PK
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 11:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbaBNKlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 05:41:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:50457 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751959AbaBNKlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 05:41:49 -0500
Received: (qmail 25842 invoked by uid 102); 14 Feb 2014 10:41:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Feb 2014 04:41:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Feb 2014 05:41:39 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0mR=9ZD256bHx9d=W9ayqn5bOETWBQLW_kvRSy-GeQK4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242095>

On Thu, Feb 13, 2014 at 06:17:17PM -0500, Ramkumar Ramachandra wrote:

> I'll throw in a few ideas from half-finished work.

Thanks. A few comments:

> 1. Speed up git-rebase--am.sh
> 
> Currently, git-rebase--am.sh is really slow because it dumps each
> patch to a file using git-format-patch, and picks it up to apply
> subsequently using git-am. Find a way to speed this up, without
> sacrificing safety. You can use the continuation features of
> cherry-pick, and dump to file only to persist state in the case of a
> failure.

Isn't the merge backend faster? I thought that was the point of it.

> 3. Rewrite git-branch to use git-for-each-ref
> 
> For higher flexibility in command-line options and output format, use
> git for-each-ref to re-implement git-branch. The first task is to grow
> features that are in branch but not fer into fer (like --column,
> --merged, --contains). The second task is to refactor fer so that an
> external program can call into it.

I actually have this about 95% done, waiting for the patches to be
polished. So I don't think it makes a good GSoC project (it would be
stupid to start from scratch, and polishing my patches is a lame
project).

> 4. Implement @{publish}
> (I just can't find the time to finish this)
> 
> @{publish} is a feature like @{upstream}, showing the state of the
> publish-point in the case of triangular workflows. Implement this
> while sharing code with git-push, and polish it until the prompt shows
> publish-state.

I think this could be a good GSoC-sized topic. I'm going to adjust the
title to be "better support for triangular workflows". I think they may
want to examine other issues in the area, rather than drilling down on
@{publish} in particular (but ultimately, it is up to the student to
propose what they want to do).

-Peff
