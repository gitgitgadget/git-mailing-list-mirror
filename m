From: Jeff King <peff@peff.net>
Subject: Re: [RFC] ident: support per-path configs by matching the path
 against a pattern
Date: Fri, 10 Jul 2015 16:58:21 -0400
Message-ID: <20150710205821.GB1181@peff.net>
References: <0000014e7752e758-a0bf7acb-2d0f-4492-8004-8eeeb9b2f042-000000@eu-west-1.amazonses.com>
 <xmqqr3ogkpz5.fsf@gitster.dls.corp.google.com>
 <20150710154308.GA29395@peff.net>
 <20150710164652.GA30113@peff.net>
 <xmqqtwtbkbis.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 22:58:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDfNO-00016W-Te
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 22:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050AbbGJU61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 16:58:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:58746 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932253AbbGJU6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 16:58:25 -0400
Received: (qmail 32550 invoked by uid 102); 10 Jul 2015 20:58:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 15:58:24 -0500
Received: (qmail 11613 invoked by uid 107); 10 Jul 2015 20:58:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 16:58:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jul 2015 16:58:21 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwtbkbis.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273835>

On Fri, Jul 10, 2015 at 01:23:07PM -0700, Junio C Hamano wrote:

> > -	if (!strcmp(var, "include.path"))
> > -		ret = handle_path_include(value, inc);
> > +	if (!parse_config_key(var, "include", &cond, &cond_len, &key) &&
> > +	    include_condition_is_true(cond, cond_len)) {
> 
> I really like these two lines.
> 
> Whoever designed that parse_config_key() interface either is a
> genious or had a foresight with a crystal ball, or perhaps both.

Heh. I peeked at the archive, and I think it was actually designed by
committee. Perhaps we are greater than the sum of our parts? ;)

-Peff
