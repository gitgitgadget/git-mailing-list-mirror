From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 10 Jun 2010 19:12:36 +0000 (UTC)
Message-ID: <loom.20100610T204637-685@post.gmane.org>
References: <46DDC500.5000606@etek.chalmers.se><1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 11 13:55:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON2pT-0005VT-KW
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 13:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab0FKLzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 07:55:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:46705 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab0FKLzL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 07:55:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ON2pE-0005Pj-31
	for git@vger.kernel.org; Fri, 11 Jun 2010 13:55:04 +0200
Received: from 94-192-117-31.zone6.bethere.co.uk ([94.192.117.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 13:55:04 +0200
Received: from ian.molton by 94-192-117-31.zone6.bethere.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 13:55:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.192.117.31 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100501 Iceweasel/3.5.9 (like Firefox/3.5.9))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148938>

Dmitry Kakurin <dmitry.kakurin <at> gmail.com> writes:

> 
> [ snip ]
> 
> When I first looked at Git source code two things struck me as odd:
> 1. Pure C as opposed to C++. No idea why. Please don't talk about 
> portability, it's BS.

Word to the wise... you effectively just told one of *the* best known
programmers of all time that they are talking BS... nice one. Hope you've got
some flameproof undies. Whats that? no? ah well...

I smell a troll, but since everyone else has had a go...

Heres some comments picked out from the thread, in no particular order...

> > You have a very strange way of not meaning to start a C vs. C++ war.

> I honestly didn't. I didn't even think it's possible. In the
> environment of mainstream commercial software development the last war
> on this subj was over 8-10 years ago.

Really? I dont know what planet you're from, but this 'war' has been raging for
decades, and will probably continue until one side or the other gets round to
using tactical nukes.

And besides, this *isn't* the commercial (closed) software world - we've moved
on. We no longer depend on closed companies handing out features like orphans in
the Victorian times...

>>> [bitfields in D]

>>   Really, I feel this is a big lack, for a language that aims at
>> simplicity, conciseness _and_ correctness.
>>
>>   OK, maybe I'm biased, I work with networks protocols all day long, so
>> I often need bitfields, but still, a lot of people deal with network
>> protocols, it's not a niche.
>
> And strictly speaking, C bitfields are completely useless for that
> purpose since the compiler is free to use whatever method he wants for
> allocating bit fields.  So if you want to write a portable program,
> you are back to making the masks yourself.

Sadly. Thats always been one of the things I found annoying in C. There are
times when you want access to the types the hardware itself uses, and there are
times when you want to know your int is 32 bits long, and there isnt really a
standardised way of doing that. Of course, its worked around in practice, but it
all seems so unnecessary.

> in the *real world* rewriting Git in assembly would be like  
> painting a house using a single horse hair instead of a paint brush  
> or roller. Your SHA-1 example is a perfect example of where you  
> benefit from doing a tiny embellished detail using the single hair  
> (assembly) and leave all the rest in C.

The above comment is pure epic win :-)

On another note, some people talked about code reuse...

IMHO Sourcecode reuse is something of a myth in any language. Sure, some small
algorithms get reused, but thats really not a language dependent characteristic.
As soon as you build something much bigger than an algorithm, it starts to need
an interface, and at that point you may as well turn it into a library. Thats
where the REAL code reuse happens. And as it happens at runtime, its good for
users - bugfixes help everyone.

On to language choice...

I have NEVER understood why people seem to think theres some kind of hierarchy
in either ease of coding or speed. You see it all the time, people think that:

assembler is faster than c is faster than c++ is faster than perl etc.

WHY? I've seen some truely braindamaged assembler that could be outperformed by
BASIC on a BBC micro. I've seen 'handcrafted' C and C++ that looked like it was
written during a skydive whilst on crack.

languages are *tools*. Pick the most appropriate. Use two. Embrace the power of
and...

Linux make good use of C and assembler, both compiled/assembled seperately and
inline. Some stuff like accessing weird registers with oddball opcodes is
actually impossible under C. But (say) write a filesystem in assembler? no
thanks! (not that it hasn't been done, but for the love of god, why?)

So, anyway, why do these kind of threads never go away? because opinions are
like arseholes. Everyones got one. As you grow older, you learn stuff. You
hopefully dont repeat the mistakes of ones youth. (theres at least one
ill-conceived C string library out there which I'm embarrased to admit is my
fault (hopefully it'll never leave the company I was at when I wrote it...).
These threads are where the n00bs meet the pros. Usually, the n00bs just need to
suck it up and admit it when they've been dumb. Its a very rare day when
something truely radical comes along, and its even rarer when its born of total
inexperience.

Nothing to see here...

All the best,

-Ian

PS. ironically, in order to post this, gmane required me to enter a word. That
word was "restraint". Gotta love karma.
