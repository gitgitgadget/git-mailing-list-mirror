From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Location-agnostic submodules
Date: Wed, 2 May 2012 18:55:43 +0200
Message-ID: <20120502165543.GB49462@book.hvoigt.net>
References: <20120427143710.GA13953@pape.arcanes.fr.eu.org> <CABURp0qA9hK1fBd3rmLG61ErpbbzrcxO=AAmFOsoxjt=ozu09Q@mail.gmail.com> <20120430220244.GL22827@pape.arcanes.fr.eu.org> <CABURp0rUKubfWXxX2ABG2E4dRTEQh4zA0bZFOeXGwv2m4b0YaA@mail.gmail.com> <732A8D2DB3374CD6BC12A5E7C4384313@PhilipOakley> <7v4nrzaioc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Phil Hord <phil.hord@gmail.com>,
	Pierre Thierry <pierre@nothos.net>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 18:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPcqG-0005YD-81
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 18:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376Ab2EBQzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 12:55:46 -0400
Received: from darksea.de ([83.133.111.250]:60773 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753249Ab2EBQzp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 12:55:45 -0400
Received: (qmail 12848 invoked from network); 2 May 2012 18:55:43 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 2 May 2012 18:55:43 +0200
Content-Disposition: inline
In-Reply-To: <7v4nrzaioc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196841>

Hi,

On Tue, May 01, 2012 at 10:57:07AM -0700, Junio C Hamano wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> > Would an alternative be something like:
> >    git submodule update <module> --from <remote>
> >
> > so that the user can state which of the current submodule's remotes
> > should be used for fetching the desired update.
> 
> Are you assuming that the <remote> in the above example will be different
> per invocation for a single user?  I would imagine not---it would be more
> like "the upstream has this URL in .gitmodules, but this other mirror is
> closer to my network environment", i.e.
> 
> 	cd <module's directory> && git config remote.origin.url $there
> 
> no?

Yes I think this is an important point. If we start working on this I
would like to emphasize the fork use case Philip brought up. When
cloning a forked repository with submodules you always have the problem
of changing/adding the forked submodules remotes afterwards.

For me it would be more like an additional lookup mechanism of the
"official" urls / names. Since I like to stay as close as possible to
the upstream repository I usually refrain from changing the .gitmodules
file. A changed .gitmodules file with additional urls (possibly some
private ones) is not something you can propagate upstream.

What I would like is a mechanism that, given a wanted sha1, would lookup
the correct remote to clone/fetch from. But, I have to admit that even
though thinking about this for some time now, I have not got to a
satisfying answer for myself yet.

Cheers Heiko
