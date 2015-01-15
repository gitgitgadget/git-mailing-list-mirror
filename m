From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] http.c: make finish_active_slot() and
 handle_curl_result() static
Date: Thu, 15 Jan 2015 01:41:13 -0500
Message-ID: <20150115064113.GB11028@peff.net>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
 <1421278855-8126-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 07:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBe7M-0000DH-Om
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 07:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbbAOGlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 01:41:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:34804 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751079AbbAOGlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 01:41:16 -0500
Received: (qmail 19826 invoked by uid 102); 15 Jan 2015 06:41:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 00:41:16 -0600
Received: (qmail 10370 invoked by uid 107); 15 Jan 2015 06:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 01:41:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 01:41:13 -0500
Content-Disposition: inline
In-Reply-To: <1421278855-8126-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262459>

On Wed, Jan 14, 2015 at 03:40:46PM -0800, Junio C Hamano wrote:

> No external callers exist.

I think this is sensible. They used to be used directly by remote-curl.c
for the smart-http protocol. But they got wrapped by run_one_slot in
beed336 (http: never use curl_easy_perform, 2014-02-18). And I'd expect
any future users to follow that route.

-Peff
