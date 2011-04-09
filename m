From: Jeff King <peff@peff.net>
Subject: Re: [tig PATCH] blame broken in recent master
Date: Sat, 9 Apr 2011 15:00:18 -0400
Message-ID: <20110409190018.GA31579@sigill.intra.peff.net>
References: <20110330142430.GA32523@sigill.intra.peff.net>
 <BANLkTinJm4Zp18D_M=TTLSDr6jBLcPB9RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Apr 09 21:00:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8dOX-000315-Oc
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 21:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357Ab1DITAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 15:00:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46592
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106Ab1DITAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 15:00:24 -0400
Received: (qmail 15760 invoked by uid 107); 9 Apr 2011 19:01:12 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.197.88.253)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 09 Apr 2011 15:01:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2011 15:00:19 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinJm4Zp18D_M=TTLSDr6jBLcPB9RQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171202>

On Sat, Apr 09, 2011 at 02:37:38PM -0400, Jonas Fonseca wrote:

> On Wed, Mar 30, 2011 at 10:24, Jeff King <peff@peff.net> wrote:
> 
> > As of 730ae86 (Rename prepare_io to prepare_update and make it more
> > specialized, 2011-03-16), "tig blame" finds no actual blamed commits.
> >
> > The problem seems to be that prepare_update switched from calling
> > format_argv to argv_copy, and we end up calling "git blame %(blameargs)"
> > without "%(blameargs)" expanded. Blame looks like the only caller which
> > actually uses a placeholder, so it is the only one broken.
> >
> > The patch below fixes it for me, but it seems like a hack. I'm not
> > really sure why the switch in prepare_update was made; clearly it is
> > part of some refactoring, but I'm not sure what your larger plans were.
> 
> I have fixed the issue in the current master.

Thanks, works perfectly here.

-Peff
