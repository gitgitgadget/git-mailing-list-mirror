From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Sun, 3 Aug 2008 20:21:33 +0400
Message-ID: <20080803162133.GO7008@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <20080729134619.GB7008@dpotapov.dyndns.org> <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no> <20080730214521.GC7008@dpotapov.dyndns.org> <3687C337-63B7-4F3E-9682-8B140FFB4D53@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sun Aug 03 18:23:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPgMv-0004Jx-He
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 18:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364AbYHCQVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756354AbYHCQVm
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 12:21:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:42092 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbYHCQVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 12:21:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so840257fgg.17
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=STq/1kWE14MlzMj0f5dMej+qb+UrmwzOVi/wx1pfKKA=;
        b=Gy1x7rZqTSnojAjlhpbP50xZejjzwWP2Ve8zggejhZmJiNOfSE1prMwo8UIn0iefE8
         GutnQY/5i8AcOnXkPouL2Ct4D9y8m2aMejA+ghfi7PzWnm8taG4dlpynhBc4mtmuokvK
         e339N8125j31WbdoARAVSN4qtFcfh89uLEF9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bPQi9oe4LyZvQ3Jwu8+K+Tt21tJrXAA+akXNnbpruEtpDWikcmEEYxcbmNTsZbn/qA
         zXnpSQ9gzXfyraUIlzWHq5OICqiWf4Kr7OLRXZlLwB1oEo7u/PkGzrv7hwf7tIu3eqRM
         rzODgg3u1Wzv+J+K81HPPHsepoTFPk5AfQkWM=
Received: by 10.86.82.6 with SMTP id f6mr9516155fgb.73.1217780497682;
        Sun, 03 Aug 2008 09:21:37 -0700 (PDT)
Received: from localhost ( [85.141.191.110])
        by mx.google.com with ESMTPS id 4sm4425756fge.5.2008.08.03.09.21.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 09:21:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3687C337-63B7-4F3E-9682-8B140FFB4D53@orakel.ntnu.no>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91250>

On Sat, Aug 02, 2008 at 02:51:28PM +0200, Eyvind Bernhardsen wrote:
> On 30. juli. 2008, at 23.45, Dmitry Potapov wrote:
> 
> >On Tue, Jul 29, 2008 at 11:17:23PM +0200, Eyvind Bernhardsen wrote:
> >>
> >>My point was that autocrlf penalises Windows users just as much as it
> >>does Linux users, so why should it be turned on by default on
> >>Windows?
> >
> >Because it does make sense on Windows (I mentioned some reasons for  
> >that
> >in my previous email), and it does NOT make any sense on Linux unless
> >you copy files from Windows.
> 
> It doesn't make any more sense on Windows than it does on Linux,  
> unless the user is careless about CRLFs and the repository will be  
> shared with Linux users.

It does, because LF is the only EOL that Git recognize internally,
and if CRLF sometimes works, but it is an artifact. With the same
success you can rely on a value of uninitialized variable or any
other kind of undefined behavior.

> If you have to work with undisciplined  
> Windows users but don't actually use Windows yourself, it might _seem_  
> to make sense, but that is an illusion.

Illusion? Is the most logical objection that you capable to produce
to all my explanation? I think it is very convenient approach, but
shall we follow it a bit further and declare all your problem with
line endings just an illusion...

> >You can compile it on Linux and Windows (using Microsoft Visual C).
> >Now, if you run it on Linux, it will print 13 symbols (exactly
> >as many as there are symbols in the printf string) while on Windows
> >you will get 14 bytes. It means that printf and as many other C
> >function on Windows does conversion and penalize you already!
> 
> But I don't use printf to store files.  What does printf have to do  
> with anything?

You missed the point entirely, did you? LF is the standard EOL in C (as
well as in many other languages that is used by Git developers). Thus,
naturally Git internally considers only LF as the only true EOL, and if
it happened that you store files with different EOLs, they should be
converted during import to the Git repository. And, yes, C programs
do use printf and other C library functions to write text files...
Why do you think Microsoft C library does convert CRLF on reading and
writing for text files? Or that is another illusion?

> >>You can have anything you like in _your_ repository, of course, but  
> >>if
> >>you're not publishing it anywhere, who cares what your line endings
> >>are?  Your line endings only matter when you publish.
> >
> >You can publish only what you have. So, it must decided before.
> 
> Yes!  Someone should decide that the repository should only have LFs  
> in it, then flag it as such so that Git can respect that decision.

What is your point?! Git *does* respect your autocrlf choice. But it
also respects *other* people choice to have what they want in *their*
repositories.

> 
> >>That's why I
> >>want a setting that is propagated: so that when you clone a  
> >>repository
> >>with a LF-only policy, Git knows what to do.
> >
> >LF-only policy is the only sane policy for any text files. It has  
> >nothing
> >to do with clone.
> 
> Gah!  So close, but so far.  What about a repository which already has  
> CRLFs in it?  You're telling me that it shouldn't have CRLFs in it,  
> which is almost entirely unhelpful.

What I am saying is that having CRLF for text files is a mistake, and it
should be dealt as that. Perhaps, something can be added to help people
to deal with their past mistakes, but by no means, we should encourage
to produce more crap... So far, I have not heard any rational suggestion,
let alone seeing your code that implements it.

> 
> My point is that if I commit two files with different line endings, I  
> want Git to store them that way.

If you want something insane, you can have that, but the insane mode is
not for normal users. So, it should not be default.

> Works on Linux by default, doesn't  
> work on Windows by default.

So what? Sane people do NOT store text files with different endings,
especially on Linux...

> >>>Of course, those who are very careful and have good editors can set
> >>>autocrlf=false even on Windows...
> >>
> >>Right, or who know that the repository they're using will only be
> >>shared with other Windows users.
> >
> >WRONG! Using storing CRLF in text files is a completely idiotic idea.
> >Those who do so asked for troubles, so they should not complain!
> 
> But some text files need CRLFs, the autocrlf mechanism even caters for  
> them.  And it's not like the extra CR actually hurts anything; I use  
> Git on Windows with "autocrlf=false", and I've yet to see any problems  
> with it.  The reason I've changed from the default "autocrlf=true" is  
> that I've seen plenty of problems with that.

What problems? Isn't true that these problems were caused in the first
place by having autocrlf=false? If you prefer CRLF for your text files
what exactly is your problem with having crlf=true? Your old history?
But why should other users suffer because you have messed up file
endings in your repository?

Perhaps, it would be nicer if Git saved autocrlf when created a new
repository, so if the global setting is changed, it will not affect
already existing repositories. I believe something like that can be
added. In fact, Junio mentioned about this possibility before, but
you do not seem to care to do _anything_ to improve the situation,
and when I say to do something, I don't mean just empty flame.

> 
> >>Internally, Git doesn't really care, does it?
> >
> >It DOES!!! Such things like merges and diffs and many other every day
> >commands do care about end-of-lines and the ONLY end-of-line they
> >recognize is '\n'. In fact, there are more than 400 places in Git  
> >where
> >'\n' is used. Of course, not all of them may be qualified as internals
> >but many of them do.
> 
> Buh?  That's crazy talk.  The only time CRLFs cause trouble with git  
> is when autocrlf is enabled.  Try this:
> 
> 
> git init
> echo -n "testing\r\ntesting 2\r\n" > testing
> git add testing
> git commit
> git config --bool --add core.autocrlf true
> touch testing
> git diff

That is *exactly* why autocrlf=true should be default on Windows, as you
want to have at the very moment when a new repository is created! Thanks!

And, yes, the file is shown changed. You can have the same effect with
SVN if you did not set svn:eol-style=native when added a file and then
change it to svn:eol-style=native later. The issue here is that you have
wrong ending for text files in the first place.

> >So, as long as Git internally consider only LF as the end-of-line.
> 
> Bah.  To the extent it "cares", Git just sees CR as an extra white  
> space character before the end-of-line LF, and you know it.

I know, and I also know that I don't like crap in my repository and
I don't like any tool that encourages users to put every crap in it.
And, no, I don't think that that check-in-all-crap-I-have should be
the default mode for Git. If you like that mode, you probably can set
autocrlf=false and also create some nice alias for git commit -a, so
you check-in all crap crap at once, but I can't care less about all
problems that you'll have after that.

> 
> >>Heh.  Where I work, we hacked CVS for Windows to get away from that
> >>behaviour :)
> >
> >Maybe, you used Cygwin version of CVS, which had LF, but those Windows
> >versions of CVS I used produced CRLF on Windows.
> 
> No, we just compiled our own, precisely because we didn't want CVS to  
> mangle our data, even on Windows.

*Shrug* All I can say I don't remember any problem like this with CVS,
and it did conversion automatically for us. Unfortunately, it converted
binary files too, so new users had to be taught about using 'cvs -kb'
or their binary files would be mutilated. So, I am pretty sure about
this. Perhaps, the difference was that we has always had our CVS server
on Linux, but we have not recompiled anything.

> The CVS repositories are used by  
> Linux and Windows clients, and some developers had their working  
> directories on cross-platform network shares, so eol conversion just  
> caused unnecessary problems.

Sharing working directories is a real issue. I hit it myself once with
CVS. Fortunately, git provides a good solution: autocrlf=input.

> 
> >>Well, what I want is to be able to say "it is necessary to do eol
> >>conversion in this repository",
> >
> >You always can do that in _your_ repository:
> >git config core.autocrlf ...
> 
> I can, except that (a) any CRLFs already in the repository will cause  
> trouble,

Sure, they will. It is insane ending to store in your repo. It was
exactly my point all way along, but somehow you missed that...

> and (b) everyone who clones from me has to make the same  
> setting manually, or they won't follow the same convention.

If people follow sane settings, they do not have to change anything
manually, and they can edit file using *their* preferable EOLs. However,
if you publish a repo with CRLF for text files, *you* create problems
for other people, and they have every right to blame you for that.

> 
> Yes.  Other people may have other preferences which will lead them to  
> push CRLFs to my repository.  That is why the setting should be  
> propagated.

Add the update hook, which will prevent pushes with the wrong ending.

> 
> >>I want it to be versioned because you might want to change it without
> >>messing with the content that's already in the repository.  This is
> >>actually my main motivation, since I have lots of CRLF-infused CVS
> >>history to deal with.
> >
> >Well, you can try to use .gitattributes, but I believe it would be far
> >more reasonable to clean this mess with line-ending than finding a
> >way to continue insanity with different ending in different text  
> >files.
> 
> But I'd rather not change the historical data in every repository.  So  
> yes, I think it's a good idea to clean up the line endings, but I  
> would like to do it in a way that allows me to check out an old  
> version with mixed line endings while still ensuring that newly  
> committed files are normalised.

Well, I don't see much historical value in seeing what files had
what ending and at what time. So, usually, it is a good idea to
clean up them when you convert your repo into Git. But as I said
above, you can try to use .gitattributes.

Anyway, autocrlf=true makes much more sense as default, because
newly created repositories and files in them will have the correct
ending.

> >>It would probably be okay to have a setting that turns all
> >>conversion off, but wouldn't that be kind of rude?
> >
> >How so?
> 
> You're explicitly saying "I don't care if I commit CRLFs into a  
> repository that requests only LFs".

Naw! autocrlf=false means you take responsibility for EOL in files that
you check in.  In fact, no version control system that can verify that
all what you check-in makes sense. So it can only _facilitate_ you in
creating good patches, but it cannot force you to do things in the right
way. Thus, any option that helps people to do their job is good, but you
cannot foresee all use cases, so it should be always choice to turn this
automatically thing off when it is necessary.

> So you're probably only saying it  
> because you know you won't commit CRLFs anyway, but since the cost is  
> so low, why not make sure?

Who are you to tell what cost is high and low? Why do you think that
you should dictate your idea of cost to *everyone*?


Dmitry
