From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 17:00:27 +0200
Message-ID: <20050628150027.GB1275@pasky.ji.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050624064101.GB14292@pasky.ji.cz>
	<20050624123819.GD9519@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mercurial@selenic.com, Jeff Garzik <jgarzik@pobox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
X-From: mercurial-bounces@selenic.com Tue Jun 28 16:54:08 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnHTF-0005qS-QH
	for gcvmd-mercurial@gmane.org; Tue, 28 Jun 2005 16:53:54 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5SF0gTG024301;
	Tue, 28 Jun 2005 10:00:42 -0500
Received: from machine.sinus.cz (qmailr@w241.dkm.cz [62.24.88.241])
	by waste.org (8.13.4/8.13.4/Debian-3) with SMTP id j5SF0U9S024279
	for <mercurial@selenic.com>; Tue, 28 Jun 2005 10:00:31 -0500
Received: (qmail 3033 invoked by uid 2001); 28 Jun 2005 15:00:27 -0000
To: Christopher Li <hg@chrisli.org>
Content-Disposition: inline
In-Reply-To: <20050624123819.GD9519@64m.dyndns.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com

Dear diary, on Fri, Jun 24, 2005 at 02:38:19PM CEST, I got a letter
where Christopher Li <hg@chrisli.org> told me that...
> On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> > > 5.1) undo the last commit or pull
> > > 
> > > $ hg undo
> > 
> > $ cg-admin-uncommit
> > 
> > Note that you should never do this if you already pushed the changes
> > out, or someone might get them. (That holds for regular Git too.) See
> > 
> > $ cg-help cg-admin-uncommit   # (or cg-admin-uncommit --help)
> > 
> > for details. (That's another Cogito's cool feature. Handy docs! ;-)
> > 
> 
> Does it still works if the last commit was interrupted  or due to error for some
> reason?

If the last commit was interrupted, it didn't happen, so your tree stays
in the same state as before doing the commit, as well as the repository.
You can just try again. If you want to get rid of dirty stuff,
cg-cancel.

> Undo pull is pretty cool because you might pull a lot of commit
> in one blow. Get rid of commit one by one is going to be painful. Some times
> the object you pull has more than one chain of history it will be very nasty
> if you want to clean it up.

If it was a tree merge, cg-admin-uncommit will undo it. If it was
fast-forward merge, there is no direct way to uncommit it, but you can
find the first fast-forwarded commit and pass it as argument to
cg-admin-uncommit; it will then rewind all the commits up to (including)
the given commit.

> Mercurial's undo is taking a snapshot of all the changed file's repo file length
> at every commit or pull.  It just truncate the file to original size and undo 
> is done.

"Trunactes"? That sounds very wrong... you mean replace with old
version? Anyway, what if the file has same length? It just doesn't make
much sense to me.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
