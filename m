From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: A darcs that can pull from git
Date: Tue, 26 Apr 2005 14:34:45 +0200
Message-ID: <20050426123445.GE18971@pasky.ji.cz>
References: <7ipswjbybx.fsf@lanthane.pps.jussieu.fr>
	<20050425133116.GG11667@abridgegame.org>
	<7i4qdusxdw.fsf@lanthane.pps.jussieu.fr>
	<20050426110613.GB20723@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: darcs-devel-bounces@darcs.net Tue Apr 26 14:30:54 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQPCe-0006zt-43
	for gcvdd-darcs-devel@m.gmane.org; Tue, 26 Apr 2005 14:30:12 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DQPHM-0007Sb-C1; Tue, 26 Apr 2005 08:35:04 -0400
Received: from w241.dkm.cz ([62.24.88.241] helo=machine.sinus.cz ident=qmailr)
	by abridgegame.org with smtp (Exim 4.50) id 1DQPHI-0005WX-Cc
	for darcs-devel@darcs.net; Tue, 26 Apr 2005 08:35:00 -0400
Received: (qmail 30212 invoked by uid 2001); 26 Apr 2005 12:34:45 -0000
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050426110613.GB20723@abridgegame.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
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

Dear diary, on Tue, Apr 26, 2005 at 01:06:17PM CEST, I got a letter
where David Roundy <droundy@abridgegame.org> told me that...
> On Mon, Apr 25, 2005 at 05:12:59PM +0200, Juliusz Chroboczek wrote:
> > > Do you have any plans/ideas for allowing pulls directly from a
> > > remote git repository?
> > 
> > I haven't thought about it yet.  Does anyone have any ideas about how
> > to efficiently pull from git without a complete local copy?
> 
> I don't think so.  My best thought so far would be to have something like a
> ~/.gitcache/, which would store the sha1 objects themselves, so at least
> we'd only end up with *one* local copy.  I'm actually curious what the true
> git people do about this--it would be nice to share a cache.  For darcs'
> purposes, we could prune the cache from time to time.  If we're running
> with a darcs backend, we really only need the recent versions of files and
> trees.
> 
> Do the git have any suggestions about how to avoid excess downloads or
> excess copies of a git repository? It seems to me like it would make sense
> to always download sha1s to ~/.gitcache/, and then hardlink them to the
> current git repository, so you wouldn't end up ever downloading the same
> sha1 twice.  Or we should use $GITCACHE/, to give the user some
> flexibility.  But perhaps this is an already-solved problem, and I've just
> not noticed...

I'm not sure about the problem you are actually trying to solve, and I
didn't manage to guess it quickly just from the mails themselves;
cg-init /local/path now hardlinks the sha1 objects to the local
.git/objects directory, so you get no space waste. If you are talking
about downloading stuff from remote repositories, http-pull might help.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
