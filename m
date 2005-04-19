From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: Darcs and git: plan of action
Date: Tue, 19 Apr 2005 14:20:55 +0200
Message-ID: <7i4qe3x8ig.fsf@lanthane.pps.jussieu.fr>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
	<20050418122011.GA13769@abridgegame.org>
	<7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr>
	<20050419110407.GB28269@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: darcs-devel-bounces@darcs.net Tue Apr 19 14:18:02 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNrfM-00054v-Lz
	for gcvdd-darcs-devel@m.gmane.org; Tue, 19 Apr 2005 14:17:21 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DNriy-0006yW-MG; Tue, 19 Apr 2005 08:21:04 -0400
Received: from shiva.jussieu.fr ([134.157.0.129])
	by abridgegame.org with esmtp (Exim 4.50) id 1DNriv-0006vO-OX
	for darcs-devel@darcs.net; Tue, 19 Apr 2005 08:21:02 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr
	[134.157.168.1])
	by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3JCKwDm002003
	; Tue, 19 Apr 2005 14:20:58 +0200 (CEST)
X-Ids: 164
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr
	[134.157.168.57])
	by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id
	j3JCKtSx013722 ; Tue, 19 Apr 2005 14:20:57 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DNrip-0001oV-Du; Tue, 19 Apr 2005 14:20:55 +0200
To: darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050419110407.GB28269@abridgegame.org> (David Roundy's
	message of "Tue, 19 Apr 2005 07:04:12 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2
	(shiva.jussieu.fr [134.157.0.164]);
	Tue, 19 Apr 2005 14:20:58 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 4264F7AA.002 by Joe's j-chkmail
	(http://j-chkmail.ensmp.fr)!
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

[Removing Linus from CC, keeping the Git list -- or should we remove it?]

> I'm not clear why it would be necesary, and it takes the only immutable
> piece of information regarding a patch, and makes it variable.

Er... I'm not suggesting to make it variable, just to make it an
opaque blob of bytes (still immutable).  I see from the examples you
give below that you agree that the format needs extending, so I
suspect we're actually agreeing here, just failing to communicate.

about having multiple ids per patch:

> Or alternatively, we could have a one-to-one mapping between git IDs and
> darcs IDs, which is what I'd do.

Okay, you've convinced me.  It's much simpler that way, we'll see how
well it works.

> The problem is that there is no sequence of alien versions that one can
> differentiate.  Git has a branched history, with each version that follows
> a merge having multiple parents.

Yep.  I've just realised that this morning.  Is there some notion of
``primary parent'' as in Arch?  Can a changeset have 0 parents?

> If we do it right (automatically tagging like crazy people), darcs
> users between themselves can cherry-pick all they like, without
> introducing inconsistencies or losing interoperability with git.

You've lost me here.  How can you cherry-pick if every tag depends on
the preceding patches?  Or are you thinking of pulling just the patch
and not the tag -- in that case, what happens when you push to git a
Darcs patch that depends on a patch that originated with git?

I've started interfacing Haskell with git this week-end, that's
something we'll need whichever model we choose.  We should be able to
start playing with actually modifying Darcs after next week-end.

                                        Juliusz
