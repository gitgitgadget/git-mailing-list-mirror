From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] check-ignore: move setup into cmd_check_ignore()
Date: Thu, 11 Apr 2013 14:35:18 -0400
Message-ID: <20130411183518.GB3177@sigill.intra.peff.net>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
 <20130411052553.GA28915@sigill.intra.peff.net>
 <20130411110511.GB24296@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMLK-00044g-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab3DKSf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 14:35:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40795 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab3DKSf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:35:26 -0400
Received: (qmail 17958 invoked by uid 107); 11 Apr 2013 18:37:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 14:37:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 14:35:18 -0400
Content-Disposition: inline
In-Reply-To: <20130411110511.GB24296@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220908>

On Thu, Apr 11, 2013 at 12:05:11PM +0100, Adam Spiers wrote:

> On Thu, Apr 11, 2013 at 01:25:53AM -0400, Jeff King wrote:
> > On Thu, Apr 11, 2013 at 02:59:31AM +0100, Adam Spiers wrote:
> > > -static int check_ignore(const char *prefix, const char **pathspec)
> > > +static int check_ignore(struct path_exclude_check check,
> > > +			const char *prefix, const char **pathspec)
> > 
> > Did you mean to pass the struct by value here? If it is truly a per-path
> > [...]
>
> It's not a per-path value; it's supposed to be reused across checks
> for multiple paths, as explained in the comments above
> last_exclude_matching_path():

Makes sense (I didn't look into it very far, and was just guessing based
on the pass-by-value). Passing a pointer is definitely the right fix,
then.

Thanks.

-Peff
