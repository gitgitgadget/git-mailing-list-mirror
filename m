From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: fix off-by-one in append_option
Date: Wed, 18 Apr 2012 14:07:40 -0700
Message-ID: <20120418210740.GA21214@sigill.intra.peff.net>
References: <20120417233255.GA24626@sigill.intra.peff.net>
 <20120418191849.GA12619@sigill.intra.peff.net>
 <7vd374ltqh.fsf@alter.siamese.dyndns.org>
 <20120418202116.GA12964@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:08:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKc6q-0003Dp-N8
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 23:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab2DRVIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 17:08:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37997
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab2DRVHp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 17:07:45 -0400
Received: (qmail 20669 invoked by uid 107); 18 Apr 2012 21:07:53 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Apr 2012 17:07:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Apr 2012 14:07:40 -0700
Content-Disposition: inline
In-Reply-To: <20120418202116.GA12964@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195902>

On Wed, Apr 18, 2012 at 01:21:16PM -0700, Jeff King wrote:

> > I am perfectly OK with even without initializers, like this:
> > 
> > 	struct argv_array repack = ARGV_ARRAY_INIT;
> > 	argv_array_push_strings(&repack, "repack", "-d", "-l", NULL);
> 
> I think that is sane, and certainly the simplest. I'll send a patch in a
> moment.

Here it is. This goes directly on top of 7e52f56 (the tip of
jk/repack-no-explode-objects-from-old-pack). The off-by-one fix I sent
earlier can be dropped, as that code is removed by the final patch
below.

  [1/3]: argv-array: refactor empty_argv initialization
  [2/3]: argv-array: add a new "pushl" method
  [3/3]: gc: use argv-array for sub-commands

-Peff
