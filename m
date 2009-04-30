From: Jakub Narebski <jnareb@gmail.com>
Subject: Why Git is so fast (was: Re: Eric Sink's blog - notes on git, dscms and a "whole product" approach)
Date: Thu, 30 Apr 2009 05:17:58 -0700 (PDT)
Message-ID: <m3fxfqnxn5.fsf_-_@localhost.localdomain>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
	<m3ocugod96.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 14:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzVE0-0002ru-7O
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 14:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519AbZD3MSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 08:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756508AbZD3MSE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 08:18:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:56784 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbZD3MSA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 08:18:00 -0400
Received: by wa-out-1112.google.com with SMTP id j5so975047wah.21
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=5LJHcXJt4rdaIEFSGHmhqHsbVDmSqYHRxLIIZX5hHaY=;
        b=X6sab+jLjvTYpO7eYzVLKCVSYAiKAypv6FPSZkNady8YYSncjBEONilL9fKgkO6RHo
         ghsbe6jvlW3QQwptv0HMNGskXTvpGkLn3NgSVWoPyUuun7iAbyIL7aSXY3x3vUsb4Blq
         eE4oAGYgsnY1tlwcctkCK4ERD1+2JczkJLMcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tYDqXk11+wZOorRIxLj8E4Qdy+CcujjXBVYFCwQENjuiirr2hPLWScbGpyAGHaPw2I
         TETaIHVCkvl0c2+3Ld9S5PaOfXsbzUgw0vVjS1ZQcbczhIxOY5fTUuo1pAjMwzdeEyLh
         F/1Xo1bPXExukTsoeNRDM4a3rX8pcwjDpmD8Y=
Received: by 10.114.192.17 with SMTP id p17mr1153672waf.196.1241093879582;
        Thu, 30 Apr 2009 05:17:59 -0700 (PDT)
Received: from localhost.localdomain (abwf75.neoplus.adsl.tpnet.pl [83.8.229.75])
        by mx.google.com with ESMTPS id y11sm8461166pod.4.2009.04.30.05.17.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 05:17:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3UCHpdA020175;
	Thu, 30 Apr 2009 14:17:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3UCHp2b020172;
	Thu, 30 Apr 2009 14:17:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3ocugod96.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118013>

Jakub Narebski <jnareb@gmail.com> writes:

> Martin Langhoff <martin.langhoff@gmail.com> writes:
> 
> > Eric Sink hs been working on the (commercial, proprietary) centralised
> > SCM Vault for a while. He's written recently about his explorations
> > around the new crop of DSCMs, and I think it's quite interesting.

[...]

> > So here's the blog -  http://www.ericsink.com/

[...]
> *  "Mercurial, Subversion, and Wesley Snipes"
> >   http://www.ericsink.com/entries/hg_denzel.html
> 
> which I will comment now.  The 'ES>' prefix means quoting above blog
> post.

[...]
> ES> * The one where I speculate cluelessly about why Git is so fast
> 
> where Eric guesses instead of asking on git mailing list or #git
> channel... ;-)

This issue is interesting: what features and what design decision
make Git fast? One of the goals of Git was good performance; are
we there?

All quotes marked 'es> ' below are from "Why is Git so Fast?" post
http://www.ericsink.com/entries/why_is_git_fast.html

es> One:  Maybe Git is fast simply because it's a DVCS.
es>
es> There's probably some truth here.  One of the main benefits touted
es> by the DVCS fanatics is the extra performance you get when
es> everything is "local".

This is I think quite obvious.  Accessing memory is faster than
acessing disk, which in turn is faster than accessing network.  So if
commit and (change)log does not require access to server via network,
they are so much faster.

BTW. that is why Subversion stores along working copy 'pristine'
versions of files: to make status and diff fast enough to be usable.
Which in turn might make SVN checkout to be larger than full Git
clone ;-)

es>
es> But this answer isn't enough.  Maybe it explains why Git is faster
es> than Subversion, but it doesn't explain why Git is so often
es> described as being faster than the other DVCSs.

Not only described; see http://git.or.cz/gitwiki/GitBenchmarks
(although some, if not most of those benchmarks are dated,
and e.g. Bazaar claims to have much better performance now).

es>
es> Two:  Maybe Git is fast because Linus Torvalds is so smart.

[non answer; the details are important]

es> Three: Maybe Git is fast because it's written in C instead of one
es> of those newfangled higher-level languages.
es>
es> Nah, probably not.  Lots of people have written fast software in
es> C#, Java or Python.
es>
es> And lots of people have written really slow software in
es> traditional native languages like C/C++. [...]

Well, I guess that access to low-level optimization techniques like
mmap are important for performance.  But here I am guessing and
speculating like Eric did; well, I am asking on a proper forum ;-)

We have some anegdotical evidence supporting this possibility (which
Eric dismisses), namely the fact that pure-Python Bazaar is slowest of
three most common open source DVCS (Git, Mercurial, bazaar) and the
fact that parts of Mercurial were written in C for better performance.

We can also compare implementations of Git in other, higher level
languages, with reference implementation in C (and shell scripts, and
Perl ;-)).  For example most complete I think but still not fully
complete Java implementation: JGit.  I hope that JGit developers can
tell us whether using higher level language affects performance, how
much, and what features of higher-level language are causing decrease
in performance.  Of course we have to take into account the
possibility that JGit isn't simply as well optimized because of less
manpower.

es>
es> Four: Maybe Git is fast because being fast is the primary goal for
es> Git.

[non answer; the details are important]

es>
es> Five:  Maybe Git is fast because it does less.
es>
es> One of my favorite recent blog entries is this piece[1] which
es> claims that the way to make code faster is to have it do less.
es>
es> [1] "How to write fast code" by Kas Thomas
es>     http://asserttrue.blogspot.com/2009/03/how-to-write-fast-code.html
[...]

es>
es> For example, the way you get something in the Git index is you use
es> the "git add" command.  Git doesn't scan your working copy for
es> changed files unless you explicitly tell it to.  This can be a
es> pretty big performance win for huge trees.  Even when you use the
es> "remember the timestamp" trick, detecting modified files in a
es> really big tree can take a noticeable amount of time.

That of course depends on how you compare performance of different
version control systems (to not compare apples with oranges).  But if
you compare e.g. "<scm> commit" with Git equivalent "git commit -a"
the above is simply not true.

BTW. when doing comparison you have to take care of the reverse,
e.g. git doing more like calculating and dislaying diffstat by default
for merges/pulls.

es>
es> Or maybe Git's shortcut for handling renames is faster than doing
es> them more correctly[2] like Bazaar does.
es>
es> [2] "Renaming is the killer app of distributed version control"
es>     http://www.markshuttleworth.com/archives/123

Errr... what?


es> Six:  Maybe Git is fast because it doesn't use much external code.
es>
es> Very often, when you are facing a decision to use somebody else's
es> code or write it yourself, there is a performance tradeoff.  Not
es> always, but often.  Maybe the third party code is just slower than
es> the code you could write yourself if you had time to do it.  Or
es> maybe there is an impedance mismatch between the API of the
es> external library and your own architecture.
es>
es> This can happen even when the library is very high quality.  For
es> example, consider libcurl.  This is a great library.  Tons of
es> people use it.  But it does have one problem that will cause
es> performance problems for some users: When using libcurl to fetch
es> an object, it wants to own the buffer.  In some situations, this
es> can end up forcing you to use extra memcpys or temporary files.
es> The reason all the low level calls like send() and recv() allow
es> the caller to own the loop and the buffer is because this is the
es> best way to avoid the need to make extra copies of the data on
es> disk or in memory.
[...]

es>
es> Maybe Git is fast because every time they faced one of these "buy
es> vs. build" choices, they decided to just write it themselves.

I don't think so.  Rather the opposite is true.  Git uses libcurl for
HTTP transport.  Git uses zlib for compression.  Git uses SHA-1 from
OpenSSL or from Mozilla.  Git uses (modified, internal) LibXDiff for
(binary) deltaifying, for diffs and for merges.

OTOH Git includes several own micro-libraries: parseopt, strbuf,
ALLOC_GROW, etc.  NIH syndrome?  I don't think so; rather avoiding
extra dependencies (bstring vs strbuf), and existing solutions not
fitting all needs (popt/argp/getopt vs parse-options).

es> Seven:  Maybe Git isn't really that fast.
es>
es> If there is one thing I've learned about version control it's that
es> everybody's situation is different.  It is quite likely that Git
es> is a lot faster for some scenarios than it is for others.
es>
es> How does Git handle really large trees?  Git was designed primary
es> to support the efforts of the Linux kernel developers.  A lot of
es> people think the Linux kernel is a large tree, but it's really
es> not.  Many enterprise configuration management repositories are
es> FAR bigger than the Linux kernel.

c.f. "Why Perforce is more scalable than Git" by Steve Hanov
     http://gandolf.homelinux.org/blog/index.php?id=50

I don't really know about this.

But there is one issue Eric Sink didn't think about:

Eight: Git seems fast.
======================

Here I mean concentaring on low _latency_, which means that when git
produces more than one page of output (for example "git log"), it tries to output the first page as fast as possible; which means that first page e.g.
"git <sth> | head -25  >/dev/null" has to be fast, and not 
"git <sth> >/dev/null" itself.

Having progress indicator appearing whenever is longer wait (quite
fresh feature) also help impression of being fast...


And what do you think about this?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
