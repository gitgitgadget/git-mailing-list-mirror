From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when  --compose
 is used.
Date: Sat, 1 Nov 2008 13:54:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0811011323240.23340@sys-0.hiltweb.site>
References: <20081031220149.GD21345@maintenance05.msc.mcgregor-surmount.com> <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org>
 <1225456609-694-3-git-send-email-madcoder@debian.org> <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com> <20081031213803.GB21799@artemis.corp> <20081101022649.GB17961@sys-0.hiltweb.site> <20081101110439.GB3819@artemis.corp>
 <20081101130033.GD17961@sys-0.hiltweb.site> <20081101170817.GC26229@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 18:56:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwKi0-0003kc-Qz
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 18:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYKARzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 13:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbYKARzJ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 13:55:09 -0400
Received: from mail.gmx.com ([74.208.5.67]:39939 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751541AbYKARzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 13:55:08 -0400
Received: (qmail invoked by alias); 01 Nov 2008 17:55:06 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com (EHLO [192.168.1.5]) [75.185.223.130]
  by mail.gmx.com (mp-us005) with SMTP; 01 Nov 2008 13:55:06 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+ZmXZgoTOZwU3dNpw5XyOhVwX0VQ/gRO/4qpHeWT
	XO5USlQQPNh4zR
In-Reply-To: <20081101170817.GC26229@artemis.corp>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99754>

On Sat, 1 Nov 2008, Pierre Habouzit wrote:
> On Sat, Nov 01, 2008 at 01:00:33PM +0000, Ian Hilt wrote:
> > I'm confused here.  Why would a MIME library help?
> 
> Hmm maybe I'm wrong, but the idea would be to do what mutt does and be
> able to parse:
> 
> To: John Doe <some.address@some.tld>, Random Joe <random.joe@abc.def>,
>   Superman <batman@nyc.us>,
>   "Someone with a comma, inside its tag name" <a@b.com>

No, you're absolutely right for this reason: MIME-encoded addresses.

Ugh.

Although, to my knowledge, git-send-email doesn't understand that now. 
So unless we want to support MIME-encoded addresses, this won't be
necessary.

> And that needs to know how to do that with perl, and _really_ I hate
> perl enough for not being able to do that well. Splitting on ',' is just
> not going to fly.

Yea, it's going to be a bit trickier than that.

> > > But yeah, I knew I left out those, and this was the reason.
> > 
> > Anyway, do you, or does anyone else, think it's even worth coding the
> > possibility for the user to edit the To and Cc fields?
> 
> *YES*
> 
> I would love to see git-send-email work like mutt does: it fills the
> field like it does now, and you are allowed to fix that, and it parses
> the buffer back to guess what you wanted. It allow to drop most of the
> interactive prompting that is so annoying (since it's not in-shell and
> has no history and stuff like that, unlike my $EDITOR).

Hmm, I'll look into this; especially the MIME library.  I'm not a perl
monk, but I can give it a shot, no?


	Ian
