From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] config: add '--sources' option to print the
 source of a config value
Date: Sat, 13 Feb 2016 13:19:01 -0500
Message-ID: <20160213181901.GC9516@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <CANoM8SWj08qKvDXhyfRXLV2iuYJ7Vjdutzjt0Q2ZNOcProqy=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	ramsay@ramsayjones.plus.com,
	Eric Sunshine <sunshine@sunshineco.com>, hvoigt@hvoigt.net,
	sbeller@google.com
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 19:19:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUemk-0002XY-6F
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 19:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbcBMSTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 13:19:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:41603 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751056AbcBMSTE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 13:19:04 -0500
Received: (qmail 11798 invoked by uid 102); 13 Feb 2016 18:19:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 13:19:03 -0500
Received: (qmail 27260 invoked by uid 107); 13 Feb 2016 18:19:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 13:19:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 13:19:01 -0500
Content-Disposition: inline
In-Reply-To: <CANoM8SWj08qKvDXhyfRXLV2iuYJ7Vjdutzjt0Q2ZNOcProqy=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286124>

On Sat, Feb 13, 2016 at 09:43:34AM -0500, Mike Rappazzo wrote:

> > I renamed the flag from "--source" to "--show-origin" as I got the impression
> > that Sebastian, Peff and Ramsay seem to be all OK with "--show-origin".
> 
> I know that I am late to the party here, but why not make the option
> `--verbose` or `-v`?  `git config` doesn't have that now, and this
> seems like a logical thing to include as verbose data.  I would
> venture to guess that `--verbose` is more likely to be the first thing
> that someone who is looking for this information will guess at before
> they run `git config --help`.

I'm actually opposed to "--verbose" because it is too vague. That is
fine for a human, but this is also an interface that we expect scripts
to parse, and which we therefore cannot later change without breaking
them. I am not prepared to set "--verbose" in stone as showing the
source file and nothing else, for all time.

We _could_ have "--show-origin", and then "--verbose" implies
"--show-origin", and we don't promise that it might not show more later.
But I don't think that is worth the added complexity (not in code, but
just in what we have to explain to the user).

-Peff
