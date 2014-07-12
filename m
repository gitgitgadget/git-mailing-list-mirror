From: Jeff King <peff@peff.net>
Subject: Re: Error running 'git status' with Git version of current 'next'
 branch
Date: Sat, 12 Jul 2014 00:59:03 -0400
Message-ID: <20140712045902.GB20675@sigill.intra.peff.net>
References: <CAN0XMOKmbQ_adDjUH3+o-RRm0pcQpH=fH9zDTe4=+b_aU_0GoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 06:59:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5pP1-000493-Q3
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 06:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbaGLE7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 00:59:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:60620 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbaGLE7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 00:59:05 -0400
Received: (qmail 20818 invoked by uid 102); 12 Jul 2014 04:59:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 23:59:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jul 2014 00:59:03 -0400
Content-Disposition: inline
In-Reply-To: <CAN0XMOKmbQ_adDjUH3+o-RRm0pcQpH=fH9zDTe4=+b_aU_0GoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253382>

On Wed, Jul 09, 2014 at 09:10:49AM +0200, Ralf Thielow wrote:

> I'm getting the following error when calling 'git status' on one of
> my projects.
> 
> git: dir.c:739: last_exclude_matching_from_list: Assertion `x->baselen
> == 0 || x->base[x->baselen - 1] == '/'' failed.
> Aborted (core dumped)
> 
> I'm using the current 'next', git version 2.0.1.664.g35b839c
> I have bisected it to commit d3ccb7d (dir: remove PATH_MAX limitation).

Thanks for bisecting. That commit has been reverted from next in favor
of a nicer refactoring, though, so I don't think it's worth tracking
down the bug in d3ccb7d.

-Peff
