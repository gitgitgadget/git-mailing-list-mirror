From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Tue, 03 Apr 2012 22:53:45 +0100
Message-ID: <4F7B7169.4050507@pileofstuff.org>
References: <11292500.AVmZFUUvNi@flobuntu> <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com> <2148933.pnpYo0xMAP@flomedio> <2487557.B8qfnaixh3@flomedio> <4F7A258C.5000200@pileofstuff.org> <20120402222958.GD13969@burratino> <4F7A3450.7000302@pileofstuff.org> <20120403000945.GA15075@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Florian Achleitner <florian.achleitner@student.tugraz.at>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:53:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFBfo-0004I5-Am
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 23:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab2DCVxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 17:53:51 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:37120 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755547Ab2DCVxu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Apr 2012 17:53:50 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120403215348.QBNC3740.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Tue, 3 Apr 2012 22:53:48 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120403215347.XNGS3795.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Tue, 3 Apr 2012 22:53:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120403000945.GA15075@burratino>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=Hd5Tmzg1rDkA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=TSbVqHtbAAAA:8 a=j6eC_ijdWVJ-nkygFBIA:9 a=yqrW7dVWVU7RJGQWVZQA:7 a=wPNLvfGTeEIA:10 a=HJv7hEJrbEjrmjEW:21 a=2oHDV8dHocOOrD6_:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194652>

On 03/04/12 01:09, Jonathan Nieder wrote:
> Andrew Sayers wrote:
> 
>> Sorry, that wasn't clear.  I meant commands that just expose a single
>> primitive bit of functionality (like git-commit-tree) instead of those
>> that present an abstract interface to the whole git machinery (like
>> git-fast-import).
> 
> Ok.  I think you are misunderstanding the purpose of fast-import[1] but
> it doesn't take away from what you're saying.

I had certainly missed the "ls" command - having seen that, I agree
fast-import is the best solution to this problem.  I'm still a bit
concerned about fast-import as a learning tool, although this is a bit
of a meta-conversation as far as GSoC is concerned.

Personally, I like to learn things by understanding the basic building
blocks, then seeing how to construct things from them.  I found git easy
to learn because I could start with the basic data structures and
algorithms, then layer an approximation of a patches-and-tarballs
workflow on top of it.  I would expect a discussion of the problem in
terms of primitive commands like git-commit-tree to help that learning
style, although I am committing a logical fallacy by assuming that
everyone thinks like me until proven otherwise :)

I think a lot of learners want to play a bit, make some informative
mistakes, then flesh out their understanding with something a bit more
technical.  People that want to "look under the hood" are well-served by
git, because they can use the ordinary interface
(status/commit/branch/etc.) then use the source when they're ready.  It
seems like people that want to "peek behind the curtain" at a
communication stream would be well-served by fast-import if only there
was a curtain for them to peek behind.  I'd be intereseted to know what
git learners think, but I'd feel more comfortable pointing students at
fast-import if there was a FUSE module, or a shell, or some other
interface on top of it whose failure mode was a puzzling mess instead of
a safely inert repository.

Incidentally Florian, some of the above probably spoke to you, other
bits probably less so.  It took me several years after leaving
university to see my own learning style, so if you find it hard to learn
git one way, try some different approaches before assuming it's a
personal problem :)

>> I agree it's possible to use fast-import for this problem, but it seems
>> like it's redundant after svn-fe has already loaded everything into git.
> 
> Right, I missed your point here before.  The fundamental question is
> not about what commands to use but about the order of operations.
> 
> 1. In one scheme, first you import the whole tree without splitting it
>    into branches, with a tool like svn-fe.  Afterwards, you
>    postprocess the resulting repository with tools like "git
>    filter-branch --subdirectory-filter".  The result of the import can
>    depend on all revisions --- you can say, in rev 1, "I'm not sure
>    whether this new directory is a branch; let me see how it develops
>    by rev 1000 to decide how to process it".
> 
> 2. In another scheme, you only import the subset of the repository
>    you are interested in.  This is what git-svn does, for example.
>    This requires the branch discovery to happen at the same time as
>    the import, because otherwise there is no way to tell what subset
>    of the repository you are actually interested in.
> 
> 3. Lastly, in yet another scheme, you import the whole tree and it is
>    split into branches on the fly.  The advantages relative to (1) are:
> 
>    - impatient people can peek at the partial result of the import as
>      it happens
> 
>    - the result of importing rev n is guaranteed to depend only on
>      revs <= n, so different people importing at different times will
>      get the same commits (assuming nobody is rewriting early history
>      behind the scenes) and it is obvious how to support incremental
>      importants to expand a repository with all revs <= n to a
>      repository with all revs <= 2n
> 
>    However, if splitting branches only can happen during the initial
>    import, that makes it harder to tweak the configuration and try
>    again to see what changes.
> 

That's a good way of putting the question, but for SVN it's useful to
distinguish between trunk and non-trunk branches.  I previously[1]
suggested this algorithm for deciding if a directory is a branch:

A directory is a branch if...
1. it is not a subdirectory of an existing branch; and
2. either:
2a. it is in a list of branches specified by the user, or
2b. it is copied from a (subdirectory of a) branch

This is a pretty solid heuristic for detecting branches copied from an
existing branch even in scheme (2) or (3), but does absolutely nothing
for trunk detection.  Although trunk detection is trivial in the sane
case (the "trunk" directory is the one and only trunk, end of story),
here's a contrived example for why it's hard in the general case:

Our SVN newbie created "scratchpad/libfoo/foo.c" in revision 1.  He
spends the next 1,000 revisions working in scratchpad/libfoo, creating
the fooiest foo that ever did foo.  After that, he creates
"scratchpad/libbar/bar.c" and continues for another thousand revisions.
 This cycle repeats until he's finally ready to tie all his libraries
together.  It's only now that he finally decides whether to create
"scratchpad/main.c" (if he thinks "scratchpad" is the trunk), or
"trunk/main.c" (if he thinks all the subdirectories of scratchpad were
trunks) or "scratchpad/main/main.c" (if he wants to give me an aneurysm
worrying how to cope when he does `svn cp scratchpad/main scratchpad`).

I paused after writing the paragraph above, because the last part got me
thinking.  Copying a subdirectory to its parent directory isn't actually
possible in SVN, but the concept of "branch absorption" is an
interesting one.  In theory, we could say that "scratchpad/libfoo" and
"scratchpad/libbar" were trunk branches at first, but were deleted when
the "scratchpad" branch was created.  I'll have to check whether this
leads to undesirable results in the real world, but this might make it
possible to do on-the-fly trunk detection as described in scheme (3).

> The relevant technical difference is that in the naive implementation
> of scheme (2) you can make use of arbitrary information available over
> svn protocol, in naive scheme (3) you can only use information that
> makes it into the fast-import stream, and in naive scheme (1) you can
> only use information that makes it into the actual git repository.  So
> to use scheme (1) you need to make sure svn-fe stores all interesting
> data in a visible way, including copyfrom info (which is not a bad
> idea anyway).

The approach I'm looking at is to extract information from an SVN dump
at an early stage, then use the extracted information when the user
tidies up the SBL file.  This was originally a simple optimisation
(reading a small gzipped JSON file is much faster than reading an SVN
dump that's 99% file bodies you don't care about) but it wouldn't be too
hard to teach svn-fe how to produce the file if you were so inclined.

	- Andrew

[1] http://article.gmane.org/gmane.comp.version-control.git/192286
