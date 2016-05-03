From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] Documentation: fix linkgit references
Date: Tue, 3 May 2016 13:58:09 -0400
Message-ID: <20160503175808.GA29877@sigill.intra.peff.net>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
 <1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
 <1462220405-12408-2-git-send-email-larsxschneider@gmail.com>
 <20160502203445.GA19509@sigill.intra.peff.net>
 <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 19:58:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axeaP-0008Pf-2D
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 19:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933958AbcECR6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 13:58:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:33209 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932543AbcECR6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 13:58:12 -0400
Received: (qmail 18708 invoked by uid 102); 3 May 2016 17:58:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 13:58:11 -0400
Received: (qmail 31954 invoked by uid 107); 3 May 2016 17:58:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 13:58:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 13:58:09 -0400
Content-Disposition: inline
In-Reply-To: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293424>

On Tue, May 03, 2016 at 10:30:09AM +0200, Lars Schneider wrote:

> > So I think that's a step backwards. I did check the asciidoctor
> > rendering on git-scm.com, though, and it gets the {litdd} case wrong. So
> > I think it does need fixing, but we need a solution that looks correct
> > in both cases. Maybe linkgit:`git-web--browse`[1] would work; it seems
> > OK with my version of asciidoc, but I have a feeling it will run into
> > the same problem with asciidoctor (if it's not respecting {litdd} in
> > that context, it's probably also not respecting backticks).
> I will play with this to find a solution. Would it be an option to
> replace "--" with "-"? Why do we need two dashes if they cause trouble?

We use two dashes to signify "internal" programs that users should not
rely on. So "git-web-browse" would be something we'd expect to support
forever, but "git-web--browse" is an implementation detail of one of our
scripts (that just happens to require an extra program).

So I don't think we want to switch away from that convention just to
make the documentation work.

AFAICT, the {litdd} is working fine with asciidoc; it's only asciidoctor
that is the problem. So the first step may be talking with asciidoctor
folks to see if it's a bug, or if they have a recommended workaround.

-Peff
