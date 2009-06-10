From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 16:04:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906101555590.6847@localhost.localdomain>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>  <alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>  <51419b2c0906091530t3dfa5267s2262f979f1e9982a@mail.gmail.com>  <alpine.LFD.2.01.0906091535410.6847@localhost.localdomain> 
 <20090610033211.GA7411@mit.edu>  <alpine.LFD.2.01.0906092058430.6847@localhost.localdomain> <94a0d4530906101531ja6f1deeob703f546d62e7599@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 01:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEWrn-0000l1-UL
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 01:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759532AbZFJXFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 19:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758509AbZFJXFV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 19:05:21 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51394 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757305AbZFJXFU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 19:05:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5AN4oqJ012987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2009 16:04:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5AN4nq1001219;
	Wed, 10 Jun 2009 16:04:49 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <94a0d4530906101531ja6f1deeob703f546d62e7599@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121316>



On Thu, 11 Jun 2009, Felipe Contreras wrote:

> On Wed, Jun 10, 2009 at 7:03 AM, Linus
> Torvalds<torvalds@linux-foundation.org> wrote:
> >
> >
> > On Tue, 9 Jun 2009, Theodore Tso wrote:
> >>
> >> My personal opinion is this kind of overloading is actually more
> >> confusing than simply adding a new name, such as "git revert-file".
> >
> > I'd agree, except I think it actually worked pretty well in "git
> > checkout".
> >
> > The alternative was to add yet another command for that, or to teach
> > people about the internal commands we did have. Adding the capability for
> > checkout to check out individual files - in addition to commits and
> > branches - I think worked pretty well.
> 
> Why? What makes 'git checkout <commit>' and 'git checkout <commit> --
> <path>' similar at all? I would expect 'git checkout <commit>' to be
> the same as 'git checkout <commit> -- .'

You don't understand.

"git checkout" would be similar to "git revert", if we did that change. 

IOW, both would be "if you give it a commit, it acts at a commit level", 
and "if you give it pathnames, it acts on a pathname level".

That is totally obvious, and not in the least confusing. They are two 
different things, but at the same time, there is no question about which 
is which. 

> In my mind these are 2 completely different commands.

They are two different things, but they both make sense within the 
_context_.

Only earthworms and FOX news have no concept of "in context". So it does 
make sense to say "git checkout filename" (and expect it to check out that 
_filename_ - surprise surprise), and also say "git checkout branch" (and 
expect it to check out that branch - again, big surprise).

Humans are generally _very_ good at seeing the same word in two different 
contexts, and not being confused at all. There is no confusion when I talk 
about SCM's in the context of git, even though "SCM" could also mean a 
Sceme interpreter, or "Saskatchewan College of Midwives".

In fact, it is often *much* better to accept context-awareness, than to 
try too hard to be "uniquely identifying" even without context. 

Of course, you do want things to also be unambiguous. But that's why we 
have things like that "--" thing, when we want to specify pathspecs 
explicitly and don't want to accept any kind of ambiguity. Most humans 
tend to leave them out, and that "--" thing shows up mostly in git 
scripts.

			Linus
