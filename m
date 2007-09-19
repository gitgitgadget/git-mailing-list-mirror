From: "Steven Burns" <royalstream@hotmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Wed, 19 Sep 2007 13:56:51 -0600
Message-ID: <fcrutu$16f$1@sea.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se>  <1189004090.20311.12.camel@hinata.boston.redhat.com>  <vpq642pkoln.fsf@bauges.imag.fr>  <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>  <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 00:30:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY83k-0000Xm-Hi
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 00:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbXISWaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 18:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbXISWaL
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 18:30:11 -0400
Received: from main.gmane.org ([80.91.229.2]:32993 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbXISWaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 18:30:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IY83X-0007cY-0u
	for git@vger.kernel.org; Thu, 20 Sep 2007 00:30:03 +0200
Received: from 200.9.63.21 ([200.9.63.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 00:30:03 +0200
Received: from royalstream by 200.9.63.21 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 00:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.9.63.21
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.3138
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3138
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 6.3 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.1 FORGED_HOTMAIL_RCVD2 hotmail.com 'From' address, but no 'Received:'
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58739>

To me, the only thing that C++ has that all other mentioned languages lack 
is the power you get from the templates and generic programming.
Sorting will always be faster if you can call the comparison function 
directly without using a function pointer, and the only way you can create a 
generic sorting algorithm is that way.

Thinking about it with a cold head, most things to hate about C++ are not in 
the language but in its libraries.
The only feature I hate from the language itself is the preprocessor 
(macros), which you get in C too.

And maybe I also hate the fact that C++ allows for unexperienced programmers 
to create a bunch of classes and hierarchies that make sense to nobody but 
them. Or even worse, unexperienced programmers start writing their own 
frameworks, wrapping and re-wrapping, the same good old C function one 
thousand times.

I guess that is why most C++ based projects out there have a strict list of 
rules and conventions, you cannot have a stable project without them.

But, nothing prevents anybody from programming in C++ the way you describe, 
using simple and clear core structures with some basic methods that 
complement them (not obscure them) and make it easier to write the 
algorithms.
Sadly, once you start using std::string, their overly complicated and fancy 
iostreams, and bulky classes that hide too much from you, I have no other 
choice than to agree and call the whole thing a mess.

Steven Burns


"Linus Torvalds" <torvalds@linux-foundation.org> wrote in message 
news:alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org...
>
>
> On Fri, 7 Sep 2007, Linus Torvalds wrote:
>>
>> The fact is, git is better than the other SCM's. And good taste (and C) 
>> is
>> one of the reasons for that.
>
> To be very specific:
> - simple and clear core datastructures, with *very* lean and aggressive
>   code to manage them that takes the whole approach of "simplicity over
>   fancy" to the extreme.
> - a willingness to not abstract away the data structures and algorithms,
>   because those are the *whole*point* of core git.
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
> Linus 
