From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] attr.c::path_matches(): the basename is part of the
 pathname
Date: Tue, 26 Mar 2013 14:49:22 -0400
Message-ID: <20130326184921.GA26462@sigill.intra.peff.net>
References: <20130323083927.GA25600@sigill.intra.peff.net>
 <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <1364323171-20299-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 19:49:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKYwV-0006Pc-7b
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 19:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760144Ab3CZSt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 14:49:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40519 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab3CZSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 14:49:26 -0400
Received: (qmail 6223 invoked by uid 107); 26 Mar 2013 18:51:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 14:51:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 14:49:22 -0400
Content-Disposition: inline
In-Reply-To: <1364323171-20299-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219182>

On Tue, Mar 26, 2013 at 11:39:28AM -0700, Junio C Hamano wrote:

> The function takes two strings (pathname and basename) as if they
> are independent strings, but in reality, the latter is always
> pointing into a substring in the former.
> 
> Clarify this relationship by expressing the latter as an offset into
> the former.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This is a huge improvement in maintainability. My initial fix attempt
was to just xstrdup() the strings (knowing that the performance would be
horrible, but I was still investigating correctness issues at that
point). And of course I ran into this same issue as I tried to make a
copy of pathname.

So even without the rest of the fix, this is definitely a good idea. :)

-Peff
