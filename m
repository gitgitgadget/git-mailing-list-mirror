From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Thu, 11 Aug 2011 22:00:21 +0200
Message-ID: <20110811195955.GA21185@book.hvoigt.net>
References: <cover.1312923673.git.hvoigt@hvoigt.net> <7v8vqzreeo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 22:00:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrbQb-0003ta-I1
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 22:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab1HKUAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 16:00:24 -0400
Received: from darksea.de ([83.133.111.250]:41560 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753397Ab1HKUAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 16:00:24 -0400
Received: (qmail 26353 invoked from network); 11 Aug 2011 22:00:22 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 Aug 2011 22:00:22 +0200
Content-Disposition: inline
In-Reply-To: <7v8vqzreeo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179139>

Hi Junio,

On Thu, Aug 11, 2011 at 11:28:31AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > If a submodule is used to seperate some bigger parts of a project into
> > an optional directory it is helpful to not clone/update them by default.
> 
> Sorry if I am slow, but I do not get this.
> 
> I thought unless you say "submodule init" once, a submodule you are not
> interested in should not be cloned nor updated at all. If that is not the
> case, isn't it a bug to be fixed without a new configuration variable that
> fixes it only when it is set?

What I usually do is say "submodule init" without any extra option once.
That will register all submodules from .gitmodules in the config. Now
when I say "submodule update" all submodules would be cloned. In the
case of recursive submodules actually

	git submodule update --init --recursive

is the only command which can get you really everything in one go.

Do you think the "submodule init" behavior is wrong? If so I think its a
bit late to change this since people using submodules (me included)
already have got used to it.

With this config variable all submodules will still be registered to
.git/config on "submodule init" but "submodule update" will skip those
submodules. Since we already have merge and rebase as alternate options
to update a submodule it just sounds logical to me to have an additional
option to disable updating.

> > We have been talking about loose submodules for some time:
> 
> Also before introducing a new terminology "loose submodule", please define
> it somewhere. It feels confusing to me that a normal submodule, which
> shouldn't be auto-cloned nor auto-updated without "submodule init", needs
> to be called by a name other than simply a "submodule" but with an
> adjuctive "loose submodule".

Thats why I avoided talking about it in the docs. For the commit message
I thought it would be kind of intuitive but I can update the commit
message so that it becomes more clear.

Cheers Heiko
