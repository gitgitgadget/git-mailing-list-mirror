From: Scott Chacon <schacon@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 14 May 2009 06:55:39 -0700
Message-ID: <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com>
References: <200905122329.15379.jnareb@gmail.com>
	 <20090512233450.GY30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 14 15:55:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4bPc-0003El-Aq
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 15:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbZENNzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 09:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZENNzj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 09:55:39 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:63981 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbZENNzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 09:55:38 -0400
Received: by yx-out-2324.google.com with SMTP id 3so722087yxj.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PI6Ccg1hMPvzNnMJ9WMjB9dgpsqnb3XowPemn8mPmIk=;
        b=IhNDz49ZG++Ou/HKPgDfsf2Cyqu1Qn7hhHMZelCY+IlJrwKp4z5eFZT8WWfpHTUXwC
         Jdp4U+LxAcPoO3Nm0kUMcv2u+VCnHZr3f5PTit2IkCLAlD2ZKGO5q5qeSC+aISEcAYYP
         WxRgM7Iqk9uEYb2yKAZiiHRKZL1lo3hlQat+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wRJe7ZcSxCHIIVQK8vQGu3COYnd+B54XY4qtQfUkX/7yf7DwJXM2GDfCmHH8IJPBZ8
         3TZYMSxFN2+Gol0R4deIf0tIzfxnOi3uv5m3RrZNnonlBbbv6d8LkJNRihCQv0mLhe3D
         ulYg0XM3qP4KbkzqZB5b7PAb/kCHnrVmdLEL0=
Received: by 10.100.214.10 with SMTP id m10mr3171523ang.41.1242309339091; Thu, 
	14 May 2009 06:55:39 -0700 (PDT)
In-Reply-To: <20090512233450.GY30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119193>

Hey,

On Tue, May 12, 2009 at 4:34 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> We have now proliferation of different (re)implementations of git:
>> JGit in Java, Dulwich in Python, Grit in Ruby; and there are other
>> planned: git# / managed git in C# (GSoC Mono project), ObjectiveGit
>> in Objective-C (for iPhone IIRC). =C2=A0At some time they would reac=
h
>> the point (or reached it already) of implementing git-daemon...
>> but currently the documentation of git protocol is lacking.
>
> Well, lets see...
>
> JGit - me and Robin, here on git ML. =C2=A0JGit is the closest
> reimplementation effort to the canonical C implementation.
> JGit runs in production servers for many folks, e.g. quite
> a few Google engineers use the JGit server every day. =C2=A0Its
> our main git daemon.
>
> Grit - GitHub folks. =C2=A0They know where to find us. =C2=A0And thei=
r
> business is Git. =C2=A0If Grit isn't right, they'll make it right,
> or possibly suffer a loss of customers. =C2=A0I'm fairly certain
> that GitHub runs Grit in production.
>
> ObjectGit - Scott Chacon, again, a GitHub folk. =C2=A0Though he has
> expressed interest in moving to JGit or libgit2 where/when possible.

Actually, all of this work has moved to CocoaGit, which is much
farther along than ObjectiveGit ever was.  Although I would love to
use libgit2 when it gets that far, this was for Mac/iPhone native
client work which JGit would not be helpful for.

>
> Dulwich - off in its own world and not even trying to match basic
> protocol rules by just watching what happens when you telnet to a
> git port. =C2=A0No clue how that's going to fair.

Oddly enough, I'm in Dulwich land too. I've been working on a
Mercurial plugin that will provide a two way lossless bridge for Hg to
be able to push and pull to/from a Git server.  I've fixed some of the
issues I've found with the client side work and both pushes and pulls
will work now. (I did turn off 'thin-pack' capability announcement,
since you're correct that it simply was not properly implemented).

If we're going to round out the list, I've also worked on an
ActionScript partial implementation, but it never got to the packfile
level, and some of the Erlang guys are interested in writing at least
a partial Erlang implementation too, which I may get involved in at
some point.

It seems like if anyone would do what you're asking, it's probably me.
In the next few weeks, I do what I can to fix up the remainder of the
Dulwich code as part of my hg-git work.  I'm also working with Shawn
on the Apress book, where I was going to try to document much of this
information, perhaps I could try writing an RFC as an appendix or
something - then that will force him to spend time correcting
everything I got wrong :)  At least that might be a good starting
point - I'm unfamiliar with the actual RFC process, so I'll research
that a bit today.  I don't mind writing it, I think it would be really
really useful to have, I just am unfamiliar with the process.

Thanks,
Scott


>
> git# - We'll see. =C2=A0Mono GSoC Git projects have a really bad
> reputation of ignoring the existing git knowledge and hoping
> they can invent the wheel on their own.
>
>> This can lead, as you can read from recent post on git mailing, to
>> implementing details wrong (like Dulwich not using full SHA-1 where
>> it should, leading to ordinary git clients to failing to fetch from =
it),
>> or fail at best practices of implementation (like JGit last issue wi=
th
>> deadlocking for multi_ack extension).
>
> Dulwich is just busted.
>
> No existing developers knew that the fetch-pack/upload-pack protocol
> has this required implicit buffering consideration until JGit
> deadlocked over it. =C2=A0But even then I'm still not 100% sure this
> is true, or if it is just an artifact of the JGit upload-pack side
> implementation being partially wrong.
>
>> The current documentation of git protocol is very sparse; the docs
>> in Documentation/technical/pack-protocol.txt offer only a sketch of
>> exchange. =C2=A0You can find more, including pkt-line format, a way =
sideband
>> is multiplexed, and how capabilities are negotiated between server a=
nd
>> client in design document for "smart" HTTP server, for example in
>> =C2=A0 Subject: Re: More on git over HTTP POST
>> =C2=A0 Message-ID: <20080803025602.GB27465@spearce.org>
>> =C2=A0 URL: http://thread.gmane.org/gmane.comp.version-control.git/9=
1104/focus=3D91196
>
> Seriously? =C2=A0Don't link to that. =C2=A0Its a horrible version of =
the smart
> HTTP RFC, and worse, it doesn't describe what you say it describes.
>
>> It would be really nice, I think, to have RFC for git pack protocol.
>> And it would help avoid incompatibilities between different clients
>> and servers. =C2=A0If the document would contain expected behaviour =
of
>> client and server and Best Current Practices it would help avoid
>> pitfals when implementing git-daemon in other implementation.
>
> Yea, it would be nice. =C2=A0But find me someone who knows the protoc=
ol
> and who has the time to document the #!@* thing. =C2=A0Maybe I'll try
> to work on this myself, but I'm strapped for time, especially over
> the next two-to-three months.
>
> And lets not even start to mention Dulwich not completing a thin
> pack before storing it on disk. =C2=A0Those sorts of on disk things
> matter to other more popular Git implementations (c git, jgit).
>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
