From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] http: use curl's tcp keepalive if available
Date: Tue, 15 Oct 2013 06:03:22 +0000
Message-ID: <20131015060322.GA10714@dcvr.yhbt.net>
References: <20131012222939.GA24255@dcvr.yhbt.net>
 <alpine.DEB.2.00.1310131142080.22193@tvnag.unkk.fr>
 <20131014052739.GA16129@dcvr.yhbt.net>
 <20131014214035.GB7007@sigill.intra.peff.net>
 <20131014233839.GA26323@dcvr.yhbt.net>
 <20131015000614.GA10905@sigill.intra.peff.net>
 <20131015045814.GA12312@dcvr.yhbt.net>
 <20131015050028.GA8150@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 08:03:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVxj5-0004eV-9h
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 08:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467Ab3JOGDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 02:03:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34546 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336Ab3JOGDW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 02:03:22 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6969844C004;
	Tue, 15 Oct 2013 06:03:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131015050028.GA8150@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236167>

Jeff King <peff@peff.net> wrote:
> I am more concerned with Windows, which may not compile your original
> patch at all.

The code I introduced in e47a8583a20256851e7fc882233e3bd5bf33dc6e
("enable SO_KEEPALIVE for connected TCP sockets" Dec 2011)
didn't trigger the addition of any new #ifdef guards.  I think we're
fine (but I'll let others confirm it).
