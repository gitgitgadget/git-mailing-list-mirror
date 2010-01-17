From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in
 summary
Date: Sun, 17 Jan 2010 11:18:30 -0500
Message-ID: <20100117161830.GA7153@sigill.intra.peff.net>
References: <20100113173408.GA16652@coredump.intra.peff.net>
 <20100113173951.GC16786@coredump.intra.peff.net>
 <7vhbql85ti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 17:18:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWXpv-0003lO-8W
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 17:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab0AQQSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 11:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240Ab0AQQSd
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 11:18:33 -0500
Received: from peff.net ([208.65.91.99]:38157 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265Ab0AQQSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 11:18:33 -0500
Received: (qmail 25725 invoked by uid 107); 17 Jan 2010 16:23:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 17 Jan 2010 11:23:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2010 11:18:30 -0500
Content-Disposition: inline
In-Reply-To: <7vhbql85ti.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137303>

On Sun, Jan 17, 2010 at 12:59:53AM -0800, Junio C Hamano wrote:

> > @@ -1085,7 +1118,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
> >  		struct pretty_print_context ctx = {0};
> >  		struct strbuf buf = STRBUF_INIT;
> >  		ctx.date_mode = DATE_NORMAL;
> > -		format_commit_message(commit, format + 7, &buf, &ctx);
> > +		format_commit_message(commit, format.buf + 7, &buf, &ctx);
> >  		printf("%s\n", buf.buf);
> 
> But sometimes log_tree_commit() doesn't show the header.  Most notably for
> merges.  What string are we using for format_commit_message()?  Oops.

Ugh. Thank you and good catch.

-Peff
