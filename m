From: Jeff King <peff@peff.net>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Sat, 19 Mar 2016 14:12:28 -0400
Message-ID: <20160319181228.GA9115@sigill.intra.peff.net>
References: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
 <20160319175705.GA6989@sigill.intra.peff.net>
 <CAJj6+1HaVnRcmDHOTDdx=o8a+aXvSi8+LykWzrfx7knE-_3ocg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Chirayu Desai <chirayudesai1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 19:12:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahLMd-0004CO-FF
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 19:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbcCSSMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 14:12:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:34658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753809AbcCSSMc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 14:12:32 -0400
Received: (qmail 21806 invoked by uid 102); 19 Mar 2016 18:12:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 19 Mar 2016 14:12:31 -0400
Received: (qmail 21920 invoked by uid 107); 19 Mar 2016 18:12:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 19 Mar 2016 14:12:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Mar 2016 14:12:28 -0400
Content-Disposition: inline
In-Reply-To: <CAJj6+1HaVnRcmDHOTDdx=o8a+aXvSi8+LykWzrfx7knE-_3ocg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289320>

On Sat, Mar 19, 2016 at 11:38:09PM +0530, Chirayu Desai wrote:

> > You'd teach parse_opt_commits() to store the string _name_ of the
> > argument (e.g., using a string_list rather than a commit_list), and then
> > later resolve those names into commits.
> Gotcha, will need to figure out where exactly would those names be
> resolved, can do after following the code path a bit more, can do.

Without looking too closely, I suspect you could do it as the first step
in filter_refs(). Or alternatively, add a function to "finalize" the
filter state before making queries of it.

-Peff
