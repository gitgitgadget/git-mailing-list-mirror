From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Alternate revno proposal (Was: Re: VCS comparison table)
Date: Thu, 19 Oct 2006 23:09:49 -0300
Message-ID: <200610200209.k9K29ncC006935@laptop13.inf.utfsm.cl>
References: <bulb@ucw.cz>
Cc: Robert Collins <robertc@robertcollins.net>,
	Petr Baudis <pasky@suse.cz>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 04:11:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gajqq-0003Gs-Ui
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 04:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946824AbWJTCLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 22:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946828AbWJTCLJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 22:11:09 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56769 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1946824AbWJTCLH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 22:11:07 -0400
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net [200.83.245.232])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9K29pnd002404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Oct 2006 23:09:52 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9K29ncC006935;
	Thu, 19 Oct 2006 23:09:49 -0300
To: Jan Hudec <bulb@ucw.cz>
In-Reply-To: Message from Jan Hudec <bulb@ucw.cz> 
   of "Wed, 18 Oct 2006 23:46:23 +0200." <20061018214623.GA32725@artax.karlin.mff.cuni.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 19 Oct 2006 23:09:56 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29400>

Jan Hudec <bulb@ucw.cz> wrote:

[...]

> Reading this thread I came to think, that the revnos should be assigned
> to _all_ revisions _available_, in order of when they entered the
> repository (there are some possible variations I will mention below)
> 
>  - Such revnos would be purely local, but:
>    - Current revnos are not guaranteed to be the same in different
>      branches either.
>    - They could be done so that mirror has the same revnos as the
>      master.

Then they are almost useless (except for people working alone). You need to
be able to talk about a particular commit with others working independently.

>  - They would be easier to use than the dotted ones. What (at least as
>    far as I understand) makes revnos easier to use than revids is, that
>    you can remember few of them for short time while composing some
>    operation. Ie. look up 2 or 3 revisions in the log and than do some
>    command on them. And a 4 to 5-digit number like 10532 is easier to
>    remember than something like 3250.2.45.86.

Probably. In git you can (mostly) get away with partial SHA-1's, BTW.

>  - Their ordering would be an (arbitrary) superset of the partial
>    ordering by descendance, ie. if revision A is ancestor of B, it would
>    always have lower revno.
>    - The intuition that lower revno means older revision would be always
>      valid for related revisions and approximately valid for unrelated
>      ones.
>  - They would be *localy stable*. That is once assigned the revno would
>    always mean the same revision in given branch (as determined by
>    location, not tip).

Tip-relative is extremely useful: I wouldn't normally remember the current
revision, but I'll probably often be talking about "the change before this
one" and so on.

>      - This is more than the current scheme can give, since now pull can
>        renumber revisions.

Urgh. Get an update, and all your bearings change?

>  - They wouldn't make any branch special, so the objections Linus raised
>    does not apply.

But the original branch /is/ special?

>  - They would be the same as subversion and svk, and IIRC mercurial as
>    well, use, so:
>    - They would already be familiar to users comming from those systems.
>    - They are known to be useful that way. In fact for svk it's the only
>      way to refer to revisions and seem to work satisfactorily (though
>      note that svk is not really suitable to ad-hoc topologies).

SVN is /centralized/, there it does make sense talking about (the one and
only) history. In a distributed system, potentially each has a different
history, and they are intertwined.

Not at all useful.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
