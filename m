From: John 'Z-Bo' Zabroski <johnzabroski@yahoo.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sat, 8 Sep 2007 00:56:54 +0000 (UTC)
Message-ID: <loom.20070908T025508-792@post.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se>  <1189004090.20311.12.camel@hinata.boston.redhat.com>  <vpq642pkoln.fsf@bauges.imag.fr>  <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>  <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 03:02:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IToic-0001BW-GM
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 03:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbXIHBCd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 21:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbXIHBCd
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 21:02:33 -0400
Received: from main.gmane.org ([80.91.229.2]:60905 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbXIHBCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 21:02:32 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ITog6-0006zr-Op
	for git@vger.kernel.org; Sat, 08 Sep 2007 03:00:02 +0200
Received: from ool-18ba4c2d.dyn.optonline.net ([24.186.76.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 03:00:02 +0200
Received: from johnzabroski by ool-18ba4c2d.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 03:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.186.76.45 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58096>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:

> 
> And if you want a fancier language, C++ is absolutely the worst one to 
> choose. If you want real high-level, pick one that has true high-level 
> features like garbage collection or a good system integration, rather than 
> something that lacks both the sparseness and straightforwardness of C, 
> *and* doesn't even have the high-level bindings to important concepts. 
> 
> IOW, C++ is in that inconvenient spot where it doesn't help make things 
> simple enough to be truly usable for prototyping or simple GUI 
> programming, and yet isn't the lean system programming language that C is 
> that actively encourags you to use simple and direct constructs.
> 
> 				Linus
> 

I want code that is Correct, Explicit, Fast, and in that order.

I'm 23 years old and learned C++ when I was 13.  Back then, my compiler didn't
even support "bleeding edge" C++ language features like namespaces.  I'm not a
C++ expert, and I don't have the ego to call myself a superb programmer.  The
largest program I've written is 10K SLOC in C.  Yet, I'd like to participate in
this discussion, if that is OKay =)

I do think I am capable of an honest critique of the downside of C++:

_Problems_ _With_ _C++_

 *size*
    On my bookshelf, most recent editions of the canonical C++ _books_:
        Accelerated C++: Practical Programming by Example (336 pages)
        The C++ Standard Template Library: A Tutorial and Reference (832 pages)
        Effective C++: 50 Specific Ways to Improve Your Programs and Design (288
pages)
        More Effective C++: 35 New Ways to Improve Your Programs and Designs
(336 pages)
        Exceptional C++: 47 Engineering Puzzles, Programming Problems, and
Solutions (240 pages)
        More Exceptional C++: 40 New Engineering Puzzles, Programming Problems,
and Solutions (304 pages) 
        The C++ Programming Language (1030 pages)
        Modern C++ Design: Generic Programming and Design Patterns Applied (352
pages)
        C++ Templates: The Complete Guide (552 pages)

    Altogether, that is 3918 pages.  K&R, the canonical C _book_, is 272 pages.
 Becoming a C++ language lawyer is much harder than becoming a C language
lawyer.  Language lawyers know "how not to hang oneself" while programming in
the language.  I don't know how many of these titles are translated to other
languages, however, I am sure the *effort* required to translate all of them is
significant.  Open source is more successful if there is a lingua franca for
programming, and that is C.  Now, it may move away from C over time, but it will
*never* be C++ because it's encyclopedic.

 *hidden complexity*
    (1) it's hard to say what code will compile down to.  viz., constructors can
be elided, but there is no fitness warranty; profiling your compiler to find out
whether it is elided is tedious and "searching for secrets" that should be
_explicit_
    (2) people don't understand static polymorphism and compile-time dispatch;
people are used to objects sending messages dynamically (run-time dispatch)
    (3) coercion
    (4) networks of objects are not explicitly laid out, hiding quadratically
complex patterns of communication between objects
    (5) data structure and data flow come before algorithms.  Sometimes, data
structure dictates data flow (ad-hoc networks of objects); sometimes, data flow
dictates data structure (one of life's most disagreeable tasks - waiting in line
- is characterized as FIFO).  This, I feel, is the most important point, because
the first rule of programming is to figure out what you want to say before you
figure out how to say it.  In C++, ad-hoc networks of objects with cyclic
message paths are all too easy to create [see (4)] which means _code_ _is_ _not_
_explicit_ and as a result _code_ _is_ _not_ _fast_.

 *transfer semantics on objects are not robust*
    this ties into (1) in hidden complexity
    the code author needs to specify a lot of boilerplate to achieve desired
transfer semantics on objects.  Similarly, the code audience, be it reviewer,
maintainer or merger, needs to read a lot of boilerplate to understand how
objects get moved around in memory.  Moreover, most of these concepts are
intuitively declarative in nature, such as a parent object/child object relation.

 *poor re-use of effort*
    "code re-use" is a misnomer; when programmers speak of code-reuse they mean
re-use of effort.  There is no benefit to polymorphism if effort cannot be
consolidated easily.

 *C++ Standard iffy*
    Some things just disappear quickly for *frantic* reasons (strstream was
removed for aesthetics), indicating not enough foresight into what is important.
 I do not want to pick a language where I have to worry about features in it's
"standard library" becoming deprecated mainly for aesthetics.  As Dijkstra
preached, programming is _not_ supposed to be a frantic exercise.

 *usually, better options*
    See C++??: A Critique of C++ and Programing and Language Trends in the 1990s
 by Ian Joyner http://web.mac.com/joynerian/iWeb/Ian%20Joyner/CPPCritique.pdf
(Somewhat outdated, but many of the points are intrinsic and will forever be
relevant).  You can add to the list of better options D 1.0.
