From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] index-helper: fix UNIX_PATH_MAX redefinition error
 on cygwin
Date: Mon, 11 Apr 2016 09:33:44 -0400
Message-ID: <20160411133343.GA7492@sigill.intra.peff.net>
References: <570ADA5B.5030408@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 15:34:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apbyq-0008VQ-3U
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 15:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbcDKNdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 09:33:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:47414 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932782AbcDKNds (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 09:33:48 -0400
Received: (qmail 29387 invoked by uid 102); 11 Apr 2016 13:33:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 09:33:47 -0400
Received: (qmail 25175 invoked by uid 107); 11 Apr 2016 13:33:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Apr 2016 09:33:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Apr 2016 09:33:44 -0400
Content-Disposition: inline
In-Reply-To: <570ADA5B.5030408@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291214>

On Sun, Apr 10, 2016 at 11:57:31PM +0100, Ramsay Jones wrote:

> So, the approach taken by patch #1 is to forget about UNIX_PATH_MAX and
> simply use sizeof(address.sun_path) instead!

That's what the existing code in unix-socket.c does. Which makes me
wonder why the index-helper code is not simply calling that.

-Peff
