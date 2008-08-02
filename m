From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Sat, 2 Aug 2008 14:51:28 +0200
Message-ID: <3687C337-63B7-4F3E-9682-8B140FFB4D53@orakel.ntnu.no>
References: <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <20080729134619.GB7008@dpotapov.dyndns.org> <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no> <20080730214521.GC7008@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 14:52:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPGb7-0005CU-6G
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 14:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbYHBMvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 08:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbYHBMvd
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 08:51:33 -0400
Received: from eyvind.bernhardsens.net ([84.49.228.97]:62610 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYHBMvc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 08:51:32 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 8D77A1B5B40;
	Sat,  2 Aug 2008 14:51:29 +0200 (CEST)
In-Reply-To: <20080730214521.GC7008@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91145>

On 30. juli. 2008, at 23.45, Dmitry Potapov wrote:

> On Tue, Jul 29, 2008 at 11:17:23PM +0200, Eyvind Bernhardsen wrote:
>>
>> My point was that autocrlf penalises Windows users just as much as it
>> does Linux users, so why should it be turned on by default on
>> Windows?
>
> Because it does make sense on Windows (I mentioned some reasons for  
> that
> in my previous email), and it does NOT make any sense on Linux unless
> you copy files from Windows.

It doesn't make any more sense on Windows than it does on Linux,  
unless the user is careless about CRLFs and the repository will be  
shared with Linux users. If you have to work with undisciplined  
Windows users but don't actually use Windows yourself, it might _seem_  
to make sense, but that is an illusion.

>>> And the main argument for having that in this way is that people
>>> with LF
>>> text files should be unnecessary penalized for Windows being
>>> different.
>>
>> I know, but my point is that I don't like to be unnecessarily
>> penalised any more when I am using Windows than when I'm using Linux
>> or OS X.
>
> It seems you still have not realized that from the very day when you
> started to use Windows, you are penalized for that day-in, day-out.
> Let's take something simple. For instance, the hello-world program:
> cat <<=== > hello.c
> #include <stdio.h>
> int main() {
> 	printf ("Hello world!\n");
> 	return 0;
> }
> ===
>
> You can compile it on Linux and Windows (using Microsoft Visual C).
> Now, if you run it on Linux, it will print 13 symbols (exactly
> as many as there are symbols in the printf string) while on Windows
> you will get 14 bytes. It means that printf and as many other C
> function on Windows does conversion and penalize you already!

But I don't use printf to store files.  What does printf have to do  
with anything?

Btw, I'm not actually a "natural" Windows user; I have a Mac on my  
desktop, and I prefer Linux to Windows on my own PCs.  I often use  
Windows at work, though, and I'm trying to make Git work as well as  
possible when I do.

>> I would like the default to be "no conversion", and for
>> conversion to be enabled not based on platform, but as a policy
>> decision on the repositories where it actually matters.
>
> If Microsoft C library did not do any conversion, I suspect we would
> have this CRLF conversion at all!

Surely, but unfortunately, I don't live in happy fairy land.

>> You can have anything you like in _your_ repository, of course, but  
>> if
>> you're not publishing it anywhere, who cares what your line endings
>> are?  Your line endings only matter when you publish.
>
> You can publish only what you have. So, it must decided before.

Yes!  Someone should decide that the repository should only have LFs  
in it, then flag it as such so that Git can respect that decision.

>> That's why I
>> want a setting that is propagated: so that when you clone a  
>> repository
>> with a LF-only policy, Git knows what to do.
>
> LF-only policy is the only sane policy for any text files. It has  
> nothing
> to do with clone.

Gah!  So close, but so far.  What about a repository which already has  
CRLFs in it?  You're telling me that it shouldn't have CRLFs in it,  
which is almost entirely unhelpful.

>> I think the real penalty is that with autocrlf enabled, Git no longer
>> stores exactly what I committed.
>
> And what is wrong with that? In any case, Git deltifies and compress
> your files. Why does it not bother you? So, what matters here is
> whether you are able to get back exactly what you put or not. That's
> why Git has this safecrlf option! Of course, it is guarantee to get
> exactly the same back only if you have the same autocrlf setting,
> but if you have different autocrlf settings, it means that you want
> *different* representation of text files!

My point is that if I commit two files with different line endings, I  
want Git to store them that way.  Works on Linux by default, doesn't  
work on Windows by default.  Deltification and compression are  
irrelevant since they don't change the content.  autocrlf does.

You only want to normalise text files if you (a) have undisciplined  
committers, and (b) need to share the repository between Windows and  
Unix.  Right now, the default configuration of Git assumes that all  
Windows users are undisciplined, and that they will always be sharing  
repositories with Unix users.

>>> Of course, those who are very careful and have good editors can set
>>> autocrlf=false even on Windows...
>>
>> Right, or who know that the repository they're using will only be
>> shared with other Windows users.
>
> WRONG! Using storing CRLF in text files is a completely idiotic idea.
> Those who do so asked for troubles, so they should not complain!

But some text files need CRLFs, the autocrlf mechanism even caters for  
them.  And it's not like the extra CR actually hurts anything; I use  
Git on Windows with "autocrlf=false", and I've yet to see any problems  
with it.  The reason I've changed from the default "autocrlf=true" is  
that I've seen plenty of problems with that.

>> Internally, Git doesn't really care, does it?
>
> It DOES!!! Such things like merges and diffs and many other every day
> commands do care about end-of-lines and the ONLY end-of-line they
> recognize is '\n'. In fact, there are more than 400 places in Git  
> where
> '\n' is used. Of course, not all of them may be qualified as internals
> but many of them do.

Buh?  That's crazy talk.  The only time CRLFs cause trouble with git  
is when autocrlf is enabled.  Try this:


git init
echo -n "testing\r\ntesting 2\r\n" > testing
git add testing
git commit
git config --bool --add core.autocrlf true
touch testing
git diff


File with CRLF in the repository, file with CRLF in the working  
directory, so where does the difference come from?  The same thing  
happens with "autocrlf=input", and the problem is obviously a lot  
bigger when you're trying to merge.

Now I've shown you when autocrlf is a problem, you show me a case  
where CRLFs cause trouble with autocrlf=false.

> So, as long as Git internally consider only LF as the end-of-line.

Bah.  To the extent it "cares", Git just sees CR as an extra white  
space character before the end-of-line LF, and you know it.

>> Heh.  Where I work, we hacked CVS for Windows to get away from that
>> behaviour :)
>
> Maybe, you used Cygwin version of CVS, which had LF, but those Windows
> versions of CVS I used produced CRLF on Windows.

No, we just compiled our own, precisely because we didn't want CVS to  
mangle our data, even on Windows.  The CVS repositories are used by  
Linux and Windows clients, and some developers had their working  
directories on cross-platform network shares, so eol conversion just  
caused unnecessary problems.

>> Well, what I want is to be able to say "it is necessary to do eol
>> conversion in this repository",
>
> You always can do that in _your_ repository:
> git config core.autocrlf ...

I can, except that (a) any CRLFs already in the repository will cause  
trouble, and (b) everyone who clones from me has to make the same  
setting manually, or they won't follow the same convention.

>> allowing the default to be "don't do
>> eol conversion" on Windows, too.  For a setting like that to be
>> useful, it has to be propagated when the repository is cloned.
>
> Why? Other people may have other preferences.

Yes.  Other people may have other preferences which will lead them to  
push CRLFs to my repository.  That is why the setting should be  
propagated.

>> I want it to be versioned because you might want to change it without
>> messing with the content that's already in the repository.  This is
>> actually my main motivation, since I have lots of CRLF-infused CVS
>> history to deal with.
>
> Well, you can try to use .gitattributes, but I believe it would be far
> more reasonable to clean this mess with line-ending than finding a
> way to continue insanity with different ending in different text  
> files.

But I'd rather not change the historical data in every repository.  So  
yes, I think it's a good idea to clean up the line endings, but I  
would like to do it in a way that allows me to check out an old  
version with mixed line endings while still ensuring that newly  
committed files are normalised.

>> It should apply on Linux as well as Windows because there is always
>> the chance that a user will manage to commit a CRLF on Linux (a
>> colleague of mine once complained that CVS on Linux doesn't do eol
>> conversion; he edited files on Windows, but checked them in on
>> Linux).
>
> For those who need it, Git provides autocrlf=input. But the question
> here is what should be default. I don't think that those who copies
> files directly from Windows to Linux are majority. OTOH, I don't
> mind autocrlf=input as default. If it can be turned off, it is fine
> with me :)

Yeah, if autocrlf is set, it probably makes sense to use it, i.e.  
anyone who doesn't want line ending conversion at all can set  
"autocrlf=false".

>> It would probably be okay to have a setting that turns all
>> conversion off, but wouldn't that be kind of rude?
>
> How so?

You're explicitly saying "I don't care if I commit CRLFs into a  
repository that requests only LFs".  So you're probably only saying it  
because you know you won't commit CRLFs anyway, but since the cost is  
so low, why not make sure?
-- 
Eyvind Bernhardsen
