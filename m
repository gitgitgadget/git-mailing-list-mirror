From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 02:22:45 +1000
Message-ID: <2cfc4032050510092238259b63@mail.gmail.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <1115739511.16187.432.camel@hades.cambridge.redhat.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 18:16:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVXOQ-0008EO-7X
	for gcvg-git@gmane.org; Tue, 10 May 2005 18:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVEJQWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 12:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVEJQWy
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 12:22:54 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:51360 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261704AbVEJQWr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 12:22:47 -0400
Received: by rproxy.gmail.com with SMTP id j1so885387rnf
        for <git@vger.kernel.org>; Tue, 10 May 2005 09:22:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bl+ebaIXa/Ov9ZTbUBrhkbPVw17yCikr8K528cs5QOSHcTlryBgba59dJaxhUQZA5wy8Q0cFFVlsODYKOd7vajT76ZWx0BBdY2GAr7/l5dSUlSpvjthjkLCWTDDSTwERkisTXmxS8CU+2Qss8kT+wC/lHb71B+LvTFn55f7ZadU=
Received: by 10.38.88.80 with SMTP id l80mr2117355rnb;
        Tue, 10 May 2005 09:22:45 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Tue, 10 May 2005 09:22:45 -0700 (PDT)
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115739511.16187.432.camel@hades.cambridge.redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/11/05, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2005-05-11 at 01:00 +1000, Jon Seymour wrote:
> > I have been experimenting with pure-Java implementation of GIT
> > concepts with a goal of eventually providing plugins to Eclipse to
> > allow the Eclipse GUI to interact with GIT repositories.
> 
> It's not April 1st. Why would you want to reimplement it in Java instead
> of just using the existing implementation? Is this a religious issue?
> 

Not really - in the Java world, things are simpler if you don't have
to carry around a JNI library - that way, you can just run it wherever
a Java interpreter exists and not worry about
having someone recompiling the JNI part. 

A pure-Java implementation will perform better than a
Java-invokes-C-executable approach [ though not, of course, a C-only
approach ].

Another benefit of playing around with a Java abstraction is that I
can more easily experiment with abstractions than I can in C since the
abstraction-facilities of Java more directly support such playing than
does C. So, for example, I can easily create a virtual repository
which layers a local repository over a remote repository and
transparently populates the local repository from the remote
repository "on-demand". Of course, this sort of thing can be done in
C, but it requires much more "work" to set up the abstractions.

You could perhaps argue that the existing 'C' tools in some way
encapsulate access  to the repository format. Maybe, but the fact is
the rapid adoption of GIT has already effectively fixed the GIT
repository format in practice so any change in repository format will
require considerable planning anyway - planning that will allow
sufficient time for implementations in other languages to catch up.

So, no, it's not a religious issue. If anything, it is being dogmatic
to insist that the sacred GIT repository structure only be manipulated
by 'C' tools blessed by the hands of Linus.

The concepts in GIT are bigger than the programming language its
toolsets are implemented in.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
