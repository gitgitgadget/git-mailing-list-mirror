From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] help.c: strip suffix only if the STRIP_EXTENSION defined
Date: Wed, 16 Mar 2016 13:39:41 -0400
Message-ID: <20160316173941.GA9142@sigill.intra.peff.net>
References: <1458138449-26690-1-git-send-email-kuleshovmail@gmail.com>
 <20160316173127.GD4039@sigill.intra.peff.net>
 <CANCZXo6KGtuuiZ3aha=Tqkwj3d8qytmA_rvw7fPHfevzz9Qyfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:40:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFQL-0002M2-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbcCPRjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:39:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:60728 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751498AbcCPRjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:39:44 -0400
Received: (qmail 8940 invoked by uid 102); 16 Mar 2016 17:39:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 13:39:44 -0400
Received: (qmail 16115 invoked by uid 107); 16 Mar 2016 17:40:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 13:40:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 13:39:41 -0400
Content-Disposition: inline
In-Reply-To: <CANCZXo6KGtuuiZ3aha=Tqkwj3d8qytmA_rvw7fPHfevzz9Qyfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289005>

On Wed, Mar 16, 2016 at 11:36:49PM +0600, Alexander Kuleshov wrote:

> > I also wonder if this should be sharing the strip_extension() helper
> > added in your 63ca1c0.
> 
> Yes, I want to move strip_extension() (from 63ca1c0) to the git-compat-util.h
> and adapt/reuse it in the help.c. What do you think about this?

Naively, it sounds like a good idea to me, but I haven't looked too
hard. There may be complications in the interface (it looks like the
helper wants to make a new string, but one in help.c makes its own copy
into the flex-array struct).

-Peff
