From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 14 May 2009 10:24:15 +0200
Message-ID: <200905141024.17525.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 14 10:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4WFW-0000mc-IZ
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 10:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188AbZENIYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 04:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbZENIYh
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 04:24:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:7109 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbZENIYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 04:24:35 -0400
Received: by rv-out-0506.google.com with SMTP id f9so673926rvb.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dTLud9bphK37lDCPUB6/Q/0NT9AlftG4PVKu673+Gb8=;
        b=UJxz8y8gBZN1NfV+4OmRsJr8qM3JWiI6ZLDn73CHuj6E0RNbNBdZclKA1aA3VExnWY
         8HHDVylWbWYacCjdOTCldFQx75ceG+suYaQelIFaNpgOZF/TYnzIjLcUgztU9scVDv0M
         OaofQAJcbN6Mvc+jTaSsoBFonjwJK1BBf/nW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ij2vqVWXLucgIjD5MyZ1jkcOs54LI6s3Taz3Iju4+VD+a0ZawlL5ISvfQKVJrR3dxh
         okY1r5fgWGUyeJquxg8886p1t59U2qHSYYiHy6s2Hjj5ckakaZsq7HZ9tXJbqu3Yjptr
         A0KENemo9kbLcvX6ZnXpBKoDuhB4qNc3j/BGM=
Received: by 10.141.211.5 with SMTP id n5mr685529rvq.106.1242289476267;
        Thu, 14 May 2009 01:24:36 -0700 (PDT)
Received: from ?192.168.1.13? (abvo12.neoplus.adsl.tpnet.pl [83.8.212.12])
        by mx.google.com with ESMTPS id f21sm2705741rvb.15.2009.05.14.01.24.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 01:24:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090512233450.GY30527@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119169>

On Wed, 13 May 2009 Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

> > We have now proliferation of different (re)implementations of git:
> > JGit in Java, Dulwich in Python, Grit in Ruby; and there are other
> > planned: git# / managed git in C# (GSoC Mono project), ObjectiveGit
> > in Objective-C (for iPhone IIRC).  At some time they would reach
> > the point (or reached it already) of implementing git-daemon...
> > but currently the documentation of git protocol is lacking.
> 
> Well, lets see...
> 
> JGit - me and Robin, here on git ML.  JGit is the closest
> reimplementation effort to the canonical C implementation.
> JGit runs in production servers for many folks, e.g. quite
> a few Google engineers use the JGit server every day.  Its
> our main git daemon.
> 
> Grit - GitHub folks.  They know where to find us.  And their
> business is Git.  If Grit isn't right, they'll make it right,
> or possibly suffer a loss of customers.  I'm fairly certain
> that GitHub runs Grit in production.
> 
> ObjectGit - Scott Chacon, again, a GitHub folk.  Though he has
> expressed interest in moving to JGit or libgit2 where/when possible.
> 
> Dulwich - off in its own world and not even trying to match basic
> protocol rules by just watching what happens when you telnet to a
> git port.  No clue how that's going to fair.
> 
> git# - We'll see.  Mono GSoC Git projects have a really bad
> reputation of ignoring the existing git knowledge and hoping
> they can invent the wheel on their own.

So you are saying that even if detailed pack protocol specification
isn't written down (Documentation/technical/pack-protocol.txt is more
of a sketch than reference documentation), the knowledge is there,
and it is not that hard to get (just ask on git mailing list), isn't it?
 
> > This can lead, as you can read from recent post on git mailing, to
> > implementing details wrong (like Dulwich not using full SHA-1 where
> > it should, leading to ordinary git clients to failing to fetch from it),
> > or fail at best practices of implementation (like JGit last issue with
> > deadlocking for multi_ack extension).
> 
> Dulwich is just busted.

That was my impression too. Those details it got wrong aren't so
obscure and hard to get right...

> 
> No existing developers knew that the fetch-pack/upload-pack protocol
> has this required implicit buffering consideration until JGit
> deadlocked over it.  But even then I'm still not 100% sure this
> is true, or if it is just an artifact of the JGit upload-pack side
> implementation being partially wrong.

Well... I guess that section on Best Current Practices to avoid 
deadlocking would not be there to avoid this issue in JGit, but
would be added for the future later.

> 
> > The current documentation of git protocol is very sparse; the docs
> > in Documentation/technical/pack-protocol.txt offer only a sketch of
> > exchange.  You can find more, including pkt-line format, a way sideband
> > is multiplexed, and how capabilities are negotiated between server and
> > client in design document for "smart" HTTP server, for example in
> >   Subject: Re: More on git over HTTP POST
> >   Message-ID: <20080803025602.GB27465@spearce.org>
> >   URL: http://thread.gmane.org/gmane.comp.version-control.git/91104/focus=91196
> 
> Seriously?  Don't link to that.  Its a horrible version of the smart
> HTTP RFC, and worse, it doesn't describe what you say it describes.

Ooops, I am sorry. This was my bookmark into this thread (which is very
interesting, and contain host of otherwise unknown to me information
about pack protocol), but the post in this thread was quite arbitrary
(a random post where I decided that this thread is interesting enough
to bookmark, and long enough to not want to save all interesting posts).

>  
> > It would be really nice, I think, to have RFC for git pack protocol.
> > And it would help avoid incompatibilities between different clients
> > and servers.  If the document would contain expected behaviour of
> > client and server and Best Current Practices it would help avoid
> > pitfals when implementing git-daemon in other implementation.
> 
> Yea, it would be nice.  But find me someone who knows the protocol
> and who has the time to document the #!@* thing.  Maybe I'll try
> to work on this myself, but I'm strapped for time, especially over
> the next two-to-three months.

I was afraid of this: that the people who know pack protocol good
enough to be able to write it down are otherwise busy. But we get
detailed / updated packfile and pack index format descriptions some
time ago (thanks all that contributed to it!). I hope that the same
would happen with pack _protocol_ description.

I was hoping of document in RFC format; dreaming about having it
submitted to IETF as (at least) unofficial RFC like Atom Publication
Protocol (or is it proper RFC these days?), and then accepted like
HTTP protocol. But I understand that it is not the same situation;
there wouldn't (and perhaps shouldn't) too many independent git-daemon
implementations...

> 
> And lets not even start to mention Dulwich not completing a thin
> pack before storing it on disk.  Those sorts of on disk things
> matter to other more popular Git implementations (c git, jgit).

Ugh! Errr... aren't thin packs send only if other side has the
capability for it? What is then Dulwich doing announcing such 
capability when not supporting it correctly...

-- 
Jakub Narebski
Poland
