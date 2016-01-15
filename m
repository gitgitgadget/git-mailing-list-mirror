From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 18/21] column: read lines with strbuf_getline()
Date: Fri, 15 Jan 2016 15:43:25 -0500
Message-ID: <20160115204325.GH11301@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-19-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:43:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKBDY-0001sC-FB
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbcAOUn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:43:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:54664 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751246AbcAOUn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:43:28 -0500
Received: (qmail 11288 invoked by uid 102); 15 Jan 2016 20:43:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:43:28 -0500
Received: (qmail 23743 invoked by uid 107); 15 Jan 2016 20:43:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:43:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 15:43:25 -0500
Content-Disposition: inline
In-Reply-To: <1452815916-6447-19-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284215>

On Thu, Jan 14, 2016 at 03:58:33PM -0800, Junio C Hamano wrote:

> Multiple lines read here are concatenated on a single line to form a
> multi-column output line.  We do not want to have a CR at the end,
> even if the input file consists of CRLF terminated lines.

Hrm. I suspect this is OK in practice, though "git column" can
technically receive unbounded input from the user. We don't specify in
the documentation that it must be text, but I guess it's somewhat
implied by the use of the word "line".

-Peff
