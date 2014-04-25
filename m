From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] git tag --contains: avoid stack overflow
Date: Fri, 25 Apr 2014 01:54:28 -0400
Message-ID: <20140425055428.GA25337@sigill.intra.peff.net>
References: <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
 <20140417215817.GA822@sigill.intra.peff.net>
 <20140423075325.GA7268@camelia.ucw.cz>
 <xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
 <20140423191628.GA20596@sigill.intra.peff.net>
 <xmqqk3afydq2.fsf@gitster.dls.corp.google.com>
 <20140423205533.GA20582@sigill.intra.peff.net>
 <xmqqfvl3ycwk.fsf@gitster.dls.corp.google.com>
 <20140424122029.GA8168@camelia.ucw.cz>
 <20140424122439.GB8168@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 25 07:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdZ5q-000558-7D
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 07:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbaDYFyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 01:54:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:38106 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750781AbaDYFya (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 01:54:30 -0400
Received: (qmail 7687 invoked by uid 102); 25 Apr 2014 05:54:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Apr 2014 00:54:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Apr 2014 01:54:28 -0400
Content-Disposition: inline
In-Reply-To: <20140424122439.GB8168@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247032>

On Thu, Apr 24, 2014 at 02:24:39PM +0200, Stepan Kasal wrote:

> From: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
> 
> In large repos, the recursion implementation of contains(commit,
> commit_list) may result in a stack overflow. Replace the recursion with
> a loop to fix it.
> 
> This problem is more apparent on Windows than on Linux, where the stack
> is more limited by default.
> 
> See also this thread on the msysGit list:
> 
> 	https://groups.google.com/d/topic/msysgit/FqT6boJrb2g/discussion
> 
> [jes: re-written to imitate the original recursion more closely]
> 
> Thomas Braun pointed out several documentation shortcomings.
> 
> Tests are run only if ulimit -s is available.  This means they cannot
> be run on Windows.
> 
> Signed-off-by: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Tested-by: Stepan Kasal <kasal@ucw.cz>

Thanks, this version looks good to me.

-Peff
