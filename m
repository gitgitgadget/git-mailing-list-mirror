From: Jeff King <peff@peff.net>
Subject: Re: Overriding ~/.gitconfig using GIT_CONFIG
Date: Tue, 30 Aug 2011 11:56:49 -0400
Message-ID: <20110830155649.GA15790@sigill.intra.peff.net>
References: <1313163498.14274.505.camel@rex>
 <7vr54qmodf.fsf@alter.siamese.dyndns.org>
 <7vmxfemnc4.fsf@alter.siamese.dyndns.org>
 <1313181853.14274.535.camel@rex>
 <20110828130555.GA56765@gmail.com>
 <1314620166.5939.282.camel@rex>
 <20110830031022.GA64106@gmail.com>
 <1314706381.5939.348.camel@rex>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nguy?? n =?utf-8?B?VGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Richard Purdie <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 17:56:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyQgM-0005xz-Me
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 17:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab1H3P4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 11:56:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54179
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397Ab1H3P4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 11:56:53 -0400
Received: (qmail 27349 invoked by uid 107); 30 Aug 2011 15:57:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Aug 2011 11:57:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2011 11:56:49 -0400
Content-Disposition: inline
In-Reply-To: <1314706381.5939.348.camel@rex>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180414>

On Tue, Aug 30, 2011 at 01:13:01PM +0100, Richard Purdie wrote:

> We've gone through several iterations of this but as things stand now,
> to initially clone things we're doing:
> 
> git clone --bare --mirror <url> <dir>
> 
> but if we already have some existing clone we'd update with:
> 
> git remote prune origin
> git remote rm origin
> git remote add --mirror origin <url>
> git fetch --all -t
>
> [...]
>
> So if a user has an origin remote in their .gitconfig, can we ignore it?

Wouldn't:

  git fetch --prune <url> refs/heads/*:refs/remotes/origin/*

do what you want, and not look at config at all?

-Peff
