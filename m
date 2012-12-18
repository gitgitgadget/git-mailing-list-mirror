From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] completion: add option --recurse-submodules to
	"git push"
Date: Tue, 18 Dec 2012 18:59:42 +0100
Message-ID: <20121218175942.GA26151@book.hvoigt.net>
References: <1354883304-6860-1-git-send-email-steffen.jaeckel@stzedn.de> <7vehj1ixr6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Jaeckel <steffen.jaeckel@stzedn.de>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 19:00:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl1Sc-0007np-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 19:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab2LRR7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 12:59:51 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:38760 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab2LRR7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 12:59:51 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Tl1SB-0006Ov-Ll; Tue, 18 Dec 2012 18:59:43 +0100
Content-Disposition: inline
In-Reply-To: <7vehj1ixr6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211768>

Hi,

sorry for the late reply.

On Fri, Dec 07, 2012 at 09:21:33AM -0800, Junio C Hamano wrote:
> Steffen Jaeckel <steffen.jaeckel@stzedn.de> writes:
> 
> > Signed-off-by: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
> > ---
> >  contrib/completion/git-completion.bash | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 0b77eb1..5b4d2e1 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1434,6 +1434,10 @@ _git_pull ()
> >  	__git_complete_remote_or_refspec
> >  }
> >  
> > +__git_push_recurse_submodules_options="
> > +	check on-demand
> > +"
> 
> Most of the existing completion functions do not seem to define
> separate variables like this; instead, they literally embed their
> choices at the point of use.
> 
> Is it expected that the same set of choices will appear in the
> completion of many other subcommand options?  [jc: Cc'ed Heiko so
> that we can sanity check the answer to this question].  If so, the
> variable may be justified; otherwise, not.

No I think not. At least not exactly the same. check will be limited to
push since it only makes sense there. on-demand on the other hand is
already used for fetch and pull. Currently no more possible uses come to
my mind. checkout and others will learn to traverse submodules but that will
most likely be a boolean (to switch it on and off).

CC'ed Jens so he can also take a look.

Cheers Heiko
