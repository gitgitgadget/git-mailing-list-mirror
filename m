From: Jeff King <peff@peff.net>
Subject: Re: filter-branch vs. <rev-list options>
Date: Thu, 1 Mar 2012 20:00:19 -0500
Message-ID: <20120302010019.GD21835@sigill.intra.peff.net>
References: <4F50089B.1090202@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 02:00:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3GrE-000484-CI
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 02:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757750Ab2CBBAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 20:00:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34778
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab2CBBAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 20:00:22 -0500
Received: (qmail 11677 invoked by uid 107); 2 Mar 2012 01:00:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Mar 2012 20:00:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2012 20:00:19 -0500
Content-Disposition: inline
In-Reply-To: <4F50089B.1090202@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191992>

On Thu, Mar 01, 2012 at 06:39:07PM -0500, Phil Hord wrote:

> git-filter-branch seems to be parsing its own switches and not
> recognizing when they run out and the rest are "rev-list" options. 
> 
> Is there a way to force this break, or should I just expect to have to
> rewrite the logic so that there's always a non-switch argument at the
> start of the rev-list section?  Or am I just doing this wrong?
> 
> fwiw - I'm actually wanting to do this in a script:
>     git filter-branch --msg-filter cat --not --remotes --not "$@"

Did you try "--":

  git filter-branch --msg-filter cat -- --not --remotes --not "$@"

?
