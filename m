From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 11:33:17 -0400
Message-ID: <20150415153317.GA21768@tsaunders-iceball.corp.tor1.mozilla.com>
References: <552E628C.7040809@debian.org>
 <552E6D07.5030903@drmicha.warpmail.net>
 <552E732E.20107@debian.org>
 <0cf0485caae569a71a8bd1aa8d1033cb@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pirate Praveen <praveen@debian.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, git-owner@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 15 17:36:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiPML-0003wc-7n
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 17:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbbDOPgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 11:36:08 -0400
Received: from tbsaunde.org ([66.228.47.254]:58984 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbbDOPgH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 11:36:07 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id A1B72C072;
	Wed, 15 Apr 2015 15:36:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <0cf0485caae569a71a8bd1aa8d1033cb@www.dscho.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267206>

On Wed, Apr 15, 2015 at 04:41:42PM +0200, Johannes Schindelin wrote:
> Hi Praveen,
> 
> On 2015-04-15 16:18, Pirate Praveen wrote:
> > On Wednesday 15 April 2015 07:22 PM, Michael J Gruber wrote:
> >> What would that require git to do, beyond taking whatever you tell it
> >> (using GIT_SSH or _GIT_SSH_COMMAND) to use as a drop in replacement for ssh?
> > 
> > May be support git+mosh as a protocol, since it is not a drop in
> > replacement. It is redesigned remote shell. The ideas it uses for
> > session resumption needs to be reimplemented. This will need support
> > from git, because it needs server side to be modified. Use SSP to return
> > the the current progress for a particular session (it uses AES session ids).
> 
> It will need support from Git alright, but not as much as from mosh, see my other reply: Mosh was not designed for non-interactive use. That support would have to be added before we can go any further.

is that really relevent? mosh doesn't support things like X forwarding
or port forwarding, but it certainly does support ssh <host> <command>
and then doing IO.  It might not support not doing terminal emulation
stuff, but that seems like a simple thing to change in principal at which
point I think it would support enough of ssh's functionality its a drop
in replacement as far as git is concerned.  Seems to me mosh is close
enough on its own its worth experimentation by someone who cares.

Trev

> > So when a client connect with a session id, git server side can respond
> > with the current state, how many objects received in that session, and
> > client can continue from where it stopped. Client also will need to
> > store session information.
> 
> No, the protocol can stay exactly the same, once you have a way to communicate non-interactively via mosh.
> 
> Ciao,
> Johannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
