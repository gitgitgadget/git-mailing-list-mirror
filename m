From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 4/4] config: add '--show-origin' option to print the
 origin of a config value
Date: Mon, 22 Feb 2016 12:58:43 -0500
Message-ID: <20160222175843.GA4587@sigill.intra.peff.net>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
 <1455873362-66998-5-git-send-email-larsxschneider@gmail.com>
 <xmqq4md08wua.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 18:58:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXul2-0001X5-RR
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 18:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbcBVR6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 12:58:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:46845 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753817AbcBVR6q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 12:58:46 -0500
Received: (qmail 9106 invoked by uid 102); 22 Feb 2016 17:58:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 12:58:46 -0500
Received: (qmail 20349 invoked by uid 107); 22 Feb 2016 17:58:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 12:58:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 12:58:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4md08wua.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286937>

On Mon, Feb 22, 2016 at 09:43:25AM -0800, Junio C Hamano wrote:

> larsxschneider@gmail.com writes:
> 
> > +test_expect_success '--show-origin with --list' '
> > +	cat >expect <<-EOF &&
> > +		file:$HOME/.gitconfig	user.global=true
> > +		file:$HOME/.gitconfig	user.override=global
> > +		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
> > +		file:$INCLUDE_DIR/absolute.include	user.absolute=include
> > +		file:.git/config	user.local=true
> > +		file:.git/config	user.override=local
> > +		file:.git/config	include.path=../include/relative.include
> > +		file:.git/../include/relative.include	user.relative=include
> > +		cmdline:	user.cmdline=true
> > +	EOF
> > ...
> > +test_expect_success '--show-origin stdin' '
> > +	cat >expect <<-\EOF &&
> > +		stdin:	user.custom=true
> > +	EOF
> 
> I do recall there was some bikeshedding^Wdesigning discussion, in
> which I chose not to participate, on the output format, how
> origin-type and origin-value are given in the output in an
> unambiguous way that is easy to understand by the end users.
> 
> Does the above reflect the concensus from the discussion?  Just
> double checking.

Yes, I think so.

-Peff
