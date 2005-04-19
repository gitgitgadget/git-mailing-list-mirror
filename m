From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Darcs and git: plan of action
Date: Tue, 19 Apr 2005 07:55:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504190749030.19286@ppc970.osdl.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
	<20050418122011.GA13769@abridgegame.org>
	<Pine.LNX.4.58.0504180832330.7211@ppc970.osdl.org>
	<20050419104252.GA28269@abridgegame.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Tue Apr 19 16:50:29 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNu2w-0000Ee-PW
	for gcvdd-darcs-devel@m.gmane.org; Tue, 19 Apr 2005 16:49:52 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DNu6t-0004mb-Nd; Tue, 19 Apr 2005 10:53:55 -0400
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by abridgegame.org with esmtp (Exim 4.50) id 1DNu6r-0004mP-0C
	for darcs-devel@darcs.net; Tue, 19 Apr 2005 10:53:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JErls4016533
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 07:53:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JErkEj013123;
	Tue, 19 Apr 2005 07:53:46 -0700
To: David Roundy <droundy@abridgegame.org>
In-Reply-To: <20050419104252.GA28269@abridgegame.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
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



On Tue, 19 Apr 2005, David Roundy wrote:
> 
> Would a small amount of human-readable change information be acceptable in
> the free-form comment area? In the rename thread I got the impression this
> would be okay for renames.  For example,
> 
> rename foo bar

Sure. That's human-readable and meaningful, as in "it actually makes sense 
as a commit comment regardless of any darcs issues". As does:

> replace [_a-zA-Z0-9] old_variable new_variable file/path

which is almost so (a human would have written "rename old to new", but
the above isn't _that_ different).

HOWEVER, then the requirement would be that we'd never have complex
combinations of the above. Ie having 2-5 lines of something like that is
"human-readable". Having 10+ lines of the above is not. See?

I have this suspicion that the "replace" thing often ends up being done on
dozens of files, and I don't want to have dozens of lines of stuff that
ends up really being machine-readable. But if it's ok to depend on the
content changes (you _do_ see which files changed) together with a single
line of "replace [token-def] xxx yyy", then hell yes - I consider that to
be useful information even outside of git.

(In other words: if it looks like something a careful human _could_ have
written, it's certainly ok. But if it looks like something a careful human
would have used a script to generate 40 entries of, it's bad).

		Linus
