From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [BUG] git gui blame: Show History Context broken since
	29e5573d
Date: Tue, 23 Feb 2010 22:30:38 +0100
Message-ID: <20100223213035.GE10932@book.hvoigt.net>
References: <vpqaav1llpn.fsf@bauges.imag.fr> <cb7bb73a1002220718p6b6621der6df062cd2f490d89@mail.gmail.com> <20100222223802.GA9898@book.hvoigt.net> <cb7bb73a1002221529r6aee3202l5b6609b59aea01fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:30:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2LI-0005om-Ta
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab0BWVao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:30:44 -0500
Received: from darksea.de ([83.133.111.250]:50317 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754103Ab0BWVan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:30:43 -0500
Received: (qmail 17259 invoked from network); 23 Feb 2010 22:30:39 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Feb 2010 22:30:39 +0100
Content-Disposition: inline
In-Reply-To: <cb7bb73a1002221529r6aee3202l5b6609b59aea01fd@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140843>

On Tue, Feb 23, 2010 at 12:29:03AM +0100, Giuseppe Bilotta wrote:
> On Mon, Feb 22, 2010 at 11:38 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > On Mon, Feb 22, 2010 at 04:18:11PM +0100, Giuseppe Bilotta wrote:
> >> On Mon, Feb 22, 2010 at 9:27 AM, Matthieu Moy
> >> <Matthieu.Moy@grenoble-inp.fr> wrote:
> >> > Hi,
> >> >
> >> > In "git gui blame", right-clicking on the left fringe and chosing
> >> > "Show History Context" in the context-menu doesn't work for me in the
> >> > latest git. It says:
> >> >
> >> > couldn't change working directory to "": no such file or directory
> >>
> >> Definitely my fault. _gitworktree was not being set up correctly when
> >> support for bare repositories was enabled and the repo was not bare
> >> (like in the blame case). Patch incoming, can you see if it does the
> >> job for you? It seems to fix it here.
> >
> > Isn't this the same bug as this one fixes:
> >
> > http://article.gmane.org/gmane.comp.version-control.git/140288
> >
> > cheers Heiko
> 
> Interesting, I missed that patch. However, I strongly suspect that
> patch is not correct, since in that case the setup of gitworktree is
> done before checking for bareness, meaning that when working in
> somerepo.git (bare repo) for which the config flag is not set, it
> might misdetect the situation as being in the non-bare case. I believe
> my fix to be more correct in this regard.

Good to know. I already picked that one into my private repo and did not
experience any problems with it, but that might be due to the fact that
I have never tried to open git gui on bare repos.

cheers Heiko
