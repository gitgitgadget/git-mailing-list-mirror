From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 10:39:03 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
References: <20071029174000.GA4449@efreet.light.src>
 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
 <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
 <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
 <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
 <20071030160232.GB2640@hermes.priv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 18:40:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imv4e-0001Bl-FV
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 18:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbXJ3RkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 13:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbXJ3RkA
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 13:40:00 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60484 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752435AbXJ3Rj7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Oct 2007 13:39:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UHd4BS025887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 10:39:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9UHd3sJ019373;
	Tue, 30 Oct 2007 10:39:03 -0700
In-Reply-To: <20071030160232.GB2640@hermes.priv>
X-Spam-Status: No, hits=-2.433 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62688>



On Tue, 30 Oct 2007, Tom Prince wrote:
> >
> >  - <remote shorthand> ("origin")
> >  - <path> ("../git.git")
> >  - <host>:<path> ("master.kernel.org:/pub/scm/...")
> >  - <protocol>://<host>/<path> ("git://repo.or.cz/...")
> >
> > See? We may not follow RFC's, but we follow "easy to use".
>
> Well, only the last one actually looks like a URL, so that is the only this
> discussion is about.

NO.

The thing is, we'd be much better off being consistent with OURSELVES than
with something else!

Nobody cares about git being consistent with a web browser. There is
nothing in common.

But I *do* care about git being consistent with itself. If I do

	git clone /some/directory

and then decide that I want to generate a new pack and change it into

	git clone file:///some/directory

I don't want to have to re-write the thing to quote differently!

The same very much goes for a path like

	git://git.kernel.org/<path>

vs

	master.kernel.org:<path>

because I will use the two interchangably. They *are* the same address,
except:

 - the "git://" protocol is a bit faster, since the ssh connection
   overhead is actually big enough to be quite noticeable.

 - but I often use the master.kernel.org:<path> thing because there's a
   mirroring delay that means that accessing it directly is sometimes
   preferable.

See? THAT is where we need to be consistent: with our own paths!

[ And yes, I literally really do switch things around exactly like that 
  between ssh accesses and the git:// protocol. That was not a made-up 
  example, but real usage! ]

In contrast, nobody has _ever_ given a real technical reason to care about
the Web URL RFC at all.

Really. It's that simple: if you cannot argue for something without
pointing to an irrelevant standard, you really shouldn't argue for it in
the first place.

People who make decisions based on "it's a standard" make *sub*standard
decisions. The fact is, most standards are not worth even using as toilet
paper, because they were designed by some committee that wanted to reach
"consensus". That's just crap.

                        Linus
