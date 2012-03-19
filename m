From: Jeff King <peff@peff.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 18 Mar 2012 22:45:51 -0400
Message-ID: <20120319024551.GC10426@sigill.intra.peff.net>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <201203182307.43599.jnareb@gmail.com>
 <20120319023231.GA10426@sigill.intra.peff.net>
 <CACsJy8DsuQNEwLb_vSPTN_Zrh6o9OK3V_R3xZDMQsFCaOafUXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Ivan Todoroski <grnch_lists@gmx.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:46:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9Sbe-0007aq-BQ
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 03:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871Ab2CSCpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 22:45:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51959
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964825Ab2CSCpx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 22:45:53 -0400
Received: (qmail 26636 invoked by uid 107); 19 Mar 2012 02:46:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Mar 2012 22:46:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Mar 2012 22:45:51 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DsuQNEwLb_vSPTN_Zrh6o9OK3V_R3xZDMQsFCaOafUXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193413>

On Mon, Mar 19, 2012 at 09:43:05AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Mon, Mar 19, 2012 at 9:32 AM, Jeff King <peff@peff.net> wrote:
> > However, I think you would need to teach the run-command API how to open
> > extra pipes to a child beyond stdout/stdin/stderr.
> 
> That might be a problem on Windows. I think Windows exec* has special
> support for stdin/stdout/stderr and only those.

Then your sneak-it-across-stdin trick is probably the best bet. It's a
little ugly, but this is for stateless-rpc, so it's not like anything
outside of git is going to actually see this.

-Peff
