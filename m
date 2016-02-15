From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] remote: use skip_prefix
Date: Mon, 15 Feb 2016 13:36:22 -0500
Message-ID: <20160215183622.GA27244@sigill.intra.peff.net>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
 <1455558150-30267-2-git-send-email-t.gummerer@gmail.com>
 <20160215181837.GE26443@sigill.intra.peff.net>
 <CAPig+cSkfEwa8TTJPg5B9W8FCqPXD9Uz6_EuFQeriwYHhP99gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 19:36:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVO0b-0001Pp-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcBOSgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 13:36:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:42309 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751193AbcBOSgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 13:36:25 -0500
Received: (qmail 26225 invoked by uid 102); 15 Feb 2016 18:36:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:36:24 -0500
Received: (qmail 10198 invoked by uid 107); 15 Feb 2016 18:36:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:36:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 13:36:22 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cSkfEwa8TTJPg5B9W8FCqPXD9Uz6_EuFQeriwYHhP99gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286228>

On Mon, Feb 15, 2016 at 01:35:03PM -0500, Eric Sunshine wrote:

> On Mon, Feb 15, 2016 at 1:18 PM, Jeff King <peff@peff.net> wrote:
> > This is definitely an improvement, but I think we can actually go a step
> > further here, and use parse_config_key. Like:
> >
> > -       if (starts_with(key, "branch.")) {
> > -               name = key + 7;
> > -               subkey = strrchr(name, '.');
> > -               if (!subkey)
> > +       if (starts_with(key, "branch", &name, &namelen, &subkey)) {
> 
> I guess you meant: s/starts_with/parse_config_key/

Whoops, yeah. I'll belatedly add a "not even compile-tested" disclaimer.
:)

-Peff
