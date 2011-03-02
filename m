From: Jeff King <peff@peff.net>
Subject: Re: In-depth git blame?
Date: Wed, 2 Mar 2011 16:15:45 -0500
Message-ID: <20110302211545.GD20400@sigill.intra.peff.net>
References: <AANLkTi=694NiUMzcHkNZ09sotcoN+=wPMnxnom5_ex+f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org
To: Jez <jezreel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 22:15:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PutOn-0006K0-9r
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 22:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584Ab1CBVPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 16:15:51 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44232 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757460Ab1CBVPu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 16:15:50 -0500
Received: (qmail 20477 invoked by uid 111); 2 Mar 2011 21:15:47 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 21:15:47 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 16:15:45 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=694NiUMzcHkNZ09sotcoN+=wPMnxnom5_ex+f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168343>

On Wed, Mar 02, 2011 at 03:43:42PM -0500, Jez wrote:

> Git-blame is useful, but sometimes I want to know the series of
> commits that have affected a line -- not just the most recent one. Is
> there a way to do this?

If you use "git gui blame" or "tig blame", both have a "blame from
parent commit" feature. This restarts the blame using the content as it
was just before the answer you just got, so you can recursively dig.
It's unfortunately a somewhat manual process.

There was a GSoC project to do what you asked, where you would indicate
a set of lines and get a "git log"-like output of all the commits
touching those lines. But there were some issues with the code, and it
never quite made it upstream, I think. I'm not sure what the current
status is. Cc'ing Thomas and Bo, who worked on it.

-Peff
