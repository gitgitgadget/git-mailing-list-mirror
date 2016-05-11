From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Wed, 11 May 2016 17:50:48 +0200
Message-ID: <20160511155047.GA3321@sandbox>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
 <20160503235652.GA395@google.com>
 <xmqqd1p1frw4.fsf@gitster.mtv.corp.google.com>
 <20160508220127.GB59077@book.hvoigt.net>
 <xmqqlh3jxkyn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 17:51:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0WPi-0000N1-7V
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 17:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbcEKPvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 11:51:00 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:48036 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065AbcEKPu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 11:50:59 -0400
Received: from [62.224.169.60] (helo=sandbox)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1b0WPR-0002BG-PJ; Wed, 11 May 2016 17:50:49 +0200
Content-Disposition: inline
In-Reply-To: <xmqqlh3jxkyn.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294351>

On Mon, May 09, 2016 at 09:19:44AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >> > - When upstream adds a new submodule, I have to do the same manual
> >> >   work to change the options for that new submodule.
> >> 
> >> Because a new module is not automatically "init"ed by default?
> >> 
> >> Isn't "config only" vs "config with gitmodules fallback" orthogonal
> >> to that issue?
> >
> > What do you mean with "orthogonal to that issue"? AFAICS a gitmodule
> > fallback does not have that issue.
> >
> > Actually I would see it more like:
> > .gitmodule is the default and .git/config a possibility to override.
> 
> The way I read Jonathan's "I have to do the same manual..." above is:
> 
>   Back when I cloned, the upstream had one submodule A.  I didn't like
>   some aspect of the configuration for that submodule so I did a
>   customization in [submodule "A"] section of .git/config for it.
> 
>   Now the upstream added another submodule B.  I want a tweak similar
>   to what I did to A applied to this one, but that would mean I need
>   to edit the entry in .git/config copied by "init" from .gitmodules.
> 
> I do not see how difference between ".git/config is the only source
> of truth" or ".git/config overrides what is in .gitmodules" would
> matter to the above scenario.

I see with that explanation your comment makes sense to me. So what we
are here talking about is the wish to configure some general user set
settings that are applied to a group of/all submodules.

Thinking about it: Maybe sticking configurations to the submodule
groups, which Stefan Beller introduced in a different topic, could be a
direction we can go for such needs.

Cheers Heiko
