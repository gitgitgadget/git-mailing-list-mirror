From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] fixes for sanitized submodule config
Date: Thu, 28 Apr 2016 09:35:34 -0400
Message-ID: <20160428133534.GA19056@sigill.intra.peff.net>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
 <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
 <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
 <20160425212449.GA7636@sigill.intra.peff.net>
 <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com>
 <20160428112511.GA11522@sigill.intra.peff.net>
 <20160428120504.GA22399@sigill.intra.peff.net>
 <20160428121753.GA5023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:35:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avm6Y-00047W-HZ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcD1Nfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:35:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:58279 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751865AbcD1Nfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:35:38 -0400
Received: (qmail 25478 invoked by uid 102); 28 Apr 2016 13:35:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:35:36 -0400
Received: (qmail 9528 invoked by uid 107); 28 Apr 2016 13:35:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:35:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 09:35:34 -0400
Content-Disposition: inline
In-Reply-To: <20160428121753.GA5023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292875>

On Thu, Apr 28, 2016 at 08:17:53AM -0400, Jeff King wrote:

> So that case _is_ correct right now. It's just that t5550 isn't testing
> the shell script part, which is broken. Probably running "git submodule
> update" in the resulting clone would cover that.
> 
> And for the fetch case, we probably just need to be calling
> prepare_submodule_repo_env() there, too.

So here's a series which fixes sanitizing in the "git-submodule" shell
script, along with "git fetch". And cleans up a few things along the
way.

  [1/5]: t5550: fix typo in $HTTPD_URL
  [2/5]: t5550: break submodule config test into multiple sub-tests
  [3/5]: submodule: export sanitize GIT_CONFIG_PARAMETERS
  [4/5]: submodule--helper: move config-sanitizing to submodule.c
  [5/5]: submodule: use prepare_submodule_repo_env consistently

-Peff
