From: Johan Herland <johan@herland.net>
Subject: Re: Git Documentation
Date: Tue, 22 Jul 2008 11:21:22 +0200
Message-ID: <200807221121.22520.johan@herland.net>
References: <d411cc4a0807212035v68c2ed95m93b77c1e61cfec9e@mail.gmail.com>
 <200807220917.57363.johan@herland.net>
 <alpine.DEB.1.10.0807220035110.1125@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Jul 22 11:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLE4k-0001k7-7M
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 11:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbYGVJVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 05:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbYGVJVa
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 05:21:30 -0400
Received: from smtp.getmail.no ([84.208.20.33]:44604 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbYGVJV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 05:21:29 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K4E00903HZQ7H00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 22 Jul 2008 11:21:26 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K4E00JJKHZNDKB0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 22 Jul 2008 11:21:23 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K4E00IN6HZM5BV3@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 22 Jul 2008 11:21:23 +0200 (CEST)
In-reply-to: <alpine.DEB.1.10.0807220035110.1125@asgard.lang.hm>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89476>

On Tuesday 22 July 2008, david@lang.hm wrote:
> On Tue, 22 Jul 2008, Johan Herland wrote:
> > It seems there are primarily two ways to teach Git:
> >
> > 1. Top-down: Start with simple use cases and commands. Teach people a
> > minimal, but necessary set of porcelain commands to get them started.
> > Stay _far_ away from plumbing commands and most of the command options.
> >
> > 2. Bottom-up: Start with how Git structures the data. Talk about blobs,
> > trees, commits, refs, how everything is connected, and how various Git
> > commands query and manipulate this structure. This _may_ involve a fair
> > amount of plumbing commands, especially when discovering how the more
> > complicated high-level commands manipulate the structure.
> >
> > Some people seem to prefer the first approach, other people prefer the
> > other approach. Both paths lead to enlightenment ;). In many cases a
> > bit of both may be useful. HOWEVER, I think it is _very_ important to
> > keep in mind that these are two _different_ approaches, and the
> > contexts in which they are taught should be kept separate. I would
> > almost suggest splitting your website down the middle and make the
> > difference between top-down and bottom-up immediately visible with,
> > say, a different background color, or something else that immediately
> > tells the user what "track" they are following...
>
> possibly a combination of the two?
>
> under the covers the git data-structures are pretty simple and explaining
> them (and the minimal tools to manipulate them) isn't that bad.

Not sure. In both cases one will need _some_ kind of model to work with, but 
I think that for the top-down approach, it will suffice with a very 
simple/simplified model along the lines of:

- A commit contains the state of some repo at some point in time (plus some 
metadata)

- A commit points to its direct parents (zero or more). A collection of 
commits make up a DAG, representing the history of a project.

- Refs point to select commits. Tags are static, branches are dynamic, etc.

Specifically, for the top-down approach I do NOT think it is necessary to 
teach:
- blobs and trees
- plumbing tools

> what gets ugly is when you then try to use the plumbing to do the
> non-trivial things.

Certainly. We should only use plumbing tools in the bottom-up approach, and 
even then we should only use them when it _simplifies_ or otherwise nicely 
_illustrates_ the concepts being taught.

> so how about an optional 'under the covers' primer, covering just the
> trivial plumbing, then the high-level minimal introduction with a link on
> each of the commands as they are introduced (so that a person can dig
> into deeper detail if they want to, possibly including 'up until version
> X this command was implemented by the following script'), followed by
> links to sample work-flows and a full dive into the plumbing (because at
> this point the person should know enough to get by, now they need
> reference material and examples more then a tutorial).

Nope. A primer (i.e. a document to be read before the "real" teaching 
starts) should not cover more than the simplest/simplified model (see 
above).

Of course, the courses should reference manual pages and more in-depth 
documentation wherever it makes sense, but we should make sure to note that 
such knowledge is not _required_ to follow the course.

> ideally this would let people dive as deep as they are comfortable with,
> or skim the explanation for the functionality
>
> I think one reason the 'plumbing first' approach gets a bad rap is that
> it's so easy to get caught up into how clever you can get with the
> plumbing. it's like teaching someone programming by spending a day
> introducing them to concepts and language syntax, and then giving them
> the entries in the obfuscated C contests as examples of how someone can
> use them to get work done, but skipping any mention of libc or other
> standard libraries.

I see your point, but I still don't think teaching plumbing have any value 
in and of itself (unless you need to specifically learn plumbing to write 
porcelain code/scripts, in which case you'd better already know how to 
navigate the existing manual pages and other documentation).

For newbies, I think plumbing should only be taught/mentioned when it 
simplifies or illustrates a concept in the bottom-up approach.

> on the other hand, teaching only porcelain is like teaching them <insert
> high-level *th generation buzzword language> without teaching any concept
> of what they computer is doing under the covers, they can work, and even
> get useful work done, but they will be limited on how effective they can
> be.

I don't agree that teaching only porcelain will not give them any concept of 
what their computer does "under the covers". I think we can teach porcelain 
with reference to the simplified object model, and still achieve a 
(simplified, but still rewarding) understanding of what happens at an 
object level.

When I use Git myself, I normally only think in terms of the simplified 
model, and I have no problem getting things done without paying attention 
to the full object model (blobs, trees, etc) or the plumbing tools that are 
implicitly involved in the process.

> you can't be a great programmer until you can understand both levels, the
> under-the-covers 'plumbing' and the high level libraries of the
> 'porcelain', trying to ignore either will limit you.

Agreed. But we shouldn't need every Git user to be a great programmer. At 
least I hope not. Otherwise, there will be few Git users, indeed... ;)

Many Git users will not be VCS geeks like us; they will be "regular" people 
that use Git because it's useful for them (or because they're forced to use 
Git at $dayjob). They will not be interested in how Git manages their data, 
and how a complex Git operation can be split into simple plumbing 
components. We should not require them to learn such details in order to 
become good Git users. Instead we should teach them Git using porcelain 
commands with reference to the simplified object model. They should learn 
how to use Git in a simple, yet still rewarding manner.

...and _that_ is how we achieve world domination ;)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
