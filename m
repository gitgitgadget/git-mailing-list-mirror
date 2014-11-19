From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] error cleanups in lock_ref_sha1_basic
Date: Tue, 18 Nov 2014 20:35:32 -0500
Message-ID: <20141119013532.GA861@peff.net>
References: <CAGZ79kbH=pqSizhUeuiCeYXZWk015K49Pj0F5pPvkOTqg4PMuQ@mail.gmail.com>
 <1416359597-15481-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sahlberg@google.com, jrnieder@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:35:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquBH-0000uN-EF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbaKSBff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:35:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:42044 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752917AbaKSBff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:35:35 -0500
Received: (qmail 9603 invoked by uid 102); 19 Nov 2014 01:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 19:35:34 -0600
Received: (qmail 25364 invoked by uid 107); 19 Nov 2014 01:35:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 20:35:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 20:35:32 -0500
Content-Disposition: inline
In-Reply-To: <1416359597-15481-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 05:13:17PM -0800, Stefan Beller wrote:

> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Change lock_ref_sha1_basic to return an error instead of dying,
> when we fail to lock a file during a transaction. This function is
> only called from transaction_commit() and it knows how to handle
> these failures.
> 
> [sb: This was part of a larger patch series, cherry-picked to master]
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>

I think this is a good thing to do. I independently wrote the same patch
recently, along with some other cleanups. Here's the series I ended up
with (I added Ronnie as the author of the final one, which replaces
this; even though my discovery was independent, he wrote it first :) ).

  [1/4]: error: save and restore errno
  [2/4]: lock_ref_sha1_basic: simplify errno handling
  [3/4]: lock_ref_sha1_basic: simplify error code path
  [4/4]: lock_ref_sha1_basic: do not die on locking errors

-Peff
