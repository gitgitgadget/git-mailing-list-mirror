From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/22] lock_file(): always add lock_file object to
 lock_file_list
Date: Mon, 7 Apr 2014 05:36:50 -0400
Message-ID: <20140407093650.GA4252@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-8-git-send-email-mhagger@alum.mit.edu>
 <20140401201659.GE21715@sigill.intra.peff.net>
 <5341CD33.3000205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 11:36:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX5z7-0006F2-Ho
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 11:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbaDGJgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 05:36:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:55242 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755032AbaDGJgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 05:36:52 -0400
Received: (qmail 12861 invoked by uid 102); 7 Apr 2014 09:36:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Apr 2014 04:36:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Apr 2014 05:36:50 -0400
Content-Disposition: inline
In-Reply-To: <5341CD33.3000205@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245828>

On Sun, Apr 06, 2014 at 11:54:59PM +0200, Michael Haggerty wrote:

> > I didn't reproduce it experimentally, though.  We should be able to just
> > 
> >     lk->owner = 0;
> > 
> > before the initial strcpy to fix it, I would think.
> 
> I think that using the owner field to avoid this problem is a bit
> indirect, so I will soon submit a fix that involves adding a flag to
> lock_file objects indicating whether the filename field currently
> contains the name of a file that needs to be deleted.

Yeah, I agree that the current code is a bit subtle. I was planning to
address this during the tempfile cleanup project (either in GSoC, if it
gets a slot, or just doing it myself). But I don't mind if you want to
do something in the interim.

-Peff
